Config = {
    Lan = "en",

    Debug = false,

    --- FRAMEWORK OPTIONS ---
    Menu = "ox",        -- Supports "qb"    (qb-menu)
                        -- "ox"             (ox_lib/qbx_core)
                        -- "gta"            (warmenu)

    Notify = "ox",     -- Supports "qb"    (qb-core)
                        -- "ox"             (ox_lib/qbx_core)
                        -- "gta"            (gta native)
                        -- "esx"            (esx_notify)

    drawText = "ox",   -- Supports "qb"    (qb-core)
                        -- "ox"             (ox_lib/qbx_core)
                        -- "gta"            (gta native)
                        -- "esx"            (ESX.TextUI)

    Callback = "qb",    -- Supports "qb"    (qb-core)
                        -- "ox"             (ox_lib/qbx_core)

    Target = "ox",      -- Supports "qb"    (qb-target)
                        -- "ox"             (ox_target)

    Fuel = "cdn-fuel",   -- Export for fuel scripts
                        -- this is purely because hud fuel isn't updated with just SetVehicleFuelLevel for cars you dont drive

                        --- GENERAL OPTIONS
    metric = false,     -- true for Km, false for Miles

    -- Charging options --
    money = "qb",       -- Supports "qb"    (qb-core)
                        -- "ox"             (ox_lib/qbx_core)
                        -- "esx"            (es_extended)

    charge = "cash",    -- "bank" or "cash"
                        -- "bank" only supported by "qb-core", "qbx_core" and "es_extended" currently
                        -- "cash" supported by "qb" and "ox"

    --- TAXI OPTIONS ---
    taxiEnable = true,  -- Enables the Taxi feature
    freeTaxi = true,    -- Enable this to make taxi's free

    canSkip = false,     -- true to enable taxi "teleport" skip to destination (for extra cost)

    cam = true,         -- Enable to get in car cam when choosing locations

    CommandCall = true,     -- If enabled, players can use a command to call taxis
    Command = "calltaxi",    -- Set the /command for players to use (default "calltaxi")

    CellAnim = false,

    -- Payphone Stuff
    PayPhones = true,    -- If enabled, only way to access taxis will targets on be the below payphone models
    ShowNearbyPayPhones = true, -- If enabled, creates a loop that checks for payphone models nearby and shows them on minimap
    PayPhoneModels = { -- List of possible phoneboxes/payphones that can be targetted to call for taxis
        `p_phonebox_01b_s`,
        `prop_phonebox_01a`,
        `prop_phonebox_01b`,
        `prop_phonebox_01c`,
        `prop_phonebox_02`,
        `prop_phonebox_03`,
        `prop_phonebox_04`,
        `ch_chint02_phonebox001`,
        `sf_prop_sf_phonebox_01b_s`,
        `sf_prop_sf_phonebox_01b_straight`,
    },

    -- AUTO PILOT OPTIONS -- ** experitmental + overpowered **
    autoEnable = true,      -- change this to enable or disable the autopilot features
    enableKeyPress = true,  -- Enable the Key to enable

    --- AMBULANCE OPTIONS ---
    ambiEnable = false,
    QuickRevive = false,
    TakeToHospital = false, -- Enable if you wish the ambulance to take players to pillbox

    QuickReviveCost = 0,
    TakeToHospitalCost = 0,

    --- PLANE OPTIONS ---
    planeEnable = true,
    CayoPericoPort = false,  -- Enable if you want to use Cayo Perico's

    PlaneCost = 2500,  -- set to 0 for free mode

    Airports = {
        { coords = vec4(-1040.96, -2747.39, 21.36, 331.39), start = "AIRP" },
        { coords = vec4(1752.15, 3290.56, 41.1109, 180.0), start = "DESRT" },
        { coords = vec4(4452.52, -4477.48, 4.3, 200.34), start = "ISHEIST" }
    },

    AirportSpawn = {
        ["DESRT"] = {
            Model = "velum2", -- plane model for this location
            Spawn = vec4(1699.42, 3249.53, 40.95, 104.45), -- Where the plane will spawn
            Taxi = { -- For taking off
                vec3(1699.42, 3249.53, 40.41),
                vec3(1671.07, 3241.90, 40.41),
                vec3(1642.72, 3234.27, 40.41),
                vec3(1614.37, 3226.64, 40.41),
                vec3(1586.02, 3219.01, 40.41),
                vec3(1557.67, 3211.38, 40.41),
                vec3(1529.32, 3203.75, 40.41),
                vec3(1500.97, 3196.12, 40.41),
                vec3(1472.62, 3188.49, 40.41),
                vec3(1444.27, 3180.86, 40.41),
                vec3(1415.92, 3173.23, 40.41),
                vec3(1387.57, 3165.60, 40.41),
                vec3(1359.22, 3157.97, 40.41),
                vec3(1330.87, 3150.34, 40.41),
                vec3(1302.52, 3142.71, 40.41),
                vec3(1274.17, 3135.08, 40.41),
                vec3(1245.82, 3127.45, 40.41),
                vec3(1217.47, 3119.82, 40.41),
                vec3(1189.12, 3112.19, 40.41),
                vec3(1160.77, 3104.56, 40.41),
                vec3(1132.33, 3096.91, 40.41)
            },
            Runway = {
                vec3(1054.56, 3075.58, 44.58), -- Runway Start
                vec3(1704.21, 3249.76, 44.7) -- Runway End
            },
            Exit = vec4(1758.04, 3290.72, 41.13, 206.52) -- Exit teleport coords
        },
        ["AIRP"] = {
            Model = "nimbus", -- plane model for this location
            Spawn = vec4(-969.17, -3355.53, 13.99, 56.94), -- Where the plane will spawn
            Taxi = { -- For taking off
                vec3(-1121.69, -3266.58, 15.11),
                vec3(-1149.04, -3250.27, 15.08),
                vec3(-1176.39, -3233.96, 15.05),
                vec3(-1203.74, -3217.65, 15.02),
                vec3(-1231.09, -3201.34, 14.99),
                vec3(-1258.44, -3185.03, 14.96),
                vec3(-1285.79, -3168.72, 14.93),
                vec3(-1313.14, -3152.41, 14.90),
                vec3(-1340.49, -3136.10, 14.87),
                vec3(-1367.84, -3119.79, 14.84),
                vec3(-1395.19, -3103.48, 14.81),
                vec3(-1422.54, -3087.17, 14.78),
                vec3(-1449.89, -3070.86, 14.75),
                vec3(-1477.24, -3054.55, 14.72),
                vec3(-1504.59, -3038.24, 14.69),
                vec3(-1531.94, -3021.93, 14.66),
                vec3(-1559.29, -3005.62, 14.63),
                vec3(-1586.64, -2989.31, 14.60),
                vec3(-1613.99, -2972.99, 14.57),
                vec3(-1641.34, -2956.68, 14.54),
                vec3(-1668.69, -2940.37, 14.51),
                vec3(-1688.73, -2926.70, 14.48)
            },
            Runway = { -- For landing
                vec3(-1729.57, -2892.78, 14.9441), -- Runway Start
                vec3(-1343.55, -2223.37, 14.9441), -- Runway End
            },
            Exit = vec4(-1036.51, -2735.76, 20.17, 329.58) -- Exit teleport coords
        },
        ["ISHEIST"] = {
            Model = "velum2", -- plane model for this location
            Spawn = vec4(4447.67, -4511.41, 4.18, 108.72), -- Where the plane will spawn
            Taxi = { -- For taking off
                vec3(4353.55, -4545.44, 4.82),
                vec3(4137.09, -4624.77, 5.55),
            },
            Runway = {
                vec3(3962.47, -4688.73, 6.19), -- Runway Start
                vec3(4441.32, -4513.98, 4.56), -- Runway End
            },
            Exit = vec4(4461.53, -4476.85, 4.25, 242.09) -- Exit teleport coords
        },
    },

    --- HELICOPTER OPTIONS ---
    heliEnable = true,
    CayoPericoHeli = false,  -- Enable if you want to use Cayo Perico's

    HeliCost = 0,   -- set to 0 for free mode

    Helipads = {
        { coords = vec4(-1044.75, -2745.53, 21.36, 326.68), start = "AIRP" },
        { coords = vec4(1775.61, 3248.56, 41.98, 356.37), start = "DESRT" },
        { coords = vec4(4517.28, -4458.87, 4.2, 20.84), start = "ISHEIST" }
    },

    HelipadSpawn = {
        ["DESRT"] = {
            Model = "frogger",
            Spawn = vec4(1771.27, 3239.82, 42.15, 100.43), -- Where the plane will spawn
            Pad = vec3(1748.14, 3243.44, 41.72),
            Exit = vec4(1763.84, 3248.52, 41.72, 14.77) -- Exit teleport coords
        },
        ["AIRP"] = {
            Model = "frogger",
            Spawn = vec4(-1178.4, -2846.14, 13.95, 147.1), -- Where the plane will spawn
            Pad = vec3(-1145.98, -2864.62, 13.94),
            Exit = vec4(-1036.51, -2735.76, 20.17, 329.58) -- Exit teleport coords
        },
        ["ISHEIST"] = {
            Model = "frogger",
            Spawn = vec4(4523.39, -4468.17, 6.06, 210.39), -- Where the plane will spawn
            Pad = vec3(4523.39, -4468.17, 6.06),
            Exit = vec4(4511.21, -4461.09, 4.2, 43.59) -- Exit teleport coords
        },
    },


    --- PED MODELS ---
    TaxiPeds = { -- Peds that can spawn as taxi drivers
        "S_M_M_Bouncer_01",
        "A_M_M_EastSA_02",
        "a_m_m_golfer_01",
        "a_m_m_tranvest_01",
    },
    LimoPeds = {
        "IG_FBISuit_01",
    },
    AmbiPeds = {
        "S_M_M_Paramedic_01",
    },

    --- VEHICLE MODELS ---
    Taxis = { -- Possible taxi vehicle models
        "taxi",
        "raiden",
        --"ruiner3", -- lamo random xd
        --"cheburek", -- funny but they drive like psychos
        "felon",
        "dilettante",
    },
    Limos = { -- Limo models
        "stretch",
    },
    Amublances = {
        "tr_emsambo",
    }
}

CoreExport = "qb-core"