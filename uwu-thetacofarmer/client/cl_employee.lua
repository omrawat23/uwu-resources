-- Initialize variables with default values
local playerJob = {name = "unemployed"}
local playerName = nil
local playerCash = nil
local playerBank = nil

-- Storage for cached data
local cachedEmployeeData = {}
local cachedLeaderboard = {}
local employeeDataCallback = nil
local leaderboardCallback = nil

-- Storage for temporary callbacks
local tempCallbacks = {
    notificationPrefs = nil,
    notificationToggle = nil
}

-- Function to fetch employee data
local function FetchEmployeeData(callback)
    employeeDataCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getEmployeeData')
end

-- Function to fetch leaderboard data
local function FetchLeaderboard(callback)
    leaderboardCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getEmployeeLeaderboard')
end

-- Function to get next paycheck info with proper sync to Config.Salaries.Time
local function GetNextPaycheckInfo()
    -- Get player job data to calculate paycheck amount
    local payAmount = 0

    -- Extract the correct grade value - need to handle both table and simple value cases
    local gradeLevel
    if type(playerJob.grade) == "table" then
        -- Try common field names for grade in the table
        if playerJob.grade.level ~= nil then
            gradeLevel = tostring(playerJob.grade.level)
        elseif playerJob.grade.id ~= nil then
            gradeLevel = tostring(playerJob.grade.id)
        elseif playerJob.grade.number ~= nil then
            gradeLevel = tostring(playerJob.grade.number)
        else
            -- If we can't find a specific field, dump the grade table to see what's available
            Client.Debug("Grade table contents: " .. json.encode(playerJob.grade))
            gradeLevel = "0" -- Default fallback
        end
    else
        -- Handle direct value case
        gradeLevel = tostring(playerJob.grade)
    end

    -- Find salary based on job grade
    local gradeInfo = Config.Grades[gradeLevel]
    if gradeInfo then
        payAmount = gradeInfo.Salary or 0
    end

    -- Get configured paycheck time from config, default to 1 minute
    local configuredMinutes = Config.Salaries.Time or 1

    -- Format expected time in seconds
    local nextPaycheckTime = math.random(30, 59) -- Randomize seconds for more natural appearance

    -- Include onlyOnDuty setting in the paycheck info
    return {
        timeRemaining = FormatTimeRemaining(nextPaycheckTime),
        amount = payAmount,
        configuredMinutes = configuredMinutes,
        onlyOnDuty = Config.Salaries.OnlyOnDuty -- Send the OnlyOnDuty setting to UI
    }
end

