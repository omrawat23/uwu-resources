Wait(5000)

-- Track which players have the employee menu open
local employeeMenuLocks = {}

-- Helper function to check if employee menu is locked for this player
local function IsEmployeeMenuLocked(playerId)
    return employeeMenuLocks[playerId] ~= nil
end

-- Helper function to lock employee menu
local function LockEmployeeMenu(playerId)
    employeeMenuLocks[playerId] = true
end

-- Helper function to unlock employee menu
local function UnlockEmployeeMenu(playerId)
    employeeMenuLocks[playerId] = nil
end

-- Cleanup locks when player disconnects
AddEventHandler('playerDropped', function()
    local src = source
    if employeeMenuLocks[src] then
        UnlockEmployeeMenu(src)
        Server.Debug("Unlocked employee menu for player " .. src .. " due to disconnect")
    end
end)

-- Event to fetch employee data
RegisterNetEvent(Config.ResourceName .. ':server:getEmployeeData')
AddEventHandler(Config.ResourceName .. ':server:getEmployeeData', function()
    local src = source
    
    -- Note: We don't check if menu is locked here because the same player should be able to reopen
    -- The lock is just to prevent duplicate requests while data is loading
    
    -- Lock the menu for this player
    LockEmployeeMenu(src)
    
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)
    local playerObj = CRUX.Framework.GetPlayer(src)

    if not playerIdentifier then
        UnlockEmployeeMenu(src) -- Unlock on error
        CRUX.Notify(src, {
            title = Config.Localess.System.error,
            description = Config.Localess.EmployeeMenu.employee_data_error or "Could not retrieve your employee data.",
            type = "error",
            duration = 5000
        })
        return
    end

    -- Query database for employee data - join with job grades to get role name, salary and commission
    MySQL.query('SELECT e.*, j.label as job_label, g.label as grade_label, g.salary, g.commission, g.name as role_name, g.is_boss FROM ' .. tablePrefix .. 'employees e LEFT JOIN ' .. tablePrefix .. 'jobs j ON e.job = j.name LEFT JOIN ' .. tablePrefix .. 'job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.license = ? AND e.job = ?',
        {playerIdentifier, Config.JobName},
        function(result)
            local employeeData = {}

            if result and #result > 0 then
                -- Ensure role matches the client-side availableRoles key format:
                -- lowercase(grade_label with spaces removed). Fallback to role_name if needed.
                local grade_label = result[1].grade_label or result[1].label or result[1].role_name
                local roleId = "employee"
                if grade_label then
                    roleId = string.lower(tostring(grade_label):gsub("%s+", ""))
                elseif result[1].role_name then
                    roleId = tostring(result[1].role_name)
                end

                employeeData = {
                    license = result[1].license,
                    name = result[1].name,
                    role = roleId, -- canonical role id matching availableRoles keys
                    job_grade = result[1].job_grade,
                    grade_label = result[1].grade_label,
                    is_boss = result[1].is_boss == 1, -- Add is_boss flag
                    salary = result[1].salary or 0, -- Get salary from job_grade
                    experience = result[1].experience or 0,
                    performance = result[1].performance or 85, -- Default performance
                    totalEarnings = result[1].balance or 0, -- Changed from total_earnings to balance
                    deliveries = result[1].deliveries or 0,
                    billings = result[1].billings or 0,
                    balance = result[1].balance or 0, -- Main balance
                    delivery_balance = result[1].delivery_balance or 0, -- New field
                    billing_balance = result[1].billing_balance or 0, -- New field
                    paycheck_balance = result[1].paycheck_balance or 0, -- New field
                    commission = result[1].commission or 0, -- Get commission from job_grade
                    avatar = result[1].image or "/placeholder.svg?height=40&width=40",
                    notifications_enabled = result[1].notifications_enabled == 1 or result[1].notifications_enabled == true
                }
                Server.Debug("Retrieved employee data for: " .. result[1].name)
            else
                -- If no employee record exists yet, create a placeholder
                local playerName = CRUX.Framework.GetPlayerName(src)
                local jobGrade = 0
                local roleName = "employee"
                local salary = 0
                local commission = 0

                -- Get job data from the player object
                if playerObj and playerObj.PlayerData and playerObj.PlayerData.job then
                    jobGrade = tonumber(playerObj.PlayerData.job.grade) or 0
                    local gradeInfo = Config.Grades[tostring(jobGrade)]
                    if gradeInfo then
                        roleName = string.lower(gradeInfo.Label:gsub("%s+", ""))
                        salary = gradeInfo.Salary
                        commission = gradeInfo.Commission or 0
                    end
                end

                employeeData = {
                    license = playerIdentifier,
                    name = playerName,
                    role = roleName, -- roleName already computed as lowercase(label without spaces) above
                    job_grade = jobGrade,
                    grade_label = Config.Grades[tostring(jobGrade)] and Config.Grades[tostring(jobGrade)].Label or "Employee",
                    salary = salary,
                    experience = 0,
                    performance = 75, -- Default starter performance
                    totalEarnings = 0, -- Kept for UI compatibility
                    deliveries = 0,
                    billings = 0,
                    balance = 0,
                    delivery_balance = 0,
                    billing_balance = 0,
                    paycheck_balance = 0,
                    commission = commission,
                    avatar = "/placeholder.svg?height=40&width=40",
                    notifications_enabled = true -- Default to true for new employees
                }

                -- Create employee record in database (without any removed fields)
                MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, job, job_grade, experience, balance, delivery_balance, billing_balance, paycheck_balance, deliveries, billings, notifications_enabled) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                    {playerIdentifier, playerName, Config.JobName, jobGrade, 0, 0, 0, 0, 0, 0, 0, true},
                    function(id)
                        if not id then
                            Server.Debug("Error creating employee record for: " .. playerName)
                        else
                            Server.Debug("Created new employee record for: " .. playerName)
                        end
                    end
                )
            end

            -- Send employee data to client
            TriggerClientEvent(Config.ResourceName .. ':client:receiveEmployeeData', src, employeeData)
            
            -- Don't unlock here - let the client unlock when they close the menu
            -- This prevents race conditions with rapid open/close
        end
    )
