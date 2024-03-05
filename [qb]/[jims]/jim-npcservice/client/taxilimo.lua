if Config.taxiEnable then
local cost, taxiLoop, calc, coords, callCoords, callBlip = 0, false, false, nil, nil, nil

--[[ FIRST STEP OF SCRIPT ]]--
function callTaxi(type)
    if not vehicle then -- if no taxi exists currently, set all the default information and show notification
        taxiState = {
            type = "taxi",

            arriving = false,
            cancelled = false,
            arrived = false,
            driving = false,
            hurry = false,
            leftEarly = false,
            trashed = false,
            noCash = false,
            stopped = false,
            leaving = false,
            stoppedEarly = false,
            skip = false,
        }
        taxiState.type = type
        triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["onitsway"], "success")
        PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
    else
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
        return
    end
    -- Quick phone animation
    if Config.CellAnim then
        CreateThread(function()
            ExecuteCommand("e phone")
            Wait(2000)
            ExecuteCommand("e c")
        end)
    end

    callCoords = GetEntityCoords(PlayerPedId()) -- store the location the player called from
    callBlip = makeBlip({ coords = callCoords, sprite = 161, name = Loc[Config.Lan].blip["pickup"], col = 4, scale = 0.8 })
    --Get location of best spawn with correct road direction
    local newSpawnCoords = nil
    for _, v in pairsByKeys(getAllBlips()) do if #(GetEntityCoords(PlayerPedId()) - GetBlipCoords(v)) >= 300 then newSpawnCoords = GetBlipCoords(v) break end end
    local _, tempLoc, heading = GetClosestVehicleNodeWithHeading(newSpawnCoords.x, newSpawnCoords.y, newSpawnCoords.z, 1, 3.0, 0)

    -- Create Vehicle and Ped
    vehicle = makeVeh(type == "stretch" and Config.Limos[math.random(1, #Config.Limos)] or Config.Taxis[math.random(1, #Config.Taxis)], vec4(tempLoc.x, tempLoc.y, tempLoc.z, heading))
    ped = makePed(type == "stretch" and Config.LimoPeds[math.random(1, #Config.LimoPeds)] or Config.TaxiPeds[math.random(1, #Config.TaxiPeds)], vector4(tempLoc.x, tempLoc.y, tempLoc.z, 0.0), false, true, nil, nil)
    SetPedIntoVehicle(ped, vehicle, -1)

    if math.random(1,2) == 1 then -- Chance for taxi to already have passengers
        passengerPed = makePed(Config.TaxiPeds[math.random(1, #Config.TaxiPeds)], vector4(tempLoc.x, tempLoc.y, tempLoc.z, 0.0), false, true, nil, nil)
        SetPedIntoVehicle(passengerPed, vehicle, 1)
    end

    Wait(1000)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleDoorsLocked(vehicle, 0)
    SetVehicleMod(vehicle, 13, (GetNumVehicleMods(vehicle, 13) - 2), nil)
    SetVehicleMod(vehicle, 15, (GetNumVehicleMods(vehicle, 15) - 2), nil)
    SetVehicleMod(vehicle, 12, (GetNumVehicleMods(vehicle, 12) - 2), nil)
    SetVehicleStrong(vehicle, true)
    SetDriverAbility(ped, 1.0)
    SetPedCanBeDraggedOut(ped, false)

    pushVehicle(vehicle)

    callCoords = GetEntityCoords(PlayerPedId())
    TaskVehicleDriveToCoordLongrange(ped, vehicle, callCoords, 15.0, 524604, 10.0)

    taxiState.arriving = true

    -- Create taxi blip and route for tracking location
    makeEntityBlip({entity = vehicle, sprite = taxiState.type == "taxi" and 672 or 724, col = taxiState.type == "taxi" and 5 or 4, name = Loc[Config.Lan].blip[taxiState.type]})
    SetBlipRoute(GetBlipFromEntity(vehicle), true)
    SetBlipAsShortRange(GetBlipFromEntity(vehicle), false)
    taxiArriving()
end

--[[ WHAT THE TAXI DOES ON THE WAY/ARRIVED ]]--
function taxiArriving()
    CreateThread(function() -- loop to check if ped is driving or not
        Wait(1000)
        cam = nil
        createCam(taxiState.type, vehicle)
        local trackCoords, stuckTimer = 0, 1
        if Config.Debug then print("^5Debug^7: ^3STARTED ^2Check if player has left area BEFORE taxi has arrived ^7") end
        while (GetScriptTaskStatus(ped, 0x21D33957) ~= 7) and #(callCoords - GetEntityCoords(vehicle)) >= 15 and taxiState.arriving and not taxiState.cancelled do
            local vehCoords = GetEntityCoords(vehicle)
            local pedCoords = GetEntityCoords(PlayerPedId())
            if string.format("%.2f", #(vehCoords - trackCoords)) == "0.00" then
                if stuckTimer >= 30 then
                    triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].error["stuck"], "error")
                    cancelTaxi()
                    break
                end
                stuckTimer += 1
            else stuckTimer = 0 end
            trackCoords = vehCoords
            drawText(GetBlipSprite(GetBlipFromEntity(vehicle)),
            {Loc[Config.Lan].menu["estimate"].." "..getEstimatedTime(pedCoords, vehCoords)},
            "y")
            Wait(1000)
            SetBlipRotation(GetBlipFromEntity(vehicle), math.ceil(GetEntityHeading(vehicle)))
            if #(callCoords - pedCoords) >= 30.0 then
                if Config.Debug then print("^5Debug^7: ^3"..#(callCoords - pedCoords).." reached ^7cancelling taxi") end
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["toofar"], "error")

                cancelTaxi()
                break
            end
        end
        if Config.Debug then print("^5Debug^7: ^3BEFORE ^2loop finished^7") end
        if not taxiState.cancelled then taxiState.arriving = false taxiState.arrived = true end
        if taxiState.arrived then
            hideText()
            SetBlipFlashesAlternate(GetBlipFromEntity(vehicle), true)
            if DoesBlipExist(callBlip) then RemoveBlip(callBlip) callBlip = nil end
            CreateThread(function()
                if passengerPed then
                    TaskWanderStandard(passengerPed, 10.0, 10)
                    if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxiarrive", ped) else
                        PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_ARRIVE_AT_DEST", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
                    end
                    Wait(2000)
                end
                CreateThread(function()
                    if Config.Debug then print("^5Debug^7: ^3STARTED ^2Check if player has left area AFTER taxi has arrived ^7") end
                    while not taxiState.driving do
                        Wait(500)
                        if #(GetEntityCoords(vehicle) - GetEntityCoords(PlayerPedId())) > 30.0 then
                            if Config.Debug then print("^5Debug^7: ^3"..#(callCoords - GetEntityCoords(PlayerPedId())).." reached ^7taxi leaving") end
                            PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
                            triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["toofar"], "error")

                            taxiLeave()
                            break
                        end
                    end
                    if Config.Debug then print("^5Debug^7: ^3AFTER ^2loop finished^7") end
                end)
                if vehicle then TriggerServerEvent("jim-npcservice:server:CreateTarget", VehToNet(vehicle)) end
                StartVehicleHorn(vehicle, 1000, GetHashKey("NORMAL"), false)
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["waiting"], "success")
                local timer = GetGameTimer()
                local hornTimer = GetGameTimer()
                local time = (180 * 1000)
                if Config.Debug then print("^5Debug^7: ^2Taxi arrived, starting timer to leave^7") end
                while (GetGameTimer() - timer < time) and GetVehiclePedIsIn(PlayerPedId()) ~= vehicle and not taxiState.drving and DoesEntityExist(vehicle) do
                    if (GetGameTimer() - timer > time - 1000) then
                        TriggerServerEvent("jim-npcservice:server:RemoveTarget", VehToNet(vehicle))
                        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
                        triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["leaving"], "success")
                        taxiState.cancelled = true
                        taxiLeave()
                    end
                    if GetGameTimer() > hornTimer + 20000 and (vehicle) then hornTimer = GetGameTimer()
                        StartVehicleHorn(vehicle, 1000, GetHashKey("NORMAL"), false)
                    end
                    Wait(0)
                end
                if Config.Debug then print("^5Debug^7: ^2Leave timer stopped^7") end
            end)
        end
    end)
end

--[[ MAKE TAXI GO AND LOOP IT ]]--
function startTaxi()
    if Config.Debug then print("^5Debug^7: ^3startTaxi^7()") end
    hideText()
    coords = GetBlipCoords(tempBlip)
    local playerBank = not Config.freeTaxi and triggerCallback("jim-npcservice:server:getBank") or nil
    for i = 0, 5 do SetVehicleDoorOpen(vehicle, i, false, false) SetVehicleDoorShut(vehicle, i, true) end

    TriggerServerEvent("jim-npcservice:server:RemoveTarget", VehToNet(vehicle))

    setDriverDest(coords)
    taxiState.arrived = false
    taxiState.driving = true
    startCalc(vehicle)
    if taxiLoop == true then return else taxiLoop = true
        CreateThread(function()
            Wait(2000)
            local timer = 60000
            local fliptimer = 4
            while taxiState.driving and not taxiState.stopped and not taxiState.leftEarly and not taxiState.noCash and not taxiState.stoppedEarly and not taxiState.skipped do
                local vehCoords = GetEntityCoords(vehicle)
                timer -= 2000
                if timer <= 0 then
                    if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxibanter", ped) else
                        PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_BANTER", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
                    end
                    timer = 120000
                end
                local routeLength = GetGpsBlipRouteLength(tempBlip)
                drawText(GetBlipSprite(tempBlip), {
                    Loc[Config.Lan].notify["dist"]..": "..string.format("%.2f", routeLength * (isKm() and 0.001 or 0.00062))..(isKm() and "Km" or "Mi"),
                    Loc[Config.Lan].menu["time"]..": "..convertMinutesToTime(routeLength/1000),
                    not Config.freeTaxi and Loc[Config.Lan].notify["cost"]..": $"..math.ceil(cost) or "",
                }, "y")
                if GetVehiclePedIsIn(PlayerPedId()) ~= vehicle and not taxiState.stopped then
                    if Config.Debug then print("^5Debug^7: ^3taxiEmpty^2 stopping journey early^7") end
                    taxiState.driving = false
                    taxiState.stopped = true
                    taxiState.leftEarly = true
                end
                if not Config.freeTaxi then
                    if playerBank <= cost then
                        if triggerCallback("jim-npcservice:server:getBank") <= cost then
                            if Config.Debug then print("^5Debug^7: ^3playerBank^2 not enough cash^7") end
                            taxiState.driving = false
                            taxiState.noCash = true
                            taxiState.stopped = true
                        end
                    end
                end
                if (GetScriptTaskStatus(ped, 0x21D33957) == 7) or #(vehCoords.xy - coords.xy) <= 30.0 then
                    if Config.Debug then print("^5Debug^7: ^2Journey marked as complete^7") end
                    taxiState.driving = false
                    taxiState.stopped = true
                end

                if (IsEntityUpsidedown(vehicle) or (GetEntityRoll(vehicle) > 75.0 or GetEntityRoll(vehicle) < -75.0)) and GetEntitySpeed(vehicle) < 2 then
                    fliptimer -= 1
                    if fliptimer <= 0 then
                        if Config.Debug then print("^5Debug^7: ^Vehicle seen as upside down^7") end
                        taxiState.driving = false
                        taxiState.stopped = true
                        taxiState.trashed = true
                    end
                else
                    fliptimer = 4
                end
                Wait(2000)
                DeletePed(passengerPed) passengerPed = nil
            end
            stopTempCam(cam) cam = nil
            hideText()
            if taxiState.stopped and not taxiState.leftEarly and not taxiState.trashed and not taxiState.noCash then
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["arriveddest"], "success")
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxiarrive", ped) else
                    PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_ARRIVE_AT_DEST", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
                end
                taxiLeave()
            elseif taxiState.noCash then
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["notenough"], "error")
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxinomoney", ped) else
                    PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_ARRIVE_AT_DEST", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
                end
                taxiLeave()
            elseif taxiState.stoppedEarly then
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["stopping"], "success")
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxigetoutearly", ped) else
                    PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_GET_OUT_EARLY", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
                end
                taxiLeave()
            elseif taxiState.leftEarly then
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["leftearly"], "success")
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxigetoutearly", ped) else
                    PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_GET_OUT_EARLY", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
                end
                taxiLeave()
            elseif taxiState.trashed and not taxiState.skipped then
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["taxidead"], "success")
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxitrashed", ped) else
                    PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_TRASHED", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
                end
                ClearPedTasks(ped)
                taxiLeave()
            elseif taxiState.skipped then
                triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["skip"], "success")
                taxiSkip()
            end
            hideText()
            taxiLoop = false
        end)
    end
