-- New function to check for available spawn points
function GetNextAvailableSpawnPoint()
    -- Get spawn points from config
    local spawnPoints = cPreset.garage.spawnPoints

    -- Check each spawn point in order
    for _, spawnPoint in ipairs(spawnPoints) do
        local clear = true
        -- Check if any vehicles are near this spawn point
        local coords = vector3(spawnPoint.x, spawnPoint.y, spawnPoint.z)

        -- Get all vehicles in the game pool
        local nearbyVehicles = GetGamePool('CVehicle')
        for _, vehicle in ipairs(nearbyVehicles) do
            local vehCoords = GetEntityCoords(vehicle)
            local distance = #(vehCoords - coords)

            -- If any vehicle is within 2.5 meters, this spawn point is occupied
            if distance < 2.5 then
                clear = false
                break
            end
        end

        -- If no vehicles nearby, this spawn point is available
        if clear then
            return spawnPoint
        end
    end

    -- If all spawn points are occupied, return nil
    return nil
end

-- Helper to strip spaces and symbols for comparison
function NormalizePlate(plate)
    if not plate then return "" end
    return string.upper(string.gsub(plate, "[^%w]", ""))
end

-- session-local sequence for minor uniqueness
local __garageSpawnSeq = 0

-- 1. OPEN SPAWN MENU
function openGarage(vehicles)
    if not canInteract() then return end
    
    local vehiclesData = {}
    for _, v in pairs(vehicles) do
        table.insert(vehiclesData, {
            model = v.model,
            label = v.label or v.model,
            image = v.image,
            livery = v.livery or 0,
            plateText = v.plateText
        })
    end

    SendNUIMessage({
        action = 'openGarageMenu', -- Targets the Spawn UI
        vehicles = vehiclesData,
        menuTitle = "Garage",
        useCustomImages = Config.UseCustomImages,
        localutilsdata = Config.LocalessUtils.Garage,
        locales = Config.Localess.Garage
    })
    SetNuiFocus(true, true)
end

-- 2. OPEN RETURN MENU
function openReturnGarage()
    if not canInteract() then return end
    -- Request active vehicles from DB
    TriggerServerEvent(Config.ResourceName .. ':Server:GetActiveVehicles')
end

-- Event triggered by server after fetching DB
RegisterNetEvent(Config.ResourceName .. ':Client:OpenReturnMenu', function(activeVehicles)
    SendNUIMessage({
        action = 'openReturnMenu', -- Targets the Return UI
        vehicles = activeVehicles,
        menuTitle = "Return Vehicle",
        localutilsdata = Config.LocalessUtils.ReturnGarage,
        locales = Config.Localess.Garage
    })
    SetNuiFocus(true, true)
end)

