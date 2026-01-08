if not Config.EnableUwuCats then return end

-- Helper function to ensure stress stays within 0-100
local function updateMetadata(current, change)
    -- math.max(0, ...) ensures it doesn't go below 0
    -- math.min(100, ...) ensures it doesn't go above 100
    local result = math.max(0, math.min(100, current + change))
    return result
end

RegisterNetEvent('crux:reduceStress')
AddEventHandler('crux:reduceStress', function()
    local src = source
    local stress = CRUX.Framework.GetMetaData(src, 'stress')

    -- Initialize if nil
    if stress == nil then
        stress = 0
        CRUX.Framework.SetMetaData(src, 'stress', 0)
    end

    -- Calculate new stress level
    local newStress = updateMetadata(stress, -Config.StressReduction)

    -- Don't do unnecessary updates if stress is already 0
    if stress > 0 then
        CRUX.Framework.SetMetaData(src, 'stress', newStress)
        
        -- Update the HUD
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
        
        -- Optional: Notification
        -- TriggerClientEvent('crux:notify', src, "You feel relaxed after petting the cat.", "success")
    end
end)