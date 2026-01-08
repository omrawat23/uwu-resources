-- File: cl_vending.lua

local currentVendingIndex = nil
-- local vendingMachineStatus = {
--     isOpen = true -- Default to open until we get actual status
-- }
-- [[ BOSS VENDING LOGIC ]]

function VendingMachine(i)
    Client.Debug("Opening BOSS vending machine with index: " .. i)
    currentVendingIndex = i
    -- Check vending machine status before proceeding
    TriggerServerEvent(Config.ResourceName .. ':server:checkVendingStatus', i)
end

-- -- Add event handler for vending machine status updates
-- RegisterNetEvent(Config.ResourceName .. ':client:receiveVendingMachineStatus', function(data)
--     vendingMachineStatus.isOpen = data.isOpen
--     Client.Debug("Received vending machine status: " .. (data.isOpen and "OPEN" or "CLOSED"))

--     -- Update the UI if boss menu is open
--     SendNUIMessage({
--         action = 'updateVendingMachineStatus',
--         isOpen = data.isOpen
--     })
-- end)


-- New net event to handle status check response
RegisterNetEvent(Config.ResourceName .. ':client:vendingStatusChecked', function(isOpen)
    if not isOpen then
        -- Notify player that the vending machine is closed
        CRUX.Notify({
            title = "Vending Machine Closed",
            description = Config.Localess.vending_closed or "Vending machine is currently closed.",
            type = "error",
        })
        SetNuiFocus(false, false)
        currentVendingIndex = nil
        return
    end
    -- Proceed to fetch stock if open
    TriggerServerEvent(Config.ResourceName .. ':server:getVendingStock', currentVendingIndex)
end)

RegisterNetEvent(Config.ResourceName .. ':client:receiveVendingStock', function(stock)
    -- Now that we have confirmation, show loading and set focus
    SendNUIMessage({ action = "showLoading" })
    SetNuiFocus(true, true)
    
    local success, availableItems = pcall(function()
        local playerInv = CRUX.Inventory.GetAllItems()
        local items = {}
        if playerInv and type(playerInv) == "table" then
            for _, itemData in pairs(playerInv) do
                local amount = itemData.count or itemData.amount or 0
                if amount > 0 then
                    local image = (itemData.client and itemData.client.image) or (Config.InventoryImages .. itemData.name .. ".png")
                    table.insert(items, {
                        name = itemData.name,
                        label = itemData.label or itemData.name,
                        amount = amount,
                        image = image
                    })
                end
            end
        end
        return items
    end)

    if not success then
        Client.Debug("^1[VENDING ERROR]^7 Failed to process player inventory: " .. tostring(availableItems))
        return
    end

    SendNUIMessage({
        action = "openVendingBossMenu",
        menuItems = stock,
        availableItems = availableItems,
        vendingIndex = currentVendingIndex,
        -- Removed isOpen (assume always open)
        description = {
            title = Config.LocalessUtils.VendingMachine.title,
            label = Config.LocalessUtils.VendingMachine.label,
            titleImage = Config.LocalessUtils.VendingMachine.titleImage
        },
        locales = Config.Localess,
        notify = Config.Localess,
        categories = Config.Categories or {"General", "Drinks", "Snacks"},
        categoryimage = Config.categoryimage -- Add category images mapping
    })
end)

RegisterNUICallback('addMenuItem', function(data, cb)
    if not currentVendingIndex then return cb({ success = false }) end
    TriggerServerEvent(Config.ResourceName .. ':server:addVendingItem', { item = data, vendingIndex = currentVendingIndex })
    cb({ success = true })
end)

RegisterNUICallback('closeBossMenu', function(_, cb)
    SetNuiFocus(false, false)
    -- Unlock the vending machine on the server
    if currentVendingIndex then
        TriggerServerEvent(Config.ResourceName .. ':server:unlockVendingMachine', currentVendingIndex)
    end
    currentVendingIndex = nil
    -- ADDED: Ensure all UIs are told to close
    SendNUIMessage({ action = "closeAllMenus" })
    cb('ok')
end)


-- [[ EMPLOYEE VENDING LOGIC ]]

function EmployeeVendingMachine(i)
    Client.Debug("Opening EMPLOYEE vending machine with index: " .. i)
    currentVendingIndex = i
    -- Don't set NUI focus yet - wait for server confirmation
    TriggerServerEvent(Config.ResourceName .. ':server:getEmployeeVendingStock', i)
