----------
Config = {}
Framework = "QBCore" -- (ESX) or (QBCore)
if Framework == "QBCore" then
    Config.CoreName = "qb-core" -- your core name
    FWork = exports[Config.CoreName]:GetCoreObject()
elseif Framework == "ESX" then
    Config.CoreName = "es_extended" -- your core name
    FWork = exports[Config.CoreName]:getSharedObject()
end
Config.Debug = false -- enables debug poly for zones
----------
----------
Config.Menu = 'ox_lib' -- (ox_lib, qb-menu, any qb-menu renamed resource)
Config.Target = "ox_target" -- (ox_target, qb-target, qtarget, ny qb-target renamed resource)
Config.InventoryType = 'ox' -- (qb, ox, lj, quasar, neither) What inventory you are using? if you are using a renamed inventory resource you can use that here as well for qb-inventory or lj-inventory renames only.
Config.Phone = "qb" -- (quasar) (renewed) (gks) (qb) (road) Whatever phone script you are using for email when a tournament starts. (event is "Pug:client:TournamentHasBecomeAvilable" in open.lua)
----------
Config.FishingKey = 47 -- Key press to start fishing. Key id's can be found here: https://docs.fivem.net/docs/game-references/controls/
Config.FishingKeyText = "G" -- Key text to show up on draw text
----------
Config.PugSlingScript = true -- Make this true if you are also using my sling script here: https://pug-scripts.tebex.io/package/5202185
Config.BoatRequired = false -- toggle this to false if you want to allow people to fish without being on a boat
Config.LockedZones = false -- Make this true if you do NOT want players to fish anywhere and make them only be able to fish in the zones created at Config.LockedLocationFishingZone
Config.LockInventory = false -- Make this true if you want players inventory to be locked every time they use a fishing rod and unlocked when they are done catching the fish
Config.FishingItemCheck = false -- This was requested by a single customer who is using core-inventory. (ignore if you are not using core inventory)
Config.UsePSUiForTreasureMiniGame = false -- Make this true if you want the treasure chest mini game to be ps-ui instead of what it is default set to. (This was requested by a customer)
Config.TreasureChestHasMiniGame = true -- Make this false if you dont want there to be any minigame on opening a treasure chest.
Config.SetWayPointToTreasure = false -- Make this true if you want there to be a waypoint to the treasure chest when using a treasure map.
Config.RemoveFishingRepWhenCraftRod = false -- Make this true if you want the player to have the fishing rep required to craft the fishing rod removed from the player when they craft the fishing rod. 
----------
----------
Config.TournamentCooldowns = 150 -- (Minutes) how much time inbetween tournaments | Default is set to 2 hours and 30 minutes (# In minutes)
Config.LengOfActiveTournament = 35 -- (Minutes) how much time the actual torunament happens for | Default is set to 35 minutes (# In minutes)
Config.TournamentTimeToSignUp = 15 -- (Minutes) How long do player have to sign up after a tournament becomes available aka how many seconds is Config.TournamentCooldowns | Default is set to 15 minutes
----------
----------
Config.TournamentPed = `s_m_m_trucker_01` -- Fishing Tournament ped
Config.TournamentPedLoc = vector4(-335.09, 6105.62, 30.45, 232.73) -- tournament ped location
----------
----------
Config.SellShopPed = `s_m_m_migrant_01` -- Fishing sell shop ped model
Config.SellShopPedPedLoc = vector4(-2196.85, 4272.36, 47.55, 157.87) -- Fishing sell Shop ped location
----------
----------
Config.GemsBuyingPed = `a_m_m_hasjew_01` -- Gems sell Shop ped
Config.GemsBuyingPedLoc = vector4(-1816.64, -1193.78, 13.3, 334.81) -- Gems Buying Ped Location
----------
----------
Config.CrafingRodLocation = vector3(-679.12, 5790.83, 17.33) -- crafting fishing rods location
----------
----------
Config.MaxFisherMan = 100 -- Max fishermen in tournaments
Config.MinFisherMan = 1 -- Min fishermen in the tournament for a torunament to start
Config.ChanceToLozeKey = 30 -- % chance the key will be taken when the player fails to open the chest
----------
Config.WaitForFIshToBiteMin = 10 -- (seconds) Minimum amount of seconds it can take for a fish to bite the bait
Config.WaitForFIshToBiteMax = 30 --(seconds) Minimum amount of seconds it can take for a fish to bite the bait
----------
----------
Config.FishingBait = 'fishingbait'
Config.ChestKey = 'chestkey'
Config.ChestItem = 'treasurechest'
Config.SuperRareitem = 'actualbrain' -- found in chest
Config.MiniGame1Speed = 0.004 -- speed at which the minigame goes at. examples you would want to try are 0.001, 0.002, 0.003, etc. (this only matters for default minigame)
Config.TournamentZoneBlip = 316 -- Tournament Zone Blip Sprite
Config.TournamentZoneBlipColor = 31 -- Tournament Zone Blip color
Config.FirstPlacePayout = 750 -- this is the payout times the amount of people in the tournament
Config.SecondPlacePayout = 500 -- this is the payout times the amount of people in the tournament
Config.ThirdPlacePayout = 250 -- this is the payout times the amount of people in the tournament
Config.UseDefaultPed = true -- Shouldnt change this if you follow readme properly
----------
----------
Config.Rod1AttemptsMin = 3 -- minimum ammout of times you need to do the skillcheck 
Config.Rod1AttemptsMax = 6 -- maximum ammout of times you need to do the skillcheck 
----------
----------
Config.SkilledRodGame = 'ps-ui' -- (ps-ui) only change this if you have changed your skillbar file name or want to use ps-ui circles. Not just any minigame will work (if ps-ui then it will the Config.CircleSpeed2 settings)
Config.NeededAttemptsMin = 2 -- minimum ammout of times you need to do the skillcheck
Config.NeededAttemptsMax = 3 -- maximum ammout of times you need to do the skillcheck
----------
----------
Config.AllUsesPsUiLock = true -- make this true if you only want to use ps-ui lock for all fishing rod minigames
-- First Fishing Rod (All PS-UI Lock)
Config.CircleSpeed1 = 20 -- Speed the skillcheck for the first fishingrod is (This only matters if Config.AllUsesPsUiLock is true) [lower number is faster]
Config.CirclesMin1 = 2 -- minimum ammout of times you need to do the skillcheck for the first fishingrod (This only matters if Config.AllUsesPsUiLock is true)
Config.CirclesMax1 = 3 -- maximum ammout of times you need to do the skillcheck for the first fishingrod (This only matters if Config.AllUsesPsUiLock is true)
-- Second Fishing Rod (All PS-UI Lock)
Config.CircleSpeed2 = 12 -- Speed the skillcheck for the first fishingrod is (This only matters if Config.AllUsesPsUiLock is true) [lower number is faster]
Config.CirclesMin2 = 3 -- minimum ammout of times you need to do the skillcheck for the first fishingrod (This only matters if Config.AllUsesPsUiLock is true)
Config.CirclesMax2 = 4 -- maximum ammout of times you need to do the skillcheck for the first fishingrod (This only matters if Config.AllUsesPsUiLock is true)
-- Third Fishing Rod (All PS-UI Lock)
Config.CircleSpeed3 = 5 -- Speed the skillcheck for the first fishingrod is (This only matters if Config.AllUsesPsUiLock is true) [lower number is faster]
Config.CirclesMin3 = 4 -- minimum ammout of times you need to do the skillcheck for the first fishingrod (This only matters if Config.AllUsesPsUiLock is true)
Config.CirclesMax3 = 5 -- maximum ammout of times you need to do the skillcheck for the first fishingrod (This only matters if Config.AllUsesPsUiLock is true)
----------
----------
-- NW_fishingGame This is for if you are using the NW_fishingGame Minigame
Config.NW_fishingGame = false -- make this true if you only want to use NW_fishingGame for all fishing rod minigames (MAKE SURE Config.AllUsesPsUiLock IS FALSE)
Config.NW_fishingGameRod1 = 'easy' -- Dificulty of fishing rod 1
Config.NW_fishingGameRod2 = 'medium' -- Dificulty of fishing rod 2
Config.NW_fishingGameRod3 = 'hard' -- Dificulty of fishing rod 3
----------
----------
--Professional Fishing Rod
-- this doesnt matter if Config.AllUsesPsUiLock is true. You can disreguard it
Config.ProfessionalRodGame = 'ps-ui' -- only change this if you have changed your qb-lock file name or if you are using ps-ui. Not just any minigame will work
Config.CirclesMin = 4 -- minimum ammout of times you need to do the skillcheck
Config.CirclesMax = 6 -- maximum ammout of times you need to do the skillcheck
----------
Config.SecondsMin = 7 -- minimum ammout of time the skill check can go on for
Config.SecondsMax = 9 -- maximum ammout of time the skill check can go on for
----------
Config.AmountOfZones = 4 -- if you add more zones make sure to make the number the amount of zones you have
----------
Config.PsUIScriptName = "ps-ui" -- Ignore this if you have not renamed your ps-ui script name and this does not matter if you are not using ps-ui with this script (you can mostly ignore this one as it was requested by a customer)
----------
-- Do not touch any of this unless
-- YOU REALLY KNOW WHAT YOU ARE DOING
Config.FrameworkFunctions = {
    -- Client-side trigger callback
    TriggerCallback = function(...)
        if Framework == 'QBCore' then
            FWork.Functions.TriggerCallback(...)
        else
            FWork.TriggerServerCallback(...)
        end
    end,

    -- Server-side register callback
    CreateCallback = function(...)
        if Framework == 'QBCore' then
            FWork.Functions.CreateCallback(...)
        else
            FWork.RegisterServerCallback(...)
        end
    end,

    -- Server-side Get All Players
    GetPlayers = function()
        if Framework == 'QBCore' then
            return FWork.Functions.GetPlayers()
        else
            return FWork.GetPlayers()
        end
    end,

    -- Client Notification Function
    Notify = function(msg, type, length)
        if Framework == 'QBCore' then
            return FWork.Functions.Notify(msg, type, length)
        else
            return FWork.ShowNotification(msg, type, length)
        end
    end,
    
    GetIdentifiers = function(source, idtype)
        return GetIdentifiers(source, idtype)
    end,

    GetItemByName = function(source, item, amount) 
        if Framework == 'QBCore' then 
            local player = FWork.Functions.GetPlayer(source)
            return player.Functions.GetItemByName(item, amount)
        else
            local player = FWork.GetPlayerFromId(source)
            return player.getInventoryItem(item, amount)
        end
    end,
    
    -- Server-side get player data
    GetPlayer = function(source,cid,client)
        if Framework == 'QBCore' then
            local self = {}
            local player = nil
            if cid then
                player = FWork.Functions.GetPlayerByCitizenId(source)
            elseif client then
                player = FWork.Functions.GetPlayerData()
            else
                player = FWork.Functions.GetPlayer(source)
            end

            if (player ~= nil) then
                self.source = source
                if client then
                    self.PlayerData = { charinfo = { firstname = player.charinfo.firstname, lastname = player.charinfo.lastname}, citizenid = player.citizenid, money = player.money, metadata = player.metadata }
                else
                    self.PlayerData = { charinfo = { firstname = player.PlayerData.charinfo.firstname, lastname = player.PlayerData.charinfo.lastname}, citizenid = player.PlayerData.citizenid, 
                    money = player.PlayerData.money, metadata = player.PlayerData.metadata, items = player.PlayerData.items, source =  player.PlayerData.source, job = {name = player.PlayerData.job.name}}
                end
                self.AddMoney = function(currency, amount) 
                    player.Functions.AddMoney(currency, amount)
                end
                self.RemoveMoney = function(currency, amount) 
                    player.Functions.RemoveMoney(currency, amount)
                end

                self.RemoveItem = function(item, amount) 
                    player.Functions.RemoveItem(item, amount, false)
                end

                self.AddItem = function(item, amount, info) 
                    player.Functions.AddItem(item, amount, false, info)
                end

                self.SetInventory = function(Data) 
                    player.Functions.SetInventory(Data)
                end

                self.SetMetaData = function(metadata, value) 
                    player.Functions.SetMetaData(metadata, value)
                end

                return self
            end
        else
            local self = {}
            local player = nil
            if cid then
                player = FWork.GetPlayerFromId(PugFindPlayersByItentifier(source))
            elseif client then
                player = FWork.GetPlayerData()
            else
                player = FWork.GetPlayerFromId(source)
            end

            if (player ~= nil) then
                self.source = source
                if client then
                    self.PlayerData = { money = {cash = PugGetPlayerMoneyCount()},charinfo = { firstname = player.get('firstName'), lastname = player.get('lastName')} }
                else
                    self.PlayerData = { charinfo = { firstname = player.get('firstName'), lastname = player.get('lastName')}, citizenid = FWork.GetIdentifier(source), 
                    money = {cash = player.getAccount('money').money, bank = player.getAccount('bank').money}, source = player.source, job = { name = player.job.name }}
                end
                self.AddMoney = function(currency, amount) 
                    player.addMoney(amount)
                end
                self.RemoveMoney = function(currency, amount) 
                    player.removeMoney(amount)
                end

                self.RemoveItem = function(item, amount) 
                    player.removeInventoryItem(item, amount)
                end

                self.AddItem = function(item, amount, info) 
                    player.addInventoryItem(item, amount, false, info)
                end

                return self
            end
        end

        return nil
    end,
}

-- make sure if you add more zones you name then tournament then the next number in line like this tournament5
Config.TournamentZone = {
    ["tournament1"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the tournament area
                vector2(-1620.01171875, 4464.6005859375),
                vector2(-1807.2664794922, 4669.259765625),
                vector2(-1898.1372070313, 4593.2348632813),
                vector2(-1692.4174804688, 4412.130859375)
            },
            ['minZ'] = -5.7327547073364,  -- min height of the tournament area
            ['maxZ'] = 35.722059249878  -- max height of the tournament area
        },
        ['blip'] = vector3(-1758.8, 4535.23, 6.72)
    },
    ["tournament2"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the tournament area
                vector2(-384.06076049805, 4399.8715820313),
                vector2(-231.89094543457, 4225.5405273438),
                vector2(-149.44592285156, 4280.4887695313),
                vector2(-305.27215576172, 4459.5703125)
            },
            ['minZ'] = 80.656478881836,  -- min height of the tournament area
            ['maxZ'] = 12.69  -- max height of the tournament area
        },
        ['blip'] = vector3(-269.97, 4345.12, 37.33)
    },
    ["tournament3"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the tournament area
                vector2(-3406.1931152344, 1010.0747070313),
                vector2(-3454.1989746094, 1007.9429321289),
                vector2(-3450.4975585938, 930.89617919922),
                vector2(-3399.5327148438, 924.79827880859)
            },
            ['minZ'] = 3.6945128440857,  -- min height of the tournament area
            ['maxZ'] = 4.109363079071  -- max height of the tournament area
        },
        ['blip'] = vector3(-3416.7, 967.79, 8.35)
    },
    ["tournament4"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the tournament area
                vector2(-1588.6945800781, 5289.0131835938),
                vector2(-1660.9250488281, 5267.6567382813),
                vector2(-1625.2055664063, 5171.3740234375),
                vector2(-1523.5847167969, 5220.361328125)
            },
            ['minZ'] = 7.4893641471863,  -- min height of the tournament area
            ['maxZ'] = 10.573061943054  -- max height of the tournament area
        },
        ['blip'] = vector3(-1595.29, 5225.13, 3.98)
    },
}

