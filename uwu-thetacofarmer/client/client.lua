Client = {}
Client.DebugClient = false
Config.Localess = Locales[Config.Locales]
resourceName = GetCurrentResourceName()
handsDirty = true
onDuty = false
sBlip = nil

local inventoryItems = nil
local isPlayerCrafting = false  -- Add this flag to prevent spam crafting

cPreset = Preset[Config.ActivePreset]

Client.Debug = function(msg)
   if Client.DebugClient then
        if type(msg) == "function" then
            msg()
        else
            print(msg)
        end
    end
end

local function removeSBlip()
    if sBlip then
        RemoveBlip(sBlip)
        sBlip = nil
    end
    onDuty = false
end

-- Add the reset event for crafting state
RegisterNetEvent(Config.ResourceName .. ":Client:ResetCraftingState", function()
    isPlayerCrafting = false
end)

function WashHands(index)
    if handsDirty then
        local ped = PlayerPedId()
        local sink = cPreset.sinks[index]
        TaskTurnPedToFaceCoord(ped, sink.location.x, sink.location.y, sink.location.z, 2000)

        local progressOptions = {
            duration = Config.WashingProgressBar.duration,
            id = 'washHands',
            label = Config.WashingProgressBar.label,
            disable = {
                move = true,
                car = true,
                combat = true
            },
            canCancel = true
        }

        -- Add animation based on config
        if Config.WashingProgressBar.animation.scenario.enabled then
            progressOptions.animation = {
                scenario = Config.WashingProgressBar.animation.scenario.anim.scenario
            }
        elseif Config.WashingProgressBar.animation.emote.enabled then
            progressOptions.animation = {
            animDict = Config.WashingProgressBar.animation.emote.anim.dict,
            anim = Config.WashingProgressBar.animation.emote.anim.clip,
            flag = 49
            }

            if Config.WashingProgressBar.animation.emote.prop and Config.WashingProgressBar.animation.emote.prop.enable then
            progressOptions.prop = {
                model = Config.WashingProgressBar.animation.emote.prop.model,
                bone = Config.WashingProgressBar.animation.emote.prop.bone,
                pos = Config.WashingProgressBar.animation.emote.prop.pos,
                rot = Config.WashingProgressBar.animation.emote.prop.rot
            }
            end
        end

        local prog = CRUX.Progress(progressOptions)

        if prog then
            handsDirty = false
            CRUX.Notify({
                title = Config.Localess.System.success,
                description = Config.Localess.WashHands.success,
                type = "success",
                duration = 5000,
            })
            ClearPedTasks(ped)
        end
        
        -- Cleanup any attached props
    local playerPed = PlayerPedId()
    for _, entityId in ipairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(entityId, playerPed) then
            NetworkRequestControlOfEntity(entityId)
            DetachEntity(entityId, true, true)
            SetEntityAsMissionEntity(entityId, true, true)
            DeleteObject(entityId)
            DeleteEntity(entityId)
        end
    end
        
        ClearPedTasks(playerPed)
        
        if Config.WashingProgressBar.animation.emote.prop and Config.WashingProgressBar.animation.emote.enabled then
            DeleteObject(GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, GetHashKey(Config.WashingProgressBar.animation.emote.prop.model), false, false, false))
        end
    else
        CRUX.Notify({
            title = Config.Localess.WashHands.fail,
            description = Config.Localess.WashHands.fail,
            type = "error",
            duration = 5000,
        })
    end
end

RegisterNetEvent(Config.ResourceName .. ":settedDuty", function(duty)
    if duty == nil then onDuty = true end
    onDuty = duty
end)

RegisterNetEvent(Config.ResourceName .. ":onPlayerLoaded", function()
    local job = JobSystem.GetJob()

    if job and job.name == Config.JobName then
        sBlip = CRUX.Utils.CreateBlip({
                location = cPreset.shop.Blip.location,
                sprite = cPreset.shop.Blip.sprite,
                scale = cPreset.shop.Blip.scale,
                color = cPreset.shop.Blip.color,
                name = Config.LocalessUtils.Shop.BlipName,
        })
        onDuty = job.onduty
    end
    handsDirty = true
end)

RegisterNetEvent(Config.ResourceName .. ":onPlayerUnload", function()
    removeSBlip()
end)

