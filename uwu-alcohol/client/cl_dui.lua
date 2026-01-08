local customerDuiObj, employeeDuiObj = nil, nil
local customerProp, employeeProp = nil, nil
local resourceName = GetCurrentResourceName()
local currentOrders = {}
local menuDuis = {}

-- Event to receive orders for DUI from server
RegisterNetEvent(Config.ResourceName .. ':client:receiveOrdersForDUI')
AddEventHandler(Config.ResourceName .. ':client:receiveOrdersForDUI', function(orders)
    currentOrders = orders or {}
    --Client.Debug"[DEBUG] Received orders for DUI: " .. #currentOrders)
end)

-- Function to setup entity-specific DUI with proper render target
local function SetupEntityDui(duiUrl, propModel, propPos, propRot, txdName, textureName, propName)
    local modelHash = GetHashKey(propModel)
    
    -- Get the correct render target name for this prop model
    local rtName = RENDER_TARGET_MAP[propModel]
    if not rtName then
        --Client.Debug"[ERROR] " .. propName .. " - Model '" .. propModel .. "' not found in render target map!")
        return nil
    end
    
    --Client.Debug"[DEBUG] Setting up " .. propName .. " DUI with model: " .. propModel .. ", render target: " .. rtName)
    
    -- Request model
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(10) end
    --Client.Debug"[DEBUG] " .. propName .. " model loaded")
    
    -- Register and link render target BEFORE creating prop
    if not IsNamedRendertargetRegistered(rtName) then
        RegisterNamedRendertarget(rtName, false)
        --Client.Debug"[DEBUG] " .. propName .. " registered render target: " .. rtName)
    end
    
    if not IsNamedRendertargetLinked(modelHash) then
        LinkNamedRendertarget(modelHash)
        --Client.Debug"[DEBUG] " .. propName .. " linked render target to model hash: " .. modelHash)
    end
    
    -- Create prop
    local prop = CreateObject(modelHash, propPos.x, propPos.y, propPos.z, false, false, false)
    SetEntityRotation(prop, propRot.x, propRot.y, propRot.z, 2, true)
    FreezeEntityPosition(prop, true)
    SetEntityAsMissionEntity(prop, true, true)
    --Client.Debug"[DEBUG] " .. propName .. " prop created: " .. tostring(prop))
    
    -- Create DUI
    local duiObj = CreateDui(duiUrl, 1024, 512)
    
    -- Wait for DUI to be ready
    local timeout = 0
    while not IsDuiAvailable(duiObj) and timeout < 100 do 
        Wait(10)
        timeout = timeout + 1
    end
    
    if not IsDuiAvailable(duiObj) then
        --Client.Debug"[ERROR] " .. propName .. " DUI failed to become available")
        DeleteEntity(prop)
        return nil
    end
    --Client.Debug"[DEBUG] " .. propName .. " DUI created and available: " .. tostring(duiObj))
    
    -- Get DUI handle and create runtime texture
    local duiHandle = GetDuiHandle(duiObj)
    local txd = CreateRuntimeTxd(txdName)
    CreateRuntimeTextureFromDuiHandle(txd, textureName, duiHandle)
    --Client.Debug"[DEBUG] " .. propName .. " runtime texture created: " .. txdName .. "/" .. textureName)
    
    -- Get render target ID (we'll use it even if 0)
    local rtId = GetNamedRendertargetRenderId(rtName)
    --Client.Debug"[DEBUG] " .. propName .. " render target ID from native: " .. tostring(rtId))
    
    return {
        duiObj = duiObj,
        prop = prop,
        rtId = rtId,
        rtName = rtName,
        txdName = txdName,
        textureName = textureName,
        propName = propName,
        propModel = propModel,
        modelHash = modelHash
    }
end

