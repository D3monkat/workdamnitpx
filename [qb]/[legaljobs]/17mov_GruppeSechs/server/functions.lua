local Core

Config.Framework = "STANDALONE"

TriggerEvent("__cfx_export_qb-core_GetCoreObject", function(getCore)
    Core = getCore()
    Config.Framework = "QBCore"
end)

TriggerEvent("__cfx_export_es_extended_getSharedObject", function(getCore)
    Core = getCore()
    Config.Framework = "ESX"
end)

CreateThread(function()
    Citizen.Wait(1000)
    if Core == nil then
        TriggerEvent("esx:getSharedObject", function(obj)
            Core = obj
            Config.Framework = "ESX"
        end)
    end
end)

function RegisterUsableItem(name, cbFunction)
    if Config.Framework == "QBCore" then
        Core.Functions.CreateUseableItem(name, cbFunction)
    elseif Config.Framework == "ESX" then
        Core.RegisterUsableItem(name, cbFunction)
    else
        RegisterCommand("gruppeSechsTablet", cbFunction)
    end
end

local cachedNames = {}
function GetPlayerIdentity(source)
    if cachedNames[source] ~= nil then
        return cachedNames[source]
    end

    if Config.Framework == "QBCore" then
        local xPlayer = Core.Functions.GetPlayer(source)

        local timeout = 50
        while xPlayer == nil and timeout > 0 do
            Citizen.Wait(100)
            xPlayer = Core.Functions.GetPlayer(source)
            timeout = timeout - 1
        end

        if xPlayer == nil then return "Example Name" end

        cachedNames[source] = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname 
    elseif Config.Framework == "ESX" then
        local xPlayer = Core.GetPlayerFromId(source)

        local timeout = 50
        while xPlayer == nil and timeout > 0 do
            Citizen.Wait(100)
            xPlayer = Core.GetPlayerFromId(source)
            timeout = timeout - 1
        end

        if xPlayer == nil then return "Example Name" end
    
        cachedNames[source] = xPlayer.getName()
    else
        cachedNames[source] = GetPlayerName(source)
    end

    return cachedNames[source]
end    
     
    

function Notify(source, msg)
    if Config.UseBuiltInNotifications then
        TriggerClientEvent("17mov_DrawDefaultNotification"..GetCurrentResourceName(), source, msg)
    else
        if Config.Framework == "QBCore" then
            TriggerClientEvent("QBCore:Notify", source, msg)
        elseif Config.Framework == "ESX" then
            TriggerClientEvent("esx:showNotification", source, msg)
        else
            TriggerClientEvent("17mov_DrawDefaultNotification"..GetCurrentResourceName(), source, msg)
        end
    end
end

function Pay(source, amount)
    if Config.Framework == "QBCore" then
        local Player = Core.Functions.GetPlayer(source)
        if Player ~= nil and Player.Functions ~= nil then
            Player.Functions.AddMoney("cash", amount)

            local itemsToAdd = {}
            for k, item in pairs(Config.RewardItemsToGive) do
                if math.random(100) <= item.chance then
                    if itemsToAdd[item.item_name] == nil then
                        itemsToAdd[item.item_name] = 0
                    end

                    itemsToAdd[item.item_name] = itemsToAdd[item.item_name] +  item.amount
                end
            end

            for k,v in pairs(itemsToAdd) do
                Player.Functions.AddItem(k, v)
            end
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = Core.GetPlayerFromId(source)
        if xPlayer ~= nil and xPlayer.addMoney ~= nil then
            xPlayer.addMoney(amount)

            local itemsToAdd = {}
            for k, item in pairs(Config.RewardItemsToGive) do
                if math.random(100) <= item.chance then
                    if itemsToAdd[item.item_name] == nil then
                        itemsToAdd[item.item_name] = 0
                    end

                    itemsToAdd[item.item_name] = itemsToAdd[item.item_name] +  item.amount
                end
            end

            for k,v in pairs(itemsToAdd) do
                xPlayer.addInventoryItem(k, v)
            end
        end
    else
        -- Configure here ur payment
    end

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_gobierno', function(account)
        if account then
            account.addMoney((price/100)*20)
        end
    end)
