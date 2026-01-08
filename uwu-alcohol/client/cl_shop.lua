-- Shop Menu functionality
-- Initialize variables with nil or empty values first
local playerJob = nil
local playerName = nil
local playerCash = nil
local playerBank = nil
local playerAvatarUrl = nil -- Add storage for player avatar

-- Add shop status variable
local shopOpen = true -- Default to open

-- Event to handle shop status changes
RegisterNetEvent(Config.ResourceName .. ':client:shopStatusChanged')
AddEventHandler(Config.ResourceName .. ':client:shopStatusChanged', function(isOpen)
    shopOpen = isOpen
    
    -- Send status update to NUI
    SendNUIMessage({
        action = "updateShopStatus",
        shopOpen = isOpen
    })
    
    if isOpen then
        CRUX.Notify({
            title = Config.Localess.Shop.shop_status,
            description = Config.Localess.Shop.shop_open,
            type = "success",
            duration = 3000,
        })
    else
        CRUX.Notify({
            title = Config.Localess.Shop.shop_status,
            description = Config.Localess.Shop.shop_closed,
            type = "error",
            duration = 3000,
        })
    end
end)

-- Event handler for receiving avatar data
RegisterNetEvent(Config.ResourceName .. ':client:receivePlayerAvatar')
AddEventHandler(Config.ResourceName .. ':client:receivePlayerAvatar', function(avatarUrl)
    playerAvatarUrl = avatarUrl
    Client.Debug("Shop menu received avatar URL: " .. (avatarUrl or "nil"))
end)

-- Main function to open the shop menu
function ShopMenu()
    -- Fetch data only when the menu is opened (player is fully loaded)
    playerJob = JobSystem.GetJob()
    playerName = CRUX.Framework.GetPlayerName()
    playerCash = CRUX.Framework.GetCash()
    playerBank = CRUX.Framework.GetBank()

    -- Check if player has the correct job
    if Config.Shop.RequireJob and playerJob.name ~= Config.JobName then
        CRUX.Notify({
            title = Config.Localess.Shop.purchase_title,
            description = Config.Localess.Shop.access_denied,
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Fetch player avatar before opening menu
    TriggerServerEvent(Config.ResourceName .. ':server:getPlayerAvatar')
    -- Small delay to ensure we get a response
    Citizen.Wait(100)

    -- Prepare shop data from config
    local shopData = Config.Shop.shopItems or {}

    -- Add categoryImage to each item in shopData (fix: use camelCase to match MenuItem interface)
    for _, item in ipairs(shopData) do
        item.categoryImage = Config.categoryimage and Config.categoryimage[item.category] or nil
    end

    -- Extract the correct grade value - need to handle both table and simple value cases
    local gradeLevel
    if type(playerJob.grade) == "table" then
        -- Try common field names for grade in the table
        if playerJob.grade.level ~= nil then
            gradeLevel = tostring(playerJob.grade.level)
        elseif playerJob.grade.id ~= nil then
            gradeLevel = tostring(playerJob.grade.id)
        elseif playerJob.grade.number ~= nil then
            gradeLevel = tostring(playerJob.grade.number)
        else
            -- If we can't find a specific field, dump the grade table to see what's available
            Client.Debug("Grade table contents: " .. json.encode(playerJob.grade))
            gradeLevel = "0" -- Default fallback
        end
    else
        -- Handle direct value case
        gradeLevel = tostring(playerJob.grade)
    end

    -- Safely get grade name and isBoss
    local gradeName = "Unknown"
    local isBoss = false
    local gradeKey = gradeLevel
    if Config.Grades and Config.Grades[gradeKey] then
        gradeName = Config.Grades[gradeKey].Label
        isBoss = Config.Grades[gradeKey].IsBoss or false
    end

    -- Send data to the UI and enable cursor
    SendNUIMessage({
        action = "openShopMenu",
        shopData = shopData,
        shopOpen = shopOpen, -- Add shop status
        playerData = {
            name = playerName,
            cash = playerCash,
            bank = playerBank,
            avatar = playerAvatarUrl,
            job = {
                name = playerJob.name,
                label = playerJob.label,
                grade = playerJob.grade,
                grade_name = gradeName,
                onduty = playerJob.onduty,
                isBoss = isBoss -- Add isBoss
            }
        },
        locales = Config.Localess,
        locales_utils = Config.LocalessUtils,
    })

    SetNuiFocus(true, true)
end

-- NUI Callback to handle closing the menu
RegisterNUICallback('closeShopMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- NUI Callback to handle purchasing items
RegisterNUICallback('purchaseItems', function(data, cb)
    if not data.items or #data.items == 0 then
        cb({ success = false, description = "No items to purchase" })
        return
    end

    -- Forward purchase request to server
    TriggerServerEvent(Config.ResourceName .. ':server:purchaseItems', {
        items = data.items,
        total = data.total,
        method = data.method or "cash"
    })

    cb({ success = true })
    SetNuiFocus(false, false)
end)

-- NUI Callback to handle toggling shop status
RegisterNUICallback('toggleShopStatus', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:toggleShopStatus')
    cb('ok')
end)

-- Event handler for purchase response from server
RegisterNetEvent(Config.ResourceName .. ':client:purchaseResponse')
AddEventHandler(Config.ResourceName .. ':client:purchaseResponse', function(response)
    if response.success then
        CRUX.Notify({
            title = Config.Localess.Shop.purchase_title,
            description = Config.Localess.Shop.purchase_success,
            type = "success",
            duration = 5000,
        })
    else
        CRUX.Notify({
            title = Config.Localess.Shop.purchase_title,
            description = response.message or Config.Localess.Shop.purchase_error,
            type = "error",
            duration = 5000,
        })
    end
end)

-- Event handler for playing buy animation
RegisterNetEvent(Config.ResourceName .. ':client:playBuyAnimation')
AddEventHandler(Config.ResourceName .. ':client:playBuyAnimation', function()
    if Config.Shop.animationBuy and Config.Shop.animationBuy.enable then
        RequestAnimDict(Config.Shop.animationBuy.dict)
        while not HasAnimDictLoaded(Config.Shop.animationBuy.dict) do
            Wait(0)
        end
        
        -- Use config values or defaults
        local speed = Config.Shop.animationBuy.speed or 8.0
        local speedMultiplier = Config.Shop.animationBuy.speedMultiplier or -8.0
        local duration = Config.Shop.animationBuy.duration or 2000
        local flag = Config.Shop.animationBuy.flag or 49
        
        TaskPlayAnim(PlayerPedId(), Config.Shop.animationBuy.dict, Config.Shop.animationBuy.name, speed, speedMultiplier, duration, flag, 0, false, false, false)
        
        -- Wait for animation to play briefly
        Wait(duration)
        ClearPedTasks(PlayerPedId())
    end
end)
