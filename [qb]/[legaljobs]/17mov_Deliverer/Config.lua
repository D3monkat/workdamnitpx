Config = {}

Config.useModernUI = true               -- In March 2023 the jobs have passed huge rework, and the UI has been changed. Set it to false, to use OLD no longer supported UI.
    Config.splitReward = false          -- This option work's only when useModernUI is false. If this option is true, the payout is: (Config.OnePercentWorth * Progress ) / PartyCount, if false then: (Config.OnePercentWorth * Progress)
Config.UseBuiltInNotifications = true   -- Set to false if you want to use ur framework notification style. Otherwise, the built in modern notifications will be used.=
Config.letBossSplitReward = true                    -- If it's true, then boss can manage whole party rewards percent in menu. If you'll set it to false, then everybody will get same amount.
Config.multiplyRewardWhileWorkingInGroup = true     -- If it's false, then reward will stay by default. For example $1000 for completing whole job. If you'll set it to true, then the payout will depend on how many players is there in the group. For example, if for full job there's $1000, then if player will work in 4 member group, the reward will be $4000. (baseReward * partyCount)

Config.UseTarget = false                                            -- Change it to true if you want to use a target system. All setings about the target system are under target.lua file.
Config.RequiredJob = "none"                                         -- Set to "none" if you dont want using jobs. If you are using target, you have to set "job" parameter inside every export in target.lua
Config.RequireJobAlsoForFriends = true          -- If it's false, then only host needs to have the job, if it's true then everybody from group needs to have the Config.RequiredJob
Config.RequireOneFriendMinimum = false                              -- Set to true if you want to force players to create teams
Config.JobVehicleModel = "17mov_DeliveryCar"                        -- Vehicle Job Model
Config.VehicleBackBone = "handle_dside_r"                           -- Only used when Config.Target == false. On coords of this bone, the 3D Text about interact with vehicle is displayed.
Config.VehicleBootOffset = 5                                        -- Means 5 meters back from basic vehicle coords. Used when trying to take parcel out of the vehicle.
Config.VehicleSearchingScenario = "prop_human_parking_meter"        -- Scenario used while "searcing" inside vehicle.
Config.Price = math.random(50,250)                                                  -- 100$ per one delivery
Config.BlockHostFromWorking = true                                  -- Means that if players are working in group, then the host only can drive veh, parntner needs to deliver. Set to false if you want also host to be able to deliver
Config.EnableVehicleTeleporting = true                              -- If its true, then the script will teleport the host to the company vehicle. If its false, then the company vehicle will apeear, but the whole squad need to go enter the car manually
Config.enableSpawningPedsInDoors = true                             -- Set to false if you don't want to use peds in doors. 
Config.JobCooldown = 0 * 60 -- 10 * 60            -- 0 minutes cooldown between making jobs (in brackets there's example for 10 minutes)
Config.GiveKeysToAllLobby = true                                    -- Set to false if you want to give keys only for group creator while starting job
Config.ProgressBarOffset = "25px"                   -- Value in px of counter offset on screen
Config.ProgressBarAlign = "bottom-right"            -- Align of the progressbar

Config.keybindSettings = {
    bagsInteractionKey = 38,
    bagsInteractionkeyString = "~r~[E] | ~s~"
}

-- ^ Options: top-left, top-center, top-right, bottom-left, bottom-center, bottom-right

Config.RewardItemsToGive = {
    -- {
    --     item_name = "water",
    --     chance = 100,
    --     amountPerDelivery = 1,
    -- },
}

Config.RequireWorkClothes = false                   -- Set it to true, to change players clothes everytime when they're starting job.

Config.PenaltyAmount = 500                      -- Penalty that is levied when a player finishes work without a company vehicle
Config.DontPayRewardWithoutVehicle = false      -- Set to true if you want to dont pay reward to players who want's to end without company vehicle (accepting the penalty)
Config.DeleteVehicleWithPenalty = false         -- Delete Vehicle even if its not company veh

Config.RequiredItem = "none"                        -- Set it to anything you want, to require players to have some item in their inventory before they start the job
Config.RequireItemFromWholeTeam = true              -- If it's false, then only host needs to have the required item, otherwise all team needs it.

Config.RestrictBlipToRequiredJob = false            -- Set to true, to hide job blip for players, who dont have RequiredJob. If requried job is "none", then this option will not have any effect.
Config.Blips = {                                                    -- Here you can configure Company blip.
    [1] = {
        Sprite = 568,
        Color = 48,
        Scale = 0.8,
        Pos = vector3(78.66, 111.75, 81.17),
        Label = 'Deliverer Job'
    },
}

Config.MarkerSettings = {                                           -- used only when Config.UseTarget = false. Colors of the marker. Active = when player stands inside the marker.
    Active = {
        r = 252, 
        g = 78,
        b = 3,
        a = 200,
    },
    UnActive = {
        r = 143,
        g = 48,
        b = 7,
        a = 200,
    }
}

Config.Locations = {                                               -- Here u can change all of the base job locations. 
    DutyToggle = {
        Coords = {
            vector3(78.5, 111.98, 81.17),
        },
        CurrentAction = 'open_dutyToggle',
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to ~y~start/finish~s~ work.',
        type = 'duty',
        scale = {x = 1.0, y = 1.0, z = 1.0}
    },
    FinishJob = {
        Coords = {
            vector3(72.67, 120.83, 79.18),
        },
        CurrentAction = 'finish_job',
        CurrentActionMsg = 'Press ~INPUT_CONTEXT~ to ~y~end ~s~working.',
        scale = {x = 3.0, y = 3.0, z = 3.0}
    },

}

Config.SpawnPoint = vector4(72.67, 120.83, 79.18, 158.66)  -- Vehicle spawn point
Config.EnableCloakroom = true                                 -- Set to false if you want to hide the "CLoakroom" button under WorkMenu

Config.Clothes = {
    male = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 11, variation = 0},
        ["pants"] = {clotheId = 10, variation = 2},
        ["bag"] = {clotheId = 0, variation = 0},
        ["shoes"] = {clotheId = 54, variation = 0},
        ["t-shirt"] = {clotheId = 57, variation = 0},
        ["torso"] = {clotheId = 13, variation = 0},
        ["decals"] = {clotheId = 0, variation = 0},
        ["kevlar"] = {clotheId = 0, variation = 0},
    },

    female = {
        ["mask"] = {clotheId = 0, variation = 0},
        ["arms"] = {clotheId = 9, variation = 0},
        ["pants"] = {clotheId = 6, variation = 2},
        ["bag"] = {clotheId = 0, variation = 0},
        ["shoes"] = {clotheId = 52, variation = 0},
        ["t-shirt"] = {clotheId = 15, variation = 0},
        ["torso"] = {clotheId = 9, variation = 1},
        ["decals"] = {clotheId = 0, variation = 0},
        ["kevlar"] = {clotheId = 0, variation = 0},
    }
}

