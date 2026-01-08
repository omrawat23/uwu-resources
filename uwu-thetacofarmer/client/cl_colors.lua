RegisterNUICallback('getColors', function(_, cb)
    local colors = Config.Colors or {}
    cb(colors)
end)
