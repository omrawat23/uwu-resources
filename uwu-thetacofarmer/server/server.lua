Server = {}
Server.DebugServer = false
Config.Localess = Locales[Config.Locales]

cPreset = Preset[Config.ActivePreset]

tablePrefix = "crux_uwucafe_cafess_"

Server.Debug = function(msg)
   if Server.DebugServer then
        if type(msg) == "function" then
            msg()
        else
            print(msg)
        end
    end
end

CRUX.Inventory.RegisterStash({
    id = Config.ResourceName .. Config.BossMenuInventoryStorage.label,
    label = Config.BossMenuInventoryStorage.label,
    slots = Config.BossMenuInventoryStorage.slots or 50, -- Default to 50 slots if not specified
    maxWeight = Config.BossMenuInventoryStorage.weight or 100000, -- Default to 100000 weight if not specified
})

for i, v in pairs(cPreset.trays) do
    local safeLabel = (v.targetlabel or ""):gsub("%s+", "_")
    CRUX.Inventory.RegisterStash({
        id = Config.ResourceName .. safeLabel .. '-' .. i,
        label = safeLabel .. ' - ' .. i,
        slots = v.slots,
        maxWeight = v.weight
    })
end

for i, v in pairs(cPreset.table) do
    local safeLabel = (v.targetlabel or ""):gsub("%s+", "_")
    CRUX.Inventory.RegisterStash({
        id = Config.ResourceName .. safeLabel .. '-' .. i,
        label = safeLabel .. ' - ' .. i,
        slots = v.slots,
        maxWeight = v.weight
    })
end

for i, v in pairs(cPreset.stashs) do
    local safeLabel = (v.targetlabel or ""):gsub("%s+", "_")
    CRUX.Inventory.RegisterStash({
        id = Config.ResourceName .. safeLabel .. '-' .. i,
        label = safeLabel .. ' - ' .. i,
        slots = v.slots,
        maxWeight = v.weight
    })
end

for i, v in pairs(cPreset.fridges) do
    local safeLabel = (v.targetlabel or ""):gsub("%s+", "_")

    CRUX.Inventory.RegisterStash({
        id = Config.ResourceName .. safeLabel .. '-' .. i,
        label = safeLabel .. ' - ' .. i,
        slots = v.slots,
        maxWeight = v.weight
    })
end


-- Helper function to generate UUID
function generateUUID()
    local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

-- Helper function to get player identifier
local function getPlayerIdentifier(source)
    local player = CRUX.Framework.GetPlayerCitizenId(source)
    return player
end

