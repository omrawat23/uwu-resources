-- Door lock system variables
local doorLocks = {}
local doorTargets = {}
local doorHashes = {}

local function playLockAnimation()
    -- Check if config exists and is enabled
    if not Config.DoorAnimation or not Config.DoorAnimation.enable then return end

    local ped = PlayerPedId()
    local dict = Config.DoorAnimation.dict
    local anim = Config.DoorAnimation.name

    -- Load the animation dictionary
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end

    -- Play the animation
    -- Speed: 8.0, SpeedMult: -8.0, Duration: -1 (Let logic decide end), Flag: 49 (Upper body, allow movement)
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 49, 0, false, false, false)

    -- Wait roughly the time it takes to "turn a key" or "swipe a card"
    -- This makes the lock happen synchronously with the hand movement
    Wait(600) 
    
    -- Cleanup
    ClearPedTasks(ped)
    RemoveAnimDict(dict)
end

-- Door lock functions
local function canInteractWithDoor()
    local playerJob = JobSystem.GetJob()

    -- Check if player has the right job
    if playerJob.name ~= Config.JobName then
        return false
    end

    return true
end

-- Helper function to calculate center point of a single door
local function calculateSingleDoorCenter(doorLocation, doorModel)
    -- Get the door entity
    local doorEntity = GetClosestObjectOfType(doorLocation.x, doorLocation.y, doorLocation.z, 2.0, doorModel, false, false, false)

    if doorEntity and doorEntity ~= 0 then
        -- Get the actual entity coordinates and dimensions
        local entityCoords = GetEntityCoords(doorEntity)
        local min, max = GetModelDimensions(doorModel)

        -- Calculate the center offset from the model dimensions
        local centerOffset = vector3(
            (min.x + max.x) / 2,
            (min.y + max.y) / 2,
            (min.z + max.z) / 2
        )

        -- Apply the entity's rotation to the center offset
        local heading = GetEntityHeading(doorEntity) * (math.pi / 180)
        local sin, cos = math.sin(heading), math.cos(heading)
        local rotatedX = cos * centerOffset.x - sin * centerOffset.y
        local rotatedY = sin * centerOffset.x + cos * centerOffset.y

        -- Return the actual center point of the door
        return vector3(
            entityCoords.x + rotatedX,
            entityCoords.y + rotatedY,
            entityCoords.z + centerOffset.z
        )
    else
        -- Fallback to door location if entity not found
        return doorLocation
    end
end

-- Helper function to calculate heading between two doors
local function calculateDoorHeading(door1Coords, door2Coords)
    local dx = door2Coords.x - door1Coords.x
    local dy = door2Coords.y - door1Coords.y
    local heading = math.deg(math.atan2(dy, dx))
    return heading < 0 and heading + 360 or heading
end

local function isPlayerNearDoor(doorIndex)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local door = cPreset.doors[doorIndex]
    if not door then return false, 0 end

    local centerPoint
    if door.doors then
        -- Calculate proper center point for double doors using actual door models
        local door1Data = door.doors[1]
        local door2Data = door.doors[2]

        -- Get actual door entities for better positioning
        local door1Entity = GetClosestObjectOfType(door1Data.coords.x, door1Data.coords.y, door1Data.coords.z, 2.0, door1Data.model, false, false, false)
        local door2Entity = GetClosestObjectOfType(door2Data.coords.x, door2Data.coords.y, door2Data.coords.z, 2.0, door2Data.model, false, false, false)

        local door1Coords = door1Data.coords
        local door2Coords = door2Data.coords

        if door1Entity and door1Entity ~= 0 then
            door1Coords = GetEntityCoords(door1Entity)
        end

        if door2Entity and door2Entity ~= 0 then
            door2Coords = GetEntityCoords(door2Entity)
        end

        centerPoint = vector3(
            (door1Coords.x + door2Coords.x) / 2,
            (door1Coords.y + door2Coords.y) / 2,
            (door1Coords.z + door2Coords.z) / 2
        )
    else
        -- Calculate actual center point for single door
        centerPoint = calculateSingleDoorCenter(door.location, door.model)
    end

    local distance = #(playerCoords - centerPoint)
    return distance <= (door.distance or 2.5), distance