end)

-- Event to fetch employee leaderboard
RegisterNetEvent(Config.ResourceName .. ':server:getEmployeeLeaderboard')
AddEventHandler(Config.ResourceName .. ':server:getEmployeeLeaderboard', function()
    local src = source

    -- Query database for employee leaderboard data - join with job_grades to get role names
    MySQL.query('SELECT e.license, e.name, g.name AS role_name, e.experience, e.deliveries, e.billings, e.balance FROM ' .. tablePrefix .. 'employees e LEFT JOIN ' .. tablePrefix .. 'job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.job = ? ORDER BY e.experience DESC LIMIT 10',
        {Config.JobName},
        function(result)
            local leaderboard = {}

            if result and #result > 0 then
                -- Format the result for the client
                for i, entry in ipairs(result) do
                    leaderboard[i] = {
                        license = entry.license,
                        name = entry.name,
                        role = entry.role_name or "employee",
                        experience = entry.experience,
                        deliveries = entry.deliveries,
                        billings = entry.billings,
                        balance = entry.balance
                    }
                end
            end

            -- Send leaderboard data to client
            TriggerClientEvent(Config.ResourceName .. ':client:receiveEmployeeLeaderboard', src, leaderboard)
        end
    )
end)

-- Event to handle duty status toggling
RegisterNetEvent(Config.ResourceName .. ':server:toggleDuty')
AddEventHandler(Config.ResourceName .. ':server:toggleDuty', function()
    local src = source

    -- Get current job status
    local job = JobSystem.GetJob(src)
    if not job then return end

    -- Toggle duty status
    local newStatus = not job.onduty
    JobSystem.SetJobDuty(src, newStatus)

    -- Notify the player
    CRUX.Notify(src, {
        title = Config.Localess.Duty.status,
        description = string.format(Config.Localess.Duty.description or "You are now %s duty.", newStatus and "on" or "off"),
        type = "info",
        duration = 5000
    })
end)