RegisterNetEvent(Config.ResourceName .. ":onJobUpdate", function(jobName, dutyStatus)
    -- Always check job and duty status for blip visibility
    if jobName == Config.JobName then
        if not sBlip then
            sBlip = CRUX.Utils.CreateBlip({
                location = cPreset.shop.Blip.location,
                sprite = cPreset.shop.Blip.sprite,
                scale = cPreset.shop.Blip.scale,
                color = cPreset.shop.Blip.color,
                name = Config.LocalessUtils.Shop.BlipName,
        })
        end
        onDuty = dutyStatus
    else
        removeSBlip()
    end
end)

    AddEventHandler('onClientResourceStart', function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then return end
        local pd = JobSystem.GetJob()
        if pd ~= nil and pd.name == Config.JobName then
            sBlip =  CRUX.Utils.CreateBlip({
                location = cPreset.shop.Blip.location,
                sprite = cPreset.shop.Blip.sprite,
                scale = cPreset.shop.Blip.scale,
                color = cPreset.shop.Blip.color,
                name = Config.LocalessUtils.Shop.BlipName,
        })
            onDuty = pd.onduty
        end
    end)


RegisterNetEvent("onClientResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    removeSBlip()
    CRUX.PedManager.RemoveAllPeds()
end)


local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(5)
    end
end

function sitChair(i, scenario, animation)
    local ped = PlayerPedId()
    local chair = cPreset.chairs[i]
    local heading = chair.heading
    local offsets = chair.offsets or vector3(0.0, 0.0, 0.0)
    FreezeEntityPosition(ped, true)
    SetEntityCoordsNoOffset(ped, chair.location.x + offsets.x, chair.location.y + offsets.y, chair.location.z + offsets.z, false, false, false)
    SetEntityHeading(ped, heading)
    Wait(200)

    if scenario then
        scenario = scenario or 'PROP_HUMAN_SEAT_CHAIR'
        TaskStartScenarioAtPosition(ped, scenario, chair.location.x, chair.location.y, chair.location.z, heading, 0, true, false)
        Wait(200)

        while IsPedUsingAnyScenario(ped) do
            Wait(100)
        end
    elseif animation then
        local gender = CRUX.Framework.GetGender() or "Male" -- Default to Male if gender can't be determined
        local animationToPlay = animation

        -- Check if chair has gender-specific animations
        if chair.animation then
            if gender == "Female" and chair.animation.female then
                -- Use female animation if available
                animationToPlay = {
                    animDict = chair.animation.female.animDict or chair.animation.animDict,
                    anim = chair.animation.female.anim or chair.animation.anim,
                    flags = chair.animation.female.flags or chair.animation.flags or 1
                }
                Client.Debug("Using female chair animation")
            else
                -- Use male animation (default)
                animationToPlay = {
                    animDict = (chair.animation.male and chair.animation.male.animDict) or chair.animation.animDict,
                    anim = (chair.animation.male and chair.animation.male.anim) or chair.animation.anim,
                    flags = (chair.animation.male and chair.animation.male.flags) or chair.animation.flags or 1
                }
                Client.Debug("Using male chair animation")
            end
        end

        -- Load and play the animation
        loadAnimDict(animationToPlay.animDict)
        TaskPlayAnim(ped, animationToPlay.animDict, animationToPlay.anim, 2.0, 2.0, -1, animationToPlay.flags, 0, false, false, false)
        RemoveAnimDict(animationToPlay.animDict)
        Wait(200)

        while IsEntityPlayingAnim(ped, animationToPlay.animDict, animationToPlay.anim, 3) do
            if IsControlJustPressed(0, 73) then
                ClearPedTasks(ped)
                break
            end
            Wait(1)
        end
    end

    if chair.leaveLocation and type(chair.leaveLocation) == "vector4" then
        SetEntityCoords(ped, chair.leaveLocation.x, chair.leaveLocation.y, chair.leaveLocation.z, false, false, false, true)
        SetEntityHeading(ped, chair.leaveLocation.w)
        FreezeEntityPosition(ped, false)
    end
end

