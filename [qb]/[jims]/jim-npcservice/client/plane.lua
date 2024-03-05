if Config.planeEnable then

local Peds, planeRoute, landHelper = {}, {}, nil

planeState = {
	startDest = "",
	endDest = "",

	waiting = false,
	taxi = false,
	inair = false,
	landing = false,
	landed = false,
}

CreateThread(function()
    for _, v in pairs(Config.Airports) do
        makeBlip({coords = v.coords, sprite = 90, name = "BLIP_90" })
        Peds[#Peds+1] = makePed("S_M_M_Pilot_01", v.coords, true, true, nil, nil, false)
        local thisPed = Peds[#Peds]
        FreezeEntityPosition(thisPed, true)
        createEntityTarget(thisPed, {
            {   icon = "fas fa-plane-departure",
                label = Loc[Config.Lan].notify["booking"],
                action = function()
                    local airports = triggerCallback("jim-npcservice:server:airportUse")
                    if airports[v.start] ~= false then
                        if Config.PlaneCost > 0 then
                            local bank = triggerCallback("jim-npcservice:server:getBank")
                            if bank >= Config.PlaneCost then
                                TriggerServerEvent("jim-npcservice:server:ChargePlayer", Config.PlaneCost)
                            else
                                triggerNotify(Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["afford"])
                                return
                            end
                        end
                        TriggerEvent("jim-npcservice:client:enterPlane", airports[v.start])
                    else
                        if GetResourceState("jim-talktonpc"):find("start") then
                            exports["jim-talktonpc"]:createCam(thisPed, true, "generic", true)
                        end
                        makeList(v.coords)
                    end
                end,
            } }, 2.5)
    end
end)

function makeList(startDest)
    local startDest = GetNameOfZone(startDest.xyz)
    local Menu = {}
    for _, v in pairs({"DESRT", "AIRP", (Config.CayoPericoPort and "ISHEIST" or nil)}) do
        if startDest ~= v then
            Menu[#Menu+1] = { header = GetLabelText(v),
            icon = radarTable[90],
                onSelect = function()
                    planeState.startDest = startDest
                    planeState.endDest = v
                    if Config.PlaneCost > 0 then
                        local bank = triggerCallback("jim-npcservice:server:getBank")
                        if bank >= Config.PlaneCost then
                            TriggerServerEvent("jim-npcservice:server:ChargePlayer", Config.PlaneCost)
                        else
                            triggerNotify(Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["afford"])
                            return
                        end
                    end
                    startPlane()
                end,
            }
        end
    end
    openMenu(Menu, {
        header = Loc[Config.Lan].notify["booking"],
        headertxt = Loc[Config.Lan].menu["choose"],
        canClose = true,
        onExit = function() end,
    })
end

function startPlane()
    if not getPlane() then return end
    TriggerServerEvent("jim-npcservice:server:airportUse", planeState.startDest, VehToNet(vehicle))

    SetVehicleDoorsLockedForAllPlayers(vehicle, true)
    SetVehicleDoorsLocked(vehicle, 10)
    TriggerEvent("jim-npcservice:client:enterPlane", VehToNet(vehicle))

    while GetVehiclePedIsIn(PlayerPedId(), false) ~= vehicle do Wait(1000) end
    --Timer to take off
    local timer = GetGameTimer()
    local time = (120 * 1000)
    triggerNotify(Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["waittakeoff"])
    if Config.Debug then print("^5Debug^7: ^2Starting timer to leave^7") end
    while (GetGameTimer() - timer < time) and not planeState.drving and DoesEntityExist(vehicle) do
        drawText(90, {
            Loc[Config.Lan].menu["takeoff"].." "..secondsToTime(math.round((time - (GetGameTimer() - timer)) / 1000))},
            "r"
        )
        Wait(1000)
    end
    planeState.taxi = true
    local tempBlip = nil
    CreateThread(function()
        while not planeState.landed do
            drawText(90, {
                Loc[Config.Lan].menu["dest"].." "..GetLabelText(planeState.endDest),
                Loc[Config.Lan].menu["current"].." "..GetLabelText(GetNameOfZone(GetEntityCoords(vehicle)))},
                "r"
            )
            Wait(1000)
        end
        hideText()
    end)
    if planeState.taxi then -- Taxiing route
        triggerNotify(Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["planetaxi"]) -- tell players taxiing started
        for i = 1, #planeRoute.Taxi do
            TaskVehicleDriveToCoordLongrange(ped, vehicle, planeRoute.Taxi[i].xyz, GetVehicleModelMaxSpeed("nimbus") / (i == 1 and 10 or 1), 16777216, 0.0)
            Wait(500)
            SetPedKeepTask(ped, true)
            if Config.Debug then tempBlip = makeBlip({coords = planeRoute.Taxi[i], sprite = 162, col = 1, name = "Taxi Loc "..i}) end
            while #(GetEntityCoords(vehicle).xy - planeRoute.Taxi[i].xy) > 25.0 do Wait(50) end
            if Config.Debug then
                triggerNotify(Loc[Config.Lan].notify["planename"], "Taxi coord "..i.." Reached")
                RemoveBlip(tempBlip)
            end
        end
        planeState.taxi = false
        planeState.inair = true
    end

    if planeState.inair then -- Mid air routes
        triggerNotify(Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["planetake"])
        planeRoute.Route[#planeRoute.Route+1] = vec4(planeRoute.Runway[1].x, planeRoute.Runway[1].y, planeRoute.Runway[1].z, 0.0)
        local takeOffCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1000.0, 400.0)
        TaskPlaneMission(ped, vehicle, 0, 0, takeOffCoords.x, takeOffCoords.y, takeOffCoords.z, 4, 100.0, 0, GetEntityHeading(vehicle), 2000.0, 400.0)
        Wait(5000)
        SetVehicleLandingGear(vehicle, 1)
        TriggerServerEvent("jim-npcservice:server:airportUse", planeState.startDest, false)
        for i = 1, #planeRoute.Route do
            if Config.Debug then tempBlip = makeBlip({coords = planeRoute.Route[i], sprite = 162, col = 1, name = "Route Loc "..i}) end
            landHelper = makePed("S_M_M_Pilot_01", planeRoute.Route[i], true, true, nil, nil, true)
            SetEntityVisible(landHelper, false, 0)
            FreezeEntityPosition(landHelper, true)

            local moveType = ""
            local prevMoveType = ""
            while #(GetEntityCoords(vehicle).xy - planeRoute.Route[i].xy) >= 400.0 do
                if IsPedHeadingTowardsPosition(ped, planeRoute.Route[i], 15.0) then moveType = "mission"
                else moveType = "chase" end
                if moveType == "mission" and prevMoveType ~= "mission" then prevMoveType = "mission"
                    TaskPlaneMission(ped, vehicle, 0, 0, planeRoute.Route[i].x, planeRoute.Route[i].y, planeRoute.Route[i].z, 4, 100.0, 0, GetEntityHeading(vehicle), 2000.0, 400.0)
                elseif moveType == "chase" and prevMoveType ~= "chase" then prevMoveType = "chase"
                    TaskPlaneChase(ped, landHelper, 0.0, 0.0, 0.0) -- This appears to follow the route better, by spawning a ped and "chasing" it
                end
                SetEntityCoords(landHelper, planeRoute.Route[i].xyz) -- update route
                SetPedKeepTask(ped, true)
                Wait(2000)
            end
            if Config.Debug then
                triggerNotify(Loc[Config.Lan].notify["planename"], "Route coord "..i.." Reached")
                DeletePed(landHelper) landHelper = nil
                RemoveBlip(tempBlip)
            end
        end
        planeState.inair = false
        planeState.landing = true
    end

    if planeState.landing then -- Landing stuff
        CreateThread(function() -- Delay Retracting wheels
            Wait(10000)
            SetVehicleLandingGear(vehicle, 0)
        end)
        triggerNotify(Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["startland"])
        TaskPlaneLand(ped, vehicle, planeRoute.Runway[1].x, planeRoute.Runway[1].y, planeRoute.Runway[1].z, planeRoute.Runway[2].x, planeRoute.Runway[2].y, planeRoute.Runway[2].z)
        SetPedKeepTask(ped, true)
        if Config.Debug then tempBlip = makeBlip({coords = planeRoute.Runway[2], sprite = 162, col = 1, name = "Stop Loc"}) end
        while (#(GetEntityCoords(vehicle).xy - planeRoute.Runway[2].xy) >= 100.0) do Wait(20) end
        planeState.landing = false
        planeState.landed = true
        if Config.Debug then RemoveBlip(tempBlip) end
    end

    if planeState.landed then -- What to do when plane is classed as landed/on runway
        triggerNotify(Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["arriveddest"], "success")
        ClearPedTasks(ped)
        TaskVehicleTempAction(ped, vehicle, 27, -1)
        SetVehicleHandbrake(vehicle, true)
        SetVehicleEngineOn(vehicle, false, true, true)

        while GetEntitySpeed(vehicle) >= 20 do Wait(100) end

        TriggerServerEvent("jim-npcservice:server:leavePlane", GetEntityCoords(vehicle), planeRoute.Exit)
    end
end

function getPlane()
    local spawnCoord = nil local spawnVeh = nil
    if planeState.startDest == "AIRP" then -- FROM LOS SANTOS --
        if planeState.endDest == "DESRT" then -- PERFECT
            planeRoute.Route = {
                vector3(-3387.54, -1934.99, 400.0),
                vector3(-4886.59, -161.45, 400.0),
                vector3(-3519.92, 2013.84, 400.0),
                vector3(-27.09, 2784.86, 150.0)
            }
        end
        if planeState.endDest == "ISHEIST" then  -- PERFECT
            planeRoute.Route = {
                vector3(-4656.11, -4000.53, 184.04),
                vector3(-1984.83, -6987.62, 209.97),

                vector3(2715.03, -5136.3, 204.83),
                vector3(3544.36, -4839.09, 77.41)
            }
        end
    elseif planeState.startDest == "DESRT" then -- FROM SANDY SHORES --
        if planeState.endDest == "AIRP" then -- works
            planeRoute.Route = {
                vector3(-27.09, 2784.86, 400.0),
                vector3(-3519.92, 2013.84, 400.0),
                vector3(-4886.59, -161.45, 400.0),
                vector3(-3995.72, -5285.52, 256.06),
                vector3(-2174.4, -3802.93, 200.81),
            }
        end
        if planeState.endDest == "ISHEIST" then -- Perfect
            planeRoute.Route = {
                vector3(-27.09, 2784.86, 400.0),
                vector3(-3519.92, 2013.84, 400.0),
                vector3(-4886.59, -161.45, 400.0),
                vector3(-1984.83, -6987.62, 209.97),

                vector3(2715.03, -5136.3, 204.83),
                vector3(3544.36, -4839.09, 77.41)
            }
        end
    elseif planeState.startDest == "ISHEIST" then -- FROM CAYO PERICO --
        if planeState.endDest == "AIRP" then -- PERFECT WITH VELUM2
            planeRoute.Route = {
                vector3(-2008.64, -6500.48, 200.81),
                vector3(-2174.4, -3802.93, 200.81)
            }
        end
        if planeState.endDest == "DESRT" then
            planeRoute.Route = {
                vector3(3544.36, -4839.09, 77.41),
                vector3(2715.03, -5136.3, 204.83),
                vector3(-1984.83, -6987.62, 209.97),
                vector3(-4886.59, -161.45, 400.0),
                vector3(-3519.92, 2013.84, 400.0),
                vector3(-27.09, 2784.86, 400.0),
            }
        end
    end

    planeRoute.Taxi = Config.AirportSpawn[planeState.startDest].Taxi
    planeRoute.Runway = Config.AirportSpawn[planeState.endDest].Runway
    planeRoute.Exit = Config.AirportSpawn[planeState.endDest].Exit

    --TODO: Check runway for vehicles instead of deleting
    if checkRunway(planeRoute.Taxi) then
        triggerNotify(nil, Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["full"], "success")
        removePlane()
        return false
    end
    ClearAreaOfEverything(Config.AirportSpawn[planeState.startDest].Spawn, 1500, false, false, false, false, false)
    vehicle = makeVeh(Config.AirportSpawn[planeState.startDest].Model, Config.AirportSpawn[planeState.startDest].Spawn)
    pushVehicle(vehicle)
    ped = makePed("S_M_M_Pilot_01", Config.AirportSpawn[planeState.startDest].Spawn, false, true, nil, nil)
    SetPedCanBeDraggedOut(ped, false)
    if vehicle and GetResourceState(Config.Fuel):find("start") then
        exports[Config.Fuel]:SetFuel(vehicle, 100.0)
    end
    SetPedIntoVehicle(ped, vehicle, -1)
    SetDriverAbility(ped, 1.0)
    SetPedCanBeDraggedOut(ped, false)
    return true
end

function checkRunway(runway)
    local vehs = GetGamePool('CVehicle')
    local peds = GetGamePool('CPed')
    local blocked = false
    for k, v in pairs(runway) do
        for i = 1, #vehs do
            if #(GetEntityCoords(vehs[i]) - v) <= 200.0 then
                if not IsPedAPlayer(GetPedInVehicleSeat(vehs[i], -1)) then
                    DeleteVehicle(vehs[i])
                else
                    blocked = true
                    break
                end
            end
        end
        for i = 1, #peds do
            if #(GetEntityCoords(peds[i]) - v) <= 20.0 then
                if not IsPedAPlayer(peds[i]) then
                    blocked = true
                else
                    break
                end
            end
        end
    end
end

RegisterNetEvent("jim-npcservice:client:enterPlane", function(veh)
    local veh = NetToVeh(veh)
    DoScreenFadeOut(1500)
    while not IsScreenFadedOut() do Wait(0) end

    local seats = GetVehicleModelNumberOfSeats(GetEntityModel(veh)) - 1
    local pickSeat = 1
    while GetPedInVehicleSeat(veh, pickSeat) ~= 0 do
        pickSeat += 1
        if pickSeat > seats then
            triggerNotify(nil, Loc[Config.Lan].notify["planename"], Loc[Config.Lan].notify["full"], "success")
            break
        end
        Wait(0)
    end
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, pickSeat)

    Wait(1000)
    DoScreenFadeIn(1000)
end)

RegisterNetEvent("jim-npcservice:client:leavePlane", function(exit)
    DoScreenFadeOut(1500)
    while not IsScreenFadedOut() do Wait(0) end
    if vehicle then removePlane() end
    SetEntityCoords(PlayerPedId(), exit)
    SetEntityHeading(PlayerPedId(), exit)
    Wait(1000)
    DoScreenFadeIn(2000)
end)

function removePlane()
    if Config.Debug then print("^5Debug^7: ^3removePlane^7()") end
    DeletePed(ped)
    DeleteVehicle(vehicle)
    ped = nil vehicle = nil
    planeState = {
        startDest = "",
        endDest = "",

        waiting = false,
        taxi = false,
        inair = false,
        landing = false,
        landed = false,
    }
    Peds, planeRoute, landHelper = {}, {}, nil
end

AddEventHandler('onResourceStop', function(r)
    if r ~= GetCurrentResourceName() then return end
    if DoesEntityExist(ped) then DeletePed(ped) end
    if DoesEntityExist(landHelper) then DeletePed(landHelper) end
    if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
    for k in pairs(Peds) do DeletePed(Peds[k]) end
    hideText()
end)

end