-- 3. HANDLE SPAWN CALLBACK
RegisterNUICallback('client:spawnVehicle', function(data, cb)
    SetNuiFocus(false, false)
    local spawnPoint = GetNextAvailableSpawnPoint()
    
    if spawnPoint then
        local vehicle = CRUX.Framework.SpawnVehicle(data.model, spawnPoint)
        if DoesEntityExist(vehicle) then
            -- Always set plate from data.plateText and append a small sequence
            __garageSpawnSeq = (__garageSpawnSeq + 1) % 100
            local base = (data.plateText or "JOB")
            -- cap base to avoid overly long plates, then add 2-digit seq
            local formattedPlate = string.sub(base, 1, 6) .. string.format("%02d", __garageSpawnSeq)
            SetVehicleNumberPlateText(vehicle, formattedPlate)

            -- 2. Get the ACTUAL plate the game registered (Game might add spaces)
            local actualGamePlate = GetVehicleNumberPlateText(vehicle)
            local dbPlate = NormalizePlate(actualGamePlate)

            -- 4. Set livery if provided (changed to mod livery for YTD support)
            if data.livery then
                SetVehicleModKit(vehicle, 0)  -- Enable mod kit for custom liveries
                SetVehicleMod(vehicle, 48, data.livery)  -- Set mod livery (supports YTD)
            end

            -- 5. Set fuel level to full
            SetVehicleFuelLevel(vehicle, 100.0)
            if DecorGetFloat ~= nil then  -- Ensure this native function exists
                DecorSetFloat(vehicle, '_FUEL_LEVEL', GetVehicleFuelLevel(vehicle))
            end

            -- 6. Set dirt level to clean
            SetVehicleDirtLevel(vehicle, 0.0)
            local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            local plate = GetVehicleNumberPlateText(vehicle)
            CRUX.VehicleKeys.GiveKey(plate, model, vehicle)
            -- Log to DB using the NORMALIZED plate
            local dbPlate = NormalizePlate(plate)
            TriggerServerEvent(Config.ResourceName .. ":Server:LogVehicleSpawn", data.model, dbPlate, data.label)
            
            cb({success = true})
        else
            CRUX.Notify({type="error", title=Config.Localess.Garage.error or "Error", description=Config.Localess.Garage.vehicle_entity_failed})
            cb({success = false})
        end
    else
        CRUX.Notify({type="error", title=Config.Localess.Garage.error or "Error", description=Config.Localess.Garage.no_spawn_points_available})
        cb({success = false})
    end
end)

-- 4. HANDLE RETURN CALLBACK
RegisterNUICallback('client:returnVehicle', function(data, cb)
    -- SetNuiFocus(false, false)  <-- This was causing the "Hang"

    -- 1. Normalize the plate coming from the UI/Database
    local targetPlate = NormalizePlate(data.plate)
    Client.Debug("[DEBUG] Attempting to return Normalized Plate: " .. targetPlate)
    
    -- Find and delete the physical entity
    local gameVehicles = GetGamePool('CVehicle')
    local deleted = false
    
    for _, veh in ipairs(gameVehicles) do
        -- 2. Get the plate from the physical entity
        local rawVehPlate = GetVehicleNumberPlateText(veh)
        
        -- 3. Normalize the physical entity's plate
        local currentEntityPlate = NormalizePlate(rawVehPlate)
        
        -- Client.Debug"[DEBUG] Checking: " .. currentEntityPlate .. " vs Target: " .. targetPlate) -- Uncomment if still failing
        
        if currentEntityPlate == targetPlate then
            -- Check distance using Config.Garage.ReturnRadius
            local ped = PlayerPedId()
            local distance = #(GetEntityCoords(ped) - GetEntityCoords(veh))
            if distance > Config.Garage.ReturnRadius then
                CRUX.Notify({
                    title = Config.Localess.Garage.too_far or "Too Far",
                    type = "error",
                    duration = 5000,
                })
                cb({success = false})
                return
            end
            
            -- Get Network ID before deleting
            local netId = NetworkGetNetworkIdFromEntity(veh)
            
            -- Ask Server to delete it (Guaranteed)
            TriggerServerEvent(Config.ResourceName .. ":Server:ForceDeleteVehicle", netId)
            
            deleted = true
            break
        end
    end
    
    -- Always remove from DB, even if not found locally (handles remote returns)
    TriggerServerEvent(Config.ResourceName .. ":Server:ProcessVehicleReturn", targetPlate)
    
    -- The callback just tells React it's done
    if deleted then
        CRUX.Notify({type="success", title=Config.Localess.System.success or "Success", description=Config.Localess.Garage.vehicle_returned_parked})
        cb({success = true})
    else
        -- Vehicle wasn't found nearby (maybe despawned or remote), but we still removed it from DB.
        Client.Debug("[DEBUG] Vehicle not found in pool (Remote Return)")
        CRUX.Notify({type="success", title=Config.Localess.System.success or "Success", description=Config.Localess.Garage.vehicle_processed_remote})
        cb({success = true})
    end
end)

-- Add callback to handle menu close from UI
RegisterNUICallback('closeGarageReturnMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb({})
end)