end

RegisterNetEvent(Config.ResourceName .. ':client:receiveEmployeeVendingStock', function(stock)
    -- Now that we have confirmation, show loading and set focus
    SendNUIMessage({ action = "showLoading" })
    SetNuiFocus(true, true)
    
    SendNUIMessage({
        action = "openEmployeeShopMenu",
        menuItems = stock,
        -- Removed isOpen (assume always open)
        description = {
            title = Config.LocalessUtils.EmployeeVendingMachine.title,
            label = Config.LocalessUtils.EmployeeVendingMachine.label,
            titleImage = Config.LocalessUtils.EmployeeVendingMachine.titleImage
        },
        vendingIndex = currentVendingIndex,
        locales = Config.Localess
    })
end)

RegisterNUICallback('collectItem', function(data, cb)
    if not currentVendingIndex then return cb({ success = false }) end
    TriggerServerEvent(Config.ResourceName .. ':server:collectVendingItem', {
        item = data.item,
        quantity = data.quantity,
        vendingIndex = currentVendingIndex
    })
    cb({ success = true })
end)

RegisterNUICallback('checkPermissions', function(data, cb)
    local playerJob = JobSystem.GetJob()
    if playerJob == Config.JobName and playerJob.is_boss == true then
        cb({ success = true })
    else
        cb({ success = false })
    end
end)

RegisterNUICallback('closeEmployeeMenu', function(_, cb)
    SetNuiFocus(false, false)
    -- Unlock the vending machine on the server
    if currentVendingIndex then
        TriggerServerEvent(Config.ResourceName .. ':server:unlockVendingMachine', currentVendingIndex)
    end
    currentVendingIndex = nil
    -- ADDED: Ensure all UIs are told to close
    SendNUIMessage({ action = "closeAllMenus" })
    cb('ok')
end)

-- New callbacks for dialog selections
RegisterNUICallback('openVendingShop', function(data, cb)
    if data.vendingIndex then
        VendingMachine(data.vendingIndex)
    end
    cb('ok')
end)

RegisterNUICallback('openVendingManage', function(data, cb)
    if data.vendingIndex then
        EmployeeVendingMachine(data.vendingIndex)
    end
    cb('ok')
end)

RegisterNUICallback('closeMenuSelectionDialog', function(_, cb)
    SetNuiFocus(false, false)
    -- Unlock the vending machine on the server if applicable
    if currentVendingIndex then
        TriggerServerEvent(Config.ResourceName .. ':server:unlockVendingMachine', currentVendingIndex)
    end
    currentVendingIndex = nil
    cb('ok')
end)

RegisterNetEvent(Config.ResourceName .. ':client:playVendingAnimation')
AddEventHandler(Config.ResourceName .. ':client:playVendingAnimation', function()
    if Config.VendingMachineAnimation and Config.VendingMachineAnimation.enable then
        RequestAnimDict(Config.VendingMachineAnimation.dict)
        while not HasAnimDictLoaded(Config.VendingMachineAnimation.dict) do
            Wait(0)
        end
        
        -- Use config values or defaults
        local speed = Config.VendingMachineAnimation.speed or 8.0
        local speedMultiplier = Config.VendingMachineAnimation.speedMultiplier or -8.0
        local duration = Config.VendingMachineAnimation.duration or 2000
        local flag = Config.VendingMachineAnimation.flag or 49
        
        TaskPlayAnim(PlayerPedId(), Config.VendingMachineAnimation.dict, Config.VendingMachineAnimation.name, speed, speedMultiplier, duration, flag, 0, false, false, false)
        
        -- Wait for animation to play briefly
        Wait(duration)
        ClearPedTasks(PlayerPedId())
    end
end)

-- Add event handler for machine in use notification
RegisterNetEvent(Config.ResourceName .. ':client:vendingMachineInUse', function()
    -- Ensure NUI is closed and focus is reset
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "closeAllMenus" })
    currentVendingIndex = nil
end)

-- Add event handler for vending machine status updates
RegisterNetEvent(Config.ResourceName .. ':client:updateVendingMachineStatus', function(isOpen)
    SendNUIMessage({ action = "updateVendingMachineStatus", isOpen = isOpen })
end)

RegisterNUICallback('toggleVendingMachineStatus', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:toggleVendingMachineStatus', data)
    cb({ success = true })
end)

