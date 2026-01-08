JobSystem = {}
JobSystem.PlayerJobs = {} -- Cache of player jobs: {[source] = {job = X, grade = Y, onduty = Z}}

-- Improved admin check function using FiveM's ACL system
function IsPlayerAdmin(playerId)
    -- Console (source = 0) is always considered admin
    if playerId == 0 then
        return true
    end

    -- Use configured admin permissions if provided, otherwise fall back to sensible defaults
    local adminPermissions
    if Config and type(Config.adminPermissions) == "table" and next(Config.adminPermissions) ~= nil then
        adminPermissions = Config.adminPermissions
    else
        adminPermissions = {
            "command.jobadmin",  -- Specific permission for job system
            "command.admin",     -- Common admin permission
            "admin",             -- Standard admin identifier
            "god",               -- Common god-mode/superadmin permission
            "group.admin"        -- Group-based admin permission
        }
    end

    -- Check if player has any of the admin permissions
    for _, permission in ipairs(adminPermissions) do
        if IsPlayerAceAllowed(playerId, permission) then
            return true
        end
    end

    -- Not an admin
    return false
end

-- Initialize job system by loading jobs from Config
JobSystem.Initialize = function()
    Wait(5000) -- Ensure DB tables are loaded before SQL operations
    Server.Debug("Initializing Job System...")

    -- Insert 'unemployed' job if it doesn't exist
    MySQL.query("SELECT * FROM " .. tablePrefix .. "jobs WHERE name = ?", {"unemployed"}, function(result)
        if not result or #result == 0 then
            MySQL.insert("INSERT INTO " .. tablePrefix .. "jobs (name, label, default_duty) VALUES (?, ?, ?)",
                {"unemployed", "Unemployed", true})
            Server.Debug("Created job: unemployed")
        end

        -- Check if unemployed job grade exists
        MySQL.query("SELECT * FROM " .. tablePrefix .. "job_grades WHERE job_name = ? AND grade = ?", {"unemployed", 0}, function(gradeResult)
            if not gradeResult or #gradeResult == 0 then
                -- Create default grade
                MySQL.insert("INSERT INTO " .. tablePrefix .. "job_grades (job_name, grade, name, label, salary) VALUES (?, ?, ?, ?, ?)",
                    {"unemployed", 0, "unemployed", "Unemployed", 0})
                Server.Debug("Created job grade: Unemployed for unemployed")
            else
                Server.Debug("Verified unemployed job grade exists")
            end
        end)
    end)

    -- Insert Config.JobName into jobs table if it doesn't exist
    MySQL.query("SELECT * FROM " .. tablePrefix .. "jobs WHERE name = ?", {Config.JobName}, function(result)
        if not result or #result == 0 then
            MySQL.insert("INSERT INTO " .. tablePrefix .. "jobs (name, label) VALUES (?, ?)", {Config.JobName, Config.JobLabel})
            Server.Debug("Created job: " .. Config.JobName)
        end
    end)

    -- Check if job has any grades in the database
    MySQL.query("SELECT COUNT(*) as gradeCount FROM " .. tablePrefix .. "job_grades WHERE job_name = ?", {Config.JobName}, function(result)
        local gradeCount = 0
        if result and #result > 0 then
            gradeCount = result[1].gradeCount
        end

        if gradeCount == 0 then
            -- No grades exist for this job, insert all from Config
            Server.Debug("No grades found for " .. Config.JobName .. ", adding all grades from Config")
            for gradeId, gradeInfo in pairs(Config.Grades) do
                MySQL.insert("INSERT INTO " .. tablePrefix .. "job_grades (job_name, grade, name, label, salary, commission, is_boss) VALUES (?, ?, ?, ?, ?, ?, ?)",
                    {Config.JobName, tonumber(gradeId), string.lower(gradeInfo.Label:gsub("%s+", "")), gradeInfo.Label,
                    gradeInfo.Salary, gradeInfo.Commission or 0, gradeInfo.IsBoss or false})
                Server.Debug("Created job grade: " .. gradeInfo.Label .. " for " .. Config.JobName)
            end
        else
            -- Grades exist, only insert missing grades
            Server.Debug("Found " .. gradeCount .. " existing grades for " .. Config.JobName .. ", only adding missing grades")
            for gradeId, gradeInfo in pairs(Config.Grades) do
                MySQL.query("SELECT * FROM " .. tablePrefix .. "job_grades WHERE job_name = ? AND grade = ?",
                    {Config.JobName, tonumber(gradeId)}, function(result)

                    if not result or #result == 0 then
                        -- This grade doesn't exist, insert it
                        MySQL.insert("INSERT INTO " .. tablePrefix .. "job_grades (job_name, grade, name, label, salary, commission, is_boss) VALUES (?, ?, ?, ?, ?, ?, ?)",
                            {Config.JobName, tonumber(gradeId), string.lower(gradeInfo.Label:gsub("%s+", "")), gradeInfo.Label,
                            gradeInfo.Salary, gradeInfo.Commission or 0, gradeInfo.IsBoss or false})
                        Server.Debug("Added missing job grade: " .. gradeInfo.Label .. " for " .. Config.JobName)
                    else
                        -- Grade already exists, don't update it
                        Server.Debug("Preserving existing job grade: " .. result[1].label .. " (grade " .. gradeId .. ") for " .. Config.JobName)
                    end
                end)
            end

            -- Check for grades in database that are no longer in Config
            MySQL.query("SELECT * FROM " .. tablePrefix .. "job_grades WHERE job_name = ?", {Config.JobName}, function(existingGrades)
                if existingGrades and #existingGrades > 0 then
                    -- Create a lookup table of valid grades from Config
                    local validGrades = {}
                    for gradeId, _ in pairs(Config.Grades) do
                        validGrades[tonumber(gradeId)] = true
                    end

                    -- Check if any existing grades are no longer in Config
                    for _, gradeData in ipairs(existingGrades) do
                        local gradeNumber = tonumber(gradeData.grade)
                        if not validGrades[gradeNumber] then
                            -- This grade exists in DB but not in Config, remove it
                            MySQL.update("DELETE FROM " .. tablePrefix .. "job_grades WHERE job_name = ? AND grade = ?",
                                {Config.JobName, gradeNumber})
                            Server.Debug("Removed outdated job grade: " .. gradeData.label .. " (grade " .. gradeNumber .. ") from " .. Config.JobName)

                            -- Check for employees using this grade and demote them to grade 1 (or lowest available)
                            MySQL.query("SELECT COUNT(*) as count FROM " .. tablePrefix .. "user_jobs WHERE job = ? AND grade = ?",
                                {Config.JobName, gradeNumber}, function(usersResult)
                                if usersResult and usersResult[1].count > 0 then
                                    -- Find lowest available grade
                                    local lowestGrade = 999
                                    for gradeId, _ in pairs(Config.Grades) do
                                        local grade = tonumber(gradeId)
                                        if grade < lowestGrade then
                                            lowestGrade = grade
                                        end
                                    end

                                    -- Demote users
                                    MySQL.update("UPDATE " .. tablePrefix .. "user_jobs SET grade = ? WHERE job = ? AND grade = ?",
                                        {lowestGrade, Config.JobName, gradeNumber})
                                    Server.Debug("Demoted " .. usersResult[1].count .. " employees from removed grade " ..
                                        gradeNumber .. " to grade " .. lowestGrade)
                                end
                            end)
                        end
                    end
                end
            end)
        end
    end)
