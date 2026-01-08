-- Initialize variables with default values
local playerJob = {name = "unemployed"}
local playerName = nil
local playerCash = nil
local playerBank = nil

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
        Client.Debug("WARNING: JobSystem not available in cl_employee.lua")
    end
end)


-- Storage for cached data
local cachedMenuItems = {}
local cachedNearbyPlayers = {}
local billingMenuItemsCallback = nil
local billingNearbyPlayersCallback = nil
local cachedEmployeeData = {}
local playerAvatarUrl = nil -- Add storage for player avatar

-- Add storage for current terminal indices
local currentTerminalIndex = nil
local currentKioskIndex = nil
local currentOrderManagementIndex = nil -- Add order management tablet index

-- Function to fetch avatar data
local function FetchPlayerAvatar()
    TriggerServerEvent(Config.ResourceName .. ':server:getPlayerAvatar')
    -- Allow a moment for the response
    Citizen.Wait(100)
end

-- Event handler for receiving avatar data
RegisterNetEvent(Config.ResourceName .. ':client:receivePlayerAvatar')
AddEventHandler(Config.ResourceName .. ':client:receivePlayerAvatar', function(avatarUrl)
    playerAvatarUrl = avatarUrl
    Client.Debug("Received player avatar URL: " .. (avatarUrl or "nil"))
end)

-- Function to fetch menu items specifically for billing menu
local function FetchBillingMenuItems(callback)
    -- Store the callback for later use when we receive the response
    billingMenuItemsCallback = callback
    -- Trigger server event to get menu items, passing the terminal index
    TriggerServerEvent(Config.ResourceName .. ':server-billing:requestMenuItems', currentTerminalIndex)
end

-- Function to fetch nearby players for billing
local function FetchBillingNearbyPlayers(callback)
    Client.Debug("Requesting nearby players for billing menu")
    billingNearbyPlayersCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server-billing:getNearbyPlayers')
end

-- Function to get commission info from job grade and possibly database
local function GetCommissionInfo()
    local commissionInfo = {
        enabled = Config.Billing.Commission.enabled,
        percentage = 0
    }

    -- First check if we have employee data with commission from the server
    if cachedEmployeeData and cachedEmployeeData.commission and cachedEmployeeData.commission > 0 then
        commissionInfo.percentage = tonumber(cachedEmployeeData.commission)
        Client.Debug("Using employee commission rate from database: " .. commissionInfo.percentage .. "%")
        return commissionInfo
    end

    -- Get current job grade as fallback
    playerJob = JobSystem.GetJob()
    local gradeLevel = tostring(playerJob.grade)

    -- Get commission from job grade config
    if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
        commissionInfo.percentage = tonumber(Config.Grades[gradeLevel].Commission)
        Client.Debug("Using job grade commission rate: " .. commissionInfo.percentage .. "% (Grade " .. gradeLevel .. ")")
    else
        -- Fallback to default commission rate
        commissionInfo.percentage = tonumber(Config.Billing.Commission.percentage)
        Client.Debug("Using default commission rate: " .. commissionInfo.percentage .. "%")
    end

    -- Ensure percentage is a number
    commissionInfo.percentage = tonumber(commissionInfo.percentage) or 0

    -- Debug output
    Client.Debug("Final commission percentage for billing UI: " .. commissionInfo.percentage .. "%")

    return commissionInfo
end

-- Request employee data from server, including commission
local function RequestEmployeeData()
    TriggerServerEvent(Config.ResourceName .. ':server-billing:getEmployeeData')
    -- Allow a moment for the response
    Citizen.Wait(100)
end

