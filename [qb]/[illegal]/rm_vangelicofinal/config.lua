--RAINMAD SCRIPTS - discord.gg/sJG56ZsGrr - rainmad.com
Config = {}

Config['VangelicoHeist'] = {
    ['framework'] = {
        name = 'QB', -- Only ESX or QB.
        scriptName = 'qb-core', -- Framework script name work framework exports. (Example: qb-core or es_extended)
        eventName = 'esx:getSharedObject', -- If your framework using trigger event for shared object, you can set in here.
        targetScript = 'ox_target' -- Target script name (qtarget or qb-target or ox_target)
    },
    ['bagClothesID'] = 45,
    ['buyerFinishScene'] = true,
    ["dispatch"] = "ps-dispatch", -- cd_dispatch | qs-dispatch | ps-dispatch | rcore_dispatch | default
    ['requiredPoliceCount'] = 0, -- required police count for start heist
    ['dispatchJobs'] = {'police', 'sasp'},
    ['nextRob'] = 7200, -- Seconds for next heist.
    ['requiredItems'] = { -- Add this items to database or shared. Don't change the order, you can change the item names.
        'bag',
        'cutter',
        'vangelico_key',
        'crack_kit',
    },
    ['keycardChance'] = 100, -- Vangelico keycard spawn chance for secret room
    ['smashRewardCount'] = 2, -- How many different reward items will be given each time a smash glass
    ['smashRewards'] = { -- You can add new reward items for all grab actions. (smash, grab, trolly) Don't change the diamond item order.
        {item = 'diamond',   count = function() return math.random(5, 10) end, sellPrice = 300},
        {item = 'goldwatch', count = function() return math.random(5, 10) end, sellPrice = 300},
        {item = 'ring',      count = function() return math.random(5, 10) end, sellPrice = 300},
        {item = 'necklace',  count = function() return math.random(5, 10) end, sellPrice = 300},
    },
    ['smashWeapons'] = { -- You can add new smash required weapons
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_CARBINERIFLE',
        'WEAPON_ADVANCEDRIFLE',
        'WEAPON_BULLPUPRIFLE',
    },
    ['moneyItem'] = { -- If your server have money item, you can set it here.
        status = false,
        itemName = 'cash'
    },
    ['black_money'] = false,  -- If change true, all moneys will convert to black. QBCore players can change itemName.
    ['finishHeist'] = { -- Heist finish coords.
        buyerPos = vector3(-748.22, -2592.2, 12.8282)
    },
}

Config['VangelicoSetup'] = {
    ['doors'] = {
        {coords = vector3(-448.14, -76.886, 41.2874), heading = 39.0,  hash = 517314340,   locked = true},
        {coords = vector3(-450.05, -78.303, 41.2874), heading = 39.0,  hash = 1118133947,  locked = true},
        {coords = vector3(-444.63, -65.878, 41.3335), heading = 219.0, hash = -543262073,  locked = true},
    },
    ['electricBox'] = {coords = vector3(-459.69, -61.791, 49.9972), heading = 307.23},
    ['keycard'] = {coords = vector3(-453.01, -58.380, 41.2904), heading = 40.23},
    ['useKeycard'] = {coords = vector3(-445.65, -66.710, 41.4904), heading = 219.23},
    ['bigGlass'] = { -- Add this item to database or shared.
        glass = {coords = vector3(-453.22, -71.608, 40.2852), heading = 128.0, itemName = 'van_necklace', sellPrice = 300}
    },
    ['lockedRoom'] = {
        ['loot'] = {
            {coords = vector3(-442.57, -65.749, 41.2903), heading = 0.0},
            {coords = vector3(-442.24, -66.353, 41.2903), heading = 0.0},
            {coords = vector3(-441.70, -67.092, 41.2903), heading = 0.0},
            {coords = vector3(-440.54, -68.036, 41.2903), heading = 0.0},
        },
        ['2xloot'] = {
            {coords = vector3(-443.74, -69.937, 41.2904), heading = 0.0},
            {coords = vector3(-445.20, -68.435, 41.2904), heading = 0.0},
        },
        ['trollys'] = {
            {coords = vector3(-442.06, -69.508, 40.2904), heading = 40.0}
        },
    },
    ['jewelCounters'] = {
        {coords = vector3(-454.12, -64.684, 41.5402), heading = 310.0},
        {coords = vector3(-452.72, -66.244, 41.5402), heading = 310.0},
        {coords = vector3(-451.46, -67.727, 41.5402), heading = 310.0},
        {coords = vector3(-450.46, -69.238, 41.5402), heading = 310.0},
        {coords = vector3(-449.28, -70.796, 41.5402), heading = 310.0},
        {coords = vector3(-447.82, -72.473, 41.5402), heading = 310.0},
        {coords = vector3(-454.59, -72.749, 41.5402), heading = 310.0},

        {coords = vector3(-454.23, -77.276, 41.5402), heading = 130.0},
        {coords = vector3(-455.39, -75.916, 41.5402), heading = 130.0},
        {coords = vector3(-456.76, -74.320, 41.5402), heading = 130.0},
        {coords = vector3(-457.91, -72.938, 41.5402), heading = 130.0},
        {coords = vector3(-459.03, -71.365, 41.5402), heading = 130.0},
        {coords = vector3(-460.31, -69.763, 41.5402), heading = 130.0},
        
        {coords = vector3(-453.13, -73.960, 41.5402), heading = 40.0},
        {coords = vector3(-452.05, -73.160, 41.5402), heading = 40.0},
        
        {coords = vector3(-453.81, -69.823, 41.5402), heading = 220.0},
        {coords = vector3(-454.99, -70.736, 41.5402), heading = 220.0},
    }
}

