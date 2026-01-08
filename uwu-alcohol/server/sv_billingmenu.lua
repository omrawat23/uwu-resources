Wait(5000)

local activeBills = {}
local businessStatus = {} -- Cache for business status
local billCounter = 0 -- Counter for sequential bill IDs
local billMetadataCounter = 0 -- Counter for bill metadata IDs

-- Track which terminals and kiosks are currently in use
local terminalLocks = {}
local kioskLocks = {}
local orderManagementLocks = {} -- Add order management tablet locks

-- Helper function to check if a terminal is locked
local function IsTerminalLocked(terminalIndex)
    return terminalLocks[terminalIndex] ~= nil
end

-- Helper function to lock a terminal
local function LockTerminal(terminalIndex, playerId)
    terminalLocks[terminalIndex] = playerId
end

-- Helper function to unlock a terminal
local function UnlockTerminal(terminalIndex)
    terminalLocks[terminalIndex] = nil
end

-- Helper function to check if a kiosk is locked
local function IsKioskLocked(kioskIndex)
    return kioskLocks[kioskIndex] ~= nil
end

-- Helper function to lock a kiosk
local function LockKiosk(kioskIndex, playerId)
    kioskLocks[kioskIndex] = playerId
end

-- Helper function to unlock a kiosk
local function UnlockKiosk(kioskIndex)
    kioskLocks[kioskIndex] = nil
end

-- Helper function to check if an order management tablet is locked
local function IsOrderManagementLocked(tabletIndex)
    return orderManagementLocks[tabletIndex] ~= nil
end

-- Helper function to lock an order management tablet
local function LockOrderManagement(tabletIndex, playerId)
    orderManagementLocks[tabletIndex] = playerId
end

-- Helper function to unlock an order management tablet
local function UnlockOrderManagement(tabletIndex)
    orderManagementLocks[tabletIndex] = nil
end

-- Cleanup locks when player disconnects
AddEventHandler('playerDropped', function()
    local src = source
    
    -- Unlock any terminals locked by this player
    for terminalIndex, playerId in pairs(terminalLocks) do
        if playerId == src then
            UnlockTerminal(terminalIndex)
            Server.Debug("Unlocked billing terminal " .. terminalIndex .. " due to player disconnect")
        end
    end
    
    -- Unlock any kiosks locked by this player
    for kioskIndex, playerId in pairs(kioskLocks) do
        if playerId == src then
            UnlockKiosk(kioskIndex)
            Server.Debug("Unlocked kiosk " .. kioskIndex .. " due to player disconnect")
        end
    end

    -- Unlock any order management tablets locked by this player
    for tabletIndex, playerId in pairs(orderManagementLocks) do
        if playerId == src then
            UnlockOrderManagement(tabletIndex)
            Server.Debug("Unlocked order management tablet " .. tabletIndex .. " due to player disconnect")
        end
    end
end)

-- Function to get next order label for today
local function GetNextOrderLabel()
    local today = os.date("%Y-%m-%d")
    
    local result = MySQL.query.await(
        'SELECT COALESCE(MAX(order_label), 0) AS max_label FROM ' .. tablePrefix .. 'orders WHERE order_date = ?',
        {today}
    )
    
    local nextLabel = (result and result[1] and result[1].max_label or 0) + 1
    Server.Debug("Next order label for " .. today .. ": " .. nextLabel)
    
    return nextLabel
end

-- Add useable item for bill
CRUX.Inventory.CreateUseableItem(Config.BillItemName, function(source, item)
    Server.Debug("bill used by player: " .. source)
    TriggerClientEvent(":lib:client:OpenBillReceipt", source, item)
end)

-- Function to load business status from database
local function LoadBusinessStatus(job)
    if businessStatus[job] ~= nil then
        return businessStatus[job]
    end

    local result = MySQL.query.await('SELECT is_open FROM ' .. tablePrefix .. 'business_settings WHERE job = ?', {job})
    if result and #result > 0 then
        businessStatus[job] = result[1].is_open
    else
        -- If no record exists, create one with default status (open)
        businessStatus[job] = true
        MySQL.insert('INSERT INTO ' .. tablePrefix .. 'business_settings (job, is_open) VALUES (?, ?)', {job, true})
    end

    return businessStatus[job]
end

-- Event handler for toggling business status
RegisterNetEvent(Config.ResourceName .. ':server:toggleBusinessStatus')
AddEventHandler(Config.ResourceName .. ':server:toggleBusinessStatus', function(data)
    local src = source
    local playerJob = JobSystem.GetJob(src)

    -- Check if player is authorized (boss)
    if not playerJob or playerJob.name ~= Config.JobName or not IsPlayerBoss(src) then
        return
    end

    -- Update business status
    local isOpen = data.isOpen
    businessStatus[Config.JobName] = isOpen

    -- Update in database
    MySQL.update('INSERT INTO ' .. tablePrefix .. 'business_settings (job, is_open) VALUES (?, ?) ON DUPLICATE KEY UPDATE is_open = ?',
        {Config.JobName, isOpen, isOpen},
        function(affectedRows)
            if affectedRows <= 0 then
                Server.Debug("Failed to update business status in database")
            else
                Server.Debug("Business status updated: " .. (isOpen and "OPEN" or "CLOSED"))

                -- Broadcast to all players
                TriggerClientEvent(Config.ResourceName .. ':client:businessStatusChanged', -1, {
                    job = Config.JobName,
                    isOpen = isOpen
                })
            end
        end
    )
end)

-- Function to check if player is a boss
function IsPlayerBoss(playerId)
    local playerJob = JobSystem.GetJob(playerId)
    if not playerJob then return false end

    local gradeLevel = tostring(playerJob.grade)
    return Config.Grades[gradeLevel] and Config.Grades[gradeLevel].IsBoss
end

-- Request menu items
RegisterNetEvent(Config.ResourceName .. ':server-billing:requestMenuItems')
AddEventHandler(Config.ResourceName .. ':server-billing:requestMenuItems', function(terminalIndex)
    local src = source
    
    -- Check if a terminal index was provided (for billing terminal access)
    if terminalIndex then
        -- Check if terminal is already in use by another player
        if IsTerminalLocked(terminalIndex) then
            local lockingPlayer = terminalLocks[terminalIndex]
            if lockingPlayer ~= src then
                return CRUX.Notify(src, { 
                    title = Config.Localess.System.error, 
                    description = Config.Localess.Billing.terminal_in_use or "Billing terminal is currently in use by another player!", 
                    type = "error" 
                })
            end
        end
        
        -- Lock the terminal for this player
        LockTerminal(terminalIndex, src)
    end
    
    local menuItems = {}

    -- Execute database query to get menu items
    MySQL.query('SELECT * FROM ' .. tablePrefix .. 'menuItems', {}, function(result)
        if result and #result > 0 then
            menuItems = result
        end
        -- Send menu items back to the requesting client
        TriggerClientEvent(Config.ResourceName .. ':client-billing:receiveMenuItems', src, menuItems)
    end)
end)

-- Add event to get player avatar
RegisterNetEvent(Config.ResourceName .. ':server:getPlayerAvatar')
AddEventHandler(Config.ResourceName .. ':server:getPlayerAvatar', function()
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Query for avatar from employee table
    MySQL.query('SELECT image FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ? LIMIT 1',
        {playerIdentifier, Config.JobName},
        function(result)
            local avatarUrl = "/placeholder.svg?height=40&width=40" -- Default

            if result and #result > 0 and result[1].image then
                avatarUrl = result[1].image
                Server.Debug("Billing: Found avatar for " .. GetPlayerName(src) .. ": " .. avatarUrl)
            else
                Server.Debug("Billing: No avatar found for " .. GetPlayerName(src) .. ", using default")
            end

            -- Send the avatar URL to the client
            TriggerClientEvent(Config.ResourceName .. ':client:receivePlayerAvatar', src, avatarUrl)
        end
    )
end)

