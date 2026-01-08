-- Employee duty status client-side handling

-- Storage for cached duty status
local cachedDutyStatus = {}
local dutyStatusCallback = nil

-- Function to fetch duty status for multiple employees
local function FetchEmployeeDutyStatus(licenses, callback)
    dutyStatusCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:requestEmployeeDutyStatus', licenses)
end

-- Event handler to receive duty status updates
RegisterNetEvent(Config.ResourceName .. ':client:receiveEmployeeDutyStatus')
AddEventHandler(Config.ResourceName .. ':client:receiveEmployeeDutyStatus', function(statuses)
    -- Update our cached statuses
    for license, isOnDuty in pairs(statuses) do
        cachedDutyStatus[license] = isOnDuty
    end

    -- Call callback if exists
    if dutyStatusCallback then
        dutyStatusCallback(statuses)
        dutyStatusCallback = nil
    else
        -- No callback waiting, update UI directly
        SendNUIMessage({
            action = "updateEmployeeDutyStatus",
            dutyStatus = statuses
        })
    end
end)

-- Event handler for individual duty status updates
RegisterNetEvent(Config.ResourceName .. ':client:employeeDutyStatusChanged')
AddEventHandler(Config.ResourceName .. ':client:employeeDutyStatusChanged', function(data)
    if not data or not data.license then return end

    -- Update cached status
    cachedDutyStatus[data.license] = data.isOnDuty

    -- Update UI if boss menu is open
    SendNUIMessage({
        action = "updateEmployeeDutyStatus",
        dutyStatus = { [data.license] = data.isOnDuty }
    })

    -- Update employees list with duty status
    if cachedEmployees and #cachedEmployees > 0 then
        for i, employee in ipairs(cachedEmployees) do
            if employee.license == data.license then
                cachedEmployees[i].isOnDuty = data.isOnDuty
                break
            end
        end

        -- Refresh UI with updated employee data
        SendNUIMessage({
            action = "refreshEmployees",
            employees = cachedEmployees
        })
    end
end)

-- Function to get all on-duty employees
local function FetchOnDutyEmployees(jobName, callback)
    onDutyEmployeesCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getOnDutyEmployees', jobName)
end

-- Event handler to receive on-duty employees
RegisterNetEvent(Config.ResourceName .. ':client:receiveOnDutyEmployees')
AddEventHandler(Config.ResourceName .. ':client:receiveOnDutyEmployees', function(employees)
    if onDutyEmployeesCallback then
        onDutyEmployeesCallback(employees)
        onDutyEmployeesCallback = nil
    end
end)

-- NUI Callback for toggling an employee's duty status
RegisterNUICallback('toggleEmployeeDuty', function(data, cb)
    if not data or not data.license then
        cb({success = false, description = "Invalid employee data"})
        return
    end

    -- Send request to server to toggle duty status
    TriggerServerEvent(Config.ResourceName .. ':server:setEmployeeDutyStatus', data.license, data.setDuty)
    cb({success = true})
end)

-- Enhanced function to fetch employees with duty status
function FetchEmployeesWithDutyStatus(callback)
    employeesCallback = callback
    TriggerServerEvent(Config.ResourceName .. ':server:getEmployees')

    -- After a brief delay, request duty status for all employees
    Citizen.SetTimeout(200, function()
        -- Extract license IDs from cached employees
        local licenses = {}
        if cachedEmployees and #cachedEmployees > 0 then
            for _, employee in ipairs(cachedEmployees) do
                table.insert(licenses, employee.license)
            end

            -- Request duty status for all employees
            if #licenses > 0 then
                FetchEmployeeDutyStatus(licenses, function(dutyStatus)
                    -- Update employee duty status
                    if cachedEmployees and #cachedEmployees > 0 then
                        for i, employee in ipairs(cachedEmployees) do
                            cachedEmployees[i].isOnDuty = dutyStatus[employee.license] or false
                        end

                        -- Call original callback with updated employee data
                        if employeesCallback then
                            employeesCallback(cachedEmployees)
                            employeesCallback = nil
                        end
                    end
                end)
            end
        end
    end)
end

-- Export the enhanced function for boss menu to use
exports('FetchEmployeesWithDutyStatus', FetchEmployeesWithDutyStatus)