end

--[[ KEY MAPS ]]--
RegisterKeyMapping('taxispeedslow', 'Speed Up / Slowdown', 'keyboard', 'SPACE')
RegisterCommand("taxispeedslow", function()
    if GetVehiclePedIsIn(PlayerPedId(), false) == vehicle and taxiState.driving and not isWarMenuOpen() then
        taxiState.hurry = not taxiState.hurry
        setDriverDest(coords)
    end
end, false)
if Config.canSkip then
    RegisterKeyMapping('taxiskip', 'Skip (Extra Cost)', 'keyboard', 'RETURN')
    RegisterCommand("taxiskip", function()
        if GetVehiclePedIsIn(PlayerPedId()) == vehicle and taxiState.driving and not taxiState.skipped and not isWarMenuOpen() then
            taxiState.skipped = true
        end
    end, false)
end
RegisterKeyMapping('taxishowHud', 'Choose a destination', 'keyboard', 'e')
RegisterCommand("taxishowHud", function()
    if GetVehiclePedIsIn(PlayerPedId()) == vehicle and (taxiState.driving or taxiState.arrived) and not isWarMenuOpen() then
        MakeDestList()
    end
end, false)
RegisterKeyMapping('taxiStop', 'Stop Taxi', 'keyboard', 'BACK')
RegisterCommand("taxiStop", function()
    if GetVehiclePedIsIn(PlayerPedId()) == vehicle and taxiState.driving and not isWarMenuOpen() then
        taxiState.stoppedEarly = true
    end
end, false)