-- Event to get nearby players specifically for billing
RegisterNetEvent(Config.ResourceName .. ':server-billing:getNearbyPlayers')
AddEventHandler(Config.ResourceName .. ':server-billing:getNearbyPlayers', function()
    local src = source
    local players = {}

    -- Add the current player (self) to the list first with "(You)" indicator
    local playerName = CRUX.Framework.GetPlayerName(src)
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Get avatar for the current player
    local playerAvatar = nil
    local result = MySQL.query.await('SELECT image FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ? LIMIT 1',
        {playerIdentifier, Config.JobName})

    if result and #result > 0 and result[1].image then
        playerAvatar = result[1].image
    end

    if playerName then
        table.insert(players, {
            id = src,
            name = playerName .. " (You)",
            avatar = playerAvatar -- Include avatar
        })
    end

    -- Use configured radius (fallback to 20.0 if not set)
    local radius = tonumber(Config.NearbyPlayersRadius) or 20.0

    -- Get all other players in proximity with their avatars
    for _, playerId in ipairs(GetPlayers()) do
        local playerId = tonumber(playerId)
        -- Skip the current player as they're already added
        if playerId ~= src then
            local playerName = CRUX.Framework.GetPlayerName(playerId)
            if playerName then
                -- Check if player is within proximity
                local playerPed = GetPlayerPed(playerId)
                local sourcePed = GetPlayerPed(src)

                if #(GetEntityCoords(playerPed) - GetEntityCoords(sourcePed)) < radius then
                    -- Get nearby players with avatars
                    local targetIdentifier = CRUX.Framework.GetIdentifier(playerId)
                    local targetAvatar = nil

                    -- Try to get avatar from employee table
                    local avatarResult = MySQL.query.await('SELECT image FROM ' .. tablePrefix .. 'employees WHERE license = ? LIMIT 1',
                        {targetIdentifier})

                    if avatarResult and #avatarResult > 0 and avatarResult[1].image then
                        targetAvatar = avatarResult[1].image
                    end

                    table.insert(players, {
                        id = playerId,
                        name = playerName,
                        avatar = targetAvatar -- Include avatar if available
                    })
                end
            end
        end
    end

    Server.Debug("Sending " .. #players .. " nearby players to client")

    -- Send nearby players to the client
    TriggerClientEvent(Config.ResourceName .. ':client-billing:receiveNearbyPlayers', src, players)
end)

-- Add a new event to get employee data including commission and billing count
RegisterNetEvent(Config.ResourceName .. ':server-billing:getEmployeeData')
AddEventHandler(Config.ResourceName .. ':server-billing:getEmployeeData', function()
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Get job grade from JobSystem instead of framework
    local playerJob = JobSystem.GetJob(src)
    local jobGrade = playerJob and playerJob.grade or 0

    -- Query database for employee record and join with job_grades to get commission
    MySQL.query('SELECT e.billings, e.image, COALESCE(g.commission, 0) as commission FROM ' .. tablePrefix .. 'employees e LEFT JOIN ' .. tablePrefix .. 'job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.license = ? AND e.job = ?',
        {playerIdentifier, Config.JobName},
        function(result)
            -- Default data with placeholder avatar
            local employeeData = {
                commission = Config.Billing.Commission.percentage,
                billings = 0,
                job = Config.JobName,
                avatar = "/placeholder.svg?height=40&width=40"
            }

            -- If employee record exists in database, use those values
            if result and #result > 0 then
                if result[1].commission and result[1].commission > 0 then
                    employeeData.commission = result[1].commission
                end
                if result[1].billings then
                    employeeData.billings = result[1].billings
                end
                if result[1].image then
                    employeeData.avatar = result[1].image
                end
                Server.Debug("Sending employee data with avatar for " .. GetPlayerName(src))
            else
                -- If no record, use commission from Config based on job grade
                local gradeLevel = tostring(jobGrade)
                if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
                    employeeData.commission = Config.Grades[gradeLevel].Commission
                end

                Server.Debug("Employee record not found, sending default values")
            end

            -- Send employee data to client
            TriggerClientEvent(Config.ResourceName .. ':client-billing:receiveEmployeeData', src, employeeData)
        end
    )
end)

-- Handle bill creation
-- RegisterNetEvent(Config.ResourceName .. ':server-billing:sendBill')
-- AddEventHandler(Config.ResourceName .. ':server-billing:sendBill', function(data)
--     local src = source
--     local targetId = tonumber(data.playerId)
--     local amount = tonumber(data.amount)
--     local reason = data.reason or "Unknown"
--     local paymentMethod = data.paymentMethod or "cash"
--     local items = data.items or {}

--     -- Validate data
--     if not targetId or not amount then
--         CRUX.Notify(src, {
--             title = Config.Localess.Billing.bill_error,
--             description = "Invalid target or amount!",
--             type = "error",
--             duration = 5000,
--         })
--         return
--     end

--     -- Get player data
--     local senderPlayer = CRUX.Framework.GetPlayer(src)
--     local receiverPlayer = CRUX.Framework.GetPlayer(targetId)

--     if not senderPlayer or not receiverPlayer then
--         CRUX.Notify(src, {
--             title = Config.Localess.Billing.bill_error,
--             description = "Player not found!",
--             type = "error",
--             duration = 5000,
--         })
--         return
--     end

--     -- Get player names and identifiers
--     local senderName = CRUX.Framework.GetPlayerName(src) or "Unknown"
--     local receiverName = CRUX.Framework.GetPlayerName(targetId) or "Unknown"
--     local senderIdentifier = CRUX.Framework.GetIdentifier(src)
--     local receiverIdentifier = CRUX.Framework.GetIdentifier(targetId)

--     -- Check if the player is on duty, but only if Config.NeedDuty is true
--     local senderJob = JobSystem.GetJob(src)
--     if Config.NeedDuty and not senderJob.onduty then
--         CRUX.Notify(src, {
--             title = Config.Localess.Billing.bill_error,
--             description = "You must be on duty to send bills!",
--             type = "error",
--             duration = 5000,
--         })
--         return
--     end

--     -- Create a unique sequential bill ID starting from 1
--     billCounter = billCounter + 1
--     local billId = billCounter

--     -- Store sender's job grade for later commission calculation
--     local senderJob = JobSystem.GetJob(src)
--     local senderJobGrade = senderJob.grade or 0

--     -- Get commission directly from job grades table instead of employee record
--     MySQL.query('SELECT COALESCE(commission, 0) as commission FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? AND grade = ?',
--         {Config.JobName, senderJobGrade},
--         function(result)
--             local commissionPercentage = 0

--             if result and #result > 0 then
--                 commissionPercentage = result[1].commission
--                 Server.Debug("[COMMISSION] Using job grade commission from DB: " .. commissionPercentage .. "%")
--             else
--                 -- Fallback to config values
--                 local gradeLevel = tostring(senderJobGrade)
--                 if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
--                     commissionPercentage = Config.Grades[gradeLevel].Commission
--                     Server.Debug("[COMMISSION] Using config commission: " .. commissionPercentage .. "%")
--                 else
--                     commissionPercentage = Config.Billing.Commission.percentage or 0
--                     Server.Debug("[COMMISSION] Using default commission: " .. commissionPercentage .. "%")
--                 end
--             end

--             -- Store the bill information with correct commission
--             activeBills[billId] = {
--                 id = billId,
--                 sender_id = src,
--                 sender_name = senderName,
--                 sender_identifier = senderIdentifier,
--                 receiver_id = targetId,
--                 receiver_name = receiverName,
--                 receiver_identifier = receiverIdentifier,
--                 amount = amount,
--                 reason = reason,
--                 payment_method = paymentMethod,
--                 items = items,
--                 commission_percentage = commissionPercentage,
--                 job = Config.JobName,
--                 timestamp = os.time()
--             }

--             Server.Debug("Bill created with " .. commissionPercentage .. "% commission rate")

--             -- Log billing attempt
--             TriggerEvent('crux_lib:discordLog',
--                 "billingAttempt",
--                 "📋 Bill Sent",
--                 senderIdentifier .. " (" .. senderName .. ") sent a bill to " .. receiverIdentifier .. " (" .. receiverName .. ")",
--                 {
--                     {
--                         ["name"] = "Sender",
--                         ["value"] = senderIdentifier .. " (" .. senderName .. ")",
--                         ["inline"] = true
--                     },
--                     {
--                         ["name"] = "Receiver",
--                         ["value"] = receiverIdentifier .. " (" .. receiverName .. ")",
--                         ["inline"] = true
--                     },
--                     {
--                         ["name"] = "Amount",
--                         ["value"] = "$" .. amount,
--                         ["inline"] = true
--                     },
--                     {
--                         ["name"] = "Payment Method",
--                         ["value"] = paymentMethod,
--                         ["inline"] = true
--                     },
--                     {
--                         ["name"] = "Commission Rate",
--                         ["value"] = commissionPercentage .. "%",
--                         ["inline"] = true
--                     },
--                     {
--                         ["name"] = "Reason",
--                         ["value"] = reason,
--                         ["inline"] = false
--                     }
--                 },
--                 Config.DiscordLogging.color.billing,
--                 src
--             )

--             -- Generate personalized greeting
--             local greeting = "Hello there"
--             local hour = tonumber(os.date("%H"))
--             if hour >= 5 and hour < 12 then
--                 greeting = "Good morning"
--             elseif hour >= 12 and hour < 18 then
--                 greeting = "Good afternoon"
--             else
--                 greeting = "Good evening"
--             end

--             -- Send enhanced bill notification to the receiving player
--             TriggerClientEvent(Config.ResourceName .. ':client-billing:receiveBill', targetId, {
--                 id = billId,
--                 sender = senderName,
--                 amount = amount,
--                 reason = reason,
--                 paymentMethod = paymentMethod,
--                 greeting = greeting,
--                 businessName = Config.JobLabel,
--                 items = items
--             })

--             -- Notify sender that bill was sent with enhanced message
--             CRUX.Notify(src, {
--                 title = "Bill Sent",
--                 description = "You sent a bill of $" .. amount .. " to " .. receiverName .. " for " .. reason,
--                 type = "success",
--                 duration = 5000,
--             })
--         end
--     )
-- end)

-- Function to check if player is a boss
function IsPlayerBoss(playerId)
    local playerJob = JobSystem.GetJob(playerId)
    if not playerJob then return false end

    local gradeLevel = tostring(playerJob.grade)
    return Config.Grades[gradeLevel] and Config.Grades[gradeLevel].IsBoss
end

-- -- Request menu items
-- RegisterNetEvent(Config.ResourceName .. ':server-billing:requestMenuItems')
-- AddEventHandler(Config.ResourceName .. ':server-billing:requestMenuItems', function(terminalIndex)
--     local src = source
    
--     -- Check if a terminal index was provided (for billing terminal access)
--     if terminalIndex then
--         -- Check if terminal is already in use by another player
--         if IsTerminalLocked(terminalIndex) then
--             local lockingPlayer = terminalLocks[terminalIndex]
--             if lockingPlayer ~= src then
--                 return CRUX.Notify(src, { 
--                     title = Config.Localess.System.error, 
--                     description = Config.Localess.Billing.terminal_in_use or "Billing terminal is currently in use by another player!", 
--                     type = "error" 
--                 })
--             end
--         end
        
--         -- Lock the terminal for this player
--         LockTerminal(terminalIndex, src)
--     end
    
--     local menuItems = {}

--     -- Execute database query to get menu items
--     MySQL.query('SELECT * FROM ' .. tablePrefix .. 'menuItems', {}, function(result)
--         if result and #result > 0 then
--             menuItems = result
--         end
--         -- Send menu items back to the requesting client
--         TriggerClientEvent(Config.ResourceName .. ':client-billing:receiveMenuItems', src, menuItems)
--     end)
-- end)

-- Add event to get player avatar
RegisterNetEvent(Config.ResourceName .. ':server:getPlayerAvatar')
AddEventHandler(Config.ResourceName .. ':server:getPlayerAvatar', function()
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Query for avatar from employee table
    MySQL.query('SELECT image FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ? LIMIT 1',
        {playerIdentifier, Config.JobName},
        function(result)
            local avatarUrl = "/placeholder.svg?height=40&width=40" -- Default

            if result and #result > 0 and result[1].image then
                avatarUrl = result[1].image
                Server.Debug("Billing: Found avatar for " .. GetPlayerName(src) .. ": " .. avatarUrl)
            else
                Server.Debug("Billing: No avatar found for " .. GetPlayerName(src) .. ", using default")
            end

            -- Send the avatar URL to the client
            TriggerClientEvent(Config.ResourceName .. ':client:receivePlayerAvatar', src, avatarUrl)
        end
    )
end)

-- Event to get nearby players specifically for billing
RegisterNetEvent(Config.ResourceName .. ':server-billing:getNearbyPlayers')
AddEventHandler(Config.ResourceName .. ':server-billing:getNearbyPlayers', function()
    local src = source
    local players = {}

    -- Add the current player (self) to the list first with "(You)" indicator
    local playerName = CRUX.Framework.GetPlayerName(src)
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Get avatar for the current player
    local playerAvatar = nil
    local result = MySQL.query.await('SELECT image FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ? LIMIT 1',
        {playerIdentifier, Config.JobName})

    if result and #result > 0 and result[1].image then
        playerAvatar = result[1].image
    end

    if playerName then
        table.insert(players, {
            id = src,
            name = playerName .. " (You)",
            avatar = playerAvatar -- Include avatar
        })
    end

    -- Use configured radius (fallback to 20.0 if not set)
    local radius = tonumber(Config.NearbyPlayersRadius) or 20.0

    -- Get all other players in proximity with their avatars
    for _, playerId in ipairs(GetPlayers()) do
        local playerId = tonumber(playerId)
        -- Skip the current player as they're already added
        if playerId ~= src then
            local playerName = CRUX.Framework.GetPlayerName(playerId)
            if playerName then
                -- Check if player is within proximity
                local playerPed = GetPlayerPed(playerId)
                local sourcePed = GetPlayerPed(src)

                if #(GetEntityCoords(playerPed) - GetEntityCoords(sourcePed)) < radius then
                    -- Get nearby players with avatars
                    local targetIdentifier = CRUX.Framework.GetIdentifier(playerId)
                    local targetAvatar = nil

                    -- Try to get avatar from employee table
                    local avatarResult = MySQL.query.await('SELECT image FROM ' .. tablePrefix .. 'employees WHERE license = ? LIMIT 1',
                        {targetIdentifier})

                    if avatarResult and #avatarResult > 0 and avatarResult[1].image then
                        targetAvatar = avatarResult[1].image
                    end

                    table.insert(players, {
                        id = playerId,
                        name = playerName,
                        avatar = targetAvatar -- Include avatar if available
                    })
                end
            end
        end
    end

    Server.Debug("Sending " .. #players .. " nearby players to client")

    -- Send nearby players to the client
    TriggerClientEvent(Config.ResourceName .. ':client-billing:receiveNearbyPlayers', src, players)
end)

-- Add a new event to get employee data including commission and billing count
RegisterNetEvent(Config.ResourceName .. ':server-billing:getEmployeeData')
AddEventHandler(Config.ResourceName .. ':server-billing:getEmployeeData', function()
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Get job grade from JobSystem instead of framework
    local playerJob = JobSystem.GetJob(src)
    local jobGrade = playerJob and playerJob.grade or 0

    -- Query database for employee record and join with job_grades to get commission
    MySQL.query('SELECT e.billings, e.image, COALESCE(g.commission, 0) as commission FROM ' .. tablePrefix .. 'employees e LEFT JOIN ' .. tablePrefix .. 'job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.license = ? AND e.job = ?',
        {playerIdentifier, Config.JobName},
        function(result)
            -- Default data with placeholder avatar
            local employeeData = {
                commission = Config.Billing.Commission.percentage,
                billings = 0,
                job = Config.JobName,
                avatar = "/placeholder.svg?height=40&width=40"
            }

            -- If employee record exists in database, use those values
            if result and #result > 0 then
                if result[1].commission and result[1].commission > 0 then
                    employeeData.commission = result[1].commission
                end
                if result[1].billings then
                    employeeData.billings = result[1].billings
                end
                if result[1].image then
                    employeeData.avatar = result[1].image
                end
                Server.Debug("Sending employee data with avatar for " .. GetPlayerName(src))
            else
                -- If no record, use commission from Config based on job grade
                local gradeLevel = tostring(jobGrade)
                if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
                    employeeData.commission = Config.Grades[gradeLevel].Commission
                end

                Server.Debug("Employee record not found, sending default values")
            end

            -- Send employee data to client
            TriggerClientEvent(Config.ResourceName .. ':client-billing:receiveEmployeeData', src, employeeData)
        end
    )
end)

-- Handle bill creation
RegisterNetEvent(Config.ResourceName .. ':server-billing:sendBill')
AddEventHandler(Config.ResourceName .. ':server-billing:sendBill', function(data)
    local src = source
    local targetId = tonumber(data.playerId)
    local amount = tonumber(data.amount)
    local reason = data.reason or "Unknown"
    local paymentMethod = data.paymentMethod or "cash"
    local items = data.items or {}

    -- Validate data
    if not targetId or not amount then
        CRUX.Notify(src, {
            title = Config.Localess.Billing.bill_error,
            description = Config.Localess.Billing.invalid_target_amount,
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Get player data
    local senderPlayer = CRUX.Framework.GetPlayer(src)
    local receiverPlayer = CRUX.Framework.GetPlayer(targetId)

    if not senderPlayer or not receiverPlayer then
        CRUX.Notify(src, {
            title = Config.Localess.Billing.bill_error,
            description = Config.Localess.Billing.player_not_found,
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Get player names and identifiers
    local senderName = CRUX.Framework.GetPlayerName(src) or "Unknown"
    local receiverName = CRUX.Framework.GetPlayerName(targetId) or "Unknown"
    local senderIdentifier = CRUX.Framework.GetIdentifier(src)
    local receiverIdentifier = CRUX.Framework.GetIdentifier(targetId)

    -- Check if the player is on duty, but only if Config.NeedDuty is true
    local senderJob = JobSystem.GetJob(src)
    if Config.NeedDuty and not senderJob.onduty then
        CRUX.Notify(src, {
            title = Config.Localess.Billing.bill_error,
            description = Config.Localess.Billing.must_be_on_duty,
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Create a unique sequential bill ID starting from 1
    billCounter = billCounter + 1
    local billId = billCounter

    -- Store sender's job grade for later commission calculation
    local senderJob = JobSystem.GetJob(src)
    local senderJobGrade = senderJob.grade or 0

    -- Get commission directly from job grades table instead of employee record
    MySQL.query('SELECT COALESCE(commission, 0) as commission FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? AND grade = ?',
        {Config.JobName, senderJobGrade},
        function(result)
            local commissionPercentage = 0

            if result and #result > 0 then
                commissionPercentage = result[1].commission
                Server.Debug("[COMMISSION] Using job grade commission from DB: " .. commissionPercentage .. "%")
            else
                -- Fallback to config values
                local gradeLevel = tostring(senderJobGrade)
                if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
                    commissionPercentage = Config.Grades[gradeLevel].Commission
                    Server.Debug("[COMMISSION] Using config commission: " .. commissionPercentage .. "%")
                else
                    commissionPercentage = Config.Billing.Commission.percentage or 0
                    Server.Debug("[COMMISSION] Using default commission: " .. commissionPercentage .. "%")
                end
            end

            -- Store the bill information with correct commission
            activeBills[billId] = {
                id = billId,
                sender_id = src,
                sender_name = senderName,
                sender_identifier = senderIdentifier,
                receiver_id = targetId,
                receiver_name = receiverName,
                receiver_identifier = receiverIdentifier,
                amount = amount,
                reason = reason,
                payment_method = paymentMethod,
                items = items,
                commission_percentage = commissionPercentage,
                job = Config.JobName,
                timestamp = os.time()
            }

            Server.Debug("Bill created with " .. commissionPercentage .. "% commission rate")

            -- Log billing attempt
            TriggerEvent('crux_lib:discordLog',
                "billingAttempt",
                "📋 Bill Sent",
                senderIdentifier .. " (" .. senderName .. ") sent a bill to " .. receiverIdentifier .. " (" .. receiverName .. ")",
                {
                    {
                        ["name"] = "Sender",
                        ["value"] = senderIdentifier .. " (" .. senderName .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Receiver",
                        ["value"] = receiverIdentifier .. " (" .. receiverName .. ")",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Amount",
                        ["value"] = "$" .. amount,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Payment Method",
                        ["value"] = paymentMethod,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Commission Rate",
                        ["value"] = commissionPercentage .. "%",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Reason",
                        ["value"] = reason,
                        ["inline"] = false
                    }
                },
                Config.DiscordLogging.color.billing,
                Config.DiscordLogging
            )

            -- Generate personalized greeting
            local greeting = "Hello there"
            local hour = tonumber(os.date("%H"))
            if hour >= 5 and hour < 12 then
                greeting = "Good morning"
            elseif hour >= 12 and hour < 18 then
                greeting = "Good afternoon"
            else
                greeting = "Good evening"
            end

            -- Send enhanced bill notification to the receiving player
            TriggerClientEvent(Config.ResourceName .. ':client-billing:receiveBill', targetId, {
                id = billId,
                sender = senderName,
                amount = amount,
                reason = reason,
                paymentMethod = paymentMethod,
                greeting = greeting,
                businessName = Config.JobLabel,
                items = items
            })

            -- Notify sender that bill was sent with enhanced message
            CRUX.Notify(src, {
                title = Config.Localess.Billing.bill_sent_title,
                description = string.format(Config.Localess.Billing.bill_sent_description, amount, receiverName, reason),
                type = "success",
                duration = 5000,
            })
        end
    )
end)

-- Function to process payment, update business balance, handle commissions, etc.
-- [CHANGED] Function now accepts orderLabel and orderDate
function ProcessPayment(bill, orderLabel, orderDate)
    local amount = bill.amount
    local commissionAmount = bill.commission_amount or 0
    local businessAmount = amount - commissionAmount

    -- Update business balance with the revenue (minus commission)
    MySQL.update('UPDATE ' .. tablePrefix .. 'bossmenu SET balance = balance + ? WHERE id = ?',
        {businessAmount, Config.JobName},
        function(affectedRows)
            if affectedRows <= 0 then
                Server.Debug("Error updating business balance for " .. Config.JobName)
            else
                Server.Debug("Successfully added $" .. businessAmount .. " to business account")
            end
        end
    )

    -- Add commission to the sender if enabled and commission amount is positive
    if Config.Billing.Commission.enabled and commissionAmount > 0 and bill.sender_id > 0 then
        local senderPlayer = CRUX.Framework.GetPlayer(bill.sender_id)
        if senderPlayer then
            -- Get player's commission rate - use what was calculated for the bill
            local commissionRate = bill.commission_percentage or 0

            -- Update employee's balance in the database - add to balance and billing_balance
            -- ALSO increment the billings counter ONLY when bill is paid
            MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET balance = balance + ?, billing_balance = billing_balance + ?, billings = billings + 1 WHERE license = ? AND job = ?',
                {commissionAmount, commissionAmount, bill.sender_identifier, Config.JobName},
                function(affectedRows)
                    if affectedRows <= 0 then
                        Server.Debug("Error updating employee balance for license: " .. bill.sender_identifier)
                        -- Create employee record if it doesn't exist
                        Server.Debug("Attempting to create new employee record with commission rate: " .. commissionRate .. "%")
                        MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, balance, billing_balance, billings, name, role, salary, experience, job, commission) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                            {bill.sender_identifier, commissionAmount, commissionAmount, 1, bill.sender_name, "Employee", 0, 0, Config.JobName, commissionRate},
                            function(id)
                                if not id then
                                    Server.Debug("Error creating employee record")
                                else
                                    Server.Debug("Created new employee record with commission: $" .. commissionAmount .. " (" .. commissionRate .. "%) and 1 billing")
                                end
                            end
                        )
                    else
                        Server.Debug("Successfully added $" .. commissionAmount .. " to employee balance and billing_balance, and incremented billing count")
                    end
                end
            )
        end
    else
        -- Even if commission is not enabled, still increment the billings counter
        MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET billings = billings + 1 WHERE license = ? AND job = ?',
            {bill.sender_identifier, Config.JobName},
            function(affectedRows)
                if affectedRows <= 0 then
                    Server.Debug("Error updating employee billing count for license: " .. bill.sender_identifier)
                    -- Create employee record if it doesn't exist (with billings = 1)
                    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, job, billings) VALUES (?, ?, ?, ?)',
                        {bill.sender_identifier, bill.sender_name, Config.JobName, 1},
                        function(id)
                            if id then
                                Server.Debug("Created new employee record with billing count: 1")
                            else
                                Server.Debug("Error creating employee record")
                            end
                        end
                    )
                else
                    Server.Debug("Successfully incremented billing count for employee: " .. bill.sender_name)
                end
            end
        )
    end

    if Config.Billing.Experience.enabled and amount >= Config.Billing.Experience.mincartvaluetoaddexperience and bill.sender_identifier then
        -- Add experience to sender's employee record
        MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET experience = experience + ? WHERE license = ? AND job = ?',
            {Config.Billing.Experience.experienceperbill, bill.sender_identifier, Config.JobName},
            function(affectedRows)
                if affectedRows <= 0 then
                    Server.Debug("Error updating employee experience for license: " .. bill.sender_identifier)
                else
                    -- Notify the sender about earning experience points
                    if bill.sender_id > 0 and GetPlayerPing(bill.sender_id) > 0 then
                        CRUX.Notify(bill.sender_id, {
                            title = Config.Localess.Experience.gained_title,
                            description = string.format(Config.Localess.Experience.experience_earned_description, Config.Billing.Experience.experienceperbill),
                            type = "success",
                            duration = 5000,
                        })

                        -- Trigger promotion check after experience gain
                        if Config.Experience and Config.Experience.Enabled then
                            TriggerEvent(Config.ResourceName .. ':server:experienceEarned', bill.sender_id, Config.Billing.Experience.experienceperbill)

                            -- Direct function call alternative
                            if _G.ExperienceSystem and _G.ExperienceSystem.CheckForPromotion then
                                _G.ExperienceSystem.CheckForPromotion(bill.sender_id)
                            end
                        end
                    end
                end
            end
        )
    end

    -- [START NEW CODE] - Insert the order into the database after payment
    -- Generate a unique sequential order_id starting from 1
    MySQL.query('SELECT COALESCE(MAX(order_id), 0) AS max_id FROM ' .. tablePrefix .. 'orders', {}, function(result)
        local newOrderId = (result and result[1] and result[1].max_id or 0) + 1
        local itemsJson = json.encode(bill.items or {})
        
        -- [CHANGED] Removed local generation of orderLabel and orderDate
        
        MySQL.insert(
            'INSERT INTO ' .. tablePrefix .. 'orders (order_id, order_label, order_date, customer_name, customer_identifier, employee_identifier, items, total_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
            {
                newOrderId,
                orderLabel, -- [CHANGED] Use passed-in orderLabel
                orderDate,  -- [CHANGED] Use passed-in orderDate
                bill.receiver_name,
                bill.receiver_identifier,
                bill.sender_identifier,
                itemsJson,
                bill.amount,
                'cooking'
            },
            function(insertId)
                if insertId then
                    Server.Debug(('Successfully created order with ID: %s, Label: #%03d'):format(newOrderId, orderLabel))
                    -- Refresh the order list for all clients
                    TriggerEvent(Config.ResourceName .. ':server:refreshOrders')
                else
                    Server.Debug(('Failed to create order for bill ID: %s'):format(bill.id))
                end
            end
        )
    end)
    -- [END NEW CODE]
    
    -- Record the transaction in the database
    local itemsJsonTransaction = json.encode(bill.items)
    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'transactions (sender_identifier, sender_name, receiver_identifier, receiver_name, amount, commission_amount, reason, payment_method, items, job, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())',
        {bill.sender_identifier, bill.sender_name, bill.receiver_identifier, bill.receiver_name, amount, commissionAmount, bill.reason, bill.payment_method, itemsJsonTransaction, Config.JobName},
        function(id)
            if not id then
                Server.Debug("Error recording transaction")
            end
        end
    )