-- THIS IS ONLY FPR IF 
Config.LockedLocationFishingZone = {
    ["LockedZone1"] = {
        ['Zone'] = {
            ['Shape'] = { --polyzone that surrounds the tournament area
                vector2(-1620.01171875, 4464.6005859375),
                vector2(-1807.2664794922, 4669.259765625),
                vector2(-1898.1372070313, 4593.2348632813),
                vector2(-1692.4174804688, 4412.130859375)
            },
            ['minZ'] = -5.7327547073364,  -- min height of the tournament area
            ['maxZ'] = 35.722059249878  -- max height of the tournament area
        },
    },
}

Config.CraftRods = {
    ["fishingrod2"] = {
        name = "Skilled Fishing Rod",
        repRequired = 350,
        item1 = 'fishingrod',
        item1Amount = 1,
        item2 = 'skill-reel',
        item2Amount = 1,
        price = 2000,
    },
    ["fishingrod3"] = {
        name = "Professional Rod",
        repRequired = 1000,
        item1 = 'fishingrod2',
        item1Amount = 1,
        item2 = 'pro-reel',
        item2Amount = 1,
        price = 5000,
    },
}

Config.SellFishies = {
    ["fish"] = {
        price = math.random(100,125)
    },
    ["stripedbass"] = {
        price = math.random(100,125)
    },
    ["bluefish"] = {
        price = math.random(135,160)
    },
    ["redfish"] = {
        price= math.random(200,225) 
    },
    ["goldfish"] = {
        price = math.random(200,225)
    },
    ["largemouthbass"] = {
        price = math.random(300,320)
    },
    ["swordfish"] = {
        price = math.random(300,320)
    },
    ["salmon"] = {
        price = math.random(300,320)
    },
    ["catfish"] = {
        price = math.random(300,320)
    },
    ["rainbowtrout"] = {
        price = math.random(630,660)
    },
    ["tigershark"] = {
        price = math.random(630,660)
    },
    ["stingraymeat"] = {
        price = math.random(700,720)
    },
    ["tuna-fish"] = {
        price = math.random(705,720)
    },
    ["killerwhale"] = {
        price = math.random(730,750)
    },
}