-- Helper function to save stash items to database
local function saveStashItems(stashId, items)
    local itemsJson = json.encode(items or {})
    MySQL.Async.execute('UPDATE ' .. tablePrefix .. 'storage_boxes SET items = @items, last_accessed = NOW() WHERE stash_id = @stash_id', {
        ['@items'] = itemsJson,
        ['@stash_id'] = stashId
    }, function(affectedRows)
        if affectedRows > 0 then
            Server.Debug("^2Saved " .. #(items or {}) .. " items to stash: " .. stashId .. "^0")
        end
    end)
end

-- Helper function to load stash items from database
local function loadStashItems(stashId)
    local result = MySQL.Sync.fetchAll('SELECT items FROM ' .. tablePrefix .. 'storage_boxes WHERE stash_id = @stash_id', {
        ['@stash_id'] = stashId
    })
    
    if result and result[1] and result[1].items then
        local items = json.decode(result[1].items)
        Server.Debug("^2Loaded " .. #(items or {}) .. " items from stash: " .. stashId .. "^0")
        return items or {}
    end
    
    return {}
end

-- Add global counter for sequential stash labels
stashLabelCounter = 0

-- Helper function to get or create stash ID for an item
function getOrCreateStashId(itemId, ownerIdentifier)
    -- First, try to get existing stash ID from database
    local result = MySQL.Sync.fetchAll('SELECT stash_id, items FROM ' .. tablePrefix .. 'storage_boxes WHERE item_id = @item_id', {
        ['@item_id'] = itemId
    })
    
    if result and result[1] then
        -- Update last accessed time
        MySQL.Async.execute('UPDATE ' .. tablePrefix .. 'storage_boxes SET last_accessed = NOW() WHERE item_id = @item_id', {
            ['@item_id'] = itemId
        })
        
        local stashId = result[1].stash_id
        Server.Debug("Found existing stash: " .. stashId)
        
        return stashId
    else
        -- Increment label counter for new stashes
        stashLabelCounter = stashLabelCounter + 1
        
        -- Generate new UUID-based stash ID
        local stashId = Config.StorageBox.id .. "_" .. generateUUID()
        
        -- Insert into storage_boxes table with empty items array
        MySQL.Async.execute('INSERT INTO ' .. tablePrefix .. 'storage_boxes (item_id, stash_id, owner_identifier, items) VALUES (@item_id, @stash_id, @owner_identifier, @items)', {
            ['@item_id'] = itemId,
            ['@stash_id'] = stashId,
            ['@owner_identifier'] = ownerIdentifier,
            ['@items'] = json.encode({})
        })
        
        Server.Debug("^2Created new storage box with stash ID: " .. stashId .. "^0")
        
        return stashId
    end
end

-- Custom stash implementation that saves to our single table
local stashInventories = {}

-- Hook into inventory save events to persist to database
-- This depends on your inventory system - adjust accordingly
AddEventHandler('CRUX:Inventory:StashUpdated', function(stashId, items)
    -- Check if this is one of our storage box stashes
    if string.find(stashId, Config.StorageBox.id .. "_") then
        stashInventories[stashId] = items
        saveStashItems(stashId, items)
    end
end)

-- Alternative: If no event exists, periodically save stashes
CreateThread(function()
    while true do
        Wait(60000) -- Save every 60 seconds
        
        for stashId, items in pairs(stashInventories) do
            if string.find(stashId, Config.StorageBox.id .. "_") then
                saveStashItems(stashId, items)
            end
        end
    end
end)

-- Register the storage box defined in Config.StorageBox
if Config.StorageBox and Config.StorageBox.enabled then
    CRUX.Inventory.CreateUseableItem(Config.StorageBox.item, function(source, item)
        -- Check if this specific item already has a unique ID
        local itemUniqueId = item.info?.uniqueId
        
        if not itemUniqueId then
            -- Generate unique ID for this item (whether stacked or not)
            itemUniqueId = generateUUID()
            
            -- Set the unique ID in the item's metadata
            local currentInfo = item.info or {}
            currentInfo.uniqueId = itemUniqueId
            
            local success = CRUX.Inventory.SetItemMetadata(source, item.slot, currentInfo)
            
            -- if not success then
            --     Server.Debug("^1Failed to set metadata for item in slot " .. item.slot .. "^0")
            --     CRUX.Notify(source, {
            --         title = Config.Localess.System.error or "Error",
            --         description = "Failed to assign unique ID to storage box.",
            --         type = "error",
            --         duration = 3000,
            --     })
            --     return
            -- end
            
            Server.Debug("^2Successfully assigned unique ID: " .. itemUniqueId .. "^0")
        else
            Server.Debug("Storage box already has unique ID: " .. itemUniqueId)
        end
        
        -- Get player identifier
        local playerIdentifier = getPlayerIdentifier(source)
        
        -- Get or create stash ID from database
        local stashId = getOrCreateStashId(itemUniqueId, playerIdentifier)
        local stashLabel = Config.StorageBox.label .. " #" .. tostring(stashLabelCounter)
        
        Server.Debug("Opening stash: " .. stashId .. " for player: " .. playerIdentifier)
        
        -- Register the unique stash dynamically
        if not CRUX.Inventory.GetStash(stashId) then
            CRUX.Inventory.RegisterStash({
                id = stashId,
                label = stashLabel,
                slots = Config.StorageBox.slots,
                maxWeight = Config.StorageBox.weight
            })
            Server.Debug("^2Registered new stash: " .. stashId .. "^0")
        end

        -- If using standard CRUX.Inventory.OpenStash
        TriggerClientEvent(Config.ResourceName .. ":lib:client:OpenDeliveryStash", source, stashId)
    end)
end

-- Save stash when player closes it
RegisterNetEvent(Config.ResourceName .. ':server:CloseStash', function(stashId)
    local source = source
    
    -- Check if this is one of our storage box stashes
    if string.find(stashId, Config.StorageBox.id .. "_") then
        -- Get current stash contents from inventory system
        local items = CRUX.Inventory.GetStashItems(stashId)
        
        if items then
            stashInventories[stashId] = items
            saveStashItems(stashId, items)
            Server.Debug("^2Saved stash on close: " .. stashId .. "^0")
        end
    end
end)

for i, v in pairs(cPreset.dustbin) do
    local safeLabel = (v.targetlabel or ""):gsub("%s+", "_")
    CRUX.Inventory.RegisterStash({
        id = Config.ResourceName .. safeLabel .. '-' .. i,
        label = safeLabel .. ' - ' .. i,
        slots = v.slots,
        maxWeight = v.weight,
        delete = {
            enabled = true,
        }
    })
end

-- Handle Ice Collection
RegisterNetEvent(":lib:server:HandleIce", function(data)
    local source = source
    Server.Debug("Ice event triggered by: " .. source)
    
    -- Check if player can carry the item before adding
    local canCarry = CRUX.Inventory.CanAddItem(source, data.addItem, data.addItemCount)
    
    if canCarry then
        local success = CRUX.Inventory.AddItem(source, data.addItem, data.addItemCount)
        if success then
            CRUX.Notify(source, {
                title = Config.Localess.System.success,
                description = Config.Localess.System.ice_collected,
                type = "success",
                duration = 3000,
            })
        else
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.System.ice_error,
                type = "error",
                duration = 3000,
            })
        end
    else
        CRUX.Notify(source, {
            title = Config.Localess.System.error,
            description = Config.Localess.System.inventory_full,
            type = "error",
            duration = 3000,
        })
    end
end)