end

-- New function to process payment after commission calculation
function ProcessPaymentWithCommission(src, bill, billAmount, commissionAmount)
    -- [ADDED] Get the order label and date *before* any payment logic
    local orderLabel = GetNextOrderLabel()
    local orderDate = os.date("%Y-%m-%d")
    local totalAmount = billAmount  -- Total amount to charge the customer

    -- Check if player has enough money based on payment method
    local paymentSuccessful = false
    local paymentMethod = bill.payment_method

    if paymentMethod == "cash" then
        if CRUX.Framework.GetMoney(src, 'cash') >= totalAmount then
            CRUX.Framework.RemoveMoney(src, 'cash', totalAmount)
            paymentSuccessful = true
            
            if CRUX.Society and CRUX.Society.AddTransaction then
                CRUX.Society.AddTransaction(
                    Config.JobName,
                    Config.JobName,
                    CRUX.Framework.GetPlayerName(src),
                    CRUX.Framework.GetIdentifier(src),
                    totalAmount,
                    "Invoice Payment",
                    src
                )
            end
            Server.Debug("Invoice Transaction Data:")
            Server.Debug("receiver_name:", Config.JobName)
            Server.Debug("receiver_identifier:", CRUX.Framework.GetIdentifier(bill.sender_id))
            Server.Debug("sender_name:", CRUX.Framework.GetPlayerName(src))
            Server.Debug("sender_identifier:", CRUX.Framework.GetIdentifier(src))
            Server.Debug("value:", totalAmount)
            Server.Debug("reason:", "Invoice Payment")
            Server.Debug("targetId:", src)
        end
    elseif paymentMethod == "bank" then
        if CRUX.Framework.GetMoney(src, 'bank') >= totalAmount then
            CRUX.Framework.RemoveMoney(src, 'bank', totalAmount)
            paymentSuccessful = true
            
            if CRUX.Society and CRUX.Society.AddTransaction then
                CRUX.Society.AddTransaction(
                    Config.JobName,
                    Config.JobName,
                    CRUX.Framework.GetPlayerName(src),
                    CRUX.Framework.GetIdentifier(src),
                    totalAmount,
                    "Invoice Payment",
                    src
                )
            end
            Server.Debug("Invoice Transaction Data:")
            Server.Debug("receiver_name:", Config.JobName)
            Server.Debug("receiver_identifier:", CRUX.Framework.GetIdentifier(bill.sender_id))
            Server.Debug("sender_name:", CRUX.Framework.GetPlayerName(src))
            Server.Debug("sender_identifier:", CRUX.Framework.GetIdentifier(src))
            Server.Debug("value:", totalAmount)
            Server.Debug("reason:", "Invoice Payment")
            Server.Debug("targetId:", src)
        end
    end

    if not paymentSuccessful then
        -- Log billing failure - insufficient funds
        TriggerEvent('crux_lib:discordLog',
            "billingFailure",
            "❌ Bill Payment Failed - Insufficient Funds",
            CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ") failed to pay bill",
            {
                {
                    ["name"] = "Payer",
                    ["value"] = CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Bill Sender",
                    ["value"] = bill.sender_identifier .. " (" .. bill.sender_name .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Amount",
                    ["value"] = "$" .. totalAmount,
                    ["inline"] = true
                },
                {
                    ["name"] = "Payment Method",
                    ["value"] = paymentMethod,
                    ["inline"] = true
                },
                {
                    ["name"] = "Failure Reason",
                    ["value"] = "Not enough funds in " .. paymentMethod,
                    ["inline"] = false
                },
                {
                    ["name"] = "Bill Reason",
                    ["value"] = bill.reason,
                    ["inline"] = false
                }
            },
            Config.DiscordLogging.color.billing,
            Config.DiscordLogging
        )

        CRUX.Notify(src, {
            title = Config.Localess.Billing.payment_failed,
            description = string.format(Config.Localess.Billing.insufficient_funds, paymentMethod == "cash" and "cash" or "money in your bank account"),
            type = "error",
            duration = 5000,
        })

        -- [ADDED] Notify the sender that the payment failed due to insufficient funds
        if bill.sender_id > 0 then
            local senderIsOnline = GetPlayerPing(bill.sender_id) > 0
            if senderIsOnline then
                CRUX.Notify(bill.sender_id, {
                    title = Config.Localess.Billing.payment_failed,
                    description = string.format(Config.Localess.Billing.payment_failed_byreceiver, bill.receiver_name, paymentMethod),
                    type = "error",
                    duration = 5000,
                })
            end
        end

        return
    end

    -- Log successful billing payment
    TriggerEvent('crux_lib:discordLog',
        "billingPayment",
        "✅ Bill Payment Successful",
        CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ") paid a bill",
        {
            {
                ["name"] = "Payer",
                ["value"] = CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Bill Sender",
                ["value"] = bill.sender_identifier .. " (" .. bill.sender_name .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Amount Paid",
                ["value"] = "$" .. totalAmount,
                ["inline"] = true
            },
            {
                ["name"] = "Payment Method",
                ["value"] = paymentMethod,
                ["inline"] = true
            },
            {
                ["name"] = "Commission",
                ["value"] = "$" .. commissionAmount .. " (" .. (bill.commission_percentage or 0) .. "%)",
                ["inline"] = true
            },
            {
                ["name"] = "Business Revenue",
                ["value"] = "$" .. (totalAmount - commissionAmount),
                ["inline"] = true
            },
            {
                ["name"] = "Bill Reason",
                ["value"] = bill.reason,
                ["inline"] = false
            }
        },
        Config.DiscordLogging.color.billing,
        Config.DiscordLogging
    )

    -- Process the successful payment
    -- [CHANGED] Pass the generated orderLabel and orderDate to ProcessPayment
    ProcessPayment(bill, orderLabel, orderDate)

    -- Notify the paying player of the total amount
    -- CRUX.Notify(src, {
    --     title = "Bill Paid",
    --     description = "You paid $" .. totalAmount .. " for " .. bill.reason,
    --     type = "success",
    --     duration = 5000,
    -- })

    -- Notify the sender that payment was received
    if bill.sender_id > 0 then
        local senderIsOnline = GetPlayerPing(bill.sender_id) > 0
        if senderIsOnline then
            TriggerClientEvent(Config.ResourceName .. ':client-billing:billPaid', bill.sender_id, {
                success = true,
                amount = billAmount,
                playerName = bill.receiver_name
            })
        end
    end

    -- Add bill item to player's inventory with metadata
    billMetadataCounter = billMetadataCounter + 1
    local billMetadata = {
        id = billMetadataCounter,
        order_label = orderLabel, -- [ADDED] Add the order_label to the metadata
        sender = bill.sender_name,
        amount = bill.amount,
        paymentMethod = bill.payment_method,
        reason = bill.reason,
        businessName = bill.job, -- Assuming job is business name
        items = bill.items and json.encode(
            (function(items)
            local filtered = {}
            for _, item in ipairs(items) do
                table.insert(filtered, {
                label = item.label,
                quantity = item.quantity,
                price = item.price
                })
            end
            return filtered
            end)(bill.items)
        ) or "",
        date = os.date("%Y-%m-%d %H:%M:%S"),
        terminalType = "Billing Terminal (" .. (bill.terminalIndex or "1") .. ")"  -- Include index in type
    }
    Server.Debug(json.encode(billMetadata))
    CRUX.Inventory.AddItem(src, Config.BillItemName, 1, billMetadata) -- Add item with metadata

    -- Clear the bill from active bills
    -- activeBills[billId] = nil