end

local function handleDoorInteraction(doorIndex)
    local door = cPreset.doors[doorIndex]
    if not door then return end

    local canInteract = canInteractWithDoor()

    if canInteract then
        -- Player has job - toggle the door state
        toggleDoorLock(doorIndex)
    else
        -- Player doesn't have job - show access denied message
        local isLocked = doorLocks[doorIndex]

        if isLocked then
            return -- No message if door is locked
        else
            CRUX.Notify({
                title = Config.Localess.Door.access_denied_title,
                description = Config.Localess.Door.access_denied,
                type = "error",
                duration = 3000,
            })
        end

        -- Play error sound from audio folder
        TriggerEvent(Config.ResourceName .. ':client:playSound', 'error')
    end
end

-- Door interaction monitoring thread
CreateThread(function()
    if not cPreset.EnableDoorLock or not cPreset.doors then
        return
    end

    -- Always use E key (INPUT_CONTEXT, control ID 38)
    local buttonControl = 38

    while true do
        Wait(0)

        if IsControlJustPressed(0, buttonControl) then
            for i, door in pairs(cPreset.doors) do
                local isNear, distance = isPlayerNearDoor(i)

                if isNear then
                    handleDoorInteraction(i)
                    
                    break -- Only handle one door at a time
                end
            end
        end
    end
end)

-- ADD: NUI DoorStatus update thread
CreateThread(function()
    if not cPreset.EnableDoorLock or not cPreset.doors then
        return
    end

    local lastDoorIndex = nil

    while true do
        Wait(100) -- Lower frequency, NUI is not real-time

        local playerCoords = GetEntityCoords(PlayerPedId())
        local foundDoor = false

        for i, door in pairs(cPreset.doors) do
            local centerPoint
            if door.doors then
                local door1Data = door.doors[1]
                local door2Data = door.doors[2]
                local door1Entity = GetClosestObjectOfType(door1Data.coords.x, door1Data.coords.y, door1Data.coords.z, 2.0, door1Data.model, false, false, false)
                local door2Entity = GetClosestObjectOfType(door2Data.coords.x, door2Data.coords.y, door2Data.coords.z, 2.0, door2Data.model, false, false, false)
                local door1Coords = door1Data.coords
                local door2Coords = door2Data.coords
                if door1Entity and door1Entity ~= 0 then
                    door1Coords = GetEntityCoords(door1Entity)
                end
                if door2Entity and door2Entity ~= 0 then
                    door2Coords = GetEntityCoords(door2Entity)
                end
                centerPoint = vector3(
                    (door1Coords.x + door2Coords.x) / 2,
                    (door1Coords.y + door2Coords.y) / 2,
                    (door1Coords.z + door2Coords.z) / 2
                )
            else
                centerPoint = calculateSingleDoorCenter(door.location, door.model)
            end

            local distance = #(playerCoords - centerPoint)
            if distance <= (door.distance or 2.5) then
                foundDoor = true
                lastDoorIndex = i
                -- Use lockedLabel/unlockedLabel for label
                local label
                if doorLocks[i] then
                    label = door.lockedLabel or "Locked"
                else
                    label = door.unlockedLabel or "Unlocked"
                end
                SendNUIMessage({
                    action = "updateDoorStatus",
                    data = {
                        doorId = door.id or i,
                        isLocked = doorLocks[i],
                        label = label,
                        distance = distance,
                        maxDistance = door.distance or 2.5
                    }
                })
                break -- Only show one door status at a time
            end
        end

        if not foundDoor and lastDoorIndex ~= nil then
            -- Hide DoorStatus if not near any door
            SendNUIMessage({ action = "hideDoorStatus" })
            lastDoorIndex = nil
        end
    end
end)

function toggleDoorLock(doorIndex)
    if not canInteractWithDoor() then
        CRUX.Notify({
            title = Config.Localess.Door.access_denied_title,
            description = Config.Localess.Door.no_permissions,
            type = "error",
            duration = 5000,
        })
        return
    end

    local door = cPreset.doors[doorIndex]
    if not door then return end

    playLockAnimation()
    
    -- Trigger server to toggle door globally
    TriggerServerEvent(Config.ResourceName .. ':server:toggleDoor', doorIndex)
