Wait(5000)

-- Shop purchase handler

-- Add shop status variable
local shopOpen = true -- Default to open

-- Handle item purchase requests
RegisterNetEvent(Config.ResourceName .. ':server:purchaseItems')
AddEventHandler(Config.ResourceName .. ':server:purchaseItems', function(data)
    local src = source
    local player = CRUX.Framework.GetPlayer(src)

    if not player then
        TriggerClientEvent(Config.ResourceName .. ':client:purchaseResponse', src, {
            success = false,
            description = Config.Localess.Shop.player_not_found
        })
        return
    end

    -- Validate data
    if not data or not data.items or not data.total or data.total <= 0 then
        TriggerClientEvent(Config.ResourceName .. ':client:purchaseResponse', src, {
            success = false,
            description = Config.Localess.Shop.invalid_purchase_data
        })
        return
    end

    local total = tonumber(data.total)
    local method = string.lower(data.method or "cash")

    -- Check if player has enough money
    local hasEnoughMoney = false
    if method == "cash" then
        hasEnoughMoney = CRUX.Framework.GetMoney(src, 'cash') >= total
    elseif method == "bank" then
        hasEnoughMoney = CRUX.Framework.GetMoney(src, 'bank') >= total
    end

    if not hasEnoughMoney then
        CRUX.Notify(src,{
            title = Config.Localess.Shop.purchase_title,
            description = string.format(Config.Localess.Billing.insufficient_funds, method),
            type = "error",
            duration = 5000,
        })
        -- Log transaction failure - insufficient funds
        TriggerEvent('crux_lib:discordLog',
            "transactionFailure",
            "❌ Purchase Failed - Insufficient Funds",
            CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ") attempted to make a purchase",
            {
                {
                    ["name"] = "Player",
                    ["value"] = CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Total Amount",
                    ["value"] = "$" .. total,
                    ["inline"] = true
                },
                {
                    ["name"] = "Payment Method",
                    ["value"] = method,
                    ["inline"] = true
                },
                {
                    ["name"] = "Failure Reason",
                    ["value"] = "Not enough funds in " .. method,
                    ["inline"] = false
                }
            },
            Config.DiscordLogging.color.transaction,
            Config.DiscordLogging
        )
        return 
    end

    -- Check if shop is open
    if not shopOpen then
        TriggerClientEvent(Config.ResourceName .. ':client:purchaseResponse', src, {
            success = false,
            description = "The shop is currently closed."
        })
        return
    end

    -- Process items first to ensure inventory capacity
    local itemsAdded = true
    local addedItems = {}

    for _, item in ipairs(data.items) do
        -- Check if player can add the item before attempting
        if not CRUX.Inventory.CanAddItem(src, item.name, item.quantity) then
            itemsAdded = false
            
            -- Log transaction failure - weight limit
            TriggerEvent('crux_lib:discordLog',
                "transactionFailure",
                "❌ Purchase Failed - Weight Limit",
                CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ") attempted to make a purchase",
                {
                    {
                        ["name"] = "Player",
                        ["value"] = CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Total Amount",
                        ["value"] = "$" .. total,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Payment Method",
                        ["value"] = method,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Item",
                        ["value"] = item.quantity .. "x " .. item.name,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Failure Reason",
                        ["value"] = "Inventory weight limit exceeded",
                        ["inline"] = false
                    }
                },
                Config.DiscordLogging.color.transaction,
                src
            )
            
            break
        end
        
        -- Add items to player inventory
        local success = CRUX.Inventory.AddItem(src, item.name, item.quantity)
        if not success then
            itemsAdded = false
            break
        else
            table.insert(addedItems, {name = item.name, quantity = item.quantity})
        end
    end

    -- If any items failed to add, don't proceed with payment
    if not itemsAdded then
        -- Roll back any items that were added
        for _, item in ipairs(addedItems) do
            CRUX.Inventory.RemoveItem(src, item.name, item.quantity)
        end

        -- Log transaction failure - inventory space or weight
        TriggerEvent('crux_lib:discordLog',
            "transactionFailure",
            "❌ Purchase Failed - Inventory Issue",
            CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ") attempted to make a purchase",
            {
                {
                    ["name"] = "Player",
                    ["value"] = CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Total Amount",
                    ["value"] = "$" .. total,
                    ["inline"] = true
                },
                {
                    ["name"] = "Payment Method",
                    ["value"] = method,
                    ["inline"] = true
                },
                {
                    ["name"] = "Failure Reason",
                    ["value"] = "Not enough inventory space or weight limit exceeded",
                    ["inline"] = false
                }
            },
            Config.DiscordLogging.color.transaction,
            src
        )

        TriggerClientEvent(Config.ResourceName .. ':client:purchaseResponse', src, {
            success = false,
            description = Config.Localess.Shop.inventory_full
        })
        return
    end

    -- Remove money from player
    if method == "cash" then
        CRUX.Framework.RemoveMoney(src, 'cash', total)
        
        if CRUX.Society and CRUX.Society.AddTransaction then
            CRUX.Society.AddTransaction(
                Config.JobName,
                Config.JobName,
                CRUX.Framework.GetPlayerName(src),
                CRUX.Framework.GetIdentifier(src),
                total,
                "Invoice Payment",
                src
            )
        end
        Server.Debug("Invoice Transaction Data:")
        Server.Debug("receiver_name:", Config.JobName)
        Server.Debug("receiver_identifier:", CRUX.Framework.GetIdentifier(src))
        Server.Debug("sender_name:", CRUX.Framework.GetPlayerName(src))
        Server.Debug("sender_identifier:", CRUX.Framework.GetIdentifier(src))
        Server.Debug("value:", total)
        Server.Debug("reason:", "Invoice Payment")
        Server.Debug("targetId:", src)
    else
        CRUX.Framework.RemoveMoney(src, 'bank', total)
        
        if CRUX.Society and CRUX.Society.AddTransaction then
            CRUX.Society.AddTransaction(
                Config.JobName,
                Config.JobName,
                CRUX.Framework.GetPlayerName(src),
                CRUX.Framework.GetIdentifier(src),
                total,
                "Invoice Payment",
                src
            )
        end
        Server.Debug("Invoice Transaction Data:")
        Server.Debug("receiver_name:", Config.JobName)
        Server.Debug("receiver_identifier:", CRUX.Framework.GetIdentifier(src))
        Server.Debug("sender_name:", CRUX.Framework.GetPlayerName(src))
        Server.Debug("sender_identifier:", CRUX.Framework.GetIdentifier(src))
        Server.Debug("value:", total)
        Server.Debug("reason:", "Invoice Payment")
        Server.Debug("targetId:", src)
    end

    -- Update business account if business exists
    if Config.JobName then
        MySQL.update('UPDATE ' .. tablePrefix .. 'bossmenu SET balance = balance + ? WHERE id = ?',
            {total, Config.JobName},
            function(rowsChanged)
                -- Safely obtain format strings, with sensible defaults to avoid nil errors
                local errFmt = (Config.Localess and Config.Localess.Shop and Config.Localess.Shop.business_balance_error) or "Business balance update failed for %s"
                local succFmt = (Config.Localess and Config.Localess.Shop and Config.Localess.Shop.business_balance_success) or "Business balance updated by $%s"

                if rowsChanged <= 0 then
                    Server.Debug(string.format(errFmt, tostring(Config.JobName)))
                else
                    Server.Debug(string.format(succFmt, tostring(total)))
                end
            end
        )
    end

    -- Record transaction
    local playerName = CRUX.Framework.GetPlayerName(src)
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)
    local itemsJson = json.encode(data.items)

    -- Create a readable reason with item names
    local itemSummary = ""
    if #data.items <= 3 then
        for i, item in ipairs(data.items) do
            if i > 1 then itemSummary = itemSummary .. ", " end
            itemSummary = itemSummary .. item.quantity .. "x " .. (item.label or item.name)
        end
    else
        for i = 1, 3 do
            if i > 1 then itemSummary = itemSummary .. ", " end
            itemSummary = itemSummary .. data.items[i].quantity .. "x " .. (data.items[i].label or data.items[i].name)
        end
        itemSummary = itemSummary .. " +" .. (#data.items - 3) .. " more"
    end

    -- Log successful transaction
    TriggerEvent('crux_lib:discordLog',
        "transactionComplete",
        "✅ Purchase Successful",
        CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ") made a purchase",
        {
            {
                ["name"] = "Player",
                ["value"] = CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Total Amount",
                ["value"] = "$" .. total,
                ["inline"] = true
            },
            {
                ["name"] = "Payment Method",
                ["value"] = method,
                ["inline"] = true
            },
            {
                ["name"] = "Items Purchased",
                ["value"] = itemSummary,
                ["inline"] = false
            }
        },
        Config.DiscordLogging.color.transaction,
        src
    )

    local reasonFormat = "Shop purchase: %s"
    local reason = string.format(reasonFormat, tostring(itemSummary))

    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'transactions (sender_identifier, sender_name, receiver_identifier, receiver_name, amount, reason, payment_method, items, job, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())',
        {playerIdentifier, playerName, Config.JobName, Config.JobLabel, total, reason, method, itemsJson, Config.JobName},
        function(id)
            if not id then
                Server.Debug(Config.Localess.Shop.transaction_record_error)
            else
                -- Notify all online managers about the purchase
                TriggerEvent(Config.ResourceName .. ':server:notifyShopTransaction', {
                    id = id,
                    sender_name = playerName,
                    amount = total,
                    items = data.items,
                    payment_method = method
                })
            end
        end
    )

    -- Send success response
    TriggerClientEvent(Config.ResourceName .. ':client:purchaseResponse', src, {
        success = true,
        description = Config.Localess.Shop.purchase_complete
    })

    -- Trigger buy animation on client if enabled
    if Config.Shop.animationBuy and Config.Shop.animationBuy.enable then
        TriggerClientEvent(Config.ResourceName .. ':client:playBuyAnimation', src)
    end
