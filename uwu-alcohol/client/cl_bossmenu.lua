Wait(5000)

-- Initialize variables with default values
local playerJob = {name = "unemployed"}
local playerName = nil
local playerCash = nil
local playerBank = nil
local vendingMachineStatus = {
    isOpen = true -- Default to open until we get actual status
}

-- Add business status tracking
local businessStatus = {
    isOpen = true -- Default to open until we get actual status
}

-- Add a check to ensure JobSystem is loaded
Citizen.CreateThread(function()
    Wait(1000) -- Wait for JobSystem to load
    if JobSystem and JobSystem.GetJob then
        playerJob = JobSystem.GetJob()
    else
        Client.Debug("WARNING: JobSystem not available in cl_bossmenu.lua")
    end
end)

-- Storage for cached data
local cachedMenuItems = {}

-- Storage for nearby players and available roles
local cachedNearbyPlayers = {}
local cachedAvailableRoles = {}

-- Storage for business data
local cachedBusinessData = {}

-- Storage for employees
local cachedEmployees = {}

-- Storage for transactions
local cachedTransactions = {}

-- Storage for job grades
local cachedJobGrades = {}

-- Add storage for avatar URL
local playerAvatarUrl = nil
local avatarCallback = nil -- Add missing callback variable for avatar

local vendingStatusCallback = nil

local paycheckHistoryCallback = nil -- Add this line for paycheck history callback

-- Storage for vending machine items
local cachedVendingMachineItems = {}

-- Add guard to prevent repeated grade checks
local bossCheckPending = false

-- cl_bossmenu.lua

-- [ADD THIS FUNCTION]
local function FetchVendingStatus(callback)
    vendingStatusCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getVendingMachineStatus')
end

local function FetchMenuItems(callback)
    -- Store the callback for later use when we receive the response
    menuItemsCallback = callback
    -- Trigger server event to get menu items
    TriggerServerEvent(Config.ResourceName .. ':server:requestMenuItems')
end

-- Function to fetch nearby players from server
local function FetchNearbyPlayers(callback)
    TriggerServerEvent(Config.ResourceName .. ':server:getNearbyPlayers')
    nearbyPlayersCallback = callback
end

-- Function to fetch available roles from server
local function FetchAvailableRoles(callback)
    TriggerServerEvent(Config.ResourceName .. ':server:getAvailableRoles')
    availableRolesCallback = callback
end

-- Function to fetch business data from server
local function FetchBusinessData(callback)
    businessDataCallback = callback
    -- Always request fresh business status when fetching business data
    TriggerServerEvent(Config.ResourceName .. ':server:getBusinessData')
    TriggerServerEvent(Config.ResourceName .. ':server:getBusinessStatus')

    TriggerServerEvent(Config.ResourceName .. ':server:getVendingMachineStatus')
end

-- Function to fetch employees from server
local function FetchEmployees(callback)
    employeesCallback = callback

    -- Use the exported function from cl_employee_duty.lua if available
    if exports['beta'] and exports['beta'].FetchEmployeesWithDutyStatus then
        exports['beta']:FetchEmployeesWithDutyStatus(callback)
    else
        -- Fallback to the standard method if the export isn't available
        TriggerServerEvent(Config.ResourceName .. ':server:getEmployees')

        -- After a brief delay, request the duty status
        Citizen.SetTimeout(200, function()
            -- Extract license IDs from cached employees
            local licenses = {}
            if cachedEmployees and #cachedEmployees > 0 then
                for _, employee in ipairs(cachedEmployees) do
                    table.insert(licenses, employee.license)
                end

                -- Request duty status updates for all employees
                TriggerServerEvent(Config.ResourceName .. ':server:requestEmployeeDutyStatus', licenses)
            end
        end)
    end
end

-- Function to fetch transactions from server
local function FetchTransactions(callback)
    transactionsCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getTransactions')
end

-- 1. Add a retry mechanism and a flag to ensure we wait for proper data
local jobGradesReceived = false
local maxJobGradeRetries = 3

-- Function to fetch job grades from server - replace the existing function
local function FetchJobGrades(callback)
    Client.Debug("DEBUG: FetchJobGrades called")
    jobGradesReceived = false -- Reset flag
    jobGradesCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getJobGrades')

    -- Set up a retry mechanism in case we get empty data
    Citizen.CreateThread(function()
        local retryCount = 0
        while not jobGradesReceived and retryCount < maxJobGradeRetries do
            Citizen.Wait(500) -- Wait half a second between retries
            retryCount = retryCount + 1

            if not jobGradesReceived then
                Client.Debug("DEBUG: Job grades not received yet, retry " .. retryCount)
                TriggerServerEvent(Config.ResourceName .. ':server:getJobGrades') -- Retry the request
            end
        end

        if not jobGradesReceived and callback then
            Client.Debug("DEBUG: Failed to get job grades after " .. maxJobGradeRetries .. " retries")
        end
    end)
end