end

-- ADD: Event to receive door state update from server (no notification/sound)
RegisterNetEvent(Config.ResourceName .. ':client:updateDoorState', function(doorIndex, isLocked)
    local door = cPreset.doors[doorIndex]
    if not door then return end

    -- Update local state
    doorLocks[doorIndex] = isLocked
    local state = isLocked and 1 or 0

    -- Handle double doors
    if door.doors then
        CreateThread(function()
            for i = 1, #door.doors do
                local doorHash = doorHashes[doorIndex][i]
                DoorSystemSetDoorState(doorHash, state, false, false)
                
                if door.holdOpen then
                    DoorSystemSetHoldOpen(doorHash, state == 0)
                end
            end
            
            -- Wait for doors to close smoothly if locking
            if isLocked then
                while not IsDoorClosed(doorHashes[doorIndex][1]) or not IsDoorClosed(doorHashes[doorIndex][2]) do
                    Wait(0)
                end
            end
        end)
    else
        CreateThread(function()
            -- Handle single door
            local doorHash = doorHashes[doorIndex]
            DoorSystemSetDoorState(doorHash, state, false, false)
            
            if door.holdOpen then
                DoorSystemSetHoldOpen(doorHash, state == 0)
            end
            
            -- Wait for door to close smoothly if locking
            if isLocked then
                while not IsDoorClosed(doorHash) do
                    Wait(0)
                end
            end
        end)
    end
end)

-- NEW: Event for individual player feedback (notification + sound)
RegisterNetEvent(Config.ResourceName .. ':client:doorToggleFeedback', function(doorIndex, isLocked)
    local door = cPreset.doors[doorIndex]
    if not door then return end

    -- Notification
    local status = isLocked and "locked" or "unlocked"
    CRUX.Notify({
        title = Config.Localess.Door.title .. status:gsub("^%l", string.upper),
        description = Config.Localess.Door.description .. status,
        type = isLocked and "error" or "success",
        duration = 3000,
    })

    -- Play door_bolt.wav from audio folder for both lock and unlock using NUI
    SendNUIMessage({
        action = 'playSound',
        data = {
            sound = 'door_bolt',
            volume = 0.3
        }
    })
end)

-- ADD: Event to sync all door states from server
RegisterNetEvent(Config.ResourceName .. ':client:syncDoorStates', function(doorStates)
    for doorIndex, isLocked in pairs(doorStates) do
        local door = cPreset.doors[doorIndex]
        if door then
            doorLocks[doorIndex] = isLocked
            local state = isLocked and 1 or 0

            -- Apply state to doors
            if door.doors then
                for i = 1, #door.doors do
                    if doorHashes[doorIndex] and doorHashes[doorIndex][i] then
                        DoorSystemSetDoorState(doorHashes[doorIndex][i], state, false, false)
                    end
                end
            else
                if doorHashes[doorIndex] then
                    DoorSystemSetDoorState(doorHashes[doorIndex], state, false, false)
                end
            end
        end
    end
end)

