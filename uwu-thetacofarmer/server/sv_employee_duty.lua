-- Employee duty status tracking system
Wait(5000)

-- Table to track employee duty status - key is license, value is duty status
local employeeDutyStatus = {}
local onDutyEmployees = {} -- Tracks which employees are on duty, indexed by job name

-- Initialize module tables
Citizen.CreateThread(function()
    Wait(1000) -- Small delay to ensure database is ready

    -- Set up on duty cache structure by job
    onDutyEmployees[Config.JobName] = {}

    -- Fetch initial duty status for all online players
    for _, playerId in ipairs(GetPlayers()) do
        local src = tonumber(playerId)
        if src then
            local playerJob = JobSystem.GetJob(src)
            local playerIdentifier = CRUX.Framework.GetIdentifier(src)

            if playerJob and playerIdentifier and playerJob.name == Config.JobName then
                employeeDutyStatus[playerIdentifier] = playerJob.onduty

                -- Add to on-duty cache if on duty
                if playerJob.onduty then
                    onDutyEmployees[Config.JobName][playerIdentifier] = true
                end

                Server.Debug("Initialized duty status for " .. GetPlayerName(src) .. ": " .. tostring(playerJob.onduty))
            end
        end
    end
end)

-- Listen for duty status changes
AddEventHandler(Config.ResourceName .. ':server:dutyStatusChanged', function(playerId, isOnDuty)
    local playerIdentifier = CRUX.Framework.GetIdentifier(playerId)
    local playerJob = JobSystem.GetJob(playerId)

    if playerIdentifier and playerJob then
        -- Store duty status
        employeeDutyStatus[playerIdentifier] = isOnDuty

        -- Update the on-duty cache
        if playerJob.name == Config.JobName then
            if isOnDuty then
                onDutyEmployees[Config.JobName][playerIdentifier] = true
            else
                onDutyEmployees[Config.JobName][playerIdentifier] = nil
            end

            -- Broadcast duty status update to all clients
            TriggerClientEvent(Config.ResourceName .. ':client:employeeDutyStatusChanged', -1, {
                license = playerIdentifier,
                isOnDuty = isOnDuty
            })

            Server.Debug("Duty status changed for " .. GetPlayerName(playerId) .. ": " .. tostring(isOnDuty))
        end
    end
end)

-- Override the existing duty toggle event to also trigger our custom event
-- Intercept and forward the duty toggle event to update our tracking
local originalToggleDuty = JobSystem.ToggleDuty
JobSystem.ToggleDuty = function(playerId)
    -- Call original function
    local success = originalToggleDuty(playerId)

    if success then
        -- Get updated status and trigger our event
        local playerJob = JobSystem.GetJob(playerId)
        if playerJob then
            TriggerEvent(Config.ResourceName .. ':server:dutyStatusChanged', playerId, playerJob.onduty)
        end
    end

    return success
end

-- Handle player connections
AddEventHandler('playerJoined', function()
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)
    local playerJob = JobSystem.GetJob(src)

    -- Only set duty status for employees of our job
    if playerIdentifier and playerJob and playerJob.name == Config.JobName then
        employeeDutyStatus[playerIdentifier] = playerJob.onduty

        if playerJob.onduty then
            onDutyEmployees[Config.JobName][playerIdentifier] = true
        end

        -- Broadcast duty status to all clients
        TriggerClientEvent(Config.ResourceName .. ':client:employeeDutyStatusChanged', -1, {
            license = playerIdentifier,
            isOnDuty = playerJob.onduty
        })
    end
end)

-- Handle player disconnections
AddEventHandler('playerDropped', function()
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    if playerIdentifier then
        -- Keep the duty status in case they rejoin, but remove from on-duty cache
        if onDutyEmployees[Config.JobName] then
            onDutyEmployees[Config.JobName][playerIdentifier] = nil
        end
    end
end)

-- Event to request duty status for multiple employees
RegisterNetEvent(Config.ResourceName .. ':server:requestEmployeeDutyStatus')
AddEventHandler(Config.ResourceName .. ':server:requestEmployeeDutyStatus', function(licenses)
    local src = source
    local statuses = {}

    if licenses and type(licenses) == 'table' then
        for _, license in ipairs(licenses) do
            statuses[license] = employeeDutyStatus[license] or false
        end
    end

    TriggerClientEvent(Config.ResourceName .. ':client:receiveEmployeeDutyStatus', src, statuses)
end)

