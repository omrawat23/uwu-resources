-- Local variables
local menuOpen = false

-- Function to open restaurant menu
function RestaurantMenu(menuIndex, menuImage)
    -- Don't open if already open
    if menuOpen then return end

    -- Make sure the player has the correct job
    local playerJob = JobSystem.GetJob()
    if Config.NeedDuty and playerJob.name == Config.JobName and not playerJob.onduty then
        CRUX.Notify({
            title = Config.Localess.RestaurantMenu.title or "Restaurant Menu",
            description = Config.Localess.RestaurantMenu.onduty or "You must be on duty to access this!",
            type = "error",
            duration = 5000,
        })
        return
    end

    -- Find or create business name
    local businessName = Config.JobLabel or "Restaurant"

    -- Send the menu data to NUI
    SendNUIMessage({
        action = "openRestaurantMenu",
        menuImage = menuImage,
        businessName = businessName,
        menuIndex = menuIndex or 1
    })

    -- Set the flag indicating menu is open
    menuOpen = true

    -- Enable cursor for the menu
    SetNuiFocus(true, true)
end

-- NUI Callback for when the menu is closed from the UI
RegisterNUICallback('closeRestaurantMenu', function(data, cb)
    -- Disable cursor
    SetNuiFocus(false, false)
    menuOpen = false
    cb('ok')
end)

-- Event to open the restaurant menu (can be triggered from other scripts)
RegisterNetEvent(Config.ResourceName .. ':client:openRestaurantMenu')
AddEventHandler(Config.ResourceName .. ':client:openRestaurantMenu', function(menuIndex, menuImage)
    RestaurantMenu(menuIndex, menuImage)
end)