-- Function to trigger the use of a consumable item on the client
function useConsumable(source, item)
    Server.Debug("Using consumable item: " .. item.name)
    if not item.name then item = {name = item, label = item} end
    local itemConfig = Config.Food[item.name] or Config.Drinks[item.name] or Config.Alcohol[item.name]
    local isDrink = Config.Drinks[item.name] ~= nil or Config.Alcohol[item.name] ~= nil
    TriggerClientEvent(Config.ResourceName .. 'lib:client:useConsumable', source, item, isDrink, itemConfig)
end

for value, _ in pairs(Config.Food) do
    CRUX.Inventory.CreateUseableItem(value, useConsumable)
end

for value, _ in pairs(Config.Drinks) do
    CRUX.Inventory.CreateUseableItem(value, useConsumable)
end

for value, _ in pairs(Config.Alcohol) do
    CRUX.Inventory.CreateUseableItem(value, function(source, item)
        useConsumable(source, item)
    end)
end

-- Helper function to safely update player metadata (hunger, thirst, etc.)
function updateMetadata(metadata, value)
    -- Initialize metadata to 0 if it's nil
    metadata = metadata or 0
    local res = metadata + value  -- Addition works for both positive and negative values
    if res < 0 then res = 0 end
    if res > 100 then res = 100 end
    return res
end