--[[ SHARED SERVER EVENTS ]]--
RegisterNetEvent("jim-npcservice:client:CreateTarget", function(veh)
    if Config.Debug then print("^5Debug^7: ^3jim-npcservice:client:CreateTarget^7") end
    local veh = NetToVeh(veh)
    createEntityTarget(veh, {
        {   icon = "fas fa-car-on",
            label = Loc[Config.Lan].target["getin"],
            action = function()
                local Ped = PlayerPedId()
                if vehicle and GetResourceState(Config.Fuel):find("start") then
                    exports[Config.Fuel]:SetFuel(vehicle, 100.0)
                end
                local seats = GetVehicleModelNumberOfSeats(GetEntityModel(veh)) - 1
                local pickSeat = 1
                while GetPedInVehicleSeat(veh, pickSeat) ~= 0 do
                    pickSeat += 1
                    if pickSeat > seats then
                        triggerNotify(nil, Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["nospace"], "success")
                        break
                    end
                    Wait(0)
                end
                TaskEnterVehicle(Ped, veh, 10000, pickSeat, 1.0, 0)
                if vehicle then RemoveBlip(GetBlipFromEntity(vehicle)) end
                if DoesBlipExist(callBlip) then RemoveBlip(callBlip) callBlip = nil end
                while GetVehiclePedIsIn(Ped) ~= veh do SetVehicleDoorsLocked(veh, 0) Wait(5) end
                if vehicle then drawText(nil, {Loc[Config.Lan].menu["pick"]}, "y") end
                Wait(2000)
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxiwhereto", ped) else
                    PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_WHERE_TO", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
                end
                ExecuteCommand("toggleseatbelt")
            end,
        } }, 2.5)
end)

