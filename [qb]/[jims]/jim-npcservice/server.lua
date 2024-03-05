RegisterNetEvent("jim-npcservice:server:CreateTarget", function(veh) local src = source
    if Config.Debug then print("^5Debug^7: ^3Creating ^2target for all nearby: '^6"..veh.."^7'") end
    local nearbyList = {}
    for _, playerId in ipairs(GetPlayers()) do
        if #(GetEntityCoords(NetworkGetEntityFromNetworkId(veh)) - GetEntityCoords(GetPlayerPed(playerId))) <= 25 then
            nearbyList[#nearbyList+1] = playerId
        end
    end
    for i = 1, #nearbyList do
        TriggerClientEvent("jim-npcservice:client:CreateTarget", nearbyList[i], veh)
    end
end)

RegisterNetEvent("jim-npcservice:server:RemoveTarget", function(veh) local src = source
    if Config.Debug then print("^5Debug^7: ^3Removing ^2target for all: '^6"..veh.."^7'") end
    TriggerClientEvent("jim-npcservice:client:RemoveTarget", -1, veh)
end)

RegisterNetEvent("jim-npcservice:server:leaveTaxi", function(veh, coords) local src = source
    if Config.Debug then print("^5Debug^7: ^3Forcing ^2Players to leave vehicle: '^6"..veh.."^7'") end
    local nearbyList = {}
    for _, playerId in ipairs(GetPlayers()) do
        if #(coords - GetEntityCoords(GetPlayerPed(playerId))) <= 6 then
            nearbyList[#nearbyList+1] = playerId
        end
    end
    for i = 1, #nearbyList do
        TriggerClientEvent('jim-npcservice:client:leaveTaxi', nearbyList[i], veh)
    end
end)

RegisterNetEvent("jim-npcservice:server:skipPlayers", function(veh, coords) local src = source
    if Config.Debug then print("^5Debug^7: ^2Sending skip event to nearby players: '^6"..veh.."^7'") end
    local nearbyList = {}
    for _, playerId in ipairs(GetPlayers()) do
        if #(coords - GetEntityCoords(GetPlayerPed(playerId))) <= 6 then
            nearbyList[#nearbyList+1] = playerId
        end
    end
    for i = 1, #nearbyList do
        if tonumber(src) ~= tonumber(nearbyList[i]) then
            TriggerClientEvent('jim-npcservice:client:skipPlayers', nearbyList[i], veh)
        end
    end
end)

RegisterNetEvent("jim-npcservice:server:enterPlane", function(veh) local src = source
    if Config.Debug then print("^5Debug^7: ^3Forcing ^2Players to leave plane: '^6"..coords.."^7'") end
    local nearbyList = {}
    for _, playerId in ipairs(GetPlayers()) do
        if #(coords - GetEntityCoords(GetPlayerPed(playerId))) <= 15 then
            nearbyList[#nearbyList+1] = playerId
        end
    end
    for i = 1, #nearbyList do
        TriggerClientEvent('jim-npcservice:client:leavePlane', nearbyList[i], exit)
    end
end)

local airPortUse = {}
for k, v in pairs(Config.Airports) do airPortUse[v.start] = false end

RegisterNetEvent("jim-npcservice:server:airportUse", function(airport, vehicle)
    if Config.Debug then print("^5Debug^7: ^3"..airport.." ^2Toggling useage '^6"..tostring(vehicle).."^7'") end
    airPortUse[airport] = vehicle
end)

RegisterNetEvent("jim-npcservice:server:leavePlane", function(coords, exit) local src = source
    if Config.Debug then print("^5Debug^7: ^3Forcing ^2Players to leave plane: '^6"..coords.."^7'") end
    local nearbyList = {}
    for _, playerId in ipairs(GetPlayers()) do
        if #(coords - GetEntityCoords(GetPlayerPed(playerId))) <= 15 then
            nearbyList[#nearbyList+1] = playerId
        end
    end
    for i = 1, #nearbyList do
        TriggerClientEvent('jim-npcservice:client:leavePlane', nearbyList[i], exit)
    end
end)

local helipadUse = {}
for k, v in pairs(Config.Helipads) do helipadUse[v.start] = false end

RegisterNetEvent("jim-npcservice:server:heliPadUse", function(helipad, vehicle)
    if Config.Debug then print("^5Debug^7: ^3"..helipad.." ^2Toggling useage '^6"..tostring(vehicle).."^7'") end
    helipadUse[helipad] = vehicle
end)

RegisterNetEvent("jim-npcservice:server:leaveHeli", function(coords, exit) local src = source
    if Config.Debug then print("^5Debug^7: ^3Forcing ^2Players to leave heli: '^6"..coords.."^7'") end
    local nearbyList = {}
    for _, playerId in ipairs(GetPlayers()) do
        if #(coords - GetEntityCoords(GetPlayerPed(playerId))) <= 15 then
            nearbyList[#nearbyList+1] = playerId
        end
    end
    for i = 1, #nearbyList do
        TriggerClientEvent('jim-npcservice:client:leaveHeli', nearbyList[i], exit)
    end
end)

-- Callbacks
if Config.Callback == "qb" then
    createCallback('jim-npcservice:server:airportUse', function(_, cb) cb(airPortUse) end)
    createCallback('jim-npcservice:server:heliPadUse',function(_, cb) cb(helipadUse) end)
    createCallback('jim-npcservice:server:getBank',function(source, cb) cb(Core.Functions.GetPlayer(source).Functions.GetMoney("bank")) end)

elseif Config.Callback == "ox" then
    createCallback('jim-npcservice:server:airportUse', function(_) return airPortUse end)
	createCallback('jim-npcservice:server:heliPadUse', function(_) return helipadUse end)
    createCallback('jim-npcservice:server:getBank', function(source) return getMoney(source) end)
end

function getMoney(source) local cash = 0 local src = source
    if Config.money == "qb" then
        cash = Core.Functions.GetPlayer(src).Functions.GetMoney(Config.charge)
    elseif Config.money == "ox" then
        if Config.charge == "cash" then
            cash = exports.ox_inventory:Search('count', "money")
        elseif Config.charge == "bank" then
            -- no default support for ox_lib bank
            -- Add your event for charging the bank balance amount here
        end
    elseif Config.money == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if Config.charge == "cash" then
            cash = xPlayer.getMoney()
        elseif Config.charge == "bank" then
            cash = xPlayer.getAccount(Config.charge).money
        end
    end
    return cash
end

RegisterNetEvent("jim-npcservice:server:ChargePlayer", function(cost) local src = source
    if Config.Debug then print("^5Debug^7: ^2Charging ^2Player: '^6"..cost.."^7'") end
    if Config.money == "qb" then
        Core.Functions.GetPlayer(src).Functions.RemoveMoney(Config.charge, cost)
    elseif Config.money == "ox" then
        if Config.charge == "cash" then
            exports.ox_inventory:RemoveItem(src, "money", cost)
        elseif Config.charge == "bank" then
            -- no default support for ox_lib bank
            -- Add your event for getting the bank balance amount here
        end
    elseif Config.money == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if Config.charge == "cash" then
            xPlayer.removeMoney(cost, "Fare")
        elseif Config.charge == "bank" then
            xPlayer.removeAccountMoney(cost, "Fare")
        end
    end
end)