end

-- Get a player's job information
JobSystem.GetJob = function(source)
    Wait(5000) -- Ensure DB tables are loaded before SQL operations
    if not source then return nil end
    local src = tonumber(source)

    -- Check if we have the job cached
    if JobSystem.PlayerJobs[src] then
        return JobSystem.PlayerJobs[src]
    end

    -- Not in cache, get from database
    local identifier = CRUX.Framework.GetIdentifier(src)
    if not identifier then return nil end

    local job = {
        name = "unemployed",
        label = "Unemployed",
        grade = 0,
        onduty = false
    }

    -- Query job from database - Fix the MySQL.sync issue
    local result = MySQL.Sync.fetchAll("SELECT * FROM " .. tablePrefix .. "user_jobs WHERE identifier = ?", {identifier})
    if result and #result > 0 then
        -- Get job details
        local jobName = result[1].job
        local jobGrade = result[1].grade

        -- Get job label - Fix MySQL.sync issue
        local jobResult = MySQL.Sync.fetchAll("SELECT * FROM " .. tablePrefix .. "jobs WHERE name = ?", {jobName})
        if jobResult and #jobResult > 0 then
            job.name = jobName
            job.label = jobResult[1].label
        end

        -- Get grade details - Fix MySQL.sync issue
        local gradeResult = MySQL.Sync.fetchAll("SELECT * FROM " .. tablePrefix .. "job_grades WHERE job_name = ? AND grade = ?", {jobName, jobGrade})
        if gradeResult and #gradeResult > 0 then
            job.grade = jobGrade
            job.grade_name = gradeResult[1].name
            job.grade_label = gradeResult[1].label
            job.salary = gradeResult[1].salary
            job.is_boss = gradeResult[1].is_boss 
        end

        job.onduty = result[1].onduty == 1
    end

    -- Cache the job
    JobSystem.PlayerJobs[src] = job

    return job
end

