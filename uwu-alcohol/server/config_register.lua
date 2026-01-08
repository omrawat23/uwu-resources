-- Register the Config with crux_lib immediately
local resourceName = GetCurrentResourceName()

-- Function to register config
local function registerConfig()
    if Config then
        local success = pcall(function()
            exports['crux_lib']:SetExternalConfig(resourceName, Config)
        end)
        return success
    end
    return false
end

-- Try immediate registration
if not registerConfig() then
    -- Retry with increasing delays
    Citizen.CreateThread(function()
        for i = 1, 10 do
            Citizen.Wait(100 * i) -- Increasing delay
            if registerConfig() then
                print('^2[' .. resourceName .. ']^7 Successfully registered config with crux_lib')
                break
            end
            
            if i == 10 then
                print('^1[' .. resourceName .. ']^7 Failed to register config with crux_lib after multiple attempts')
            end
        end
    end)
end

-- Also register when resource starts (belt and suspenders approach)
AddEventHandler('onResourceStart', function(resource)
    if resource == resourceName then
        Citizen.Wait(100)
        registerConfig()
    end
end)