-- Format time remaining for display (HH:MM:SS)
function FormatTimeRemaining(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

-- Event handler to receive employee data from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveEmployeeData')
AddEventHandler(Config.ResourceName .. ':client:receiveEmployeeData', function(employeeData)
    -- Store the received employee data with all fields
    cachedEmployeeData = employeeData or {}
    Client.Debug("Received employee data: " .. json.encode(cachedEmployeeData))

    if employeeDataCallback then
        employeeDataCallback(cachedEmployeeData)
        employeeDataCallback = nil
    end
end)

-- Function to get experience configuration for UI
RegisterNUICallback('getExperienceConfig', function(data, cb)
    local config = {
        thresholds = {},  -- Will populate from Config.Grades now
        maxAutoGrade = Config.Experience.MaxAutoGrade or 5,
        gradeLabels = {},
        enabled = Config.Experience.Enabled or false,
        isBossMap = {}  -- Add map of grade IDs to their IsBoss value
    }

    -- Add all grade labels and thresholds from Config.Grades
    for gradeId, gradeInfo in pairs(Config.Grades) do
        config.gradeLabels[gradeId] = gradeInfo.Label

        -- Add experience threshold for this grade
        if gradeInfo.Experience ~= nil then
            config.thresholds[gradeId] = gradeInfo.Experience
        end

        -- Add IsBoss mapping for the grade
        config.isBossMap[gradeId] = gradeInfo.IsBoss == true
    end

    -- Get current player's grade to check if they are a boss
    local playerJob = JobSystem.GetJob()
    if playerJob then
        local gradeLevel = tostring(playerJob.grade)
        -- Add this boolean to tell UI if current player is a boss
        config.isCurrentPlayerBoss = (Config.Grades[gradeLevel] and Config.Grades[gradeLevel].IsBoss) == true
    end

    cb(config)
end)


-- Event handler for receiving paycheck
-- RegisterNetEvent(Config.ResourceName .. ':client:receivePaycheck')
-- AddEventHandler(Config.ResourceName .. ':client:receivePaycheck', function(data)
--     -- Play a cash register sound for paycheck regardless
--     PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

--     -- Check cached employee data for notifications setting - consistent with the other handler
--     local shouldNotify = true
--     if cachedEmployeeData and (cachedEmployeeData.notifications_enabled == false or cachedEmployeeData.notifications_enabled == 0) then
--         shouldNotify = false
--         Client.Debug("Notifications are disabled, suppressing paycheck notification")
--     end

--     -- Only show notification if allowed by user preference
--     if shouldNotify then
--         CRUX.Notify({
--             title = "Paycheck Received",
--             description = "You received a paycheck of $" .. data.amount .. " from " .. data.jobName .. " added to your employee balance",
--             type = "success",
--             duration = 5000,
--         })
--     end

--     -- Update UI if the employee menu is open
--     SendNUIMessage({
--         action = 'updatePaycheck',
--         amount = data.amount,
--         jobName = data.jobName,
--         shouldNotify = shouldNotify -- Add this to be consistent
--     })
-- end)

-- Event handler to receive leaderboard data from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveEmployeeLeaderboard')
AddEventHandler(Config.ResourceName .. ':client:receiveEmployeeLeaderboard', function(leaderboard)
    cachedLeaderboard = leaderboard or {}
    Client.Debug("Received leaderboard data: " .. json.encode(cachedLeaderboard))

    if leaderboardCallback then
        leaderboardCallback(cachedLeaderboard)
        leaderboardCallback = nil
    end
end)

-- Event handler to receive updated commission balance
RegisterNetEvent(Config.ResourceName .. ':client:updateEmployeeCommission')
AddEventHandler(Config.ResourceName .. ':client:updateEmployeeCommission', function(balance)
    -- Update cached balance
    if cachedEmployeeData then
        cachedEmployeeData.balance = balance
    end

    -- Send update to UI
    SendNUIMessage({
        action = 'updateCommissionEarned',
        balance = balance
    })
end)

-- NUI Callback for avatar updates - support both employee and boss menus
RegisterNUICallback('updateAvatar', function(data, cb)
    if not data.imageUrl then
        cb({success = false, description = "No image URL provided"})
        return
    end

    -- Send to server to update avatar in database
    TriggerServerEvent(Config.ResourceName .. ':server:updateEmployeeAvatar', data.imageUrl)
    cb({success = true})
end)

-- Event handler for avatar updates - works for both menus
RegisterNetEvent(Config.ResourceName .. ':client:avatarUpdated')
AddEventHandler(Config.ResourceName .. ':client:avatarUpdated', function(imageUrl)
    -- Update cached employee data if it exists
    if cachedEmployeeData then
        cachedEmployeeData.avatar = imageUrl
    end

    -- Update cached boss data if it exists
    if cachedBossData and cachedBossData.playerData then
        cachedBossData.playerData.avatar = imageUrl
    end

    -- Send update to UI - works for both menus
    SendNUIMessage({
        action = 'updateAvatar',
        avatar = imageUrl
    })
end)

-- Main function to open the employee menu
function EmployeeMenu()
    -- Get fresh data when menu is opened
    playerJob = JobSystem.GetJob()
    playerName = CRUX.Framework.GetPlayerName()
    playerCash = CRUX.Framework.GetCash()
    playerBank = CRUX.Framework.GetBank()

    -- Check if player has the correct job
    if playerJob.name ~= Config.JobName then
        CRUX.Notify({
            title = Config.Localess.EmployeeMenu.employee_portal or "Employee Menu",
            description = config.Localess.EmployeeMenu.access_denied,
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Extract the correct grade value - need to handle both table and simple value cases
    local gradeLevel
    if type(playerJob.grade) == "table" then
        -- Try common field names for grade in the table
        if playerJob.grade.level ~= nil then
            gradeLevel = tostring(playerJob.grade.level)
        elseif playerJob.grade.id ~= nil then
            gradeLevel = tostring(playerJob.grade.id)
        elseif playerJob.grade.number ~= nil then
            gradeLevel = tostring(playerJob.grade.number)
        else
            -- If we can't find a specific field, dump the grade table to see what's available
            Client.Debug("Grade table contents: " .. json.encode(playerJob.grade))
            gradeLevel = "0" -- Default fallback
        end
    else
        -- Handle direct value case
        gradeLevel = tostring(playerJob.grade)
    end

    -- Fetch all required data before opening the employee menu
    FetchEmployeeData(function(employeeData)
        FetchLeaderboard(function(leaderboard)
            -- Get next paycheck info with proper time configuration
            local nextPaycheck = GetNextPaycheckInfo()

            -- Get role labels for displaying employee role
            local roleLabels = {}
            for gradeId, gradeInfo in pairs(Config.Grades) do
                local roleId = string.lower(gradeInfo.Label:gsub("%s+", ""))
                roleLabels[roleId] = gradeInfo.Label
            end

            -- Safely get grade name with error handling
            local gradeName = "Unknown"
            local gradeKey = gradeLevel
            if Config.Grades and Config.Grades[gradeKey] then
                gradeName = Config.Grades[gradeKey].Label
            end

            -- Get current job data directly from JobSystem
            local currentJob = JobSystem.GetJob()

            -- Prepare the data for the UI - updated to include avatar settings
            local menuData = {
                action = "openEmployeeMenu",
                PlayerData = {
                    name = playerName,
                    bank = playerBank,
                    cash = playerCash
                },
                JobData = {
                    name = playerJob.name,
                    label = playerJob.label,  -- Try to get label from current job if missing
                    grade = playerJob.grade,
                    grade_name = gradeName,
                    onduty = playerJob.onduty
                },
                locales = Config.Localess,
                locales_utils = Config.LocalessUtils,
                EmployeeData = {
                    license = employeeData.license or "",
                    name = employeeData.name or playerName,
                    role = employeeData.role or "",
                    salary = employeeData.salary or 0,
                    experience = employeeData.experience or 0,
                    performance = employeeData.performance or 75,
                    totalEarnings = employeeData.balance or 0,  -- Use balance instead of totalEarnings
                    deliveries = employeeData.deliveries or 0,
                    billings = employeeData.billings or 0,
                    balance = employeeData.balance or 0,
                    delivery_balance = employeeData.delivery_balance or 0,
                    billing_balance = employeeData.billing_balance or 0,
                    paycheck_balance = employeeData.paycheck_balance or 0,
                    avatar = employeeData.avatar or "/placeholder.svg?height=40&width=40",
                    avatarSettings = true,  -- Enable avatar settings in the UI
                },
                RoleLabels = roleLabels,
                leaderboard = leaderboard,
                paycheck = nextPaycheck,
                experienceEnabled = Config.Experience.Enabled,  -- Add this line to pass the enabled flag
            }

            -- Add debug log to see what's being sent
            Client.Debug("Sending menu data to UI: " .. json.encode(menuData))

            -- Send data to the UI and enable cursor
            SendNUIMessage(menuData)
            SetNuiFocus(true, true)
        end)
    end)
end

-- Register NUI callback for resetting paycheck timer
RegisterNUICallback('resetPaycheckTimer', function(data, cb)
    -- Get configured time
    local configuredMinutes = Config.Salaries.Time or 1
    local formattedTime = string.format("00:%02d:00", configuredMinutes)

    -- Notify server that we want to reset this player's timer
    TriggerServerEvent(Config.ResourceName .. ':server:resetPaycheckTimer')

    -- Send resetTimer flag to prevent duplicate notifications
    SendNUIMessage({
        action = 'updateDutyStatus',
        onduty = JobSystem.CurrentJob.onduty,
        resetTimer = true, -- This flag tells UI not to show notification
        paycheckTime = formattedTime,
        configuredMinutes = configuredMinutes,
        onlyOnDuty = Config.Salaries.OnlyOnDuty
    })

    cb({success = true})
end)

-- NUI Callback to handle closing the menu
RegisterNUICallback('closeEmployeeMenu', function(data, cb)
    SetNuiFocus(false, false)
    -- Unlock the employee menu on the server
    TriggerServerEvent(Config.ResourceName .. ':server:unlockEmployeeMenu')
    cb('ok')
end)

-- NUI Callback to handle toggling duty status
RegisterNUICallback('toggleDuty', function(data, cb)
    -- This sends the duty toggle event to the server
    TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
    cb({success = true})
end)

-- Add a handler for withdrawing specific balance types
RegisterNUICallback('withdrawCommission', function(data, cb)
    if type(data.amount) ~= 'number' or data.amount <= 0 then
        cb({success = false, description = 'Invalid amount'})
        return
    end

    local balanceType = data.type or 'balance' -- Default to main balance if not specified

    -- Send the withdrawal request to server
    TriggerServerEvent(Config.ResourceName .. ':server:withdrawEmployeeBalance', data.amount, balanceType)
    cb({success = true})
end)

-- Function to update job grades data in database
RegisterNUICallback('updateJobGrade', function(data, cb)
    if not data.roleId or not data.salary then
        cb({success = false, description = "Invalid grade data"})
        return
    end

    -- Send the job grade update request to the server
    TriggerServerEvent(Config.ResourceName .. ':server:updateJobGrade', data)

    cb({success = true})
end)

-- Event handler to receive grade update confirmation
RegisterNetEvent(Config.ResourceName .. ':client:jobGradeUpdated')
AddEventHandler(Config.ResourceName .. ':client:jobGradeUpdated', function(result)
    -- Send update to UI
    SendNUIMessage({
        action = 'jobGradeUpdated',
        success = result.success,
        description = result.message,
        gradeData = result.gradeData
    })
end)

-- Event handler for duty status updates
RegisterNetEvent(Config.ResourceName .. ':client:dutyStatusUpdated')
AddEventHandler(Config.ResourceName .. ':client:dutyStatusUpdated', function(isOnDuty)
    -- Update local duty status
    if playerJob then
        playerJob.onduty = isOnDuty
    end

    -- Send duty status update to UI
    SendNUIMessage({
        action = 'updateDutyStatus',
        onduty = isOnDuty
    })
end)

-- Register NUI callback for requesting paycheck at timer end
RegisterNUICallback('requestPaycheck', function(data, cb)
    -- Only request paycheck if salary system is enabled
    if Config.Salaries.Enable then
        -- Request paycheck from server - this will trigger the paycheck process
        TriggerServerEvent(Config.ResourceName .. ':server:requestPaycheck')
    else
        -- Reset the timer without requesting paycheck
        TriggerServerEvent(Config.ResourceName .. ':server:resetPaycheckTimer')
    end

    cb({success = true})
end)

-- NUI Callback to get notification preferences
RegisterNUICallback('getNotificationPreferences', function(data, cb)
    -- Store the callback in our temporary storage
    tempCallbacks.notificationPrefs = cb

    -- Request notification preferences from server
    TriggerServerEvent(Config.ResourceName .. ':server:getNotificationPreferences')
end)

-- Register permanent event handler for notification preferences
RegisterNetEvent(Config.ResourceName .. ':client:receiveNotificationPreferences')
AddEventHandler(Config.ResourceName .. ':client:receiveNotificationPreferences', function(prefs)
    Client.Debug("Received notification preferences: " .. json.encode(prefs))

    -- Check if we have a stored callback waiting for this response
    if tempCallbacks.notificationPrefs then
        -- Execute the callback with the preferences
        tempCallbacks.notificationPrefs(prefs)
        -- Clear the callback
        tempCallbacks.notificationPrefs = nil
    end
end)

-- NUI Callback to toggle notification preferences
RegisterNUICallback('toggleNotifications', function(data, cb)
    -- Add debug output
    Client.Debug("Toggling notifications to: " .. tostring(data.enabled))

    -- Store the callback
    tempCallbacks.notificationToggle = cb

    -- Send toggle request to server
    TriggerServerEvent(Config.ResourceName .. ':server:toggleNotifications', data.enabled)
end)

-- Register permanent event handler for notification toggle results
RegisterNetEvent(Config.ResourceName .. ':client:notificationToggleResult')
AddEventHandler(Config.ResourceName .. ':client:notificationToggleResult', function(result)
    Client.Debug("Received notification toggle result: " .. json.encode(result))

    -- Check if we have a stored callback waiting for this response
    if tempCallbacks.notificationToggle then
        -- Execute the callback with the result
        tempCallbacks.notificationToggle(result)
        -- Clear the callback
        tempCallbacks.notificationToggle = nil
    end
end)

-- Modify the existing paycheck event handler to respect notification settings
RegisterNetEvent(Config.ResourceName .. ':client:receivePaycheckAndUpdateTimer')
AddEventHandler(Config.ResourceName .. ':client:receivePaycheckAndUpdateTimer', function(data)
    -- Client.Debug debug info
    Client.Debug("Received paycheck: " .. json.encode(data))

    -- Play a cash register sound for paycheck regardless
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

    -- Check cached employee data for notifications setting - fix the type comparison issue
    local shouldNotify = true
    if cachedEmployeeData and (cachedEmployeeData.notifications_enabled == false or cachedEmployeeData.notifications_enabled == 0) then
        shouldNotify = false
        Client.Debug("Notifications are disabled, suppressing paycheck notification")
    end

    -- Only show notification if allowed by user preference
    if shouldNotify then
        CRUX.Notify({
            title = Config.Localess.Paycheck.title,
            description = string.format(Config.Localess.Paycheck.message, data.amount, data.jobName),
            type = "success",
            duration = 5000,
        })
    end

    -- Forward this to NUI to update the UI with new timer and handle notification
    SendNUIMessage({
        action = 'receivePaycheck',
        amount = data.amount,
        jobName = data.jobName,
        newTimer = data.newTimer,
        shouldNotify = shouldNotify -- Pass this explicitly to help UI
    })
end)

-- Also fix the regular paycheck event handler to respect notification settings
RegisterNetEvent(Config.ResourceName .. ':client:receivePaycheck')
AddEventHandler(Config.ResourceName .. ':client:receivePaycheck', function(data)
    -- Play a cash register sound for paycheck regardless
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

    -- Check cached employee data for notifications setting - consistent with the other handler
    local shouldNotify = true
    if cachedEmployeeData and (cachedEmployeeData.notifications_enabled == false or cachedEmployeeData.notifications_enabled == 0) then
        shouldNotify = false
        Client.Debug("Notifications are disabled, suppressing paycheck notification")
    end

    -- Only show notification if allowed by user preference
    if shouldNotify then
        CRUX.Notify({
            title = Config.Localess.Paycheck.title,
            description = string.format(Config.Localess.Paycheck.message, data.amount, data.jobName),
            type = "success",
            duration = 5000,
        })
    end

    -- Update UI if the employee menu is open
    SendNUIMessage({
        action = 'updatePaycheck',
        amount = data.amount,
        jobName = data.jobName,
        shouldNotify = shouldNotify -- Add this to be consistent
    })
end)

-- Add business status tracking
local businessStatus = {
    isOpen = true -- Default to open until we get actual status
}

-- Add event handler for business status changes
RegisterNetEvent(Config.ResourceName .. ':client:businessStatusChanged')
AddEventHandler(Config.ResourceName .. ':client:businessStatusChanged', function(data)
    if data.job == Config.JobName then
        businessStatus.isOpen = data.isOpen
        Client.Debug("Business status updated: " .. (data.isOpen and "OPEN" or "CLOSED"))

        -- Update paycheck timer UI if needed
        SendNUIMessage({
            action = 'updateBusinessStatus',
            isOpen = data.isOpen
        })
    end
end)

-- Add event handler to receive business status
RegisterNetEvent(Config.ResourceName .. ':client:receiveBusinessStatus')
AddEventHandler(Config.ResourceName .. ':client:receiveBusinessStatus', function(data)
    if data.job == Config.JobName then
        businessStatus.isOpen = data.isOpen
        Client.Debug("Received business status: " .. (data.isOpen and "OPEN" or "CLOSED"))
    end
end)

-- Request business status when resource starts
Citizen.CreateThread(function()
    Citizen.Wait(2000) -- Wait for other systems to initialize
    TriggerServerEvent(Config.ResourceName .. ':server:getBusinessStatus')
end)

-- Update the paycheck related code to check business status
RegisterNUICallback('requestPaycheck', function(data, cb)
    -- Only request paycheck if salary system is enabled and business is open
    if Config.Salaries.Enable then
        if businessStatus.isOpen then
            -- Request paycheck from server - this will trigger the paycheck process
            TriggerServerEvent(Config.ResourceName .. ':server:requestPaycheck')
        else
            -- Notify the player that paychecks are suspended
            CRUX.Notify({
                title = Config.Localess.Order.paycheck_suspended,
                description = Config.Localess.Order.paycheck_suspended_description,
                type = "error",
                duration = 5000,
            })

            -- Reset the timer without requesting paycheck
            TriggerServerEvent(Config.ResourceName .. ':server:resetPaycheckTimer')
        end
    else
        -- Reset the timer without requesting paycheck
        TriggerServerEvent(Config.ResourceName .. ':server:resetPaycheckTimer')
    end

    cb({success = true})
end)

-- Export the function for use in other files
exports('EmployeeMenu', EmployeeMenu)
