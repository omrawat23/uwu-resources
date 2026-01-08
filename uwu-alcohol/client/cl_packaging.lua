-- Packaging System
local packagingData = {
    slots = {},
    maxSlots = 8
}

-- Function to open packaging menu
function OpenPackagingMenu()
    local playerJob = JobSystem.GetJob()
    
    -- Check if player has the correct job
    if not playerJob or playerJob.name ~= Config.JobName then
        CRUX.Notify({
            title = Config.Localess.System.error or "Error",
            description = "You don't have access to this feature.",
            type = "error",
            duration = 5000,
        })
        return
    end
    
    -- Check if Config.StorageBox exists
    if not Config.StorageBox or not Config.StorageBox.enabled then
        CRUX.Notify({
            title = "Packaging Error",
            description = "Packaging system is not configured.",
            type = "error",
            duration = 5000,
        })
        return
    end
    
    -- Reset packaging data
    packagingData.slots = {}
    
    -- Send packaging menu to NUI
    SendNUIMessage({
        action = "openPackaging",
        data = {
            slots = packagingData.slots,
            maxSlots = packagingData.maxSlots
        }
    })
    
    SetNuiFocus(true, true)
end

-- NUI Callback: Get player inventory for item selection
RegisterNUICallback('getInventoryItems', function(data, cb)
    local inventoryItems = CRUX.Inventory.GetAllItems()
    local formattedItems = {}
    
    if inventoryItems then
        for _, item in pairs(inventoryItems) do
            -- Safely get count/amount with fallback to 0
            local itemCount = tonumber(item.count) or tonumber(item.amount) or 0
            
            -- Skip the storage box item itself
            if itemCount > 0 and item.name ~= Config.StorageBox.item then
                table.insert(formattedItems, {
                    name = item.name,
                    label = item.label or CRUX.Inventory.GetItemLabel(item.name) or item.name,
                    count = itemCount,
                    image = Config.InventoryImages .. item.name .. ".png",
                    slot = item.slot
                })
            end
        end
    end
    
    -- Always return an array, even if empty
    cb(formattedItems)
end)

-- NUI Callback: Add item to packaging slot
RegisterNUICallback('addItemToPackage', function(data, cb)
    local slotIndex = tonumber(data.slotIndex)
    local itemName = data.itemName
    local amount = tonumber(data.amount) or 1
    
    if not slotIndex or not itemName or amount <= 0 then
        cb({ success = false, message = "Invalid data" })
        return
    end
    
    -- Get inventory items to check locally
    local inventoryItems = CRUX.Inventory.GetAllItems()
    local hasEnough = false
    
    if inventoryItems then
        for _, item in pairs(inventoryItems) do
            if item.name == itemName then
                local itemCount = tonumber(item.count) or tonumber(item.amount) or 0
                if itemCount >= amount then
                    hasEnough = true
                end
                break
            end
        end
    end
    
    if not hasEnough then
        cb({ success = false, message = "You don't have enough of this item" })
        return
    end
    
    -- Add to packaging data
    packagingData.slots[slotIndex] = {
        item = itemName,
        amount = amount,
        label = CRUX.Inventory.GetItemLabel(itemName) or itemName,
        image = Config.InventoryImages .. itemName .. ".png"
    }
    
    cb({ success = true })
end)

-- NUI Callback: Remove item from packaging slot
RegisterNUICallback('removeItemFromPackage', function(data, cb)
    local slotIndex = tonumber(data.slotIndex)
    
    if packagingData.slots[slotIndex] then
        packagingData.slots[slotIndex] = nil
        cb({ success = true })
    else
        cb({ success = false })
    end
end)

-- NUI Callback: Clear all slots
RegisterNUICallback('clearAllSlots', function(data, cb)
    packagingData.slots = {}
    cb({ success = true })
end)

-- NUI Callback: Finalize packaging
RegisterNUICallback('finalizePackaging', function(data, cb)
    SetNuiFocus(false, false)
    
    -- Check if there are any items to package
    local itemCount = 0
    for _ in pairs(packagingData.slots) do
        itemCount = itemCount + 1
    end
    
    if itemCount == 0 then
        CRUX.Notify({
            title = "Packaging",
            description = "You need to add at least one item to package.",
            type = "error",
            duration = 5000,
        })
        cb({ success = false })
        return
    end
    
    -- Check if Config.StorageBox exists
    if not Config.StorageBox or not Config.StorageBox.enabled then
        CRUX.Notify({
            title = "Packaging",
            description = "Packaging system is not configured.",
            type = "error",
            duration = 5000,
        })
        cb({ success = false })
        return
    end
    
    -- Check if player has a storage box item locally
    local inventoryItems = CRUX.Inventory.GetAllItems()
    local hasStorageBox = false
    
    if inventoryItems then
        for _, item in pairs(inventoryItems) do
            if item.name == Config.StorageBox.item then
                local itemCount = tonumber(item.count) or tonumber(item.amount) or 0
                if itemCount > 0 then
                    hasStorageBox = true
                    break
                end
            end
        end
    end
    
    if not hasStorageBox then
        CRUX.Notify({
            title = "Packaging",
            description = "You need a " .. (Config.StorageBox.label or "Storage Box") .. " to package items.",
            type = "error",
            duration = 5000,
        })
        cb({ success = false })
        return
    end
    
    -- Send to server for processing
    TriggerServerEvent(Config.ResourceName .. ':server:packageItems', packagingData.slots)
    
    cb({ success = true })
end)

-- NUI Callback: Close packaging menu
RegisterNUICallback('closePackaging', function(data, cb)
    SetNuiFocus(false, false)
    packagingData.slots = {}
    cb('ok')
end)

-- Register the command
RegisterCommand('package', function()
    OpenPackagingMenu()
end, false)

-- Export the function
exports('OpenPackagingMenu', OpenPackagingMenu)
