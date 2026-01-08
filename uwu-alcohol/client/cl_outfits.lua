local currentOutfit = nil
local playerGrade = 0
local playerGradeLabel = "Employee"
local savedCivilianOutfit = nil -- Store the player's civilian outfit when they change to uniform

-- Function to get player's current job grade and label - updated to use JobSystem
local function GetPlayerJobInfo()
    -- Use JobSystem.GetJob() instead of CRUX.Framework.GetPlayerJobInfo()
    local playerJob = JobSystem.GetJob()
    local grade = playerJob and tonumber(playerJob.grade) or 0
    local gradeLabel = playerJob and playerJob.grade_name or "Employee"

    -- If grade_name is not available, try to get it from Config.Grades
    if not playerJob or not playerJob.grade_name then
        local gradeStr = tostring(grade)
        if Config.Grades and Config.Grades[gradeStr] then
            gradeLabel = Config.Grades[gradeStr].Label or "Employee"
        end
    end

    return grade, gradeLabel
end

-- Update job grade when starting
Citizen.CreateThread(function()
    Wait(5000) -- Wait for framework to initialize
    playerGrade, playerGradeLabel = GetPlayerJobInfo()
    Client.Debug("Outfits: Initial player grade: " .. tostring(playerGrade) .. " (" .. playerGradeLabel .. ")")
end)

-- Update job grade whenever it changes using job change events
-- RegisterNetEvent('QBCore:Client:OnJobUpdate')
-- AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
--     if JobInfo and JobInfo.name == Config.JobName then
--         playerGrade = tonumber(JobInfo.grade)
--         playerGradeLabel = JobInfo.grade_name or "Employee"
--         Client.Debug"Outfits: Updated player grade: " .. tostring(playerGrade) .. " (" .. playerGradeLabel .. ")")
--     end
-- end)

-- Also listen for JobSystem-specific events if available
RegisterNetEvent('JobSystem:Client:JobUpdate')
AddEventHandler('JobSystem:Client:JobUpdate', function(JobInfo)
    if JobInfo and JobInfo.name == Config.JobName then
        playerGrade = tonumber(JobInfo.grade)
        playerGradeLabel = JobInfo.grade_name or "Employee"
        Client.Debug("Outfits: Updated player grade from JobSystem: " .. tostring(playerGrade) .. " (" .. playerGradeLabel .. ")")
    end
end)

-- Get the current gender for outfit selection
RegisterNUICallback("getPlayerGender", function(data, cb)
    local gender = CRUX.Framework.GetGender()
    cb({gender = gender})
end)

-- Get the current outfit (if one is equipped)
RegisterNUICallback("getCurrentOutfit", function(data, cb)
    cb({currentOutfit = currentOutfit})
end)

-- Function to get current player clothing
local function GetCurrentClothing()
    local ped = PlayerPedId()
    return {
        hat = { Id = GetPedPropIndex(ped, 0), Texture = GetPedPropTextureIndex(ped, 0) },
        mask = { Id = GetPedDrawableVariation(ped, 1), Texture = GetPedTextureVariation(ped, 1) },
        arms = { Id = GetPedDrawableVariation(ped, 3), Texture = GetPedTextureVariation(ped, 3) },
        pants = { Id = GetPedDrawableVariation(ped, 4), Texture = GetPedTextureVariation(ped, 4) },
        bag = { Id = GetPedDrawableVariation(ped, 5), Texture = GetPedTextureVariation(ped, 5) },
        shoes = { Id = GetPedDrawableVariation(ped, 6), Texture = GetPedTextureVariation(ped, 6) },
        ["t-shirt"] = { Id = GetPedDrawableVariation(ped, 8), Texture = GetPedTextureVariation(ped, 8) },
        torso = { Id = GetPedDrawableVariation(ped, 11), Texture = GetPedTextureVariation(ped, 11) },
        decals = { Id = GetPedDrawableVariation(ped, 10), Texture = GetPedTextureVariation(ped, 10) },
        armor = { Id = GetPedDrawableVariation(ped, 9), Texture = GetPedTextureVariation(ped, 9) }
    }
end

