local insideWeedPoly = false
local insideCokePoly = false
local insideWeed2Poly = false
local insideCoke2Poly = false
local insideWeed3Poly = false
local insideCoke3Poly = false
local harvesting = false
local processing = false
local packaging = false
local crop
local duration = 20000 -- duration to give reward from harvesting/processing

local WeedPoly1 = PolyZone:Create({
    vector2(5367.5610351562, -5214.109375),
    vector2(5416.6918945312, -5253.0405273438),
    vector2(5386.6396484375, -5296.0864257812),
    vector2(5333.4975585938, -5250.4306640625),
    vector2(5338.1020507812, -5242.0805664062)
  }, {
    name="weedfarm",
    minZ = 29.02,
    maxZ = 41.00,
})

local CokePoly1 = PolyZone:Create({
    vector2(5304.5590820312, -5314.4204101562),
    vector2(5291.4077148438, -5301.0517578125),
    vector2(5293.8881835938, -5297.7431640625),
    vector2(5291.0336914062, -5291.2275390625),
    vector2(5300.076171875, -5282.1518554688),
    vector2(5298.9287109375, -5280.7758789062),
    vector2(5315.5727539062, -5265.0034179688),
    vector2(5325.5971679688, -5276.392578125),
    vector2(5326.21875, -5279.2026367188),
    vector2(5331.1591796875, -5284.7719726562),
    vector2(5330.7890625, -5286.5170898438)
  }, {
    name="cokelol",
    minZ = 29.02759475708,
    maxZ = 41.066668701172,
})

local CokePoly2 = PolyZone:Create({
    vector2(5210.9912109375, -5124.1372070312),
    vector2(5213.3823242188, -5123.9536132812),
    vector2(5214.1826171875, -5132.455078125),
    vector2(5212.017578125, -5132.6479492188)
  }, {
    name="cokeproces",
    minZ = 4.1963186264038,
    maxZ = 7.2344698905945,
})

local WeedPoly2 = PolyZone:Create({
    vector2(5184.99609375, -5148.7827148438),
    vector2(5184.8857421875, -5145.6069335938),
    vector2(5187.919921875, -5145.87890625),
    vector2(5187.716796875, -5148.9013671875)
  }, {
    name="weed2",
    minZ = 1.6093778610229,
    maxZ = 4.6553180217743,
})

local CokePoly3 = PolyZone:Create({
    vector2(5063.359375, -4588.8232421875),
    vector2(5062.79296875, -4590.5063476562),
    vector2(5065.1586914062, -4591.3540039062),
    vector2(5066.0366210938, -4589.9448242188)
  }, {
    name="coke3",
    minZ = 1.8559522628784,
    maxZ = 3.8663694858551,
})

local WeedPoly3 = PolyZone:Create({
    vector2(5066.2783203125, -4590.0454101562),
    vector2(5065.7491015625, -4591.5809179688),
    vector2(5068.6025390625, -4592.52),
    vector2(5068.9663085938, -4590.8774414062)
  }, {
    name="weed3",
    minZ = 1.8674008846283,
    maxZ = 4.030305147171,
})

WeedPoly1:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        insideWeedPoly = true
        exports['qb-core']:DrawText('[E] - Start Harvesting', 'left')
    else
        insideWeedPoly = false
        exports['qb-core']:HideText()
    end
end)

WeedPoly2:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        insideWeed2Poly = true
        exports['qb-core']:DrawText('[E] - Start Processing', 'left')
    else
        insideWeed2Poly = false
        exports['qb-core']:HideText()
    end
end)

WeedPoly3:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        insideWeed3Poly = true
        exports['qb-core']:DrawText('[E] - Start Packaging', 'left')
    else
        insideWeed3Poly = false
        exports['qb-core']:HideText()
    end
end)

CokePoly1:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        insideCokePoly = true
        exports['qb-core']:DrawText('[E] - Start Harvesting', 'left')
    else
        insideCokePoly = false
        exports['qb-core']:HideText()
    end
end)

CokePoly2:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        insideCoke2Poly = true
        exports['qb-core']:DrawText('[E] - Start Processing', 'left')
    else
        insideCoke2Poly = false
        exports['qb-core']:HideText()
    end
end)

CokePoly3:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        insideCoke3Poly = true
        exports['qb-core']:DrawText('[E] - Start Packaging', 'left')
    else
        insideCoke3Poly = false
        exports['qb-core']:HideText()
    end
end)

local ToggleHarvesting = function(type)
    harvesting = not harvesting
    crop = type
    if harvesting then
        Wait(2000)
        exports['qb-core']:DrawText('[E] - Stop Harvesting', 'left')
    else
        Wait(2000)
        exports['qb-core']:DrawText('[E] - Start Harvesting', 'left')
    end
end

local ToggleProcessing = function(type)
    processing = not processing
    crop = type
    if processing then
        exports['qb-core']:DrawText('[E] - Stop Processing', 'left')
    else
        exports['qb-core']:DrawText('[E] - Start Processing', 'left')
    end
end

local TogglePackaging = function(type)
    packaging = not packaging
    crop = type
    if packaging then
        exports['qb-core']:DrawText('[E] - Stop Packaging', 'left')
    else
        exports['qb-core']:DrawText('[E] - Start Packaging', 'left')
    end
end

