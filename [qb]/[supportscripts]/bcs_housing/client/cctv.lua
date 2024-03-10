-- Inspired by esx-legacy esx_property
-- https://github.com/esx-framework/esx_core/blob/1.9.0/%5Besx_addons%5D/esx_property/client/cctv.lua
-- Credits where its due!

RegisterNetEvent('Housing:addCCTV', function(identifier)
    busy = true
    local home = GetHomeObject(identifier)
    debugPrint('[addCCTV]', 'Creating cctv', home.cctv.enabled)
    if not home.cctv.enabled then
        Notify(Locale['housing'], Locale['cctv_not_enabled'], 'error', 3000)
        return 
    end
    CreateThread(function()
        HelpText(true, Locale['prompt_set_cctv_heading'])
        while true do
            Wait(2)
            if IsControlJustReleased(0, 38) then
                home.cctv.rot = {x = round(GetGameplayCamRot(2).x, 2), y = round(GetGameplayCamRot(2).y, 2), z = round(GetGameplayCamRot(2).z, 2)}
                break
            end
        end
        HelpText(true, Locale['prompt_set_cctv_max_right'])
        while true do
            Wait(2)
            if IsControlJustReleased(0, 38) then
                home.cctv.maxRight = round(GetGameplayCamRot(2).z, 2)
                break
            end
        end
        HelpText(true, Locale['prompt_set_cctv_max_left'])
        while true do
            Wait(2)
            if IsControlJustReleased(0, 38) then
                home.cctv.maxLeft = round(GetGameplayCamRot(2).z, 2)
                break
            end
        end
        HelpText(false)
        busy = false
        TriggerServerEvent('Housing:saveCCTV', identifier, home)
    end)
end)

