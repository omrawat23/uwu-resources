
-- Event handler to get player's saved skin with multi-framework support
RegisterNetEvent(Config.ResourceName .. "server:getPlayerSkin", function()
    local src = source
    local framework = Config.Framework:lower()

    -- Auto-detect framework if set to auto-detect
    if framework == "auto-detect" then
        if GetResourceState("es_extended") ~= "missing" then
            framework = "esx"
        elseif GetResourceState("qbx_core") ~= "missing" then
            framework = "qbx"
        elseif GetResourceState("qb-core") ~= "missing" then
            framework = "qb"
        else
            Server.Debug("^1[ERROR]^7 Could not auto-detect framework for outfits system")
            return
        end
    end

    Server.Debug("^2[INFO]^7 Using " .. framework .. " framework for outfits system")

    -- Handle skin loading based on detected framework
    if framework == "qb" then
        -- QB-Core implementation
        local Player = CRUX.Framework.GetPlayer(src)
        if not Player then return end

        local citizenid = CRUX.Framework.GetPlayerCitizenId(src)

        -- Get player skin from database
        local result = MySQL.query.await('SELECT skin FROM players WHERE citizenid = ?', {citizenid})
        if result[1] and result[1].skin then
            TriggerClientEvent("qb-clothing:client:loadPlayerClothing", src, json.decode(result[1].skin))
            TriggerClientEvent(Config.ResourceName .. "client:loadPlayerSkin", src) -- Notify our script the skin is loaded
        end

    elseif framework == "qbx" then
        -- QBX implementation
        local Player = CRUX.Framework.GetPlayer(src)
        if not Player then return end

        -- Handle QBX differences - it might use Player.Data instead of PlayerData
        local citizenid
        if Player.PlayerData then
            citizenid = CRUX.Framework.GetPlayerCitizenId(src)
        elseif Player.Data then
            citizenid = CRUX.Framework.GetPlayerCitizenId(src)
        else
            Server.Debug("^1[ERROR]^7 Could not get citizenid for player in QBX framework")
            return
        end

        -- Get player skin from database - QBX may use a different table/column
        local result = MySQL.query.await('SELECT skin FROM players WHERE citizenid = ?', {citizenid})
        if result[1] and result[1].skin then
            TriggerClientEvent("qb-clothing:client:loadPlayerClothing", src, json.decode(result[1].skin))
            -- QBX might use a different event, but we'll try the standard one first
            TriggerClientEvent(Config.ResourceName .. "client:loadPlayerSkin", src)
        end

    elseif framework == "esx" then
        -- ESX implementation
        local xPlayer = CRUX.Framework.GetPlayer(src)
        if not xPlayer then return end

        local identifier = xPlayer.getIdentifier()

        -- ESX stores skin data differently - could be in 'users' table or in datastore
        -- Try direct skin storage first
        local result = MySQL.query.await('SELECT skin FROM users WHERE identifier = ?', {identifier})
        if result[1] and result[1].skin then
            -- ESX typically uses skinchanger
            TriggerClientEvent('skinchanger:loadSkin', src, json.decode(result[1].skin))
            TriggerClientEvent(Config.ResourceName .. "client:loadPlayerSkin", src)
        else
            -- Try datastore approach if direct skin not found
            local result = MySQL.query.await('SELECT data FROM datastore_data WHERE name = ? AND owner = ?', {'user_skin', identifier})
            if result[1] and result[1].data then
                local skinData = json.decode(result[1].data)
                TriggerClientEvent('skinchanger:loadSkin', src, skinData)
                TriggerClientEvent(Config.ResourceName .. "client:loadPlayerSkin", src)
            else
                Server.Debug("^1[WARNING]^7 Could not find skin data for player in ESX framework")
            end
        end
    else
        Server.Debug("^1[ERROR]^7 Unsupported framework for outfits system: " .. tostring(framework))
    end
end)
