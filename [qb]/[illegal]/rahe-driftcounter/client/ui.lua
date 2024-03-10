Modules.UI = {}

function startDriftCounterUpdate()
    -- Update drift points counter
    CreateThread(function()
        local lastValue

        while Modules.DriftCounter.ChainLoopStarted do
            local currentPoints = Modules.DriftCounter.CurrentPoints

            if currentPoints ~= lastValue then
                lastValue = currentPoints
                SendNUIMessage({ action = "updateDriftCounter", points = currentPoints })
            end

            Wait(0)
        end
    end)

    -- Update drift time remaining bar
    CreateThread(function()
        local lastValue

        while Modules.DriftCounter.ChainLoopStarted do
            local percentage = math.ceil((Modules.DriftCounter.ChainTimeLeft / shConfig.driftChainTime) * 100)

            if percentage ~= lastValue then
                lastValue = percentage
                SendNUIMessage({ action = 'updateTimeRemaining', timeRemainingPercentage = (percentage < 100 and percentage or 0) })
            end

            Wait(0)
        end
    end)

    -- Update drift angle bar
    CreateThread(function()
        if shConfig.displayAngle then
            local lastValue

            while Modules.DriftCounter.ChainLoopStarted do
                local displayAngle = math.floor(Modules.DriftCounter.CurrentAngle)

                if displayAngle ~= lastValue then
                    lastValue = displayAngle
                    SendNUIMessage({ action = 'updateAngle', angle = displayAngle, anglePercentage = displayAngle / shConfig.maxAngle * 100 })
                end

                Wait(0)
            end
        end
    end)
end