RegisterNetEvent("jim-npcservice:client:RemoveTarget", function(veh)
    if Config.Debug then print("^5Debug^7: ^3jim-npcservice:client:RemoveTarget^7") end
    exports['qb-target']:RemoveTargetEntity(NetToVeh(veh))
end)

RegisterNetEvent("jim-npcservice:client:leaveTaxi", function(veh) local Ped = PlayerPedId()
    if Config.Debug then print("^5Debug^7: ^3jim-npcservice:client:leaveTaxi^7") end
    if GetVehiclePedIsIn(Ped, false) == NetToVeh(veh) then
        TaskLeaveVehicle(Ped, NetToVeh(veh), 1)
    end
end)

RegisterNetEvent("jim-npcservice:client:skipPlayers", function(veh)
    if Config.Debug then print("^5Debug^7: ^3jim-npcservice:client:skipPlayers^7") end
    if GetVehiclePedIsIn(PlayerPedId(), false) == NetToVeh(veh) then
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do Wait(10) end
        Wait(2000)
        DoScreenFadeIn(800)
        while not IsScreenFadedIn() do Wait(10) end
        Wait(1000)
    end
end)

--[[ FINISHER FUNCTIONS ]]--
function cancelTaxi()
    if Config.Debug then print("^5Debug^7: ^3cancelTaxi^7()") end
    cam = nil
    taxiState.cancelled = true
    hideText()
    SetBlipRoute(tempBlip, false)
    if DoesBlipExist(tempBlip) then RemoveBlip(tempBlip) tempBlip = nil end
    RemoveBlip(GetBlipFromEntity(vehicle))
    if DoesBlipExist(callBlip) then RemoveBlip(callBlip) callBlip = nil end
    ClearPedTasks(ped)
    removeTaxi()
