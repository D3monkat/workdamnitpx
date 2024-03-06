local QBCore = exports['qb-core']:GetCoreObject()
Config = {}

Config.Peds = {
    [1] = {
        ["model"] = "ig_hunter",
        ["coords"] = vector4(-679.38, 5834.06, 16.33, 135.24),
        ["cam"] = vector4(-680.05, 5833.46, 17.73, 314.56), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
        ["markerCoord"] = vector3(-680.1, 5833.48, 17.33),
        ["interactive"] = {
            -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
            ["type"] = 38,-- https://docs.fivem.net/docs/game-references/controls/

            ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
            ["text"] = "Talk to local", -- Text that will appear when you approach the npc
            ["icon"] = "fa-solid fa-people-arrows",
            ["distance"] = 2, -- Interactive distance
            
            ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
            ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

            ["drawmarker_distance"] = 4,
            ["interactiveState"] = false, -- -- Don't touch this
            ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
        },  
        ["modal_style"] = "question", -- warning, error, success, question or np
        ["animDict"] = "amb@world_human_clipboard@male@idle_a",
        ["animName"] = "idle_a",
        ["name"] = { -- Ped name
        ["firstname"] = "Buck", 
        ["lastname"] = "Jackson",
        },
        ["title"] = "Big Game Winner", -- the text you want to appear maybe character task etc.
        ["question"] = "Well, howdy there, partner! What can ol me do for ya today? I reckon Im your go-to fella when it comes to huntin and fishin gear. Yep, I specialize in all them outdoor goodies for huntin critters and catchin fish out in them waters. So, whats on your mind friend?", -- question or text
            ["options"] = {
            ["option1"] = {
                ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Can i look at supplies?", -- The answer to the option will appear in the person
                ["funcion_name"] = "Suppliesbuying", -- Function name
                ["selected"] = false, -- Don't touch this
            },
            ["option2"] = {
                ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "I would like to sell some meat to you.", -- The answer to the option will appear in the person  
                ["funcion_name"] = "SellStuff", -- Function name
                ["selected"] = false, -- Don't touch this
            },
            ["option3"] = {
                ["button"] = 3, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "Can i purchase a hunting license?", -- The answer to the option will appear in the person  
                ["funcion_name"] = "licensestuff", -- Function name
                ["selected"] = false, -- Don't touch this
            },
            ["option4"] = {
                ["button"] = 4, -- A, B, C, D or 1, 2, 3, 4, 
                ["label"] = "I am geared and ready to hunt!", -- The answer to the option will appear in the person  
                ["funcion_name"] = "gohunting", -- Function name
                ["selected"] = false, -- Don't touch this
            },
        },
        SellStuff = function()
            QBCore.Functions.Progressbar("Fiddle", "The Hunter is getting their calculator out", 5000, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
             }, {
                flags = 49,
             }, {}, {}, function() -- Done
                TriggerEvent('kevin-hunting:HuntingMenu')
             end, function() -- Cancel
                QBCore.Functions.Notify("You chicken...", "error", 4500)
             end) 
        end,     
        licensestuff = function()
            QBCore.Functions.Progressbar("Fiddle", "You fill out paperwork..", 6500, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
             }, {
                flags = 49,
             }, {}, {}, function() -- Done
                TriggerServerEvent('kevin-hunting:BuyHuntingLicense')  
             end, function() -- Cancel
                QBCore.Functions.Notify("You chicken...", "error", 4500)
             end)
        end,     
        gohunting = function()

            QBCore.Functions.Progressbar("Fiddle", "You get permission to hunt!", 6500, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
             }, {
                flags = 49,
             }, {}, {}, function() -- Done
                TriggerEvent('kevin-hunting:GoHunt')    
             end, function() -- Cancel
                QBCore.Functions.Notify("You chicken...", "error", 4500)
             end)
        end,        
        Suppliesbuying = function()
            QBCore.Functions.Progressbar("Fiddle", "You start looking around.", 6500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
         }, {
            flags = 49,
         }, {}, {}, function() -- Done
            exports.ox_inventory:openInventory('shop', { type = 'baitandgear', id = 1 })  
         end, function() -- Cancel
            QBCore.Functions.Notify("You chicken...", "error", 4500)
         end)




        end
    },
    [2] = {
      ["model"] = "a_c_cat_01",
      ["coords"] = vector4(-584.19, -1060.57, 22.37, 271.22),
      ["cam"] = vector4(-583.38, -1060.39, 22.74, 90.81), -- If the camera angle doesn't look right, give the heading a full negative value, e.g. -93.0 instead of 93.0. If this doesn't work, enter the heading value of the direction your pad is facing the npc!
      ["markerCoord"] = vector3(-584.19, -1060.57, 22.37),
      ["interactive"] = {
          -- ["type"] = "target", -- or fivem keys https://docs.fivem.net/docs/game-references/controls/
          ["type"] = 38,-- https://docs.fivem.net/docs/game-references/controls/

          ["key_label"] = "e", -- If type fivem is converted to index key, the name of the key must be entered "E"
          ["text"] = "Talk to... The cat? ok....", -- Text that will appear when you approach the npc
          ["icon"] = "fa-solid fa-people-arrows",
          ["distance"] = 2, -- Interactive distance
          
          ["uiMarker"] = true, -- If you make it True, you will have a nice image on the screen, but I do not recommend it for resmon.
          ["uiDrawText"] = true, -- If you make it True, you will have a nice text on the screen, but I do not recommend it for resmon.

          ["drawmarker_distance"] = 4,
          ["interactiveState"] = false, -- -- Don't touch this
          ["drawmarker_math"] = 46 -- It is part of a division process that magnifies the marker according to proximity and distance.
      },  
      ["modal_style"] = "question", -- warning, error, success, question or np
      ["animDict"] = "amb@lo_res_idles@",
      ["animName"] = "creatures_world_cat_standing_lo_res_base",
      ["name"] = { -- Ped name
      ["firstname"] = "Smokey", 
      ["lastname"] = "The cat",
      },
      ["title"] = "meow meow", -- the text you want to appear maybe character task etc.
      ["question"] = "Meow, meow meow meow meow meow? Meow meow meow meow meow!", -- question or text
          ["options"] = {
          ["option1"] = {
              ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
              ["label"] = "Is your owner arround?", -- The answer to the option will appear in the person
              ["funcion_name"] = "catcafe", -- Function name
              ["selected"] = false, -- Don't touch this
          },        
      },       
      catcafe = function()
          QBCore.Functions.Progressbar("Fiddle", "It seems the cat understood", 6500, false, true, {
          disableMovement = false,
          disableCarMovement = false,
          disableMouse = false,
          disableCombat = true,
       }, {
          flags = 49,
       }, {}, {}, function() -- Done
         
         -- TriggerServerEvent("InteractSound_SV:PlayOnSource", "BellStartEnd", 0.7)
         TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "BellStartEnd", 0.7)
       end, function() -- Cancel
          QBCore.Functions.Notify("You chicken...", "error", 4500)
       end)




      end
  },
}