-- Main creation thread
Citizen.CreateThread(function()
    -- Wait for config to be ready
    while not cPreset do Wait(100) end
    
    -- Check if screens are enabled before proceeding
    local customerEnabled = cPreset.CustomerOrderStatusScreen and cPreset.CustomerOrderStatusScreen.enabled
    local employeeEnabled = cPreset.EmployeeOrderStatusScreen and cPreset.EmployeeOrderStatusScreen.enabled
    
    if not customerEnabled and not employeeEnabled then
        --Client.Debug"[DEBUG] Both order status screens are disabled - skipping DUI setup")
        return
    end
    
    -- Check if both screens use props with the same render target (only if both are enabled)
    if customerEnabled and employeeEnabled then
        local customerPreset = cPreset.CustomerOrderStatusScreen.prop
        local employeePreset = cPreset.EmployeeOrderStatusScreen.prop
        local customerRt = RENDER_TARGET_MAP[customerPreset.model]
        local employeeRt = RENDER_TARGET_MAP[employeePreset.model]
        
        if customerRt == employeeRt then
            --Client.Debug"[WARNING] ========================================")
            --Client.Debug"[WARNING] Both screens use the same render target!")
            --Client.Debug"[WARNING] They will display the SAME content.")
            --Client.Debug"[WARNING] ========================================")
        end
    end
    
    -- ========= SETUP CUSTOMER DUI =========
    if customerEnabled then
        local customerPreset = cPreset.CustomerOrderStatusScreen.prop
        local customerData = SetupEntityDui(
            'nui://' .. resourceName .. '/build/dui.html',
            customerPreset.model,
            customerPreset.location,
            customerPreset.rotation or vector3(0.0, 0.0, 0.0),
            'customerDuiTxd',
            'customerDuiTexture',
            'Customer'
        )
        
        if customerData then
            customerDuiObj = customerData.duiObj
            customerProp = customerData.prop
            
            -- Rendering thread for customer
            Citizen.CreateThread(function()
                -- Try to get a valid render target ID in the render loop
                local validRtId = nil
                
                while customerDuiObj and DoesEntityExist(customerProp) do
                    Wait(0)
                    
                    -- Try to get render target ID if we don't have it yet
                    if not validRtId then
                        validRtId = GetNamedRendertargetRenderId(customerData.rtName)
                        if validRtId and validRtId ~= 0 then
                            --Client.Debug"[DEBUG] Customer got valid render target ID in loop: " .. validRtId)
                        end
                    end
                    
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local propCoords = GetEntityCoords(customerProp)
                    local distance = #(playerCoords - propCoords)
                    
                    if distance < 50.0 then
                        -- Prepare order data
                        local inProgress = {}
                        local ready = {}
                        for _, order in ipairs(currentOrders) do
                            if order.status == 'cooking' and (not order.self_pickup or order.employee_identifier) then 
                                table.insert(inProgress, order.order_id)
                            elseif order.status == 'ready' then 
                                table.insert(ready, order.order_id) 
                            end
                        end
                        
                        SendDuiMessage(customerDuiObj, json.encode({ 
                            action = 'updateOrderBoard', 
                            title = Config.LocalessUtils.CustomerOrderStatusScreen.title or "", 
                            titleImage = Config.LocalessUtils.CustomerOrderStatusScreen.titleImage or "",
                            inProgress = inProgress, 
                            ready = ready 
                        }))
                        
                        -- Use valid ID if we have it, otherwise use 0
                        local renderTargetId = validRtId or customerData.rtId or 0
                        SetTextRenderId(renderTargetId)
                        Set_2dLayer(4)
                        SetScriptGfxDrawBehindPausemenu(true)
                        DrawSprite(customerData.txdName, customerData.textureName, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
                    else
                        Wait(500)
                    end
                end
            end)
        end
    else
        --Client.Debug"[DEBUG] Customer order status screen is disabled")
    end
    
    Wait(100)
    
    -- ========= SETUP EMPLOYEE DUI =========
    if employeeEnabled then
        local employeePreset = cPreset.EmployeeOrderStatusScreen.prop
        local employeeData = SetupEntityDui(
            'nui://' .. resourceName .. '/build/employeedui.html',
            employeePreset.model,
            employeePreset.location,
            employeePreset.rotation or vector3(0.0, 0.0, 0.0),
            'employeeDuiTxd',
            'employeeDuiTexture',
            'Employee'
        )
        
        if employeeData then
            employeeDuiObj = employeeData.duiObj
            employeeProp = employeeData.prop
            
            -- Rendering thread for employee
            Citizen.CreateThread(function()
                local validRtId = nil
                
                while employeeDuiObj and DoesEntityExist(employeeProp) do
                    Wait(0)
                    
                    if not validRtId then
                        validRtId = GetNamedRendertargetRenderId(employeeData.rtName)
                        if validRtId and validRtId ~= 0 then
                            --Client.Debug"[DEBUG] Employee got valid render target ID in loop: " .. validRtId)
                        end
                    end
                    
                    local playerCoords = GetEntityCoords(PlayerPedId())
                    local propCoords = GetEntityCoords(employeeProp)
                    local distance = #(playerCoords - propCoords)
                    
                    if distance < 50.0 then
                        local acceptedOrders = {}
                        for _, order in ipairs(currentOrders) do
                            if order.employee_identifier and order.employee_identifier ~= '' then
                                table.insert(acceptedOrders, order)
                            end
                        end

                        SendDuiMessage(employeeDuiObj, json.encode({ 
                            action = 'updateEmployeeBoard', 
                            terminal = 'POS-01', 
                            orders = acceptedOrders,
                            title = Config.LocalessUtils.EmployeeOrderStatusScreen.title or "",
                            titleImage = Config.LocalessUtils.EmployeeOrderStatusScreen.titleImage or "",
                        }))
                        
                        local renderTargetId = validRtId or employeeData.rtId or 0
                        SetTextRenderId(renderTargetId)
                        Set_2dLayer(4)
                        SetScriptGfxDrawBehindPausemenu(true)
                        DrawSprite(employeeData.txdName, employeeData.textureName, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                        SetTextRenderId(GetDefaultScriptRendertargetRenderId())
                    else
                        Wait(500)
                    end
                end
            end)
        end
    else
        --Client.Debug"[DEBUG] Employee order status screen is disabled")
    end
    
    -- ========= SETUP MENU SCREENS DUI =========
    if cPreset.MenuScreens then
        for i, screen in ipairs(cPreset.MenuScreens) do
            local menuData = SetupEntityDui(
                'nui://' .. resourceName .. '/build/menudui.html',
                screen.model,
                screen.location,
                screen.rotation or vector3(0.0, 0.0, 0.0),
                'menuDuiTxd' .. i,
                'menuDuiTexture' .. i,
                'Menu' .. i
            )
            
            if menuData then
                menuDuis[i] = menuData
                
                -- Rendering thread for menu
                Citizen.CreateThread(function()
                    local validRtId = nil
                    
                    while menuData.duiObj and DoesEntityExist(menuData.prop) do
                        Wait(0)
                        
                        if not validRtId then
                            validRtId = GetNamedRendertargetRenderId(menuData.rtName)
                            if validRtId and validRtId ~= 0 then
                                --Client.Debug"[DEBUG] Menu " .. i .. " got valid render target ID in loop: " .. validRtId)
                            end
                        end
                        
                        local playerCoords = GetEntityCoords(PlayerPedId())
                        local propCoords = GetEntityCoords(menuData.prop)
                        local distance = #(playerCoords - propCoords)
                        
                        if distance < 50.0 then
                            SendDuiMessage(menuData.duiObj, json.encode({ 
                                action = 'setImage', 
                                image = screen.menuImage 
                            }))
                            
                            local renderTargetId = validRtId or menuData.rtId or 0
                            SetTextRenderId(renderTargetId)
                            Set_2dLayer(4)
                            SetScriptGfxDrawBehindPausemenu(true)
                            DrawSprite(menuData.txdName, menuData.textureName, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
                            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
                        else
                            Wait(500)
                        end
                    end
                end)
            end
        end
    end
