shConfig = {
    -- Time (in ms) how long the player has between drifts until his drifting chain gets reset.
    driftChainTime = 4000,

    -- Time (in ms) how long drifting will be disabled for after player crashes his car.
    crashResetTime = 4100, -- Time in MS

    -- If static points should be given to the player every frame if he is drifting.
    addStaticPointOnDrifting = true,
    staticPointToAdd = 0.0625,

    -- If speed points should be given to the player every frame if he is drifting.
    addSpeedPointOnDrifting = true,

    -- If angle points should be given to the player every frame if he is drifting.
    addPointBasedOnAngle = true,

    -- Client-side events that will get triggered when client events occur inside the script.
    -- DO NOT CHANGE these if you don't know what you are doing. The default event names are used by rahe-drifting and changing these might break it.
    driftStartEvent = "drift:start", -- On drift start.
    driftFinishedEvent = "drift:finish", -- On drift end (the amount of points is the first param).
    enableEvent = "drift:enable", -- Enable drift counter.
    disableEvent = "drift:disable", -- Disable drift counter.
    toggleEvent = "drift:toggle", -- Toggle drift counter.

    getCurrentDriftScore = "drift:getCurrentDriftScore", -- Get current drift score.
    -- Example usage
    -- TriggerEvent("drift:getCurrentDriftScore", function(score)
    --     print("Score: ", score)
    -- end)

    isDrifting = "drift:isDrifting", -- Return true or false if the player is drifting or not
    -- Example usage
    -- TriggerEvent("drift:isDrifting", function(isDrifting)
    --     print("Drifting status: ", isDrifting)
    -- end)

    isEnabled = "drift:isEnabled", -- Checks if the counter is enabled
    -- Example usage
    -- TriggerEvent("drift:isEnabled", function(isEnabled)
    --     print("Drifting enabled: ", isEnabled)
    -- end)

    useVehicleAllowlist = false, -- Allow only listed vehicule to use the drift counter
    allowedVehicles = {
        [GetHashKey("180sx")] = true,
        [GetHashKey("gtr")] = true,
        [GetHashKey("futo")] = true,
    },

    displayAngle = true,
    maxAngle = 50
}