-- canInteract = function (entity, distance, data)
--     local playerJob = JobSystem.GetJob()
--     print(json.encode(playerJob))
--     -- {"name":"burgerpolice","is_boss":false,"grade":5,"grade_name":"manager","onduty":false,"grade_label":"Manager","label":"Burgershot","salary":300}
--     local jobName = playerJob and playerJob.name or ""
--     local onDuty = playerJob and playerJob.onDuty or false

    -- Show notification if player is off duty
    -- if not dutyCheck and Config.Billing and Config.Billing.enabled then
    --     CRUX.Notify({
    --         title = "Billing Terminal",
    --         description = "You need to be on duty to use the billing terminal.",
    --         type = "error",
    --         duration = 5000,
    --     })
    -- end

    -- Return whether the player can interact
--     return dutyCheck
-- end

canInteract = function (entity, distance, data)
    local playerJob = JobSystem.GetJob()
    local jobName = playerJob and playerJob.name or ""
    local onDuty = playerJob and playerJob.onDuty or false
    local resourceJobName = Config.ResourceName .. jobName
    local configResourceJobName = Config.ResourceName .. Config.JobName

    local canInteract = (resourceJobName == configResourceJobName) and (onDuty or not Config.NeedDuty)

    if not canInteract and Config.Billing and Config.Billing.enabled then
        CRUX.Notify({
            title = Config.Localess.Billing.terminal_title or "Billing Terminal",
            description = Config.Localess.Billing.off_duty_error or "You need to be on duty to use the billing terminal.",
            type = "error",
            duration = 5000,
        })
    end

    return canInteract
end

-- if hands are clean return true
canInterHands = function () 
    local val = not handsDirty
    if not Config.DirtyHands then
        val = true
    end
    if not val then CRUX.Notify({
        title = Config.Localess.WashHands.targetfail,
        description = Config.Localess.WashHands.targetfail,
        type = "error",
        duration = 5000,
    }) end
    return val
end


-- Table to track all spawned entities (props and peds) for cleanup
local spawnedEntities = {}

-- Function to delete all spawned entities
function DeleteAllSpawnedEntities()
    for _, ent in ipairs(spawnedEntities) do
        if DoesEntityExist(ent) then
            DeleteEntity(ent)
        end
    end
    -- Clear the table to reset for potential future use
    spawnedEntities = {}
end