-- Set a player's job
JobSystem.SetJob = function(source, jobName, grade)
    Wait(5000) -- Ensure DB tables are loaded before SQL operations
    if not source then return false end
    local src = tonumber(source)
    local identifier = CRUX.Framework.GetIdentifier(src)
    if not identifier then return false end

    -- Validate job and grade
    local jobResult = MySQL.Sync.fetchAll("SELECT * FROM " .. tablePrefix .. "jobs WHERE name = ?", {jobName})
    if not jobResult or #jobResult == 0 then
        Server.Debug("Job not found: " .. jobName)
        return false
    end

    -- Check if grade exists for job
    local gradeResult = MySQL.Sync.fetchAll("SELECT * FROM " .. tablePrefix .. "job_grades WHERE job_name = ? AND grade = ?", {jobName, grade})
    if not gradeResult or #gradeResult == 0 then
        Server.Debug("Grade not found: " .. grade .. " for job " .. jobName)
        return false
    end

    -- Check if player already has a job record
    local playerJobResult = MySQL.Sync.fetchAll("SELECT * FROM " .. tablePrefix .. "user_jobs WHERE identifier = ?", {identifier})

    -- Set default duty status (usually true for first assignment, or keep existing if updating)
    local defaultDuty = jobResult[1].default_duty
    if defaultDuty == nil then defaultDuty = true end

    if playerJobResult and #playerJobResult > 0 then
        -- Update existing record - UPDATE BOTH THE JOB AND GRADE
        local result = MySQL.update("UPDATE " .. tablePrefix .. "user_jobs SET job = ?, grade = ? WHERE identifier = ?",
            {jobName, grade, identifier})

        -- Server.Debug for debugging
        Server.Debug("Updated job for " .. GetPlayerName(src) .. ": " .. jobName .. " grade " .. grade ..
            " (Rows affected: " .. tostring(result) .. ")")
    else
        -- Insert new record - MAKE SURE TO INCLUDE ALL REQUIRED FIELDS
        local result = MySQL.insert("INSERT INTO " .. tablePrefix .. "user_jobs (identifier, job, grade, onduty) VALUES (?, ?, ?, ?)",
            {identifier, jobName, grade, defaultDuty})

        -- Server.Debug for debugging
        Server.Debug("Inserted new job for " .. GetPlayerName(src) .. ": " .. jobName .. " grade " .. grade ..
            " (Insert ID: " .. tostring(result) .. ")")
    end

    -- Update cache
    JobSystem.PlayerJobs[src] = {
        name = jobName,
        label = jobResult[1].label,
        grade = grade,
        grade_name = gradeResult[1].name,
        grade_label = gradeResult[1].label,
        salary = gradeResult[1].salary,
        is_boss = gradeResult[1].is_boss,
        onduty = defaultDuty
    }

    -- Notify client
    TriggerClientEvent(Config.ResourceName .. ':client:jobChanged', src, JobSystem.PlayerJobs[src])

    return true
end

-- Add player timers for paychecks
JobSystem.PlayerTimers = {} -- Store player paycheck timers: {[source] = timeRemaining}

-- Toggle duty status
JobSystem.SetJobDuty = function(source, dutyStatus)
    if not source then return false end

    local playerJob = JobSystem.PlayerJobs[source]
    if not playerJob then return false end

    playerJob.onduty = dutyStatus

    -- Reset the player's paycheck timer when toggling duty status
    -- Only if we're going on duty OR if onlyOnDuty is false
    if dutyStatus or not Config.Salaries.OnlyOnDuty then
        JobSystem.ResetPaycheckTimer(source)
    else
        -- If going off duty and onlyOnDuty is true, pause/stop the timer
        -- by setting it to a very high value or removing it
        if Config.Salaries.OnlyOnDuty then
            JobSystem.PlayerTimers[source] = nil -- Remove the timer
        end
    end

    -- Notify client of duty status change
    TriggerClientEvent(Config.ResourceName .. ':client:dutyStatusUpdated', source, dutyStatus)

    return true
end

-- Reset a player's paycheck timer
JobSystem.ResetPaycheckTimer = function(source, timeRemaining)
    -- Only set a timer if:
    -- 1. onlyOnDuty is false (meaning we track regardless of status) OR
    -- 2. onlyOnDuty is true AND player is on duty
    local playerJob = JobSystem.PlayerJobs[source]
    if not Config.Salaries.OnlyOnDuty or (playerJob and playerJob.onduty) then
        -- Set timer to Config.Salaries.Time in minutes
        local timerInMinutes = Config.Salaries.Time or 1

        -- If custom time provided, use that instead (for mid-cycle duty changes)
        if timeRemaining then
            JobSystem.PlayerTimers[source] = timeRemaining
        else
            -- Otherwise use the full timer
            JobSystem.PlayerTimers[source] = timerInMinutes * 60 -- Convert to seconds
        end

        -- Send updated timer to client
        local formattedTime = string.format("00:%02d:00", timerInMinutes)
        TriggerClientEvent(Config.ResourceName .. ':client:updatePaycheckTimer', source, {
            timeRemaining = formattedTime,
            configuredMinutes = timerInMinutes,
            onlyOnDuty = Config.Salaries.OnlyOnDuty
        })
    else
        -- If player shouldn't be tracking time, remove their timer
        JobSystem.PlayerTimers[source] = nil
    end