end
-- Handle bill acceptance/payment
RegisterNetEvent(Config.ResourceName .. ':server-billing:acceptBill')
AddEventHandler(Config.ResourceName .. ':server-billing:acceptBill', function(billId)
    local src = source
    local bill = activeBills[billId]

    if not bill then
        CRUX.Notify(src, {
            title = Config.Localess.Billing.bill_error,
            description = Config.Localess.Billing.invalid_bill,
            type = "error",
            duration = 5000,
        })
        return
    end

    local receiverPlayer = CRUX.Framework.GetPlayer(src)
    if not receiverPlayer then return end

    -- Calculate the bill amount and commission
    local billAmount = bill.amount
    local commissionAmount = 0
    local totalAmount = billAmount  -- Total amount to charge the customer

    -- Get sender's commission rate from database or job grade
    if Config.Billing.Commission.enabled and bill.sender_id > 0 then
        -- Get job grade from JobSystem
        local senderJob = GetPlayerPing(bill.sender_id) > 0 and JobSystem.GetJob(bill.sender_id) or nil
        local senderJobGrade = senderJob and senderJob.grade or 0

        -- Get commission directly from job grades table
        MySQL.query('SELECT COALESCE(commission, 0) as commission FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? AND grade = ?',
            {Config.JobName, senderJobGrade},
            function(result)
                local commissionPercentage = 0

                if result and #result > 0 then
                    commissionPercentage = result[1].commission
                    Server.Debug("[COMMISSION] Using job grade commission from DB: " .. commissionPercentage .. "%")
                else
                    -- Fallback to config values
                    local gradeLevel = tostring(senderJobGrade)
                    if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
                        commissionPercentage = Config.Grades[gradeLevel].Commission
                        Server.Debug("[COMMISSION] Using config commission: " .. commissionPercentage .. "%")
                    else
                        commissionPercentage = Config.Billing.Commission.percentage or 0
                        Server.Debug("[COMMISSION] Using default commission: " .. commissionPercentage .. "%")
                    end
                end

                -- Calculate commission amount
                local commissionAmount = math.floor((billAmount * commissionPercentage) / 100)

                -- Store calculated values in bill object
                bill.commission_amount = commissionAmount
                bill.commission_percentage = commissionPercentage

                Server.Debug("[COMMISSION] Bill amount: $" .. billAmount .. ", Commission: $" .. commissionAmount .. " (" .. commissionPercentage .. "%)")

                -- Continue with payment processing
                ProcessPaymentWithCommission(src, bill, billAmount, commissionAmount)
            end
        )
        return -- Exit here as we're handling async
    else
        -- No commission calculation needed
        ProcessPaymentWithCommission(src, bill, billAmount, 0)
    end
end)