--         ["modal_style"] = "question", -- warning, error, success, question or np
--         ["animDict"] = "amb@world_human_clipboard@male@idle_a",
--         ["animName"] = "idle_a",
--         ["name"] = { -- Ped name
--         ["firstname"] = "Buck", 
--         ["lastname"] = "Jackson",
--     },
--     ["title"] = "Big Game Winner", -- the text you want to appear maybe character task etc.
--     ["question"] = "Well, howdy there, partner! What can ol me do for ya today? I reckon Im your go-to fella when it comes to huntin and fishin gear. Yep, I specialize in all them outdoor goodies for huntin critters and catchin fish out in them waters. So, whats on your mind friend?", -- question or text
--     ["options"] = {
--         ["option1"] = {
--             ["button"] = 1, -- A, B, C, D or 1, 2, 3, 4, 
--             ["label"] = "Can i look at your supplies?", -- The answer to the option will appear in the person
--             ["event"] = "kat:OpenShop", -- Event name
--             ["server"] = false, -- Make this true if there will be a server side event trigger
--             ["client"] = true, -- If there will be a client side event trigger, make it true
--             ["argument"] = "", -- You can send only 1 argument and this can include framework variables.                   
--             ["selected"] = false, -- Don't touch this
--         },
--         ["option2"] = {
--             ["button"] = 2, -- A, B, C, D or 1, 2, 3, 4, 
--             ["label"] = "I would like to purchase a weapons license so im legal, I guess..", -- The answer to the option will appear in the person
--             ["event"] = "kevin-hunting:BuyHuntingLicense", -- Event name
--             ["server"] = true, -- Make this true if there will be a server side event trigger
--             ["client"] = false, -- If there will be a client side event trigger, make it true
--             ["argument"] = "", -- You can send only 1 argument and this can include framework variables.                   
--             ["selected"] = false, -- Don't touch this
--         },
--         ["option3"] = {
--             ["button"] = 3, -- A, B, C, D or 1, 2, 3, 4, 
--             ["label"] = "Can i sell my goods?", -- The answer to the option will appear in the person
--             ["event"] = "kevin-hunting:HuntingMenu", -- Event name
--             ["server"] = false, -- Make this true if there will be a server side event trigger
--             ["client"] = true, -- If there will be a client side event trigger, make it true
--             ["argument"] = "huntingrep", -- You can send only 1 argument and this can include framework variables.                   
--             ["selected"] = false, -- Don't touch this
--         },
--         ["option4"] = {
--             ["button"] = 4, -- A, B, C, D or 1, 2, 3, 4, 
--             ["label"] = "Its high noon! Lets Hunt!", -- The answer to the option will appear in the person
--             ["event"] = "kevin-hunting:GoHunt", -- Event name
--             ["server"] = false, -- Make this true if there will be a server side event trigger
--             ["client"] = true, -- If there will be a client side event trigger, make it true
--             ["argument"] = "", -- You can send only 1 argument and this can include framework variables.                   
--             ["selected"] = false, -- Don't touch this
--         },
--         },
--         setNewJob = function()
--             -- Your export or triggers here
--         end
--     }
-- }

