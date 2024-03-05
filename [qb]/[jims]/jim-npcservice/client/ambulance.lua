if Config.ambiEnable then

local ambulanceLoop, coords, callCoords, callBlip = false, nil, nil, nil

--[[ FIRST STEP OF SCRIPT ]]--
function callAmbi(carModel, pedModel)
    if not vehicle then -- if no ambulance exists currently, set all the default information and show notification
        ambiState = {
            arriving = false,
            cancelled = false,
            arrived = false,
            driving = false,
            trashed = false,
            stopped = false,
            leaving = false,
        }
        triggerNotify(Loc[Config.Lan].notify["ambiname"], Loc[Config.Lan].notify["onitsway"], "success")
        PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
    else
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
        return
    end

    callCoords = GetEntityCoords(PlayerPedId()) -- store the location the player called from
    callBlip = makeBlip({ coords = callCoords, sprite = 161, name = Loc[Config.Lan].blip["pickup"], col = 4, scale = 0.8 })
    --Get location of best spawn with correct road direction
    local newSpawnCoords = nil
    for _, v in pairsByKeys(getAllBlips()) do if #(GetEntityCoords(PlayerPedId()) - GetBlipCoords(v)) >= 300 then newSpawnCoords = GetBlipCoords(v) break end end
    local _, tempLoc, heading = GetClosestVehicleNodeWithHeading(newSpawnCoords.x, newSpawnCoords.y, newSpawnCoords.z, 1, 3.0, 0)

    -- Create Vehicle and Ped
    vehicle = makeVeh(carModel or Config.Amublances[math.random(1, #Config.Amublances)], vec4(tempLoc.x, tempLoc.y, tempLoc.z, heading))
    driver = makePed(pedModel or Config.AmbiPeds[math.random(1, #Config.AmbiPeds)], vec4(tempLoc.x, tempLoc.y, tempLoc.z, 0.0), false, true, nil, nil)
    ped = makePed(pedModel or Config.AmbiPeds[math.random(1, #Config.AmbiPeds)], vec4(tempLoc.x, tempLoc.y, tempLoc.z, 0.0), false, true, nil, nil)
    SetPedIntoVehicle(driver, vehicle, -1)
    SetPedIntoVehicle(ped, vehicle, 1)

    Wait(1000)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleDoorsLocked(vehicle, 0)
    SetVehicleMod(vehicle, 13, (GetNumVehicleMods(vehicle, 13) - 2), nil)
    SetVehicleMod(vehicle, 15, (GetNumVehicleMods(vehicle, 15) - 2), nil)
    SetVehicleMod(vehicle, 12, (GetNumVehicleMods(vehicle, 12) - 2), nil)
    SetVehicleStrong(vehicle, true)
    SetDriverAbility(ped, 1.0)
    SetPedCanBeDraggedOut(ped, false)
    SetEntityNoCollisionEntity(ped, PlayerPedId(), false)
    SetPedCombatAttributes(ped, 3, true)
    pushVehicle(vehicle)

    --local _, DriveToPos, _ = GetClosestRoad(callCoords.x, callCoords.y, callCoords.z, 10, 1, true)

    TaskVehicleDriveToCoordLongrange(driver, vehicle, callCoords, 22.0, 524604, 10.0)

    ambiState.arriving = true

    -- Create ambulance blip and route for tracking location
    makeEntityBlip({entity = vehicle, sprite = 672, col = 3, name = Loc[Config.Lan].blip["ambi"]})
    SetBlipRoute(GetBlipFromEntity(vehicle), true)
    SetBlipAsShortRange(GetBlipFromEntity(vehicle), false)
    ambulanceArriving()
end

--[[ WHAT THE AMBULANCE DOES ON THE WAY/ARRIVED ]]--
function ambulanceArriving()
    CreateThread(function() -- loop to check if ped is driving or not
        Wait(1000)
        SetVehicleSiren(vehicle, true)

        cam = nil
        createCam("taxi", vehicle)
        local trackCoords, stuckTimer = 0, 1
        if Config.Debug then print("^5Debug^7: ^3STARTED ^2Check if player has left area BEFORE ambulance has arrived ^7") end
        while (GetScriptTaskStatus(driver, 0x21D33957) ~= 7) and #(callCoords.xy - GetEntityCoords(vehicle).xy) >= 30 and ambiState.arriving and not ambiState.cancelled do
            local vehCoords = GetEntityCoords(vehicle)
            local pedCoords = GetEntityCoords(PlayerPedId())
            if tonumber(string.format("%.2f", #(vehCoords - trackCoords))) <= 2 then
                if stuckTimer >= 30 then
                    if #(callCoords - GetEntityCoords(PlayerPedId())) <= 150 then
                        DoScreenFadeOut(1000)
                        while not IsScreenFadedOut() do Wait(10) end
                        local getAmbiBack = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -5.0, 0.0)
                        Wait(500)
                        SetEntityCoords(PlayerPedId(), getAmbiBack)
                        break
                    else
                        triggerNotify(Loc[Config.Lan].notify["ambiname"], Loc[Config.Lan].error["stuck"], "error")
                        cancelAmbulance()
                        break
                    end
                end
                stuckTimer += 1
            else stuckTimer = 0 end
            trackCoords = vehCoords
            drawText(GetBlipSprite(GetBlipFromEntity(vehicle)), {Loc[Config.Lan].menu["estimate"].." "..getEstimatedTime(pedCoords, vehCoords)}, "b")
            Wait(1000)
            SetBlipRotation(GetBlipFromEntity(vehicle), math.ceil(GetEntityHeading(vehicle)))
            if #(callCoords - pedCoords) > 30.0 then
                if Config.Debug then print("^5Debug^7: ^3"..#(callCoords - pedCoords).." reached ^7cancelling ambulance") end
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify["ambiname"], Loc[Config.Lan].notify["toofar"], "error")

                cancelAmbulance()
                break
            end
        end
        if Config.Debug then print("^5Debug^7: ^3BEFORE ^2loop finished^7") end
        if not ambiState.cancelled then ambiState.arriving = false ambiState.arrived = true end
        if ambiState.arrived then
            hideText()
            SetBlipFlashesAlternate(GetBlipFromEntity(vehicle), true)
            TaskVehicleTempAction(driver, vehicle, 6, 2000)
            SetVehicleHandbrake(vehicle, true)
            ClearPedTasks(driver)
            if DoesBlipExist(callBlip) then RemoveBlip(callBlip) callBlip = nil end
            if vehicle then RemoveBlip(GetBlipFromEntity(vehicle)) end
            makeEntityBlip({entity = ped, sprite = 126, col = 3, name = "Paramedic"})

            CreateThread(function()
                local pedcoords = GetEntityCoords(PlayerPedId())
                SetVehicleSiren(vehicle, false)
                Wait(1000)
                TaskGoToCoordAnyMeans(ped, pedcoords.x, pedcoords.y, pedcoords.z, 2.0, 0, 0, 786603, 0xbf800000)
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("ambexit", ped) else
                    PlayPedAmbientSpeechNative(ped, "AMBULANCED_ARRIVE_AT_DEST", "SPEECH_PARAMS_FORCE")
                end

                if GetResourceState("jim-talktonpc"):find("start") then
                    if math.random(1, 2) == 1 then exports["jim-talktonpc"]:injectEmotion("ambarrive", ped)
                    else exports["jim-talktonpc"]:injectEmotion("ambdead", ped) end
                else
                    PlayPedAmbientSpeechNative(ped, "AMBULANCED_ARRIVE_AT_DEST", "SPEECH_PARAMS_FORCE")
                end

                reviveChoice()

            end)
        end
    end)
end

function reviveChoice()
    local trackCoords, stuckTimer = 0, 1
    while #(GetEntityCoords(ped) - GetEntityCoords(PlayerPedId())) > 1 do
        Wait(1000)
        local vehCoords = GetEntityCoords(ped)
        if tonumber(string.format("%.2f", #(vehCoords - trackCoords))) <= 2 then
            if stuckTimer >= 10 then
                if #(callCoords - GetEntityCoords(PlayerPedId())) <= 150 then
                    print("close enough")
                    DoScreenFadeOut(800)
                    while not IsScreenFadedOut() do Wait(10) end
                    SetEntityCoords(PlayerPedId(), GetEntityCoords(ped))
                    break
                else
                    triggerNotify(Loc[Config.Lan].notify["ambiname"], Loc[Config.Lan].error["stuck"], "error")
                    break
                end
            end
            stuckTimer += 1
        else stuckTimer = 0 end
        trackCoords = vehCoords
    end
	TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
    Wait(1000)
    if Config.QuickRevive and Config.TakeToHospital then
        local Menu = {}
        Menu[#Menu+1] = {
            header = Loc[Config.Lan].menu["quickrevive"],
            txt = Config.QuickReviveCost > 0 and "$"..Config.QuickReviveCost or nil,
            onSelect = function() quickRevive() end,
        }
        Menu[#Menu+1] = {
            header = Loc[Config.Lan].menu["tohospital"],
            txt = Config.TakeToHospitalCost > 0 and "$"..Config.TakeToHospitalCost or nil,
            onSelect = function() takeToHospital() end,
        }
        openMenu(Menu, {
            header = Loc[Config.Lan].menu["chooseserv"],
            canClose = true,
            onExit = function() end,
        })
    elseif not Config.QuickRevive and Config.TakeToHospital then
        takeToHospital()
    elseif Config.QuickRevive and not Config.TakeToHospital then
        quickRevive()
    end
end

function quickRevive()
    if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:stopCam() end
    ClearPedTasksImmediately(ped)
    Wait(10)
    loadAnimDict("mini@cpr@char_a@cpr_str")
    TaskPlayAnim(ped, "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(10000)
    ClearPedTasks(ped)
    TriggerEvent("hospital:client:Revive", PlayerPedId())
    loadAnimDict("get_up@directional@movement@from_knees@standard")
    if Config.QuickReviveCost > 0 then
        TriggerServerEvent("jim-npcservice:server:ChargePlayer", Config.QuickReviveCost)
    end
    TaskPlayAnim(PlayerPedId(), "get_up@directional@movement@from_knees@standard", "getup_l_0", 2.0, 2.0, -1, 32, 13800, false, false, false)

    Wait(1000)
    TaskEnterVehicle(ped, vehicle, 10000, 1, 2.0)
    while GetVehiclePedIsIn(ped, false) ~= vehicle do Wait(200) end
    ambulanceLeave()
end

function takeToHospital()
    if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:stopCam() end

    loadAnimDict("missfinale_c2mcs_1")
    TaskPlayAnim(ped, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, -1, 49, 0, false, false, false)
    AttachEntityToEntity(PlayerPedId(), ped, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 180, false, false, false, false, 2, false)

    loadAnimDict("nm")
    TaskPlayAnim(PlayerPedId(), "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)

    Wait(1000)
    CreateThread(function()
        while GetVehiclePedIsIn(ped) ~= vehicle do SetVehicleDoorsLocked(vehicle, 0) Wait(0) end
    end)
    TaskEnterVehicle(ped, vehicle, 10000, 1, 2.0)
    SetPedKeepTask(ped, true)
    while GetVehiclePedIsIn(ped, false) ~= vehicle do Wait(200) end
    DetachEntity(PlayerPedId())
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 2)
    if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("ambstate", ped) else
        PlayPedAmbientSpeechNative(ped, "AMBULANCED_ARRIVE_AT_DEST", "SPEECH_PARAMS_FORCE")
    end

    if vehicle then RemoveBlip(GetBlipFromEntity(ped)) end

    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 2)
    ClearPedTasks(ped) ClearPedTasks(PlayerPedId())

    if vehicle and GetResourceState(Config.Fuel):find("start") then
        exports[Config.Fuel]:SetFuel(vehicle, 100.0)
    end
    Wait(2000)
    SetVehicleSiren(vehicle, true)
    Wait(1000)
    if tempBlip then RemoveBlip(tempBlip) tempBlip = nil end
    tempBlip = makeBlip({ coords = vec3(363.69, -584.58, 28.69), sprite = 61, col = 5, name = GetLabelText("AMTT_DESTIN"), })
    if ambiState.driving then ambiState.changing = true end
    startAmbulance()
end


function setAmbiDest(coords) local speed, style = nil, nil
    stopTempCam(cam)
    triggerNotify(Loc[Config.Lan].notify["ambiname"], Loc[Config.Lan].notify["heading"], "success")
    if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("ambexit", ped) end

    TaskVehicleDriveToCoordLongrange(driver, vehicle, coords, 33.0, 524604, 10.0)
    SetBlipRoute(tempBlip, true)
end

--[[ MAKE AMBULANCE GO AND LOOP IT ]]--
function startAmbulance()
    if Config.Debug then print("^5Debug^7: ^3startAmbulance^7()") end
    hideText()
    coords = GetBlipCoords(tempBlip)

    for i = 0, 5 do SetVehicleDoorOpen(vehicle, i, false, false) SetVehicleDoorShut(vehicle, i, true) end

    setAmbiDest(coords)
    ambiState.arrived = false
    ambiState.driving = true

    if ambulanceLoop == true then return else ambulanceLoop = true
        CreateThread(function()
            Wait(2000)
            local timer = 60000
            while ambiState.driving and not ambiState.stopped do
                local vehCoords = GetEntityCoords(vehicle)
                timer -= 2000
                if timer <= 0 then
                    if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("ambresp", ped) else
                        PlayPedAmbientSpeechNative(ped, "AMBULANCED_ARRIVE_AT_DEST", "SPEECH_PARAMS_FORCE")
                    end
                    timer = 120000
                end
                local routeLength = GetGpsBlipRouteLength(tempBlip)
                drawText(GetBlipSprite(tempBlip), {
                    Loc[Config.Lan].notify["dist"]..": "..string.format("%.2f", routeLength * (isKm() and 0.001 or 0.00062))..(isKm() and "Km" or "Mi"),
                    Loc[Config.Lan].menu["time"]..": "..convertMinutesToTime(routeLength/1000),
                }, "b")
                if (GetScriptTaskStatus(driver, 0x21D33957) == 7) or #(vehCoords.xy - coords.xy) <= 30.0 then
                    if Config.Debug then print("^5Debug^7: ^2Journey marked as complete^7") end
                    ambiState.driving = false
                    ambiState.stopped = true
                end
                if IsEntityUpsidedown(vehicle) then
                    if Config.Debug then print("^5Debug^7: ^Vehicle seen as upside down^7") end
                    ambiState.driving = false
                    ambiState.stopped = true
                    ambiState.trashed = true
                end
                Wait(2000)
                DeletePed(passengerPed) passengerPed = nil
            end
            stopTempCam(cam) cam = nil
            hideText()
            if ambiState.stopped and not ambiState.trashed then
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify["ambiname"], Loc[Config.Lan].notify["arriveddest"], "success")
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("ambexit", ped) else
                    PlayPedAmbientSpeechNative(ped, "AMBULANCED_ARRIVE_AT_DEST", "SPEECH_PARAMS_FORCE")
                end
                ambulanceLeave()
            elseif ambiState.trashed then
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify["ambiname"], Loc[Config.Lan].notify["ambulancedead"], "success")
                if GetResourceState("jim-talktonpc"):find("start") then exports["jim-talktonpc"]:injectEmotion("ambulancetrashed", ped) else
                    PlayPedAmbientSpeechNative(ped, "AMBULANCED_ARRIVE_AT_DEST", "SPEECH_PARAMS_FORCE")
                end
                ClearPedTasks(driver)
                ambulanceLeave()
            end
            hideText()
            ambulanceLoop = false
        end)
    end
end

--[[ SHARED SERVER EVENTS ]]--
RegisterNetEvent("jim-npcservice:client:leaveAmbulance", function(veh) local Ped = PlayerPedId()
    if Config.Debug then print("^5Debug^7: ^3jim-npcservice:client:leaveAmbulance^7") end
    if GetVehiclePedIsIn(Ped, false) == veh then
        TaskLeaveVehicle(Ped, veh, 4160)
    end
end)

--[[ FINISHER FUNCTIONS ]]--
function cancelAmbulance()
    if Config.Debug then print("^5Debug^7: ^3cancelAmbulance^7()") end
    cam = nil
    ambiState.cancelled = true
    hideText()
    SetBlipRoute(tempBlip, false)
    if DoesBlipExist(tempBlip) then RemoveBlip(tempBlip) tempBlip = nil end
    RemoveBlip(GetBlipFromEntity(vehicle))
    if DoesBlipExist(callBlip) then RemoveBlip(callBlip) callBlip = nil end
    ClearPedTasks(ped)
    removeAmbulance()
end

function ambulanceLeave() ambiState.stopped = false ambiState.leaving = true
    if Config.Debug then print("^5Debug^7: ^3ambulanceLeave^7()") end
    SetVehicleSiren(vehicle, false)
    hideText()
    cam = nil
    SetBlipRoute(tempBlip, false)
    if DoesBlipExist(tempBlip) then RemoveBlip(tempBlip) tempBlip = nil end
    if DoesBlipExist(callBlip) then RemoveBlip(callBlip) callBlip = nil end

    TaskVehicleTempAction(driver, vehicle, 6, 2000)
    SetVehicleHandbrake(vehicle, true)
    SetVehicleEngineOn(vehicle, false, true, false)
    if Config.TakeToHospitalCost > 0 then
        TriggerServerEvent("jim-npcservice:server:ChargePlayer", Config.TakeToHospitalCost)
    end
    -- What Happens when you arrive at hospital
    CreateThread(function()
        Wait(1000)
        --- THE EVENT SHOULD BE USED TO HEAL/PUT A PLAYER IN BED ---
        TriggerEvent("qb-ambulancejob:checkin")
    end)

    Wait(5000)
    TaskVehicleDriveWander(driver, vehicle, 10.0, 786603)
    CreateThread(function()
        local timeout = 30000
        while DoesEntityExist(vehicle) and timeout > 0 do
            timeout -= 1000
            Wait(1000)
        end
        if vehicle then
            removeAmbulance()
        end
    end)
    while DoesEntityExist(vehicle) do
        if #(GetEntityCoords(vehicle) - GetEntityCoords(PlayerPedId())) >= 90.0 then
            if Config.Debug then print("^5Debug^7: ^2Vehicle past ^390^7.^30^7, ^2removing^1") end
            removeAmbulance()
        end
        Wait(100)
    end
end

function removeAmbulance()
    if Config.Debug then print("^5Debug^7: ^3removeAmbulance^7()") end
    DeletePed(ped)
    DeletePed(driver)
    DeleteVehicle(vehicle)
    ped = nil vehicle = nil passengerPed = nil
    ambulanceLoop, coords, callCoords, callBlip = false, nil, nil, nil
end

exports('callAmbi', callAmbi)

AddEventHandler('onResourceStop', function(r)
    if r ~= GetCurrentResourceName() then return end
    if DoesEntityExist(ped) then DeletePed(ped) end
    if DoesEntityExist(driver) then DeletePed(driver) end
    if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
    hideText()
end)

end