Config.Lang = {

    -- Here you can changea all translations used in client.lua, and server.lua. Dont forget to translate it also under the HTML and JS file.

    -- Client
    ["no_permission"] = "Only the party owner can do that!",
    ["keybind"] = 'Marker Interaction',
    ["too_far"] = "Your party has started work, but you are too far from headquarters. You can still join them.",
    ["kicked"] = "You kicked %s out of the party",
    ["alreadyWorking"] = "First, complete the previous order.",
    ["quit"] = "You have left the Team",
    ["cantSpawnVeh"] = "The truck spawn site is occupied.",
    ["nobodyNearby"] = "There is no one around",
    ["TargetCoords"] = "Deliverer Destination",
    ["deliverParcel"] = "Deliver the Parcel",
    ["takeParcel"] = "Take the parcel",
    ["wait"] = "Now wait for someone to open the door",
    ["missingParcel"] = "You don't have a package with you. Take it from the car",
    ["spawnpointOccupied"] = "The car's spawn site is occupied",
    ["notADriver"] = "You need to be a driver of vehicle to end the job",
    ["cantInvite"] = "To be able to invite more people, you must first finish the job",
    ["wrongReward1"] = "The payout percentage should be between 0 and 100",
    ["wrongReward2"] = "The total percentage of all payouts exceeded 100%",
    ["tutorial"] = "The job involves delivering packages to homes. If you work in a team, one person drives the car to the designated place, while the other person takes the package from the trunk, and goes to deliver the package to the house. On the other hand, if you work alone, you have to do both tasks yourself. The payout depends on the number of packages delivered. Finish the work when you want by returning to the base and leaving the car at the designated place",
    ["partyIsFull"] = "Failed to send an invite, your group is full",
    ["inviteSent"] = "Invite Sent!",
    ["tooFar"] = "You're too far from your target location to pick a parcel",
    ["cantLeaveLobby"] = "You can't leave the lobby while you're working. First, end the job.",

    -- Server
    ["isAlreadyHost"] = "This player leads his team.",
    ["isBusy"] = "This player already belongs to another team.", 
    ["hasActiveInvite"] = "This Player already has an active invitation from someone.",
    ["HaveActiveInvite"] = "You already have an active invitation to join the team.",
    ["InviteDeclined"] = "Your invitation has been declined.",
    ["InviteAccepted"] = "Your invitation has been accepted!",
    ["error"] = "There was a Problem joining a team. Please try again later.",
    ["kickedOut"] = "You've been kicked out of the team!",
    ["reward"] = "You have received a payout of $",
    ["RequireOneFriend"] = "This job requires at least one team member",
    ["dontHaveReqItem"] = "You or someone from your team do not have the required item to start work",
    ["penalty"] = "You paid a fine in the amount of ",
    ["clientsPenalty"] = "The team's host accepted the punishment. You have not received the payment",
    ["notEverybodyHasRequiredJob"] = "Not every of your friends have the required job",
    ["someoneIsOnCooldown"] = "%s can't start the job now (cooldown: %s)", 
    ["hours"] = "h",
    ["minutes"] = "m",
    ["seconds"] = "s",
    ["newBoss"] = "The previous lobby boss has left the server. You are now the team leader",
}

