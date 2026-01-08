Wait(5000)

-- Track which vending machines are currently in use
local vendingMachineLocks = {}

-- Helper function to check if a vending machine is locked
local function IsVendingMachineLocked(vendingIndex)
    return vendingMachineLocks[vendingIndex] ~= nil
end

-- Helper function to lock a vending machine
local function LockVendingMachine(vendingIndex, playerId)
    vendingMachineLocks[vendingIndex] = playerId
end

-- Helper function to unlock a vending machine
local function UnlockVendingMachine(vendingIndex)
    vendingMachineLocks[vendingIndex] = nil
end

-- Cleanup locks when player disconnects
AddEventHandler('playerDropped', function()
    local src = source
    for vendingIndex, playerId in pairs(vendingMachineLocks) do
        if playerId == src then
            UnlockVendingMachine(vendingIndex)
            Server.Debug("Unlocked vending machine " .. vendingIndex .. " due to player disconnect")
        end
    end
end)

-- [[ BOSS VENDING LOGIC ]]
RegisterNetEvent(Config.ResourceName .. ':server:getVendingStock', function(vendingIndex)
    local src = source
    
    -- Check vending machine status
    MySQL.scalar('SELECT is_open FROM ' .. tablePrefix .. 'vending_machine_status WHERE id = ?', {vendingIndex}, function(isOpen)
        if not isOpen then
            TriggerClientEvent(Config.ResourceName .. ':client:vendingMachineInUse', src)
            return CRUX.Notify(src, { 
                title = "Vending Closed", 
                description = "Vending machine is currently closed.", 
                type = "error" 
            })
        end
        
        -- Check if machine is already in use by another player
        if IsVendingMachineLocked(vendingIndex) then
            local lockingPlayer = vendingMachineLocks[vendingIndex]
            if lockingPlayer ~= src then
                TriggerClientEvent(Config.ResourceName .. ':client:vendingMachineInUse', src)
                return CRUX.Notify(src, { 
                    title = Config.Localess.System.error, 
                    description = Config.Localess.Vending.machine_in_use or "Vending machine is currently in use by another player!", 
                    type = "error" 
                })
            end
        end
        
        -- Lock the machine for this player
        LockVendingMachine(vendingIndex, src)
        
        -- This query correctly gets all possible items that can be added to a machine.
        local query = "SELECT * FROM " .. tablePrefix .. "vendingMachineItems"
        MySQL.query(query, {}, function(stock)
            -- Send stock to client (always assume open)
            TriggerClientEvent(Config.ResourceName .. ':client:receiveVendingStock', src, stock or {})
            -- Don't unlock here - let the client unlock when they close the menu
        end)
    end)
end)