-- Event to handle commission withdrawal
RegisterNetEvent(Config.ResourceName .. ':server:withdrawCommission')
AddEventHandler(Config.ResourceName .. ':server:withdrawCommission', function(amount)
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    if not playerIdentifier then
        CRUX.Notify(src, {
            title = Config.Localess.System.error,
            description = Config.Localess.EmployeeMenu.identity_error or "Could not verify your identity.",
            type = "error",
            duration = 5000
        })
        return
    end

    -- Validate amount
    if not amount or amount <= 0 then
        CRUX.Notify(src, {
            title = Config.Localess.BossMenu.withdraw,
            description = Config.Localess.EmployeeMenu.withdraw_invalid_amount or "Invalid amount!",
            type = "error",
            duration = 5000
        })
        return
    end

    -- Check employee balance
    MySQL.query('SELECT balance FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
        {playerIdentifier, Config.JobName},
        function(result)
            if not result or #result == 0 then
                CRUX.Notify(src, {
                    title = Config.Localess.System.error,
                    description = Config.Localess.EmployeeMenu.employee_record_not_found_withdraw or "Employee record not found!",
                    type = "error",
                    duration = 5000
                })
                return
            end

            local balance = tonumber(result[1].balance)
            if balance < amount then
                CRUX.Notify(src, {
                    title = Config.Localess.BossMenu.withdraw,
                    description = Config.Localess.EmployeeMenu.insufficient_commission or "Insufficient commission balance!",
                    type = "error",
                    duration = 5000
                })
                return
            end

            -- Update employee balance
            MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET balance = balance - ? WHERE license = ? AND job = ?',
                {amount, playerIdentifier, Config.JobName},
                function(rowsChanged)
                    if rowsChanged > 0 then
                        -- Add money to player using the configured withdraw method
                        local withdrawMethod = Config.EmployeeWithdrawMoney or 'cash'
                        CRUX.Framework.AddMoney(src, withdrawMethod, amount)

                        -- Notify the player
                        CRUX.Notify(src, {
                            title = Config.Localess.EmployeeMenu.commission_withdrawn,
                            description = string.format(Config.Localess.EmployeeMenu.commission_withdrawn_description or "You've withdrawn $%s from your commission balance to your %s.", amount, withdrawMethod),
                            type = "success",
                            duration = 5000
                        })

                        -- Get updated balance and inform client
                        MySQL.query('SELECT balance FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
                            {playerIdentifier, Config.JobName},
                            function(newBalance)
                                if newBalance and #newBalance > 0 then
                                    TriggerClientEvent(Config.ResourceName .. ':client:updateEmployeeCommission', src, tonumber(newBalance[1].balance))
                                end
                            end
                        )
                    else
                        CRUX.Notify(src, {
                            title = Config.Localess.EmployeeMenu.transaction_failed,
                            description = Config.Localess.EmployeeMenu.transaction_failed_update or "Failed to update commission balance!",
                            type = "error",
                            duration = 5000
                        })
                    end
                end
            )
        end
    )
end)