-- Homes Locations:

Config.TargetLocations = {
    {-- Mirror Park: 
        vector3(1060.51, -378.2, 68.23),
        vector3(1010.45, -423.49, 65.35),
        vector3(1028.82, -408.31, 66.34),
        vector3(967.2, -451.53, 62.8),
        vector3(944.38, -463.08, 61.55),
        vector3(921.87, -477.86, 61.08),
        vector3(906.35, -489.36, 59.44),
        vector3(878.34, -497.98, 58.1),
        vector3(861.56, -508.98, 57.65),
        vector3(850.22, -532.74, 57.93),
        vector3(843.98, -562.65, 57.99),
        vector3(861.73, -583.51, 58.16),
        vector3(886.75, -608.18, 58.44),
        vector3(902.95, -615.46, 58.45),
        vector3(928.9, -639.81, 58.24),
        vector3(943.19, -653.34, 58.65),
        vector3(959.98, -669.91, 58.45),
        vector3(987.43, -433.03, 64.03),
        vector3(970.82, -701.46, 58.48),
        vector3(979.11, -716.16, 58.22),
        vector3(996.9, -729.59, 57.82),
        vector3(980.19, -627.67, 59.24),
        vector3(964.22, -596.14, 59.9),
        vector3(976.61, -580.7, 59.85),
        vector3(1009.66, -572.53, 60.59),
        vector3(999.55, -593.78, 59.63),
        vector3(1056.17, -448.91, 66.26),
        vector3(1051.08, -470.48, 64.3),
        vector3(1046.36, -498.17, 64.27),
        vector3(945.77, -519.09, 60.81),
    },
    
    {-- Grove Street: 
      vector3(85.94, -1959.76, 21.12),
      vector3(114.31, -1961.23, 21.33),
      vector3(126.91, -1929.9, 21.38),
      vector3(118.34, -1921.08, 21.32),
      vector3(100.73, -1911.99, 21.4),
      vector3(76.48, -1947.96, 21.17),
      vector3(72.08, -1938.97, 21.37),
      vector3(56.42, -1922.59, 21.91),
      vector3(39.0, -1911.58, 21.95),
      vector3(22.97, -1896.78, 22.97),
      vector3(5.21, -1884.26, 23.7),
      vector3(-4.82, -1872.19, 24.15),
      vector3(-20.65, -1859.06, 25.4),
      vector3(-34.17, -1847.08, 26.19),
      vector3(21.17, -1844.85, 24.6),
      vector3(29.75, -1854.61, 24.07),
      vector3(46.07, -1864.24, 23.28),
      vector3(54.54, -1873.15, 22.78),
      vector3(104.16, -1885.55, 24.32),
      vector3(115.3, -1888.01, 23.93),
      vector3(128.17, -1897.08, 23.67),
      vector3(148.67, -1904.45, 23.51),
      vector3(130.67, -1853.28, 25.23),
      vector3(150.03, -1864.67, 24.59),
      vector3(171.57, -1871.68, 24.4),
      vector3(192.39, -1883.39, 25.06),
      vector3(250.72, -1935.12, 24.72),
      vector3(258.35, -1927.22, 25.44),
      vector3(270.52, -1917.07, 26.18),
      vector3(282.78, -1899.03, 27.25),
      vector3(320.23, -1854.08, 27.51),
      vector3(329.43, -1845.78, 27.75),
      vector3(338.8, -1829.65, 28.34),
    },
    
    {-- Vinewood / Luxury / Beverly :
      vector3(-1038.06, 222.25, 64.38),
      vector3(-971.58, 122.31, 57.05),
      vector3(-998.27, 158.17, 62.32),
      vector3(-1043.04, 237.24, 64.16),
      vector3(-940.42, 202.52, 67.96),
      vector3(-902.19, 191.48, 69.45),
      vector3(-830.39, 115.11, 56.04),
      vector3(-819.36, 267.95, 86.39),
      vector3(-881.39, 363.73, 85.36),
      vector3(-875.64, 485.77, 87.92),
      vector3(-842.79, 467.01, 87.6),
      vector3(-848.74, 508.59, 90.82),
      vector3(-873.38, 562.86, 96.62),
      vector3(-904.37, 588.01, 101.19),
      vector3(-924.75, 561.3, 100.16),
      vector3(-907.71, 544.98, 100.39),
      vector3(-947.77, 567.76, 101.5),
      vector3(-974.36, 581.81, 103.15),
      vector3(-1022.6, 586.94, 103.43),
      vector3(-1090.14, 548.72, 103.63),
      vector3(-1107.7, 594.53, 104.45),
      vector3(-1167.13, 568.66, 101.83),
      vector3(-1192.97, 564.04, 100.34),
      vector3(-1217.59, 506.63, 95.85),
      vector3(-1277.88, 497.13, 97.89),
      vector3(-1308.31, 448.89, 100.97),
      vector3(-1294.37, 454.34, 97.57),
      vector3(-1289.03, 500.7, 97.56),
      vector3(-1371.49, 444.12, 105.86),
      vector3(-1413.68, 462.24, 109.21),
      vector3(-1453.99, 512.2, 117.8),
      vector3(-1452.89, 545.58, 120.84),
      vector3(-1405.13, 561.92, 125.41),
      vector3(-1372.21, 585.13, 131.45),
      vector3(-1367.36, 611.04, 133.88),
      vector3(-1337.14, 605.93, 134.38),
      vector3(-1056.39, 761.52, 167.32),
      vector3(-1009.25, 765.58, 171.38),
      vector3(-1032.75, 685.94, 161.3),
      vector3(-951.24, 682.55, 153.58),
      vector3(-931.46, 690.99, 153.47),
      vector3(-908.77, 693.75, 151.44),
      vector3(-884.53, 699.23, 151.27),
      vector3(-852.83, 695.12, 148.99),
      vector3(-596.93, 851.41, 211.48),
      vector3(-658.43, 886.25, 229.3),
      vector3(-678.9, 512.09, 113.53),
    },
    
    {-- Paleto Cove
		vector3(-442.7332, 6197.9048, 29.5519),
		vector3(-447.9656, 6260.2656, 30.0478),
		vector3(-407.2643, 6314.1787, 28.9413),
		vector3(-380.0866, 6252.7510, 31.8512),
		vector3(-371.1159, 6266.8330, 31.8773),
		vector3(-347.5160, 6225.3491, 31.8849),
		vector3(-356.8997, 6207.5635, 31.8453),
		vector3(-374.5617, 6190.9844, 31.7295),
		vector3(-332.5815, 6302.1470, 33.0894),
		vector3(-302.1783, 6326.9878, 32.8874),
		vector3(-280.5193, 6350.6924, 32.6005),
		vector3(-247.7391, 6369.9751, 31.8480),
		vector3(-227.1711, 6377.3184, 31.7592),
		vector3(-272.5939, 6400.9214, 31.5049),
		vector3(-213.5938, 6396.2188, 33.0851),
		vector3(-245.9163, 6414.4048, 31.4609),
		vector3(-229.6180, 6445.5410, 31.1974),
		vector3(-188.9087, 6409.6362, 32.2979),
		vector3(-130.7822, 6551.8555, 29.8726),
		vector3(-105.6279, 6528.4644, 30.1669),
		vector3(-44.2822, 6582.0112, 32.1754),
		vector3(-26.5352, 6597.1646, 31.8615),
		vector3(-41.5671, 6637.3848, 31.0875),
		vector3(1.8436, 6612.5825, 32.0783),
		vector3(-9.5346, 6654.2510, 31.6987),
		vector3(35.3683, 6663.1484, 32.1904),
		vector3(25.0593, 6601.7456, 32.4702),
		vector3(11.5247, 6578.3208, 33.0680),
		vector3(-15.2698, 6557.3887, 33.2404),
    },
    
    {-- Sandy Shores
		vector3(1936.5343, 3891.7048, 32.9660),
		vector3(1907.9694, 3870.1423, 32.8873),
		vector3(1895.3854, 3873.7349, 32.7546),
		vector3(1894.2567, 3895.9536, 33.1758),
		vector3(1915.8472, 3909.3054, 33.4416),
		vector3(1880.4668, 3920.5144, 33.2131),
		vector3(1859.3314, 3865.1721, 33.0588),
		vector3(1832.6194, 3868.5867, 34.2978),
		vector3(1813.6133, 3854.0532, 34.3544),
		vector3(1845.7345, 3914.6057, 33.4612),
		vector3(1841.8229, 3928.6067, 33.7160),
		vector3(1803.5552, 3913.8477, 37.0569),
		vector3(1786.5189, 3912.9922, 34.9110),
		vector3(1756.4033, 3871.4163, 34.8715),
		vector3(1733.5139, 3895.2866, 35.5591),
		vector3(1691.8171, 3865.7251, 34.9074),
		vector3(1728.6255, 3851.9136, 34.7835),
		vector3(1763.8185, 3823.6282, 34.7677),
		vector3(1733.4729, 3808.6064, 35.1290),
		vector3(1777.5068, 3799.9907, 34.5231),
		vector3(1746.1237, 3788.2400, 34.8349),
		vector3(1661.3657, 3819.9653, 35.4696),
		vector3(1639.2556, 3731.1453, 35.0671),
		vector3(1501.5947, 3694.9929, 35.2129),
		vector3(1430.7393, 3671.3950, 34.8290),
		vector3(1385.1843, 3659.5012, 34.9281),
		vector3(1435.3721, 3657.2271, 34.4200),
		vector3(1436.1945, 3639.0781, 34.9473),
		vector3(1774.6428, 3742.8442, 34.6551),
		vector3(1826.8835, 3729.6814, 33.9619),
		vector3(1880.6827, 3810.4888, 32.7787),
        vector3(1898.8463, 3781.7305, 32.8766),
    },
    
    {-- Vinewood Hills
		vector3(-1896.2778, 642.5568, 130.2090),
		vector3(-1974.7939, 631.0368, 122.6836),
		vector3(-1929.0251, 595.2929, 122.2898),
		vector3(-1996.3718, 591.2081, 118.1020),
		vector3(-1937.5178, 551.0701, 115.0066),
		vector3(-2014.8813, 499.9010, 107.1717),
		vector3(-1942.7184, 449.6245, 102.9277),
		vector3(-2011.1891, 445.2169, 103.0159),
		vector3(-1940.6174, 387.5656, 96.5071),
		vector3(-2009.1472, 367.3987, 94.8143),
		vector3(-1931.2488, 362.5046, 93.9752),
		vector3(-1995.5084, 301.0286, 91.9646),
		vector3(-1922.4053, 298.4567, 89.2873),
		vector3(-1861.1036, 310.3795, 89.1135),
		vector3(-1807.9282, 333.1443, 89.5684),
		vector3(-1733.1272, 379.0571, 89.7252),
		vector3(-1673.0544, 385.5844, 89.3482),
		vector3(-1905.4785, 252.9049, 86.4528),
		vector3(-1970.5217, 246.0985, 87.8121),
		vector3(-1961.2308, 211.9155, 86.8029),
		vector3(-1931.9990, 162.5955, 84.6526),
		vector3(-1899.0903, 132.3632, 81.9846),
		vector3(-1873.2402, 202.0925, 84.3629),
		vector3(-1540.0469, 420.5542, 110.0140),
		vector3(-1495.8254, 437.0356, 112.4979),
		vector3(-1453.8679, 512.2359, 117.7964),
		vector3(-1500.6329, 523.1329, 118.2721),
		vector3(-1452.9457, 545.5695, 120.9981),
		vector3(-1413.6045, 462.1275, 109.2086),
		vector3(-1371.5176, 443.9559, 105.8571),
		vector3(-1308.1466, 448.8974, 100.9698),
		vector3(-1294.0350, 454.1402, 97.6155),
		vector3(-1215.8156, 457.7998, 92.0638),
		vector3(-1174.3781, 440.1317, 86.8498),
		vector3(-1094.8983, 427.3870, 75.8796),
		vector3(-1052.1298, 432.6034, 77.2586),
		vector3(-1062.6107, 475.8785, 81.3205),
		vector3(-1122.4701, 486.2416, 82.3556),
		vector3(-1158.9462, 481.8375, 86.0938),
		vector3(-1343.0540, 481.3592, 102.7619),
		vector3(-1405.4391, 526.7250, 123.8311),
		vector3(-1405.0470, 561.9185, 125.4063),
		vector3(-1367.3549, 610.7667, 133.8814),
		vector3(-1337.0435, 606.0247, 134.3797),
		vector3(-1346.4253, 560.6721, 130.5315),
		vector3(-1405.1028, 561.9202, 125.4061),
		vector3(-1291.8151, 650.4315, 141.5014),
		vector3(-1248.8357, 643.0283, 142.7191),
		vector3(-1241.3063, 674.4846, 142.8119),
		vector3(-1218.6959, 665.1198, 144.5303),
		vector3(-1196.6896, 693.2114, 147.4287),
		vector3(-1165.6638, 726.8533, 155.6067),
		vector3(-1117.7200, 761.5005, 164.2887),
		vector3(-1130.9229, 784.5159, 163.8878),
		vector3(-1100.6418, 797.8969, 167.2566),
		vector3(-999.5895, 816.9012, 173.0496),
		vector3(-998.5234, 768.5643, 171.5826),
		vector3(-962.6918, 814.2612, 177.7594),
		vector3(-912.2087, 777.1611, 187.0264),
		vector3(-931.7864, 809.0701, 184.7804),
		vector3(-867.2475, 784.6716, 191.9343),
		vector3(-824.1008, 805.8468, 202.7844),
		vector3(-1217.7559, 506.6211, 95.8564),
		vector3(-1193.0499, 564.0475, 100.3386),
		vector3(-1277.8846, 497.1633, 97.8903),
		vector3(-1166.9827, 568.6805, 101.8273),
		vector3(-1146.5553, 545.8839, 101.9076),
		vector3(-1125.4878, 548.3510, 102.5704),
		vector3(-1107.6426, 594.5598, 104.4545),
		vector3(-1090.0519, 548.6413, 103.6333),
		vector3(-1022.6326, 586.9312, 103.4257),
		vector3(-974.3496, 581.8124, 103.1506),
		vector3(-958.0566, 606.9882, 106.3019),
		vector3(-947.9169, 567.8177, 101.5054),
		vector3(-924.8204, 561.3508, 100.1554),
		vector3(-904.4675, 588.0671, 101.1786),
		vector3(-907.6199, 545.0297, 100.2050),
		vector3(-873.2761, 562.7284, 96.6195),
		vector3(-884.5577, 517.9766, 92.4411),
		vector3(-848.7819, 508.5738, 90.8170),
		vector3(-866.6036, 457.6646, 88.2811),
		vector3(-842.7645, 466.8344, 87.5966),
		vector3(-968.7289, 436.8936, 80.7655),
		vector3(-967.1542, 510.6446, 82.0669),
		vector3(-987.2959, 487.1200, 82.4470),
		vector3(-1007.1221, 513.5518, 79.6788),
		vector3(-1009.5896, 479.1726, 79.5724),
		vector3(-1052.8890, 517.2342, 88.3298),
		vector3(-1062.6179, 475.8768, 81.3193),
		vector3(-1065.0510, 726.7988, 165.4746),
		vector3(-1032.7455, 685.9443, 161.3027),
		vector3(-951.3388, 682.5403, 153.5903),
		vector3(-908.8495, 693.7487, 151.4355),
		vector3(-884.5516, 699.4364, 151.2710),
		vector3(-852.9199, 695.2335, 148.9904),
		vector3(-819.3500, 696.6093, 148.1096),
		vector3(-765.7354, 650.6202, 145.6979),
		vector3(-753.3721, 620.4018, 142.8478),
		vector3(-733.1371, 593.5372, 142.4779),
		vector3(-704.2806, 588.3829, 142.2769),
		vector3(-685.8431, 595.8616, 144.0266),
		vector3(-700.9188, 647.0342, 155.3489),
		vector3(-747.2981, 808.2870, 215.0237),
		vector3(-655.0894, 802.9260, 198.9907),
		vector3(-599.8167, 807.5590, 191.5211),
		vector3(-596.0237, 780.5001, 189.2897),
		vector3(-565.8644, 760.9774, 185.4249),
		vector3(-597.4691, 764.1092, 189.3102),
		vector3(-645.7798, 740.2784, 174.2848),
		vector3(-699.6313, 705.9604, 158.2026),
		vector3(-606.2241, 672.2451, 151.5965),
		vector3(-551.7419, 687.0760, 146.0744),
		vector3(-559.8564, 663.7163, 145.4868),
		vector3(-658.4384, 886.2686, 229.2954),
		vector3(-596.9675, 851.3839, 211.4786),
		vector3(-494.0464, 796.0877, 184.3410),
		vector3(-495.7682, 738.6370, 163.0310),
		vector3(-533.3387, 709.6213, 153.1577),
		vector3(-523.1417, 628.2281, 137.9711),
		vector3(-524.9379, 572.9097, 121.4334),
		vector3(-474.3472, 585.8811, 128.6839),
		vector3(-526.5754, 517.0284, 112.9418),
		vector3(-554.5994, 541.2596, 110.7071),
		vector3(-536.6666, 477.2514, 103.1923),
		vector3(-500.1553, 398.1322, 98.2612),
		vector3(-595.4125, 530.3362, 107.7546),
		vector3(-580.4070, 491.5719, 108.9023),
		vector3(-622.7013, 488.8928, 108.8781),
		vector3(-640.9922, 520.5344, 109.8733),
		vector3(-667.0818, 471.4909, 114.1362),
		vector3(-679.0460, 512.0357, 113.5260),
		vector3(-721.5009, 490.5041, 109.6177),
		vector3(-717.7809, 448.6887, 106.9091),
		vector3(-762.1623, 430.8520, 100.1968),
		vector3(-784.7370, 459.6927, 100.3803),
		vector3(-824.7520, 421.9958, 92.1242),
		vector3(-561.0980, 402.4667, 101.8052),
		vector3(-595.7433, 393.0391, 101.8817),
		vector3(-615.5351, 398.2577, 101.6181),
		vector3(-445.9789, 686.4261, 153.1095),
		vector3(-400.0392, 664.7520, 163.8300),
		vector3(-340.2424, 668.7140, 172.7842),
		vector3(-339.5855, 625.6011, 171.3567),
		vector3(-307.4913, 643.3517, 176.1342),
		vector3(-293.5560, 600.8394, 181.5751),
		vector3(-232.5184, 588.2177, 190.5318),
		vector3(-189.4314, 618.2712, 199.6612),
		vector3(-189.1368, 591.6457, 197.8230),
		vector3(-126.4889, 588.2740, 204.6964),
		vector3(-458.9551, 537.0651, 121.4601),
		vector3(-417.9880, 569.0379, 125.0571),
		vector3(-378.9175, 548.3911, 124.0455),
		vector3(-386.9645, 504.2419, 120.4127),
		vector3(-348.7748, 514.9944, 120.6473),
		vector3(-355.9555, 469.7876, 112.6134),
		vector3(-311.7386, 474.9619, 111.8185),
		vector3(-305.0695, 431.0481, 110.4503),
		vector3(-401.1886, 427.6350, 112.4045),
		vector3(-444.2151, 342.8266, 105.6254),
		vector3(-409.5766, 341.5468, 108.9069),
		vector3(-371.9107, 343.3319, 109.9427),
		vector3(-328.0798, 369.5786, 110.0061),
		vector3(-297.7571, 379.8358, 112.0946),
		vector3(-239.0119, 381.5478, 112.5999),
		vector3(-166.3757, 423.9090, 111.8057),
		vector3(-174.4391, 502.6264, 137.4205),
		vector3(-66.7621, 490.0279, 144.8817),
		vector3(-7.7555, 467.7879, 145.8452),
		vector3(57.4602, 449.7416, 147.0314),
		vector3(79.9284, 486.2225, 148.2014),
		vector3(107.0097, 466.7068, 147.5612),
		vector3(224.0842, 513.4880, 140.9205),
    },
}