end

-- Handle server event to reset paycheck timer
RegisterNetEvent(Config.ResourceName .. ':server:resetPaycheckTimer')
AddEventHandler(Config.ResourceName .. ':server:resetPaycheckTimer', function()
    local src = source
    JobSystem.ResetPaycheckTimer(src)
end)

-- Clear job data when player disconnects
JobSystem.ClearPlayerJob = function(source)
    if not source then return end
    local src = tonumber(source)
    JobSystem.PlayerJobs[src] = nil
end

-- When a player joins, load their job
RegisterNetEvent(Config.ResourceName .. ':server:playerJoined')
AddEventHandler(Config.ResourceName .. ':server:playerJoined', function()
    local src = source
    local jobData = JobSystem.GetJob(src) -- This will cache the job

    -- Notify client about their job (important for persistence)
    if jobData then
        TriggerClientEvent(Config.ResourceName .. ':client:jobChanged', src, jobData)
        Server.Debug("Loaded job for player " .. GetPlayerName(src) .. ": " .. jobData.name .. " (grade " .. jobData.grade .. ")")
    else
        Server.Debug("Failed to load job for player " .. GetPlayerName(src))
    end

    -- Initialize their timer
    JobSystem.ResetPaycheckTimer(src)
end)

-- Add a specific player spawn event to ensure job is loaded after full connection
AddEventHandler('playerSpawned', function()
    local src = source
    Citizen.Wait(1000) -- Wait a bit for the player to be fully loaded
    TriggerEvent(Config.ResourceName .. ':server:playerJoined') -- Reuse the existing event
end)

-- Admin commands for job management
RegisterCommand(Config.JobSystem.Commands.GiveJob, function(source, args)
    Wait(5000) -- Ensure DB tables are loaded before SQL operations
    -- Check if the player has permission to use this command
    if not IsPlayerAdmin(source) then
        CRUX.Notify(source, {
            title = Config.Localess.System.error,
            description = Config.Localess.JobSystem.no_permission,
            type = "error",
            duration = 5000
        })
        return
    end

    -- Check args
    if not args[1] or not args[2] or not args[3] then
        if source > 0 then
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = string.format(Config.Localess.JobSystem.give_job_usage, Config.JobSystem.Commands.GiveJob),
                type = "error",
                duration = 5000
            })
        else
            Server.Debug("Usage: " .. Config.JobSystem.Commands.GiveJob .. " [playerId] [jobName] [grade]")
        end
        return
    end

    -- Parse args
    local targetId = tonumber(args[1])
    local jobName = args[2]
    local grade = tonumber(args[3])

    -- Check if target exists
    if not CRUX.Framework.GetPlayerName(targetId) then
        if source > 0 then
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.JobSystem.player_not_found,
                type = "error",
                duration = 5000
            })
        else
            Server.Debug("Player not found.")
        end
        return
    end

    -- Set job
    local success = JobSystem.SetJob(targetId, jobName, grade)

    if success then
        -- Add to employee table if job name matches Config.JobName
        if jobName == Config.JobName then
            local targetIdentifier = CRUX.Framework.GetIdentifier(targetId)
            local targetName = CRUX.Framework.GetPlayerName(targetId)

            -- Get commission rate based on grade
            local gradeLevel = tostring(grade)
            local commission = 0
            if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
                commission = Config.Grades[gradeLevel].Commission
            end

            -- Query grade information directly from the database to ensure accuracy
            MySQL.query('SELECT * FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? AND grade = ?', {Config.JobName, grade}, function(gradeResult)
                local gradeName = "employee"

                -- Use grade information from database if available
                if gradeResult and #gradeResult > 0 then
                    gradeName = gradeResult[1].name or "employee"
                else
                    -- Fallback to config if not in database
                    if Config.Grades[gradeLevel] then
                        gradeName = string.lower(Config.Grades[gradeLevel].Label:gsub("%s+", ""))
                    end
                end

                -- Check if employee already exists
                MySQL.query('SELECT license FROM ' .. tablePrefix .. 'employees WHERE license = ?', {targetIdentifier}, function(result)
                    if result and #result > 0 then
                        -- Update existing employee record - use job_grade instead of role
                        MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET job = ?, job_grade = ? WHERE license = ?',
                            {Config.JobName, grade, targetIdentifier},
                            function(rowsChanged)
                                if rowsChanged > 0 then
                                    Server.Debug("Updated employee record for " .. targetName)
                                else
                                    Server.Debug("Failed to update employee record")
                                end
                            end
                        )
                    else
                        -- Create new employee record - use job_grade instead of role
                        MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, job, job_grade, experience) VALUES (?, ?, ?, ?, ?)',
                            {targetIdentifier, targetName, Config.JobName, grade, 0},
                            function(id)
                                if id then
                                    Server.Debug("Created employee record for " .. targetName)
                                else
                                    Server.Debug("Failed to create employee record")
                                end
                            end
                        )
                    end
                end)
            end)
        end

        -- Notify source
        -- if source > 0 then
        --     CRUX.Notify(source, {
        --         title = "Success",
        --         description = "Job assigned.",
        --         type = "success",
        --         duration = 5000
        --     })
        -- else
        --     Server.Debug("Job assigned.")
        -- end

        -- Notify target
        CRUX.Notify(targetId, {
            title = Config.Localess.JobSystem.job_changed_notification,
            description = string.format(Config.Localess.JobSystem.job_changed, jobName, grade),
            type = "info",
            duration = 5000
        })
    else
        if source > 0 then
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.JobSystem.job_assign_failed,
                type = "error",
                duration = 5000
            })
        else
            Server.Debug("Failed to assign job.")
        end
    end