-- Event to handle firing an employee
RegisterNetEvent(Config.ResourceName .. ':server:fireEmployee')
AddEventHandler(Config.ResourceName .. ':server:fireEmployee', function(employeeLicense)
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Check if employee exists and belongs to this job
    MySQL.query('SELECT e.name, g.name AS role_name, e.job FROM ' .. tablePrefix .. 'employees e LEFT JOIN ' .. tablePrefix .. 'job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.license = ?',
        {employeeLicense},
        function(result)
            if not result or #result == 0 then
                CRUX.Notify(src, {
                    title = Config.Localess.EmployeeMenu.fire_employee,
                    description = Config.Localess.EmployeeMenu.fire_employee_not_found or "Employee not found!",
                    type = "error",
                    duration = 5000
                })
                return
            end

            local employee = result[1]

            -- Check if employee works for this job
            if employee.job ~= Config.JobName then
                CRUX.Notify(src, {
                    title = Config.Localess.EmployeeMenu.fire_employee,
                    description = Config.Localess.EmployeeMenu.fire_employee_wrong_business or "This employee doesn't work for your business!",
                    type = "error",
                    duration = 5000
                })
                return
            end

            -- Delete the employee from the employees table
            MySQL.update('DELETE FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
                {employeeLicense, Config.JobName},
                function(rowsChanged)
                    if rowsChanged > 0 then
                        -- Also remove from user_jobs table or set to unemployed
                        MySQL.update('UPDATE ' .. tablePrefix .. 'user_jobs SET job = ?, grade = ? WHERE identifier = ?',
                            {"unemployed", 0, employeeLicense},
                            function(userJobRowsChanged)
                                if userJobRowsChanged > 0 then
                                    Server.Debug("Updated user_jobs to unemployed for fired employee: " .. employee.name)
                                else
                                    -- If no user_jobs record exists, that's fine - employee was only in employees table
                                    Server.Debug("No user_jobs record found for fired employee: " .. employee.name)
                                end
                            end
                        )

                        -- Find if the player is online to remove their job
                        local targetSrc = nil
                        for _, playerId in ipairs(GetPlayers()) do
                            local playerLicense = CRUX.Framework.GetIdentifier(tonumber(playerId))
                            Server.Debug("Checking player " .. playerId .. " with license: " .. tostring(playerLicense))

                            if playerLicense == employeeLicense then
                                targetSrc = tonumber(playerId)
                                Server.Debug("Found online player to fire: " .. targetSrc)
                                break
                            end
                        end

                        -- If player is online, set their job to unemployed
                        if targetSrc then
                            -- Use the JobSystem function to set their job to unemployed
                            local success = JobSystem.SetJob(targetSrc, "unemployed", 0)

                            if success then
                                CRUX.Notify(targetSrc, {
                                    title = Config.Localess.EmployeeMenu.employment_notice,
                                    description = string.format(Config.Localess.EmployeeMenu.employment_notice_fired or "You have been fired from %s", Config.JobLabel),
                                    type = "error",
                                    duration = 5000
                                })

                                Server.Debug("Job removed for fired employee: " .. employee.name)
                            else
                                Server.Debug("Failed to set job to unemployed for employee: " .. employee.name)
                            end
                        else
                            Server.Debug("Employee is offline, job will be updated when they next join: " .. employee.name)
                        end

                        -- Notify the manager
                        CRUX.Notify(src, {
                            title = Config.Localess.EmployeeMenu.fire_employee,
                            description = string.format(Config.Localess.EmployeeMenu.fire_employee_description or "%s has been fired from your business!", employee.name),
                            type = "success",
                            duration = 5000
                        })

                        -- Log the action
                        Server.Debug("Employee " .. employee.name .. " fired from " .. Config.JobLabel)

                        -- Send success to client UI
                        TriggerClientEvent(Config.ResourceName .. ':client:employeeFired', src, {
                            success = true,
                            license = employeeLicense,
                            name = employee.name
                        })
                    else
                        CRUX.Notify(src, {
                            title = Config.Localess.System.error,
                            description = Config.Localess.EmployeeMenu.fire_employee_db_error or "Failed to fire employee from database!",
                            type = "error",
                            duration = 5000
                        })
                    end
                end
            )
        end
    )
end)

-- Update employee performance based on sales/deliveries
-- This function could be called from other events to update performance
function UpdateEmployeePerformance(license, deliveryCompleted)
    if deliveryCompleted then
        -- Increment deliveries count
        MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET deliveries = deliveries + 1 WHERE license = ? AND job = ?',
            {license, Config.JobName},
            function(rowsChanged)
                if rowsChanged <= 0 then
                    Server.Debug("Failed to update delivery count for: " .. license)
                end
            end
        )
    end

    -- Calculate performance based on experience and deliveries
    MySQL.query('SELECT experience, deliveries FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
        {license, Config.JobName},
        function(result)
            if result and #result > 0 then
                local experience = result[1].experience or 0
                local deliveries = result[1].deliveries or 0

                -- Simple performance calculation (can be adjusted)
                local performance = math.min(75 + math.floor(experience/100) + math.floor(deliveries/10), 100)

                -- Update performance
                MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET performance = ? WHERE license = ? AND job = ?',
                    {performance, license, Config.JobName},
                    function(rowsChanged)
                        if rowsChanged <= 0 then
                            Server.Debug("Failed to update performance for: " .. license)
                        end
                    end
                )
            end
        end
    )
end