function ApplyDrunkEffect(duration)
    -- Enable visual effects
    local ped = PlayerPedId()

    -- Apply drunk effect
    SetTimecycleModifier("spectator5")   -- Blurry effect
    SetPedMotionBlur(ped, true)
    ShakeGameplayCam("DRUNK_SHAKE", 1.0) -- Camera shake

    -- Reduce movement control
    SetPedMoveRateOverride(ped, 0.5)          -- Slows down movement
    SetRunSprintMultiplierForPlayer(ped, 0.5) -- Reduce sprint speed

    -- Change walking style
    RequestAnimSet(Config.AlcoholEffect.Default.WalkingStyle)
    while not HasAnimSetLoaded(Config.AlcoholEffect.Default.WalkingStyle) do
        Wait(100)
    end
    SetPedMovementClipset(ped, Config.AlcoholEffect.Default.WalkingStyle, 1.0)

    -- Create a thread to handle the effect duration and fade-out
    CreateThread(function()
        -- Split the total duration - 70% for full effect, 30% for fade-out
        local fullEffectDuration = math.floor(duration * 0.7)
        local fadeTime = duration - fullEffectDuration

        -- Keep the effect active for the full effect portion
        Wait(fullEffectDuration)

        -- Start fade-out
        local startTime = GetGameTimer()

        -- Gradually reduce effects over the fade time
        while GetGameTimer() - startTime < fadeTime do
            local progress = (GetGameTimer() - startTime) / fadeTime

            -- Gradually reduce all effects
            ShakeGameplayCam("DRUNK_SHAKE", 1.0 - progress)
            SetPedMoveRateOverride(ped, 0.5 + (progress * 0.5))
            SetRunSprintMultiplierForPlayer(ped, 0.5 + (progress * 0.5))
            SetTimecycleModifierStrength(1.0 - progress)

            Wait(50)
        end

        -- Completely reset all effects
        ClearTimecycleModifier()
        SetPedMotionBlur(ped, false)
        StopGameplayCamShaking(true)
        ResetPedMovementClipset(ped, 0.0)
        SetPedMoveRateOverride(ped, 1.0)
        SetRunSprintMultiplierForPlayer(ped, 1.0)
    end)

    -- Return immediately so the function doesn't block
    return true
end

RegisterNetEvent(Config.ResourceName .. "lib:client:useConsumable", function(item, isDrink, itemConfig)
    if not item then return end
    if type(item) == "string" then item = { name = item, label = item } end

    local animation = nil
    local prop = nil

    if itemConfig and itemConfig.animation then
        -- Use item's configured animation settings
        if itemConfig.animation.emote and itemConfig.animation.emote.enabled then
            animation = {
                animDict = itemConfig.animation.emote.anim.dict,
                anim = itemConfig.animation.emote.anim.clip,
                flag = 49
            }

            if itemConfig.animation.emote.prop and itemConfig.animation.emote.prop.enable then
                prop = {
                    model = itemConfig.animation.emote.prop.model,
                    bone = itemConfig.animation.emote.prop.bone,
                    pos = itemConfig.animation.emote.prop.pos,
                    rot = itemConfig.animation.emote.prop.rot
                }
            end
        elseif itemConfig.animation.scenario and itemConfig.animation.scenario.enabled then
            animation = {
                scenario = itemConfig.animation.scenario.anim.scenario
            }
        end
    end

    local val = CRUX.Progress({
        id = 'useConsumable',
        label = itemConfig.ProgressBar or (isDrink and Config.Localess.Consumable.Drinking or Config.Localess.Consumable.Eating) .. item.label,
        duration = itemConfig.duration or 5,
        canCancel = true,
        animation = animation,
        prop = prop
    })

    -- Cleanup after progress
    local playerPed = PlayerPedId()
    for _, entityId in ipairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(entityId, playerPed) then
            NetworkRequestControlOfEntity(entityId)
            DetachEntity(entityId, true, true)
            SetEntityAsMissionEntity(entityId, true, true)
            DeleteObject(entityId)
            DeleteEntity(entityId)
        end
    end

    ClearPedTasks(PlayerPedId())
    if prop and prop.model then
        DeleteObject(GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, GetHashKey(prop.model), false, false, false))
    end

    if val then
        -- Display effects preview if in debug mode
        if Config.DebugScript and itemConfig then
            local effects = ""
            if itemConfig.Hunger and itemConfig.Hunger > 0 then
                effects = effects .. "Hunger +" .. itemConfig.Hunger .. " "
            end
            if itemConfig.Thirst and itemConfig.Thirst > 0 then
                effects = effects .. "Thirst +" .. itemConfig.Thirst .. " "
            end
            if itemConfig.Stress and itemConfig.Stress > 0 then
                effects = effects .. "Stress -" .. itemConfig.Stress
            end

            if effects ~= "" then
                CRUX.Notify({
                    title = Config.Localess.System.consumption,
                    description = "fresh",
                    type = "info",
                    duration = 3000,
                })
            end
        end

        TriggerServerEvent(Config.ResourceName .. ":server:useConsumable", item.name, isDrink)
    end
    
    if Config.Alcohol[item.name] then
        if Config.AlcoholEffect.Custom.Active and isDrink then
            Config.AlcoholEffect.Custom.Function(item)
        elseif Config.AlcoholEffect.Default.Active and isDrink then
            local time = Config.AlcoholEffect.Default.Time * 1000
            ApplyDrunkEffect(time)
        end
    end
