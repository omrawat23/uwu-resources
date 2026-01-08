if not Config.Delivery.Enabled then
    return
end

-- Local variables - simplified for global system
local delivery = {
    active = false,
    location = nil,
    items = {},
    reward = nil,
    accepted = false
}

-- Blip and entity references
local deliveryBlip = nil
local deliveryPed = nil
local deliveryTarget = nil
local deliveryProp = nil
local cooldown = false
local cDel = Config.Delivery

local waitingForResponse = false
local lastNotificationTime = 0
local notificationCooldown = 60000 -- 1 minute cooldown between notifications

-- Helper function to reset delivery state
local function resetDelivery()
    return {
        active = false,
        location = nil,
        items = {},
        reward = nil,
        accepted = false
    }
end

-- Helper function to load animation dictionary
function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

-- Delivery Menu
function deliveryMenu()
    if not delivery.active and not delivery.accepted then
        CRUX.Notify({
            title = Config.Localess.Delivery.no_delivery,
            description = Config.Localess.Delivery.no_delivery,
            type = "error",
            duration = 5000,
        })
        return
    end

    local items = {}

    -- Get items for delivery - simplified without inventory validation
    for Item, Amount in pairs(delivery.items) do
        table.insert(items, {
            label = CRUX.Inventory.GetItemLabel(Item) or Item,
            value = Amount
        })
    end

    local validPositions = {
        ["top-right"] = true,
        ["top-center"] = true,
        ["top-left"] = true,
        ["center-left"] = true,
        ["center"] = true,
        ["center-right"] = true,
        ["bottom-left"] = true,
        ["bottom-center"] = true,
        ["bottom-right"] = true
    }

    local position = Config.Delivery.DeliveryInProgressPosition
    if not position or not validPositions[position] then
        position = "bottom-right"
    end

    SendNUIMessage({
        action = 'openDeliveryMenu',
        items = items,
        reward = delivery.reward,
        accepted = delivery.accepted,
        status = delivery.accepted and "active" or "pending",
        locales = Config.Localess.Delivery,
        title = Config.LocalessUtils.DeliveryMenu.title,
        label = Config.LocalessUtils.DeliveryMenu.label,
        titleImage = Config.LocalessUtils.DeliveryMenu.titleImage,
        config = {
            position = position
        }
    })
    SetNuiFocus(true, true)
end

-- Function to close delivery UI when needed
local function closeDeliveryMenu()
    SendNUIMessage({
        action = 'closeDeliveryMenu'
    })
    SetNuiFocus(false, false)
end

-- Register NUI callbacks
RegisterNUICallback('client:acceptDelivery', function(data, cb)
    TriggerEvent('client:acceptDelivery')
    cb({})
end)

RegisterNUICallback('client:declineDelivery', function(data, cb)
    TriggerEvent('client:declineDelivery')
    cb({})
end)

-- Add new callback for canceling an active delivery
RegisterNUICallback('client:cancelDelivery', function(data, cb)
    TriggerEvent('client:cancelDelivery')
    cb({})
end)

-- Remove the showDeliveryLocation callback as we're replacing it
RegisterNUICallback(Config.ResourceName .. ':client:showDeliveryLocation', function(data, cb)
    TriggerEvent(Config.ResourceName .. ':client:showDeliveryLocation')
    cb({})
end)

-- Close NUI when user clicks escape or presses a button
RegisterNUICallback('closeMenu', function(data, cb)
    -- Just remove NUI focus, but completely close the delivery menu
    SetNuiFocus(false, false)
    closeDeliveryMenu()
    cb({})
end)

-- Function to re-display menu for a pending delivery
function redisplayDeliveryMenu()
    if delivery.active then
        deliveryMenu()
    end
end

-- Register the export so it can be called from other resources
exports('redisplayDeliveryMenu', redisplayDeliveryMenu)

-- Safe removal of target zones - simplified for consistent handling
local function safeRemoveTarget(target)
    if not target then return false end
    Client.Debug("Removing target zone: " .. tostring(target))

    local success = pcall(function()
      if type(target) == "string" then
        CRUX.Target.RemoveZone(target)
      else
        CRUX.Target.RemoveZone(target)
      end
    end)

    return success