RegisterNetEvent('qb-cayoperico:client:CuttingBricks', function(type)
    QBCore.Functions.Progressbar("Cutting brick", "Cutting brick...", 6000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-cayoperico:server:CuttingBricks', type)
    end, function() -- Cancel
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('qb-cayoperico:client:DepositCrop', function()
    QBCore.Functions.Progressbar("Opening laptop", "Depositing Crop...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-cayoperico:server:DepositHarvest')
    end, function() -- Cancel
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('qb-cayoperico:client:ExchangeCrop', function()
    QBCore.Functions.Progressbar("Opening laptop", "Exchanging Note...", 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-cayoperico:server:ExchangeNote')
    end, function() -- Cancel
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

CreateThread(function()
    while true do
        Wait(3)
        local ped = PlayerPedId()
        local onFoot = IsPedOnFoot(ped)
        if LocalPlayer.state.isLoggedIn and onFoot then
            if insideWeedPoly then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed(38)
                    ToggleHarvesting("weed")
                    if not harvesting then
                        if IsPedUsingScenario(ped, 'PROP_HUMAN_BUM_BIN') then
                            FreezeEntityPosition(ped, false)
                            ClearPedTasksImmediately(ped)
                        end
                    end
                end
            elseif insideCokePoly then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed(38)
                    ToggleHarvesting("coke")
                    if not harvesting then
                        if IsPedUsingScenario(ped, 'PROP_HUMAN_BUM_BIN') then
                            FreezeEntityPosition(ped, false)
                            ClearPedTasksImmediately(ped)
                        end
                    end
                end
            elseif insideWeed2Poly and PlayerJob.name == "cayoperico" then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed(38)
                    ToggleProcessing("weed")
                    if not processing then
                        if IsPedUsingScenario(ped, 'PROP_HUMAN_BUM_BIN') then
                            FreezeEntityPosition(ped, false)
                            ClearPedTasksImmediately(ped)
                        end
                    end
                end
            elseif insideCoke2Poly and PlayerJob.name == "cayoperico" then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed(38)
                    ToggleProcessing("coke")
                    if not processing then
                        if IsPedUsingScenario(ped, 'PROP_HUMAN_BUM_BIN') then
                            FreezeEntityPosition(ped, false)
                            ClearPedTasksImmediately(ped)
                        end
                    end
                end
            elseif insideWeed3Poly and PlayerJob.name == "cayoperico" and PlayerJob.grade.level >= 1 then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed(38)
                    TogglePackaging("weed")
                    if not packaging then
                        if IsPedUsingScenario(ped, 'PROP_HUMAN_BUM_BIN') then
                            FreezeEntityPosition(ped, false)
                            ClearPedTasksImmediately(ped)
                        end
                    end
                end
            elseif insideCoke3Poly and PlayerJob.name == "cayoperico" and PlayerJob.grade.level >= 1 then
                if IsControlJustPressed(0, 38) then
                    exports['qb-core']:KeyPressed(38)
                    TogglePackaging("coke")
                    if not packaging then
                        if IsPedUsingScenario(ped, 'PROP_HUMAN_BUM_BIN') then
                            FreezeEntityPosition(ped, false)
                            ClearPedTasksImmediately(ped)
                        end
                    end
                end
            else
                Wait(2000)
            end
        else
            Wait(10000)
        end
    end
end)

-- animation loop
CreateThread(function()
    while true do
        Wait(1)
        if LocalPlayer.state.isLoggedIn then
            if harvesting or packaging or processing then
                Wait(100)
                local ped = PlayerPedId()
                FreezeEntityPosition(ped, true)
                TaskStartScenarioInPlace(ped, 'PROP_HUMAN_BUM_BIN',0,true)   
                Wait(duration - 600)
                if harvesting or packaging or processing then
                    ClearPedTasksImmediately(ped)
                    FreezeEntityPosition(ped, false)
                end
                Wait(500)
                if harvesting or packaging or processing then
                    TaskGoStraightToCoord(ped, GetEntityCoords(ped),-1,1)
                end
            else
                Wait(2000)
            end
        else
            Wait(5000)
        end
    end
end)

-- give item loop
CreateThread(function()
    while true do
        Wait(duration)
        if LocalPlayer.state.isLoggedIn then
            if harvesting then
                if IsPedOnFoot(PlayerPedId()) then
                    if Config.LockPick == 'ps-ui' then
                        exports['ps-ui']:Circle(function(result)
                            if result then
                                TriggerServerEvent('qb-cayoperico:server:GetCrop', crop)
                            end
                        end, 4, 60)
                    elseif Config.LockPick == 'qb-lock' then
                        local result = exports['qb-lock']:StartLockPickCircle(4, 60, success) -- qb-lock export
                        if result then
                            TriggerServerEvent('qb-cayoperico:server:GetCrop', crop)
                        end
                    else -- No minigame
                        TriggerServerEvent('qb-cayoperico:server:GetCrop', crop)
                    end
                end
            elseif processing then
                if IsPedOnFoot(PlayerPedId()) then
                    TriggerServerEvent('qb-cayoperico:server:GetProcessed', crop)
                end
            elseif packaging then
                if IsPedOnFoot(PlayerPedId()) then
                    TriggerServerEvent('qb-cayoperico:server:GetPackaged', crop)
                end
            end
        end
    end
end)