end)

RegisterNetEvent(Config.ResourceName .. ":Client:CraftItem", function(Args)
    if isPlayerCrafting then return true end
    isPlayerCrafting = true

    local itemLabel = CRUX.Inventory.GetItemLabel(Args.Item) or Args.Item
    local inputData = {
        title = string.format(Config.Localess.Crafting.craft_title or "Craft: %s", itemLabel),
        description = Config.Localess.Crafting.enter_amount_description or "Enter the amount to craft",
        label = "Amount",
        defaultValue = 1,
        required = true,
        min = 1,
        max = 100, -- You can set a sensible max value
        args = Args
    }

    -- Send NUI message to open InputDialog
    SendNUIMessage({
        action = "openInputDialog",
        data = inputData
    })

        SetNuiFocus(true, true)

    -- Register a one-time NUI callback for the input dialog result
    RegisterNUICallback("inputDialogResult", function(data, cb)
        SetNuiFocus(false, false)
        local result = data and data.value
        if not result then
            isPlayerCrafting = false
            cb('ok')
            return true
        end

        local amount = tonumber(result)
        if amount and amount > 0 then
            Args.Amount = amount
            Args.ItemLabel = itemLabel
            TriggerServerEvent(Config.ResourceName .. ":Server:RequestCraft", Args)
        else
            isPlayerCrafting = false
        end
        cb('ok')
        return true
    end)
end)

-- Step 3: The server validates and calls this event back. This event ONLY handles the progress bar.
RegisterNetEvent(Config.ResourceName .. ":Client:StartCraftingProcess", function(Args)
    local label = CRUX.Inventory.GetItemLabel(Args.Item)
    if type(label) ~= "string" then
        label = tostring(Args.Item)
    end
    local craftConfig = Preset[Config.ActivePreset].craft[Args.Id]
    if not craftConfig then
        Client.Debug("[ERROR] Crafting config not found for: " .. Args.Id)
        isPlayerCrafting = false
        return
    end

    local playerPed = PlayerPedId()
    local animationConfig = craftConfig.animation
    local singleItemDuration = craftConfig.ProgressBarDuration or 5000
    local totalDuration = singleItemDuration * Args.Amount
    local progressAnimation = {}

    if animationConfig and animationConfig.emote and animationConfig.emote.enabled then
        progressAnimation = {
            animDict = animationConfig.emote.anim.dict,
            anim = animationConfig.emote.anim.clip,
            flag = 49,
        }
    elseif animationConfig and animationConfig.scenario and animationConfig.scenario.enabled then
        progressAnimation = {
            scenario = animationConfig.scenario.anim.scenario,
        }
    end

    local prog = CRUX.Progress({
        duration = totalDuration,
        label = "Crafting " .. Args.Amount .. "x " .. label,
        id = Config.ResourceName .. ":craft-" .. Args.Item,
        disable = { car = true, move = true, combat = true },
        animation = progressAnimation,
        prop = (animationConfig and animationConfig.emote and animationConfig.emote.enabled) and animationConfig.emote.prop or nil,
        canCancel = true,
    })

    if prog then
        -- Clean up any attached props to prevent them from falling to ground
    local playerPed = PlayerPedId()
    for _, entityId in ipairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(entityId, playerPed) then
            NetworkRequestControlOfEntity(entityId)
            DetachEntity(entityId, true, true)
            SetEntityAsMissionEntity(entityId, true, true)
            DeleteObject(entityId)
            DeleteEntity(entityId)
        end
    end

        -- Then clear the tasks
        ClearPedTasks(playerPed)
        -- Step 4: Finalize the craft on the server.
        TriggerServerEvent(Config.ResourceName .. ":Server:FinalizeCraft", Args)
        CRUX.Notify({
            title = Config.Localess.Crafting.crafting_successful or "Crafting Successful",
            description = string.format(Config.Localess.Crafting.crafted_description or "You crafted %d x %s", Args.Amount, label),
            type = "success",
            duration = 3000,
        })
    else
        CRUX.Notify({ 
            title = Config.Localess.Crafting.crafting_cancelled or "Crafting Cancelled", 
            description = Config.Localess.Crafting.cancelled_description or "You cancelled crafting",
            type = "error",
            duration = 3000,
        })
    end

    isPlayerCrafting = false
end)

