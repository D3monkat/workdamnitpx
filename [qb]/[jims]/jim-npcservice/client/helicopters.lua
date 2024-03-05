if Config.heliEnable then

local Peds, heliRoute, landHelper = {}, {}, nil

heliState = {
	startDest = "",
	endDest = "",

	waiting = false,
	taxi = false,
	inair = false,
	landing = false,
	landed = false,
}

CreateThread(function()
    for _, v in pairs(Config.Helipads) do
        makeBlip({coords = v.coords, sprite = 64, name = "BLIP_64", col = 4 })
        Peds[#Peds+1] = makePed("S_M_M_Pilot_01", v.coords, true, true, nil, nil, false)
        local thisPed = Peds[#Peds]
        FreezeEntityPosition(thisPed, true)
        createEntityTarget(thisPed,
        {
            {   icon = "fas fa-helicopter",
                label = Loc[Config.Lan].notify["booking"],
                action = function()
                    local heliPads = triggerCallback("jim-npcservice:server:heliPadUse")
                    if heliPads[v.start] ~= false then
                        if Config.HeliCost > 0 then
                            local bank = triggerCallback("jim-npcservice:server:getBank")
                            if bank >= Config.HeliCost then
                                TriggerServerEvent("jim-npcservice:server:ChargePlayer", Config.HeliCost)
                            else
                                triggerNotify(Loc[Config.Lan].notify["heliname"], Loc[Config.Lan].notify["afford"])
                                return
                            end
                        end
                    else
                        if GetResourceState("jim-talktonpc"):find("start") then
                            exports["jim-talktonpc"]:createCam(thisPed, true, "generic", true)
                        end
                        makeHeliList(v.coords)
                    end
                end,
            }
        }, 2.5)
    end
end)

function makeHeliList(startDest)
    -- TODO: add the ability for others to join the current flight..somehow
    local startDest = GetNameOfZone(startDest.xyz)
    local Menu = {}
    for _, v in pairs({"DESRT", "AIRP", (Config.CayoPericoHeli and "ISHEIST" or nil)}) do
        if startDest ~= v then
            Menu[#Menu+1] = { header = GetLabelText(v),
            icon = radarTable[64],
                onSelect = function()
                    heliState.startDest = startDest
                    heliState.endDest = v
                    if Config.HeliCost > 0 then
                        local bank = triggerCallback("jim-npcservice:server:getBank")
                        if bank >= Config.HeliCost then
                            TriggerServerEvent("jim-npcservice:server:ChargePlayer", Config.HeliCost)
                        else
                            triggerNotify(Loc[Config.Lan].notify["heliname"], Loc[Config.Lan].notify["afford"])
                            return
                        end
                    end
                    startHeli()
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

function startHeli()
    getHeli()
    TriggerServerEvent("jim-npcservice:server:heliPadUse", heliState.startDest, VehToNet(vehicle))

    SetVehicleDoorsLockedForAllPlayers(vehicle, true)
    SetVehicleDoorsLocked(vehicle, 10)
    TriggerEvent("jim-npcservice:client:enterHeli", VehToNet(vehicle))

    while GetVehiclePedIsIn(PlayerPedId(), false) ~= vehicle do Wait(1000) end
    --Timer to take off
    local timer = GetGameTimer()
    local time = (120 * 1000)
    triggerNotify(Loc[Config.Lan].notify["heliname"], Loc[Config.Lan].notify["waittakeoff"])
    if Config.Debug then print("^5Debug^7: ^2Starting timer to leave^7") end
    while (GetGameTimer() - timer < time) and not heliState.drving and DoesEntityExist(vehicle) do
        drawText(64, {
            Loc[Config.Lan].menu["takeoff"].." "..secondsToTime(math.round((time - (GetGameTimer() - timer)) / 1000))},
            "r"
        )
        Wait(1000)
    end
    heliState.taxi = true
    local tempBlip = nil
    CreateThread(function()
        while not heliState.landed do
            drawText(64, {
                Loc[Config.Lan].menu["dest"].." "..GetLabelText(heliState.endDest),
                Loc[Config.Lan].menu["current"].." "..GetLabelText(GetNameOfZone(GetEntityCoords(vehicle)))},
                "r"
            )
            Wait(1000)
        end
        hideText()
    end)
    if heliState.taxi then -- Taxiing route
        SetVehicleEngineOn(vehicle, true, false, false)

        heliState.taxi = false
        heliState.inair = true
    end

    if heliState.inair then -- Mid air routes
        triggerNotify(Loc[Config.Lan].notify["heliname"], Loc[Config.Lan].notify["planetake"])
        heliRoute.Route[#heliRoute.Route+1] = vec4(heliRoute.Pad.x, heliRoute.Pad.y, heliRoute.Pad.z, 0.0)
        local takeOffCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, 1000.0, 400.0)
        TaskHeliMission(ped, vehicle, 0, 0, takeOffCoords.x, takeOffCoords.y, takeOffCoords.z, 4, 1.0, 10.0, GetEntityHeading(vehicle), 0, -1.0, 0, 14)
        Wait(5000)
        TriggerServerEvent("jim-npcservice:server:heliPadUse", heliState.startDest, false)

        landHelper = makePed("S_M_M_Pilot_01", vec4(0,0,0,0), true, true, nil, nil, true)
        for i = 1, #heliRoute.Route do
            if Config.Debug then tempBlip = makeBlip({coords = heliRoute.Route[i], sprite = 162, col = 1, name = "Route Loc "..i}) end
            SetEntityVisible(landHelper, false, 0)
            FreezeEntityPosition(landHelper, true)
            while #(GetEntityCoords(vehicle).xy - heliRoute.Route[i].xy) >= 100.0 do
                SetEntityCoords(landHelper, heliRoute.Route[i].xyz) -- update route
                TaskHeliChase(ped, landHelper, 0.0, 0.0, 0.0) -- This appears to follow the route better, by spawning a ped and "chasing" it
                SetPedKeepTask(ped, true)
                Wait(2000)
            end
            if Config.Debug then
                triggerNotify(Loc[Config.Lan].notify["heliname"], "Route coord "..i.." Reached")
                RemoveBlip(tempBlip)
            end
        end
        heliState.inair = false
        heliState.landing = true
    end

    if heliState.landing then -- Landing stuff
        triggerNotify(Loc[Config.Lan].notify["heliname"], Loc[Config.Lan].notify["startland"])
        TaskHeliMission(ped, vehicle, 0, 0, heliRoute.Pad.x, heliRoute.Pad.y, 100.0, 20, 50.0, 0.0, GetEntityHeading(vehicle), -1, -1, -1, 0)
        SetPedKeepTask(ped, true)
        while IsEntityInAir(vehicle) == 1 do Wait(20) end
        heliState.landing = false
        heliState.landed = true
        if Config.Debug then RemoveBlip(tempBlip) end
    end

    if heliState.landed then -- What to do when heli is classed as landed/on runway
        triggerNotify(Loc[Config.Lan].notify["heliname"], Loc[Config.Lan].notify["arriveddest"], "success")
        --ClearPedTasks(ped)

        SetVehicleEngineOn(vehicle, false, false, true)

        Wait(2000)

        TriggerServerEvent("jim-npcservice:server:leaveHeli", GetEntityCoords(vehicle), heliRoute.Exit)
        Wait(3000)
        if heliState.endDest == "AIRP" then removeHeli() else heliLeave() end
    end
end

function getHeli()
    local spawnCoord = nil local spawnVeh = nil
    if heliState.startDest == "AIRP" then -- FROM LOS SANTOS --
        if heliState.endDest == "DESRT" then -- PERFECT
            heliRoute.Route = {
                vec3(-1334.65, -2710.27, 108.44),
                vec3(-893.68, -2300.17, 89.0),
                vec3(-378.95, -1883.3, 194.35),
                vec3(214.3, -1208.47, 208.2),
                vec3(722.31, -245.3, 216.39),
                vec3(1406.38, 741.44, 216.04),
                vec3(1729.97, 1733.96, 222.81),
                vec3(1985.45, 2608.18, 197.2),
                vec3(1953.71, 3077.55, 155.43),
            }
        end
        if heliState.endDest == "ISHEIST" then  -- PERFECT
            heliRoute.Route = {
                vec3(-1134.85, -2741.84, 127.41),
                vec3(3740.66, -4416.08, 174.77),
                vec3(4429.8, -4441.24, 79.27),
            }
        end
    elseif heliState.startDest == "DESRT" then -- FROM SANDY SHORES --
        if heliState.endDest == "AIRP" then -- works
            heliRoute.Route = {
                vec3(1644.12, 2983.37, 104.41),
                vec3(1683.77, 2630.13, 186.64),
                vec3(1077.33, 2071.2, 335.45),
                vec3(299.63, 1911.08, 395.24),
                vec3(-824.33, 1717.96, 439.51),
                vec3(-740.62, 874.63, 374.49),
                vec3(-607.0, 33.16, 274.5),
                vec3(-577.31, -897.09, 294.51),
                vec3(-836.12, -2095.08, 232.6),
                vec3(-1145.99, -2864.62, 13.95)
            }
        end
        if heliState.endDest == "ISHEIST" then -- Perfect
            heliRoute.Route = {
                vec3(728.53, 2889.68, 290.14),
                vec3(-637.22, 2784.01, 330.17),
                vec3(-1882.96, 2582.68, 264.34),
                vec3(-3433.92, 2050.95, 301.7),
                vec3(-3068.32, 49.66, 81.56),
                vec3(-2459.37, -388.17, 52.99),
                vec3(-1841.72, -1019.47, 60.69),
                vec3(-1292.62, -1826.31, 105.0),
                vec3(3740.66, -4416.08, 174.77),
                vec3(4429.8, -4441.24, 79.27),
            }
        end
    elseif heliState.startDest == "ISHEIST" then -- FROM CAYO PERICO --
        if heliState.endDest == "AIRP" then -- PERFECT WITH VELUM2
            heliRoute.Route = {
                vec3(4429.8, -4441.24, 79.27),
                vec3(3740.66, -4416.08, 174.77),
                vec3(-1134.85, -2741.84, 127.41),
            }
        end
        if heliState.endDest == "DESRT" then
            heliRoute.Route = {
                vec3(4429.8, -4441.24, 79.27),
                vec3(3740.66, -4416.08, 174.77),
                vec3(-1292.62, -1826.31, 105.0),
                vec3(-1841.72, -1019.47, 60.69),
                vec3(-2459.37, -388.17, 52.99),
                vec3(-3068.32, 49.66, 81.56),
                vec3(-3433.92, 2050.95, 301.7),
                vec3(-1882.96, 2582.68, 264.34),
                vec3(-637.22, 2784.01, 330.17),
                vec3(728.53, 2889.68, 290.14),
            }
        end
    end

    heliRoute.Pad = Config.HelipadSpawn[heliState.endDest].Pad
    heliRoute.Exit = Config.HelipadSpawn[heliState.endDest].Exit

    --TODO: Check runway for vehicles instead of deleting
    ClearAreaOfEverything(Config.HelipadSpawn[heliState.startDest].Spawn, 1500, false, false, false, false, false)
    vehicle = makeVeh(Config.HelipadSpawn[heliState.startDest].Model, Config.HelipadSpawn[heliState.startDest].Spawn)
    pushVehicle(vehicle)
    ped = makePed("S_M_M_Pilot_01", Config.HelipadSpawn[heliState.startDest].Spawn, false, true, nil, nil)
    SetPedCanBeDraggedOut(ped, false)
    if vehicle and GetResourceState(Config.Fuel):find("start") then
        exports[Config.Fuel]:SetFuel(vehicle, 100.0)
    end
    SetPedIntoVehicle(ped, vehicle, -1)
    SetDriverAbility(ped, 1.0)
    SetPedCanBeDraggedOut(ped, false)
end


RegisterNetEvent("jim-npcservice:client:enterHeli", function(veh)
    local veh = NetToVeh(veh)
    DoScreenFadeOut(1500)
    while not IsScreenFadedOut() do Wait(0) end

    local seats = GetVehicleModelNumberOfSeats(GetEntityModel(veh)) - 1
    local pickSeat = 1
    while GetPedInVehicleSeat(veh, pickSeat) ~= 0 do
        pickSeat += 1
        if pickSeat > seats then
            triggerNotify(nil, Loc[Config.Lan].notify["heliname"], Loc[Config.Lan].notify["full"], "success")
            break
        end
        Wait(0)
    end
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, pickSeat)

    Wait(1000)
    DoScreenFadeIn(1000)
end)

RegisterNetEvent("jim-npcservice:client:leaveHeli", function(exit)
    DoScreenFadeOut(1500)
    while not IsScreenFadedOut() do Wait(0) end
    SetEntityCoords(PlayerPedId(), exit)
    SetEntityHeading(PlayerPedId(), exit)
    Wait(1000)
    DoScreenFadeIn(2000)
end)

function heliLeave()
    if Config.Debug then print("^5Debug^7: ^3heliLeave^7()") end
    hideText()
    TriggerServerEvent("jim-npcservice:server:leaveHeli", VehToNet(vehicle), GetEntityCoords(vehicle))
    Wait(5000)

    TaskHeliMission(ped, vehicle, 0, 0, 0, 0, 1000.0, 20, 50.0, 0.0, GetEntityHeading(vehicle), -1, -1, -1, 0)

    CreateThread(function()
        local timeout = 30000
        while DoesEntityExist(vehicle) and timeout > 0 do
            timeout -= 1000
            Wait(1000)
        end
        if vehicle then
            removeHeli()
        end
    end)
end

function removeHeli()
    if Config.Debug then print("^5Debug^7: ^3removeHeli^7()") end
    DeletePed(ped)
    DeleteVehicle(vehicle)
    DeletePed(landHelper)
    landHelper = nil
    ped = nil vehicle = nil
    heliRoute = {}
    heliState = {
        startDest = "",
        endDest = "",

        waiting = false,
        taxi = false,
        inair = false,
        landing = false,
        landed = false,
    }
    Peds, heliRoute, landHelper = {}, {}, nil
end

function makeList(startDest)
    -- TODO: add the ability for others to join the current flight..somehow
    local startDest = GetNameOfZone(startDest.xyz)
    local Menu = {}
    for _, v in pairs({"DESRT", "AIRP", (Config.CayoPericoPort and "ISHEIST" or nil)}) do
        if startDest ~= v then
            Menu[#Menu+1] = { header = GetLabelText(v),
            icon = radarTable[90],
                onSelect = function()
                    heliState.startDest = startDest
                    heliState.endDest = v
                    startHeli()
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

AddEventHandler('onResourceStop', function(r)
    if r ~= GetCurrentResourceName() then return end
    if DoesEntityExist(ped) then DeletePed(ped) end
    if DoesEntityExist(landHelper) then DeletePed(landHelper) end
    if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
    for k in pairs(Peds) do DeletePed(Peds[k]) end
    hideText()
end)

end