RegisterNetEvent('Housing:viewCCTV', function(identifier)
    DoScreenFadeOut(500)
    Wait(500)
    local initialCoords = GetEntityCoords(PlayerPedId())
    local home = GetHomeObject(identifier)
    TriggerServerCallback('Housing:enterCCTV', function(canCCTV)
        if canCCTV then
            local cctvcam = nil
            ClearFocus()
            if not home.cctv.rot then
                Notify(Locale['housing'], Locale['cctv_not_setup'], 'error', 3000)
                InCCTV = false
                Wait(1000)
                ClearFocus()
                ClearTimecycleModifier()
                ClearExtraTimecycleModifier()
                RenderScriptCams(false, false, 0, true, false)
                DestroyCam(cctvcam, false)
                SetFocusEntity(playerPed)
                SetNightvision(false)
                SetSeethrough(false)
                SetEntityCollision(playerPed, true, true)
                FreezeEntityPosition(playerPed, false)
                SetEntityVisible(playerPed, true)
                SetEntityCoordsNoOffset(playerPed, initialCoords)
                Wait(1500)
                DoScreenFadeIn(1000)
                return
            end
            if IsResourceStarted('bcs_hud') then
                exports['bcs_hud']:keybind({
                    title='CCTV Controls',
                    items={
                        {
                            description=Locale['keybind_cctv_move'],
                            buttons={'W','A','S','D'}
                        },
                        {
                            description=Locale['keybind_cctv_zoom'],
                            buttons={'SCROLL'}
                        },
                        {
                            description=Locale['keybind_cctv_exit'],
                            buttons={'BACKSPACE'}
                        },
                    }
                })
            else
                displayHelp(Locale['prompt_cctv_keybinds'], 'bottom-right')
            end
            local entrance = home.complex == 'Apartment' and Apartments[home.apartment.identifier].entrance.center or home.entry
            local playerPed = PlayerPedId()
            cctvcam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",
            vector3(entrance.x, entrance.y, entrance.z + Config.CCTV.HeightAboveDoor), 0, 0, 0, Config.CCTV.FOV)
            SetCamRot(cctvcam, home.cctv.rot.x, home.cctv.rot.y, home.cctv.rot.z, 2)
            SetCamActive(cctvcam, true)
            SetTimecycleModifier("scanline_cam_cheap")

            DisableAllControlActions(0)
            FreezeEntityPosition(playerPed, true)
            SetEntityCollision(playerPed, false, true)
            SetEntityVisible(playerPed, false)
            SetTimecycleModifierStrength(2.0)
            SetFocusArea(entrance.x, entrance.y, entrance.z, 0.0, 0.0, 0.0)
            PointCamAtCoord(cctvcam, vector3(entrance.x, entrance.y, entrance.z + Config.CCTV.HeightAboveDoor))
            RenderScriptCams(true, false, 1, true, false)
            Wait(1000)
            DoScreenFadeIn(500)
            RequestAmbientAudioBank("Phone_Soundset_Franklin", 0, 0)
            RequestAmbientAudioBank("HintCamSounds", 0, 0)
            while IsCamActive(cctvcam) do
                Wait(5)
                DisableAllControlActions(0)
                EnableControlAction(0, 245, true)
                EnableControlAction(0, 246, true)
                EnableControlAction(0, 249, true)
                HideHudComponentThisFrame(7)
                HideHudComponentThisFrame(8)
                HideHudComponentThisFrame(9)
                HideHudComponentThisFrame(6)
                HideHudComponentThisFrame(19)
                HideHudAndRadarThisFrame()
                -- ROTATE LEFT
                local getCameraRot = GetCamRot(cctvcam, 2)

                if IsDisabledControlPressed(0, Config.CCTV.Controls.Left) and getCameraRot.z < home.cctv.maxLeft then
                    PlaySoundFrontend(-1, "	FocusIn", "HintCamSounds", false)
                    SetCamRot(cctvcam, getCameraRot.x, 0.0, getCameraRot.z + Config.CCTV.RotateSpeed, 2)
                end
                -- ROTATE RIGHT
                if IsDisabledControlPressed(0, Config.CCTV.Controls.Right) and getCameraRot.z > home.cctv.maxRight then
                    PlaySoundFrontend(-1, "	FocusIn", "HintCamSounds", false)
                    SetCamRot(cctvcam, getCameraRot.x, 0.0, getCameraRot.z - Config.CCTV.RotateSpeed, 2)
                end

                -- ROTATE UP
                if IsDisabledControlPressed(0, Config.CCTV.Controls.Up) and getCameraRot.x < Config.CCTV.MaxUpRotation then
                    PlaySoundFrontend(-1, "	FocusIn", "HintCamSounds", false)
                    SetCamRot(cctvcam, getCameraRot.x + Config.CCTV.RotateSpeed, 0.0, getCameraRot.z, 2)
                end

                if IsDisabledControlPressed(0, Config.CCTV.Controls.Down) and getCameraRot.x > Config.CCTV.MaxDownRotation then
                    PlaySoundFrontend(-1, "	FocusIn", "HintCamSounds", false)
                    SetCamRot(cctvcam, getCameraRot.x - Config.CCTV.RotateSpeed, 0.0, getCameraRot.z, 2)
                end

                if IsDisabledControlPressed(0, Config.CCTV.Controls.ZoomIn) and GetCamFov(cctvcam) > Config.CCTV.MaxZoom then
                    SetCamFov(cctvcam, GetCamFov(cctvcam) - 1.0)
                end

                if IsDisabledControlPressed(0, Config.CCTV.Controls.ZoomOut) and GetCamFov(cctvcam) < Config.CCTV.MinZoom then
                    SetCamFov(cctvcam, GetCamFov(cctvcam) + 1.0)
                end

                if IsDisabledControlPressed(0, Config.CCTV.Controls.Down) and getCameraRot.x > Config.CCTV.MaxDownRotation then
                    PlaySoundFrontend(-1, "	FocusIn", "HintCamSounds", false)
                    SetCamRot(cctvcam, getCameraRot.x - Config.CCTV.RotateSpeed, 0.0, getCameraRot.z, 2)
                end

                if IsDisabledControlPressed(0, Config.CCTV.Controls.Down) and getCameraRot.x > Config.CCTV.MaxDownRotation then
                    PlaySoundFrontend(-1, "	FocusIn", "HintCamSounds", false)
                    SetCamRot(cctvcam, getCameraRot.x - Config.CCTV.RotateSpeed, 0.0, getCameraRot.z, 2)
                end

                if IsDisabledControlPressed(1, Config.CCTV.Controls.Exit) then
                    DoScreenFadeOut(1000)
                    TriggerServerCallback("Housing:leaveCCTV", function(CanExit)
                        if CanExit then
                            InCCTV = false
                            Wait(1000)
                            ClearFocus()
                            ClearTimecycleModifier()
                            ClearExtraTimecycleModifier()
                            RenderScriptCams(false, false, 0, true, false)
                            DestroyCam(cctvcam, false)
                            SetFocusEntity(playerPed)
                            SetNightvision(false)
                            SetSeethrough(false)
                            SetEntityCollision(playerPed, true, true)
                            FreezeEntityPosition(playerPed, false)
                            SetEntityVisible(playerPed, true)
                            SetEntityCoordsNoOffset(playerPed, initialCoords)
                            Wait(1500)
                            DoScreenFadeIn(1000)
                        end
                    end, identifier)
                break
                end
            end
            if IsResourceStarted('bcs_hud') then
                exports.bcs_hud:closeKeybind()
            else
                closeHelp()
            end
        else
            Wait(1500)
            DoScreenFadeIn(1000)
        end
    end, identifier)
end)