-- Server-side logic for using a consumable item
RegisterNetEvent(Config.ResourceName .. ':server:useConsumable', function (item, isDrink)
    local source = source
    if CRUX.Inventory.CountItem(source, item) > 0 then
        -- Fix: Properly determine itemConfig based on isDrink to avoid nil for food items
        local itemConfig
        if isDrink then
            itemConfig = Config.Drinks[item] or Config.Alcohol[item]
        else
            itemConfig = Config.Food[item]
        end
        
        if not itemConfig then return end

        -- Handle item removal
        if itemConfig.Remove then
            -- For backwards compatibility
            if itemConfig.RemoveItem and itemConfig.RemoveItemCount then
                CRUX.Inventory.RemoveItem(source, itemConfig.RemoveItem or item, itemConfig.RemoveItemCount)
            -- For new multi-item format
            elseif itemConfig.RemoveItems and type(itemConfig.RemoveItems) == "table" then
                for _, removeData in ipairs(itemConfig.RemoveItems) do
                    if removeData.item and removeData.count then
                        CRUX.Inventory.RemoveItem(source, removeData.item, removeData.count)
                    end
                end
            else
                -- Default fallback - remove the item itself
                CRUX.Inventory.RemoveItem(source, item, 1)
            end
        else
            -- Default fallback - remove the item itself
            CRUX.Inventory.RemoveItem(source, item, 1)
        end

        -- Handle items with new multi-item format (additions)
        if itemConfig.Add then
            -- For backwards compatibility
            if itemConfig.AddItem and itemConfig.AddItemCount then
                if CRUX.Inventory.CanAddItem(source, itemConfig.AddItem, itemConfig.AddItemCount) then
                    CRUX.Inventory.AddItem(source, itemConfig.AddItem, itemConfig.AddItemCount)
                else
                    CRUX.Notify(source, {
                        title = Config.Localess.System.error,
                        description = Config.Localess.System.inventory_full,
                        type = "error",
                        duration = 3000,
                    })
                    return
                end
            -- For new multi-item format
            elseif itemConfig.AddItems and type(itemConfig.AddItems) == "table" then
                local canAddAll = true
                -- First check if all items can be added
                for _, addData in ipairs(itemConfig.AddItems) do
                    if addData.item and addData.count then
                        if not CRUX.Inventory.CanAddItem(source, addData.item, addData.count) then
                            canAddAll = false
                            break
                        end
                    end
                end
                
                -- If all items can be added, proceed with adding them
                if canAddAll then
                    for _, addData in ipairs(itemConfig.AddItems) do
                        if addData.item and addData.count then
                            CRUX.Inventory.AddItem(source, addData.item, addData.count)
                        end
                    end
                else
                    CRUX.Notify(source, {
                        title = Config.Localess.System.error,
                        description = Config.Localess.System.inventory_full,
                        type = "error",
                        duration = 3000,
                    })
                    return
                end
            end
        end

        local thirst = CRUX.Framework.GetMetaData(source, 'thirst')
        local hunger = CRUX.Framework.GetMetaData(source, 'hunger')
        local stress = CRUX.Framework.GetMetaData(source, 'stress')

        if thirst == nil then
            CRUX.Framework.SetMetaData(source, 'thirst', 0)
        end
        if hunger == nil then
            CRUX.Framework.SetMetaData(source, 'hunger', 0)
        end
        if stress == nil then
            CRUX.Framework.SetMetaData(source, 'stress', 0)
        end

        local tm = updateMetadata(thirst, itemConfig.Thirst or 0)
        local hm = updateMetadata(hunger, itemConfig.Hunger or 0)
        local sm = updateMetadata(stress, itemConfig.Stress or 0)

        CRUX.Framework.SetMetaData(source, 'thirst', tm)
        CRUX.Framework.SetMetaData(source, 'hunger', hm)
        CRUX.Framework.SetMetaData(source, 'stress', sm)

        -- Update all HUD needs together
        TriggerClientEvent('hud:client:UpdateNeeds', source, hm, tm)

        if itemConfig.Stress then
            TriggerClientEvent('hud:client:UpdateStress', source, sm)
        end

        -- Notify player
        if itemConfig.Log then
            CRUX.Notify(source, {
                title = Config.Localess.Consumption.title,
                description = Config.Localess.Consumption.description,
                type = "success",
                duration = 3000,
            })
        -- Add drink-specific notification only if there's no custom log
        elseif isDrink then
            CRUX.Notify(source, {
                title = Config.Localess.Consumption.refresh_title,
                description = Config.Localess.Consumption.refresh_description,
                type = "success",
                duration = 3000,
            })
        end
    end
end)

-- =================================================================================================
-- UPDATED CRAFTING LOGIC
-- =================================================================================================

-- [UPDATED] This event is called first by the client to check for materials.
RegisterNetEvent(Config.ResourceName .. ":Server:RequestCraft", function(Args)
    local source = source
    local Costs = Args.Costs
    local amountToCraft = Args.Amount
    local itemLabel = Args.ItemLabel

    -- Security check for a valid amount
    if not amountToCraft or type(amountToCraft) ~= "number" or amountToCraft <= 0 then
        return
    end

    local hasItems = true
    for item, requiredAmount in pairs(Costs) do
        local totalRequired = requiredAmount * amountToCraft
        if CRUX.Inventory.CountItem(source, item) < totalRequired then
            hasItems = false
            break
        end
    end

    if hasItems then
        -- Player has the items, tell the client to start the progress bar.
        TriggerClientEvent(Config.ResourceName .. ":Client:StartCraftingProcess", source, Args)
    else
        -- Player is missing items.
        CRUX.Notify(source, {
            title = Config.Localess.System.error,
            description = Config.Localess.System.missing_items,
            type = "error",
            duration = 3000,
        })

        -- Discord Log for Crafting Failure
        local playerName = CRUX.Framework.GetPlayerName(source)
        local playerIdentifier = CRUX.Framework.GetIdentifier(source)

        TriggerEvent('crux_lib:discordLog',
            "craftingFailure",
            "❌ Crafting Failed",
            playerIdentifier .. " (" .. playerName .. ") failed to craft",
            {
                {
                    ["name"] = "Player",
                    ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Item",
                    ["value"] = amountToCraft .. "x " .. Args.Item .. " (" .. (itemLabel or "") .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Reason",
                    ["value"] = "Item does not exist in inventory",
                    ["inline"] = true
                }
            },
            Config.DiscordLogging.color.crafting,
            Config.DiscordLogging
        )

        -- ADD THIS LINE
        TriggerClientEvent(Config.ResourceName .. ":Client:ResetCraftingState", source)
    end
end)