-- Function to apply clothing outfit
local function ApplyClothing(outfitData)
    local ped = PlayerPedId()

    -- Apply all clothing components
    if outfitData.hat and outfitData.hat.Id ~= -1 then
        SetPedPropIndex(ped, 0, outfitData.hat.Id, outfitData.hat.Texture, true)
    else
        ClearPedProp(ped, 0)
    end

    if outfitData.mask then
        SetPedComponentVariation(ped, 1, outfitData.mask.Id, outfitData.mask.Texture, 0)
    end

    if outfitData.arms then
        SetPedComponentVariation(ped, 3, outfitData.arms.Id, outfitData.arms.Texture, 0)
    end

    if outfitData.pants then
        SetPedComponentVariation(ped, 4, outfitData.pants.Id, outfitData.pants.Texture, 0)
    end

    if outfitData.bag then
        SetPedComponentVariation(ped, 5, outfitData.bag.Id, outfitData.bag.Texture, 0)
    end

    if outfitData.shoes then
        SetPedComponentVariation(ped, 6, outfitData.shoes.Id, outfitData.shoes.Texture, 0)
    end

    if outfitData["t-shirt"] then
        SetPedComponentVariation(ped, 8, outfitData["t-shirt"].Id, outfitData["t-shirt"].Texture, 0)
    end

    if outfitData.torso then
        SetPedComponentVariation(ped, 11, outfitData.torso.Id, outfitData.torso.Texture, 0)
    end

    if outfitData.decals then
        SetPedComponentVariation(ped, 10, outfitData.decals.Id, outfitData.decals.Texture, 0)
    end

    if outfitData.armor then
        SetPedComponentVariation(ped, 9, outfitData.armor.Id, outfitData.armor.Texture, 0)
    end
end

-- Get available outfits based on player's job grade
RegisterNUICallback("getAvailableOutfits", function(data, cb)
    local availableOutfits = {}
    local gender = CRUX.Framework.GetGender()

    -- Always include civilian option
    table.insert(availableOutfits, {
        id = 'civilian',
        name = Config.Localess.Outfits.civilian_clothes or "Return to Civilian Clothes",
        category = "Custom",
        grade = 0,
        isCurrent = currentOutfit == nil, -- civilian is when currentOutfit is nil
        hasOutfit = savedCivilianOutfit ~= nil -- whether we have saved civilian clothes
    })

    -- Add ONLY the outfit for the player's current grade
    local gradeString = tostring(playerGrade)
    -- Only add outfit if it exists for player's gender
    if Config.Outfits[gender] and Config.Outfits[gender][gradeString] then
        -- Get outfit name from Config.Grades instead of Config.Outfits.OutfitNames
        local outfitName = "Grade " .. gradeString .. " Uniform" -- Default fallback
        if Config.Grades[gradeString] and Config.Grades[gradeString].OutfitName then
            outfitName = Config.Grades[gradeString].OutfitName
        end

        table.insert(availableOutfits, {
            id = 'grade_' .. gradeString,
            name = outfitName,
            category = playerGrade >= 3 and "Formal Wear" or "Work Uniform",
            grade = playerGrade,
            isCurrent = currentOutfit == 'grade_' .. gradeString
        })
    end

    cb({
        outfits = availableOutfits,
        playerGrade = playerGrade,
        playerGradeLabel = playerGradeLabel
    })
end)

-- Callback to equip an outfit based on Config.Outfits
RegisterNUICallback("equipOutfit", function(data, cb)
    local outfitId = data.outfitId
    local gender = data.gender or CRUX.Framework.GetGender()
    local success = false
    local description = Config.Localess.Outfits.failed_equip or "Failed to equip outfit"

    if not Config.Outfits.Enable then
        cb({success = false, description = Config.Localess.Outfits.disabled or "Outfits are disabled"})
        return
    end

    if gender ~= "Male" and gender ~= "Female" then
        cb({success = false, description = Config.Localess.Outfits.invalid or "Invalid gender"})
        return
    end

    -- Determine which outfit configuration to use based on outfit ID
    local outfitData = nil
    local gradeRequired = nil

    if outfitId == "civilian" then
        -- Handle civilian clothes case
        if savedCivilianOutfit then
            -- Play animation if enabled
            if Config.Outfits.Animation.Enable then
                local ped = PlayerPedId()
                RequestAnimDict(Config.Outfits.Animation.Anim.Dict)
                while not HasAnimDictLoaded(Config.Outfits.Animation.Anim.Dict) do
                    Wait(10)
                end
                TaskPlayAnim(ped, Config.Outfits.Animation.Anim.Dict, Config.Outfits.Animation.Anim.Name, 8.0, -8.0, -1, 0, 0, false, false, false)
                Wait(1000)
            end

            -- Restore the saved civilian outfit
            ApplyClothing(savedCivilianOutfit)

            -- Stop animation
            if Config.Outfits.Animation.Enable then
                local ped = PlayerPedId()
                StopAnimTask(ped, Config.Outfits.Animation.Anim.Dict, Config.Outfits.Animation.Anim.Name, 1.0)
            end

            currentOutfit = nil
            success = true
            description = Config.Localess.Outfits.civilian_clothes or "Changed to Civilian Clothes"

            -- Show notification
            CRUX.Notify({
                title = Config.Localess.Outfits.title or "Outfit",
                description = Config.Localess.Outfits.reset_civilian_clothes or "You've changed back to your civilian clothes",
                type = "success",
                duration = 5000
            })
        else
            cb({success = false, description = Config.Localess.Outfits.no_civilian_saved or "No civilian outfit saved. Please change to uniform first."})
            return
        end
    else
        -- Extract grade from outfit ID (format: 'grade_X')
        gradeRequired = tonumber(outfitId:match("grade_(%d+)"))

        if not gradeRequired or gradeRequired > playerGrade then
            cb({success = false, description = Config.Localess.Outfits.no_permission or "You don't have permission to use this outfit"})
            return
        end

        -- Get outfit data for the specific grade and gender
        outfitData = Config.Outfits[gender][tostring(gradeRequired)]

        if not outfitData then
            cb({success = false, description = Config.Localess.Outfits.outfit_not_found or "Outfit not found"})
            return
        end

        -- Save current civilian outfit if switching from civilian to uniform
        if currentOutfit == nil then
            savedCivilianOutfit = GetCurrentClothing()
            Client.Debug("Saved civilian outfit for later restoration")
        end

        -- Play animation if enabled
        if Config.Outfits.Animation.Enable then
            local ped = PlayerPedId()
            RequestAnimDict(Config.Outfits.Animation.Anim.Dict)
            while not HasAnimDictLoaded(Config.Outfits.Animation.Anim.Dict) do
                Wait(10)
            end
            TaskPlayAnim(ped, Config.Outfits.Animation.Anim.Dict, Config.Outfits.Animation.Anim.Name, 8.0, -8.0, -1, 0, 0, false, false, false)
            Wait(1000)
        end

        -- Apply the uniform outfit
        ApplyClothing(outfitData)

        -- Stop animation
        if Config.Outfits.Animation.Enable then
            local ped = PlayerPedId()
            StopAnimTask(ped, Config.Outfits.Animation.Anim.Dict, Config.Outfits.Animation.Anim.Name, 1.0)
        end

        -- Update the current outfit
        currentOutfit = outfitId
        success = true
        description = Config.Localess.Outfits.equip_success or "Outfit equipped successfully"

        -- Show notification
        local outfitName = (Config.Grades[tostring(gradeRequired)] and Config.Grades[tostring(gradeRequired)].OutfitName) or "work uniform"
        CRUX.Notify({
            title = Config.Localess.Outfits.title or "Outfit",
            description = string.format(Config.Localess.Outfits.changed_to_uniform or "You've changed into your %s", outfitName),
            type = "success",
            duration = 5000
        })
    end

    cb({success = success, description = description})
end)