-- [NEW EVENT] - Fetches initial orders for a single client with limited completed orders for today only
RegisterNetEvent(Config.ResourceName .. ':server:getInitialOrders', function(tabletData)
    local src = source
    local tabletIndex = tabletData.index
    
    -- Check if order management tablet is already in use by another player
    if IsOrderManagementLocked(tabletIndex) then
        local lockingPlayer = orderManagementLocks[tabletIndex]
        if lockingPlayer ~= src then
            return CRUX.Notify(src, { 
                title = Config.Localess.System.error, 
                description = Config.Localess.Order.tablet_in_use or "Order management tablet is currently in use by another player!", 
                type = "error" 
            })
        end
    end
    
    -- Lock the order management tablet for this player
    LockOrderManagement(tabletIndex, src)
    
    -- Use await query for synchronous result
    local orders = MySQL.query.await(
        'SELECT o.*, e.name as employee_name FROM ' .. tablePrefix .. 'orders o LEFT JOIN ' .. tablePrefix .. 'employees e ON o.employee_identifier = e.license WHERE o.status IN (?, ?) OR (o.status = ? AND o.order_date >= CURDATE())',
        {'cooking', 'ready', 'completed'}
    )
    -- Send the orders and tablet data back to the original client
    TriggerClientEvent(Config.ResourceName .. ':client:openOrderManagementWithData', src, orders or {}, tabletData)
end)