-- Function to get all on-duty employees for a job
local function GetOnDutyEmployees(jobName)
    local result = {}

    if onDutyEmployees[jobName] then
        for license, _ in pairs(onDutyEmployees[jobName]) do
            table.insert(result, license)
        end
    end

    return result
end

-- Event to get all on-duty employees for a job
RegisterNetEvent(Config.ResourceName .. ':server:getOnDutyEmployees')
AddEventHandler(Config.ResourceName .. ':server:getOnDutyEmployees', function(jobName)
    local src = source
    local employees = GetOnDutyEmployees(jobName or Config.JobName)
    TriggerClientEvent(Config.ResourceName .. ':client:receiveOnDutyEmployees', src, employees)
end)

-- Register an event to modify an employee's duty status (for boss menu)
RegisterNetEvent(Config.ResourceName .. ':server:setEmployeeDutyStatus')
AddEventHandler(Config.ResourceName .. ':server:setEmployeeDutyStatus', function(employeeLicense, isOnDuty)
    local src = source
    local playerJob = JobSystem.GetJob(src)

    -- Only allow bosses to set duty status
    if not playerJob or playerJob.name ~= Config.JobName or not IsPlayerBoss(src) then
        CRUX.Notify(src, {
            title = Config.Localess.System.error,
            description = Config.Localess.Duty.no_permission_manage_duty or "You don't have permission to manage employee duty status",
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Find the employee's server ID by license
    local targetId = nil
    for _, playerId in ipairs(GetPlayers()) do
        local playerIdentifier = CRUX.Framework.GetIdentifier(tonumber(playerId))
        if playerIdentifier == employeeLicense then
            targetId = tonumber(playerId)
            break
        end
    end

    -- If the player is online, toggle their duty directly
    if targetId then
        local targetJob = JobSystem.GetJob(targetId)
        if targetJob and targetJob.name == Config.JobName and targetJob.onduty ~= isOnDuty then
            -- Toggle duty for the target player
            JobSystem.SetJobDuty(targetId, isOnDuty)

            -- Notify the player their duty status was changed
            CRUX.Notify(targetId, {
                title = Config.Localess.Duty.status,
                description = string.format(Config.Localess.Duty.duty_set_by_management or "Your duty status was set to %s by management", isOnDuty and "ON" or "OFF"),
                type = "info",
                duration = 5000,
            })

            -- Notify the boss
            CRUX.Notify(src, {
                title = Config.Localess.Duty.management,
                description = string.format(Config.Localess.Duty.duty_management_success or "Successfully set %s's duty status to %s", GetPlayerName(targetId), isOnDuty and "ON" or "OFF"),
                type = "success",
                duration = 5000,
            })
        else
            CRUX.Notify(src, {
                title = Config.Localess.System.error,
                description = Config.Localess.Duty.not_employee_of_job or "Player is not an employee of this job",
                type = "error",
                duration = 5000,
            })
        end
    else
        -- Player is offline, just update our cache and database
        employeeDutyStatus[employeeLicense] = isOnDuty

        if isOnDuty then
            onDutyEmployees[Config.JobName][employeeLicense] = true
        else
            onDutyEmployees[Config.JobName][employeeLicense] = nil
        end

        -- Update the database to reflect the new duty status (offline player)
        MySQL.update('UPDATE ' .. tablePrefix .. 'employee_duty SET is_onduty = ? WHERE license = ? AND job = ?',
            {isOnDuty, employeeLicense, Config.JobName})

        -- Broadcast the duty status change to all clients
        TriggerClientEvent(Config.ResourceName .. ':client:employeeDutyStatusChanged', -1, {
            license = employeeLicense,
            isOnDuty = isOnDuty
        })

        CRUX.Notify(src, {
            title = Config.Localess.Duty.management,
            description = Config.Localess.Duty.updated_offline_employee or "Updated offline employee's duty status",
            type = "success",
            duration = 5000,
        })
    end
end)

-- Export to check if a player is on duty
exports('IsEmployeeOnDuty', function(license)
    return employeeDutyStatus[license] or false
end)