-- Reset outfit to player's own clothes
RegisterNUICallback("resetOutfit", function(data, cb)
    local success = false
    local description = Config.Localess.Outfits.failed_equip or "Failed to reset outfit"

    if savedCivilianOutfit then
        -- Play animation if enabled
        if Config.Outfits.Animation.Enable then
            local ped = PlayerPedId()
            RequestAnimDict(Config.Outfits.Animation.Anim.Dict)
            while not HasAnimDictLoaded(Config.Outfits.Animation.Anim.Dict) do
                Wait(10)
            end
            TaskPlayAnim(ped, Config.Outfits.Animation.Anim.Dict, Config.Outfits.Animation.Anim.Name, 8.0, -8.0, -1, 0, 0, false, false, false)
            Wait(1000)
        end

        -- Restore saved civilian outfit
        ApplyClothing(savedCivilianOutfit)

        -- Stop animation
        if Config.Outfits.Animation.Enable then
            local ped = PlayerPedId()
            StopAnimTask(ped, Config.Outfits.Animation.Anim.Dict, Config.Outfits.Animation.Anim.Name, 1.0)
        end

        success = true
        description = Config.Localess.Outfits.reset_success or "Outfit reset successfully"
        currentOutfit = nil

        -- Show notification
        CRUX.Notify({
            title = Config.Localess.Outfits.title or "Outfit",
            description = Config.Localess.Outfits.reset_civilian_clothes or "You've changed back to your civilian clothes",
            type = "success",
            duration = 5000
        })
    else
        description = Config.Localess.Outfits.no_civilian_for_reset or "No civilian outfit saved. Please change to uniform first to save your current clothes."
    end

    cb({success = success, description = description})
end)

-- Event handler for receiving player skin data - not needed anymore since we don't use framework clothes
RegisterNetEvent(Config.ResourceName .. "client:loadPlayerSkin", function()
    -- This event is no longer used since we save actual clothing manually
    savedCivilianOutfit = nil
    currentOutfit = nil
end)

-- Function to open job clothing menu
function OpenJobClothing()
    Client.Debug("Opening job clothing menu")

    -- Update job grade info before opening
    playerGrade, playerGradeLabel = GetPlayerJobInfo()
    Client.Debug("Job clothing: Current grade: " .. tostring(playerGrade) .. " (" .. playerGradeLabel .. ")")

    -- Send event to open the clothing UI with locales data
    SendNUIMessage({
        action = "openJobClothing",
        locales = Config.Localess,
        locales_utils = Config.LocalessUtils
    })

    -- Set focus for UI interaction
    SetNuiFocus(true, true)
end

-- Callback to close job clothing menu
RegisterNUICallback("closeJobClothing", function(data, cb)
    Client.Debug("Closing job clothing menu")
    SetNuiFocus(false, false)
    cb("ok")
end)
