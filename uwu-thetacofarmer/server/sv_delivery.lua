Wait(5000)

if not Config.Delivery.Enabled then
    return
end

-- Global delivery system
local globalDelivery = {
    active = false,
    location = nil,
    items = {},
    reward = nil,
    expireTime = nil
}

-- Track players who have accepted the current delivery
local acceptedPlayers = {}

-- Create a new global delivery
function createGlobalDelivery()
    if globalDelivery.active then
        return false
    end

    -- Select random delivery data
    local location = Config.Delivery.locations[math.random(#Config.Delivery.locations)]
    local deliveryData = Config.Delivery.deliveries[math.random(#Config.Delivery.deliveries)]

    -- Handle cash calculation properly
    local rewardAmount
    if type(deliveryData.cash) == "table" and deliveryData.cash.min and deliveryData.cash.max then
        rewardAmount = math.random(deliveryData.cash.min, deliveryData.cash.max)
    else
        rewardAmount = deliveryData.cash or 0
    end

    globalDelivery = {
        active = true,
        location = location,
        items = deliveryData.items,
        reward = rewardAmount, -- Store as number, not table
        expireTime = os.time() + Config.Delivery.expire
    }

    acceptedPlayers = {}

    -- Notify all eligible players about the new delivery
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        local src = tonumber(playerId)
        if canPlayerParticipate(src) then
            TriggerClientEvent(Config.ResourceName .. ':client:globalDeliveryCreated', src, {
                location = globalDelivery.location,
                items = globalDelivery.items,
                cash = globalDelivery.reward -- Send as number
            })
        end
    end

    Server.Debug("^2[DELIVERY] Global delivery created at " .. json.encode(globalDelivery.location) .. " with reward $" .. rewardAmount .. "^7")
    return true
end

-- Check if delivery has expired
function checkDeliveryExpiry()
    if globalDelivery.active and os.time() >= globalDelivery.expireTime then
        Server.Debug("^3[DELIVERY] Global delivery expired^7")

        -- Notify all players that delivery expired
        for playerId, _ in pairs(acceptedPlayers) do
            TriggerClientEvent(Config.ResourceName .. ':client:globalDeliveryExpired', playerId)
        end

        globalDelivery.active = false
        acceptedPlayers = {}
        return true
    end
    return false
end

-- Check if player can participate in deliveries
function canPlayerParticipate(source)
    local playerJob = JobSystem.GetJob(source)

    if playerJob.name ~= Config.JobName then
        return false
    end

    if Config.NeedDuty and not playerJob.onduty then
        return false
    end

    return true
end

-- Global delivery system loop
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Delivery.delay * 1000)

        -- Check for expired delivery
        if globalDelivery.active then
            checkDeliveryExpiry()
        end

        -- Create new delivery if none active
        if not globalDelivery.active then
            createGlobalDelivery()
        end
    end
end)

-- Clean up when a player disconnects
AddEventHandler('playerDropped', function()
    local src = source
    if acceptedPlayers[src] then
        acceptedPlayers[src] = nil
        Server.Debug(("^3[DELIVERY] Player %s disconnected with accepted delivery, cleaning up^7"):format(GetPlayerName(src)))
    end
end)

-- Event to check if player can create a delivery (now just checks participation)
RegisterNetEvent(Config.ResourceName .. ':server:canCreateDelivery')
AddEventHandler(Config.ResourceName .. ':server:canCreateDelivery', function()
    local src = source

    if not canPlayerParticipate(src) then
        local playerJob = JobSystem.GetJob(src)
        local reason = "wrong_job"
        if playerJob.name == Config.JobName and Config.NeedDuty and not playerJob.onduty then
            reason = "not_on_duty"
        end
        TriggerClientEvent(Config.ResourceName .. ':client:canCreateDeliveryResponse', src, false, reason)
        return
    end

    -- If there's an active global delivery, send it to the player
    if globalDelivery.active then
        TriggerClientEvent(Config.ResourceName .. ':client:canCreateDeliveryResponse', src, true)
        TriggerClientEvent(Config.ResourceName .. ':client:globalDeliveryCreated', src, {
            location = globalDelivery.location,
            items = globalDelivery.items,
            cash = globalDelivery.reward -- Send as number
        })
    else
        TriggerClientEvent(Config.ResourceName .. ':client:canCreateDeliveryResponse', src, false, "no_delivery_available")
    end
end)

-- Player accepts global delivery
RegisterNetEvent(Config.ResourceName .. ':server:acceptGlobalDelivery')
AddEventHandler(Config.ResourceName .. ':server:acceptGlobalDelivery', function()
    local src = source

    if not globalDelivery.active then
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.no_active_delivery)
        return
    end

    if acceptedPlayers[src] then
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.already_accepted)
        return
    end

    acceptedPlayers[src] = true
    Server.Debug(("^2[DELIVERY] Player %s accepted global delivery^7"):format(GetPlayerName(src) or src))
end)