policeAlert = function(coords)
    if Config['VangelicoHeist']["dispatch"] == "default" then
        TriggerServerEvent('vangelico:server:policeAlert', coords)
    elseif Config['VangelicoHeist']["dispatch"] == "cd_dispatch" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = Config["VangelicoHeist"]['dispatchJobs'], 
            coords = coords,
            title = 'Vangelico Robbery',
            message = 'A '..data.sex..' robbing a Vangelico at '..data.street, 
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431, 
                scale = 1.2, 
                colour = 3,
                flashes = false, 
                text = '911 - Vangelico Robbery',
                time = 5,
                radius = 0,
            }
        })
    elseif Config['VangelicoHeist']["dispatch"] == "qs-dispatch" then
        exports['qs-dispatch']:VangelicoRobbery()
    elseif Config['VangelicoHeist']["dispatch"] == "ps-dispatch" then
        exports['ps-dispatch']:VangelicoRobbery()
    elseif Config['VangelicoHeist']["dispatch"] == "rcore_dispatch" then
        local data = {
            code = '10-64', -- string -> The alert code, can be for example '10-64' or a little bit longer sentence like '10-64 - Shop robbery'
            default_priority = 'high', -- 'low' | 'medium' | 'high' -> The alert priority
            coords = coords, -- vector3 -> The coords of the alert
            job = Config["VangelicoHeist"]['dispatchJobs'], -- string | table -> The job, for example 'police' or a table {'police', 'ambulance'}
            text = 'Vangelico Robbery', -- string -> The alert text
            type = 'alerts', -- alerts | shop_robbery | car_robbery | bank_robbery -> The alert type to track stats
            blip_time = 5, -- number (optional) -> The time until the blip fades
            blip = { -- Blip table (optional)
                sprite = 431, -- number -> The blip sprite: Find them here (https://docs.fivem.net/docs/game-references/blips/#blips)
                colour = 3, -- number -> The blip colour: Find them here (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
                scale = 1.2, -- number -> The blip scale
                text = 'Vangelico Robbery', -- number (optional) -> The blip text
                flashes = false, -- boolean (optional) -> Make the blip flash
                radius = 0, -- number (optional) -> Create a radius blip instead of a normal one
            }
        }
        TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
    end
end

Strings = {
    --Notifications
    ['wait_nextrob'] = 'You have to wait this long to undress again',
    ['minute'] = 'minute.',
    ['need_this'] = 'You need this: ',
    ['need_police'] = 'Not enough police in the city.',
    ['total_money'] = 'You got this: ',
    ['police_alert'] = 'Vangelico robbery alert! Check your gps.',
    ['not_cop'] = 'You are not cop!',
    ['buyer_blip'] = 'Buyer',
    ['deliver_to_buyer'] = 'Deliver the loot to the buyer. Check gps.',
    ['need_rifle'] = 'You need the rifle.',
    ['got_keycard'] = 'You got Keycard.',
    ['no_keycard'] = 'You didnt find Keycard.',

    --Target labels
    ['t_electricbox'] = 'Crack the electric box',
    ['t_smashglass'] = 'Smash the glass',
    ['t_keycard'] = 'Use keycard',
    ['t_trolly'] = 'Grab the trolly',
    ['t_overheat'] = 'Cut the glass',
    ['t_safecrack'] = 'Start the safecrack',
    ['t_loot'] = 'Grab the loot',

    --Minigames
    ['change'] = 'Change horizontal',
    ['change2'] = 'Change vertical',
    ['exit'] = 'Exit',

    ['safecrack'] = "~INPUT_FRONTEND_LEFT~ ~INPUT_FRONTEND_RIGHT~ Rotate\n~INPUT_FRONTEND_RDOWN~ Check",
}