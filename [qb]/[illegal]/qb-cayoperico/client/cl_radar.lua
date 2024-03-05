local IslandEntry = CircleZone:Create(vector3(4819.56, -5032.33, 38.6), 1800.0, {name="cayo_zone_entry", debugPoly=false})
local IslandExit = CircleZone:Create(vector3(4819.56, -5032.33, 38.6), 1200.0, {name="cayo_zone_exit", debugPoly=false})

local alertIslanders = function()
    if LocalPlayer.state.isLoggedIn and PlayerJob.name ~= "cayoperico" then
        local ped = PlayerPedId()
        if GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then -- ONLY DRIVER ALERTS COPS
            TriggerServerEvent('qb-cayoperico:server:callIslanders', GetEntityCoords(ped))
        end
    end
end

local alertCops = function()
    if LocalPlayer.state.isLoggedIn and PlayerJob.name == "cayoperico" then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        local plate = GetVehicleNumberPlateText(veh)
        if (plate == "CAYODODO") then -- DODO Plane
            if GetPedInVehicleSeat(veh, -1) == ped then -- ONLY DRIVER ALERTS COPS
                local chance = math.random(1, 100)
                if chance <= 70 then
                    -- ALERT COPS FOR PLANE
                    TriggerServerEvent("qb-cayoperico:server:callCops", "plane", GetEntityCoords(ped))
                end
            end
        elseif (plate == "CAYOBOAT") then -- LONGFIN BOAT
            if GetPedInVehicleSeat(veh, -1) == ped then -- ONLY DRIVER ALERTS COPS
                local chance = math.random(1, 100)
                if chance <= 40 then
                    -- ALERT COPS FOR BOAT
                    TriggerServerEvent("qb-cayoperico:server:callCops", "boat", GetEntityCoords(ped))
                end
            end
        end
    end
end

IslandEntry:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
	    alertIslanders()
    end
end)

IslandExit:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if not isPointInside then
        alertCops()
    end
end)

RegisterNetEvent('qb-cayoperico:client:callCops', function(type, coords)
    local transport 
    if type == "boat" then
        transport = "Longfin speedboat"
    else
        transport = "Seaplane"
    end 
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerServerEvent('police:server:policeAlert', 'Smuggling Alert') -- Regular QBCore
        
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 66)
    SetBlipColour(blip, 4)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 1.0)
    SetBlipFlashes(blip, true)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("911: Suspicious Activity")
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        if transG == 0 then
            SetBlipSprite(blip, 2)
            RemoveBlip(blip)
            return
        end
    end
end)

RegisterNetEvent('qb-cayoperico:client:callIslanders', function(coords)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerEvent('chatMessage', "RADAR", "warning", "Someone is entering Cayo Perico")

    local transG = 120
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 9)
    SetBlipColour(blip, 4)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 0.4)
    SetBlipFlashes(blip, true)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Cayo Perico: Radar Systems")
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        if transG == 0 then
            SetBlipSprite(blip, 2)
            RemoveBlip(blip)
            return
        end
    end
end)