local function createTargets()

    -- Boss Menu Target
    if cPreset.bossMenu then
        for i, cBossmenu in pairs(cPreset.bossMenu) do
            local bossMenuTargetOpt = {
                options = {
                    {
                        action = function(entity)
                            BossMenu()
                            
                            -- Wait a moment to ensure NUI focus has registered
                            Wait(1000)

                            -- Animation handling for boss menu
                            if cBossmenu.animation and cBossmenu.animation.emote and cBossmenu.animation.emote.enabled then
                                RequestAnimDict(cBossmenu.animation.emote.anim.dict)
                                while not HasAnimDictLoaded(cBossmenu.animation.emote.anim.dict) do
                                    Wait(0)
                                end
                                
                                -- Ensure the flag includes the loop bit
                                local animFlag = cBossmenu.animation.emote.anim.flag or 1
                                if type(animFlag) ~= "number" then animFlag = tonumber(animFlag) or 1 end
                                if bit32 and bit32.bor then
                                    animFlag = bit32.bor(animFlag, 1)
                                else
                                    -- fallback: if least significant bit not set, add 1
                                    if animFlag % 2 == 0 then animFlag = animFlag + 1 end
                                end
                                
                                -- Set duration to -1 (infinite) and use loop-capable flag
                                TaskPlayAnim(PlayerPedId(), cBossmenu.animation.emote.anim.dict, cBossmenu.animation.emote.anim.anim,
                                    cBossmenu.animation.emote.anim.speed, cBossmenu.animation.emote.anim.speedMultiplier,
                                    -1, animFlag, 0, false, false, false)

                                -- Handle prop attachment if enabled
                                local attachedProp = nil
                                if cBossmenu.animation.emote.prop and cBossmenu.animation.emote.prop.enable then
                                    attachedProp = CreateObject(GetHashKey(cBossmenu.animation.emote.prop.model), 0, 0, 0, true, true, true)
                                    AttachEntityToEntity(attachedProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), cBossmenu.animation.emote.prop.bone), 
                                        cBossmenu.animation.emote.prop.pos.x, cBossmenu.animation.emote.prop.pos.y, cBossmenu.animation.emote.prop.pos.z, 
                                        cBossmenu.animation.emote.prop.rot.x, cBossmenu.animation.emote.prop.rot.y, cBossmenu.animation.emote.prop.rot.z, 
                                        true, true, false, true, 1, true)
                                end

                                -- Loop while the UI is open
                                while IsNuiFocused() do
                                    Wait(500)
                                end
                                
                                ClearPedTasks(PlayerPedId())

                                -- Clean up attached prop
                                if attachedProp and DoesEntityExist(attachedProp) then
                                    DeleteEntity(attachedProp)
                                end

                            elseif cBossmenu.animation and cBossmenu.animation.scenario and cBossmenu.animation.scenario.enabled then
                                TaskStartScenarioInPlace(PlayerPedId(), cBossmenu.animation.scenario.anim.scenario, 0, true)

                                -- Loop while the UI is open
                                while IsNuiFocused() do
                                    Wait(500)
                                end
                                
                                ClearPedTasks(PlayerPedId())
                            end
                        end,
                        icon = cBossmenu.targeticon,
                        label = cBossmenu.targetlabel,
                    }
                },
                distance = cBossmenu.distance
            }

            if cBossmenu.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(cBossmenu.prop.model, cBossmenu.prop.location, cBossmenu.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, bossMenuTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-bossmenu-" .. tostring(i)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    cBossmenu.location,
                    cBossmenu.length,
                    cBossmenu.width,
                    {
                        heading = cBossmenu.heading,
                        minZ = cBossmenu.minZ,
                        maxZ = cBossmenu.maxZ,
                        options = bossMenuTargetOpt.options,
                        distance = bossMenuTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end

    -- -- Register a client command to open the Boss Menu
    -- RegisterCommand("bossmenu", function()
    --     if BossMenu then
    --         BossMenu()
    --     else
    --         if CRUX and CRUX.Notify then
    --             CRUX.Notify({
    --                 title = "Boss Menu",
    --                 description = "Boss menu function not available.",
    --                 type = "error",
    --                 duration = 5000,
    --             })
    --         end
    --     end
    -- end, false)

    -- -- Add chat suggestion (wrapped to avoid errors if chat resource not present)
    -- pcall(function()
    --     TriggerEvent('chat:addSuggestion', '/bossmenu', 'Open the boss menu')
    -- end)

    -- -- Optional key mapping (unbound by default)
    -- if RegisterKeyMapping then
    --     RegisterKeyMapping('bossmenu', 'Open Boss Menu', 'keyboard', '')
    -- end

    -- Employee Menu Target
    if cPreset.employeeMenu then
        for i, employeeMenuData in pairs(cPreset.employeeMenu) do
            local employeeMenuTargetOpt = {
                options = {
                    {
                        action = function(entity)
                            if EmployeeMenu then
                                EmployeeMenu(i, employeeMenuData)
                            end

                            -- Wait a moment to ensure NUI focus has registered
                            Wait(200)

                            -- Animation handling for employee menu
                            if employeeMenuData.animation and employeeMenuData.animation.emote and employeeMenuData.animation.emote.enabled then
                                RequestAnimDict(employeeMenuData.animation.emote.anim.dict)
                                while not HasAnimDictLoaded(employeeMenuData.animation.emote.anim.dict) do
                                    Wait(0)
                                end
                                
                                -- Ensure the flag includes the loop bit
                                local animFlag = employeeMenuData.animation.emote.anim.flag or 1
                                if type(animFlag) ~= "number" then animFlag = tonumber(animFlag) or 1 end
                                if bit32 and bit32.bor then
                                    animFlag = bit32.bor(animFlag, 1)
                                else
                                    -- fallback: if least significant bit not set, add 1
                                    if animFlag % 2 == 0 then animFlag = animFlag + 1 end
                                end
                                
                                -- Set duration to -1 (infinite) and use loop-capable flag
                                TaskPlayAnim(PlayerPedId(), employeeMenuData.animation.emote.anim.dict, employeeMenuData.animation.emote.anim.anim,
                                    employeeMenuData.animation.emote.anim.speed, employeeMenuData.animation.emote.anim.speedMultiplier,
                                    -1, animFlag, 0, false, false, false)

                                -- Handle prop attachment if enabled
                                local attachedProp = nil
                                if employeeMenuData.animation.emote.prop and employeeMenuData.animation.emote.prop.enable then
                                    attachedProp = CreateObject(GetHashKey(employeeMenuData.animation.emote.prop.model), 0, 0, 0, true, true, true)
                                    AttachEntityToEntity(attachedProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), employeeMenuData.animation.emote.prop.bone), 
                                        employeeMenuData.animation.emote.prop.pos.x, employeeMenuData.animation.emote.prop.pos.y, employeeMenuData.animation.emote.prop.pos.z, 
                                        employeeMenuData.animation.emote.prop.rot.x, employeeMenuData.animation.emote.prop.rot.y, employeeMenuData.animation.emote.prop.rot.z, 
                                        true, true, false, true, 1, true)
                                end

                                -- Loop while the UI is open
                                while IsNuiFocused() do
                                    Wait(500)
                                end
                                
                                ClearPedTasks(PlayerPedId())

                                -- Clean up attached prop
                                if attachedProp and DoesEntityExist(attachedProp) then
                                    DeleteEntity(attachedProp)
                                end

                            elseif employeeMenuData.animation and employeeMenuData.animation.scenario and employeeMenuData.animation.scenario.enabled then
                                TaskStartScenarioInPlace(PlayerPedId(), employeeMenuData.animation.scenario.anim.scenario, 0, true)

                                -- Loop while the UI is open
                                while IsNuiFocused() do
                                    Wait(500)
                                end
                                
                                ClearPedTasks(PlayerPedId())
                            end
                        end,
                        icon = employeeMenuData.targeticon,
                        label = employeeMenuData.targetlabel,
                        canInteract = canInteract,
                    }
                },
                distance = employeeMenuData.distance
            }

            if employeeMenuData.prop and employeeMenuData.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(employeeMenuData.prop.model, employeeMenuData.prop.location, employeeMenuData.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, employeeMenuTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-employeemenu-" .. tostring(i)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    employeeMenuData.location,
                    employeeMenuData.length,
                    employeeMenuData.width,
                    {
                        heading = employeeMenuData.heading,
                        minZ = employeeMenuData.minZ,
                        maxZ = employeeMenuData.maxZ,
                        options = employeeMenuTargetOpt.options,
                        distance = employeeMenuTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end


    -- Self Order Kiosk Target
    if cPreset.SelfOrderKiosk then
        for i, tabletData in pairs(cPreset.SelfOrderKiosk) do
            local orderingTabletTargetOpt = {
                options = {
                    {
                        action = function(entity)
                            if OpenOrderingTablet then
                                OpenOrderingTablet(i, tabletData) -- Pass index i explicitly for kiosk identification
                                
                                -- Wait a moment to ensure NUI focus has registered
                                Wait(200)

                                -- Animation handling for terminals
                                if tabletData.animation and tabletData.animation.emote and tabletData.animation.emote.enabled then
                                    RequestAnimDict(tabletData.animation.emote.anim.dict)
                                    while not HasAnimDictLoaded(tabletData.animation.emote.anim.dict) do
                                        Wait(0)
                                    end

                                    -- Ensure the flag includes the loop bit
                                    local animFlag = tabletData.animation.emote.anim.flag or 1
                                    if type(animFlag) ~= "number" then animFlag = tonumber(animFlag) or 1 end
                                    if bit32 and bit32.bor then
                                        animFlag = bit32.bor(animFlag, 1)
                                    else
                                        -- fallback: if least significant bit not set, add 1
                                        if animFlag % 2 == 0 then animFlag = animFlag + 1 end
                                    end
                                    
                                    -- Set duration to -1 (infinite) and use loop-capable flag
                                    TaskPlayAnim(PlayerPedId(), tabletData.animation.emote.anim.dict, tabletData.animation.emote.anim.anim,
                                        tabletData.animation.emote.anim.speed or 8.0, tabletData.animation.emote.anim.speedMultiplier or -1.0,
                                        -1, animFlag, 0, false, false, false)

                                    -- Handle prop attachment if enabled
                                    local attachedProp = nil
                                    if tabletData.animation.emote.prop and tabletData.animation.emote.prop.enable then
                                        attachedProp = CreateObject(GetHashKey(tabletData.animation.emote.prop.model), 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(attachedProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), tabletData.animation.emote.prop.bone), 
                                            tabletData.animation.emote.prop.pos.x, tabletData.animation.emote.prop.pos.y, tabletData.animation.emote.prop.pos.z, 
                                            tabletData.animation.emote.prop.rot.x, tabletData.animation.emote.prop.rot.y, tabletData.animation.emote.prop.rot.z, 
                                            true, true, false, true, 1, true)
                                    end

                                    -- Loop while the UI is open
                                    while IsNuiFocused() do
                                        Wait(500)
                                    end
                                    
                                    ClearPedTasks(PlayerPedId())

                                    -- Clean up attached prop
                                    if attachedProp and DoesEntityExist(attachedProp) then
                                        DeleteEntity(attachedProp)
                                    end

                                elseif tabletData.animation and tabletData.animation.scenario and tabletData.animation.scenario.enabled then
                                    TaskStartScenarioInPlace(PlayerPedId(), tabletData.animation.scenario.anim.scenario, 0, true)

                                    -- Loop while the UI is open
                                    while IsNuiFocused() do
                                        Wait(500)
                                    end
                                    
                                    ClearPedTasks(PlayerPedId())
                                end
                                
                            else
                                CRUX.Notify({
                                    title = Config.Localess.Targets.ordering_tablet or "Ordering Tablet",
                                    description = Config.Localess.Targets.ordering_tablet_error or "Ordering tablet function not available.",
                                    type = "error",
                                    duration = 5000,
                                })
                            end
                        end,
                        icon = tabletData.targeticon or "fas fa-tablet-alt",
                        label = tabletData.targetlabel or Config.Localess.Targets.ordering_tablet,
                    }
                },
                distance = tabletData.distance or 2.0
            }

            if tabletData.prop and tabletData.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(tabletData.prop.model, tabletData.prop.location, tabletData.prop.rotation)
                table.insert(spawnedEntities, ent) -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, orderingTabletTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-orderingtablet-" .. tostring(i)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    tabletData.location,
                    tabletData.length,
                    tabletData.width,
                    {
                        heading = tabletData.heading,
                        minZ = tabletData.minZ,
                        maxZ = tabletData.maxZ,
                        options = orderingTabletTargetOpt.options,
                        distance = orderingTabletTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end

    -- Order Management Tablet Target
    if cPreset.OrderManagementTablet then
        for i, tabletData in pairs(cPreset.OrderManagementTablet) do
            local orderManagementTabletTargetOpt = {
                options = {
                    {
                        action = function(entity)
                            if OpenOrderManagementTablet then
                                OpenOrderManagementTablet(i, tabletData)
                                
                                -- Wait a moment to ensure NUI focus has registered before starting the loop
                                Wait(200) 

                                -- Animation handling for order management tablet
                                if tabletData.animation and tabletData.animation.emote and tabletData.animation.emote.enabled then
                                    RequestAnimDict(tabletData.animation.emote.anim.dict)
                                    while not HasAnimDictLoaded(tabletData.animation.emote.anim.dict) do
                                        Wait(0)
                                    end
                                    
                                    -- Ensure the flag allows looping (usually flag 1 or 49)
                                    -- Ensure the flag includes the loop bit
                                    local animFlag = tabletData.animation.emote.anim.flag or 1
                                    if type(animFlag) ~= "number" then animFlag = tonumber(animFlag) or 1 end
                                    if bit32 and bit32.bor then
                                        animFlag = bit32.bor(animFlag, 1)
                                    else
                                        -- fallback: if least significant bit not set, add 1
                                        if animFlag % 2 == 0 then animFlag = animFlag + 1 end
                                    end
                                    
                                    -- Set duration to -1 (infinite) and use loop-capable flag
                                    TaskPlayAnim(PlayerPedId(), tabletData.animation.emote.anim.dict, tabletData.animation.emote.anim.anim,
                                        tabletData.animation.emote.anim.speed, tabletData.animation.emote.anim.speedMultiplier,
                                        -1, animFlag, 0, false, false, false)

                                    -- Handle prop attachment if enabled
                                    local attachedProp = nil
                                    if tabletData.animation.emote.prop and tabletData.animation.emote.prop.enable then
                                        attachedProp = CreateObject(GetHashKey(tabletData.animation.emote.prop.model), 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(attachedProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), tabletData.animation.emote.prop.bone), 
                                            tabletData.animation.emote.prop.pos.x, tabletData.animation.emote.prop.pos.y, tabletData.animation.emote.prop.pos.z, 
                                            tabletData.animation.emote.prop.rot.x, tabletData.animation.emote.prop.rot.y, tabletData.animation.emote.prop.rot.z, 
                                            true, true, false, true, 1, true)
                                    end

                                    -- Loop while the UI is open
                                    while IsNuiFocused() do
                                        Wait(500)
                                    end
                                    
                                    ClearPedTasks(PlayerPedId())

                                    -- Clean up attached prop
                                    if attachedProp and DoesEntityExist(attachedProp) then
                                        DeleteEntity(attachedProp)
                                    end

                                elseif tabletData.animation and tabletData.animation.scenario and tabletData.animation.scenario.enabled then
                                    TaskStartScenarioInPlace(PlayerPedId(), tabletData.animation.scenario.anim.scenario, 0, true)

                                    -- Loop while the UI is open
                                    while IsNuiFocused() do
                                        Wait(500)
                                    end
                                    
                                    ClearPedTasks(PlayerPedId())
                                end
                            else
                                CRUX.Notify({
                                    title = Config.Localess.Targets.order_management_tablet or "Order Management Tablet",
                                    description = Config.Localess.Targets.order_management_error or "Order management tablet function not available.",
                                    type = "error",
                                    duration = 5000,
                                })
                            end
                        end,
                        icon = tabletData.targeticon or "fas fa-tasks",
                        label = tabletData.targetlabel or Config.Localess.Targets.order_management_tablet,
                        canInteract = canInteract,
                    }
                },
                distance = tabletData.distance or 2.0
            }

            if tabletData.prop and tabletData.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(tabletData.prop.model, tabletData.prop.location, tabletData.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, orderManagementTabletTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-ordermanagementtablet-" .. tostring(i)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    tabletData.location,
                    tabletData.length,
                    tabletData.width,
                    {
                        heading = tabletData.heading,
                        minZ = tabletData.minZ,
                        maxZ = tabletData.maxZ,
                        options = orderManagementTabletTargetOpt.options,
                        distance = orderManagementTabletTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end

    -- Vending Machine Target
    if Config.EnableVendingMachine and cPreset.ReverseVendingMachine then
        for i, vendingData in pairs(cPreset.ReverseVendingMachine) do
            local vendingTargetOpt = {
                options = {
                    {
                        action = function(entity)
                            if canInteract(entity) then -- Assuming canInteract is a function that can be called here
                                local menuType = isBoss and "boss" or "employee"
                                SendNUIMessage({
                                    action = "showMenuSelectionDialog",
                                    menuType = menuType,
                                    notifyData = Config.Localess,
                                    vendingIndex = i
                                })
                                SetNuiFocus(true, true)

                                -- Wait a moment to ensure NUI focus has registered
                                Wait(200)

                                -- Animation handling for terminals
                                if vendingData.animation and vendingData.animation.emote and vendingData.animation.emote.enabled then
                                    RequestAnimDict(vendingData.animation.emote.anim.dict)
                                    while not HasAnimDictLoaded(vendingData.animation.emote.anim.dict) do
                                        Wait(0)
                                    end
                                    
                                    -- Changed duration to -1 for infinite loop
                                    -- Ensure the flag includes the loop bit
                                    local animFlag = vendingData.animation.emote.anim.flag or 1
                                    if type(animFlag) ~= "number" then animFlag = tonumber(animFlag) or 1 end
                                    if bit32 and bit32.bor then
                                        animFlag = bit32.bor(animFlag, 1)
                                    else
                                        -- fallback: if least significant bit not set, add 1
                                        if animFlag % 2 == 0 then animFlag = animFlag + 1 end
                                    end
                                    
                                    -- Set duration to -1 (infinite) and use loop-capable flag
                                    TaskPlayAnim(PlayerPedId(), vendingData.animation.emote.anim.dict, vendingData.animation.emote.anim.anim,
                                        vendingData.animation.emote.anim.speed, vendingData.animation.emote.anim.speedMultiplier,
                                        -1, animFlag, 0, false, false, false)

                                    -- Handle prop attachment if enabled
                                    local attachedProp = nil
                                    if vendingData.animation.emote.prop and vendingData.animation.emote.prop.enable then
                                        attachedProp = CreateObject(GetHashKey(vendingData.animation.emote.prop.model), 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(attachedProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), vendingData.animation.emote.prop.bone), 
                                            vendingData.animation.emote.prop.pos.x, vendingData.animation.emote.prop.pos.y, vendingData.animation.emote.prop.pos.z, 
                                            vendingData.animation.emote.prop.rot.x, vendingData.animation.emote.prop.rot.y, vendingData.animation.emote.prop.rot.z, 
                                            true, true, false, true, 1, true)
                                    end

                                    -- Loop while the UI is open
                                    while IsNuiFocused() do
                                        Wait(500)
                                    end
                                    
                                    ClearPedTasks(PlayerPedId())

                                    -- Clean up attached prop
                                    if attachedProp and DoesEntityExist(attachedProp) then
                                        DeleteEntity(attachedProp)
                                    end

                                elseif vendingData.animation and vendingData.animation.scenario and vendingData.animation.scenario.enabled then
                                    TaskStartScenarioInPlace(PlayerPedId(), vendingData.animation.scenario.anim.scenario, 0, true)

                                    -- Loop while the UI is open
                                    while IsNuiFocused() do
                                        Wait(500)
                                    end
                                    
                                    ClearPedTasks(PlayerPedId())
                                end
                            else
                                VendingMachine(i)
                            end
                        end,
                        icon = vendingData.targeticon or "fas fa-utensils",
                        label = vendingData.targetlabel or Config.Localess.Targets.return_utensils,
                    }
                },
                distance = vendingData.distance or 1.5
            }

            if vendingData.prop and vendingData.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(vendingData.prop.model, vendingData.prop.location, vendingData.prop.rotation)
                table.insert(spawnedEntities, ent) -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, vendingTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-vendingmachine-" .. tostring(i)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    vendingData.location,
                    vendingData.length,
                    vendingData.width,
                    {
                        heading = vendingData.heading,
                        minZ = vendingData.minZ,
                        maxZ = vendingData.maxZ,
                        options = vendingTargetOpt.options,
                        distance = vendingTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end

    -- Employee Vending Machine Target
    -- if Config.EnableVendingMachine and cPreset.EmployeeVendingMachine then
    --     for i, vendingData in pairs(cPreset.EmployeeVendingMachine) do
    --         local employeeVendingTargetOpt = {
    --             options = {
    --                 {
    --                     action = function(entity)
    --                         EmployeeVendingMachine(i)
    --                     end,
    --                     icon = vendingData.targeticon or "fas fa-user-cog",
    --                     label = vendingData.targetlabel or Config.Localess.Targets.employee_vending,
    --                     canInteract = canInteract,
    --                 }
    --             },
    --             distance = vendingData.distance or 1.5
    --         }

    --         if vendingData.prop and vendingData.prop.enabled then
    --             local ent = CRUX.Utils.SpawnProp(vendingData.prop.model, vendingData.prop.location, vendingData.prop.rotation)
    --             table.insert(spawnedEntities, ent)  -- Track the spawned entity
    --             CRUX.Target.AddTargetEntity(ent, employeeVendingTargetOpt)
    --         else
    --             local zoneName = Config.ResourceName .. "-employeevendingmachine-" .. tostring(i)
    --             CRUX.Target.AddBoxZone(
    --                 zoneName,
    --                 vendingData.location,
    --                 vendingData.length,
    --                 vendingData.width,
    --                 {
    --                     heading = vendingData.heading,
    --                     minZ = vendingData.minZ,
    --                     maxZ = vendingData.maxZ,
    --                     options = employeeVendingTargetOpt.options,
    --                     distance = employeeVendingTargetOpt.distance
    --                 },
    --                 Config.debugPoly
    --             )
    --         end
    --     end
    -- end

    -- Shop Menu Target
    if Config.Shop and Config.Shop.enabled then
        local cShop = Config.Shop
        local shopPed = CRUX.Utils.CreatePed(cShop.Ped.Type, cShop.Ped.Hash, cPreset.shop.pedLocation, false, cShop.Ped.Scenario)
        table.insert(spawnedEntities, shopPed)  -- Track the spawned ped
        CRUX.Target.AddTargetEntity(shopPed, {
            options = {
                {
                    action = ShopMenu,
                    icon = cShop.targeticon,
                    label = cShop.targetlabel,
                },
            },
            distance = Config.TargetDistance
        })
    end

  -- Restaurant Menu Target
    if cPreset.EnableRestaurantMenu then
        for i, restaurantMenuData in pairs(cPreset.restaurantMenu) do
            local restaurantMenuTargetOpt = {
                options = {
                    {
                        action = function()
                            RestaurantMenu(i, restaurantMenuData.menuImage)
                        end,
                        icon = restaurantMenuData.targeticon,
                        label = restaurantMenuData.targetlabel,
                    }
                },
                distance = restaurantMenuData.distance
            }

            if restaurantMenuData.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(restaurantMenuData.prop.model, restaurantMenuData.prop.location, restaurantMenuData.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, restaurantMenuTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-restaurantmenu-" .. tostring(i)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    restaurantMenuData.location,
                    restaurantMenuData.length,
                    restaurantMenuData.width,
                    {
                        heading = restaurantMenuData.heading,
                        minZ = restaurantMenuData.minZ,
                        maxZ = restaurantMenuData.maxZ,
                        options = restaurantMenuTargetOpt.options,
                        distance = restaurantMenuTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end

  -- Shop Menu Target
    -- if Config.Shop and Config.Shop.enabled then
    --     local cShop = Config.Shop
    --     local shopPed = CRUX.Utils.CreatePed(cShop.Ped.Type, cShop.Ped.Hash, cPreset.shop.Blip.location, false, cShop.Ped.Scenario)
    --     CRUX.Target.AddTargetEntity(shopPed, {
    --         options = {
    --             {
    --                 action = ShopMenu,
    --                 icon = cShop.targeticon,
    --                 label = cShop.targetlabel,
    --             },
    --         },
    --         distance = Config.TargetDistance
    --     })
    -- end

    -- Delivery Menu Target
    if Config.Delivery and Config.Delivery.Enabled then
        local cDelivery = Config.Delivery
        local deliveryPed = CRUX.Utils.CreatePed(cDelivery.ped.Type, cDelivery.ped.Hash, cPreset.delivery.pedLocation, false, cDelivery.ped.Scenario)
        table.insert(spawnedEntities, deliveryPed)  -- Track the spawned ped
        CRUX.Target.AddTargetEntity(deliveryPed, {
            options = {
                {
                    action = function (entity)
                        Client.Debug("Opening delivery menu")
                        deliveryMenu()
                    end,
                    icon = Config.Delivery.targeticon,
                    label = Config.Delivery.targetlabel,
                    canInteract = canInteract,
                },
            },
            distance = cDelivery.targetDistance,
        })
    end

    -- Billing Menu Target
    if cPreset.EnableTerminal then
        for i, v in pairs(cPreset.terminals) do
            local TerminalTargetOpt = {
                options = {
                    {
                        action = function (entity)
                            OpenBillingMenu(i,v)  -- Pass index i explicitly for terminal identification
                            
                            -- Wait a moment to ensure NUI focus has registered
                            Wait(200) 

                            -- Animation handling for terminals
                            if v.animation and v.animation.emote and v.animation.emote.enabled then
                                RequestAnimDict(v.animation.emote.anim.dict)
                                while not HasAnimDictLoaded(v.animation.emote.anim.dict) do
                                    Wait(0)
                                end
                                
                                -- Set duration to -1 (infinite)
                                TaskPlayAnim(PlayerPedId(), v.animation.emote.anim.dict, v.animation.emote.anim.anim,
                                    v.animation.emote.anim.speed, v.animation.emote.anim.speedMultiplier,
                                    -1, v.animation.emote.anim.flag, 0, false, false, false)

                                -- Handle prop attachment if enabled
                                local attachedProp = nil
                                if v.animation.emote.prop and v.animation.emote.prop.enable then
                                    attachedProp = CreateObject(GetHashKey(v.animation.emote.prop.model), 0, 0, 0, true, true, true)
                                    AttachEntityToEntity(attachedProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), v.animation.emote.prop.bone), 
                                        v.animation.emote.prop.pos.x, v.animation.emote.prop.pos.y, v.animation.emote.prop.pos.z, 
                                        v.animation.emote.prop.rot.x, v.animation.emote.prop.rot.y, v.animation.emote.prop.rot.z, 
                                        true, true, false, true, 1, true)
                                end

                                -- Loop while the UI is open
                                while IsNuiFocused() do
                                    Wait(500)
                                end
                                
                                ClearPedTasks(PlayerPedId())

                                -- Clean up attached prop
                                if attachedProp and DoesEntityExist(attachedProp) then
                                    DeleteEntity(attachedProp)
                                end

                            elseif v.animation and v.animation.scenario and v.animation.scenario.enabled then
                                TaskStartScenarioInPlace(PlayerPedId(), v.animation.scenario.anim.scenario, 0, true)

                                -- Loop while the UI is open
                                while IsNuiFocused() do
                                    Wait(500)
                                end
                                
                                ClearPedTasks(PlayerPedId())
                            end
                        end,
                        icon = v.targeticon,
                        label = v.targetlabel,
                        canInteract = canInteract,
                    }
                },
                distance = v.distance
            }
            if v.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(v.prop.model, v.prop.location, v.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, TerminalTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-terminal-" .. tostring(i)
                CRUX.Target.AddBoxZone(zoneName, v.location, v.length, v.width,  {
                    heading = v.heading,
                    minZ = v.minZ,
                    maxZ = v.maxZ,
                    options = TerminalTargetOpt.options,
                    distance = TerminalTargetOpt.distance
                }, Config.debugPoly)
            end
        end
    end

    -- Stashs Target
    if cPreset.EnableStash then
        for i, v in pairs(cPreset.stashs) do
            local stashTargetOpt = {
                options = {
                    {
                        action = function (entity)
                            local safeLabel = (v.targetlabel or ""):gsub("%s+", "_")
                            CRUX.Inventory.OpenStash(Config.ResourceName .. safeLabel .. '-' .. i)

                            -- Wait a moment to ensure NUI focus has registered (Inventory Open)
                            Wait(200)

                            if v.animation.emote.enabled then
                                RequestAnimDict(v.animation.emote.anim.dict)
                                while not HasAnimDictLoaded(v.animation.emote.anim.dict) do
                                    Wait(0)
                                end
                                
                                -- Set duration to -1 (infinite)
                                -- Ensure the flag includes the loop bit
                                local animFlag = v.animation.emote.anim.flag or 1
                                if type(animFlag) ~= "number" then animFlag = tonumber(animFlag) or 1 end
                                if bit32 and bit32.bor then
                                    animFlag = bit32.bor(animFlag, 1)
                                else
                                    -- fallback: if least significant bit not set, add 1
                                    if animFlag % 2 == 0 then animFlag = animFlag + 1 end
                                end
                                
                                -- Set duration to -1 (infinite) and use loop-capable flag
                                TaskPlayAnim(PlayerPedId(), v.animation.emote.anim.dict, v.animation.emote.anim.anim,
                                    v.animation.emote.anim.speed, v.animation.emote.anim.speedMultiplier,
                                    -1, animFlag, 0, false, false, false)

                                -- Handle prop attachment if enabled
                                local attachedProp = nil
                                if v.animation.emote.prop and v.animation.emote.prop.enable then
                                    attachedProp = CreateObject(GetHashKey(v.animation.emote.prop.model), 0, 0, 0, true, true, true)
                                    AttachEntityToEntity(attachedProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), v.animation.emote.prop.bone), 
                                        v.animation.emote.prop.pos.x, v.animation.emote.prop.pos.y, v.animation.emote.prop.pos.z, 
                                        v.animation.emote.prop.rot.x, v.animation.emote.prop.rot.y, v.animation.emote.prop.rot.z, 
                                        true, true, false, true, 1, true)
                                end

                                -- Loop while the UI is open
                                while IsNuiFocused() do
                                    Wait(500)
                                end
                                
                                ClearPedTasks(PlayerPedId())

                                -- Clean up attached prop
                                if attachedProp and DoesEntityExist(attachedProp) then
                                    DeleteEntity(attachedProp)
                                end

                            elseif v.animation.scenario.enabled then
                                TaskStartScenarioInPlace(PlayerPedId(), v.animation.scenario.anim.scenario, 0, true)

                                -- Loop while the UI is open
                                while IsNuiFocused() do
                                    Wait(500)
                                end
                                
                                ClearPedTasks(PlayerPedId())
                            end
                        end,
                        icon = v.targeticon,
                        label = v.targetlabel,
                        canInteract = canInteract,
                    }
                },
                distance = v.distance
            }
            if v.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(v.prop.model, v.prop.location, v.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, stashTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-stash-" .. tostring(i)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    v.location,
                    v.length,
                    v.width,
                    {
                        heading = v.heading,
                        minZ = v.minZ,
                        maxZ = v.maxZ,
                        options = stashTargetOpt.options,
                        distance = stashTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end

    -- Duty Target
    if cPreset.EnableDuty then
        for i, v in pairs(cPreset.duty) do
            local cDutyTargetOpt = {
                options = {
                    {
                        action = function (entity)
                            local progressConfig = {
                                id = "duty_toggle",
                                duration = v.progressBar.duration,
                                label = v.progressBar.label,
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    move = true,
                                    car = true,
                                    combat = true
                                }
                            }

                            local animConfig = v.progressBar.animation
                            if animConfig.emote.enabled then
                                progressConfig.animation = {
                                    animDict = animConfig.emote.anim.dict,
                                    anim = animConfig.emote.anim.clip,
                                    flag = 49
                                }

                                if animConfig.emote.prop and animConfig.emote.prop.enable then
                                    progressConfig.prop = {
                                        model = animConfig.emote.prop.model,
                                        bone = animConfig.emote.prop.bone,
                                        pos = animConfig.emote.prop.pos,
                                        rot = animConfig.emote.prop.rot
                                    }
                                end
                            elseif animConfig.scenario.enabled then
                                progressConfig.animation = {
                                    scenario = animConfig.scenario.anim.scenario
                                }
                            end

                            local prog = CRUX.Progress(progressConfig)

                            -- Only clean up props and clear tasks AFTER progress completes
                            if prog then
                                local player = PlayerPedId()
                                for _, entityId in ipairs(GetGamePool('CObject')) do
                                    if IsEntityAttachedToEntity(entityId, player) then
                                        NetworkRequestControlOfEntity(entityId)
                                        DetachEntity(entityId, true, true)
                                        SetEntityAsMissionEntity(entityId, true, true)
                                        DeleteObject(entityId)
                                        DeleteEntity(entityId)
                                    end
                                end

                                ClearPedTasks(player)
                                TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
                            else
                                local player = PlayerPedId()
                                ClearPedTasks(player)
                            end
                        end,
                        icon = v.targeticon,
                        label = v.targetlabel,
                        canInteract = canInteract,
                    }
                },
                distance = v.distance
            }

            if v.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(v.prop.model, v.prop.location, v.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, cDutyTargetOpt)
            else
                CRUX.Target.AddCircleZone(
                    "-toggleduty" .. i,
                    v.location,
                    v.radius,
                    cDutyTargetOpt,
                    Config.debugPoly
                )
            end
        end
    end

    -- Clothing Target
    if cPreset.EnableClothing then
        for i, v in ipairs(cPreset.clothing) do
            local clothingTargetOpt = {
                options = {
                    {
                        action = function (entity)
                            OpenJobClothing()
                        end,
                        icon = v.targeticon,
                        label = v.targetlabel,
                        canInteract = canInteract,
                    },
                },
                distance = v.distance
            }

            if v.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(v.prop.model, v.prop.location, v.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, clothingTargetOpt)
            else
                CRUX.Target.AddBoxZone(
                    "-clothing"..i,
                    v.location,
                    v.length,
                    v.width,
                    {
                        heading = v.heading,
                        minZ = v.minZ,
                        maxZ = v.maxZ,
                        options = clothingTargetOpt.options,
                        distance = clothingTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end


    -- Garage Target
    if Config.Garage and Config.Garage.enabled then
        local cGarage = Config.Garage
        local garagePed = CRUX.Utils.CreatePed(cGarage.Ped.Type, cGarage.Ped.Hash, cPreset.garage.pedLocation, false, cGarage.Ped.Scenario)
        table.insert(spawnedEntities, garagePed)

        CRUX.Target.AddTargetEntity(garagePed, {
            options = {
                {
                    action = function()
                        openGarage(cGarage.Vehicles) -- Opens Spawn UI
                    end,
                    icon = Config.Garage.OpenGarage_icon,
                    label = Config.Garage.OpenGarage_label,
                    canInteract = canInteract, 
                },
                {
                    action = function()
                        openReturnGarage() -- Opens Return UI (DB Check)
                    end,
                    icon = Config.Garage.ReturnVehicle_icon,
                    label = Config.Garage.ReturnVehicle_label,
                    -- Removed 'hasVehicleToReturn' check so they can open the menu 
                    -- to see their remote vehicles even if they aren't sitting in one.
                    canInteract = canInteract, 
                },
            },
            distance = Config.Garage.targetDistance,
        })
    end

    -- Trays Target
        if cPreset.trays and cPreset.EnableTray then
            for trayIdx, trayData in pairs(cPreset.trays) do
                local TrayTargetOpt = {
                    options = {
                        {
                            action = function (entity)
                                local safeLabel = (trayData.targetlabel or ""):gsub("%s+", "_")
                                CRUX.Inventory.OpenStash(Config.ResourceName .. safeLabel .. '-' .. trayIdx)
                            end,
                            icon = trayData.targeticon,
                            label = trayData.targetlabel,
                        }
                    },
                    distance = trayData.distance
                }

                if trayData.prop.enabled then
                    local ent = CRUX.Utils.SpawnProp(trayData.prop.model, trayData.prop.location, trayData.prop.rotation)
                    table.insert(spawnedEntities, ent)  -- Track the spawned entity
                    CRUX.Target.AddTargetEntity(ent, TrayTargetOpt)
                else
                    local zoneName = Config.ResourceName .. "-tray-" .. tostring(trayIdx)
                    CRUX.Target.AddBoxZone(
                        zoneName,
                        trayData.location,
                        trayData.length,
                        trayData.width,
                        {
                            heading = trayData.heading,
                            minZ = trayData.minZ,
                            maxZ = trayData.maxZ,
                            options = TrayTargetOpt.options,
                            distance = TrayTargetOpt.distance,
                            useZ = false
                        },
                        Config.debugPoly
                    )
                end
            end
        end

      -- Table Target
        if cPreset.table and cPreset.EnableTable then
            for tableIdx, tableData in pairs(cPreset.table) do
                local TrayTargetOpt = {
                    options = {
                        {
                            action = function (entity)
                                local safeLabel = (tableData.targetlabel or ""):gsub("%s+", "_")
                                CRUX.Inventory.OpenStash(Config.ResourceName .. safeLabel .. '-' .. tableIdx)
                            end,
                            icon = tableData.targeticon,
                            label = tableData.targetlabel,
                        }
                    },
                    distance = tableData.distance
                }

                if tableData.prop.enabled then
                    local ent = CRUX.Utils.SpawnProp(tableData.prop.model, tableData.prop.location, tableData.prop.rotation)
                    table.insert(spawnedEntities, ent)  -- Track the spawned entity
                    CRUX.Target.AddTargetEntity(ent, TrayTargetOpt)
                else
                    local zoneName = Config.ResourceName .. "-table-" .. tostring(tableIdx)
                    CRUX.Target.AddBoxZone(
                        zoneName,
                        tableData.location,
                        tableData.length,
                        tableData.width,
                        {
                            heading = tableData.heading,
                            minZ = tableData.minZ,
                            maxZ = tableData.maxZ,
                            options = TrayTargetOpt.options,
                            distance = TrayTargetOpt.distance,
                            useZ = false
                        },
                        Config.debugPoly
                    )
                end
            end
        end

    -- Ice Target
    if cPreset.ice and cPreset.EnableIce then
        for iceIdx, iceData in pairs(cPreset.ice) do
                local IceTargetOpt = {
                    options = {
                        {
                            action = function ()
                                local progressConfig = {
                                    id = "ice_machine",
                                    duration = iceData.progressBar.duration,
                                    label = iceData.progressBar.label,
                                    useWhileDead = false,
                                    canCancel = true,
                                    disable = {
                                        move = true,
                                        car = true,
                                        combat = true
                                    }
                                }

                                local animConfig = iceData.progressBar.animation
                                if animConfig.emote.enabled then
                                    progressConfig.animation = {
                                        animDict = animConfig.emote.anim.dict,
                                        anim = animConfig.emote.anim.clip,
                                        flag = 49
                                    }

                                    if animConfig.emote.prop and animConfig.emote.prop.enable then
                                        progressConfig.prop = {
                                            model = animConfig.emote.prop.model,
                                            bone = animConfig.emote.prop.bone,
                                            pos = animConfig.emote.prop.pos,
                                            rot = animConfig.emote.prop.rot
                                        }
                                    end
                                elseif animConfig.scenario.enabled then
                                    progressConfig.animation = {
                                        scenario = animConfig.scenario.anim.scenario
                                    }
                                end

                                local prog = CRUX.Progress(progressConfig)

                                -- Only clean up props and clear tasks AFTER progress completes
                                if prog then
                                    -- Clean up any attached props to prevent them from falling to ground
                                    local player = PlayerPedId()
                                    for _, entityId in ipairs(GetGamePool('CObject')) do
                                        if IsEntityAttachedToEntity(entityId, player) then
                                            NetworkRequestControlOfEntity(entityId)
                                            DetachEntity(entityId, true, true)
                                            SetEntityAsMissionEntity(entityId, true, true)
                                            DeleteObject(entityId)
                                            DeleteEntity(entityId)
                                        end
                                    end

                                    -- Then clear the tasks
                                    ClearPedTasks(player)

                                    TriggerServerEvent(":lib:server:HandleIce", {
                                        addItem = iceData.addItem,
                                        addItemCount = iceData.addItemCount
                                    })
                                else
                                    -- If progress was cancelled, still clean up
                                    local player = PlayerPedId()
                                    ClearPedTasks(player)
                                end
                            end,
                            icon = iceData.targeticon,
                            label = iceData.targetlabel,
                            canInteract = canInteract,
                        }
                    },
                    distance = iceData.distance
                }

                if iceData.prop.enabled then
                    local ent = CRUX.Utils.SpawnProp(iceData.prop.model, iceData.prop.location, iceData.prop.rotation)
                    table.insert(spawnedEntities, ent)  -- Track the spawned entity
                    CRUX.Target.AddTargetEntity(ent, IceTargetOpt)
                else
                    local zoneName = Config.ResourceName .. "-ice-" .. tostring(iceIdx)
                    CRUX.Target.AddBoxZone(
                        zoneName,
                        iceData.location,
                        iceData.length,
                        iceData.width,
                        {
                            heading = iceData.heading,
                            minZ = iceData.minZ,
                            maxZ = iceData.maxZ,
                            options = IceTargetOpt.options,
                            distance = IceTargetOpt.distance
                        },
                        Config.debugPoly
                    )
                end
            end
    end

    -- Trash Target
    if cPreset.EnableTrash then
        for dustbinIdx, dustbinData in pairs(cPreset.dustbin) do
            local TrashTargetOpt = {
                options = {
                    {
                        action = function (entity)
                            Client.Debug("Opening trash " .. dustbinIdx)
                            local safeLabel = (dustbinData.targetlabel or ""):gsub("%s+", "_")
                            CRUX.Inventory.OpenStash(Config.ResourceName .. safeLabel .. '-' .. dustbinIdx)
                        end,
                        icon = dustbinData.targeticon,
                        label = dustbinData.targetlabel,
                        canInteract = canInteract,
                    }
                },
                distance = dustbinData.distance
            }
            if dustbinData.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(dustbinData.prop.model, dustbinData.prop.location, dustbinData.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, TrashTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-trash-" .. tostring(dustbinIdx)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    dustbinData.location,
                    dustbinData.length,
                    dustbinData.width,
                    {
                        heading = dustbinData.heading,
                        minZ = dustbinData.minZ,
                        maxZ = dustbinData.maxZ,
                        options = TrashTargetOpt.options,
                        distance = TrashTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end

    -- Fridge Target
    if cPreset.EnableFridge then
        for i, v in pairs(cPreset.fridges) do
            local fridgeTargetOpt = {
                options = {
                    {
                        action = function ()
                            local safeLabel = (v.targetlabel or ""):gsub("%s+", "_")
                            CRUX.Inventory.OpenStash(Config.ResourceName .. safeLabel .. '-' .. i)
                        end,
                        icon = v.targeticon,
                        label = v.targetlabel,
                        canInteract = canInteract,
                    }
                },
                distance = v.distance
            }

            if v.prop.enabled then
                local ent = CRUX.Utils.SpawnProp(v.prop.model, v.prop.location, v.prop.rotation)
                table.insert(spawnedEntities, ent)  -- Track the spawned entity
                CRUX.Target.AddTargetEntity(ent, fridgeTargetOpt)
            else
                local zoneName = Config.ResourceName .. "-fridge-" .. tostring(i)
                CRUX.Target.AddBoxZone(
                    zoneName,
                    v.location,
                    v.length,
                    v.width,
                    {
                        heading = v.heading,
                        minZ = v.minZ,
                        maxZ = v.maxZ,
                        options = fridgeTargetOpt.options,
                        distance = fridgeTargetOpt.distance
                    },
                    Config.debugPoly
                )
            end
        end
    end



    -- Chairs Target
    for i, v in pairs(cPreset.chairs) do
        local name = "chair"..i
        CRUX.Target.AddCircleZone(
            name,
            v.location,
            v.targetRadius,
            {
                options = {
                    {
                        action = function (entity)
                            sitChair(i, v.scenario, v.animation)
                        end,
                        icon = v.targeticon,
                        label = v.targetlabel,
                    }
                },
                distance = v.distance
            },
            Config.debugPoly
        )
    end

    local function openSinkMenu(sinkId)
        local menuData = {
            Id = "-sink-menu",
            Title = Config.SinkCleaning.MenuHeading,
            Icon = Config.SinkCleaning.MenuIcon,
            Items = {}
        }

        -- Get player's current inventory once to check against required items
        local playerItems = {}
        local inventory = CRUX.Inventory.GetAllItems()
        if inventory then
            for _, item in pairs(inventory) do
                playerItems[item.name] = item
            end
        end

        -- Add "Wash Hands" option
        table.insert(menuData.Items, {
            Header = Config.SinkCleaning.WashHands.Title,
            Text = Config.SinkCleaning.WashHands.description,
            Icon = Config.SinkCleaning.UseCustomImages and Config.SinkCleaning.WashHands.image or Config.SinkCleaning.WashHands.icon,
            Args = { sinkId = sinkId },
            Event = Config.ResourceName .. ":Client:WashHands"
        })

        -- Add item cleaning options from config
        if Config.SinkCleaning and Config.SinkCleaning.enabled then
            for itemId, itemData in pairs(Config.SinkCleaning.items) do
                local metadata = {}
                local text = ""
                local canClean = true

                -- Build metadata and check if player has required items
                for _, reqItem in pairs(itemData.RequiredItems) do
                    local itemLabel = CRUX.Inventory.GetItemLabel(reqItem.item) or reqItem.item
                    if CRUX.Menu.GetCurrentActiveMenu() == "qb" then
                        text = text .. reqItem.count .. "x " .. itemLabel .. " <br>"
                    else
                        metadata[#metadata + 1] = { label = itemLabel, value = reqItem.count }
                    end

                    -- Check if the player has enough of the required item
                    local playerHasItem = playerItems[reqItem.item]
                    local playerItemCount = playerHasItem and tonumber(playerHasItem.count) or 0
                    if playerItemCount < reqItem.count then
                        canClean = false
                    end
                end

                local itemIcon = Config.SinkCleaning.UseCustomImages and itemData.image or itemData.icon

                table.insert(menuData.Items, {
                    Header = itemData.Title,
                    Text = itemData.description,
                    Icon = itemIcon,
                    disabled = not canClean, -- Disable if ingredients are missing
                    Args = {
                        sinkId = sinkId,
                        itemId = itemId,
                        required = itemData.RequiredItems,
                        add = itemData.AddItems,
                        progressBar = itemData.ProgressBar
                    },
                    Metadata = metadata,
                    Event = Config.ResourceName .. ":Client:CleanItem" -- FIX: Added resource name prefix
                })
            end
        end

        if #menuData.Items > 0 then
            CRUX.Menu(menuData)
        else
            CRUX.Notify({
                title = Config.Localess.WashHands.title,
                description = Config.Localess.WashHands.no_available,
                type = "error",
                duration = 5000,
            })
        end
    end

    -- Sinks Target
    if cPreset.EnableSink and cPreset.sinks then
    for i, v in pairs(cPreset.sinks) do
        local name = Config.ResourceName .. "-sink"..i
        CRUX.Target.AddBoxZone(
            name,
            v.location,
            v.length,
            v.width,
            {
            heading = v.heading,
            minZ = v.minZ,
            maxZ = v.maxZ,
            options = {
                {
                action = function(entity)
                    if Config.SinkCleaning and Config.SinkCleaning.enabled then
                    openSinkMenu(i)
                    else
                    WashHands(i)
                    end
                end,
                icon = Config.SinkCleaning.TargetIcon,
                label = Config.SinkCleaning.TargetLabel,
                }
            },
            distance = v.distance
            },
            Config.debugPoly
        )
     end
    end

    -- Crafts Target
    for i, v in pairs(Config.Crafts) do
        local pres = cPreset.craft[i]
        local Crafts = {
            Id = "-craft"..i,
            Title = pres.MenuTitle,
            Items = v
        }

        local CraftTargetOpt = {
            options = {
                {
                    action = function (entity)
                        if canInterHands() then
                            OpenCraft(Crafts)
                        end
                    end,
                    icon = pres.targeticon,
                    label = pres.targetlabel,
                    canInteract = canInteract,
                }
            },
            distance = pres.distance
        }

        if pres.prop and pres.prop.enabled then
            local ent = CRUX.Utils.SpawnProp(pres.prop.model, pres.prop.location, pres.prop.rotation)
            table.insert(spawnedEntities, ent)  -- Track the spawned entity
            CRUX.Target.AddTargetEntity(ent, CraftTargetOpt)
        else
            local name = Config.ResourceName .. "-craft"..i
            CRUX.Target.AddBoxZone(
                name,
                pres.location,
                pres.length,
                pres.width,
                {
                    heading = pres.heading,
                    minZ = pres.minZ,
                    maxZ = pres.maxZ,
                    options = CraftTargetOpt.options,
                    distance = CraftTargetOpt.distance
                },
                Config.debugPoly
            )
        end
    end

end

createTargets()

RegisterNetEvent(Config.ResourceName .. ":Client:WashHands", function(data)
    WashHands(data.sinkId)
end)

RegisterNetEvent(Config.ResourceName ..":Client:CleanItem", function(data)
    local progressBar = data.progressBar
    if progressBar then
        -- Only request server to check required items, no local check
        TriggerServerEvent(Config.ResourceName ..":Server:CheckRequiredItems", data.required, data)
    end
end)

RegisterNetEvent(Config.ResourceName ..":Client:RequiredItemsResult", function(hasItems, data)
    if hasItems then
        local progressBar = data.progressBar
        local progressConfig = {
            id = "clean_item",
            duration = progressBar.duration,
            label = progressBar.label,
            useWhileDead = false,
            canCancel = true,
            disable = {
                move = true,
                car = true,
                combat = true
            }
        }

        local animConfig = progressBar.animation
        if animConfig.emote.enabled then
            progressConfig.animation = {
                animDict = animConfig.emote.anim.dict,
                anim = animConfig.emote.anim.clip,
                flag = 49
            }

            if animConfig.emote.prop and animConfig.emote.prop.enable then
                progressConfig.prop = {
                    model = animConfig.emote.prop.model,
                    bone = animConfig.emote.prop.bone,
                    pos = animConfig.emote.prop.pos,
                    rot = animConfig.emote.prop.rot
                }
            end
        elseif animConfig.scenario.enabled then
            progressConfig.animation = {
                scenario = animConfig.scenario.anim.scenario
            }
        end

        local prog = CRUX.Progress(progressConfig)

        if prog then
                                    -- Clean up any attached props to prevent them from falling to ground
                        local player = PlayerPedId()
                        for _, entityId in ipairs(GetGamePool('CObject')) do
                            if IsEntityAttachedToEntity(entityId, player) then
                                NetworkRequestControlOfEntity(entityId)
                                DetachEntity(entityId, true, true)
                                SetEntityAsMissionEntity(entityId, true, true)
                                DeleteObject(entityId)
                                DeleteEntity(entityId)
                            end
                        end

                        ClearPedTasks(player)
                        
            TriggerServerEvent(Config.ResourceName ..":Server:HandleCleanItem", data)
        end
    end
end)

RegisterNetEvent(Config.ResourceName .. ":Client:OpenRestaurantMenu", function(menuIdx, menuImage)
    RestaurantMenu(menuIdx, menuImage)
end)

-- Clean up function on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    -- Delete all spawned entities (peds and props)
    DeleteAllSpawnedEntities()

    Client.Debug("Resource cleanup completed successfully")
end)