RegisterNetEvent(Config.ResourceName .. ':server:addVendingItem', function(data)
    local src = source
    local itemData = data.item
    local vendingIndex = data.vendingIndex

    if not (itemData and vendingIndex and itemData.name and itemData.quantity and itemData.quantity > 0) then
        return CRUX.Notify(src, { title = Config.Localess.System.error, description = Config.Localess.Vending.invalid_item_data, type = "error" })
    end

    -- 1. Remove item from player inventory
    if not CRUX.Inventory.RemoveItem(src, itemData.name, itemData.quantity) then
        return CRUX.Notify(src, { title = Config.Localess.System.error, description = Config.Localess.Vending.insufficient_item, type = "error" })
    end

    -- 2. Get item price and check business balance BEFORE updating vending stock
    MySQL.scalar("SELECT price FROM " .. tablePrefix .. "vendingMachineItems WHERE name = ?", {itemData.name}, function(price)
        if price then
            local totalMoney = price * itemData.quantity

            -- Check if business has sufficient balance before deducting
            MySQL.scalar('SELECT balance FROM ' .. tablePrefix .. 'bossmenu WHERE id = ?', {Config.JobName}, function(currentBalance)
                if not currentBalance or currentBalance < totalMoney then
                    -- Business is bankrupt - notify and refund item
                    CRUX.Inventory.AddItem(src, itemData.name, itemData.quantity)
                    
                    CRUX.Notify(src, { 
                        title = Config.Localess.System.error, 
                        description = Config.Localess.System.business_funds_insufficient or "The business has insufficient funds to add this item!", 
                        type = "error",
                    })
                    
                    -- Helper: point-in-polygon (ray-casting) for 2D
                    local function PointInPolygon(px, py, polygon)
                        if not polygon or #polygon == 0 then return false end
                        local inside = false
                        local j = #polygon
                        for i = 1, #polygon do
                            local vi = polygon[i]
                            local vj = polygon[j]
                            local xi = vi.x or vi[1]
                            local yi = vi.y or vi[2]
                            local xj = vj.x or vj[1]
                            local yj = vj.y or vj[2]

                            if ((yi > py) ~= (yj > py)) then
                                local intersectX = xi + (py - yi) * (xj - xi) / (yj - yi)
                                if px < intersectX then
                                    inside = not inside
                                end
                            end
                            j = i
                        end
                        return inside
                    end

                    -- Gather bosses and notify only if they are inside cpreset.AreaPolyzone (if enabled)
                    local bosses = {}
                    local jobName = Config.JobName

                    local function IsPlayerBoss(job)
                        if not job then return false end
                        if job.is_boss ~= nil then
                            return job.is_boss
                        end
                        -- fallback to grade lookup if available
                        local gradeLevel = tostring(job.grade or 0)
                        if Config.Grades and Config.Grades[gradeLevel] and Config.Grades[gradeLevel].IsBoss then
                            return true
                        end
                        return false
                    end

                    for _, playerId in ipairs(GetPlayers()) do
                        local pid = tonumber(playerId)
                        if pid then
                            local bossJob = JobSystem.GetJob(pid)
                            if bossJob and bossJob.name == jobName and IsPlayerBoss(bossJob) then
                                local ped = GetPlayerPed(pid)
                                if ped and ped ~= 0 then
                                    local pos = GetEntityCoords(ped)
                                    local px, py, pz = pos.x, pos.y, pos.z

                                    local shouldNotify = true
                                    -- If AreaPolyzone is configured, check if boss is inside it
                                    if cpreset and cpreset.AreaPolyzone and cpreset.AreaPolyzone.enabled then
                                        local poly = cpreset.AreaPolyzone.polyzone
                                        local minZ = cpreset.AreaPolyzone.minZ
                                        local maxZ = cpreset.AreaPolyzone.maxZ

                                        local inPoly = PointInPolygon(px, py, poly)
                                        if not inPoly then
                                            shouldNotify = false
                                        else
                                            if minZ and pz < minZ then shouldNotify = false end
                                            if maxZ and pz > maxZ then shouldNotify = false end
                                        end
                                    end

                                    if shouldNotify then
                                        table.insert(bosses, pid)
                                    end
                                end
                            end
                        end
                    end

                    for _, bossId in ipairs(bosses) do
                        CRUX.Notify(bossId, {
                            title = Config.Localess.BossMenu.bankruptcy_alert or "⚠️ Bankruptcy Alert",
                            description = string.format(Config.Localess.BossMenu.bankruptcy_message or "Your business has insufficient funds! Current balance: $%s, Required: $%s",
                                (currentBalance or 0), totalMoney),
                            type = "error",
                            duration = 10000
                        })
                    end
                    Server.Debug("Vending sale rejected - business bankrupt. Balance: $" .. (currentBalance or 0) .. ", Required: $" .. totalMoney)
                    return
                end

                -- Remove money from business balance
                MySQL.update('UPDATE ' .. tablePrefix .. 'bossmenu SET balance = balance - ? WHERE id = ? AND balance >= ?',
                    {totalMoney, Config.JobName, totalMoney},
                    function(affectedRows)
                        if affectedRows <= 0 then
                            Server.Debug("Error updating business balance for ordering - insufficient funds")
                            -- Refund item if balance update fails
                            CRUX.Inventory.AddItem(src, itemData.name, itemData.quantity)
                            CRUX.Notify(src, { title = Config.Localess.System.error, description = Config.Localess.BossMenu.trans_failed_bossmenubalance, type = "error" })
                        else
                            -- Success: Add item to vending stock
                            local insertQuery = [[
                                INSERT INTO ]] .. tablePrefix .. [[vendingmenuItemsSold (name, label, quantity, image, vending_index)
                                VALUES (?, ?, ?, ?, ?)
                                ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity);
                            ]]
                            MySQL.update(insertQuery, {
                                itemData.name,
                                itemData.label,
                                itemData.quantity,
                                itemData.image,
                                vendingIndex
                            }, function(affectedRows2)
                                if affectedRows2 > 0 then
                                    -- Add money to player
                                    CRUX.Framework.AddMoney(src, 'cash', totalMoney)
                                    CRUX.Notify(src, { title = Config.Localess.System.success, description = string.format(Config.Localess.Vending.item_added_with_money, totalMoney, itemData.quantity, itemData.label), type = "success" })

                                    -- Record transaction
                                    local playerName = CRUX.Framework.GetPlayerName(src)
                                    local playerIdentifier = CRUX.Framework.GetIdentifier(src)
                                    local itemsJson = json.encode({itemData})
                                    local reason = "Vending Item Sold: " .. itemData.quantity .. "x " .. itemData.label

                                    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'transactions (sender_identifier, sender_name, receiver_identifier, receiver_name, amount, reason, payment_method, items, job, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())',
                                        {playerIdentifier, playerName, Config.JobName, Config.JobLabel, totalMoney, reason, 'cash', itemsJson, Config.JobName})

                                    -- Discord Log for Vending Item Added
                                    if Config.DiscordLogging.logEvents.vendingItemAdded then
                                        TriggerEvent('crux_lib:discordLog',
                                            "vendingItemAdded",
                                            "📦 Vending Item Added",
                                            playerIdentifier .. " (" .. playerName .. ") added items to vending stock",
                                            {
                                                {
                                                    ["name"] = "Player",
                                                    ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                                                    ["inline"] = true
                                                },
                                                {
                                                    ["name"] = "Item",
                                                    ["value"] = itemData.quantity .. "x " .. (itemData.label or "") .. " (" .. itemData.name .. ")",
                                                    ["inline"] = true
                                                },
                                                {
                                                    ["name"] = "Vending Machine",
                                                    ["value"] = tostring(vendingIndex),
                                                    ["inline"] = true
                                                }
                                            },
                                            Config.DiscordLogging.color.vending,
                                            Config.DiscordLogging
                                        )
                                    end

                                    -- Trigger animation if enabled
                                    if Config.VendingMachineAnimation and Config.VendingMachineAnimation.enable then
                                        TriggerClientEvent(Config.ResourceName .. ':client:playVendingAnimation', src)
                                    end
                                    
                                    -- Refresh the UI for the player who added the item
                                    TriggerEvent(Config.ResourceName .. ':server:getEmployeeVendingStock', vendingIndex)
                                else
                                    CRUX.Notify(src, { title = Config.Localess.Vending.database_error, description = Config.Localess.Vending.add_item_failed, type = "error" })
                                    -- Give the item back if the DB insert fails
                                    CRUX.Inventory.AddItem(src, itemData.name, itemData.quantity)
                                end
                            end)
                        end
                    end
                )
            end)
        else
            -- No price found, just add to vending stock (legacy/fallback)
            local insertQuery = [[
                INSERT INTO ]] .. tablePrefix .. [[vendingmenuItemsSold (name, label, quantity, image, vending_index)
                VALUES (?, ?, ?, ?, ?)
                ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity);
            ]]
            MySQL.update(insertQuery, {
                itemData.name,
                itemData.label,
                itemData.quantity,
                itemData.image,
                vendingIndex
            }, function(affectedRows)
                if affectedRows > 0 then
                    CRUX.Notify(src, { title = Config.Localess.System.success, description = Config.Localess.Vending.item_added, type = "success" })
                    -- Discord Log for Vending Item Added (no money)
                    if Config.DiscordLogging.logEvents.vendingItemAdded then
                        local playerName = CRUX.Framework.GetPlayerName(src)
                        local playerIdentifier = CRUX.Framework.GetIdentifier(src)
                        TriggerEvent('crux_lib:discordLog',
                            "vendingItemAdded",
                            "📦 Vending Item Added",
                            playerIdentifier .. " (" .. playerName .. ") added items to vending stock",
                            {
                                {
                                    ["name"] = "Player",
                                    ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item",
                                    ["value"] = itemData.quantity .. "x " .. (itemData.label or "") .. " (" .. itemData.name .. ")",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Vending Machine",
                                    ["value"] = tostring(vendingIndex),
                                    ["inline"] = true
                                }
                            },
                            Config.DiscordLogging.color.vending,
                            Config.DiscordLogging
                        )
                    end
                    -- Refresh the UI for the player who added the item
                    TriggerEvent(Config.ResourceName .. ':server:getEmployeeVendingStock', vendingIndex)
                else
                    CRUX.Notify(src, { title = Config.Localess.Vending.database_error, description = Config.Localess.Vending.add_item_failed, type = "error" })
                    -- Give the item back if the DB insert fails
                    CRUX.Inventory.AddItem(src, itemData.name, itemData.quantity)
                end
            end)
        end
    end)
