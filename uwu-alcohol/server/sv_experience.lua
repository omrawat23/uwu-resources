
-- Function to check if a player should be promoted based on experience
local function CheckForPromotion(playerId)
    -- Skip if system is disabled
    if not Config.Experience or not Config.Experience.Enabled then
        return false
    end

    local playerIdentifier = CRUX.Framework.GetIdentifier(playerId)
    if not playerIdentifier then return false end

    -- Get player's current job
    local currentJob = JobSystem.GetJob(playerId)
    if not currentJob or currentJob.name ~= Config.JobName then return false end

    -- Get current grade as a number
    local currentGrade = tonumber(currentJob.grade) or 0

    -- Don't proceed if player already at or above max auto grade
    if currentGrade >= Config.Experience.MaxAutoGrade then
        return false
    end

    -- Get player's current experience from database
    local result = MySQL.query.await('SELECT experience FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
        {playerIdentifier, Config.JobName})

    if not result or #result == 0 then return false end

    local currentExp = tonumber(result[1].experience) or 0

    -- Find the next grade the player should be promoted to
    local nextGrade = nil
    local nextGradeThreshold = nil

    -- Check each grade to find the appropriate promotion
    for gradeId, gradeInfo in pairs(Config.Grades) do
        local grade = tonumber(gradeId)
        local threshold = gradeInfo.Experience or 0

        -- If player has enough XP for this grade and it's higher than current but not too high
        if grade > currentGrade
           and grade <= Config.Experience.MaxAutoGrade
           and currentExp >= threshold
           and (nextGrade == nil or grade < nextGrade) then
            nextGrade = grade
            nextGradeThreshold = threshold
        end
    end

    -- If a valid next grade was found, promote the player
    if nextGrade and nextGradeThreshold and currentExp >= nextGradeThreshold then
        -- Get grade label for notifications
        local gradeLabel = "next position"
        if Config.Grades[tostring(nextGrade)] then
            gradeLabel = Config.Grades[tostring(nextGrade)].Label
        end

        Server.Debug("^2[PROMOTION]^7 Player " .. CRUX.Framework.GetPlayerName(playerId) .. " is eligible for promotion to grade " .. nextGrade .. " (" .. gradeLabel .. ")")

        -- Use SetJob instead of SetGrade - same job, new grade
        local success = JobSystem.SetJob(playerId, currentJob.name, nextGrade)

        if success then
            -- Update the employee record in database as well
            MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET job_grade = ? WHERE license = ? AND job = ?',
                {nextGrade, playerIdentifier, Config.JobName})

            -- Send notification if enabled
            if Config.Experience.Notifications and Config.Experience.Notifications.Enabled then
                CRUX.Notify(playerId, {
                    title = Config.Experience.Notifications.Title or "Promotion",
                    description = "Congratulations! You've been promoted to " .. gradeLabel .. "!",
                    type = Config.Experience.Notifications.Type or "success",
                    duration = Config.Experience.Notifications.Duration or 7500,
                })
            end

            Server.Debug("^2[PROMOTION]^7 Player " .. CRUX.Framework.GetPlayerName(playerId) .. " promoted to grade " .. nextGrade .. " (" .. gradeLabel .. ")")
            return true, nextGrade, gradeLabel
        end
    end

    return false
end

-- Event handler for when experience is earned
RegisterNetEvent(Config.ResourceName .. ':server:experienceEarned')
AddEventHandler(Config.ResourceName .. ':server:experienceEarned', function(playerId, amount)
    -- Check for promotion when XP is gained
    CheckForPromotion(playerId)
end)

-- Background thread to periodically check for promotions
Citizen.CreateThread(function()
    while true do
        if Config.Experience and Config.Experience.Enabled then
            -- Wait 5 minutes between checks
            Citizen.Wait(5 * 60 * 1000)

            -- Check all online players with this job
            local players = GetPlayers()
            for _, playerIdStr in ipairs(players) do
                local playerId = tonumber(playerIdStr)
                local playerJob = JobSystem.GetJob(playerId)

                if playerJob and playerJob.name == Config.JobName then
                    -- Check if player is eligible for promotion
                    CheckForPromotion(playerId)
                end
            end
        else
            -- If disabled, check less frequently (1 hour)
            Citizen.Wait(60 * 60 * 1000)
        end
    end
end)

-- Export functions for other resources
exports('CheckForPromotion', CheckForPromotion)