-- [UPDATED] This is the final transaction event, called by the client AFTER the progress bar.
RegisterNetEvent(Config.ResourceName .. ":Server:FinalizeCraft", function(Args)
    local source = source
    local Item = Args.Item
    local Costs = Args.Costs
    local amountToCraft = Args.Amount
    local itemLabel = Args.Label

    -- Security check for a valid amount
    if not amountToCraft or type(amountToCraft) ~= "number" or amountToCraft <= 0 then
        return
    end

    local HasItems = true

    -- Re-verify items as a security measure.
    for ItemC, Amount in pairs(Costs) do
        local totalRequired = Amount * amountToCraft
        if CRUX.Inventory.CountItem(source, ItemC) < totalRequired then
            HasItems = false
            break
        end
    end

    if HasItems then
        -- Check if player can carry the crafted items
        if not CRUX.Inventory.CanAddItem(source, Item, amountToCraft) then
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.System.inventory_full,
                type = "error",
                duration = 3000,
            })
            
            -- Discord Log for Crafting Failure due to inventory weight
            local playerName = GetPlayerName(source)
            local playerIdentifier = CRUX.Framework.GetIdentifier(source)

            TriggerEvent('crux_lib:discordLog',
                "craftingFailure",
                "❌ Crafting Failed",
                playerIdentifier .. " (" .. playerName .. ") failed to craft due to inventory weight",
                {
                    {
                        ["name"] = "Player",
                        ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Item",
                        ["value"] = amountToCraft .. "x " .. Item,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Reason",
                        ["value"] = "Insufficient inventory space (weight)",
                        ["inline"] = true
                    }
                },
                Config.DiscordLogging.color.crafting,
                Config.DiscordLogging
            )
            
            return
        end
        
        -- All items are present, so remove them
        for ItemC, Amount in pairs(Costs) do
            local totalToRemove = Amount * amountToCraft
            CRUX.Inventory.RemoveItem(source, ItemC, totalToRemove)
        end

        -- Add the crafted items
        local success, itemData = CRUX.Inventory.AddItem(source, Item, amountToCraft)

        if not success then
            -- IMPORTANT: Give ingredients back if there's no space
            for ItemC, Amount in pairs(Costs) do
                local totalToReturn = Amount * amountToCraft
                CRUX.Inventory.AddItem(source, ItemC, totalToReturn)
            end
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.Crafting.no_space,
                type = "error",
                duration = 3000,
            })

            -- Discord Log for Crafting Failure
            local playerName = GetPlayerName(source)
            local playerIdentifier = CRUX.Framework.GetIdentifier(source)

            TriggerEvent('crux_lib:discordLog',
                "craftingFailure",
                "❌ Crafting Failed",
                playerIdentifier .. " (" .. playerName .. ") failed to craft due to inventory space",
                {
                    {
                        ["name"] = "Player",
                        ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Item",
                        ["value"] = amountToCraft .. "x " .. Item,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Reason",
                        ["value"] = "Insufficient inventory space",
                        ["inline"] = true
                    }
                },
                Config.DiscordLogging.color.crafting,
                Config.DiscordLogging
            )
        else
            -- Discord Log for Crafting Success
            local playerName = GetPlayerName(source)
            local playerIdentifier = CRUX.Framework.GetIdentifier(source)
            local ingredientsList = {}

            for ItemC, Amount in pairs(Costs) do
                local totalUsed = Amount * amountToCraft
                table.insert(ingredientsList, totalUsed .. "x " .. ItemC)
            end

            TriggerEvent('crux_lib:discordLog',
                "craftingSuccess",
                "🔨 Crafting Successful",
                playerIdentifier .. " (" .. playerName .. ") successfully crafted items",
                {
                    {
                        ["name"] = "Player",
                        ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Crafted Item",
                        ["value"] = amountToCraft .. "x " .. Item .. " (" .. (itemLabel or "") .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Ingredients Used",
                        ["value"] = table.concat(ingredientsList, "\n"),
                        ["inline"] = false
                    }
                },
                Config.DiscordLogging.color.crafting,
                Config.DiscordLogging
            )
        end
    else
        -- This happens if items were dropped/used during the crafting process.
        CRUX.Notify(source, {
            title = Config.Localess.System.error,
            description = Config.Localess.System.missing_items,
            type = "error",
            duration = 3000,
        })

        -- Discord Log for Crafting Failure - Missing Items
        local playerName = GetPlayerName(source)
        local playerIdentifier = CRUX.Framework.GetIdentifier(source)

        TriggerEvent('crux_lib:discordLog',
            "craftingFailure",
            "❌ Crafting Failed",
            playerIdentifier .. " (" .. playerName .. ") failed to craft due to missing items",
            {
                {
                    ["name"] = "Player",
                    ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Item",
                    ["value"] = amountToCraft .. "x " .. Item,
                    ["inline"] = true
                },
                {
                    ["name"] = "Reason",
                    ["value"] = "Missing required ingredients",
                    ["inline"] = true
                }
            },
            Config.DiscordLogging.color.crafting,
            Config.DiscordLogging
        )
    end