end

function PayForCrime(source, amount)
    if Config.Framework == "QBCore" then
        local Player = Core.Functions.GetPlayer(source)
        if Player ~= nil and Player.Functions ~= nil then
            Player.Functions.AddMoney("cash", amount)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = Core.GetPlayerFromId(source)
        if xPlayer ~= nil and xPlayer.addMoney ~= nil then
            xPlayer.addMoney(amount)
        end
    else
        -- Configure here ur payment
    end
end

function PayPenalty(source, amount)
    if Config.Framework == "QBCore" then
        local Player = Core.Functions.GetPlayer(source)
        if Player ~= nil and Player.Functions ~= nil then
            Player.Functions.RemoveMoney("cash", amount)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = Core.GetPlayerFromId(source)
        if xPlayer ~= nil and xPlayer.removeMoney ~= nil then
            xPlayer.removeMoney(amount)
        end
    else
        -- Configure here ur remove money func
    end
end

function isHaveRequiredItem(source)
    if Config.RequiredItem ~= "none" then
        if Config.Framework == "QBCore" then
            local counter = 0
            for k,v in pairs(Core.Functions.GetPlayer(source).PlayerData.items) do
                if v.name == Config.RequiredItem then
                    local amount = v.amount
                    if amount == nil then amount = v.count end
                    counter = counter + amount
                    if amount > 0 then break end
                end
            end

            return counter > 0
        elseif Config.Framework == "ESX" then
            return Core.GetPlayerFromId(source).getInventoryItem(Config.RequiredItem).count > 0
        end
    end

    return true
end
function GetPlayerJob(source)
    if source == nil or type(source) ~= "number" then return "unknown" end
    if Config.Framework == "QBCore" then
        return Core.Functions.GetPlayer(source).PlayerData.job.name or "unknown"
    elseif Config.Framework == "ESX" then
        return Core.GetPlayerFromId(source).job.name or "unknown"
    else
        return "unknown"
    end
end

function IsEnoughPolice()
    local counter = 0
    if Config.Framework == "QBCore" then
        for _, v in pairs(Core.Functions.GetPlayers()) do
            local Player = Core.Functions.GetPlayer(v)
            if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
                counter = counter + 1
            end
        end
    elseif Config.Framework == "ESX" then
        local xPlayers = Core.GetPlayers()
        for i = 1, #xPlayers, 1 do
            local xPlayer = Core.GetPlayerFromId(xPlayers[i])
            if xPlayer and xPlayer.job.name == "police" then
                counter = counter + 1
            end
        end
    else
        return true
    end

    return counter >= Config.MinimumCopsToStartHeist
end

function NotifyCops(coords, vehNetId, plate)
    if Config.Framework == "QBCore" then
        for k, v in pairs(Core.Functions.GetPlayers()) do
            local Player = Core.Functions.GetPlayer(v)
            if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
                TriggerClientEvent("17mov_GruppeSechs:CopsNotify", v, coords, vehNetId, plate)
            end
        end
    elseif Config.Framework == "ESX" then
        local xPlayers = Core.GetPlayers()
        for i = 1, #xPlayers, 1 do
            local xPlayer = Core.GetPlayerFromId(xPlayers[i])
            if xPlayer and xPlayer.job.name == "police" then
                TriggerClientEvent("17mov_GruppeSechs:CopsNotify", xPlayers[i], coords, vehNetId, plate)
            end
        end
    end
end

function DisableNotificationForCops(vehNetId)
    if Config.Framework == "QBCore" then
        for k, v in pairs(Core.Functions.GetPlayers()) do
            local Player = Core.Functions.GetPlayer(v)
            if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
                TriggerClientEvent("17mov_GruppeSechs:disableCopsNotify", v, vehNetId)
            end
        end
    elseif Config.Framework == "ESX" then
        local xPlayers = Core.GetPlayers()
        for i = 1, #xPlayers, 1 do
            local xPlayer = Core.GetPlayerFromId(xPlayers[i])
            if xPlayer and xPlayer.job.name == "police" then
                TriggerClientEvent("17mov_GruppeSechs:disableCopsNotify", xPlayers[i], vehNetId)
            end
        end
    end
end