-- Update the event handler to set the flag when valid data is received
RegisterNetEvent(Config.ResourceName .. ':client:receiveJobGrades')
AddEventHandler(Config.ResourceName .. ':client:receiveJobGrades', function(jobGrades)
    -- Enhanced debugging to trace the data flow
    Client.Debug("DEBUG: RECEIVED JOB GRADES FROM SERVER")
    Client.Debug("DEBUG: Received raw job grades type: " .. type(jobGrades))
    local isEmpty = jobGrades == nil or next(jobGrades) == nil
    Client.Debug("DEBUG: Job grades empty? " .. tostring(isEmpty))

    -- Only process if we have actual data
    if not isEmpty then
        -- Set the flag to indicate we received valid data
        jobGradesReceived = true

        -- Always ensure we have a table, even if empty
        cachedJobGrades = jobGrades or {}

        -- Log specific roles to verify data structure
        if jobGrades and jobGrades["manager"] then
            local managerRole = jobGrades["manager"]
            Client.Debug("DEBUG: Manager grade received - isBoss value: " .. tostring(managerRole.isBoss) ..
                  " (Type: " .. type(managerRole.isBoss) .. ")")
        else
            Client.Debug("DEBUG: No manager grade found in job grades data")
        end

        -- Client.Debug some keys in the data
        local keys = {}
        if jobGrades then
            for k, _ in pairs(jobGrades) do
                table.insert(keys, k)
            end
        end
        Client.Debug("DEBUG: Job grade keys: " .. table.concat(keys, ", "))

        -- Client.Debug the full formatted data for verification
        Client.Debug("DEBUG: Full job grades received on client: " .. json.encode(cachedJobGrades))

        -- Call the original callback if it exists
        if jobGradesCallback then
            Client.Debug("DEBUG: Calling jobGradesCallback with valid data")
            jobGradesCallback(cachedJobGrades)
            jobGradesCallback = nil
        else
            Client.Debug("DEBUG: No jobGradesCallback available, but data cached for later use")
        end
    else
        Client.Debug("DEBUG: Received empty job grades data, waiting for retry or valid data")
    end
end)

-- Function to fetch paycheck history from server
local function FetchPaycheckHistory(callback)
    paycheckHistoryCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getPaycheckHistory')
end

-- Function to fetch player avatar
local function FetchPlayerAvatar(callback)
    TriggerServerEvent(Config.ResourceName .. ':server:getPlayerAvatar')
    avatarCallback = callback
end

-- Event handler for receiving avatar data
RegisterNetEvent(Config.ResourceName .. ':client:receivePlayerAvatar')
AddEventHandler(Config.ResourceName .. ':client:receivePlayerAvatar', function(avatarUrl)
    playerAvatarUrl = avatarUrl

    if avatarCallback then
        avatarCallback(avatarUrl)
        avatarCallback = nil
    end
end)

-- Event handler to receive menu items from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveMenuItems')
AddEventHandler(Config.ResourceName .. ':client:receiveMenuItems', function(menuItems)
    -- Ensure menuItems is properly formatted
    cachedMenuItems = menuItems or {}
    Client.Debug("Received menu items: " .. json.encode(cachedMenuItems))
    if menuItemsCallback then
        menuItemsCallback(cachedMenuItems)
        menuItemsCallback = nil -- Clear the callback after use
    end
end)

-- Event handler to receive nearby players from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveNearbyPlayers')
AddEventHandler(Config.ResourceName .. ':client:receiveNearbyPlayers', function(nearbyPlayers)
    cachedNearbyPlayers = nearbyPlayers or {}
    if nearbyPlayersCallback then
        nearbyPlayersCallback(cachedNearbyPlayers)
        nearbyPlayersCallback = nil
    end
end)

-- Event handler to receive available roles from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveAvailableRoles')
AddEventHandler(Config.ResourceName .. ':client:receiveAvailableRoles', function(availableRoles)
    -- Add more debugging to check values received by client
    cachedAvailableRoles = availableRoles or {}
    Client.Debug("Received available roles from server: " .. json.encode(cachedAvailableRoles))

    -- Client.Debug specific debug info for manager role (if exists)
    if cachedAvailableRoles and cachedAvailableRoles["manager"] then
        local managerRole = cachedAvailableRoles["manager"]
        Client.Debug("DEBUG: Manager role received - isBoss value: " .. tostring(managerRole.isBoss) ..
              " (Type: " .. type(managerRole.isBoss) .. ")")
    end

    if availableRolesCallback then
        availableRolesCallback(cachedAvailableRoles)
        availableRolesCallback = nil
    end
end)

-- Event handler to receive business data from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveBusinessData')
AddEventHandler(Config.ResourceName .. ':client:receiveBusinessData', function(businessData)
    cachedBusinessData = businessData or {}
    Client.Debug("Received business data: " .. json.encode(cachedBusinessData))
    if businessDataCallback then
        businessDataCallback(cachedBusinessData)
        businessDataCallback = nil
    end
end)

-- Event handler to receive employees from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveEmployees')
AddEventHandler(Config.ResourceName .. ':client:receiveEmployees', function(employees)
    cachedEmployees = employees or {}
    Client.Debug("Received employees: " .. json.encode(cachedEmployees))
    if employeesCallback then
        employeesCallback(cachedEmployees)
        employeesCallback = nil
    end
end)

-- Event handler to receive transactions from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveTransactions')
AddEventHandler(Config.ResourceName .. ':client:receiveTransactions', function(transactions)
    cachedTransactions = transactions or {}
    Client.Debug("Received transactions: " .. json.encode(cachedTransactions))
    if transactionsCallback then
        transactionsCallback(cachedTransactions)
        transactionsCallback = nil
    end

    -- Also update the NUI directly
    SendNUIMessage({
        action = "updateTransactions",
        transactions = cachedTransactions
    })
end)

