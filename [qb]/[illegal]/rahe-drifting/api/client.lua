--
--[[ Framework specific functions ]]--
--

local framework = shConfig.framework
local ESX, QBCore

CreateThread(function()
    if framework == 'ESX' then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    elseif framework == 'QB' then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

--
--[[ Drifting tablet opening ]]--
--

-- Tablet opening through a command
RegisterCommand("drifting", function()
    openTablet()
end)

-- Tablet opening through an event
RegisterNetEvent("rahe-drifting:client:openTablet")
AddEventHandler("rahe-drifting:client:openTablet", function()
    openTablet()
end)

--
--[[ General]]--
--

RegisterNetEvent('rahe-drifting:client:notify')
AddEventHandler('rahe-drifting:client:notify',function(message, type)
    notifyPlayer(message, type)
end)

function notifyPlayer(message, type)
    TriggerEvent('chatMessage', "SERVER", "normal", message)
end

-- You can do some logic here when the tablet is closed. For example, if you started an animation when opening, you can end the animation here.
RegisterNetEvent('rahe-drifting:client:tabletClosed', function()

end)

exports('driftingtablet', function(data, slot)
    openTablet()
end)