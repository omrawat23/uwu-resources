-- Server-side packaging handler
RegisterNetEvent(Config.ResourceName .. ':server:packageItems')
AddEventHandler(Config.ResourceName .. ':server:packageItems', function(packagedItems)
    local src = source
    
    -- Validate packagedItems
    if not packagedItems or type(packagedItems) ~= "table" then
        CRUX.Notify(src, {
            title = Config.Localess.System.error or "Packaging Error",
            description = "Invalid packaging data.",
            type = "error",
            duration = 5000,
        })
        return
    end
    
    -- Check if Config.StorageBox exists and is enabled
    if not Config.StorageBox or not Config.StorageBox.enabled then
        CRUX.Notify(src, {
            title = Config.Localess.System.error or "Packaging Error",
            description = "Packaging system is not configured.",
            type = "error",
            duration = 5000,
        })
        return
    end
    
    -- Check if player has storage box (server-side validation)
    local hasStorageBox = CRUX.Inventory.CountItem(src, Config.StorageBox.item)
    if not hasStorageBox or hasStorageBox <= 0 then
        CRUX.Notify(src, {
            title = Config.Localess.System.error or "Packaging Error",
            description = "You need a " .. (Config.StorageBox.label or "Storage Box") .. " to package items.",
            type = "error",
            duration = 5000,
        })
        return
    end
    
    -- Verify player has all items (similar to crafting validation)
    local itemsToPackage = {}
    for slotIndex, itemData in pairs(packagedItems) do
        local itemName = itemData.item
        local amount = tonumber(itemData.amount)
        
        if not itemName or not amount or amount <= 0 then
            CRUX.Notify(src, {
                title = Config.Localess.System.error or "Packaging Error",
                description = "Invalid item data in slot " .. slotIndex,
                type = "error",
                duration = 5000,
            })
            return
        end
        
        -- Server-side item count validation
        local playerItemCount = CRUX.Inventory.CountItem(src, itemName)
        if not playerItemCount or playerItemCount < amount then
            CRUX.Notify(src, {
                title = Config.Localess.System.error or "Packaging Error",
                description = "You don't have enough " .. (itemData.label or itemName),
                type = "error",
                duration = 5000,
            })
            return
        end
        
        table.insert(itemsToPackage, { item = itemName, amount = amount, label = itemData.label })
    end
    
    -- Find the storage box slot using server-side method
    local storageBoxSlot = nil
    
    -- Use GetItemByName which is server-side
    local storageBoxItem = CRUX.Inventory.GetItem(src, Config.StorageBox.item)
    
    if storageBoxItem and storageBoxItem.slot then
        storageBoxSlot = storageBoxItem.slot
    end
    
    if not storageBoxSlot then
        CRUX.Notify(src, {
            title = Config.Localess.System.error or "Packaging Error",
            description = "Could not find storage box in your inventory.",
            type = "error",
            duration = 5000,
        })
        return
    end
    
    -- Get existing storage box item to check/create uniqueId
    local uniqueId = storageBoxItem and storageBoxItem.info and storageBoxItem.info.uniqueId
    
    -- Generate unique ID if it doesn't exist
    if not uniqueId then
        uniqueId = generateUUID()
    end
    
    -- Get player identifier
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)
    
    -- Get or create stash ID for this storage box
    local stashId = getOrCreateStashId(uniqueId, playerIdentifier)
    
    -- Register the stash dynamically if it doesn't exist
    if not CRUX.Inventory.GetStash(stashId) then
        local stashLabel = Config.StorageBox.label .. " #" .. string.sub(stashId, -8)
        CRUX.Inventory.RegisterStash({
            id = stashId,
            label = stashLabel,
            slots = Config.StorageBox.slots,
            maxWeight = Config.StorageBox.weight
        })
        Server.Debug("^2Registered new stash for storage box: " .. stashId .. "^0")
    end
    
    -- Remove items from player inventory and add to storage box stash
    for _, itemToPackage in ipairs(itemsToPackage) do
        local removed = CRUX.Inventory.RemoveItem(src, itemToPackage.item, itemToPackage.amount)
        
        if not removed then
            -- If removal fails, refund already removed items
            Server.Debug("^1Failed to remove " .. itemToPackage.item .. " from player inventory^0")
            
            for i = 1, #itemsToPackage do
                if i < _ then
                    CRUX.Inventory.AddItem(src, itemsToPackage[i].item, itemsToPackage[i].amount)
                end
            end
            
            CRUX.Notify(src, {
                title = Config.Localess.System.error or "Packaging Error",
                description = "Failed to package items. Items have been returned.",
                type = "error",
                duration = 5000,
            })
            return
        end
        
        Server.Debug("Removed " .. itemToPackage.amount .. "x " .. itemToPackage.item .. " from player")
    end
    
    -- Add all items to the storage box's stash
    for _, itemToAdd in ipairs(itemsToPackage) do
        local success = CRUX.Inventory.AddItem(stashId, itemToAdd.item, itemToAdd.amount)
        
        if success then
            Server.Debug("Added " .. itemToAdd.amount .. "x " .. itemToAdd.item .. " to storage box stash: " .. stashId)
        else
            Server.Debug("^3Warning: Failed to add " .. itemToAdd.item .. " to stash^0")
        end
    end
    
    -- Update storage box metadata with unique ID and description
    local newInfo = storageBoxItem and storageBoxItem.info or {}
    newInfo.uniqueId = uniqueId
    newInfo.description = "Contains " .. #itemsToPackage .. " item type(s)"
    
    local metadataSuccess = CRUX.Inventory.SetItemMetadata(src, storageBoxSlot, newInfo)
    
    if not metadataSuccess then
        Server.Debug("^1Failed to set metadata for storage box^0")
    end
    
    -- Notify player of success
    CRUX.Notify(src, {
        title = Config.Localess.System.success or "Packaging Complete",
        description = "Items packaged into storage box successfully!",
        type = "success",
        duration = 5000,
    })
    
    -- Discord logging
    if Config.DiscordLogging and Config.DiscordLogging.enabled then
        local playerName = GetPlayerName(src)
        local itemsList = {}
        
        for _, item in ipairs(itemsToPackage) do
            table.insert(itemsList, item.amount .. "x " .. (item.label or item.item))
        end
        
        TriggerEvent('crux_lib:discordLog',
            "packaging",
            "📦 Items Packaged",
            playerIdentifier .. " (" .. playerName .. ") packaged items into storage box",
            {
                {
                    ["name"] = "Player",
                    ["value"] = playerIdentifier .. " (" .. playerName .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Storage Box ID",
                    ["value"] = string.sub(stashId, -8),
                    ["inline"] = true
                },
                {
                    ["name"] = "Items Packaged",
                    ["value"] = table.concat(itemsList, "\n"),
                    ["inline"] = false
                }
            },
            Config.DiscordLogging and Config.DiscordLogging.color and Config.DiscordLogging.color.packaging or 3447003,
            Config.DiscordLogging
        )
    end
end)