-- Event handler to receive job grades from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveJobGrades')
AddEventHandler(Config.ResourceName .. ':client:receiveJobGrades', function(jobGrades)
    -- Enhanced debugging to trace the data flow
    Client.Debug("DEBUG: RECEIVED JOB GRADES FROM SERVER")
    Client.Debug("DEBUG: Received raw job grades type: " .. type(jobGrades))
    Client.Debug("DEBUG: Job grades empty? " .. tostring(jobGrades == nil or next(jobGrades) == nil))

    -- Only process if we have actual data
    if jobGrades and next(jobGrades) ~= nil then
        -- Set the flag to indicate we received valid data
        jobGradesReceived = true

        -- Always ensure we have a table, even if empty
        cachedJobGrades = jobGrades or {}

        -- Log specific roles to verify data structure
        if jobGrades and jobGrades["manager"] then
            local managerRole = jobGrades["manager"]
            Client.Debug("DEBUG: Manager grade received - isBoss value: " .. tostring(managerRole.isBoss) ..
                  " (Type: " .. type(managerRole.isBoss) .. ")")
        else
            Client.Debug("DEBUG: No manager grade found in job grades data")
        end

        -- Client.Debug some keys in the data
        local keys = {}
        if jobGrades then
            for k, _ in pairs(jobGrades) do
                table.insert(keys, k)
            end
        end
        Client.Debug("DEBUG: Job grade keys: " .. table.concat(keys, ", "))

        -- Client.Debug the full formatted data for verification
        Client.Debug("DEBUG: Full job grades received on client: " .. json.encode(cachedJobGrades))

        -- Call the original callback if it exists
        if jobGradesCallback then
            Client.Debug("DEBUG: Calling jobGradesCallback")
            jobGradesCallback(cachedJobGrades)
            jobGradesCallback = nil
        else
            Client.Debug("DEBUG: No jobGradesCallback available")
        end
    else
        Client.Debug("DEBUG: Received empty job grades data, waiting for retry or valid data")
    end
end)