-- [ORDER MANAGEMENT] - Fetches all active orders and sends them to all clients.
RegisterNetEvent(Config.ResourceName .. ':server:refreshOrders', function()
    local src = source
    
    -- Fetch only active orders (cooking, ready) for real-time updates
    -- Completed orders should only be fetched when explicitly requested
    local orders = MySQL.query.await([[
        SELECT o.*, e.name as employee_name 
        FROM ]] .. tablePrefix .. [[orders o 
        LEFT JOIN ]] .. tablePrefix .. [[employees e ON o.employee_identifier = e.license 
        WHERE o.status IN ('cooking', 'ready')
        ORDER BY o.created_at DESC
    ]])
    
    if orders and #orders > 0 then
        -- Enrich orders: ensure employee_name is populated
        for _, order in ipairs(orders) do
            if order.employee_identifier and (not order.employee_name or order.employee_name == "") then
                local foundName = ""
                
                -- Try to find online player
                for _, pid in ipairs(GetPlayers()) do
                    local p = tonumber(pid)
                    if p then
                        local pidIdentifier = CRUX.Framework.GetIdentifier(p)
                        if pidIdentifier == order.employee_identifier then
                            foundName = CRUX.Framework.GetPlayerName(p) or ""
                            break
                        end
                    end
                end
                
                -- Fallback to database
                if foundName == "" then
                    local empResult = MySQL.query.await('SELECT name FROM ' .. tablePrefix .. 'employees WHERE license = ? LIMIT 1', {order.employee_identifier})
                    if empResult and #empResult > 0 and empResult[1].name then
                        foundName = empResult[1].name
                    end
                end
                
                order.employee_name = foundName or ""
            end
        end
        
        -- Broadcast to OTHER clients only (skip source)
        for _, playerId in ipairs(GetPlayers()) do
            local pid = tonumber(playerId)
            if pid and pid ~= src then
                TriggerClientEvent(Config.ResourceName .. ':client:receiveOrders', pid, orders)
            end
        end
    else
        -- Send empty list to keep clients in sync
        for _, playerId in ipairs(GetPlayers()) do
            local pid = tonumber(playerId)
            if pid and pid ~= src then
                TriggerClientEvent(Config.ResourceName .. ':client:receiveOrders', pid, {})
            end
        end
    end
end)

