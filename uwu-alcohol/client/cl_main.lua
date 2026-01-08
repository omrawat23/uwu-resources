-- When opening the UI, send the notify position config
RegisterNetEvent(Config.ResourceName .. ':openClientMenu')
AddEventHandler(Config.ResourceName .. ':openClientMenu', function(menuType)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open",
        menuType = menuType,
        config = {
            NotifyPosition = Config.NotifyPosition,

        }
    })
end)

-- Register NUI callback to get notify position
RegisterNUICallback('getNotifyPosition', function(data, cb)
    -- Return the notify position from config
    cb({position = Config.NotifyPosition or 'center-right'})
end)

-- Register NUI callback to get UI close button
RegisterNUICallback('getCloseUiButton', function(_, cb)
    -- Send both keys as an array
    cb({ buttons = Config.CloseUiButton })
end)

-- Register NUI callback to get UI close button
RegisterNUICallback('getVendingMachine', function(_, cb)
    cb({ vending = Config.EnableVendingMachine})
end)

-- Add this to cl_main.lua to send notify position updates
-- This can be called whenever the config changes or when the UI is initialized
function SendConfigToUI()
    SendNUIMessage({
        type = 'updateConfig',
        config = {
            NotifyPosition = Config.NotifyPosition or 'center-right',

        }
    })
end

-- Add new NUI callback for notifications
RegisterNUICallback('sendNotification', function(data, cb)
    
    local title = data.title or "Restaurant"
    local description = data.message or "Boss Menu"
    local notificationType = data.type or "info"
    local duration = data.duration or 3000

    CRUX.Notify({
        title = title,
        description = message,
        type = notificationType,
        duration = duration,
    })
    
    cb('ok')
end)


-- Example: Call this when resource starts or config reloads
-- Add this to an appropriate location in your code
AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    -- Short delay to ensure UI is ready
    SetTimeout(500, function()
        SendNUIMessage({
            type = 'updateConfig',
            config = {
                NotifyPosition = Config.NotifyPosition or 'center-right',

            }
        })
    end)
end)
