Wait(5000)

-- Global door state storage
local globalDoorStates = {}

CreateThread(function()
    if not cPreset or not cPreset.EnableDoorLock or not cPreset.doors then
        return
    end

    for i, door in pairs(cPreset.doors) do
        -- Always initialize as locked on server start
        globalDoorStates[i] = true
        
        -- Save/update locked state to DB
        MySQL.insert('INSERT INTO ' .. tablePrefix .. 'door_states (door_index, is_locked) VALUES (?, ?) ON DUPLICATE KEY UPDATE is_locked = VALUES(is_locked)', {i, true})
        
        Server.Debug("^2[DOOR]^7 Door " .. i .. " initialized as locked")
    end
end)

-- Client requests initial door states
RegisterNetEvent(Config.ResourceName .. ':server:requestDoorStates', function()
    local src = source
    TriggerClientEvent(Config.ResourceName .. ':client:syncDoorStates', src, globalDoorStates)
end)

-- Client toggles a door
RegisterNetEvent(Config.ResourceName .. ':server:toggleDoor', function(doorIndex)
    local src = source
    
    if globalDoorStates[doorIndex] == nil then
        Server.Debug("^1[DOOR ERROR]^7 Invalid door index: " .. tostring(doorIndex))
        return
    end

    -- Toggle the state
    local newState = not globalDoorStates[doorIndex]
    globalDoorStates[doorIndex] = newState
    
    -- Save to DB
    local success = MySQL.update.await('UPDATE ' .. tablePrefix .. 'door_states SET is_locked = ? WHERE door_index = ?', {newState, doorIndex})
    
    if not success or success == 0 then
        -- If update failed, try insert
        MySQL.insert('INSERT INTO ' .. tablePrefix .. 'door_states (door_index, is_locked) VALUES (?, ?) ON DUPLICATE KEY UPDATE is_locked = VALUES(is_locked)', {doorIndex, newState})
    end
    
    Server.Debug("^2[DOOR]^7 Door " .. doorIndex .. " toggled to " .. (newState and "locked" or "unlocked") .. " by player " .. src)
    
    -- Sync door state to all clients (without notification/sound)
    TriggerClientEvent(Config.ResourceName .. ':client:updateDoorState', -1, doorIndex, newState)
    
    -- -- Send notification and sound only to the player who toggled it
    TriggerClientEvent(Config.ResourceName .. ':client:doorToggleFeedback', src, doorIndex, newState)
end)