-- [ORDER MANAGEMENT] - Updates the status of a specific order.
RegisterNetEvent(Config.ResourceName .. ':server:updateOrderStatus', function(data)
    local src = source
    local orderId = data.orderId
    local newStatus = data.status

    if not orderId or not newStatus then return end

    -- Update by PRIMARY KEY id only to avoid accidentally updating multiple rows sharing order_id
    MySQL.update(
        'UPDATE ' .. tablePrefix .. 'orders SET status = ? WHERE id = ?',
        {newStatus, orderId},
        function(affectedRows)
            if affectedRows > 0 then
                -- Refresh active orders for all clients (refreshOrders broadcasts active orders)
                TriggerEvent(Config.ResourceName .. ':server:refreshOrders')

                -- If status changed to completed, send completed orders to the requesting client immediately,
                -- then continue with commission/self-pickup processing asynchronously.
                if newStatus == 'completed' then
                    -- Fetch today's completed orders and send them directly to the requester so their "Completed" tab updates immediately
                    local completedOrders = MySQL.query.await([[
                        SELECT o.*, e.name as employee_name
                        FROM ]] .. tablePrefix .. [[orders o
                        LEFT JOIN ]] .. tablePrefix .. [[employees e ON o.employee_identifier = e.license
                        WHERE o.status = 'completed' AND o.order_date = CURDATE()
                        ORDER BY o.created_at DESC
                    ]])
                    TriggerClientEvent(Config.ResourceName .. ':client:receiveCompletedOrders', src, completedOrders or {})

                    -- Proceed with self-pickup / commission logic (kept asynchronous)
                    MySQL.query('SELECT self_pickup, employee_identifier, total_amount FROM ' .. tablePrefix .. 'orders WHERE id = ?', {orderId}, function(orderResult)
                        if orderResult and #orderResult > 0 then
                            local order = orderResult[1]
                            if order.self_pickup and order.employee_identifier then
                                local employeeIdentifier = order.employee_identifier
                                local orderAmount = order.total_amount

                                -- Get employee's job grade from employees table
                                MySQL.query('SELECT job_grade FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?', {employeeIdentifier, Config.JobName}, function(empResult)
                                    local senderJobGrade = 0
                                    if empResult and #empResult > 0 then
                                        senderJobGrade = empResult[1].job_grade or 0
                                    end

                                    -- Now get commission directly from job grades table using the grade
                                    MySQL.query('SELECT COALESCE(commission, 0) as commission FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? AND grade = ?',
                                        {Config.JobName, senderJobGrade},
                                        function(gradeResult)
                                            local commissionPercentage = 0

                                            if gradeResult and #gradeResult > 0 then
                                                commissionPercentage = gradeResult[1].commission
                                                Server.Debug("[COMMISSION] Using job grade commission from DB: " .. commissionPercentage .. "% for employee " .. employeeIdentifier)
                                            else
                                                -- Fallback to config values
                                                local gradeLevel = tostring(senderJobGrade)
                                                if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
                                                    commissionPercentage = Config.Grades[gradeLevel].Commission
                                                    Server.Debug("[COMMISSION] Using config commission: " .. commissionPercentage .. "% for grade " .. gradeLevel)
                                                else
                                                    commissionPercentage = Config.Billing.Commission.percentage or 0
                                                    Server.Debug("[COMMISSION] Using default commission: " .. commissionPercentage .. "%")
                                                end
                                            end

                                            local commissionAmount = math.floor((orderAmount * commissionPercentage) / 100)

                                            Server.Debug("Commission calculation for order " .. tostring(orderId) .. ": amount=" .. orderAmount .. ", percentage=" .. commissionPercentage .. "%, commission=" .. commissionAmount)

                                            if commissionAmount > 0 then
                                                -- Add commission to employee's balance
                                                MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET balance = balance + ?, billing_balance = billing_balance + ? WHERE license = ? AND job = ?',
                                                    {commissionAmount, commissionAmount, employeeIdentifier, Config.JobName},
                                                    function(commAffected)
                                                        if commAffected > 0 then
                                                            Server.Debug("Awarded $" .. commissionAmount .. " commission to employee " .. employeeIdentifier .. " for self-pickup order " .. tostring(orderId))

                                                            -- Notify the employee if online
                                                            for _, playerId in ipairs(GetPlayers()) do
                                                                if CRUX.Framework.GetIdentifier(tonumber(playerId)) == employeeIdentifier then
                                                                    CRUX.Notify(tonumber(playerId), {
                                                                        title = Config.Localess.Billing.commission_earned,
                                                                        description = string.format(Config.Localess.Billing.commission_earned_description, commissionAmount),
                                                                        type = "success",
                                                                        duration = 5000,
                                                                    })
                                                                    break
                                                                end
                                                            end
                                                        else
                                                            Server.Debug("Failed to award commission to employee " .. employeeIdentifier .. " for order " .. tostring(orderId) .. " (update failed)")
                                                        end
                                                    end
                                                )
                                            else
                                                Server.Debug("No commission awarded for order " .. tostring(orderId) .. " (amount=0 or percentage=0)")
                                            end
                                        end
                                    )
                                end)
                            else
                                Server.Debug("Order " .. tostring(orderId) .. " is not a valid self-pickup order or no employee assigned")
                            end
                        else
                            Server.Debug("Failed to retrieve order details for " .. tostring(orderId))
                        end
                    end)
                end
            else
                Debug.Warn(('Failed to update order status for order ID: %s'):format(tostring(orderId)))
            end
        end
    )
end)

RegisterNetEvent(Config.ResourceName .. ':server:getCompletedOrders', function()
    local src = source
    
    local completedOrders = MySQL.query.await([[
        SELECT o.*, e.name as employee_name 
        FROM ]] .. tablePrefix .. [[orders o 
        LEFT JOIN ]] .. tablePrefix .. [[employees e ON o.employee_identifier = e.license 
        WHERE o.status = 'completed' AND o.order_date = CURDATE()
        ORDER BY o.created_at DESC
    ]])
    
    TriggerClientEvent(Config.ResourceName .. ':client:receiveCompletedOrders', src, completedOrders or {})
end)

-- [ORDER MANAGEMENT] - Fetches orders for DUI display (client-specific)
RegisterNetEvent(Config.ResourceName .. ':server:refreshOrdersForDUI', function()
    local src = source
    MySQL.query('SELECT * FROM ' .. tablePrefix .. 'orders WHERE status IN (?, ?)', {'cooking', 'ready'}, function(orders)
        if orders then
            -- Add employee_name using CRUX.Framework.GetPlayerName(employee_identifier)
            for _, order in ipairs(orders) do
                if order.employee_identifier then
                    local foundName = ""
                    for _, playerId in ipairs(GetPlayers()) do
                        if CRUX.Framework.GetIdentifier(tonumber(playerId)) == order.employee_identifier then
                            foundName = CRUX.Framework.GetPlayerName(tonumber(playerId)) or ""
                            break
                        end
                    end
                    if foundName == "" then
                        -- Fallback: get name from database if player is offline
                        local empResult = MySQL.query.await('SELECT name FROM ' .. tablePrefix .. 'employees WHERE license = ? LIMIT 1', {order.employee_identifier})
                        if empResult and #empResult > 0 and empResult[1].name then
                            foundName = empResult[1].name
                        end
                    end
                    order.employee_name = foundName
                else
                    order.employee_name = ""
                end
            end
            TriggerClientEvent(Config.ResourceName .. ':client:receiveOrdersForDUI', src, orders)
        end
    end)
end)


