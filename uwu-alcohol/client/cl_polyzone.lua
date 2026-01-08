-- AreaPolyZone functionality

isInZone = false
local areaPolyZone = nil
local dutyStateChangedByZone = false
local notificationSent = false -- Track if we've sent a notification for the current state

-- Function to handle player entering zone
local function handleZoneEnter()
    if isInZone then return end
    isInZone = true
    notificationSent = false -- Reset notification flag

    local playerJob = JobSystem.GetJob()
    if not playerJob or playerJob.name ~= Config.JobName then return end

    -- Only set on duty if not already on duty and AutoDutyOnIfInZone is enabled
    if not playerJob.onduty and cPreset.AreaPolyzone.AutoDutyOnIfInZone then
        -- Track that duty change was initiated by zone
        dutyStateChangedByZone = true
        -- Set player on duty
        TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
        CRUX.Notify({
            title = Config.Localess.Duty.restaurant_area,
            description = Config.Localess.Duty.enter_workplace,
            type = "success",
            duration = 5000,
        })
    elseif not playerJob.onduty and not cPreset.AreaPolyzone.AutoDutyOnIfInZone then
        -- Just notify without changing duty status if AutoDutyOnIfInZone is disabled
        CRUX.Notify({
            title = Config.Localess.Duty.restaurant_area,
            description = Config.Localess.Duty.clock_in,
            type = "info",
            duration = 5000,
        })
    end
end

-- Function to handle player exiting zone
local function handleZoneExit()
    if not isInZone then return end
    isInZone = false
    notificationSent = false -- Reset notification flag

    local playerJob = JobSystem.GetJob()
    if not playerJob or playerJob.name ~= Config.JobName then return end

    -- Always set off duty when player leaves the zone, regardless of AutoDutyOnIfInZone setting
    if playerJob.onduty then
        -- Track that duty change was initiated by zone
        dutyStateChangedByZone = true
        -- Set player off duty
        TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
        CRUX.Notify({
            title = Config.Localess.Duty.restaurant_area,
            description = Config.Localess.Duty.leave_workplace,
            type = "warning",
            duration = 5000,
        })
    end
end


-- Function to create the polyzone using lib.zones.poly
local function createAreaPolyZone()
    -- Only create if enabled in cPreset
    if not cPreset.AreaPolyzone.enabled then return end

    -- Get polyzone points from cPreset
    local points = cPreset.AreaPolyzone.polyzone

    -- Make sure we have valid points
    if not points or #points < 3 then
        Client.Debug("^1[ERROR]^7 Invalid AreaPolyZone points configuration")
        return
    end

    -- Convert points to vec3 format if needed
    local vecPoints = {}
    for i, pt in ipairs(points) do
        table.insert(vecPoints, vec(pt.x, pt.y, pt.z or cPreset.AreaPolyzone.minZ))
    end

    -- Create the polyzone using lib.zones.poly
    areaPolyZone = lib.zones.poly({
        points = vecPoints,
        thickness = (cPreset.AreaPolyzone.maxZ or 2) - (cPreset.AreaPolyzone.minZ or 0),
        debug = cPreset.AreaPolyzone.debugPoly or false,
        inside = function()
            -- Called every tick while inside zone
        end,
        onEnter = function()
            handleZoneEnter()
        end,
        onExit = function()
            handleZoneExit()
        end
    })

    Client.Debug("^2[INFO]^7 Restaurant duty zone created successfully with lib.zones.poly")
end


-- Function to check if a point is inside a polygon
function IsPointInPolygon(x, y, polygon)
    -- Check Z coordinate first to avoid unnecessary polygon calculations
    local playerPos = GetEntityCoords(PlayerPedId())
    local z = playerPos.z

    -- If player is outside the min/max Z bounds, they're not in the zone
    -- if z < cPreset.AreaPolyzone.minZ or z > cPreset.AreaPolyzone.maxZ then
    --     return false
    -- end

    local inside = false
    local j = #polygon

    for i = 1, #polygon do
        if ((polygon[i].y > y) ~= (polygon[j].y > y)) and
            (x < (polygon[j].x - polygon[i].x) * (y - polygon[i].y) /
            (polygon[j].y - polygon[i].y) + polygon[i].x) then
            inside = not inside
        end
        j = i
    end

    return inside