end, false)

RegisterCommand(Config.JobSystem.Commands.RemoveJob, function(source, args)
    Wait(5000) -- Ensure DB tables are loaded before SQL operations
    -- Check if the player has permission to use this command
    if not IsPlayerAdmin(source) then
        CRUX.Notify(source, {
            title = Config.Localess.System.error,
            description = Config.Localess.JobSystem.no_permission,
            type = "error",
            duration = 5000
        })
        return
    end

    -- Check args
    if not args[1] then
        if source > 0 then
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = string.format(Config.Localess.JobSystem.remove_job_usage, Config.JobSystem.Commands.RemoveJob),
                type = "error",
                duration = 5000
            })
        else
            Server.Debug("Usage: " .. Config.JobSystem.Commands.RemoveJob .. " [playerId]")
        end
        return
    end

    -- Parse args
    local targetId = tonumber(args[1])

    -- Check if target exists
    if not CRUX.Framework.GetPlayerName(targetId) then
        if source > 0 then
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.JobSystem.player_not_found,
                type = "error",
                duration = 5000
            })
        else
            Server.Debug("Player not found.")
        end
        return
    end

    -- Get the target's current job before changing it
    local currentJob = JobSystem.GetJob(targetId)
    local playerIdentifier = CRUX.Framework.GetIdentifier(targetId)

    -- Set job to unemployed
    local success = JobSystem.SetJob(targetId, "unemployed", 0)

    if success then
        -- If the player was working at our job, remove them from the employee database
        if currentJob and currentJob.name == Config.JobName and playerIdentifier then
            MySQL.update('DELETE FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
                {playerIdentifier, Config.JobName},
                function(rowsChanged)
                    if rowsChanged > 0 then
                        Server.Debug("Removed " .. GetPlayerName(targetId) .. " from employees database")
                    else
                        Server.Debug("No employee record found to remove for " .. GetPlayerName(targetId))
                    end
                end
            )
        end

        -- Notify source
        if source > 0 then
            CRUX.Notify(source, {
                title = Config.Localess.JobSystem.job_changed_notification,
                description = Config.Localess.JobSystem.job_removed,
                type = "success",
                duration = 5000
            })
        else
            Server.Debug("Job removed.")
        end

        -- Notify target
        CRUX.Notify(targetId, {
            title = Config.Localess.JobSystem.job_changed_notification,
            description = Config.Localess.JobSystem.job_removed_notification,
            type = "info",
            duration = 5000
        })
    else
        if source > 0 then
            CRUX.Notify(source, {
                title = Config.Localess.System.error,
                description = Config.Localess.JobSystem.job_remove_failed,
                type = "error",
                duration = 5000
            })
        else
            Server.Debug("Failed to remove job.")
        end
    end
end, false)


RegisterCommand(Config.JobSystem.Commands.CheckJob, function(source)
    -- No SQL operations here, no wait needed
    local src = source
    local job = JobSystem.GetJob(src)

    if job then
        CRUX.Notify(src, {
            title = "Your Job",
            description = string.format(Config.Localess.JobSystem.job_info, job.label, job.grade, job.onduty and "On" or "Off"),
            type = "success",
            duration = 5000
        })
        -- Also Server.Debug to console for better visibility during testing
        -- Server.Debug("Job info for player " .. GetPlayerName(src) .. ": " .. job.label .. " (Grade: " .. job.grade .. ", Duty: " .. (job.onduty and "On" or "Off") .. ")")
    else
        CRUX.Notify(src, {
            title = Config.Localess.System.error,
            description = Config.Localess.JobSystem.job_info_error,
            type = "error",
            duration = 5000
        })
    end
end, false)