function OpenCraft(Craft)
    if not Craft or not Craft.Items then
        return
    end
    inventoryItems = CRUX.Inventory.GetAllItems()
    Client.Debug(json.encode(inventoryItems))
    if not inventoryItems then
        return
    end
    local playerItemsMap = {}
    for _, itemData in pairs(inventoryItems) do
        playerItemsMap[itemData.name] = itemData 
    end
    local mapCount = 0
    for _ in pairs(playerItemsMap) do mapCount = mapCount + 1 end
    local craftItems = {}
    local recipeCount = 0
    for _ in pairs(Craft.Items) do recipeCount = recipeCount + 1 end
    for Item, Costs in pairs(Craft.Items) do
        local metadata = {}
        local canCraft = true
        for ItemC, Amount in pairs(Costs) do
            local playerHasItem = playerItemsMap[ItemC] 
            local itemCount = (playerHasItem and (playerHasItem.count or playerHasItem.amount)) or 0
            local hasEnough = itemCount >= Amount
            if itemCount < Amount then
            canCraft = false
            end
            local ingredientLabel = CRUX.Inventory.GetItemLabel(ItemC) or (playerHasItem and playerHasItem.label) or ItemC
            metadata[#metadata + 1] = { label = ingredientLabel, value = Amount, hasEnough = hasEnough }
        end
        local itm = playerItemsMap[Item]
        local itemLabel = CRUX.Inventory.GetItemLabel(Item) or (itm and itm.label) or Item
        local imag = Config.InventoryImages .. Item .. ".png"
        local craftId = string.match(Craft.Id, "(craftid%d*)") or "craftid"
        local menuItem = {
            id = Item,
            header = itemLabel,
            icon = imag,
            disabled = not canCraft,
            metadata = metadata,
            args = {
                Item = Item,
                ItemLabel = itemLabel,
                Costs = Costs,
                Id = craftId
            }
        }
        table.insert(craftItems, menuItem)
    end
    local craftData = {
        action = "openMenu",
        data = {
            type = "craft",
            id = Craft.Id,
            title = Craft.Title,
            subtitle = "",
            items = craftItems,
            primaryAction = Config.ResourceName .. ":craftItem",
            cancelAction = Config.ResourceName .. ":menuClosed"
        }
    }
    local success, jsonData
    success, jsonData = pcall(function() return json.encode(craftData) end)
    if not success then
        return
    end
    SendNUIMessage(craftData)
    SetNuiFocus(true, true)
end

-- NUI Callbacks
RegisterNUICallback(Config.ResourceName .. ":craftItem", function(data, cb)
    SetNuiFocus(false, false)
    if data and data.args then
        TriggerEvent(Config.ResourceName .. ":Client:CraftItem", data.args)
    end
    cb('ok')
end)

RegisterNUICallback(Config.ResourceName .. ":menuClosed", function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- For testing the NUI connection
RegisterCommand('testnui', function()
    SendNUIMessage({
        action = "testMessage",
        data = "Hello from Lua!"
    })
    Client.Debug("Sent test message to NUI")
end, false)

-- Test command for the craft menu
RegisterCommand('testcraftmenu', function()
    -- Create sample craft data
    local sampleCraftItems = {
        {
            id = "burger",
            header = "Tasty Burger",
            icon = Config.InventoryImages .. "burger.png",
            disabled = false,
            metadata = {
                { label = "burger", value = 2 },
                { label = "Lettuce", value = 1 },
                { label = "Meat", value = 1 },
                { label = "Cheese", value = 1 }
            },
            args = {
                Item = "burger",
                Costs = {
                    bread = 2,
                    lettuce = 1,
                    meat = 1,
                    cheese = 1
                },
                Id = "craftid1"
            }
        },
        {
            id = "fries",
            header = "French Fries",
            icon = Config.InventoryImages .. "bs_fanta.png",
            disabled = false,
            metadata = {
                { label = "Potato", value = 2 },
                { label = "Salt", value = 1 }
            },
            args = {
                Item = "fries",
                Costs = {
                    potato = 2,
                    salt = 1
                },
                Id = "craftid1"
            }
        },
        {
            id = "soda",
            header = "Cola Drink",
            icon = Config.InventoryImages .. "cola.png",
            disabled = true, -- This item is disabled to test the disabled state
            metadata = {
                { label = "Water", value = 1 },
                { label = "Sugar", value = 2 },
                { label = "Cola Syrup", value = 1 }
            },
            args = {
                Item = "soda",
                Costs = {
                    water = 1,
                    sugar = 2,
                    cola_syrup = 1
                },
                Id = "craftid1"
            }
        }
    }

    -- Create NUI message data structure
    local craftData = {
        action = "openMenu",
        data = {
            type = "craft",
            id = "test_craft_menu",
            title = "Test Craft Menu",
            subtitle = "This is a test craft menu",
            items = sampleCraftItems,
            primaryAction = Config.ResourceName .. ":craftItem",
            cancelAction = Config.ResourceName .. ":menuClosed"
        }
    }

    -- Print the JSON-encoded data
    SendNUIMessage(craftData)
    SetNuiFocus(true, true)
end, false)

-- Add an event to close the NUI menu programmatically
RegisterNetEvent(Config.ResourceName .. ":Client:CloseNUI", function()
    SendNUIMessage({action = "closeMenu"})
    SetNuiFocus(false, false)
end)

CreateThread(function()
        CRUX.Utils.CreateBlip({
                location = cPreset.blip.location,
                sprite = cPreset.blip.sprite,
                scale = cPreset.blip.scale,
                color = cPreset.blip.color,
                name = Config.LocalessUtils.RestaurantBlipName,
        })

    while true do
        Wait(1000)
        local pos = GetEntityCoords(PlayerPedId())
        if not handsDirty and #(pos - cPreset.blip.location) > 100 then
            handsDirty = true
        end
    end
end)

local lastJobName = nil
local lastOnDuty = nil

CreateThread(function()
    while true do
        Wait(1000)
        local job = JobSystem.GetJob()
        if job then
            if job.name ~= lastJobName or job.onduty ~= lastOnDuty then
                lastJobName = job.name
                lastOnDuty = job.onduty
                TriggerEvent(Config.ResourceName .. ":onJobUpdate", job.name, job.onduty)
            end
        end
    end
end)


-- Send experience config to NUI
function SendExperienceConfigToNUI()
    -- Validate that Config.Experience and Config.Experience.Levels exist
    if not Config.Experience or not Config.Experience.Levels then
        Client.Debug("Warning: Cannot send experience config to NUI - Config.Experience.Levels is not defined!")
        return
    end

    local expConfig = {
        thresholds = Config.Experience.Levels.Thresholds,
        display = Config.Experience.Levels.Display
    }

    SendNUIMessage({
        action = "updateExperienceConfig",
        config = expConfig
    })

end

RegisterNetEvent(Config.ResourceName .. ":lib:client:OpenDeliveryStash", function(stashId)
    if not stashId then
        Client.Debug("^1ERROR: No stash ID provided^0")
        return
    end
    
    Client.Debug("Opening unique DeliveryStorage stash: " .. tostring(stashId))
    CRUX.Inventory.OpenStash(stashId)
end)

-- Register NUI callback to provide door image URLs to web UI
RegisterNUICallback('getDoorImages', function(_, cb)
    cb({ images = Config.DoorImages })
end)

RegisterNUICallback('getfonts', function(_, cb)
    cb({ font = Config.Fonts })
end)

RegisterNUICallback('getCraftMenuPosition', function(_, cb)
    cb({ position = Config.CraftingMenuPosition })
end)