-- Event handler to receive paycheck history from server
RegisterNetEvent(Config.ResourceName .. ':client:updatePaycheckHistory')
AddEventHandler(Config.ResourceName .. ':client:updatePaycheckHistory', function(data)
    local paychecks = data.paychecks or {}
    Client.Debug("Received " .. #paychecks .. " paycheck records")

    if paycheckHistoryCallback then
        paycheckHistoryCallback(paychecks)
        paycheckHistoryCallback = nil
    else
        -- If no callback but BossMenu is open, update directly
        SendNUIMessage({
            action = "updatePaycheckHistory",
            paychecks = paychecks
        })
    end
end)

-- Event handler to receive job invitations
RegisterNetEvent(Config.ResourceName .. ':client:receiveJobInvite')
AddEventHandler(Config.ResourceName .. ':client:receiveJobInvite', function(inviteData)
    Client.Debug("Received job invitation: " .. json.encode(inviteData))

    -- Send a test alert to see if NUI is reachable at all
    SendNUIMessage({
        action = 'testAlert',
        description = 'Testing NUI connection'
    })

    -- Format the role message using the Config.Localess.JobInviteNotification.message template
    local formatteddescription = string.format(Config.Localess.JobInviteNotification.message, inviteData.roleLabel)

    -- Forward the invitation to the NUI with simplified data and localized content
    SendNUIMessage({
        action = 'receiveJobInvite',
        id = tostring(inviteData.id),
        sender = tostring(inviteData.sender),
        jobName = tostring(inviteData.jobName),
        role = tostring(inviteData.role),
        roleLabel = tostring(inviteData.roleLabel),
        salary = inviteData.salary,
        grade = tostring(inviteData.grade),
        -- Add notification properties from Config.Localess
        notificationTitle = Config.LocalessUtils.JobInviteNotification.label,
        titleHeader = Config.LocalessUtils.JobInviteNotification.title,
        notificationImage = Config.LocalessUtils.JobInviteNotification.titleImage,
        description = formattedMessage,
        timeoutDuration = Config.JobInviteTimer -- Pass the configured timer value
    })

    -- Make the cursor visible for the invitation
    -- We'll hide it again when the invite is handled
    SetNuiFocus(true, true)
end)

-- NUI callback when a job invitation is accepted
RegisterNUICallback('acceptJobInvite', function(data, cb)
    Client.Debug("Job invitation accepted: " .. json.encode(data))

    -- Hide the NUI cursor when there are no more invites
    -- if data.remainingInvites <= 0 then
    --     SetNuiFocus(false, false)
    -- end

    -- Forward the acceptance to the server
    TriggerServerEvent(Config.ResourceName .. ':server:acceptJobInvite', data)

    -- Hide NUI focus after accepting (don't keep it visible)
    SetNuiFocus(false, false)
    
    -- Return success to the NUI
    cb({success = true})
end)

-- NUI callback when a job invitation is rejected
RegisterNUICallback('rejectJobInvite', function(data, cb)
    Client.Debug("Job invitation rejected: " .. json.encode(data))

    -- Hide the NUI cursor when there are no more invites
    -- if data.remainingInvites <= 0 then
    --     SetNuiFocus(false, false)
    -- end

    -- Forward the rejection to the server
    TriggerServerEvent(Config.ResourceName .. ':server:rejectJobInvite', data)
    
    -- Hide NUI focus after rejecting (don't keep it visible)
    SetNuiFocus(false, false)
    
    -- Return success to the NUI
    cb({success = true})
end)

-- NUI callback to track remaining invites
RegisterNUICallback('remainingInvitesCount', function(data, cb)
    -- if data.count <= 0 then
    --     SetNuiFocus(false, false)
    -- end
    cb('ok')
end)

-- NUI callback for withdrawing money
RegisterNUICallback('withdrawMoney', function(data, cb)
    local amount = tonumber(data.amount)
    if not amount or amount <= 0 then
        cb({ success = false, description = "Invalid amount" })
        return
    end

    -- Update player's cash/bank balances before sending request
    playerCash = CRUX.Framework.GetCash()
    playerBank = CRUX.Framework.GetBank()

    -- Pass the withdraw method to server
    TriggerServerEvent(Config.ResourceName .. ':server:withdrawMoney', amount, Config.WithdrawMoney)
    cb({ success = true })
end)

-- NUI callback for depositing money
RegisterNUICallback('depositMoney', function(data, cb)
    local amount = tonumber(data.amount)
    if not amount or amount <= 0 then
        cb({ success = false, description = "Invalid amount" })
        return
    end

    -- Update player's cash/bank balances before sending request
    playerCash = CRUX.Framework.GetCash()
    playerBank = CRUX.Framework.GetBank()

    -- Verify player has enough funds in the correct account
    local hasSufficientFunds = false
    if Config.DepositMoney == 'cash' then
        hasSufficientFunds = playerCash >= amount
    else
        hasSufficientFunds = playerBank >= amount
    end

    if not hasSufficientFunds then
        cb({ success = false, description = "Insufficient funds in " .. Config.DepositMoney .. " account" })
        return
    end

    -- Pass the deposit method to server
    TriggerServerEvent(Config.ResourceName .. ':server:depositMoney', amount, Config.DepositMoney)
    cb({ success = true })
end)

-- Add a function to refresh player's money amounts
function RefreshPlayerMoney()
    playerCash = CRUX.Framework.GetCash()
    playerBank = CRUX.Framework.GetBank()

    -- If boss menu is open, update the UI with new values
    if bossMenuActive then
        SendNUIMessage({
            action = "updatePlayerMoney",
            cash = playerCash,
            bank = playerBank
        })
    end
end

-- Register event to handle money updates from server
RegisterNetEvent(Config.ResourceName .. ':client:updatePlayerMoney')
AddEventHandler(Config.ResourceName .. ':client:updatePlayerMoney', function()
    RefreshPlayerMoney()
end)

-- Add event handler for business status updates
RegisterNetEvent(Config.ResourceName .. ':client:receiveBusinessStatus')
AddEventHandler(Config.ResourceName .. ':client:receiveBusinessStatus', function(data)
    if data.job == Config.JobName then
        businessStatus.isOpen = data.isOpen
        Client.Debug("Received business status: " .. (data.isOpen and "OPEN" or "CLOSED"))

        -- Update the UI if boss menu is open
        SendNUIMessage({
            action = 'updateBusinessStatus',
            isOpen = data.isOpen
        })
    end
end)

-- cl_bossmenu.lua

RegisterNetEvent(Config.ResourceName .. ':client:receiveVendingMachineStatus', function(data)
    -- 1. Update the local variable immediately
    vendingMachineStatus.isOpen = data.isOpen
    
    Client.Debug("Received vending machine status: " .. (data.isOpen and "OPEN" or "CLOSED"))

    -- 2. If we are in the loading chain (opening menu), release the lock
    if vendingStatusCallback then
        vendingStatusCallback(data.isOpen)
        vendingStatusCallback = nil
    end

    -- 3. Update the NUI directly if the menu is already visible
    SendNUIMessage({
        action = 'updateVendingMachineStatus',
        isOpen = data.isOpen
    })
end)

-- Add event handler for business status changes
RegisterNetEvent(Config.ResourceName .. ':client:businessStatusChanged')
AddEventHandler(Config.ResourceName .. ':client:businessStatusChanged', function(data)
    if data.job == Config.JobName then
        businessStatus.isOpen = data.isOpen
        Client.Debug("Business status changed: " .. (data.isOpen and "OPEN" or "CLOSED"))

        -- Update the UI if boss menu is open
        SendNUIMessage({
            action = 'updateBusinessStatus',
            isOpen = data.isOpen
        })
    end
end)

-- NUI callback for toggling business status
RegisterNUICallback('toggleBusinessStatus', function(data, cb)
    -- Send to server to update business status
    TriggerServerEvent(Config.ResourceName .. ':server:toggleBusinessStatus', data)
    cb({success = true})
end)

-- Add tracking variable for the boss menu
local bossMenuActive = false

-- Function to open the boss menu with all necessary data
function BossMenu()
    -- Prevent multiple claims if already active
    if bossMenuActive then
        Client.Debug("Boss menu already active, ignoring rapid open attempt")
        return
    end

    -- Get fresh data when menu is opened
    playerJob = JobSystem.GetJob()
    playerName = CRUX.Framework.GetPlayerName()
    playerCash = CRUX.Framework.GetCash()
    playerBank = CRUX.Framework.GetBank()
    Client.Debug("Full job structure: " .. json.encode(playerJob))

    -- Validate job data
    if not playerJob or not playerJob.name then
        Client.Debug("BossMenu: playerJob unavailable or malformed")
        CRUX.Notify({
            title = Config.Localess.BossMenu.title or "Boss Menu",
            description = Config.Localess.BossMenu.unable_jobdetermine or "Unable to determine your job. Please try again later.",
            type = "error",
            duration = 5000,
        })
        return
    end

    if playerJob.name == Config.JobName then
        -- Use the player's grade to verify boss permission via server (DB check)
        local grade = tonumber(playerJob.grade) or 0

        -- Prevent spamming server with repeated checks
        if bossCheckPending then
            Client.Debug("BossMenu: grade check already pending, ignoring duplicate request")
            return
        end
        bossCheckPending = true

        -- Request server to check crux_job_grades.is_boss for this job/grade
        TriggerServerEvent(Config.ResourceName .. ':server:checkGradeIsBoss', playerJob.name, grade, GetPlayerServerId(PlayerId()))
    else
        -- Notify player they don't have the correct job
        CRUX.Notify({
            title = Config.Localess.BossMenu.title or "Boss Menu",
            description = Config.Localess.BossMenu.wrong_job,
            type = "error",
            duration = 5000,
        })
    end
end

-- Handle server response for whether the grade is a boss grade
RegisterNetEvent(Config.ResourceName .. ':client:gradeIsBossResult')
AddEventHandler(Config.ResourceName .. ':client:gradeIsBossResult', function(isBoss)
    bossCheckPending = false

    if isBoss == true then
        -- Grade confirmed as boss — attempt to claim/open the boss menu
        TriggerServerEvent(Config.ResourceName .. ':server:claimBossMenu')
    else
        -- Not a boss grade
        CRUX.Notify({
            title = Config.Localess.BossMenu.title or "Boss Menu",
            description = Config.Localess.BossMenu.no_permissions,
            type = "error",
            duration = 5000,
        })
    end
end)

-- Function to open the boss menu after availability is confirmed
function ContinueOpenBossMenu()
    local serverId = GetPlayerServerId(PlayerId()) -- Add server ID for self-invite check
    
    -- Create a container for all the data we'll gather
    local menuData = {
        playerJob = {
            name = playerJob.name,
            label = playerJob.label,
            grade = playerJob.grade,
            grade_name = Config.Grades[tostring(playerJob.grade)].Label or "Unknown",
            onduty = playerJob.onduty
        },
        playerData = {
            name = playerName,
            bank = playerBank,
            cash = playerCash,
            serverId = serverId
        },
        locales = Config.Localess,
        locales_utils = Config.LocalessUtils,
        availableRoles = {},
        menuItems = {},
        nearbyPlayers = {},
        businessData = {},
        employees = {},
        transactions = {},
        paychecks = {},
        -- Initial placeholder, will be updated by FetchVendingStatus below
        vendingStatus = vendingMachineStatus.isOpen, 
        vendingMachineItems = {},  
        config = {
            depositMethod = Config.DepositMoney or 'cash', 
            withdrawMethod = Config.WithdrawMoney or 'cash' 
        }
    }

    -- Function to open the UI once we have all data
    local function OpenBossMenuUI()
        -- Format transaction locales
        menuData.transactionLocales = {
            paycheck_society = Config.LocalessUtils.Transactions.paycheck_society,
            paycheck_no_society = Config.LocalessUtils.Transactions.paycheck_no_society
        }

        -- Send the assembled data to the UI
        SendNUIMessage({
            action = "openBossMenu",
            data = menuData
        })

        -- Enable cursor and focus
        SetNuiFocus(true, true)
    end

    -- Start with fetching the job grades
    FetchJobGrades(function(jobGrades)
        -- Store the job grades
        menuData.availableRoles = jobGrades or {}

        -- Now get player avatar
        FetchPlayerAvatar(function(avatarUrl)
            menuData.playerData.avatar = avatarUrl

            -- Then get menu items
            FetchMenuItems(function(menuItems)
                menuData.menuItems = menuItems

                -- Get vending machine items
                FetchVendingMachineItems(function(vendingMachineItems)
                    menuData.vendingMachineItems = vendingMachineItems

                    -- Get nearby players
                    FetchNearbyPlayers(function(nearbyPlayers)
                        menuData.nearbyPlayers = nearbyPlayers

                        -- [CHANGED] Insert FetchVendingStatus here to ensure we wait for the result
                        FetchVendingStatus(function(isOpen)
                            -- Explicitly update the menuData with the fresh result from server
                            menuData.vendingStatus = isOpen
                            -- Also update local variable
                            vendingMachineStatus.isOpen = isOpen

                            -- Get business data
                            FetchBusinessData(function(businessData)
                                -- Make sure we have the latest business status
                                if businessData and businessStatus and businessStatus.isOpen ~= nil then
                                    businessData.isOpen = businessStatus.isOpen
                                    Client.Debug("Set business status in data: " .. (businessStatus.isOpen and "OPEN" or "CLOSED"))
                                end

                                menuData.businessData = businessData

                                -- Get employees
                                FetchEmployees(function(employees)
                                    menuData.employees = employees

                                    -- Get transactions and paychecks in parallel
                                    FetchTransactions(function(transactions)
                                        menuData.transactions = transactions

                                        FetchPaycheckHistory(function(paychecks)
                                            menuData.paychecks = paychecks

                                            -- Now that we have all data, open the menu
                                            OpenBossMenuUI()
                                        end)
                                    end)
                                end)
                            end)
                        end) -- End FetchVendingStatus
                    end)
                end)
            end)
        end)
    end)
end

-- Add handler for boss menu availability response
RegisterNetEvent(Config.ResourceName .. ':client:bossMenuAvailability')
AddEventHandler(Config.ResourceName .. ':client:bossMenuAvailability', function(data)
    if data.available then
        -- The menu is available, continue opening it
        bossMenuActive = true
        ContinueOpenBossMenu()
    else
        -- The menu is in use by someone else
        bossMenuActive = false
        CRUX.Notify({
            title = Config.Localess.BossMenu.title,
            description = string.format(Config.Localess.BossMenu.menu_in_use, data.userName),
            type = "error",
            duration = 5000,
        })
    end
end)

-- Update the close handler to release the boss menu
RegisterNUICallback('closeBossMenu', function(data, cb)
    -- Disable cursor and NUI focus when UI is closed
    SetNuiFocus(false, false)

    -- Release the boss menu if we were using it
    if bossMenuActive then
        bossMenuActive = false
        TriggerServerEvent(Config.ResourceName .. ':server:releaseBossMenu')
    end

    -- Ensure the UI knows the menu is closed
    SendNUIMessage({
        action = "bossmenuClosed"
    })

    cb('ok')
end)

-- Add a cleanup function to ensure the boss menu is properly released
function CleanupBossMenu()
    if bossMenuActive then
        bossMenuActive = false
        TriggerServerEvent(Config.ResourceName .. ':server:releaseBossMenu')
        SetNuiFocus(false, false)
    end
end

-- Handle releasing boss menu on resource stop
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        CleanupBossMenu()
    end
end)

-- Also release boss menu when player changes instances or character
AddEventHandler('playerSpawned', function()
    CleanupBossMenu()
end)

-- Add auto-release if player goes AFK or into menus
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Check every minute

        -- If boss menu is active but player is in another menu or AFK
        if bossMenuActive and (IsPauseMenuActive() or not DoesEntityExist(PlayerPedId())) then
            TriggerServerEvent(Config.ResourceName .. ':server:releaseBossMenu')
            bossMenuActive = false

            -- Remove focus if it's still active
            if hasFocus then
                SetNuiFocus(false, false)
                hasFocus = false
            end
        end
    end
end)

-- Add NUI callback for inviting employees
RegisterNUICallback('inviteEmployee', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:inviteEmployee', data.playerId, data.role)
     SetNuiFocus(true, true)
    cb({success = true})
end)

-- NUI callback for firing an employee
RegisterNUICallback('fireEmployee', function(data, cb)
    Client.Debug("Firing employee with license: " .. tostring(data.employeeLicense))
    TriggerServerEvent(Config.ResourceName .. ':server:fireEmployee', data.employeeLicense)
    cb({success = true}) -- Immediate client response for UI feedback
end)

-- Handler for closing the Boss UI
RegisterNUICallback('closeBossMenu', function(data, cb)
    -- Disable cursor and NUI focus when UI is closed
    SetNuiFocus(false, false)
    cb('ok')
end)

-- NUI callback for updating menu items
RegisterNUICallback('updateMenuItem', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:updateMenuItem', data)
    cb({success = true})
end)

-- NUI callback for deleting menu items
RegisterNUICallback('deleteMenuItem', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:deleteMenuItem', data.id)
    cb({success = true})
end)

-- NUI callback for requesting transactions
RegisterNUICallback('getTransactions', function(data, cb)
    FetchTransactions(function(transactions)
        cb({success = true, transactions = transactions})
    end)
end)

-- NUI callback for requesting paycheck history directly
RegisterNUICallback('getPaycheckHistory', function(data, cb)
    FetchPaycheckHistory(function(paychecks)
        cb({success = true, paychecks = paychecks})
    end)
end)

-- Event handler to receive business data updates from server
RegisterNetEvent(Config.ResourceName .. ':client:updateBusinessData')
AddEventHandler(Config.ResourceName .. ':client:updateBusinessData', function(businessData)
    cachedBusinessData = businessData or {}
    Client.Debug("Received business data update: " .. json.encode(cachedBusinessData))

    -- Forward the update to the UI
    SendNUIMessage({
        action = "updateBusinessData",
        businessData = businessData
    })
end)

-- Event handler to receive employee update confirmations
RegisterNetEvent(Config.ResourceName .. ':client:employeeUpdated')
AddEventHandler(Config.ResourceName .. ':client:employeeUpdated', function(employeeData)
    Client.Debug("Employee updated: " .. json.encode(employeeData))

    -- Forward the update to the NUI
    SendNUIMessage({
        action = "employeeUpdated",
        employee = employeeData
    })

    -- Re-fetch all employees to update cache
    FetchEmployees(function(employees)
        SendNUIMessage({
            action = "refreshEmployees",
            employees = employees
        })
    end)
end)

-- Event handler to receive employee firing confirmation
RegisterNetEvent(Config.ResourceName .. ':client:employeeFired')
AddEventHandler(Config.ResourceName .. ':client:employeeFired', function(data)
    if data and data.success then
        -- Send the confirmation to the NUI
        SendNUIMessage({
            action = "employeeFired",
            success = true,
            license = data.license,
            name = data.name
        })
    end
end)

-- NUI callback for updating employee data
RegisterNUICallback('updateEmployee', function(data, cb)
    Client.Debug("Updating employee: " .. json.encode(data))
    TriggerServerEvent(Config.ResourceName .. ':server:updateEmployee', data)
    cb({success = true})
end)

-- NUI callback for opening the business inventory from boss menu
RegisterNUICallback('openBusinessInventory', function(data, cb)
    Client.Debug("Opening business inventory from boss menu")

    -- Close the boss menu UI first
    SetNuiFocus(false, false)

    -- Release the boss menu so others can use it
    if bossMenuActive then
        bossMenuActive = false
        TriggerServerEvent(Config.ResourceName .. ':server:releaseBossMenu')
    end

    -- Get the storage ID from data or use default
    local storageId = data.storageId

    -- Slight delay to ensure UI is fully closed before opening inventory
    Citizen.Wait(200)

    -- Try-catch to handle any potential errors when opening inventory
    local success, error = pcall(function()
          CRUX.Inventory.OpenStash(Config.ResourceName .. Config.BossMenuInventoryStorage.label)
    end)

    if not success then
        Client.Debug("Error opening inventory: " .. tostring(error))
        cb({success = false, error = tostring(error)})
    else
        cb({success = true})
    end
end)

-- Add event handler for new shop transactions
RegisterNetEvent(Config.ResourceName .. ':client:newShopTransaction')
AddEventHandler(Config.ResourceName .. ':client:newShopTransaction', function(transactionData)
    if not transactionData then return end

    -- If boss menu is open, refresh the transactions
    SendNUIMessage({
        action = 'newShopTransaction',
        transaction = transactionData
    })

    -- Show notification about new shop transaction
    if isInZone then
        -- If player is in the shop zone, show detailed notification
        CRUX.Notify({
            title = Config.Localess.BossMenu.shop_purchase,
            description = string.format(Config.Localess.BossMenu.shop_purchase_notification_detailed,
                                    transactionData.item_name,
                                    transactionData.quantity,
                                    transactionData.sender_name,
                                    transactionData.amount),
            type = "info",
            duration = 5000,
        })
    end

  -- Refresh transactions if boss menu is open
    FetchTransactions(function() end)
end)


-- Add event handler for employee status updates
RegisterNetEvent(Config.ResourceName .. ':client:employeeStatusChanged')
AddEventHandler(Config.ResourceName .. ':client:employeeStatusChanged', function(data)
    if not data or not data.license then return end

    -- Forward the status update to the UI if boss menu is open
    SendNUIMessage({
        action = "employeeStatusChanged",
        license = data.license,
        isOnline = data.isOnline
    })

    -- Also update our cached employees list if we have it
    if cachedEmployees and #cachedEmployees > 0 then
        for i, employee in ipairs(cachedEmployees) do
            if employee.license == data.license then
                cachedEmployees[i].isOnline = data.isOnline
                break
            end
        end
    end
end)

-- Add event handler for batch employee status updates
RegisterNetEvent(Config.ResourceName .. ':client:receiveEmployeeOnlineStatus')
AddEventHandler(Config.ResourceName .. ':client:receiveEmployeeOnlineStatus', function(statuses)
    if not statuses then return end

    -- Update our cached employees list if we have it
    if cachedEmployees and #cachedEmployees > 0 then
        local updated = false
        for i, employee in ipairs(cachedEmployees) do
            if statuses[employee.license] ~= nil then
                cachedEmployees[i].isOnline = statuses[employee.license]
                updated = true
            end
        end

        -- If we updated any employees, refresh the UI
        if updated and employeesCallback then
            employeesCallback(cachedEmployees)
            employeesCallback = nil
        elseif updated then
            -- Send updates directly to NUI if no callback is waiting
            SendNUIMessage({
                action = "refreshEmployees",
                employees = cachedEmployees
            })
        end
    end
end)

-- Enhanced function to fetch employees with online status check
local function FetchEmployeesWithStatus(callback)
    employeesCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getEmployees')

    -- After a brief delay, request the latest online status
    Citizen.SetTimeout(200, function()
        -- Extract license IDs from cached employees
        local licenses = {}
        if cachedEmployees and #cachedEmployees > 0 then
            for _, employee in ipairs(cachedEmployees) do
                table.insert(licenses, employee.license)
            end

            -- Request status updates for all employees
            TriggerServerEvent(Config.ResourceName .. ':server:checkEmployeeOnlineStatus', licenses)
        end
    end)
end

-- Replace the original FetchEmployees function with our enhanced version
FetchEmployees = FetchEmployeesWithStatus

-- NEW: Add handler for real-time employee updates
RegisterNetEvent(Config.ResourceName .. ':client:newEmployeeAdded')
AddEventHandler(Config.ResourceName .. ':client:newEmployeeAdded', function(employeeData)
    -- Only process if the employee data is for our job
    if employeeData.job == Config.JobName then
        Client.Debug("New employee added/updated: " .. employeeData.name)

        -- Update the employees list if it exists
        local employeeExists = false

        if cachedEmployees and #cachedEmployees > 0 then
            -- Check if employee already exists in the list (update)
            for i, emp in ipairs(cachedEmployees) do
                if emp.license == employeeData.license then
                    -- Update existing employee
                    cachedEmployees[i] = employeeData
                    employeeExists = true
                    break
                end
            end

            -- If employee doesn't exist, add them
            if not employeeExists then
                table.insert(cachedEmployees, employeeData)
            end

            -- Send updated employees list to UI if boss menu is active
            if bossMenuActive then
                SendNUIMessage({
                    action = "refreshEmployees",
                    employees = cachedEmployees
                })
            end
        end
    end
end)

-- Update FetchEmployees to use our new duty status system

-- Replace the existing FetchEmployees function with our enhanced version
-- local function FetchEmployees(callback)
--     employeesCallback = callback

--     -- Use the exported function from cl_employee_duty.lua if available
--     if exports['beta'] and exports['beta'].FetchEmployeesWithDutyStatus then
--         exports['beta']:FetchEmployeesWithDutyStatus(callback)
--     else
--         -- Fallback to the standard method if the export isn't available
--         TriggerServerEvent(Config.ResourceName .. ':server:getEmployees')

--         -- After a brief delay, request the duty status
--         Citizen.SetTimeout(200, function()
--             -- Extract license IDs from cached employees
--             local licenses = {}
--             if cachedEmployees and #cachedEmployees > 0 then
--                 for _, employee in ipairs(cachedEmployees) do
--                     table.insert(licenses, employee.license)
--                 end

--                 -- Request duty status updates for all employees
--                 TriggerServerEvent(Config.ResourceName .. ':server:requestEmployeeDutyStatus', licenses)
--             end
--         end)
--     end
-- end

-- NUI callback for toggling employee duty status
RegisterNUICallback('toggleEmployeeDuty', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:setEmployeeDutyStatus', data.employeeLicense, data.setDuty)
    cb({success = true})
end)

-- Add event handler for duty status updates (Don't replace the existing function!)
RegisterNetEvent(Config.ResourceName .. ':client:employeeDutyStatusChanged')
AddEventHandler(Config.ResourceName .. ':client:employeeDutyStatusChanged', function(data)
    if not data or not data.license then return end

    -- Forward duty status update to the UI
    SendNUIMessage({
        action = "updateEmployeeDutyStatus",
        license = data.license,
        isOnDuty = data.isOnDuty
    })

    -- Also update our cached employees list if we have it
    if cachedEmployees and #cachedEmployees > 0 then
        for i, employee in ipairs(cachedEmployees) do
            if employee.license == data.license then
                cachedEmployees[i].isOnDuty = data.isOnDuty
                break
            end
        end
    end
end)

-- Add event handler for batch duty status updates
RegisterNetEvent(Config.ResourceName .. ':client:receiveEmployeeDutyStatus')
AddEventHandler(Config.ResourceName .. ':client:receiveEmployeeDutyStatus', function(statuses)
    if not statuses then return end

    -- Update our cached employees list if we have it
    if cachedEmployees and #cachedEmployees > 0 then
        local updated = false
        for i, employee in ipairs(cachedEmployees) do
            if statuses[employee.license] ~= nil then
                cachedEmployees[i].isOnDuty = statuses[employee.license]
                updated = true
            end
        end

        -- If we updated any employees, refresh the UI
        if updated and employeesCallback then
            employeesCallback(cachedEmployees)
            employeesCallback = nil
        elseif updated then
            -- Send updates directly to NUI if no callback is waiting
            SendNUIMessage({
                action = "refreshEmployees",
                employees = cachedEmployees
            })
        end
    end

end)
-- NUI callback for checking self-invite
RegisterNUICallback('checkSelfInvite', function(data, cb)
    local playerId = tonumber(data.playerId)
    local currentPlayerId = GetPlayerServerId(PlayerId())

    -- Check if the player is trying to invite themselves
    local isSelf = (playerId == currentPlayerId)

    cb({
        success = true,
        isSelf = isSelf
    })
end)

-- Function to fetch vending machine items from server
local function FetchVendingMachineItems(callback)
    -- Store the callback for later use when we receive the response
    vendingMachineItemsCallback = callback
    -- Trigger server event to get vending machine items
    TriggerServerEvent(Config.ResourceName .. ':server:requestVendingMachineItems')
end

-- Event handler to receive vending machine items from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveVendingMachineItems')
AddEventHandler(Config.ResourceName .. ':client:receiveVendingMachineItems', function(vendingMachineItems)
    -- Ensure vendingMachineItems is properly formatted
    cachedVendingMachineItems = vendingMachineItems or {}
    Client.Debug("Received vending machine items: " .. json.encode(cachedVendingMachineItems))
    if vendingMachineItemsCallback then
        vendingMachineItemsCallback(cachedVendingMachineItems)
        vendingMachineItemsCallback = nil -- Clear the callback after use
    end
end)

-- NUI callback for updating vending machine items
RegisterNUICallback('updateVendingMachineItem', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:updateVendingMachineItem', data)
    cb({success = true})
end)

-- NUI callback for deleting vending machine items
RegisterNUICallback('deleteVendingMachineItem', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:deleteVendingMachineItem', data.id)
    cb({success = true})
end)

function ContinueOpenBossMenu()
    local serverId = GetPlayerServerId(PlayerId())
    
    local menuData = {
        playerJob = {
            name = playerJob.name,
            label = playerJob.label,
            grade = playerJob.grade,
            grade_name = Config.Grades[tostring(playerJob.grade)].Label or "Unknown",
            onduty = playerJob.onduty
        },
        playerData = {
            name = playerName,
            bank = playerBank,
            cash = playerCash,
            serverId = serverId
        },
        locales = Config.Localess,
        locales_utils = Config.LocalessUtils,
        availableRoles = {},
        menuItems = {},
        nearbyPlayers = {},
        businessData = {},
        employees = {},
        transactions = {},
        paychecks = {},
        vendingStatus = true, -- Will be updated below
        vendingMachineItems = {},
        config = {
            depositMethod = Config.DepositMoney or 'cash',
            withdrawMethod = Config.WithdrawMoney or 'cash'
        }
    }

    local function OpenBossMenuUI()
        menuData.transactionLocales = {
            paycheck_society = Config.LocalessUtils.Transactions.paycheck_society,
            paycheck_no_society = Config.LocalessUtils.Transactions.paycheck_no_society
        }

        SendNUIMessage({
            action = "openBossMenu",
            data = menuData
        })

        SetNuiFocus(true, true)
    end

    -- Fetch job grades first
    FetchJobGrades(function(jobGrades)
        menuData.availableRoles = jobGrades or {}

        FetchPlayerAvatar(function(avatarUrl)
            menuData.playerData.avatar = avatarUrl

            FetchMenuItems(function(menuItems)
                menuData.menuItems = menuItems

                FetchVendingMachineItems(function(vendingMachineItems)
                    menuData.vendingMachineItems = vendingMachineItems

                    FetchNearbyPlayers(function(nearbyPlayers)
                        menuData.nearbyPlayers = nearbyPlayers

                        -- **FIX: Fetch vending status from server**
                        FetchVendingStatus(function(isOpen)
                            menuData.vendingStatus = isOpen
                            vendingMachineStatus.isOpen = isOpen

                            FetchBusinessData(function(businessData)
                                if businessData and businessStatus and businessStatus.isOpen ~= nil then
                                    businessData.isOpen = businessStatus.isOpen
                                end

                                menuData.businessData = businessData

                                FetchEmployees(function(employees)
                                    menuData.employees = employees

                                    FetchTransactions(function(transactions)
                                        menuData.transactions = transactions

                                        FetchPaycheckHistory(function(paychecks)
                                            menuData.paychecks = paychecks
                                            OpenBossMenuUI()
                                        end)
                                    end)
                                end)
                            end)
                        end) -- End FetchVendingStatus
                    end)
                end)
            end)
        end)
    end)
end