end)

-- Thread for fetching data periodically
Citizen.CreateThread(function()
    while true do
        Wait(5000)
        -- Only fetch data if at least one screen is enabled
        if (cPreset.CustomerOrderStatusScreen and cPreset.CustomerOrderStatusScreen.enabled) or 
           (cPreset.EmployeeOrderStatusScreen and cPreset.EmployeeOrderStatusScreen.enabled) then
            TriggerServerEvent(Config.ResourceName .. ':server:refreshOrdersForDUI')
        end
    end
end)

-- Cleanup when the resource stops
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if customerDuiObj then
            DestroyDui(customerDuiObj)
            if DoesEntityExist(customerProp) then
                DeleteEntity(customerProp)
            end
            --Client.Debug"Cleaned up customer DUI assets.")
        end
        if employeeDuiObj then
            DestroyDui(employeeDuiObj)
            if DoesEntityExist(employeeProp) then
                DeleteEntity(employeeProp)
            end
            --Client.Debug"Cleaned up employee DUI assets.")
        end
        for i, menuData in ipairs(menuDuis) do
            if menuData.duiObj then
                DestroyDui(menuData.duiObj)
            end
            if DoesEntityExist(menuData.prop) then
                DeleteEntity(menuData.prop)
            end
            --Client.Debug"Cleaned up menu " .. i .. " DUI assets.")
        end
    end
end)

RegisterCommand('testrt', function()
    local rtId = GetNamedRendertargetRenderId('tvscreen')
    --Client.Debug"Render target ID for 'tvscreen': " .. tostring(rtId))
    
    local registered = IsNamedRendertargetRegistered('tvscreen')
    --Client.Debug"Is 'tvscreen' registered: " .. tostring(registered))
    
    local linked = IsNamedRendertargetLinked(GetHashKey('prop_tv_flat_01'))
    --Client.Debug"Is prop_tv_flat_01 linked: " .. tostring(linked))
end)


function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end

-- TV in Jimmys room
Citizen.CreateThread(function ()
	local model = GetHashKey("des_tvsmash_start"); -- 2054093856
	local pos = { x = -810.59, y = 170.46, z = 77.25 };
	local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.05, model, 0, 0, 0)
	local handle = CreateNamedRenderTargetForModel("tvscreen", model) -- CHANGED NAME HERE
	while true do
		SetTextRenderId(handle) -- set render target
		Set_2dLayer(4)
		Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
			DrawRect(0.5, 0.5, 1.0, 0.5, 255, 0, 0, 255); -- WOAH!
		SetTextRenderId(GetDefaultScriptRendertargetRenderId()) -- reset
		Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
		Citizen.Wait(0)
	end
end)