end)

-- [[ EMPLOYEE VENDING LOGIC ]]

RegisterNetEvent(Config.ResourceName .. ':server:getEmployeeVendingStock', function(vendingIndex)
    local src = source

    -- Check if machine is already in use by another player
    if IsVendingMachineLocked(vendingIndex) then
        local lockingPlayer = vendingMachineLocks[vendingIndex]
        if lockingPlayer ~= src then
            TriggerClientEvent(Config.ResourceName .. ':client:vendingMachineInUse', src)
            return CRUX.Notify(src, { 
                title = Config.Localess.System.error, 
                description = Config.Localess.Vending.machine_in_use or "Vending machine is currently in use by another player!", 
                type = "error" 
            })
        end
    end

    -- Lock the machine for this player
    LockVendingMachine(vendingIndex, src)

    -- Query stock (always assume open)
    local query = "SELECT * FROM " .. tablePrefix .. "vendingmenuItemsSold WHERE vending_index = ? AND quantity > 0"
    MySQL.query(query, {vendingIndex}, function(stock)
        TriggerClientEvent(Config.ResourceName .. ':client:receiveEmployeeVendingStock', src, stock or {})
        -- Don't unlock here - let the client unlock when they close the menu
    end)
end)

RegisterNetEvent(Config.ResourceName .. ':server:collectVendingItem', function(data)
    local src = source
    local itemData = data.item
    local vendingIndex = data.vendingIndex
    local collectQuantity = tonumber(data.quantity)

    if not (itemData and vendingIndex and collectQuantity and collectQuantity > 0) then
        return CRUX.Notify(src, { title = Config.Localess.System.error, description = Config.Localess.Vending.invalid_collection_data, type = "error" })
    end

    -- Proceed without checking vending machine status (assume always open)
    -- 1. Check if the machine still has enough stock using the unique ID
    MySQL.scalar("SELECT quantity FROM " .. tablePrefix .. "vendingmenuItemsSold WHERE id = ? AND vending_index = ?", {itemData.id, vendingIndex}, function(currentQuantity)
        if currentQuantity and currentQuantity >= collectQuantity then
            -- 2. Add item to player's inventory
            if not CRUX.Inventory.AddItem(src, itemData.name, collectQuantity) then
                return CRUX.Notify(src, { title = Config.Localess.System.inventory_full, description = Config.Localess.Vending.inventory_full_description, type = "error" })
            end

            -- 3. Update the stock in the database
            local newQuantity = currentQuantity - collectQuantity
            local updateQuery = (newQuantity > 0) 
                and "UPDATE " .. tablePrefix .. "vendingmenuItemsSold SET quantity = ? WHERE id = ?" 
                or "DELETE FROM " .. tablePrefix .. "vendingmenuItemsSold WHERE id = ?"
            
            local queryParams = (newQuantity > 0) and {newQuantity, itemData.id} or {itemData.id}

            MySQL.update(updateQuery, queryParams, function(affectedRows)
                if affectedRows > 0 then
                    CRUX.Notify(src, { title = Config.Localess.System.success, description = string.format(Config.Localess.Vending.item_collected, collectQuantity, itemData.label), type = "success" })
                    -- Discord Log for Vending Item Collected
                    if Config.DiscordLogging.logEvents.vendingItemCollected then
                        local playerName = CRUX.Framework.GetPlayerName(src)
                        local playerIdentifier = CRUX.Framework.GetIdentifier(src)
                        TriggerEvent('crux_lib:discordLog',
                            "vendingItemCollected",
                            "📦 Vending Item Collected",
                            playerIdentifier .. " (" .. playerName .. ") collected items from vending stock",
                            {
                                {
                                    ["name"] = "Player",
                                    ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Item",
                                    ["value"] = collectQuantity .. "x " .. (itemData.label or "") .. " (" .. itemData.name .. ")",
                                    ["inline"] = true
                                },
                                {
                                    ["name"] = "Vending Machine",
                                    ["value"] = tostring(vendingIndex),
                                    ["inline"] = true
                                }
                            },
                            Config.DiscordLogging.color.vending,
                            Config.DiscordLogging
                        )

                    local itemsJson = json.encode({{name = itemData.name, label = itemData.label, quantity = collectQuantity}})
                    local reason = "Vending Item Collected: " .. collectQuantity .. "x " .. itemData.label
                    
                    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'transactions (sender_identifier, sender_name, receiver_identifier, receiver_name, amount, reason, payment_method, items, job, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())',
                        {Config.JobName, Config.JobLabel, playerIdentifier, playerName, 0, reason, 'none', itemsJson, Config.JobName},
                        function(id)
                            if not id then
                                Server.Debug(Config.Localess.Vending.collection_transaction_error)
                            end
                        end
                    )
                    end
                else
                    CRUX.Notify(src, { title = Config.Localess.System.error, description = Config.Localess.Vending.stock_update_failed, type = "error" })
                    CRUX.Inventory.RemoveItem(src, itemData.name, collectQuantity)
                end
            end)
        end
    end)