-- Update database schema if needed with missing columns
Citizen.CreateThread(function()
    Wait(5000) -- Wait for database to be ready

    -- Add deliveries column if it doesn't exist
    MySQL.query("SHOW COLUMNS FROM " .. tablePrefix .. "employees LIKE 'deliveries'", {}, function(result)
        if result and #result == 0 then
            MySQL.execute("ALTER TABLE " .. tablePrefix .. "employees ADD COLUMN deliveries INT DEFAULT 0", {})
            Server.Debug("Added deliveries column to " .. tablePrefix .. "employees table")
        end
    end)

    -- Add billings column if it doesn't exist
    MySQL.query("SHOW COLUMNS FROM " .. tablePrefix .. "employees LIKE 'billings'", {}, function(result)
        if result and #result == 0 then
            MySQL.execute("ALTER TABLE " .. tablePrefix .. "employees ADD COLUMN billings INT DEFAULT 0", {})
            Server.Debug("Added billings column to " .. tablePrefix .. "employees table")
        end
    end)

    -- Add performance column if it doesn't exist
    MySQL.query("SHOW COLUMNS FROM " .. tablePrefix .. "employees LIKE 'performance'", {}, function(result)
        if result and #result == 0 then
            MySQL.execute("ALTER TABLE " .. tablePrefix .. "employees ADD COLUMN performance INT DEFAULT 75", {})
            Server.Debug("Added performance column to " .. tablePrefix .. "employees table")
        end
    end)

    -- Add image column if it doesn't exist
    MySQL.query("SHOW COLUMNS FROM " .. tablePrefix .. "employees LIKE 'image'", {}, function(result)
        if result and #result == 0 then
            MySQL.execute("ALTER TABLE " .. tablePrefix .. "employees ADD COLUMN image VARCHAR(255) DEFAULT '/placeholder.svg?height=40&width=40'", {})
            Server.Debug("Added image column to " .. tablePrefix .. "employees table")
        end
    end)
end)

-- Event to handle updating job grades in the database
RegisterNetEvent(Config.ResourceName .. ':server:updateJobGrade')
AddEventHandler(Config.ResourceName .. ':server:updateJobGrade', function(data)
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Validate the data
    if not data.roleId or not data.salary then
        TriggerClientEvent(Config.ResourceName .. ':client:jobGradeUpdated', src, {
            success = false,
            description = Config.Localess.EmployeeMenu.invalid_grade_data or "Invalid grade data provided."
        })
        return
    end

    -- Ensure salary and commission are numbers
    local salary = tonumber(data.salary)
    local commission = tonumber(data.commission) or 0
    if commission < 0 then commission = 0 end
    if commission > 100 then commission = 100 end

    -- Convert isBoss to database format (robust handling for boolean, number, string)
    local isBoss = 0
    if data.isBoss == true then
        isBoss = 1
    else
        local asNum = tonumber(data.isBoss)
        if asNum ~= nil and asNum == 1 then
            isBoss = 1
        else
            isBoss = 0
        end
    end

    -- Use provided gradeId if available, otherwise find by roleId
    local gradeId

    if data.gradeId then
        gradeId = tonumber(data.gradeId)
        Server.Debug("Using provided gradeId: " .. gradeId)
    else
        -- Find grade number from roleId (backup logic)
        for id, gradeInfo in pairs(Config.Grades) do
            local roleId = string.lower(gradeInfo.Label:gsub("%s+", ""))
            if roleId == data.roleId then
                gradeId = tonumber(id)
                Server.Debug("Found gradeId from roleId: " .. gradeId)
                break
            end
        end
    end

    if not gradeId then
        TriggerClientEvent(Config.ResourceName .. ':client:jobGradeUpdated', src, {
            success = false,
            description = Config.Localess.EmployeeMenu.grade_id_not_found or "Could not find grade ID for this role."
        })
        return
    end

    Server.Debug(string.format("Updating job grade %d with label: %s, salary: %d, commission: %d, is_boss: %d",
        gradeId, data.label, salary, commission, isBoss))

    -- Update the job grade in the database
    MySQL.update('UPDATE ' .. tablePrefix .. 'job_grades SET label = ?, salary = ?, commission = ?, is_boss = ? WHERE job_name = ? AND grade = ?',
        {data.label, salary, commission, isBoss, Config.JobName, gradeId},
        function(rowsChanged)
            if rowsChanged > 0 then
                -- Update was successful
                CRUX.Notify(src, {
                    title = Config.Localess.BossMenu.grade_updated,
                    description = string.format(Config.Localess.BossMenu.grade_update_success, data.label),
                    type = "success",
                    duration = 3000,
                })


                -- Also fetch the updated data to confirm the changes
                MySQL.query('SELECT * FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? AND grade = ?',
                    {Config.JobName, gradeId},
                    function(result)
                        if result and #result > 0 then
                            local updatedGrade = result[1]
                            Server.Debug("Updated grade data: " .. json.encode(updatedGrade))
                        end
                    end
                )

                -- Update also the Config.Grades in memory (optional)
                if Config.Grades[tostring(gradeId)] then
                    Config.Grades[tostring(gradeId)].Label = data.label
                    Config.Grades[tostring(gradeId)].Salary = salary
                    Config.Grades[tostring(gradeId)].Commission = commission
                    Config.Grades[tostring(gradeId)].IsBoss = (isBoss == 1)
                end

                -- Send success response back to client
                TriggerClientEvent(Config.ResourceName .. ':client:jobGradeUpdated', src, {
                    success = true,
                    description = "Job grade updated successfully",
                    gradeData = {
                        id = data.roleId,
                        gradeId = gradeId,
                        label = data.label,
                        salary = salary,
                        commission = commission,
                        isBoss = (isBoss == 1)
                    }
                })

                -- Broadcast the update to all clients
                TriggerClientEvent(Config.ResourceName .. ':client:refreshJobGrades', -1)
            else
                -- Update failed or no changes
                TriggerClientEvent(Config.ResourceName .. ':client:jobGradeUpdated', src, {
                    success = false,
                    description = Config.Localess.EmployeeMenu.no_grade_changes or "No changes were made to the job grade."
                })
            end
        end
    )
end)

