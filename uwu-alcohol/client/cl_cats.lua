if not Config.EnableUwuCats then return end

local petting = false
local spawnedCats = {} -- Stores entity IDs

-- Helper: Load Animation Dictionary
local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

-- Helper: Load Model
local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(5)
    end
end

-- Event: Petting Logic
RegisterNetEvent('crux:petcat')
AddEventHandler('crux:petcat', function(ped)
    local player = PlayerPedId()
    
    -- Interaction Animation
    local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    local animation = "machinic_loop_mechandplayer"
    loadAnimDict(animDict)
    local animLength = GetAnimDuration(animDict, animation)

    -- Face the cat
    TaskTurnPedToFaceEntity(player, ped, 2000)
    Wait(1000)

    -- Start Petting
    petting = true
    FreezeEntityPosition(player, true)
    TaskPlayAnim(player, animDict, animation, 1.0, 4.0, animLength, 49, 0, 0, 0, 0)
    
    -- Sound & Effects
    SendNUIMessage({ command = "play", file = 'cat' })
    Wait(Config.PetCatDuration)

    -- Cleanup
    ClearPedTasks(player)
    FreezeEntityPosition(player, false)
    petting = false

    -- Reward
    TriggerServerEvent('crux:reduceStress')
end)

-- Main Logic: Spawn and Target
Citizen.CreateThread(function()
    -- Wait a moment for CRUX/Target to initialize safely
    Wait(1000) 

    for index, data in pairs(Config.Cats) do
        -- 1. Spawn the Ped
        loadModel(data.model)
        loadAnimDict(data.animDict)

        local ped = CreatePed(4, data.model, data.coords.x, data.coords.y, data.coords.z - 1.0, data.heading, false, true)
        
        SetEntityHeading(ped, data.heading)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        -- Play the config-defined animation (Ledge or Ground)
        TaskPlayAnim(ped, data.animDict, data.animName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        
        spawnedCats[index] = ped

        -- 2. Add Target Zone
        local zoneName = "uwu-cat-" .. index
        CRUX.Target.AddBoxZone(
            zoneName,
            data.coords,
            data.boxzone.length,
            data.boxzone.width,
            {
                heading = data.heading,
                minZ = data.boxzone.minZ,
                maxZ = data.boxzone.maxZ,
                options = {
                    {
                        action = function()
                            TriggerEvent('crux:petcat', spawnedCats[index])
                        end,
                        icon = 'fa-solid fa-cat',
                        label = 'Pet ' .. (data.label or "Cat"),
                    }
                },
                distance = data.boxzone.distance
            },
            false -- debugPoly
        )
    end
end)

-- Cleanup: Delete cats when resource stops (prevents duplicates)
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    for _, ped in pairs(spawnedCats) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
end)