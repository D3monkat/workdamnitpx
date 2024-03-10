CreateThread(function()
    if Config.framework ~= 'ESX' then return end
    ESX = exports['es_extended']:getSharedObject()
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end

    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
        RemoveAllBlip()
        TriggerEvent("Housing:initialize")
    end)
    
    PlayerData = ESX.GetPlayerData()

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)

    function TriggerServerCallback(func, ...)
        ESX.TriggerServerCallback(func, ...)
    end

    function GetClosestPlayer()
        return ESX.Game.GetClosestPlayer()
    end
end)