-- Function to get all job grades for a specific job
RegisterNetEvent(Config.ResourceName .. ':server:getJobGrades')
AddEventHandler(Config.ResourceName .. ':server:getJobGrades', function()
    local src = source
    local playerJob = CRUX.Framework.GetJob(src)

    -- Check if player has the correct job
    if not playerJob or playerJob.name ~= Config.JobName then
        TriggerClientEvent(Config.ResourceName .. ':client:receiveJobGrades', src, {})
        return
    end

    -- Query all job grades for this job
    MySQL.query('SELECT * FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? ORDER BY grade ASC',
        {Config.JobName},
        function(result)
            if result and #result > 0 then
                -- Format the job grades data
                local jobGrades = {}
                for i, grade in ipairs(result) do
                    local roleId = string.lower(grade.label:gsub("%s+", ""))
                    jobGrades[roleId] = {
                        id = roleId,
                        gradeId = grade.grade,
                        label = grade.label,
                        salary = grade.salary,
                        commission = grade.commission,
                        isBoss = grade.is_boss == 1
                    }
                end

                -- Send job grades to client
                TriggerClientEvent(Config.ResourceName .. ':client:receiveJobGrades', src, jobGrades)
            else
                -- No job grades found
                TriggerClientEvent(Config.ResourceName .. ':client:receiveJobGrades', src, {})
            end
        end
    )
end)

-- Event to update employee avatar image
RegisterNetEvent(Config.ResourceName .. ':server:updateEmployeeAvatar')
AddEventHandler(Config.ResourceName .. ':server:updateEmployeeAvatar', function(imageUrl)
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    if not playerIdentifier then
        CRUX.Notify(src, {
            title = Config.Localess.System.error or "Error",
            description = Config.Localess.EmployeeMenu.identity_error or "Could not verify your identity.",
            type = "error",
            duration = 5000
        })
        return
    end

    -- Validate image URL (basic validation)
    if not imageUrl or imageUrl == "" then
        CRUX.Notify(src, {
            title = Config.Localess.EmployeeMenu.avatar_update or "Avatar Update",
            description = Config.Localess.EmployeeMenu.avatar_invalid_url or "Invalid image URL provided.",
            type = "error",
            duration = 5000
        })
        return
    end

    -- Update the employee's image in the database
    MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET image = ? WHERE license = ? AND job = ?',
        {imageUrl, playerIdentifier, Config.JobName},
        function(rowsChanged)
            if rowsChanged > 0 then
                CRUX.Notify(src, {
                    title = Config.Localess.EmployeeMenu.avatar_updated or "Avatar Updated",
                    description = Config.Localess.EmployeeMenu.avatar_updated_success or "Your profile avatar has been updated successfully.",
                    type = "success",
                    duration = 5000
                })

                -- Send updated avatar to client
                TriggerClientEvent(Config.ResourceName .. ':client:avatarUpdated', src, imageUrl)
            else
                -- Check if employee record exists
                MySQL.query('SELECT license FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
                    {playerIdentifier, Config.JobName},
                    function(result)
                        if result and #result > 0 then
                            -- Employee exists but no changes were made
                            CRUX.Notify(src, {
                                title = Config.Localess.EmployeeMenu.avatar_update or "Avatar Update",
                                description = Config.Localess.EmployeeMenu.avatar_no_changes or "No changes were made to your avatar.",
                                type = "error",
                                duration = 5000
                            })
                        else
                            -- Employee doesn't exist, create record with avatar (without removed fields)
                            local playerName = CRUX.Framework.GetPlayerName(src)
                            MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, job, image, job_grade, experience, balance, delivery_balance, billing_balance, paycheck_balance, deliveries, billings) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                                {playerIdentifier, playerName, Config.JobName, imageUrl, 0, 0, 0, 0, 0, 0, 0, 0},
                                function(id)
                                    if id then
                                        CRUX.Notify(src, {
                                            title = Config.Localess.EmployeeMenu.avatar_created or "Avatar Created",
                                            description = Config.Localess.EmployeeMenu.avatar_created or "Your employee profile and avatar have been created.",
                                            type = "success",
                                            duration = 5000
                                        })

                                        -- Send updated avatar to client
                                        TriggerClientEvent(Config.ResourceName .. ':client:avatarUpdated', src, imageUrl)
                                    else
                                        CRUX.Notify(src, {
                                            title = Config.Localess.EmployeeMenu.avatar_update or "Avatar Update",
                                            description = Config.Localess.EmployeeMenu.avatar_create_failed or "Failed to create employee record.",
                                            type = "error",
                                            duration = 5000
                                        })
                                    end
                                end
                            )
                        end
                    end
                )
            end
        end
    )
