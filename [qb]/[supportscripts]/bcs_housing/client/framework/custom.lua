CreateThread(function()
    if Config.framework == 'ESX' or Config.framework == 'QB' then return end

    --When player logs in to the server
    RegisterNetEvent('framework:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
        RemoveAllBlip()
        TriggerEvent("Housing:initialize")
    end)
    
    PlayerData = GetPlayerData()

    RegisterNetEvent('framework:setJob')
    AddEventHandler('framework:setJob', function(job)
        PlayerData.job = job
    end)

    function TriggerServerCallback(func, ...)
        TriggerServerCallback(func, ...)
    end

    function GetClosestPlayer()
        return ESX.Game.GetClosestPlayer()
    end
end)