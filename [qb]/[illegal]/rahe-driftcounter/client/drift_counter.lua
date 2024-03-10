Modules = {}
Modules.DriftCounter = {}
Modules.DriftCounter.IsEnabled = false
Modules.DriftCounter.IsDrifting = false
Modules.DriftCounter.CurrentPoints = 0
Modules.DriftCounter.CurrentAngle = 0
Modules.DriftCounter.ChainCooldown = shConfig.driftChainTime
Modules.DriftCounter.ChainLoopStarted = false
Modules.DriftCounter.ChainTimeLeft = 0
Modules.DriftCounter.CachedAllowedVeh = {}

-- Source: https://github.com/Equilibrium-Studio/EasyDrift
-- Source: https://github.com/Blumlaut/FiveM-DriftCounter/blob/master/driftcounter_c.lua
function Modules.DriftCounter.GetCurrentAngle()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local vx, vy, _ = table.unpack(GetEntityVelocity(veh))
        local modV = math.sqrt(vx * vx + vy * vy)

        local _, _, rz = table.unpack(GetEntityRotation(veh, 0))
        local sn, cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))

        if GetEntitySpeed(veh) * 3.6 < 25 or GetVehicleCurrentGear(veh) == 0 then
            return 0, modV
        end --speed over 25 km/h

        local cosX = (sn * vx + cs * vy) / modV
        return math.deg(math.acos(cosX)) * 0.5, modV
    else
        return 0
    end
end

-- Cleaning the cache to avoid any memory leak as the system will load up every vehicle entity the player goes in. If the entity is deleted or not in range it will be removed from the list to avoid memory leaks.
function Modules.DriftCounter.CleanUpCache()
    for veh, _ in pairs(Modules.DriftCounter.CachedAllowedVeh) do
        if not DoesEntityExist(veh) then
            Modules.DriftCounter.CachedAllowedVeh[veh] = nil
        end
    end
end

function Modules.DriftCounter.IsVehicleAllowedToDrift(pVeh)
    if not shConfig.useVehicleAllowlist then
        return true
    end

    if Modules.DriftCounter.CachedAllowedVeh[pVeh] == nil then
        local pVehModel = GetEntityModel(pVeh)
        if shConfig.allowedVehicles[pVehModel] ~= nil then
            Modules.DriftCounter.CachedAllowedVeh[pVeh] = true
        else
            Modules.DriftCounter.CachedAllowedVeh[pVeh] = false
        end
        Modules.DriftCounter.CleanUpCache()
    else
        return Modules.DriftCounter.CachedAllowedVeh[pVeh] -- Using a cache system allow better performance, we don't check the vehicle model every time.
    end

end

function Modules.DriftCounter.IsPlayerDrifting()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        return false
    end

    local pVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    if not Modules.DriftCounter.IsVehicleAllowedToDrift(pVeh) then
        return false
    end

    if GetEntityHeightAboveGround(pVeh) > 1.5 then
        return false
    end

    if PlayerPedId() ~= GetPedInVehicleSeat(pVeh, -1) then
        return false
    end

    Modules.DriftCounter.CurrentAngle = Modules.DriftCounter.GetCurrentAngle()
    if Modules.DriftCounter.CurrentAngle < 10 then
        return false
    end

    return true
end

local hasCrashOccured
local isCrashActive = false
local lastCrashTime = 0
function startCrashDetectThread()
    CreateThread(function()
        local playerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)

        while Modules.DriftCounter.ChainLoopStarted do
            if playerVehicle and HasEntityCollidedWithAnything(playerVehicle) then
                isCrashActive = true
                hasCrashOccured = true
                lastCrashTime = GetGameTimer()
                SendNUIMessage({action = 'setCrashStatus', status = true})
            end

            Wait(0)
        end
    end)

    CreateThread(function()
        while true do
            if isCrashActive then
                if GetGameTimer() - lastCrashTime >= shConfig.crashResetTime then
                    isCrashActive = false
                    SendNUIMessage({action = 'setCrashStatus', status = false})
                end

                Wait(50)
            else
                Wait(250)
            end

        end
    end)
end

