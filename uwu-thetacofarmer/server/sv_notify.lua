-- -- Server-side notification utility

-- -- Function to send notification to a specific player
-- function NotifyPlayer(source, data)
--     if not source or source == 0 then return end

--     -- For backwards compatibility, support different parameter formats
--     local notifyData = data
--     if type(data) == "string" then
--         notifyData = {
--             title = "Notification",
--             message = data,
--             type = "info",
--             duration = 3000
--         }
--     elseif not data.message and data.description then
--         notifyData.message = data.description
--     end

--     -- Trigger notification on client
--     TriggerClientEvent(Config.ResourceName .. ':notify:client', source, notifyData)
-- end

-- -- Function to send notification to all players
-- function NotifyAll(data)
--     -- For backwards compatibility, support different parameter formats
--     local notifyData = data
--     if type(data) == "string" then
--         notifyData = {
--             title = "Notification",
--             message = data,
--             type = "info",
--             duration = 3000
--         }
--     elseif not data.message and data.description then
--         notifyData.message = data.description
--     end

--     -- Trigger notification for all clients
--     TriggerClientEvent(Config.ResourceName .. ':notify:client', -1, notifyData)
-- end

-- -- Export the notification functions
-- exports('NotifyPlayer', NotifyPlayer)
-- exports('NotifyAll', NotifyAll)

-- -- Register server events that other resources can trigger
-- RegisterNetEvent(Config.ResourceName .. ':server:notifyPlayer')
-- AddEventHandler(Config.ResourceName .. ':server:notifyPlayer', function(target, data)
--     -- Check if the source has permission to send notifications
--     -- This could be enhanced with more robust permission checks
--     NotifyPlayer(target, data)
-- end)

-- -- Add CRUX compatibility if needed
-- if CRUX then
--     CRUX.Notify = NotifyPlayer
-- end