end)

-- Handle employee balance withdrawal
RegisterNetEvent(Config.ResourceName .. ':server:withdrawEmployeeBalance')
AddEventHandler(Config.ResourceName .. ':server:withdrawEmployeeBalance', function(amount, balanceType)
    local src = source
    local amount = tonumber(amount)
    if not amount or amount <= 0 then
        CRUX.Notify(src, {
            title = Config.Localess.System.error or "Error",
            description = Config.Localess.EmployeeMenu.withdrawal_invalid_amount or "Invalid withdrawal amount.",
            type = "error",
            duration = 5000
        })
        return
    end

    -- Default to main balance if no specific type is provided
    balanceType = balanceType or 'balance'

    -- Validate balance type is one of the allowed values
    if balanceType ~= 'balance' and balanceType ~= 'delivery_balance' and
       balanceType ~= 'billing_balance' and balanceType ~= 'paycheck_balance' then
        balanceType = 'balance'
    end

    local playerIdentifier = CRUX.Framework.GetIdentifier(src)
    if not playerIdentifier then return end

    -- Get the current balance to check if enough funds are available
    MySQL.query('SELECT * FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
        {playerIdentifier, Config.JobName},
        function(result)
            if not result or #result == 0 then
                CRUX.Notify(src, {
                     title = Config.Localess.System.error or "Error",
                    description = Config.Localess.EmployeeMenu.employee_record_not_found_withdraw or "Employee record not found.",
                    type = "error",
                    duration = 5000
                })
                return
            end

            local employeeData = result[1]
            local availableBalance = employeeData[balanceType] or 0

            if availableBalance < amount then
                CRUX.Notify(src, {
                     title = Config.Localess.System.error or "Error",
                    description = Config.Localess.EmployeeMenu.insufficient_balance_withdraw or "Insufficient funds in your balance.",
                    type = "error",
                    duration = 5000
                })
                return
            end

            -- Update the specific balance and the main balance
            local updateQuery = 'UPDATE ' .. tablePrefix .. 'employees SET '
            local params = {}

            -- Always update the main balance
            updateQuery = updateQuery .. 'balance = balance - ?'
            table.insert(params, amount)

            -- Update the specific balance if it's not the main balance
            if balanceType ~= 'balance' then
                updateQuery = updateQuery .. ', ' .. balanceType .. ' = ' .. balanceType .. ' - ?'
                table.insert(params, amount)
            end

            updateQuery = updateQuery .. ' WHERE license = ? AND job = ?'
            table.insert(params, playerIdentifier)
            table.insert(params, Config.JobName)

            MySQL.update(updateQuery, params, function(affectedRows)
                if affectedRows and affectedRows > 0 then
                    -- Add the money to the player using the configured withdraw method
                    local withdrawMethod = Config.EmployeeWithdrawMoney or 'cash'
                    CRUX.Framework.AddMoney(src, withdrawMethod, amount)

                    -- Determine balance type label for notification
                    local balanceTypeLabel = "employee"
                    if balanceType == 'delivery_balance' then
                        balanceTypeLabel = "delivery"
                    elseif balanceType == 'billing_balance' then
                        balanceTypeLabel = "commission"
                    elseif balanceType == 'paycheck_balance' then
                        balanceTypeLabel = "paycheck"
                    end

                    -- Send notification
                    -- CRUX.Notify(src, {
                    --     title = "Balance Withdrawn",
                    --     description = "You withdrew $" .. amount .. " from your " .. balanceTypeLabel .. " balance to your " .. withdrawMethod .. ".",
                    --     type = "success",
                    --     duration = 5000
                    -- })

                    -- Update the UI via NUI message
                    TriggerClientEvent(Config.ResourceName .. ':client:updateEmployeeBalances', src, {
                        balance = employeeData.balance - amount,
                        [balanceType] = employeeData[balanceType] - amount
                    })
                else
                    CRUX.Notify(src, {
                         title = Config.Localess.System.error or "Error",
                        description = Config.Localess.EmployeeMenu.withdraw_balance_failed or "Failed to withdraw from balance. Please try again.",
                        type = "error",
                        duration = 5000
                    })
                end
            end)
        end
    )
end)

