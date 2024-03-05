if Config.autoEnable then

local coords = nil

function startPilot()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if Config.Debug then print("^5Debug^7: ^3startPilot^7()") end
    hideText()
    if not DoesBlipExist(GetFirstBlipInfoId(8)) then  -- add destination blip if available
        triggerNotify(Loc[Config.Lan].notify["pilotname"], Loc[Config.Lan].notify["nodest"], "success")
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
        return
    end
    pilotState = {
        driving = false,
        leftEarly = false,
        trashed = false,
        stopped = false,
        stoppedEarly = false,
    }
    coords = GetBlipCoords(GetFirstBlipInfoId(8))
    for i = 0, 5 do SetVehicleDoorOpen(vehicle, i, false, false) SetVehicleDoorShut(vehicle, i, true) end

    setPilotDest(coords)

    pilotState.driving = true
    if pilotLoop == true then return else pilotLoop = true
        CreateThread(function()
            Wait(2000)
            CreateThread(function() checkCancelled() end)
            while pilotState.driving and not pilotState.stopped and not pilotState.stoppedEarly do
                local vehCoords = GetEntityCoords(vehicle)
                drawText(8, {
                    Loc[Config.Lan].notify["dist"]..": "..string.format("%.2f", #(vehCoords.xy - coords.xy) * (isKm() and 0.001 or 0.00062))..(isKm() and "Km" or "Mi"),
                    Loc[Config.Lan].menu["time"]..": "..convertMinutesToTime(#(vehCoords.xy - coords.xy)/1000),
                }, "g")
                if GetVehiclePedIsIn(ped) ~= vehicle and not pilotState.stopped then
                    if Config.Debug then print("^5Debug^7: ^3taxiEmpty^2 stopping journey early^7") end
                    pilotState.driving = false
                    pilotState.stopped = true
                    pilotState.leftEarly = true
                    ClearPedTasks(ped)
                end
                if (GetScriptTaskStatus(ped, 0x21D33957) == 7) or #(vehCoords.xy - coords.xy) <= 30.0 then
                    if Config.Debug then print("^5Debug^7: ^2Journey marked as complete^7") end
                    pilotState.driving = false
                    pilotState.stopped = true
                    ClearPedTasks(ped)
                end
                if (IsEntityUpsidedown(vehicle) or (GetEntityRoll(vehicle) > 75.0 or GetEntityRoll(vehicle) < -75.0)) and GetEntitySpeed(vehicle) < 2 then
                    if Config.Debug then print("^5Debug^7: ^Vehicle seen as upside down^7") end
                    pilotState.driving = false
                    pilotState.stopped = true
                    pilotState.trashed = true
                    ClearPedTasks(ped)
                end
                Wait(2000)
            end
            if pilotState.stopped and not pilotState.leftEarly and not pilotState.trashed then
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify["pilotname"], Loc[Config.Lan].notify["arriveddest"], "success")
                ClearPedTasks(ped)
            elseif pilotState.stoppedEarly then
                PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify["pilotname"], Loc[Config.Lan].notify["disabled"], "success")
                ClearPedTasks(ped)
            elseif pilotState.trashed then
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                triggerNotify(Loc[Config.Lan].notify["pilotname"], Loc[Config.Lan].notify["taxidead"], "success")
                ClearPedTasks(ped)
            end
            hideText()
            pilotLoop = false
        end)
    end
end

RegisterKeyMapping('startAutoPilot', 'Enable a Vehicles Autopilot', 'keyboard', "APOSTROPHE")
RegisterCommand("startAutoPilot", function()
    startPilot()
end, false)

function setPilotDest(coords)
    triggerNotify(Loc[Config.Lan].notify["pilotname"], Loc[Config.Lan].notify["heading"], "success")
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
    TaskVehicleDriveToCoordLongrange(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId()), coords.x, coords.y, coords.z, 22.0, 524715, 20.0)
end

function checkCancelled()
    while pilotState.driving do
        if  IsControlJustPressed(2, 59) or -- Leftright
            IsControlJustPressed(2, 60) or -- Stick control
            IsControlJustPressed(2, 63) or -- Go
            IsControlJustPressed(2, 64) or  -- Stop
            IsControlJustPressed(2, 55) -- Handbrake
        then
            pilotState.driving = false
            pilotState.stoppedEarly = true
        end
        Wait(5)
    end
end

AddEventHandler('onResourceStop', function(r)
    if r ~= GetCurrentResourceName() then return end
    ClearPedTasks(PlayerPedId())
    hideText()
end)

exports('startAutoPilot', startPilot)

end