end

-- Helper function to clean up delivery resources
local function cleanupDelivery()
    -- Close the UI
    closeDeliveryMenu()

    -- Safely remove any remaining target zones
    if deliveryTarget then
        safeRemoveTarget(deliveryTarget)
        deliveryTarget = nil
    end

    if deliveryPed then
        CRUX.Target.RemoveTargetEntity(deliveryPed)
        SetTimeout(10000, function()
            -- Delete both the ped and prop when cleanup happens
            if deliveryProp ~= nil and DoesEntityExist(deliveryProp) then
                DeleteObject(deliveryProp)
                deliveryProp = nil
            end

            if deliveryPed ~= nil and DoesEntityExist(deliveryPed) then
                DeleteEntity(deliveryPed)
                deliveryPed = nil
            end
        end)
    end

    delivery = resetDelivery()
    if deliveryBlip then
        RemoveBlip(deliveryBlip)
        deliveryBlip = nil
    end

    SetTimeout(cDel.delay*1000, function()
        cooldown = false
    end)
end

-- Function to handle delivery animation sequence
local function playDeliveryAnimation()
    -- Make ped face the player
    local playerCoords = GetEntityCoords(PlayerPedId())
    local pedCoords = GetEntityCoords(deliveryPed)
    local heading = GetHeadingFromVector_2d(playerCoords.x - pedCoords.x, playerCoords.y - pedCoords.y)
    TaskTurnPedToFaceCoord(deliveryPed, playerCoords.x, playerCoords.y, playerCoords.z, 2000)
    Wait(500)

    -- Handle prop animation
    local prop = CreateObject(GetHashKey(cDel.deliveryProp), 0, 0, 0, true, true, true)
    deliveryProp = prop  -- Store the prop reference

    -- Change animation dict and clip to one with both hands carrying
    local carryDict = "anim@heists@box_carry@"
    local carryAnim = "idle"

    LoadAnimDict(carryDict)

    -- Play player animation first (before attaching prop)
    TaskPlayAnim(PlayerPedId(),
        carryDict,
        carryAnim,
        8.0, 8.0, -1, 51, 0,
        false, false, false)

    -- Wait for animation to start
    Wait(300)

    -- Attach to player with configuration values for proper paper bag positioning
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, -0.07, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    -- Make ped prepare for handover with both hands
    TaskPlayAnim(deliveryPed,
        carryDict,
        "idle_p",  -- Using the receiving animation
        8.0, 8.0, -1, 50, 0,
        false, false, false)

    Wait(1000) -- Wait for handover moment

    -- Detach from player
    DetachEntity(prop, true, true)

    -- Attach to delivery ped with configuration values for proper paper bag positioning
    AttachEntityToEntity(prop, deliveryPed, GetPedBoneIndex(deliveryPed, 28422), 0.0, 0.0, -0.07, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    -- Let the ped complete the receiving animation
    TaskPlayAnim(deliveryPed,
        carryDict,
        carryAnim,
        8.0, 8.0, -1, 51, 0,
        false, false, false)

    Wait(500)

    -- Clean up player animation only
    ClearPedTasks(PlayerPedId())
    -- Do NOT clear ped tasks so they keep holding the bag properly

    -- Finally clean up the delivery
    cleanupDelivery()
end

local function endDelivery(delivered)
    if delivered and delivery.active then
        -- Format the data correctly as an object with items and cash properties
        local orderData = {
            items = delivery.items,
            cash = delivery.reward
        }

        -- Send properly formatted orderData to server
        TriggerServerEvent(Config.ResourceName .. ':server:completeDelivery', orderData)
        -- Animation will be triggered by the callback event if successful
    else
        -- Non-delivery related cleanup still happens
        cleanupDelivery()
    end
end

local function knockOnDoor()
    LoadAnimDict(cDel.animations.doorKnock.dict)
    TaskPlayAnim(PlayerPedId(),
        cDel.animations.doorKnock.dict,
        cDel.animations.doorKnock.anim,
        cDel.animations.doorKnock.speed,
        cDel.animations.doorKnock.speedMultiplier,
        cDel.animations.doorKnock.duration,
        cDel.animations.doorKnock.flag,
        cDel.animations.doorKnock.playbackRate,
        false, false, false)
    Wait(cDel.animations.doorKnock.duration)
    ClearPedTasks(PlayerPedId())

    -- Safe removal of the delivery target
    if deliveryTarget then
        safeRemoveTarget(deliveryTarget)
        deliveryTarget = nil
    end

    -- Add a delay before spawning the ped
    Wait(Config.Delivery.DeliveryPedTimer * 1000)

    -- Spawn the ped after knocking
    local ped = cDel.deliveryPed[math.random(#cDel.deliveryPed)]
    deliveryPed = CRUX.utils.CreatePed(ped.Type, ped.Hash, delivery.location, false, ped.Scenario)

    -- Use CRUX.Target to add entity target for delivery completion
    CRUX.Target.AddTargetEntity(deliveryPed, {
        options = {
            {
                action = function(entity)
                    endDelivery(true)
                end,
                icon = Config.Localess.Targets.delivery_food_icon,
                label = Config.Localess.Targets.delivery_food,
            }
        },
        distance = Config.Delivery.targetDistance,
    })
end

-- Check if player can interact with delivery functions
local function canInteract()
    local playerJob = JobSystem.GetJob()

    -- Check if player has the right job
    if playerJob.name ~= Config.JobName then
        return false
    end

    -- Check duty status only if Config.NeedDuty is true
    if Config.NeedDuty and not playerJob.onduty then
        return false
    end

    return true
end

-- Function to check if player is inside area polyzone (for delivery notifications)
local function isPlayerInAreaZone()
    -- If area polyzone is not enabled, always return true (allow notifications everywhere)
    if not cPreset.AreaPolyzone or not cPreset.AreaPolyzone.enabled then
        return true
    end

    local playerPos = GetEntityCoords(PlayerPedId())
    local polyzone = cPreset.AreaPolyzone.polyzone
    local minZ = cPreset.AreaPolyzone.minZ
    local maxZ = cPreset.AreaPolyzone.maxZ

    -- Check Z coordinate first
    -- if playerPos.z < minZ or playerPos.z > maxZ then
    --     return false
    -- end

    -- Check if player is inside the polygon using the function from cl_polyzone.lua
    if polyzone and #polyzone >= 3 then
        -- Use the IsPointInPolygon function from cl_polyzone.lua
        return IsPointInPolygon(playerPos.x, playerPos.y, polyzone)
    end

    return false
end

-- Helper function to handle delivery notifications with cooldown
local function deliveryNotification(title, message, type, force)
    local currentTime = GetGameTimer()

    -- Skip notification if on cooldown unless forced
    if not force and (currentTime - lastNotificationTime) < notificationCooldown then
        return
    end

    -- Update last notification time
    lastNotificationTime = currentTime

    -- Show notification
    CRUX.Notify({
        title = title,
        description = message,
        type = type,
        duration = 5000,
    })
end

-- Request delivery creation from server (now just checks for global deliveries)
local function requestDeliveryCreation()
    if waitingForResponse then
        return
    end

    waitingForResponse = true
    TriggerServerEvent(Config.ResourceName .. ':server:canCreateDelivery')

    SetTimeout(10000, function()
        waitingForResponse = false
    end)
end

-- Handle global delivery creation from server
RegisterNetEvent(Config.ResourceName .. ':client:globalDeliveryCreated')
AddEventHandler(Config.ResourceName .. ':client:globalDeliveryCreated', function(deliveryData)
    if delivery.active then
        return -- Already have an active delivery
    end

    -- Only show notification if player is in area zone (if enabled)
    if not isPlayerInAreaZone() then
        return -- Don't show notification if player is outside area zone
    end

    delivery.location = deliveryData.location
    delivery.items = deliveryData.items

    -- If cash is a table with min and max, pick a random value
    if type(deliveryData.cash) == "table" and deliveryData.cash.min and deliveryData.cash.max then
        delivery.reward = math.random(deliveryData.cash.min, deliveryData.cash.max)
    else
        delivery.reward = deliveryData.cash
    end

    delivery.labels = {}
    for item, _ in pairs(delivery.items) do
        delivery.labels[item] = CRUX.Inventory.GetItemLabel(item)
    end

    delivery.active = true
    delivery.accepted = false


    CRUX.Notify({
        title = Config.Localess.Delivery.new_delivery_title,
        description = Config.Localess.Delivery.new_delivery_desc,
        type = "success",
        duration = 5000,
    })
end)

-- Handle global delivery expiry
RegisterNetEvent(Config.ResourceName .. ':client:globalDeliveryExpired')
AddEventHandler(Config.ResourceName .. ':client:globalDeliveryExpired', function()
    if delivery.active then
        -- Only show notification if player is in area zone (if enabled)
        if isPlayerInAreaZone() then
            CRUX.Notify({
                title = Config.Localess.Delivery.new_delivery_title,
                description = Config.Localess.Delivery.delivery_expired,
                type = "error",
                duration = 5000,
            })
        end
        cleanupDelivery()
    end
end)

-- Show Delivery Location
RegisterNetEvent(Config.ResourceName .. ':client:showDeliveryLocation', function()
    if delivery.accepted and deliveryBlip then
        SetBlipRoute(deliveryBlip, true)
    else
        CRUX.Notify({
            title = Config.Localess.Delivery.no_delivery,
            description = Config.Localess.Delivery.check_location_error,
            type = "error",
            duration = 5000,
        })
    end
end)

-- Timeout delivery
local function checkDelivery()
    -- Set initial time
    local timeRemaining = cDel.max_time

    -- Send initial time to UI
    SendNUIMessage({
        action = 'updateDeliveryStatus',
        status = "active",
        timeRemaining = timeRemaining
    })

    -- Create a loop to update the time
    Citizen.CreateThread(function()
        while delivery.accepted and timeRemaining > 0 do
            Citizen.Wait(1000)
            timeRemaining = timeRemaining - 1

            -- Update UI every second for real-time countdown
            SendNUIMessage({
                action = 'updateDeliveryStatus',
                timeRemaining = timeRemaining
            })

            -- Check if time is up
            if timeRemaining <= 0 then
                CRUX.Notify({
                    title = Config.Localess.Delivery.delivery_timeout,
                    description = Config.Localess.Delivery.delivery_expired,
                    type = "error",
                    duration = 5000,
                })
                endDelivery(false)
                break
            end
        end
    end)
end

-- Accept Delivery - updated to notify server
RegisterNetEvent('client:acceptDelivery', function()
    if not delivery.active or delivery.accepted then return end

    delivery.accepted = true

    -- Notify server that we accepted the global delivery
    TriggerServerEvent(Config.ResourceName .. ':server:acceptGlobalDelivery')

    -- Close the menu completely when accepting
    closeDeliveryMenu()

    -- Create blip for delivery location using CreateBlip function
    deliveryBlip = CRUX.utils.CreateBlip({
        location = delivery.location,
        sprite = cDel.deliveryBlip.sprite,
        scale = cDel.deliveryBlip.scale,
        color = cDel.deliveryBlip.color,
        name = cDel.deliveryBlip.name,
        route = true,
        routeColor = cDel.deliveryBlip.color,
        shortRange = false
    })

    CRUX.Notify({
        title = Config.Localess.Delivery.delivery_accepted,
        description = Config.Localess.Delivery.check_location,
        type = "success",
        duration = 5000,
    })

    -- Generate a unique identifier for the target zone
    local targetId = "b2-delivery-door-" .. tostring(math.random(1000000))

    -- Create target zone with error handling
    local success, result = pcall(function()
        return CRUX.Target.AddBoxZone(targetId,
            vector3(delivery.location.x, delivery.location.y, delivery.location.z + 1.25),
            1.0, 1.6,
            {
                heading = 7,
                debugPoly = Config.debugPoly,
                minZ = delivery.location.z + 1.0 - 0.5,
                maxZ = delivery.location.z + 0.5 + 1.0,
                options = {
                    {
                        action = function()
                            knockOnDoor()
                        end,
                        icon = Config.Localess.Targets.door_icon,
                        label = Config.Localess.Targets.door,
                        canInteract = canInteract,
                    }
                },
                distance = Config.Delivery.targetDistance
            },
            Config.debugPoly
        )
    end)

    -- Validate target zone creation
    if success then
        deliveryTarget = result or targetId -- Store the target ID for later removal
    else
        deliveryTarget = targetId -- Store the ID even though the zone creation failed
    end

    checkDelivery()
end)

-- Decline Delivery
RegisterNetEvent('client:declineDelivery', function()
    if not delivery.active or delivery.accepted then return end

    -- Close the delivery menu UI and reset NUI focus
    closeDeliveryMenu()

    -- Reset delivery and flag
    delivery = resetDelivery()
    canCreateDelivery = false

    CRUX.Notify({
        title = Config.Localess.Delivery.delivery_declined,
        description = Config.Localess.Delivery.delivery_declined,
        type = "error",
        duration = 5000,
    })

    -- Clean up any delivery resources that may exist
    if deliveryBlip then RemoveBlip(deliveryBlip) end
    if deliveryTarget then safeRemoveTarget(deliveryTarget) end

    -- No need to clean up the ped or prop since they should only exist after knocking on the door
    -- But we do need to reset the cooldown timer
    SetTimeout(cDel.delay*1000, function()
        cooldown = false
    end)
end)

-- Add new event handler for canceling active delivery
RegisterNetEvent('client:cancelDelivery')
AddEventHandler('client:cancelDelivery', function()
    if delivery.active and delivery.accepted then
        endDelivery(false) -- Pass false to indicate not delivered

        -- Reset the flag explicitly
        canCreateDelivery = false

        -- Clean up any delivery resources that may exist
        if deliveryBlip then RemoveBlip(deliveryBlip) end
        if deliveryTarget then safeRemoveTarget(deliveryTarget) end
    end
end)

-- Event handler for server delivery completion callback
RegisterNetEvent(Config.ResourceName .. ':client:deliveryCompleteCallback')
AddEventHandler(Config.ResourceName .. ':client:deliveryCompleteCallback', function(success, message)
    -- Reset the flag regardless of success
    canCreateDelivery = false

    -- Close the UI first
    closeDeliveryMenu()

    if success then
        -- Only play the handover animation if delivery was successful
        playDeliveryAnimation()
        -- Discord log for delivery success
        TriggerServerEvent(Config.ResourceName .. ":Server:LogDeliveryComplete", delivery.items, delivery.reward, delivery.labels)
    else
        -- If delivery failed, just show notification and clean up
        if message then
            CRUX.Notify({
                title = Config.Localess.Delivery.delivery_failed,
                description = message,
                type = "error",
                duration = 5000,
            })
        end
        -- Discord log for delivery failure
        TriggerServerEvent(Config.ResourceName .. ":Server:LogDeliveryFailed", delivery.items, delivery.reward, delivery.labels, message)
        -- Clean up the delivery without playing animation
        cleanupDelivery()
    end
end)

-- Create Deliveries - simplified for global system
CreateThread(function()
    while true do
        if canInteract() then
            if not delivery.active and not waitingForResponse then
                requestDeliveryCreation()
                Wait(5000) -- Short wait after requesting
            else
                Wait(10000) -- Wait longer when delivery is active
            end
        else
            -- If player can't interact (wrong job or not on duty), wait longer
            if Config.NeedDuty then
                local playerJob = JobSystem.GetJob()
                if playerJob.name == Config.JobName and not playerJob.onduty then
                    -- Only show notification for correct job but not on duty
                    deliveryNotification(Config.Localess.Delivery.no_delivery, Config.Localess.Delivery.no_delivery, "error", false)
                end
            end
            Wait(30000) -- Longer wait when can't interact
        end
    end
end)

-- Add event handler for resource stop to clean up
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if delivery.active then
            -- Clean up all entities and notify server
            if deliveryBlip then RemoveBlip(deliveryBlip) end
            if deliveryProp and DoesEntityExist(deliveryProp) then DeleteObject(deliveryProp) end
            if deliveryPed and DoesEntityExist(deliveryPed) then DeleteEntity(deliveryPed) end
            if deliveryTarget then safeRemoveTarget(deliveryTarget) end

            TriggerServerEvent(Config.ResourceName .. ':server:finishDelivery', false)
        end
    end
end)

-- Export the delivery menu function
exports('deliveryMenu', deliveryMenu)