function Modules.DriftCounter.StartChainBreakLoop()
    if not Modules.DriftCounter.ChainLoopStarted then
        Modules.DriftCounter.ChainLoopStarted = true

        startDriftCounterUpdate()
        startCrashDetectThread()

        Modules.DriftCounter.FadeInHud()

        TriggerEvent(shConfig.driftStartEvent)
        Citizen.CreateThread(function()
            Modules.Utils.RealWait(Modules.DriftCounter.ChainCooldown, function(cb, timeLeft)
                Modules.DriftCounter.ChainTimeLeft = timeLeft - (timeLeft * 2) -- Duh
                if Modules.DriftCounter.IsDrifting or hasCrashOccured then
                    hasCrashOccured = false
                    cb(false, shConfig.driftChainTime)
                end
            end)


            Modules.DriftCounter.FadeOutHud()

            TriggerEvent(shConfig.driftFinishedEvent, Modules.DriftCounter.CurrentPoints)
            Modules.DriftCounter.ChainCooldown = shConfig.driftChainTime
            Modules.DriftCounter.ChainLoopStarted = false
            Modules.DriftCounter.CurrentPoints = 0
            Modules.DriftCounter.CurrentAngle = 0
            Modules.DriftCounter.ChainTimeLeft = 0
        end)
    end
end

function Modules.DriftCounter.FadeInHud()
    SendNUIMessage({ action = "showDriftCounter" })
end

function Modules.DriftCounter.FadeOutHud()
    SendNUIMessage({ action = "hideDriftCounter" })
end

Citizen.CreateThread(function()
    while true do
        if Modules.DriftCounter.IsEnabled then
            if Modules.DriftCounter.IsPlayerDrifting() and not isCrashActive then
                Modules.DriftCounter.IsDrifting = true
                Modules.DriftCounter.StartChainBreakLoop()
                if Modules.DriftCounter.CurrentAngle > 10 then
                    -- Static
                    if shConfig.addStaticPointOnDrifting then
                        Modules.DriftCounter.CurrentPoints = math.floor(Modules.DriftCounter.CurrentPoints + shConfig.staticPointToAdd * Modules.Utils.TimeFrame) -- This fix the issue where player with low fps would get less point then player with high fps count.
                    end

                    -- Angle
                    if shConfig.addPointBasedOnAngle then
                        local angle = Modules.DriftCounter.CurrentAngle < shConfig.maxAngle and Modules.DriftCounter.CurrentAngle or shConfig.maxAngle
                        Modules.DriftCounter.CurrentPoints = math.floor(Modules.DriftCounter.CurrentPoints + (0.0012 * (angle ^ 1.2) * Modules.Utils.TimeFrame)) -- This fix the issue where player with low fps would get less point then player with high fps count.
                    end

                    -- Speed
                    if shConfig.addSpeedPointOnDrifting then
                        local speedKmh = (GetEntitySpeed(PlayerPedId()) * 3.6)
                        Modules.DriftCounter.CurrentPoints = math.floor(Modules.DriftCounter.CurrentPoints + (0.0022 * (speedKmh ^ 1.25) * Modules.Utils.TimeFrame)) -- This fix the issue where player with low fps would get less point then player with high fps count.
                    end
                end
            else
                Modules.DriftCounter.IsDrifting = false
                if Modules.DriftCounter.ChainLoopStarted then
                    Wait(0) -- Chain active, so we need to check if the player start drifting again or not as fast as possible
                else
                    Wait(100) -- Could be longer i guess, but will take more time to detect if the player is drifting or not.
                end
            end
        else
            Wait(1000) -- Sleep if disabled
        end

        Wait(0)
    end
end)

AddEventHandler('drift:reduce', function(amountToReduce)
    Modules.DriftCounter.CurrentPoints = Modules.DriftCounter.CurrentPoints - amountToReduce
end)

AddEventHandler(shConfig.getCurrentDriftScore, function(cb)
    cb(Modules.DriftCounter.CurrentPoints)
end)

AddEventHandler(shConfig.isDrifting, function(cb)
    cb(Modules.DriftCounter.IsDrifting)
end)

AddEventHandler(shConfig.isEnabled, function(cb)
    cb(Modules.DriftCounter.IsEnabled)
end)

AddEventHandler(shConfig.enableEvent, function()
    Modules.DriftCounter.IsEnabled = true
end)

AddEventHandler(shConfig.disableEvent, function()
    Modules.DriftCounter.IsEnabled = false
    Modules.DriftCounter.IsDrifting = false
end)

AddEventHandler(shConfig.toggleEvent, function()
    Modules.DriftCounter.IsEnabled = not Modules.DriftCounter.IsEnabled
end)