-- Handle bill rejection
RegisterNetEvent(Config.ResourceName .. ':server-billing:rejectBill')
AddEventHandler(Config.ResourceName .. ':server-billing:rejectBill', function(billId)
    local src = source
    local bill = activeBills[billId]

    if not bill then
        CRUX.Notify(src, {
            title = Config.Localess.Billing.invalid_bill_title,
            description = Config.Localess.Billing.invalid_bill_description,
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Log billing failure - bill rejected
    TriggerEvent('crux_lib:discordLog',
        "billingFailure",
        "❌ Bill Rejected",
        CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ") rejected a bill",
        {
            {
                ["name"] = "Rejector",
                ["value"] = CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Bill Sender",
                ["value"] = bill.sender_identifier .. " (" .. bill.sender_name .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Amount",
                ["value"] = "$" .. bill.amount,
                ["inline"] = true
            },
            {
                ["name"] = "Payment Method",
                ["value"] = bill.payment_method,
                ["inline"] = true
            },
            {
                ["name"] = "Failure Reason",
                ["value"] = "Bill rejected by customer",
                ["inline"] = false
            },
            {
                ["name"] = "Bill Reason",
                ["value"] = bill.reason,
                ["inline"] = false
            }
        },
        Config.DiscordLogging.color.billing,
        Config.DiscordLogging
    )

    -- Notify the sender that the bill was rejected
    if bill.sender_id > 0 then
        local senderIsOnline = GetPlayerPing(bill.sender_id) > 0
        if senderIsOnline then
            CRUX.Notify(bill.sender_id, {
                title = Config.Localess.Billing.bill_rejected_title,
                description = string.format(Config.Localess.Billing.bill_rejected_sender, bill.receiver_name, bill.amount),
                type = "error",
                duration = 5000,
            })
        end
    end

    -- Notify the player who rejected the bill
    CRUX.Notify(src, {
        title = Config.Localess.Billing.bill_rejected_title,
        description = string.format(Config.Localess.Billing.bill_rejected_receiver, bill.sender_name, bill.amount),
        type = "info",
        duration = 5000,
    })

    -- Clear the bill from active bills
    activeBills[billId] = nil
end)

-- Register billing command if enabled
if Config.Billing.EnableCommand and Config.Billing.Command then
    RegisterCommand(Config.Billing.Command, function(source, args, rawCommand)
        local src = source
        local playerJob = JobSystem.GetJob(src)

        if playerJob.name == Config.JobName then
            -- Only check for duty status if Config.NeedDuty is enabled
            local dutyCheck = not Config.NeedDuty or playerJob.onduty

            if dutyCheck then
                -- Check if business is open before allowing billing
                local isBusinessOpen = businessStatus[Config.JobName]

                -- If status hasn't been loaded yet, load it now
                if isBusinessOpen == nil then
                    isBusinessOpen = LoadBusinessStatus(Config.JobName)
                end

                if isBusinessOpen then
                    TriggerClientEvent(Config.ResourceName .. ':client-billing:openBillingMenu', src)
                else
                    -- Notify that billing is disabled because business is closed
                    TriggerClientEvent(Config.ResourceName .. ':notify', src, {
                        title = Config.Localess.Billing.title,
                        description = Config.Localess.Billing.business_closed,
                        type = "error",
                        duration = 5000,
                    })
                end
            else
                -- Only show this if Config.NeedDuty is true
                TriggerClientEvent(Config.ResourceName .. ':notify', src, {
                    title = Config.Localess.Billing.title,
                    description = Config.Localess.Billing.must_be_on_duty,
                    type = "error",
                    duration = 5000,
                })
            end
        else
            TriggerClientEvent(Config.ResourceName .. ':notify', src, {
                title = Config.Localess.Billing.title,
                description = Config.Localess.Billing.command_access_denied,
                type = "error",
                duration = 5000,
            })
        end
    end)
end

-- Add this new event to get business status
RegisterNetEvent(Config.ResourceName .. ':server:getBusinessStatus')
AddEventHandler(Config.ResourceName .. ':server:getBusinessStatus', function()
    local src = source
    local isOpen = LoadBusinessStatus(Config.JobName)

    TriggerClientEvent(Config.ResourceName .. ':client:receiveBusinessStatus', src, {
        job = Config.JobName,
        isOpen = isOpen
    })
end)

-- Initialize business status on resource start
AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    -- Load business status for this job
    LoadBusinessStatus(Config.JobName)
end)

-- Update the business data when requested
RegisterNetEvent(Config.ResourceName .. ':server:requestBossData')
AddEventHandler(Config.ResourceName .. ':server:requestBossData', function()
    local src = source
    local playerJob = JobSystem.GetJob(src)

    -- Check if player is authorized
    if not playerJob or playerJob.name ~= Config.JobName then
        return
    end

    -- Load business status
    local isOpen = LoadBusinessStatus(Config.JobName)

    -- Send business data, including status
    TriggerClientEvent(Config.ResourceName .. ':client:updateBusinessData', src, {
        businessData = {
            -- Other business data here
            isOpen = isOpen
        }
    })
end)

-- Handle ordering checkout
RegisterNetEvent(Config.ResourceName .. ':server:processOrderingCheckout')
AddEventHandler(Config.ResourceName .. ':server:processOrderingCheckout', function(data)
    local src = source
    local amount = tonumber(data.amount)
    local items = data.items or {}
    local paymentMethod = data.paymentMethod or "cash"
    local kioskIndex = data.terminalIndex -- This is actually the kiosk index

    -- Validate data
    if not amount or amount <= 0 then
        TriggerClientEvent(Config.ResourceName .. ':client:orderingCheckoutProcessed', src, {
            success = false,
            message = "Invalid amount"
        })
        return
    end


    -- NEW: Check if at least one employee is online and on duty before allowing the order
    -- local hasOnlineActiveEmployee = false
    -- for _, playerId in ipairs(GetPlayers()) do
    --     local playerJob = JobSystem.GetJob(tonumber(playerId))
    --     if playerJob and playerJob.name == Config.JobName and playerJob.onduty then
    --         hasOnlineActiveEmployee = true
    --         break
    --     end
    -- end

    -- if not hasOnlineActiveEmployee then
    --     TriggerClientEvent(Config.ResourceName .. ':client:orderingCheckoutProcessed', src, {
    --         success = false,
    --         message = Config.Localess.EmployeeMenu.no_employee_active
    --     })
    --     return
    -- end

    -- Check if player has enough money
    local playerMoney = 0
    if paymentMethod == "cash" then
        playerMoney = CRUX.Framework.GetMoney(src, 'cash')
    elseif paymentMethod == "bank" then
        playerMoney = CRUX.Framework.GetMoney(src, 'bank')
    end

    if playerMoney < amount then
        TriggerClientEvent(Config.ResourceName .. ':client:orderingCheckoutProcessed', src, {
            success = false,
            message = "Insufficient funds"
        })
        return
    end

    -- Deduct money
    if paymentMethod == "cash" then
        CRUX.Framework.RemoveMoney(src, 'cash', amount)
    elseif paymentMethod == "bank" then
        CRUX.Framework.RemoveMoney(src, 'bank', amount)
    end

    -- Add to business balance (assuming ordering contributes to business revenue)
    MySQL.update('UPDATE ' .. tablePrefix .. 'bossmenu SET balance = balance + ? WHERE id = ?',
        {amount, Config.JobName},
        function(affectedRows)
            if affectedRows <= 0 then
                Server.Debug("Error updating business balance for ordering")
            end
        end
    )
    
    -- Record the transaction in the database
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)
    local playerName = CRUX.Framework.GetPlayerName(src)
    local itemsJson = json.encode(items)
    -- For ordering, set the customer as sender and the business as receiver
    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'transactions (sender_identifier, sender_name, receiver_identifier, receiver_name, amount, commission_amount, reason, payment_method, items, job, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())',
        {Config.JobName, Config.JobLabel, playerIdentifier, playerName, amount, 0, "Kiosk Orders", paymentMethod, itemsJson, Config.JobName},
        function(id)
            if not id then
                Server.Debug("Error recording ordering transaction")
            end
        end
    )

    -- [ADDED] Define orderLabel here to use in both the order and the metadata
    local orderLabel = nil

    -- Insert self-pickup order into crux_orders
    MySQL.query('SELECT COALESCE(MAX(order_id), 0) AS max_id FROM ' .. tablePrefix .. 'orders', {}, function(result)
        local newOrderId = (result and result[1] and result[1].max_id or 0) + 1
        
        -- Get the next order label for today
        orderLabel = GetNextOrderLabel() -- [CHANGED] Assign to the outer variable
        local orderDate = os.date("%Y-%m-%d")
        
        MySQL.insert(
            'INSERT INTO ' .. tablePrefix .. 'orders (order_id, order_label, order_date, customer_name, customer_identifier, employee_identifier, self_pickup, items, total_amount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            {
                newOrderId,
                orderLabel,
                orderDate,
                playerName,
                playerIdentifier,
                NULL,  -- employee_identifier set to NULL initially
                true,  -- self_pickup = true
                itemsJson,
                amount,
                'cooking'  -- Start with cooking status
            },
            function(insertId)
                if insertId then
                    Server.Debug(('Successfully created self-pickup order with ID: %s, Label: #%03d'):format(newOrderId, orderLabel))
                    -- Refresh the order list for all clients
                    TriggerEvent(Config.ResourceName .. ':server:refreshOrders')
                else
                    Server.Debug('Failed to create self-pickup order')
                end

                -- [MOVED] Create bill metadata and add to inventory *after* order is created and label is set
                billMetadataCounter = billMetadataCounter + 1
                local billMetadata = {
                    id = billMetadataCounter,
                    order_label = orderLabel, -- [ADDED] Add order_label to metadata
                    sender = Config.JobLabel,
                    amount = amount,
                    paymentMethod = paymentMethod,
                    reason = "Restaurant Order",
                    businessName = Config.JobLabel,
                    items = json.encode(items),
                    date = os.date("%Y-%m-%d %H:%M:%S"),
                    terminalType = "Kiosk Terminal (" .. (data.terminalIndex or "1") .. ")"  -- Include index in type
                }

                CRUX.Inventory.AddItem(src, Config.BillItemName, 1, billMetadata)

            end
        )
    end)

    -- [MOVED] The AddItem logic was moved inside the callback above

    -- Log the transaction
    TriggerEvent('crux_lib:discordLog',
        "orderingTransaction",
        "🍔 Order Processed",
        CRUX.Framework.GetIdentifier(src) .. " completed an order",
        {
            {
                ["name"] = "Customer",
                ["value"] = CRUX.Framework.GetIdentifier(src) .. " (" .. CRUX.Framework.GetPlayerName(src) .. ")",
                ["inline"] = true
            },
            {
                ["name"] = "Amount",
                ["value"] = "$" .. amount,
                ["inline"] = true
            },
            {
                ["name"] = "Payment Method",
                ["value"] = paymentMethod,
                ["inline"] = true
            }
        },
        Config.DiscordLogging.color.billing,
        Config.DiscordLogging
    )

    -- Notify success
    TriggerClientEvent(Config.ResourceName .. ':client:orderingCheckoutProcessed', src, {
        success = true
    })
end)

-- [ORDER MANAGEMENT] - Accepts a self-pickup order by setting employee_identifier
RegisterNetEvent(Config.ResourceName .. ':server:acceptSelfPickupOrder')
AddEventHandler(Config.ResourceName .. ':server:acceptSelfPickupOrder', function(data)
    local src = source
    local orderId = data.orderId
    local employeeIdentifier = CRUX.Framework.GetIdentifier(src)

    if not orderId or not employeeIdentifier then return end

    -- Check using primary id (id) instead of order_id
    MySQL.query('SELECT self_pickup, employee_identifier FROM ' .. tablePrefix .. 'orders WHERE id = ?', {orderId}, function(result)
        if result and #result > 0 and result[1].self_pickup and not result[1].employee_identifier then
            -- Assign the employee by primary id
            MySQL.update(
                'UPDATE ' .. tablePrefix .. 'orders SET employee_identifier = ? WHERE id = ?',
                {employeeIdentifier, orderId},
                function(affectedRows)
                    if affectedRows > 0 then
                        Server.Debug(('Employee %s accepted self-pickup order %s'):format(employeeIdentifier, orderId))
                        -- Refresh the order list for all clients
                        TriggerEvent(Config.ResourceName .. ':server:refreshOrders')
                    else
                        Server.Debug(('Failed to accept self-pickup order %s'):format(orderId))
                    end
                end
            )
        else
            Server.Debug(('Order %s is not eligible for acceptance'):format(orderId))
        end
    end)
end)
