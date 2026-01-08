-- local function spawnVehicle(modelName)
--     local modelHash = GetHashKey(modelName)

--     -- Request the vehicle model
--     RequestModel(modelHash)
--     while not HasModelLoaded(modelHash) do
--         Wait(500)
--     end

--     -- Get the player's ped and position
--     local ped = PlayerPedId()
--     local spawnPos = GetEntityCoords(ped)
--     local heading = GetEntityHeading(ped)

--     -- Create the vehicle
--     local vehicle = CreateVehicle(modelHash, spawnPos.x, spawnPos.y, spawnPos.z, heading, true, false)
--     if not vehicle or not DoesEntityExist(vehicle) then
--         print("Failed to create vehicle.")
--         SetModelAsNoLongerNeeded(modelHash)
--         return nil
--     end

--     -- Set a unique plate to avoid key conflicts (mk_vehiclekeys uses plates for key management)
--     local uniquePlate = "SPWN" .. tostring(math.random(1000, 9999))
--     SetVehicleNumberPlateText(vehicle, uniquePlate)

--     SetVehicleOnGroundProperly(vehicle)
--     SetEntityAsMissionEntity(vehicle, true, true)
--     SetModelAsNoLongerNeeded(modelHash)
--     TaskWarpPedIntoVehicle(ped, vehicle, -1)

--     -- Ensure network ownership for key export if needed (guard against missing natives on some clients)
--     local netId = NetworkGetNetworkIdFromEntity(vehicle)
--     if type(NetworkSetNetworkIdCanMigrate) == "function" then
--         NetworkSetNetworkIdCanMigrate(netId, true)
--     elseif type(SetNetworkIdCanMigrate) == "function" then
--         -- some runtimes expose a differently named native
--         SetNetworkIdCanMigrate(netId, true)
--     end

--     return vehicle
-- end

-- RegisterCommand("spawnveh", function(source, args, raw)
--     local model = args[1] or "adder"
--     local veh = spawnVehicle(model)
--     if not veh then
--         print("Vehicle spawn failed.")
--         return
--     end

--     -- Check if player already has keys for this vehicle using mk_vehiclekeys export
--     local okHas, hasKey = pcall(function()
--         return exports["mk_vehiclekeys"]:HasKey(veh)
--     end)
--     if okHas and hasKey then
--         print("Spawned " .. model .. ". You already have the keys for this vehicle.")
--         return
--     end

--     -- Give keys using mk_vehiclekeys export (the export expects the vehicle entity)
--     local okAdd, err = pcall(function()
--         exports["mk_vehiclekeys"]:AddKey(veh)
--     end)
--     if okAdd then
--         -- Wait briefly for key registration to complete (avoids verification failure due to async behavior)
--         Wait(500)
--         -- Verify keys were added
--         local okVerify, verifyHasKey = pcall(function()
--             return exports["mk_vehiclekeys"]:HasKey(veh)
--         end)
--         if okVerify and verifyHasKey then
--             print("Spawned " .. model .. " and added keys.")
--         else
--             print("Spawned " .. model .. ". Attempted to add keys but verification failed.")
--         end
--     else
--         print("Spawned vehicle, but failed to add keys: " .. tostring(err))
--     end
-- end, false)