end

function taxiSkip()
    if Config.Debug then print("^5Debug^7: ^3taxiSkip^7()") end
    cam = nil
    TriggerServerEvent("jim-npcservice:server:skipPlayers", VehToNet(vehicle), GetEntityCoords(vehicle))
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do Wait(10) end
    local _, Pos, _ = GetClosestRoad(coords.x, coords.y, coords.z, 10, 1, true)
    local copyHeading = GetEntityHeading(GetClosestVehicle(Pos.x, Pos.y, Pos.z, 20.0, 0, 70))
    SetEntityCoords(vehicle, Pos)
    SetVehicleOnGroundProperly(vehicle)
    SetEntityHeading(copyHeading)
    Wait(2000)
    DoScreenFadeIn(800)
    while not IsScreenFadedIn() do Wait(10) end
    if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxiarrive", ped) else
        PlayPedAmbientSpeechWithVoiceNative(ped, "TAXID_ARRIVE_AT_DEST", "A_M_M_EASTSA_02_LATINO_FULL_01", "SPEECH_PARAMS_FORCE", 0)
    end
    Wait(1000)
    taxiLeave()
end

function taxiLeave() taxiState.stopped = false taxiState.leaving = true
    if Config.Debug then print("^5Debug^7: ^3taxiLeave^7()") end
    hideText()
    taxiState.hurry = false
    cam = nil
    SetBlipRoute(tempBlip, false)
    if DoesBlipExist(tempBlip) then RemoveBlip(tempBlip) tempBlip = nil end
    if DoesBlipExist(callBlip) then RemoveBlip(callBlip) callBlip = nil end

    TaskVehicleTempAction(ped, vehicle, 6, 2000)
    SetVehicleHandbrake(vehicle, true)
    SetVehicleEngineOn(vehicle, false, true, false)
    TriggerServerEvent("jim-npcservice:server:leaveTaxi", VehToNet(vehicle), GetEntityCoords(vehicle))
    Wait(5000)
    TaskVehicleDriveWander(ped, vehicle, 10.0, 786603)
    CreateThread(function()
        local timeout = 30000
        while DoesEntityExist(vehicle) and timeout > 0 do
            timeout -= 1000
            Wait(1000)
        end
        if vehicle then
            removeTaxi()
        end
    end)
    while DoesEntityExist(vehicle) do
        if #(GetEntityCoords(vehicle) - GetEntityCoords(PlayerPedId())) >= 90.0 then
            if Config.Debug then print("^5Debug^7: ^2Vehicle past ^390^7.^30^7, ^2removing^1") end
            removeTaxi()
        end
        Wait(100)
    end
end

function startCalc(vehicle)
    if not Config.freeTaxi then
        if Config.Debug then print("^5Debug^7: ^3startCalc^7()") end
        CreateThread(function()
            if calc then return else calc = true end
            local prevLoc = GetEntityCoords(vehicle)
            while GetScriptTaskStatus(ped, 0x21D33957) ~= 7 and taxiState.driving and calc == true do
                local vehCoords = GetEntityCoords(vehicle)
                local currentDist = getEstimatedDist(prevLoc, vehCoords)
                cost += ((currentDist / 100) * (taxiState.type == "taxi" and 1 or 10))
                prevLoc = vehCoords
                Wait(2000)
            end
            hideText()
            if taxiState.skipped then cost += (((getEstimatedDist(prevLoc, coords) / 100) * (taxiState.type == "taxi" and 5 or 25)) * 0.5) end
            TriggerServerEvent("jim-npcservice:server:ChargePlayer", math.ceil(cost))
            calc = false
            cost = 0
        end)
    end

end

function removeTaxi()
    if Config.Debug then print("^5Debug^7: ^3removeTaxi^7()") end
    DeletePed(ped)
    DeletePed(passengerPed)
    DeleteVehicle(vehicle)
    ped = nil vehicle = nil passengerPed = nil
    cost, taxiLoop, calc, coords, callCoords, callBlip = 0, false, false, nil, nil, nil