end)

-- New event to notify managers about shop transactions
RegisterNetEvent(Config.ResourceName .. ':server:notifyShopTransaction')
AddEventHandler(Config.ResourceName .. ':server:notifyShopTransaction', function(transactionData)
    -- Get all online players
    local players = GetPlayers()

    for _, playerId in ipairs(players) do
        local src = tonumber(playerId)
        if src then
            -- Check if player is a manager of this job
            local playerJob = JobSystem.GetJob(src)

            if playerJob and playerJob.name == Config.JobName then
                -- Check if player has manager access
                local gradeLevel = tostring(playerJob.grade)
                local gradeInfo = Config.Grades[gradeLevel]

                if gradeInfo and gradeInfo.IsBoss then
                    -- Send NUI message about new transaction to manager
                    TriggerClientEvent(Config.ResourceName .. ':client:newShopTransaction', src, transactionData)
                end
            end
        end
    end
end)

-- Add event to get player avatar for shop menu
-- RegisterNetEvent(Config.ResourceName .. ':server:getPlayerAvatar')
-- AddEventHandler(Config.ResourceName .. ':server:getPlayerAvatar', function()
--     local src = source
--     local playerIdentifier = CRUX.Framework.GetIdentifier(src)

--     -- Query for avatar from employee table
--     MySQL.query('SELECT image FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ? LIMIT 1',
--         {playerIdentifier, Config.JobName},
--         function(result)
--             local avatarUrl = "/placeholder.svg?height=40&width=40" -- Default

--             if result and #result > 0 and result[1].image then
--                 avatarUrl = result[1].image
--                 Server.Debug(string.format(Config.Localess.Shop.avatar_found, CRUX.Framework.GetPlayerName(src), avatarUrl))
--             else
--                 Server.Debug(Config.Localess.Shop.avatar_not_found)
--             end

--             -- Send the avatar URL to the client
--             TriggerClientEvent(Config.ResourceName .. ':client:receivePlayerAvatar', src, avatarUrl)
--         end
--     )
-- end)

-- Add event to toggle shop status
RegisterNetEvent(Config.ResourceName .. ':server:toggleShopStatus')
AddEventHandler(Config.ResourceName .. ':server:toggleShopStatus', function()
    local src = source
    local playerJob = JobSystem.GetJob(src)
    
    if playerJob and playerJob.name == Config.JobName then
        local gradeLevel = tostring(playerJob.grade)
        local gradeInfo = Config.Grades[gradeLevel]
        
        if gradeInfo and gradeInfo.IsBoss then
            shopOpen = not shopOpen
            -- Notify all clients of status change
            TriggerClientEvent(Config.ResourceName .. ':client:shopStatusChanged', -1, shopOpen)
        end
    end
end)