-- Get notification preferences
RegisterNetEvent(Config.ResourceName .. ':server:getNotificationPreferences')
AddEventHandler(Config.ResourceName .. ':server:getNotificationPreferences', function()
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    if not playerIdentifier then return end

    MySQL.query('SELECT notifications_enabled FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
        {playerIdentifier, Config.JobName},
        function(result)
            local enabled = true -- Default to true

            if result and #result > 0 then
                enabled = result[1].notifications_enabled == 1 or result[1].notifications_enabled == true
            end

            TriggerClientEvent(Config.ResourceName .. ':client:receiveNotificationPreferences', src, {enabled = enabled})
        end
    )
end)

-- Toggle notification preferences
RegisterNetEvent(Config.ResourceName .. ':server:toggleNotifications')
AddEventHandler(Config.ResourceName .. ':server:toggleNotifications', function(enabled)
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    if not playerIdentifier then
        TriggerClientEvent(Config.ResourceName .. ':client:notificationToggleResult', src, {success = false, description = Config.Localess.EmployeeMenu.identity_error_toggle or "Could not verify your identity"})
        return
    end

    -- Convert to boolean then to number for database
    local enabledValue = enabled and 1 or 0

    -- Update the setting in database
    MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET notifications_enabled = ? WHERE license = ? AND job = ?',
        {enabledValue, playerIdentifier, Config.JobName},
        function(affectedRows)
            if affectedRows > 0 then
                TriggerClientEvent(Config.ResourceName .. ':client:notificationToggleResult', src, {
                    success = true,
                    enabled = enabled
                })
            else
                -- Check if employee exists
                MySQL.query('SELECT license FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
                    {playerIdentifier, Config.JobName},
                    function(result)
                        if result and #result > 0 then
                            -- No changes were made (value was already set)
                            TriggerClientEvent(Config.ResourceName .. ':client:notificationToggleResult', src, {
                                success = true,
                                enabled = enabled
                            })
                        else
                            -- Create employee record with notification preference
                            local playerName = CRUX.Framework.GetPlayerName(src)
                            MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, job, job_grade, notifications_enabled) VALUES (?, ?, ?, ?, ?)',
                                {playerIdentifier, playerName, Config.JobName, 0, enabledValue},
                                function(id)
                                    TriggerClientEvent(Config.ResourceName .. ':client:notificationToggleResult', src, {
                                        success = id ~= nil,
                                        enabled = id ~= nil and enabled or false,
                                        description = id ~= nil and "Preference saved" or "Failed to save preference"
                                    })
                                end
                            )
                        end
                    end
                )
            end
        end
    )
end)

---@param source number | string | player source id or identifier
---@return number | player experience
exports('getPlayerExperience', function(source)
    local identifier = source
    
    -- If source is a number, it's a player source ID, so get their identifier
    if type(source) == 'number' then
        identifier = CRUX.Framework.GetIdentifier(source)
        if not identifier then
            Server.Debug("Could not get identifier for source: " .. tostring(source))
            return 0
        end
    end
    
    -- Query the database for the player's experience
    local promise = promise.new()
    
    MySQL.query('SELECT experience FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
        {identifier, Config.JobName},
        function(result)
            if result and #result > 0 then
                promise:resolve(result[1].experience or 0)
            else
                promise:resolve(0)
            end
        end
    )
    
    return Citizen.Await(promise)
end)