end

-- Force check and notification of duty status based on zone
local function forceCheckDutyStatus(skipNotification)
    local playerJob = JobSystem.GetJob()
    if not playerJob or playerJob.name ~= Config.JobName then return end

    local playerPos = GetEntityCoords(PlayerPedId())
    local playerInZone = false
    local z = playerPos.z

    if cPreset.AreaPolyzone and cPreset.AreaPolyzone.polyzone and #(cPreset.AreaPolyzone.polyzone) >= 3
       and z >= cPreset.AreaPolyzone.minZ and z <= cPreset.AreaPolyzone.maxZ then
        playerInZone = IsPointInPolygon(playerPos.x, playerPos.y, cPreset.AreaPolyzone.polyzone)
    end

    -- Apply automatic duty ON only if AutoDutyOnIfInZone is enabled
    if playerInZone and not playerJob.onduty and cPreset.AreaPolyzone.AutoDutyOnIfInZone then
        -- Should be on duty when in zone if AutoDutyOnIfInZone is enabled
        dutyStateChangedByZone = true
        TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
        if not skipNotification then
            CRUX.Notify({
                title = Config.Localess.Duty.restaurant_area,
                description = Config.Localess.Duty.inside_workplace,
                type = "success",
                duration = 5000,
            })
        end
    -- Notify to use duty point if AutoDutyOnIfInZone is disabled and player inside zone
    elseif playerInZone and not playerJob.onduty and not skipNotification and not notificationSent then
        notificationSent = true
        CRUX.Notify({
            title = Config.Localess.Duty.restaurant_area,
            description = Config.Localess.Duty.inside_workplace,
            type = "info",
            duration = 5000,
        })
    -- Always turn duty OFF when outside zone, regardless of AutoDutyOnIfInZone setting
    elseif not playerInZone and playerJob.onduty and not notificationSent then
        -- Should be off duty when outside zone - but only notify if we haven't already
        dutyStateChangedByZone = true
        notificationSent = true -- Mark that we've sent a notification
        TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
        if not skipNotification then
            CRUX.Notify({
                title = Config.Localess.Duty.restaurant_area,
                description = Config.Localess.Duty.outside_workplace,
                type = "warning",
                duration = 5000,
            })
        end
    end

    return playerInZone
end

-- Create a thread to check player's position in relation to the polyzone
Citizen.CreateThread(function()
    Wait(1000) -- Wait for everything to initialize

    -- Create the area polyzone
    createAreaPolyZone()

    -- If not enabled, exit early
    if not cPreset.AreaPolyzone or not cPreset.AreaPolyzone.enabled then return end

    -- Check if player is already in zone when script starts and apply duty
    local initialInZone = forceCheckDutyStatus(true) -- Skip initial notification

    -- Update isInZone to match current state
    isInZone = initialInZone

    -- Add a delayed notification for initial state
    -- Citizen.SetTimeout(2000, function()
    --     local playerJob = JobSystem.GetJob()
    --     if isInZone and playerJob and playerJob.name == Config.JobName then
    --         CRUX.Notify({
    --             title = "Restaurant Area",
    --             description = "You're inside your workplace - duty status has been updated.",
    --             type = "info",
    --             duration = 5000,
    --         })
    --     end
    -- end)

    Client.Debug("^3[INFO]^7 Restaurant zone initial state: " .. (isInZone and "Inside zone" or "Outside zone"))

    -- Set up point check loop
    while true do
        local playerPos = GetEntityCoords(PlayerPedId())
        local isPlayerInZone = false

        -- Check if player is in the polyzone
        if cPreset.AreaPolyzone and cPreset.AreaPolyzone.polyzone and #(cPreset.AreaPolyzone.polyzone) >= 3 then
            isPlayerInZone = IsPointInPolygon(playerPos.x, playerPos.y, cPreset.AreaPolyzone.polyzone)
        end

        -- Handle zone transitions
        if isPlayerInZone and not isInZone then
            handleZoneEnter()
        elseif not isPlayerInZone and isInZone then
            handleZoneExit()
        end

        -- Check position less frequently when far from transitions
        local distanceToCheck = isInZone and 1000 or 3000
        Wait(distanceToCheck)
    end
end)

