RegisterNetEvent('qb-cayoperico:server:callCops', function(type, coords)
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            TriggerClientEvent("qb-cayoperico:client:callCops", Player.PlayerData.source, type, coords)
        end
    end
end)

RegisterNetEvent('qb-cayoperico:server:callIslanders', function(coords)
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "cayoperico" then
            TriggerClientEvent("qb-cayoperico:client:callIslanders", Player.PlayerData.source, coords)
        end
    end
end)
