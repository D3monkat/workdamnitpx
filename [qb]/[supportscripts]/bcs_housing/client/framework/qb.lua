CreateThread(function()
    if Config.framework ~= 'QB' then return end
    QBCore = exports['qb-core']:GetCoreObject()
    
    PlayerData = QBCore.Functions.GetPlayerData()

    RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
        PlayerData = val
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        RemoveAllBlip()
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        TriggerEvent("Housing:initialize")
    end)

    function TriggerServerCallback(func, ...)
        QBCore.Functions.TriggerCallback(func, ...)
    end

    function GetClosestPlayer()
        return QBCore.Functions.GetClosestPlayer()
    end
end)