-- Enhanced event handler for manual duty toggles
RegisterNetEvent(Config.ResourceName .. ':client:dutyStatusUpdated')
AddEventHandler(Config.ResourceName .. ':client:dutyStatusUpdated', function(isOnDuty)
    -- Only handle manual duty changes
    if not dutyStateChangedByZone then
        -- If manually going on duty outside the zone, warn player they'll be auto-toggled
        -- But only if AutoDutyOnIfInZone is enabled
        if isOnDuty and cPreset.AreaPolyzone and cPreset.AreaPolyzone.enabled and
           cPreset.AreaPolyzone.AutoDutyOnIfInZone and not isInZone then
            CRUX.Notify({
                title = Config.Localess.Duty.duty_warning,
                description = Config.Localess.Duty.auto_off_duty,
                type = "error",
                duration = 7000,
            })

            -- Add a short delay to ensure notification is seen before toggling off duty
            Wait(1500)

            -- Force duty toggle if they're outside the zone
            if not isInZone then
                dutyStateChangedByZone = true
                TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
            end
        end
    end

    -- Reset the flag
    dutyStateChangedByZone = false
end)

-- A function to check and update duty status based on zone
function CheckAndUpdateDutyStatus()
    local playerJob = JobSystem.GetJob()
    if not playerJob or playerJob.name ~= Config.JobName then return end

    -- Always force off duty when outside zone, regardless of AutoDutyOnIfInZone setting
    if not isInZone and playerJob.onduty then
        dutyStateChangedByZone = true
        TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
        CRUX.Notify({
            title = Config.Localess.Duty.restaurant_area,
            description = Config.Localess.Duty.outside_workplace,
            type = "warning",
            duration = 5000,
        })
    end
end

-- Register a command to check zone status and force update
-- RegisterCommand('checkzone', function()
--     local playerPos = GetEntityCoords(PlayerPedId())
--     local playerJob = JobSystem.GetJob()
--     local inZone = false

--     if cPreset.AreaPolyzone and cPreset.AreaPolyzone.polyzone and #(cPreset.AreaPolyzone.polyzone) >= 3 then
--         inZone = IsPointInPolygon(playerPos.x, playerPos.y, cPreset.AreaPolyzone.polyzone)

--         -- Force an update to duty status based on zone
--         forceCheckDutyStatus(false)
--     end

--     CRUX.Notify({
--         title = "Zone Check",
--         description = "You are " .. (inZone and "INSIDE" or "OUTSIDE") .. " the restaurant zone. Duty status: " ..
--                  ((playerJob and playerJob.onduty) and "ON duty" or "OFF duty"),
--         type = "info",
--         duration = 5000,
--     })
-- end, false)

-- Also add force zone check on resource restart
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    -- Add a delay to make sure other systems initialize first
    Citizen.SetTimeout(2500, function()
        if cPreset.AreaPolyzone and cPreset.AreaPolyzone.enabled then
            forceCheckDutyStatus(false)
        end
    end)
end)

-- Handle resource stop to clean up
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    -- Clean up zone if needed
    if areaPolyZone then
        -- Properly remove the polyzone
        CRUX.Target.RemoveZone("restaurant_duty_zone")
    end
end)

---@return boolean
exports('insideZone', function()
    return isInZone
end)