end)

-- =================================================================================================
-- DELIVERY CALLBACK WITH DISCORD LOGGING
-- =================================================================================================

-- REVERT DELIVERY LOGIC TO ORIGINAL EVENT-BASED FORMAT

-- Discord log for delivery completion
RegisterNetEvent(Config.ResourceName .. ":Server:LogDeliveryComplete", function(items, reward, labels)
    local source = source
    local playerName = GetPlayerName(source)
    local playerIdentifier = CRUX.Framework.GetIdentifier(source)
    local itemsList = {}
    
    -- Ensure reward is a number, not nil
    local rewardAmount = tonumber(reward) or 0
    
    for item, amount in pairs(items) do
        local label = labels and labels[item] or item
        table.insert(itemsList, amount .. "x " .. item .. " (" .. label .. ")")
    end
    
    TriggerEvent('crux_lib:discordLog',
        "deliveryComplete",
        "🚚 Delivery Completed",
        playerIdentifier .. " (" .. playerName .. ") successfully completed a delivery order",
        {
            {
                ["name"] = "Player",
                ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Items Delivered",
                ["value"] = table.concat(itemsList, "\n"),
                ["inline"] = true
            },
            {
                ["name"] = "Reward",
                ["value"] = "$" .. rewardAmount,
                ["inline"] = true
            }
        },
        Config.DiscordLogging.color.delivery,
        Config.DiscordLogging
    )
end)

-- Discord log for delivery failure
RegisterNetEvent(Config.ResourceName .. ":Server:LogDeliveryFailed", function(items, reward, reason)
    local source = source
    local playerName = GetPlayerName(source)
    local playerIdentifier = CRUX.Framework.GetIdentifier(source)
    local itemsList = {}
    
    -- Ensure reward is a number, not nil
    local rewardAmount = tonumber(reward) or 0
    
    for item, amount in pairs(items) do
        table.insert(itemsList, amount .. "x " .. (item.label or item))
    end
    
    TriggerEvent('crux_lib:discordLog',
        "deliveryComplete",
        "❌ Delivery Failed",
        playerIdentifier .. " (" .. playerName .. ") failed a delivery",
        {
            {
                ["name"] = "Player",
                ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Items Attempted",
                ["value"] = table.concat(itemsList, "\n"),
                ["inline"] = true
            },
            {
                ["name"] = "Reward",
                ["value"] = "$" .. rewardAmount,
                ["inline"] = true
            },
            {
                ["name"] = "Reason",
                ["value"] = reason or "Unknown",
                ["inline"] = true
            }
        },
        Config.DiscordLogging.color.delivery,
        Config.DiscordLogging
    )
end)

-- =================================================================================================
-- GARAGE DISCORD LOGGING EVENTS
-- =================================================================================================