end

-- MENUS --
if Config.PayPhones then
    exports['qb-target']:AddTargetModel(Config.PayPhoneModels, {
        options = {{
            icon = "fas fa-car-on",
            label = "Call a cab",
            action = function(entity) callCab() lookEnt(entity) end,
            }},
        distance = 2.5, })
    if Config.ShowNearbyPayPhones then
        CreateThread(function()
            while true do
                local pedCoords = GetEntityCoords(PlayerPedId())
                for _, v in pairs(GetGamePool('CObject')) do
                    for _, model in pairs(Config.PayPhoneModels) do
                        if GetEntityModel(v) == model then
                            if #(pedCoords - GetEntityCoords(v)) <= 150 then
                                if not DoesBlipExist(GetBlipFromEntity(v)) then
                                    makeEntityBlip({entity = v, sprite = 817, col = 5, name = "Payphone" })
                                end
                            else
                                if DoesBlipExist(GetBlipFromEntity(v)) then RemoveBlip(GetBlipFromEntity(v)) end
                            end
                        end
                    end
                end
                Wait(10000)
            end
        end)
    end
end

if Config.CommandCall then
    RegisterCommand(Config.Command, function() callCab() end)
end

function callCab()
    local Menu = {}
    if not vehicle then
        Menu[#Menu+1] = { icon = "https://docs.fivem.net/blips/radar_cop_car.png", header = Loc[Config.Lan].menu["taxi"], onSelect = function() callTaxi("taxi") end, }
        Menu[#Menu+1] = { icon = "https://docs.fivem.net/blips/radar_limo.png", header = Loc[Config.Lan].menu["limo"], onSelect = function() callTaxi("stretch") end, }
    else
        Menu[#Menu+1] = { isMenuHeader = taxiState.driving, header = "Cancel Taxi", onSelect = function() cancelTaxi() end, }
    end
    openMenu(Menu, { header = Loc[Config.Lan].menu["chooseserv"], canClose = true, })
end

function MakeDestList()
    startTempCam(cam)
    local Menu = {}
    if DoesBlipExist(GetFirstBlipInfoId(8)) then -- add destination blip if available
        local destBlip = GetFirstBlipInfoId(8)
        local pCoords = GetEntityCoords(PlayerPedId())
        local destCoords = GetBlipCoords(destBlip)
        Menu[#Menu+1] = {
            icon = (isOx() and radarTable[8] or nil),
            header = (isOx() and GetLabelText("CM_LOC_WP") or
                img:gsub('%!', #Menu):gsub('%?', colorTable["50"]):gsub('%|', radarTable[8]).." - "..GetLabelText("CM_LOC_WP")),
                txt = generateBlipText(pCoords, destCoords, taxiState.type),

            onSelect = function()
                if tempBlip then RemoveBlip(tempBlip) tempBlip = nil end
                tempBlip = makeBlip({ coords = destCoords, sprite = 8, col = 5, name = GetLabelText("AMTT_DESTIN"), })
                if taxiState.driving then taxiState.changing = true end
                startTaxi(tempBlip)
            end,
        }
    end
    for k, v in pairsByKeys(Locations) do
        Menu[#Menu+1] = { arrow = true, header = k, txt = #v.." Locations", onSelect = function() makeSubList(v) end, }
    end
    openMenu(Menu, {
        header = Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ],
        headertxt = Loc[Config.Lan].menu["choose"],
        canClose = true,
        onExit = function() if Config.Menu ~= "gta" then stopTempCam(cam) end end,
    })
end

function makeSubList(list) local Menu = {}
    startTempCam(cam)
    if type(list[1].coords) == "table" then
        local tempList = {}
        for k, v in pairs(list) do tempList[(GetLabelText(v.label) == "NULL" and v.label or GetLabelText(v.label))] = v end
        for _, v in pairsByKeys(tempList) do -- add every blip that can be found (no names)
            Menu[#Menu+1] = {
                arrow = true,
                icon = (isOx() or Config.Menu == "gta") and radarTable[v.blip.sprite] or nil,
                header = ((isOx() or Config.Menu == "gta") and v.label or
                    img:gsub('%!', #Menu):gsub('%?', colorTable[tostring(v.blip.col)]):gsub('%|', radarTable[v.blip.sprite]).."  "..v.label),
                txt = #v.coords.." Location"..(#v.coords > 1 and "s" or ""),
                onSelect = function() makeBlipList(v, list) end,
            }
        end
        openMenu(Menu, { header = Loc[Config.Lan].menu["choose"], onBack = function() MakeDestList() end, })
    elseif type(list[1].coords) == "vector3" then
        local pCoords = GetEntityCoords(PlayerPedId())
        local tempList = {}
        for k, v in pairs(list) do tempList[(GetLabelText(v.label) == "NULL" and v.label or GetLabelText(v.label))] = v end
        for k, v in pairsByKeys(tempList) do
            Menu[#Menu+1] = {
                icon = (isOx() or Config.Menu == "gta") and radarTable[v.blip.sprite] or nil,
                header = ((isOx() or Config.Menu == "gta") and (GetLabelText(v.label) == "NULL" and v.label or GetLabelText(v.label)) or
                    img:gsub('%!', #Menu):gsub('%?', colorTable[tostring(v.blip.col)]):gsub('%|', radarTable[v.blip.sprite]).." "..(GetLabelText(v.label) == "NULL" and v.label or GetLabelText(v.label))),
                    txt = generateBlipText(pCoords, v.coords, taxiState.type),
                onSelect = function()
                    if tempBlip then RemoveBlip(tempBlip) tempBlip = nil end
                    tempBlip = makeBlip({ coords = v.coords, sprite = v.blip.sprite, col = 5, name = GetLabelText("AMTT_DESTIN"), })
                    if taxiState.driving then taxiState.changing = true end
                    startTaxi(tempBlip)
                end,
            }
        end
        openMenu(Menu, { header = Loc[Config.Lan].menu["landmarks"], onBack = function() MakeDestList() end, })
    end
end

function makeBlipList(list, prev)
    startTempCam(cam)
    local Menu = {} local distList = {}
    local pCoords = GetEntityCoords(PlayerPedId())
    for _, v in pairs(list.coords) do distList[math.ceil(#(pCoords - v.xyz))] = v end
    for _, v in pairsByKeys(distList) do
        Menu[#Menu+1] = {
            icon = (isOx() and radarTable[list.blip.sprite] or nil),
            header = ((isOx() or Config.Menu == "gta") and "Location "..#Menu+1 or
                img:gsub('%!', #Menu):gsub('%?', colorTable[tostring(list.blip.col)]):gsub('%|', radarTable[list.blip.sprite]).." Location "..#Menu+1),
            txt = generateBlipText(pCoords, v, taxiState.type),
            onSelect = function()
                if tempBlip then RemoveBlip(tempBlip) tempBlip = nil end
                tempBlip = makeBlip({ coords = v, sprite = list.blip.sprite, col = 5, name = GetLabelText("AMTT_DESTIN"), })
                if taxiState.driving then taxiState.changing = true end
                startTaxi()
            end,
        }
    end
    openMenu(Menu, { header = list.label, canClose = false, onBack = function() makeSubList(prev) end, })
end

function setDriverDest(coords) local speed, style = nil, nil
    stopTempCam(cam)
    if taxiState.type == "taxi" then
        speed = (taxiState.hurry and 35.0 or 22.0)
        style = (taxiState.hurry and 524604 or 524715)
    else
        speed = (taxiState.hurry and 25.0 or 16.0)
        style = (taxiState.hurry and 524604 or 524715)
    end
    if taxiState.hurry and not taxiState.changing then
        triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["speeding"], "success")
        if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxispeedup", ped) end
    elseif taxiState.hurry and not taxiState.changing then
        triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["changing"], "success")
        if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxichangedest", ped) end
        taxiState.changing = true
    elseif taxiState.driving and not taxiState.changing and not taxiState.hurry then

    else
        triggerNotify(Loc[Config.Lan].notify[ taxiState.type == "taxi" and "taxiname" or "limoname" ], Loc[Config.Lan].notify["heading"], "success")
        if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("taxibegin", ped) end
    end

    TaskVehicleDriveToCoordLongrange(ped, vehicle, coords.x, coords.y, coords.z, speed, style, 20.0)
    SetBlipRoute(tempBlip, true)
end

exports('callCab', callCab)
exports('callTaxi', callTaxi)

AddEventHandler('onResourceStop', function(r)
    if r ~= GetCurrentResourceName() then return end
    if DoesEntityExist(ped) then DeletePed(ped) end
    if DoesEntityExist(passengerPed) then DeletePed(passengerPed) end
    if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
    hideText()
end)

end