end)

-- Add new event to unlock vending machine when menu is closed
RegisterNetEvent(Config.ResourceName .. ':server:unlockVendingMachine', function(vendingIndex)
    local src = source
    
    -- Only unlock if this player is the one who locked it
    if vendingMachineLocks[vendingIndex] == src then
        UnlockVendingMachine(vendingIndex)
        Server.Debug("Unlocked vending machine " .. vendingIndex .. " for player " .. src)
    end
end)

-- Add new event to check vending machine status
RegisterNetEvent(Config.ResourceName .. ':server:checkVendingStatus', function(vendingIndex)
    local src = source
    MySQL.scalar('SELECT is_open FROM ' .. tablePrefix .. 'vending_machine_status WHERE id = ?', {vendingIndex}, function(isOpen)
        if isOpen == nil then
            -- Insert default open status if no row exists
            MySQL.insert('INSERT INTO ' .. tablePrefix .. 'vending_machine_status (id, is_open) VALUES (?, TRUE)', {vendingIndex}, function(insertId)
                TriggerClientEvent(Config.ResourceName .. ':client:vendingStatusChecked', src, true)
            end)
        else
            TriggerClientEvent(Config.ResourceName .. ':client:vendingStatusChecked', src, isOpen)
        end
    end)
end)

-- Add new event to toggle vending machine status
RegisterNetEvent(Config.ResourceName .. ':server:toggleVendingMachineStatus', function(data)
    local isOpen = data.isOpen
    MySQL.update('UPDATE ' .. tablePrefix .. 'vending_machine_status SET is_open = ? WHERE id = 1', {isOpen}, function(affectedRows)
        if affectedRows > 0 then
            -- Notify all clients of the update
            TriggerClientEvent(Config.ResourceName .. ':client:updateVendingMachineStatus', -1, isOpen)
        end
    end)
end)

-- sv_vending.lua

RegisterNetEvent(Config.ResourceName .. ':server:getVendingMachineStatus', function()
    local src = source
    -- We specifically look for ID 1 as the "Master" switch for the boss menu
    MySQL.scalar('SELECT is_open FROM ' .. tablePrefix .. 'vending_machine_status WHERE id = 1', function(result)
        local status = true -- Default to true if row doesn't exist

        -- [FIX] Explicitly check for nil, so we don't accidentally overwrite 'false'
        if result ~= nil then
            -- If DB returns 0 (tinyint) or false, we strictly set false
            if result == 0 or result == false then
                status = false
            else
                status = true
            end
        else
            -- If row 1 doesn't exist, create it so it works next time
            MySQL.insert('INSERT INTO ' .. tablePrefix .. 'vending_machine_status (id, is_open) VALUES (1, 1)')
        end

        -- Send the CORRECT status variable, do not use "or true" here
        TriggerClientEvent(Config.ResourceName .. ':client:receiveVendingMachineStatus', src, {isOpen = status})
    end)
end)