function initializeDoorLocks()
    if not cPreset.EnableDoorLock or not cPreset.doors then
        return
    end

    Client.Debug("Initializing door lock system with " .. #cPreset.doors .. " doors")

    for i, door in pairs(cPreset.doors) do
        -- Initialize door lock status as locked (true) - will be synced from server
        doorLocks[i] = true

        -- Calculate center point and heading for double doors
        local centerPoint, targetHeading
        if door.doors then
            -- Use improved center calculation for double doors
            local door1Data = door.doors[1]
            local door2Data = door.doors[2]

            local door1Entity = GetClosestObjectOfType(door1Data.coords.x, door1Data.coords.y, door1Data.coords.z, 2.0, door1Data.model, false, false, false)
            local door2Entity = GetClosestObjectOfType(door2Data.coords.x, door2Data.coords.y, door2Data.coords.z, 2.0, door2Data.model, false, false, false)

            local door1Coords = door1Data.coords
            local door2Coords = door2Data.coords

            if door1Entity and door1Entity ~= 0 then
                door1Coords = GetEntityCoords(door1Entity)
            end

            if door2Entity and door2Entity ~= 0 then
                door2Coords = GetEntityCoords(door2Entity)
            end

            centerPoint = vector3(
                (door1Coords.x + door2Coords.x) / 2,
                (door1Coords.y + door2Coords.y) / 2,
                (door1Coords.z + door2Coords.z) / 2
            )
            targetHeading = calculateDoorHeading(door1Coords, door2Coords)
        else
            centerPoint = door.location
            targetHeading = door.heading
        end

        -- Handle double doors
        if door.doors then
            doorHashes[i] = {}
            for j = 1, #door.doors do
                local doorData = door.doors[j]
                -- Create a proper numeric hash for each door
                local doorHash = GetHashKey("door_" .. (door.id or i) .. "_" .. j)
                doorHashes[i][j] = doorHash

                -- Add door to system with proper parameters
                AddDoorToSystem(doorHash, doorData.model, doorData.coords.x, doorData.coords.y, doorData.coords.z, false, false, false)

                -- Set initial door state (4 = reset, then set to locked = 1)
                DoorSystemSetDoorState(doorHash, 4, false, false)
                Wait(100) -- Small delay to ensure door system processes the reset
                DoorSystemSetDoorState(doorHash, 1, false, false) -- Start locked
                
                -- Set door rate (controls how fast door opens/closes)
                DoorSystemSetAutomaticRate(doorHash, door.doorRate or 1.0, false, false)

                Client.Debug("Double door " .. i .. "-" .. j .. " initialized - Hash: " .. doorHash .. " - Locked: true")
            end
        else
            -- Handle single door
            local doorHash = GetHashKey("door_" .. (door.id or i))
            doorHashes[i] = doorHash

            -- Add door to system
            AddDoorToSystem(doorHash, door.model, door.location.x, door.location.y, door.location.z, false, false, false)

            -- Set initial door state to locked (1)
            DoorSystemSetDoorState(doorHash, 4, false, false)
            Wait(100) -- Small delay
            DoorSystemSetDoorState(doorHash, 1, false, false) -- Start locked

            -- Set door rate
            DoorSystemSetAutomaticRate(doorHash, door.doorRate or 1.0, false, false)

            Client.Debug("Single door " .. i .. " initialized - Hash: " .. doorHash .. " - Locked: true")
        end

        -- Create target zone for the door using calculated center point
        local targetId = "door-lock-" .. i
        doorTargets[i] = targetId

        -- Calculate minZ, maxZ, length, and width for the target zone
        local minZ = centerPoint.z - 1.0
        local maxZ = centerPoint.z + 1.0
        local length = door.length or 1.0
        local width = door.width or 1.0

        if CRUX and CRUX.Target and CRUX.Target.AddBoxZone then
            CRUX.Target.AddBoxZone(targetId, centerPoint, length, width, {
                heading = targetHeading,
                debugPoly = Config.debugPoly,
                minZ = minZ,
                maxZ = maxZ,
                options = {
                {
                    action = function()
                    toggleDoorLock(i)
                    end,
                    icon = "fas fa-key",
                    label = "Toggle Door Lock",
                    canInteract = canInteractWithDoor,
                }
                },
                distance = door.distance
            }, Config.debugPoly)
        else
            Client.Debug("^1[ERROR]^7 CRUX.Target.AddBoxZone is nil, cannot create door target zone")
        end

        Client.Debug("Door " .. i .. " target zone created at: " .. tostring(centerPoint))
    end
    
    -- Request current door states from server after initialization
    TriggerServerEvent(Config.ResourceName .. ':server:requestDoorStates')
end

-- Initialize door locks when client starts
AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    -- Add delay to ensure preset is loaded and world is ready
    SetTimeout(2000, function()
        initializeDoorLocks()
    end)
end)

-- Also initialize when player spawns (in case they join after resource start)
-- AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
--     SetTimeout(3000, function()
--         initializeDoorLocks()
--     end)
-- end)