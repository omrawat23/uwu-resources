-- Client-side job system
JobSystem = JobSystem or {}
JobSystem.CurrentJob = {
    name = "unemployed",
    label = "Unemployed",
    grade = 0,
    grade_name = "Unemployed",
    onduty = false
}

-- Add initialization tracking
JobSystem.IsInitialized = false
JobSystem.InitAttempts = 0
JobSystem.MaxInitAttempts = 5

-- Update current job from server data
RegisterNetEvent(Config.ResourceName .. ':client:jobChanged')
AddEventHandler(Config.ResourceName .. ':client:jobChanged', function(jobData)
    JobSystem.CurrentJob = jobData
    -- Mark as initialized when we receive job data
    JobSystem.IsInitialized = true
    Client.Debug("Job updated: " .. json.encode(JobSystem.CurrentJob))

    TriggerEvent(Config.ResourceName .. ':onJobUpdate', jobData.name, jobData.onduty)

    -- If the job name is changed, update the client UI/blips as needed
    if jobData.name == Config.JobName then
        TriggerEvent(Config.ResourceName .. ':onPlayerLoaded') -- This event will setup blips, etc.
    else
        TriggerEvent(Config.ResourceName .. ':onPlayerUnload') -- This will remove job-specific UI elements
    end
end)

-- Update duty status
RegisterNetEvent(Config.ResourceName .. ':client:dutyStatusUpdated')
AddEventHandler(Config.ResourceName .. ':client:dutyStatusUpdated', function(onduty)
    JobSystem.CurrentJob.onduty = onduty
    TriggerEvent(Config.ResourceName .. ':settedDuty', onduty)
end)

-- Improved GetJob function with initialization checks and retry logic
JobSystem.GetJob = function()
    -- If not initialized and we haven't tried too many times, request data
    if not JobSystem.IsInitialized and JobSystem.InitAttempts < JobSystem.MaxInitAttempts then
        JobSystem.InitAttempts = JobSystem.InitAttempts + 1
        Client.Debug("Job system not ready, requesting data (attempt " .. JobSystem.InitAttempts .. ")")
        TriggerServerEvent(Config.ResourceName .. ':server:playerJoined')
        -- Wait a moment to get a response
        Wait(500)
    end

    return JobSystem.CurrentJob
end

-- Enhanced initialization with retry logic
Citizen.CreateThread(function()
    -- Initial delay to ensure server is ready
    Wait(2000)

    -- Request job data
    TriggerServerEvent(Config.ResourceName .. ':server:playerJoined')
    Client.Debug("Initial job data request sent")

    -- Set up retry mechanism
    local retryCount = 0
    local maxRetries = 5

    while not JobSystem.IsInitialized and retryCount < maxRetries do
        Wait(5000) -- Wait longer between retries
        retryCount = retryCount + 1

        if not JobSystem.IsInitialized then
            Client.Debug("Job data still not received, retry #" .. retryCount)
            TriggerServerEvent(Config.ResourceName .. ':server:playerJoined')
        end
    end

    if JobSystem.IsInitialized then
        Client.Debug("Job system successfully initialized: " .. JobSystem.CurrentJob.name)
    else
        Client.Debug("WARNING: Failed to initialize job system after " .. maxRetries .. " attempts")
    end
end)

-- Request job when player spawns with reset flags
RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
    Wait(1000) -- Small delay to ensure server is ready
    JobSystem.IsInitialized = false -- Reset flag to force a fresh load
    JobSystem.InitAttempts = 0      -- Reset attempt counter
    TriggerServerEvent(Config.ResourceName .. ':server:playerJoined')
    Client.Debug("Player spawned, requested job data")
end)

-- Toggle duty status
JobSystem.ToggleDuty = function()
    TriggerServerEvent(Config.ResourceName .. ':server:toggleDuty')
end

-- Export the function for use in other files
exports('GetJob', JobSystem.GetJob)

-- Add client-side exports to match server-side functionality
exports('hasJob', function()
    local job = JobSystem.GetJob()
    if not job then return false end

    -- Consider both name and label when checking unemployed
    if job.name == "unemployed" or (job.label and job.label:lower() == "unemployed") then
        return false
    end

    return true
end)

exports('hasJobAndGrade', function(grade)
    local job = JobSystem.GetJob()
    if not job then return false end

    -- Accept match by job name or job label, and compare numeric grades safely
    local jobMatches = (job.name == Config.JobName) or (Config.JobLabel and job.label == Config.JobLabel)
    if not jobMatches then return false end

    return tonumber(job.grade) == tonumber(grade)
end)

exports('onDuty', function()
    local job = JobSystem.GetJob()
    if not job then return false end
    return job.onduty == true
end)

-- Optional: export full job object for other resources that need the detailed structure
exports('getJob', function()
    return JobSystem.GetJob()
end)

-- Make the JobSystem globally accessible
_G.JobSystem = JobSystem

-- Add this client-side handler for duty toggling
RegisterNetEvent(Config.ResourceName .. ':client:toggleDuty')
AddEventHandler(Config.ResourceName .. ':client:toggleDuty', function()
    JobSystem.ToggleDuty()
end)

-- Replace CRUX.Framework.GetJob with our custom function
CRUX.Framework.GetJob = JobSystem.GetJob

-- Replace CRUX.Framework.ToggleDuty with our custom function
CRUX.Framework.ToggleDuty = JobSystem.ToggleDuty