-- Paycheck System
JobSystem.PaycheckSystem = {
    initialized = false,

    -- Initialize the paycheck system
    Initialize = function()
        Wait(5000) -- Ensure DB tables are loaded before SQL operations
        if not Config.Salaries.Enable then return end
        if JobSystem.PaycheckSystem.initialized then return end

        Server.Debug("Initializing Paycheck System...")

        -- Server-side automatic paycheck processor
        Citizen.CreateThread(function()
            while true do
                -- Process paychecks for all online players
                JobSystem.PaycheckSystem.ProcessPaychecks()

                -- Wait for the specified interval in minutes (converted to milliseconds)
                Citizen.Wait(Config.Salaries.Time * 60 * 1000)
            end
        end)

        JobSystem.PaycheckSystem.initialized = true
    end,

    -- Process paychecks for all players
    ProcessPaychecks = function()
        Wait(5000) -- Ensure DB tables are loaded before SQL operations
        Server.Debug("Processing paychecks for all online players...")

        -- Get all online players
        local players = GetPlayers()

        for _, playerId in ipairs(players) do
            local src = tonumber(playerId)
            local playerJob = JobSystem.GetJob(src)

            -- Check if player has a job and meets requirements
            if playerJob and playerJob.name ~= "unemployed" then
                -- Check duty status if required - respect OnlyOnDuty setting
                local canReceivePaycheck = true
                if Config.Salaries.OnlyOnDuty and not playerJob.onduty then
                    canReceivePaycheck = false
                    Server.Debug("Player " .. GetPlayerName(src) .. " is not on duty, skipping paycheck")
                end

                if canReceivePaycheck then
                    JobSystem.PaycheckSystem.GivePaycheck(src, playerJob)

                    -- Reset player's paycheck timer
                    JobSystem.ResetPaycheckTimer(src)
                end
            end
        end
    end,

    -- Give paycheck to a specific player
    GivePaycheck = function(src, playerJob)
        Wait(5000) -- Ensure DB tables are loaded before SQL operations

        if not src or not playerJob then return end

        local jobName = playerJob.name
        local jobGrade = playerJob.grade
        local salary = playerJob.salary or 0
        local playerName = CRUX.Framework.GetPlayerName(src)
        local playerIdentifier = CRUX.Framework.GetIdentifier(src)

        if not playerIdentifier or not playerName then return end

        -- Respect SocietyPay setting
        if Config.Salaries.SocietyPay then
            -- Pay from society funds
            MySQL.query('SELECT balance FROM ' .. tablePrefix .. 'bossmenu WHERE id = ?',
                {jobName},
                function(result)
                    if not result or #result == 0 then
                        -- Society not found
                        CRUX.Notify(src, {
                            title = Config.Localess.System.paycheck_error or "Paycheck Error",
                            description = Config.Localess.System.society_not_found or "Business account not found.",
                            type = "error",
                            duration = 5000
                        })
                        return
                    end
                    
                    if result[1].balance < salary then
                        -- Not enough money in society - notify employee and all bosses
                        CRUX.Notify(src, {
                            title = Config.Localess.JobSystem.paycheck_title or "Paycheck Error",
                            description = Config.Localess.JobSystem.employer_insufficient_funds or "Your employer has insufficient funds to pay your salary.",
                            type = "error",
                            duration = 7000
                        })
                        
                        -- Helper: point-in-polygon (ray-casting) for 2D
                        local function PointInPolygon(px, py, polygon)
                            if not polygon or #polygon == 0 then return false end
                            local inside = false
                            local j = #polygon
                            for i = 1, #polygon do
                                local vi = polygon[i]
                                local vj = polygon[j]
                                local xi = vi.x or vi[1]
                                local yi = vi.y or vi[2]
                                local xj = vj.x or vj[1]
                                local yj = vj.y or vj[2]

                                if ((yi > py) ~= (yj > py)) then
                                    local intersectX = xi + (py - yi) * (xj - xi) / (yj - yi)
                                    if px < intersectX then
                                        inside = not inside
                                    end
                                end
                                j = i
                            end
                            return inside
                        end

                        -- Gather bosses and notify only if they are inside cpreset.AreaPolyzone (if enabled)
                        local bosses = {}
                        for _, playerId in ipairs(GetPlayers()) do
                            local pid = tonumber(playerId)
                            local bossJob = JobSystem.GetJob(pid)
                            if bossJob and bossJob.name == jobName and bossJob.is_boss then
                                local ped = GetPlayerPed(pid)
                                if ped and ped ~= 0 then
                                    local pos = GetEntityCoords(ped)
                                    local px, py, pz = pos.x, pos.y, pos.z

                                    local shouldNotify = true
                                    -- If AreaPolyzone is configured, check if boss is inside it
                                    if cpreset and cpreset.AreaPolyzone and cpreset.AreaPolyzone.enabled then
                                        local poly = cpreset.AreaPolyzone.polyzone
                                        local minZ = cpreset.AreaPolyzone.minZ
                                        local maxZ = cpreset.AreaPolyzone.maxZ

                                        local inPoly = PointInPolygon(px, py, poly)
                                        if not inPoly then
                                            shouldNotify = false
                                        else
                                            if minZ and pz < minZ then shouldNotify = false end
                                            if maxZ and pz > maxZ then shouldNotify = false end
                                        end
                                    end

                                    if shouldNotify then
                                        table.insert(bosses, pid)
                                    end
                                end
                            end
                        end

                        for _, bossId in ipairs(bosses) do
                            CRUX.Notify(bossId, {
                                title = Config.Localess.BossMenu.bankruptcy_alert or "⚠️ Bankruptcy Alert",
                                description = string.format(Config.Localess.BossMenu.paycheck_bankruptcy or "Cannot pay salaries! Business balance: $%s, Required: $%s",
                                    result[1].balance, salary),
                                type = "error",
                                duration = 10000
                            })
                        end
                        Server.Debug("Paycheck rejected - insufficient society funds. Balance: $" .. result[1].balance .. ", Salary: $" .. salary)
                        return
                    end

                    -- Deduct money from society
                    MySQL.update('UPDATE ' .. tablePrefix .. 'bossmenu SET balance = balance - ? WHERE id = ? AND balance >= ?',
                        {salary, jobName, salary},
                        function(rowsChanged)
                            if rowsChanged > 0 then
                                -- Complete the paycheck process
                                JobSystem.PaycheckSystem.CompletePaycheck(src, playerIdentifier, playerName, jobName, jobGrade, salary, true)
                            else
                                CRUX.Notify(src, {
                                    title = Config.Localess.System.paycheck_error or "Paycheck Error",
                                    description = Config.Localess.JobSystem.paycheck_failed or "Failed to process paycheck - insufficient business funds.",
                                    type = "error",
                                    duration = 5000
                                })
                            end
                        end
                    )
                end
            )
        else
            -- Just pay the player without deducting from society - this follows SocietyPay = false
            JobSystem.PaycheckSystem.CompletePaycheck(src, playerIdentifier, playerName, jobName, jobGrade, salary, false)
        end
    end,

    -- Complete the paycheck process
    CompletePaycheck = function(src, playerIdentifier, playerName, jobName, jobGrade, salary, fromSociety)
        Wait(5000) -- Ensure DB tables are loaded before SQL operations

        -- Record the paycheck in history
        MySQL.insert('INSERT INTO ' .. tablePrefix .. 'paycheck_history (license, name, job, job_grade, amount, from_society) VALUES (?, ?, ?, ?, ?, ?)',
            {playerIdentifier, playerName, jobName, jobGrade, salary, fromSociety},
            function(id)
                if not id then
                    Server.Debug("Error recording paycheck for: " .. playerName)
                end
            end
        )

        -- Update balance and paycheck_balance in employee record - now using job_grade instead of role
        MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET balance = balance + ?, paycheck_balance = paycheck_balance + ? WHERE license = ? AND job = ?',
            {salary, salary, playerIdentifier, jobName},
            function(rowsChanged)
                if rowsChanged <= 0 then
                    -- Employee record doesn't exist, create it with job_grade instead of role
                    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, balance, paycheck_balance, job, job_grade, experience) VALUES (?, ?, ?, ?, ?, ?, ?)',
                        {playerIdentifier, playerName, salary, salary, jobName, jobGrade, 0},
                        function(id)
                            if id then
                                Server.Debug("Created new employee record for paycheck: " .. playerName)
                            else
                                Server.Debug("Error creating employee record for paycheck: " .. playerName)
                            end
                        end
                    )
                else
                    Server.Debug("Updated employee balance with paycheck: $" .. salary .. " for " .. playerName)
                end
            end
        )

        -- Get job label for the notification
        MySQL.query('SELECT label FROM ' .. tablePrefix .. 'jobs WHERE name = ?', {jobName}, function(result)
            local jobLabel = jobName
            if result and #result > 0 then
                jobLabel = result[1].label
            end

            -- Notify player about paycheck - use ONLY client-side notification
            TriggerClientEvent(Config.ResourceName .. ':client:receivePaycheck', src, {
                jobName = jobLabel,
                amount = salary
            })

            Server.Debug(string.format(Config.Localess.JobSystem.paycheck_added, salary, playerName, jobLabel))
        end)
    end
}

