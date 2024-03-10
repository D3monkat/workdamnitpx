function OpenBossMenu()
    if PlayerData.job and PlayerData.job.name == JobConfig.job_name then
        if IsResourceStarted("esx_society") and PlayerData.job.grade_name ==
            "boss" then
            TriggerEvent("esx_society:openBossMenu", JobConfig.job_name,
                function(data, menu) menu.close() end, { wash = false })
        elseif IsResourceStarted("qb-management") then
            TriggerEvent("qb-bossmenu:client:OpenMenu")
        elseif IsResourceStarted("bcs_companymanager") then
            TriggerEvent("CompanyManager:company:openBossMenu")
        end
    end
end

function BossMenuPrompt()
    CreateThread(function()
        if PlayerData.job and PlayerData.job.name == JobConfig.job_name then
            HelpText(true, Locale["prompt_bossmenu"])
            while inZone do
                Wait(2)
                if IsControlJustReleased(0, 38) then
                    HelpText(false)
                    OpenBossMenu()
                    break
                end
            end
        end
    end)
end

AddEventHandler("Housing:openBossMenu", OpenBossMenu)

if Config.target then
    CreateThread(function()
        AddTargetBoxZone("REABOSS", {
            name = "REABOSS",
            coords = JobConfig.bossmenu.coords,
            length = JobConfig.bossmenu.length,
            width = JobConfig.bossmenu.width,
            heading = JobConfig.bossmenu.heading,
            debugPoly = Config.debug,
            minZ = JobConfig.bossmenu.minZ,
            maxZ = JobConfig.bossmenu.maxZ
        }, {
            options = {
                {
                    event = "Housing:openBossMenu",
                    icon = "fas fa-user",
                    label = "Open Boss Menu"
                }
            },
            distance = 3.5
        })
    end)
else
    local bossmenu = BoxZone:Create(JobConfig.bossmenu.coords,
        JobConfig.bossmenu.length,
        JobConfig.bossmenu.width, {
            name = "REABOSS",
            heading = JobConfig.bossmenu.heading,
            debugPoly = Config.debug,
            minZ = JobConfig.bossmenu.minZ,
            maxZ = JobConfig.bossmenu.maxZ
        })
    if Config.EnableMarkers.enable then
        CreateThread(function()
            while inside do
                local sleep = 500
                local pedCoords = GetEntityCoords(PlayerPedId())
                local dist = #(pedCoords - coord)
                if dist < 3.0 then
                    sleep = 0
                    DrawMarker(Config.EnableMarkers.type, coord, 0.0, 0.0, 0.0,
                        0, 0.0, 0.0, Config.EnableMarkers.size.x,
                        Config.EnableMarkers.size.y,
                        Config.EnableMarkers.size.z,
                        Config.EnableMarkers.color.r,
                        Config.EnableMarkers.color.g,
                        Config.EnableMarkers.color.b, 100, false, true,
                        2, false, false, false, false)
                end
                Wait(sleep)
            end
        end)
    end

    bossmenu:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inZone = true
            BossMenuPrompt()
        else
            inZone = false
            HelpText(false)
        end
    end)
end