-- Random Peds spawned on door delivery

Config.PedModels = {
   `a_f_m_bevhills_01`,
   `a_f_m_bevhills_02`,
   `a_f_m_business_02`,
   `a_f_m_downtown_01`,
   `a_f_m_eastsa_01`,
   `a_f_m_eastsa_02`,
   `a_f_m_fatbla_01`,
   `a_f_m_ktown_01`,
   `a_f_m_ktown_02`,
   `a_f_m_prolhost_01`,
   `a_f_m_skidrow_01`,
   `a_f_m_tramp_01`,
   `a_f_m_soucentmc_01`,
   `a_f_m_soucent_01`,
   `a_f_o_salton_01`,
   `a_f_y_business_04`,
   `a_f_y_eastsa_03`,
   `a_f_y_epsilon_01`,
   `a_f_y_eastsa_01`,
   `a_f_y_golfer_01`,
   `a_f_y_soucent_01`,
   `a_f_y_soucent_03`,
   `a_f_y_vinewood_03`,

    `a_m_m_bevhills_02`,
    `a_m_m_business_01`,
    `a_m_m_genfat_01`,
    `a_m_m_eastsa_01`,
    `a_m_m_eastsa_02`,
    `a_m_m_hillbilly_01`,
    `a_m_m_malibu_01`,
    `a_m_m_rurmeth_01`,
    `a_m_m_salton_03`,
    `a_m_m_skater_01`,
    `a_m_m_skidrow_01`,
    `a_m_m_socenlat_01`,
    `a_m_m_soucent_01`,
    `a_m_o_salton_01`,
    `a_m_o_soucent_01`,
    `a_m_y_beachvesp_01`,
    `a_m_y_bevhills_01`,
    `a_m_y_bevhills_02`,
    `a_m_y_busicas_01`,
    `a_m_y_business_02`,
    `a_m_y_business_03`,
    `a_m_m_hasjew_01`,
}