Config.SellGems = {
    -- ["diamond"] = {
    --     pricemin = 1000,
    --     pricemax = 3000,
    -- },
    -- ["emerald"] = {
    --     pricemin = 1000,
    --     pricemax = 31000,
    -- },
    -- ["sapphire"] = {
    --     pricemin = 1000,
    --     pricemax = 3000,
    -- },
    -- ["ruby"] = {
    --     pricemin = 1000,
    --     pricemax = 3000,
    -- },
    -- ["yellow-diamond"] = {
    --     pricemin = 1000,
    --     pricemax = 3000,
    -- },
    -- ["captainskull"] = {
    --     pricemin = 4000,
    --     pricemax = 10000,
    -- },
}

Config.TreasureLocations =  {
    [1] = vector3(-385.71, 4929.79, 191.19),
    [2] = vector3(-537.28, 5955.06, 35.25),
    [3] = vector3(268.35, 6511.3, 30.56),
    [4] = vector3(1672.04, 6647.94, 10.43),
    [5] = vector3(3688.46, 4939.28, 18.99),
    [6] = vector3(-2621.12, 4481.75, -34.07),
    [7] = vector3(-2826.86, 4136.66, -47.5),
    [8] = vector3(-2918.78, 3354.25, 27.26),
    [9] = vector3(-1872.77, 3823.91, 186.08),
    [10] = vector3(-1645.35, 3047.32, 31.24),
    [11] = vector3(-547.34, 3559.78, 239.07),
    [12] = vector3(-13.99, 3777.88, 30.64),
    [13] = vector3(-198.96, 3604.64, 52.26),
    [14] = vector3(-56.58, 3096.97, 26.74),
    [15] = vector3(-246.3, 3023.47, 21.12),
    [16] = vector3(-912.58, 2545.76, 61.12),
    [17] = vector3(-1702.95, 2301.95, 70.09),
    [18] = vector3(-2138.68, 2561.38, 2.87),
    [19] = vector3(-2458.48, 2725.17, 2.88),
    [20] = vector3(-2625.99, 2482.43, 2.89),
    [21] = vector3(-2907.75, 2614.68, -13.24),
    [22] = vector3(-3419.84, 1428.31, -34.84),
    [23] = vector3(-3280.41, 954.76, 2.93),
    [24] = vector3(-3154.45, 841.88, 2.21),
    [25] = vector3(-3047.96, 570.93, 3.34),
    [26] = vector3(-3320.98, 199.82, -13.81),
    [27] = vector3(-2528.6, 585.45, 236.63),
    [28] = vector3(-2194.37, 1460.66, 298.28),
    [29] = vector3(679.52, 1302.43, 357.26),
    [30] = vector3(1359.36, 2174.14, 95.63),
    [31] = vector3(1636.65, 1700.92, 104.34),
    [32] = vector3(2080.0, 1949.08, 86.16),
    [33] = vector3(2281.45, 2329.77, 59.99),
    [34] = vector3(2712.8, 1954.21, 46.03),
    [35] = vector3(2427.05, 1397.22, 45.7),
    [36] = vector3(3105.6, 1141.58, 15.99),
    [37] = vector3(3056.19, 1444.67, 14.1),
    [38] = vector3(3082.99, 1614.91, 5.78),
    [39] = vector3(3236.32, 2266.77, 16.06),
    [40] = vector3(3484.35, 2586.78, 14.07),
    [41] = vector3(3945.25, 3711.71, 21.93),
    [42] = vector3(4061.42, 4213.11, 12.39),
    [43] = vector3(4121.24, 4497.79, 16.96),
    [44] = vector3(3624.95, 5029.1, 11.04),
    [45] = vector3(3326.22, 5194.84, 17.69),
    [46] = vector3(2937.96, 5336.93, 102.0),
    [47] = vector3(3625.58, 5674.14, 8.05),
    [48] = vector3(2449.1, 6341.63, 78.93),
    [49] = vector3(1186.89, 6546.99, 3.51),
    [50] = vector3(1999.43, 6453.28, 73.39),
    [51] = vector3(2194.44, 5947.14, 75.67),
    [52] = vector3(2182.82, 5577.5, 54.0),
    [53] = vector3(2082.1, 5081.16, 43.69),
    [54] = vector3(2351.13, 4970.27, 42.8),
    [55] = vector3(2669.76, 4841.7, 33.24),
    [56] = vector3(2437.74, 4658.32, 32.94),
    [57] = vector3(2254.95, 4656.26, 31.1),
    [58] = vector3(1827.96, 4735.53, 33.44),
    [59] = vector3(1552.85, 5126.57, 110.7),
    [60] = vector3(1988.94, 5184.95, 47.79),
    [61] = vector3(1892.76, 4234.39, -7.23),
    [62] = vector3(1645.82, 4154.97, 3.16),
    [63] = vector3(1336.33, 4119.94, 8.28),
    [64] = vector3(1185.54, 4034.84, 5.0),
    [65] = vector3(905.72, 3932.61, -7.47),
    [66] = vector3(464.66, 1653.64, 268.33),
    [67] = vector3(672.41, 279.41, 100.97),
    [68] = vector3(540.23, -1739.97, 30.68),
    [69] = vector3(542.77, -2004.89, 23.16),
    [70] = vector3(408.05, -2115.25, 19.5),
    [71] = vector3(225.38, -2214.23, 7.58),
    [72] = vector3(-458.21, -2111.48, 15.81),
    [73] = vector3(-699.29, -1766.04, 27.9),
    [74] = vector3(-1255.46, -2092.46, 13.25),
    [75] = vector3(-1308.22, -1431.86, 4.63),
    [76] = vector3(-1033.21, -521.2, 36.51),
    [77] = vector3(-1111.2, -668.65, 14.33),
    [78] = vector3(-1065.85, 19.3, 46.8),
    [79] = vector3(-926.35, 61.65, 50.5),
    [80] = vector3(-1728.25, -579.34, 36.34),
    [81] = vector3(-1638.09, -386.53, 43.02),
    [82] = vector3(-783.91, 146.79, 63.85),
    [83] = vector3(-188.84, 354.55, 105.83),
    [84] = vector3(1066.88, 17.8, 79.29),
    [85] = vector3(1644.97, -1630.06, 111.63),
    [86] = vector3(1986.03, -2156.4, 98.17),
    [87] = vector3(2831.25, -1462.9, 11.23),
    [88] = vector3(1661.41, -2356.56, 96.86),
    [89] = vector3(1560.44, -2817.91, 1.23),
    [90] = vector3(1146.73, -2582.01, 18.29),
}