RegisterNetEvent(Config.ResourceName .. ':server:finishDelivery')
AddEventHandler(Config.ResourceName .. ':server:finishDelivery', function(success)
    local src = source
    if acceptedPlayers[src] then
        acceptedPlayers[src] = nil
    end
end)

RegisterServerEvent(Config.ResourceName .. ':server:completeDelivery')
AddEventHandler(Config.ResourceName .. ':server:completeDelivery', function(orderData)
    local src = source

    -- Clear player from accepted deliveries list
    if acceptedPlayers[src] then
        acceptedPlayers[src] = nil
    end

    local player = CRUX.Framework.GetPlayer(src)
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)
    local playerName = CRUX.Framework.GetPlayerName(src)

    if not player then
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.player_data_not_found)
        return
    end

    -- Enhanced validation with detailed logging
    if not orderData then
        Server.Debug("ERROR: Delivery failed - orderData is nil for player " .. playerName)
        CRUX.Notify(src, {
            title = Config.Localess.Delivery.delivery_failed,
            description = Config.Localess.Delivery.invalid_delivery_data,
            type = "error",
            duration = 5000,
        })
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.invalid_delivery_data)
        return
    end

    if not orderData.items then
        Server.Debug("ERROR: Delivery failed - orderData.items is missing for player " .. playerName)
        Server.Debug("orderData received: " .. json.encode(orderData))
        CRUX.Notify(src, {
            title = Config.Localess.Delivery.delivery_failed,
            description = Config.Localess.Delivery.invalid_delivery_items,
            type = "error",
            duration = 5000,
        })
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.invalid_delivery_items)
        return
    end

    if type(orderData.items) ~= "table" then
        Server.Debug("ERROR: Delivery failed - orderData.items is not a table for player " .. playerName)
        Server.Debug("orderData.items type: " .. type(orderData.items))
        CRUX.Notify(src, {
            title = Config.Localess.Delivery.delivery_failed,
            description = Config.Localess.Delivery.invalid_items_format,
            type = "error",
            duration = 5000,
        })
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.invalid_items_format)
        return
    end

    if not orderData.cash or type(orderData.cash) ~= "number" then
        Server.Debug("ERROR: Delivery failed - orderData.cash issue for player " .. playerName)
        Server.Debug("orderData.cash: " .. tostring(orderData.cash))
        CRUX.Notify(src, {
            title = Config.Localess.Delivery.delivery_failed,
            description = Config.Localess.Delivery.invalid_reward_amount,
            type = "error",
            duration = 5000,
        })
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.invalid_reward_amount)
        return
    end

    -- Verify delivery items are available BEFORE telling client to proceed with animation
    local hasAllItems = true
    for item, count in pairs(orderData.items) do
        -- Check if player has the required item with the required count
        local playerItemCount = CRUX.Inventory.CountItem(src, item)
        if not playerItemCount or playerItemCount < count then
            hasAllItems = false
            break
        end
    end

    if not hasAllItems then
        -- Missing items for delivery - tell the client to NOT play animation
        CRUX.Notify(src, {
            title = Config.Localess.Delivery.delivery_failed,
            description = Config.Localess.Delivery.missing_required_items,
            type = "error",
            duration = 5000,
        })
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.missing_required_items)
        return
    end

    -- After validation of both data AND inventory, let the client know the delivery can continue
    TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, true)

    -- Remove delivery items from player
    for item, count in pairs(orderData.items) do
        CRUX.Inventory.RemoveItem(src, item, count)
    end

    -- Get the reward amount from the order
    local reward = orderData.cash

    -- Check payment configuration
    if Config.Delivery.DeliveryUsingBossMenu then
        -- Calculate commission based on job grade
        local jobData = JobSystem.GetJob(src)
        local commissionRate = 0
        local jobGrade = jobData and jobData.grade or 0

        -- Get commission rate from job grades table
        local gradeResult = MySQL.Sync.fetchAll("SELECT commission FROM " .. tablePrefix .. "job_grades WHERE job_name = ? AND grade = ?",
            {Config.JobName, jobGrade})

        if gradeResult and #gradeResult > 0 and gradeResult[1].commission then
            commissionRate = gradeResult[1].commission
            Server.Debug("[DELIVERY] Using commission from job grade DB: " .. commissionRate .. "%")
        else
            -- Fallback to config if not found in database
            local gradeLevel = tostring(jobGrade)
            if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
                commissionRate = Config.Grades[gradeLevel].Commission
                Server.Debug("[DELIVERY] Using commission from config: " .. commissionRate .. "%")
            end
        end

        -- Calculate amounts
        local commissionAmount = math.floor((reward * commissionRate) / 100)
        local businessAmount = reward - commissionAmount

        -- Add remaining money to boss account
        MySQL.update('UPDATE ' .. tablePrefix .. 'bossmenu SET balance = balance + ? WHERE id = ?',
            {businessAmount, Config.JobName},
            function(affectedRows)
                if affectedRows <= 0 then
                    Server.Debug("Error updating business balance for " .. Config.JobName .. " with $" .. businessAmount)
                    -- Try to create the bossmenu account if it doesn't exist
                    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'bossmenu (id, balance) VALUES (?, ?)',
                        {Config.JobName, businessAmount},
                        function(id)
                            if id then
                                Server.Debug("Created new business account with $" .. businessAmount)
                            else
                                Server.Debug("Error creating business account")
                            end
                        end
                    )
                else
                    Server.Debug("Successfully added $" .. businessAmount .. " to business account")
                end
            end
        )

        -- Update employee statistics in database - add to balance and delivery_balance
        MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET deliveries = deliveries + 1, balance = balance + ?, delivery_balance = delivery_balance + ? WHERE license = ? AND job = ?',
            {commissionAmount, commissionAmount, playerIdentifier, Config.JobName},
            function(affectedRows)
                if affectedRows <= 0 then
                    -- Create employee record if doesn't exist (without role, salary and commission fields)
                    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, job, job_grade, deliveries, balance, delivery_balance) VALUES (?, ?, ?, ?, ?, ?, ?)',
                        {playerIdentifier, playerName, Config.JobName, jobGrade, 1, commissionAmount, commissionAmount},
                        function(id)
                            if id then
                                Server.Debug("Created new employee record with delivery commission")
                            else
                                Server.Debug("Error creating employee record")
                            end
                        end
                    )
                end
            end
        )

        -- Record the delivery transaction in the database
        local itemsJson = json.encode(orderData.items)
        MySQL.insert('INSERT INTO ' .. tablePrefix .. 'transactions (sender_identifier, sender_name, receiver_identifier, receiver_name, amount, commission_amount, reason, payment_method, items, job, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())',
            {playerIdentifier, playerName, "delivery-customer", "Delivery Customer", reward, commissionAmount, "Food Delivery", "cash", itemsJson, Config.JobName},
            function(id)
                if not id then
                    Server.Debug("Error recording delivery transaction")
                else
                    Server.Debug("Recorded delivery transaction #" .. id)
                end
            end
        )

        -- Success notification with commission details
        CRUX.Notify(src, {
            title = Config.Localess.Delivery.delivery_accepted,
            description = string.format(Config.Localess.Delivery.delivery_complete_commission, commissionAmount, commissionPercentage),
            type = "success",
            duration = 5000,
        })

    elseif Config.Delivery.DeliveryUsingCash then
        -- Direct cash payment to player
        CRUX.Framework.AddMoney(src, 'cash', reward)

        -- Get job data for job_grade
        local jobData = JobSystem.GetJob(src)
        local jobGrade = jobData and jobData.grade or 0

        -- Update employee record's statistics only - DON'T add to overall balance (to prevent double payment)
        -- Only update deliveries counter and delivery_balance for tracking purposes
        MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET deliveries = deliveries + 1, delivery_balance = delivery_balance + ? WHERE license = ? AND job = ?',
            {reward, playerIdentifier, Config.JobName},
            function(affectedRows)
                if affectedRows <= 0 then
                    -- Create employee record if doesn't exist (without adding to balance)
                    MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, job, job_grade, deliveries, balance, delivery_balance, experience) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                        {playerIdentifier, playerName, Config.JobName, jobGrade, 1, 0, reward, 0}, -- Set balance to 0 instead of reward
                        function(id)
                            if id then
                                Server.Debug("Created new employee record with delivery")
                            else
                                Server.Debug("Error creating employee record")
                            end
                        end
                    )
                end
            end
        )

        -- Record the cash delivery transaction
        local itemsJson = json.encode(orderData.items)
        MySQL.insert('INSERT INTO ' .. tablePrefix .. 'transactions (sender_identifier, sender_name, receiver_identifier, receiver_name, amount, commission_amount, reason, payment_method, items, job, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())',
            {playerIdentifier, playerName, "delivery-customer", "Delivery Customer", reward, reward, "Food Delivery (Cash)", "cash", itemsJson, Config.JobName},
            function(id)
                if not id then
                    Server.Debug("Error recording cash delivery transaction")
                else
                    Server.Debug("Recorded cash delivery transaction #" .. id)
                end
            end
        )

        -- Success notification for direct cash payment
        CRUX.Notify(src, {
            title = Config.Localess.Delivery.delivery_accepted,
            description = string.format(Config.Localess.Delivery.delivery_complete_cash, reward) or "Delivery completed! You received $" .. reward .. " in cash.",
            type = "success",
            duration = 5000,
        })
    else
        -- Neither option is enabled, this is an error state
        Server.Debug("Error: No delivery payment method is enabled in Config.Delivery")
        CRUX.Notify(src, {
            title = Config.Localess.Delivery.delivery_accepted,
            description = Config.Localess.Delivery.delivery_complete_no_payment,
            type = "info",
            duration = 5000,
        })
    end

    -- Add experience for the delivery if enabled
    if Config.Delivery.Experience.enabled then
        -- Get current experience
        MySQL.query('SELECT experience FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ?',
            {playerIdentifier, Config.JobName},
            function(result)
                if result and #result > 0 then
                    local currentExp = result[1].experience or 0
                    local expGain = Config.Delivery.Experience.expPerDelivery -- Use config value

                    -- Update experience
                    MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET experience = ? WHERE license = ? AND job = ?',
                        {currentExp + expGain, playerIdentifier, Config.JobName},
                        function()
                            -- Trigger promotion check after experience gain
                            if Config.Experience and Config.Experience.Enabled then
                                TriggerEvent(Config.ResourceName .. ':server:experienceEarned', src, expGain)

                                -- Direct function call alternative
                                if _G.ExperienceSystem and _G.ExperienceSystem.CheckForPromotion then
                                    _G.ExperienceSystem.CheckForPromotion(src)
                                end
                            end
                        end
                    )

                    -- Notify player about experience gain
                    CRUX.Notify(src, {
                        title = Config.Localess.Experience.gained_title,
                        description = string.format(Config.Localess.Experience.gained_message, expGain),
                        type = "success",
                        duration = 5000,
                    })
                end
            end
        )
    end
end)

-- Fix the compatibility handler to properly format data for the new event
RegisterNetEvent(Config.ResourceName .. ':server:requestDeliveryComplete')
AddEventHandler(Config.ResourceName .. ':server:requestDeliveryComplete', function(items, reward)
    local src = source

    -- Add validation for the old format too
    if not items or type(items) ~= "table" then
        Server.Debug("Error: Invalid items data in requestDeliveryComplete from player " .. GetPlayerName(src))
        TriggerClientEvent(Config.ResourceName .. ':client:deliveryCompleteCallback', src, false, Config.Localess.Delivery.invalid_items_data)
        return
    end

    -- Convert old format to new format for compatibility
    local orderData = {
        items = items,
        cash = tonumber(reward) or 0
    }

    -- Call the new handler with properly formatted data
    TriggerEvent(Config.ResourceName .. ':server:completeDelivery', orderData)
end)