-- Event handler to receive menu items from server
RegisterNetEvent(Config.ResourceName .. ':client-billing:receiveMenuItems')
AddEventHandler(Config.ResourceName .. ':client-billing:receiveMenuItems', function(menuItems)
    cachedMenuItems = menuItems or {}
    Client.Debug("Billing: Received menu items: " .. #cachedMenuItems)

    if billingMenuItemsCallback then
        billingMenuItemsCallback(cachedMenuItems)
        billingMenuItemsCallback = nil
    end
end)

-- Event handler to receive nearby players for billing
RegisterNetEvent(Config.ResourceName .. ':client-billing:receiveNearbyPlayers')
AddEventHandler(Config.ResourceName .. ':client-billing:receiveNearbyPlayers', function(nearbyPlayers)
    if nearbyPlayers then
        Client.Debug("Billing: Received " .. #nearbyPlayers .. " nearby players")
        -- Log the first player to verify data format
        if #nearbyPlayers > 0 then
            Client.Debug("First player: " .. nearbyPlayers[1].name .. " (ID: " .. nearbyPlayers[1].id .. ")")
        end
        cachedNearbyPlayers = nearbyPlayers
    else
        Client.Debug("Billing: Received empty nearby players list")
        cachedNearbyPlayers = {}
    end

    if billingNearbyPlayersCallback then
        billingNearbyPlayersCallback(cachedNearbyPlayers)
        billingNearbyPlayersCallback = nil
    end
end)

-- Initialize with cached employee data if available
RegisterNetEvent(Config.ResourceName .. ':client-billing:receiveEmployeeData')
AddEventHandler(Config.ResourceName .. ':client-billing:receiveEmployeeData', function(employeeData)
    if employeeData then
        cachedEmployeeData = employeeData
        Client.Debug("Received employee data - Commission: " .. tostring(employeeData.commission) .. "%, Billings: " .. tostring(employeeData.billings or 0))
    else
        Client.Debug("Warning: Received empty employee data")
    end
end)

-- Add event handler for business status changes
RegisterNetEvent(Config.ResourceName .. ':client:businessStatusChanged')
AddEventHandler(Config.ResourceName .. ':client:businessStatusChanged', function(data)
    if data.job == Config.JobName then
        businessStatus.isOpen = data.isOpen
        Client.Debug("Business status updated: " .. (data.isOpen and "OPEN" or "CLOSED"))
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

-- Main function to open the billing menu
function OpenBillingMenu(i,v)
    currentTerminalIndex = i  -- Store the terminal index

    -- Get fresh data when menu is opened
    playerJob = JobSystem.GetJob()
    playerName = CRUX.Framework.GetPlayerName()
    playerCash = CRUX.Framework.GetCash()
    playerBank = CRUX.Framework.GetBank()

    -- First check if business is open before allowing billing
    if not businessStatus.isOpen then
        CRUX.Notify({
            title = Config.Localess.Billing.terminal_title,
            description = Config.Localess.Billing.business_closed,
            type = "error",
            duration = 5000,
        })
        return
    -- Then check for duty status only if Config.NeedDuty is true
    elseif Config.NeedDuty and not playerJob.onduty and Config.Billing and Config.Billing.enabled then
        CRUX.Notify({
            title = Config.Localess.Billing.terminal_title,
            description = Config.Localess.Billing.off_duty_error,
            type = "error",
            duration = 5000,
        })
        return
    -- Finally check if player has the correct job
    elseif playerJob.name ~= Config.JobName then
        CRUX.Notify({
            title = Config.Localess.Billing.terminal_title,
            description = Config.Localess.Billing.access_denied,
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

    -- Fetch player avatar data before opening menu
    FetchPlayerAvatar()

    -- Request fresh employee data (including commission and billings) before opening menu
    RequestEmployeeData()

    -- Fetch all required data before opening the billing menu
    FetchBillingMenuItems(function(menuItems)
        Client.Debug("Billing menu items fetched: " .. #menuItems)

        FetchBillingNearbyPlayers(function(nearbyPlayers)
            Client.Debug("Nearby players fetched for billing: " .. #nearbyPlayers)

            -- Get commission info based on player's job grade or database
            local commissionInfo = GetCommissionInfo()
            Client.Debug("Billing with commission rate: " .. commissionInfo.percentage .. "%")

            -- Safely get grade name with error handling
            local gradeName = "Unknown"
            -- Use the extracted gradeLevel instead of direct conversion
            local gradeKey = gradeLevel
            if Config.Grades and Config.Grades[gradeKey] then
                gradeName = Config.Grades[gradeKey].Label
            end

            -- Prepare the data for the UI, now including avatar
            local menuData = {
                action = "openBillingMenu",
                data = {
                    playerJob = {
                        name = playerJob.name,
                        label = playerJob.label,
                        grade = playerJob.grade,
                        grade_name = gradeName,
                        onduty = playerJob.onduty
                    },
                    playerData = {
                        name = playerName,
                        bank = playerBank,
                        cash = playerCash,
                        avatar = playerAvatarUrl -- Add avatar URL here
                    },
                    locales = Config.Localess,
                    locales_utils = Config.LocalessUtils,
                    menuItems = menuItems,
                    nearbyPlayers = nearbyPlayers,
                    commissionInfo = commissionInfo,
                    employeeStats = {
                        billings = cachedEmployeeData.billings or 0
                    }
                }
            }

            -- Send data to the UI and enable cursor
            Client.Debug("Opening billing menu with commission rate: " .. commissionInfo.percentage .. "%")
            SendNUIMessage(menuData)
            SetNuiFocus(true, true)
        end)
    end)
end

-- Event handler to specifically open billing menu (used by commands)
RegisterNetEvent(Config.ResourceName .. ':client-billing:openBillingMenu')
AddEventHandler(Config.ResourceName .. ':client-billing:openBillingMenu', function()
    local index = currentTerminalIndex or 1
    OpenBillingMenu(index)
end)

-- NUI Callback to handle closing the menu
RegisterNUICallback('closeBillingMenu', function(data, cb)
    SetNuiFocus(false, false)
    -- Unlock the billing terminal on the server
    if currentTerminalIndex then
        TriggerServerEvent(Config.ResourceName .. ':server:unlockBillingTerminal', currentTerminalIndex)
        currentTerminalIndex = nil
    end
    cb('ok')
end)

-- NUI Callback to handle sending a bill
RegisterNUICallback('sendBill', function(data, cb)
    if not data.playerId or not data.amount then
        cb({ success = false, description = "Invalid data" })
        return
    end

    -- Forward bill request to server
    TriggerServerEvent(Config.ResourceName .. ':server-billing:sendBill', {
        playerId = data.playerId,
        amount = data.amount,
        reason = data.reason or "Unknown",
        items = data.items or {},
        paymentMethod = data.paymentMethod or "cash",
        terminalIndex = currentTerminalIndex  -- Include terminal index
    })

    SetNuiFocus(true, true)
    cb({ success = true })
end)

-- Event handler for bill payment notifications
RegisterNetEvent(Config.ResourceName .. ':client-billing:billPaid')
AddEventHandler(Config.ResourceName .. ':client-billing:billPaid', function(data)
    if data and data.success then
        CRUX.Notify({
            title = Config.Localess.Billing.payment_received,
            description = string.format(Config.Localess.Billing.payment_received_message, data.amount, data.playerName),
            type = "success",
            duration = 5000,
        })
    else
        CRUX.Notify({
            title = Config.Localess.Billing.payment_failed,
            description = data.message or Config.Localess.Billing.payment_failed_message,
            type = "error",
            duration = 5000,
        })
    end
end)

-- Event handler for receiving a bill
RegisterNetEvent(Config.ResourceName .. ':client-billing:receiveBill')
AddEventHandler(Config.ResourceName .. ':client-billing:receiveBill', function(billData)
   Client.Debug('^^^ LUA: Received bill event on client. Sending to NUI. Bill ID: ' .. tostring(billData.id))

    -- Play a subtle notification sound for the bill
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

    -- Forward the enhanced bill data to the UI for display
    SendNUIMessage({
        action = 'receiveBillingRequest',
        id = billData.id,
        sender = billData.sender,
        amount = billData.amount,
        paymentMethod = billData.paymentMethod,
        reason = billData.reason,
        greeting = billData.greeting,
        businessName = billData.businessName,
        items = billData.items,
        -- Add notification title, title header, image, and message from Config.Localess
        localedata = Config.Localess.BillingInviteNotification,
        notificationTitle = Config.LocalessUtils.BillingInviteNotification.label,
        notificationImage = Config.LocalessUtils.BillingInviteNotification.titleImage,
        titleHeader = Config.LocalessUtils.BillingInviteNotification.title,
        description = Config.Localess.BillingInviteNotification.message,
        timeoutDuration = Config.BillTimer  -- Pass the configured timer value
    })

    -- Make the cursor visible for the bill UI
    SetNuiFocus(true, true)
end)

-- NUI callback when a bill is accepted
RegisterNUICallback('acceptBill', function(data, cb)
    Client.Debug("Bill accepted: " .. json.encode(data))
    TriggerServerEvent(Config.ResourceName .. ':server-billing:acceptBill', data.billId)
    SetNuiFocus(false, false)  -- Release NUI focus after accepting the bill
    cb({ success = true })
end)

-- NUI callback when a bill is rejected
RegisterNUICallback('rejectBill', function(data, cb)
    Client.Debug("Bill rejected: " .. json.encode(data))
    TriggerServerEvent(Config.ResourceName .. ':server-billing:rejectBill', data.billId)
    SetNuiFocus(false, false)  -- Release NUI focus after rejecting the bill
    cb({ success = true })
end)

-- NUI callback to track remaining bills and manage cursor focus
RegisterNUICallback('remainingBillingRequests', function(data, cb)
    Client.Debug("Remaining billing requests: " .. data.count)
    -- if data.count <= 0 then
    --     SetNuiFocus(false, false)
    -- end
    cb('ok')
end)

-- NUI callback to close bill receipt modal and release focus
RegisterNUICallback('closeBillReceipt', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Event handler for bill response
RegisterNetEvent(Config.ResourceName .. ':client:billResponse')
AddEventHandler(Config.ResourceName .. ':client:billResponse', function(response)
    if response.success then
        CRUX.Notify({
            title = Config.Localess.Billing.bill_sent,
            description = response.message or Config.Localess.Billing.bill_sent_success,
            type = "success",
            duration = 3000,
        })
    else
        CRUX.Notify({
            title = Config.Localess.Billing.bill_sent,
            description = response.message or Config.Localess.Billing.bill_sent_error,
            type = "error",
            duration = 3000,
        })
    end
end)


-- Event handler for item usage
-- Event handler for opening bill receipt
RegisterNetEvent(":lib:client:OpenBillReceipt", function(item)
    if item.info and item.info.id then
        -- If items is a stringified array, decode it
        if type(item.info.items) == "string" then
            local success, decoded = pcall(function() return json.decode(item.info.items) end)
            if success and type(decoded) == "table" then
                -- Check if decoded is an array of strings (legacy) or objects (new)
                if #decoded > 0 and type(decoded[1]) == "string" then
                    -- Legacy: Transform array of strings into array of objects
                    local transformedItems = {}
                    for _, itemName in ipairs(decoded) do
                        table.insert(transformedItems, {
                            label = itemName,  -- Use the string as the label
                            quantity = 1,     -- Default quantity
                            price = 0         -- Default price
                        })
                    end
                    item.info.items = transformedItems
                elseif #decoded > 0 and type(decoded[1]) == "table" then
                    -- New: Already an array of objects, use as is
                    item.info.items = decoded
                else
                    -- Empty or invalid array
                    item.info.items = {}
                end
            else
                -- Decode failed, set to empty
                item.info.items = {}
            end
        elseif type(item.info.items) == "table" then
            -- If already a table, assume it's correct (fallback)
            -- No action needed
        else
            -- Invalid type, set to empty
            item.info.items = {}
        end

        SendNUIMessage({
            action = 'openBillReceipt',
            bill = {
                id = item.info.id,
                order_label = item.info.order_label,  -- Pass order_label to UI
                sender = item.info.sender,
                amount = item.info.amount,
                paymentMethod = item.info.paymentMethod,
                reason = item.info.reason,
                businessName = item.info.businessName,
                items = item.info.items,
                date = item.info.date,
                titleImage = Config.LocalessUtils.BillingInviteNotification.titleImage,
                terminalType = item.info.terminalType or "Unknown"  -- Add terminal type from metadata
            }
        })
        SetNuiFocus(true, true)
    end
end)


-- Function to open the ordering tablet
function OpenOrderingTablet(index, tabletData)
    currentKioskIndex = index  -- Store the kiosk index

    -- Check if business is open before allowing ordering
    if not businessStatus.isOpen then
        CRUX.Notify({
            title =  Config.Localess.Billing.kiosk_closed_title or "Kiosk Closed",
            description = Config.Localess.Billing.kiosk_closed or "Kiosk is currently closed by the management.",
            type = "error",
            duration = 5000,
        })
        return
    end

    Client.Debug("Opening ordering tablet " .. index)

    -- Refresh player data
    playerJob = JobSystem.GetJob()
    playerName = CRUX.Framework.GetPlayerName()
    playerCash = CRUX.Framework.GetCash()
    playerBank = CRUX.Framework.GetBank()

    -- Set a callback to handle menu items when the server responds,
    -- then directly request the items from the server.
    billingMenuItemsCallback = function(menuItems)
        Client.Debug("Ordering: Fetched menu items: " .. #menuItems)

        -- Prepare data for ordering tab
        local orderingData = {
            action = "openOrderingTab",
            data = {
                tabletIndex = index,
                tabletData = tabletData,
                menuItems = menuItems,
                locales = Config.Localess,
                playerData = {
                    name = playerName,
                    bank = playerBank,
                    cash = playerCash
                },
                titleImage = Config.LocalessUtils.SelfOrderingTab.titleImage
            }
        }

        -- Send to NUI
        SendNUIMessage(orderingData)
        SetNuiFocus(true, true)
    end

    TriggerServerEvent(Config.ResourceName .. ':server-billing:requestMenuItems', currentKioskIndex)
end

-- NUI Callback to handle ordering tab visibility
RegisterNUICallback('setOrderingTabVisible', function(data, cb)
    -- Set NUI focus based on visibility state
    if data.visible then
        SetNuiFocus(true, true)
    else
        SetNuiFocus(false, false)
        -- Unlock the kiosk when closing
        if currentKioskIndex then
            TriggerServerEvent(Config.ResourceName .. ':server:unlockKiosk', currentKioskIndex)
            currentKioskIndex = nil
        end
    end
    cb('ok')
end)

-- NUI Callback to handle ordering checkout
RegisterNUICallback('processOrderingCheckout', function(data, cb)
    if not data.cart or #data.cart == 0 then
        cb({ success = false, message = "Cart is empty" })
        return
    end

    local totalAmount = data.totalAmount
    local items = data.cart
    local paymentMethod = data.paymentMethod or "cash"

    -- Check if player has enough money
    local hasEnough = false
    if paymentMethod == "cash" then
        hasEnough = playerCash >= totalAmount
    elseif paymentMethod == "bank" then
        hasEnough = playerBank >= totalAmount
    end

    if not hasEnough then
        cb({ success = false, message = "Insufficient funds" })
        return
    end

    -- Trigger server event to process checkout (similar to billing)
    TriggerServerEvent(Config.ResourceName .. ':server:processOrderingCheckout', {
        amount = totalAmount,
        items = items,
        paymentMethod = paymentMethod,
        terminalIndex = currentKioskIndex  -- Include kiosk index
    })

    cb({ success = true })
end)

-- Event handler for ordering checkout response
RegisterNetEvent(Config.ResourceName .. ':client:orderingCheckoutProcessed')
AddEventHandler(Config.ResourceName .. ':client:orderingCheckoutProcessed', function(data)
    if data.success then
        CRUX.Notify({
            title = Config.Localess.Order.complete,
            description = Config.Localess.Order.description,
            type = "success",
            duration = 5000,
        })

        -- Close the ordering tab
        SendNUIMessage({ action = "closeOrderingTab" })
        SetNuiFocus(false, false)

        -- Trigger animation if enabled
        if Config.SelfOrderKioskAnimation and Config.SelfOrderKioskAnimation.enable then
            RequestAnimDict(Config.SelfOrderKioskAnimation.dict)
            while not HasAnimDictLoaded(Config.SelfOrderKioskAnimation.dict) do
                Wait(0)
            end
            
            -- Use config values or defaults
            local speed = Config.SelfOrderKioskAnimation.speed or 8.0
            local speedMultiplier = Config.SelfOrderKioskAnimation.speedMultiplier or -8.0
            local duration = Config.SelfOrderKioskAnimation.duration or 2000
            local flag = Config.SelfOrderKioskAnimation.flag or 49
            
            TaskPlayAnim(PlayerPedId(), Config.SelfOrderKioskAnimation.dict, Config.SelfOrderKioskAnimation.name, speed, speedMultiplier, duration, flag, 0, false, false, false)
            
            -- Wait for animation to play briefly
            Wait(duration)
            ClearPedTasks(PlayerPedId())
        end
        
    else
        CRUX.Notify({
            title = Config.Localess.Shop.purchase_error,
            description = data.message or "Failed to process order",
            type = "error",
            duration = 5000,
        })
    end
end)

--- [START] ORDER MANAGEMENT SECTION ---

RegisterNUICallback('getCompletedOrders', function(data, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:getCompletedOrders')
    cb('ok')
end)

-- This function can be called from a target script or command to open the UI.
function OpenOrderManagementTablet(index, tabletData)
    currentOrderManagementIndex = index  -- Store the order management tablet index
    
    -- Check if business is open before allowing order management
    if not businessStatus.isOpen then
        CRUX.Notify({
            title = Config.Localess.Billing.terminal_title,
            description = Config.Localess.Billing.business_closed,
            type = "error",
            duration = 5000,
        })
        return
    end

    Client.Debug("Requesting initial orders for tablet " .. tostring(index))
    -- Pass tabletData to the server, which will pass it back
    TriggerServerEvent(Config.ResourceName .. ':server:getInitialOrders', {index = index, data = tabletData})
end

RegisterNetEvent(Config.ResourceName .. ':client:openOrderManagementWithData')
AddEventHandler(Config.ResourceName .. ':client:openOrderManagementWithData', function(orders, tabletInfo)
    Client.Debug("Received " .. #orders .. " initial orders. Opening management tablet.")

    -- Debug: Show all data being sent to NUI
    local nuiData = {
        action = "openOrderManagement",
        locales = Config.Localess,
        data = {
            tabletIndex = tabletInfo.index,
            tabletData = tabletInfo.data,
            isVisible = true,
            orders = orders -- Pass orders directly
        },
        description = {
            title = Config.LocalessUtils.OrderManagementTab.title,
            label = Config.LocalessUtils.OrderManagementTab.label,
            titleImage = Config.LocalessUtils.OrderManagementTab.titleImage
        },
    }
    -- Client.Debug"Sending to NUI: " .. json.encode(nuiData))

    -- Send the message to the React UI to open the component with orders pre-loaded
    SendNUIMessage(nuiData)

    -- Give focus to the UI
    SetNuiFocus(true, true)
end)

-- Forward completed orders sent from server to the React UI
RegisterNetEvent(Config.ResourceName .. ':client:receiveCompletedOrders')
AddEventHandler(Config.ResourceName .. ':client:receiveCompletedOrders', function(completedOrders)
    -- Ensure we forward in a shape the UI can handle; include as 'orders' property.
    SendNUIMessage({
        action = 'receiveCompletedOrders',
        orders = completedOrders or {}
    })
end)

-- Make this function available for other scripts to use
exports('OpenOrderManagementTablet', OpenOrderManagementTablet)

-- NUI callback for when the UI wants to refresh the list of orders
RegisterNUICallback('getOrders', function(_, cb)
    TriggerServerEvent(Config.ResourceName .. ':server:refreshOrders')
    cb('ok')
end)

-- NUI callback to forward a status update request to the server
RegisterNUICallback('updateOrderStatus', function(data, cb)
    if data.orderId and data.status then
        TriggerServerEvent(Config.ResourceName .. ':server:updateOrderStatus', data)
    end
    cb('ok')
end)

-- NUI callback to close the order management UI
RegisterNUICallback('closeOrderManagement', function(data, cb)
    SetNuiFocus(false, false)
    -- Unlock the order management tablet on the server
    if currentOrderManagementIndex then
        TriggerServerEvent(Config.ResourceName .. ':server:unlockOrderManagement', currentOrderManagementIndex)
        currentOrderManagementIndex = nil
    end
    cb('ok')
end)


-- Event handler to receive the list of orders from the server
RegisterNetEvent(Config.ResourceName .. ':client:receiveOrders')
AddEventHandler(Config.ResourceName .. ':client:receiveOrders', function(orders)
    -- Forward the received orders to the React UI in a consistent shape
    -- The UI expects either an array or an object with 'orders' property; we send { orders = orders }.
    SendNUIMessage({
        action = 'updateOrderList',
        orders = orders or {}
    })
end)

--- [END] ORDER MANAGEMENT SECTION ---

-- Export the function for use in other files
exports('OpenBillingMenu', OpenBillingMenu)

-- NUI callback to accept self-pickup order
RegisterNUICallback('acceptSelfPickupOrder', function(data, cb)
    if data.orderId then
        TriggerServerEvent(Config.ResourceName .. ':server:acceptSelfPickupOrder', data)
    end
    cb('ok')
end)


