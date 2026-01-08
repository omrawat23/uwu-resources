-- Get list of vehicles the player has spawned
RegisterNetEvent(Config.ResourceName .. ':Server:GetActiveVehicles', function()
    local src = source
    local Player = CRUX.Framework.GetPlayer(src)
    if not Player then return end
    
    local citizenid = CRUX.Framework.GetPlayerCitizenId(src)
    
    MySQL.Async.fetchAll('SELECT * FROM ' .. tablePrefix .. 'player_job_vehicles WHERE citizenid = ?', {citizenid}, function(result)
        TriggerClientEvent(Config.ResourceName .. ':Client:OpenReturnMenu', src, result or {})
    end)
end)

-- Log a new spawn
RegisterNetEvent(Config.ResourceName .. ':Server:LogVehicleSpawn', function(model, plate, label)
    local src = source
    local Player = CRUX.Framework.GetPlayer(src)
    if not Player then return end
    
    local cleanPlate = NormalizePlate(plate)
    
    MySQL.Async.execute('INSERT INTO ' .. tablePrefix .. 'player_job_vehicles (citizenid, plate, model, label) VALUES (?, ?, ?, ?)', {
        CRUX.Framework.GetPlayerCitizenId(src), cleanPlate, model, label
    })
end)

-- Process return (Delete from DB)
RegisterNetEvent(Config.ResourceName .. ':Server:ProcessVehicleReturn', function(plate)
    local src = source
    local Player = CRUX.Framework.GetPlayer(src)
    if not Player then return end
    
    -- Normalize purely to be safe, though client should have sent it clean
    local cleanPlate = string.upper(string.gsub(plate, "[^%w]", ""))
    
    MySQL.Async.execute('DELETE FROM ' .. tablePrefix .. 'player_job_vehicles WHERE plate = ? AND citizenid = ?', {
        cleanPlate, CRUX.Framework.GetPlayerCitizenId(src)
    })
end)


RegisterNetEvent(Config.ResourceName .. ':Server:ForceDeleteVehicle', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    end
end)

-- Helper to strip spaces and symbols for comparison
function NormalizePlate(plate)
    if not plate then return "" end
    return string.upper(string.gsub(plate, "[^%w]", ""))
end


-- On resource start, clear DB table and delete any leftover vehicles
AddEventHandler('onResourceStart', function(resourceName)
    -- ensure this runs only for this resource
    if resourceName ~= GetCurrentResourceName() then return end

    -- First check that the table exists to avoid SQL errors
    local targetTable = tablePrefix .. 'player_job_vehicles'
    MySQL.Async.fetchAll('SHOW TABLES LIKE ?', { targetTable }, function(tblResult)
        if not tblResult or #tblResult == 0 then
            Server.Debug(('[%s] Table %s not found; skipping vehicle cleanup.'):format(GetCurrentResourceName(), targetTable))
            return
        end

        -- Table exists, proceed with original cleanup logic
        MySQL.Async.fetchAll('SELECT plate FROM ' .. targetTable, {}, function(result)
            if result and #result > 0 then
                local platesToDelete = {}
                for _, row in ipairs(result) do
                    table.insert(platesToDelete, NormalizePlate(row.plate))
                end
                
                -- Get all vehicles in the world
                local vehicles = GetAllVehicles()
                for _, vehicle in ipairs(vehicles) do
                    if DoesEntityExist(vehicle) then
                        local vehPlate = GetVehicleNumberPlateText(vehicle)
                        local normVehPlate = NormalizePlate(vehPlate)
                        for _, dbPlate in ipairs(platesToDelete) do
                            if normVehPlate == dbPlate then
                                DeleteEntity(vehicle)
                                break
                            end
                        end
                    end
                end
            end
            
            -- Clear the entire table
            MySQL.Async.execute('DELETE FROM ' .. targetTable, {})
        end)
    end)
end)