-- Event handler for paycheck requests
RegisterNetEvent(Config.ResourceName .. ':server:requestPaycheck')
AddEventHandler(Config.ResourceName .. ':server:requestPaycheck', function()
    Wait(5000) -- Ensure DB tables are loaded before SQL operations
    local src = source
    local playerJob = JobSystem.GetJob(src)

    -- Verify player has a job
    if not playerJob then return end

    -- Check if salary system is enabled
    if not Config.Salaries.Enable then
        return
    end

    -- Check duty status if needed - respect OnlyOnDuty setting
    if Config.Salaries.OnlyOnDuty and not playerJob.onduty then
        TriggerClientEvent(Config.ResourceName .. ':notify', src, {
            title = Config.Localess.JobSystem.not_on_duty,
            description = Config.Localess.JobSystem.must_be_on_duty,
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Update the client's timer display
    local configuredMinutes = Config.Salaries.Time or 1
    local formattedTime = string.format("00:%02d:00", configuredMinutes)

    TriggerClientEvent(Config.ResourceName .. ':client:updatePaycheckTimer', src, {
        timeRemaining = formattedTime,
        configuredMinutes = configuredMinutes,
        onlyOnDuty = Config.Salaries.OnlyOnDuty
    })
end)

-- Initialize job system when resource starts
Citizen.CreateThread(function()
    Wait(2000) -- Slight delay to ensure database is ready
    JobSystem.Initialize()

    -- Additional check to verify database tables exist
    MySQL.query("SELECT 1 FROM " .. tablePrefix .. "user_jobs LIMIT 1", {}, function(result)
        if not result then
            Server.Debug("WARNING: user_jobs table might not exist. Job persistence will not work!")
        else
            Server.Debug("Job system database tables verified.")
        end
    end)
end)

-- Initialize the paycheck system when the resource starts
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    JobSystem.Initialize()
    JobSystem.PaycheckSystem.Initialize()
end)

-- Updated exports to match the returned job structure and be more resilient
exports('hasJob', function(source)
    local job = JobSystem.GetJob(source)
    if not job then return false end

    -- Consider both name and label when checking unemployed
    if job.name == "unemployed" or (job.label and job.label:lower() == "unemployed") then
        return false
    end

    return true
end)

exports('hasJobAndGrade', function(source, grade)
    local job = JobSystem.GetJob(source)
    if not job then return false end

    -- Accept match by job name or job label, and compare numeric grades safely
    local jobMatches = (job.name == Config.JobName) or (Config.JobLabel and job.label == Config.JobLabel)
    if not jobMatches then return false end

    return tonumber(job.grade) == tonumber(grade)
end)

exports('onDuty', function(source)
    local job = JobSystem.GetJob(source)
    if not job then return false end
    return job.onduty == true
end)

-- Optional: export full job object for other resources that need the detailed structure
exports('getJob', function(source)
    return JobSystem.GetJob(source)
end)

-- Server handler: check whether a specific job/grade is marked as boss (is_boss column)
RegisterNetEvent(Config.ResourceName .. ':server:checkGradeIsBoss')
AddEventHandler(Config.ResourceName .. ':server:checkGradeIsBoss', function(jobName, grade, requesterServerId)
    Wait(5000) -- Ensure DB tables are loaded before SQL operations
    local src = source
    local job = tostring(jobName or "")
    local gradeNum = tonumber(grade) or 0

    Server.Debug("Received checkGradeIsBoss request from source=" .. tostring(src) .. " for job=" .. job .. " grade=" .. tostring(gradeNum))

    -- Query the job_grades table for this job/grade
    MySQL.query("SELECT is_boss FROM " .. tablePrefix .. "job_grades WHERE job_name = ? AND grade = ?", {job, gradeNum}, function(result)
        local isBoss = false

        if result and #result > 0 then
            -- Normalize values: could be 0/1, "0"/"1", true/false
            local val = result[1].is_boss
            if val == true or val == 1 or tostring(val) == "1" or tostring(val):lower() == "true" then
                isBoss = true
            end
            Server.Debug("checkGradeIsBoss DB result for " .. job .. "@" .. gradeNum .. " -> is_boss=" .. tostring(isBoss))
        else
            Server.Debug("checkGradeIsBoss: no grade record found for " .. job .. "@" .. gradeNum)
        end

        -- Reply to the requesting client (use src so the caller always gets the response)
        TriggerClientEvent(Config.ResourceName .. ':client:gradeIsBossResult', src, isBoss)
    end)
end)
