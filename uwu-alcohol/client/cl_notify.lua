-- local openNotifications = 0

-- -- Utility function for client-side notifications using PrimeToast
-- local function NotifyClient(data)
--     -- Set defaults if properties are missing
--     local title = data.title or ""
--     local description = data.message or data.description or ""
--     local type = data.type or "info" -- default type is info
--     local duration = data.duration or 3000 -- default 3 seconds

--     -- Map notification types to PrimeToast severity
--     local severity = "info" -- default
--     if type == "success" then
--         severity = "success"
--     elseif type == "error" then
--         severity = "error"
--     elseif type == "warning" then
--         severity = "warn"
--     end

--     -- Send the notification to NUI
--     SendNUIMessage({
--         action = "sendNotification",
--         data = {
--             title = title,
--             description = message,
--             severity = severity,
--             duration = duration,
--             position = Config.NotifyPosition -- Use NotifyPosition from config
--         }
--     })

--     -- Increment count to track active notifications
--     openNotifications = openNotifications + 1

--     -- Return notification ID (for potential future reference)
--     return openNotifications
-- end

-- -- Event handler for client notifications
-- RegisterNetEvent(Config.ResourceName .. ':notify')
-- AddEventHandler(Config.ResourceName .. ':notify', function(data)
--     NotifyClient(data)
-- end)

-- -- Register a callback to update notify position when requested
-- RegisterNUICallback('getNotifyPosition', function(data, cb)
--     cb({ position = Config.NotifyPosition or 'center-right' })
-- end)

-- -- Event handler for server-triggered notifications
-- RegisterNetEvent(Config.ResourceName .. ':notify:client')
-- AddEventHandler(Config.ResourceName .. ':notify:client', function(data)
--     NotifyClient(data)
-- end)

-- -- Create a replacement for CRUX.Notify that forwards to our new system
-- function Toast(data)
--     return NotifyClient(data)
-- end

-- -- Make CRUX.Notify an alias for our Toast function
-- if CRUX then
--     CRUX.Notify = Toast
-- end