RegisterNetEvent(Config.ResourceName .. ":Server:LogVehicleSpawn", function(vehicleModel, plateText)
    local source = source
    local playerName = GetPlayerName(source)
    local playerIdentifier = CRUX.Framework.GetIdentifier(source)

    TriggerEvent('crux_lib:discordLog',
        "vehicleSpawn",
        "🚗 Vehicle Spawned",
        playerIdentifier .. " (" .. playerName .. ") took out a vehicle from the garage",
        {
            {
                ["name"] = "Player",
                ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Vehicle",
                ["value"] = vehicleModel,
                ["inline"] = true
            },
            {
                ["name"] = "Plate",
                ["value"] = plateText,
                ["inline"] = true
            }
        },
        Config.DiscordLogging.color.garage,
        Config.DiscordLogging
    )
end)

RegisterNetEvent(Config.ResourceName .. ":Server:LogVehicleReturn", function(vehicleModel, plateText)
    local source = source
    local playerName = GetPlayerName(source)
    local playerIdentifier = CRUX.Framework.GetIdentifier(source)

    TriggerEvent('crux_lib:discordLog',
        "vehicleReturn",
        "🏠 Vehicle Returned",
        playerIdentifier .. " (" .. playerName .. ") returned a vehicle to the garage",
        {
            {
                ["name"] = "Player",
                ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Vehicle",
                ["value"] = vehicleModel,
                ["inline"] = true
            },
            {
                ["name"] = "Plate",
                ["value"] = plateText,
                ["inline"] = true
            }
        },
        Config.DiscordLogging.color.garage,
        Config.DiscordLogging
    )
end)

-- =================================================================================================
-- MISCELLANEOUS EVENTS
-- =================================================================================================

-- Handle item cleaning process
RegisterNetEvent(Config.ResourceName .. ":Server:HandleCleanItem", function(data)
    local source = source
    local hasItems = true

    -- Verify items on server side
    for _, reqItem in pairs(data.required) do
        local itemCount = CRUX.Inventory.CountItem(source, reqItem.item, nil, false)
        if not itemCount or itemCount < reqItem.count then
            hasItems = false
            break
        end
    end

    if hasItems then
        -- Remove required items
        for _, reqItem in pairs(data.required) do
            if reqItem.remove then
                CRUX.Inventory.RemoveItem(source, reqItem.item, reqItem.count)
            end
        end
        
        -- Check if player can carry all the items to be added
        local canAddAll = true
        for _, addItem in pairs(data.add) do
            if not CRUX.Inventory.CanAddItem(source, addItem.item, addItem.count) then
                canAddAll = false
                break
            end
        end
        
        if canAddAll then
            -- Add new items
            for _, addItem in pairs(data.add) do
                CRUX.Inventory.AddItem(source, addItem.item, addItem.count)
            end
            CRUX.Notify(source, {
                title = Config.Localess.System.success,
                description = Config.Localess.WashHands.item_cleaned,
                type = "success",
                duration = 5000,
            })
        else
            -- Return the items that were removed if we can't add the new ones
            for _, reqItem in pairs(data.required) do
                if reqItem.remove then
                    CRUX.Inventory.AddItem(source, reqItem.item, reqItem.count)
                end
            end
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.System.inventory_full,
                type = "error",
                duration = 5000,
            })
        end
    else
        CRUX.Notify(source, {
            title = Config.Localess.WashHands.error,
            description = Config.Localess.WashHands.missing_required,
            type = "error",
            duration = 5000,
        })
    end
end)

-- Replace callback with event for required items check
RegisterNetEvent(Config.ResourceName .. ":Server:CheckRequiredItems", function(required, clientData)
    local source = source
    local hasItems = true
    for _, reqItem in pairs(required) do
        local itemCount = CRUX.Inventory.CountItem(source, reqItem.item, nil, false)
        if not itemCount or itemCount < reqItem.count then
            hasItems = false
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.WashHands.missing_required,
                type = "error",
            })
            break
        end
    end
    TriggerClientEvent(Config.ResourceName ..":Client:RequiredItemsResult", source, hasItems, clientData)
end)

-- Register restaurant menu items to open their respective menus on use
if Config.UsableMenuItem and Config.UsableMenuItem.enabled and Config.UsableMenuItem.items then
    for menuIdx, menuData in pairs(cPreset.restaurantMenu) do
        for _, menuItem in ipairs(Config.UsableMenuItem.items) do
            local itemName = menuItem.item
            CRUX.Inventory.CreateUseableItem(itemName, function(source, item)
                Server.Debug("Restaurant menu item used: " .. tostring(itemName) .. " by player: " .. source)
                TriggerClientEvent(Config.ResourceName .. ":Client:OpenRestaurantMenu", source, menuIdx, menuItem.image)
            end)
        end
    end
end



