Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN
Tebex: https://lionh34rt.tebex.io/

# Description
* **Cayo Perico resource to create an ecosystem on the new island.**
* *Features: drugs, weapon crafting, smuggling, radar systems, NPC's to make it more alive, boss menu with treasury, personal stash, group stashes*
* **Advised: https://forum.cfx.re/t/releases-free-cayo-perico-improvements-freeroam-4-1-7/1944991**

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)

# Installation
* **Install all dependencies**
* **Add the job and items to your qb-core shared**
* **Add the correct lines to your inventory formatdata function in app.js**
* **Run the SQL script**

# Items for shared.lua
```lua
["cayo_weed1"] 					= {["name"] = "cayo_weed1", 					["label"] = "Weed Branch", 				["weight"] = 2000, 		["type"] = "item", 		["image"] = "cayo_weed1.png", 				["unique"] = false, 		["useable"] = false, 	["shouldClose"] = false,	   	["combinable"] = nil,   ["description"] = "Fresh weed..."},
["cayo_weed2"] 					= {["name"] = "cayo_weed2", 					["label"] = "Weed Buds", 				["weight"] = 1500, 		["type"] = "item", 		["image"] = "cayo_weed2.png", 				["unique"] = false, 		["useable"] = false, 	["shouldClose"] = false,	   	["combinable"] = nil,   ["description"] = "Weed buds..."},
["cayo_weed3"] 					= {["name"] = "cayo_weed3", 					["label"] = "Weed Brick", 				["weight"] = 12000, 	["type"] = "item", 		["image"] = "cayo_weed3.png", 				["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "Weed brick from Cayo Perico..."},
["cayo_coke1"] 					= {["name"] = "cayo_coke1", 					["label"] = "Coca Leaves", 				["weight"] = 2000, 		["type"] = "item", 		["image"] = "cayo_coke1.png", 				["unique"] = false, 		["useable"] = false, 	["shouldClose"] = false,	   	["combinable"] = nil,   ["description"] = "Coca leaves..."},
["cayo_coke2"] 					= {["name"] = "cayo_coke2", 					["label"] = "Cocaine", 					["weight"] = 1500, 		["type"] = "item", 		["image"] = "cayo_coke2.png", 				["unique"] = false, 		["useable"] = false, 	["shouldClose"] = false,	   	["combinable"] = nil,   ["description"] = "Cocaine Hydrochloride..."},
["cayo_coke3"] 					= {["name"] = "cayo_coke3", 					["label"] = "Coke Brick", 				["weight"] = 12000, 	["type"] = "item", 		["image"] = "cayo_coke3.png", 				["unique"] = false, 		["useable"] = true, 	["shouldClose"] = true,	   		["combinable"] = nil,   ["description"] = "Coke brick from Cayo Perico..."},
["cayo_deliverynote"] 			= {["name"] = "cayo_deliverynote", 				["label"] = "Delivery Note", 			["weight"] = 1000, 		["type"] = "item", 		["image"] = "cayo_deliverynote.png", 		["unique"] = true, 			["useable"] = false, 	["shouldClose"] = false,	   	["combinable"] = nil,   ["description"] = ""},

-- WARNING DUPLICATE: BELOW USED IN QB-LABS TOO
["empty_plastic_bag"] 			 = {["name"] = "empty_plastic_bag", 			["label"] = "Empty Ziploc baggies",		["weight"] = 100, 		["type"] = "item", 		["image"] = "empty-plastic-bag.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,	["combinable"] = nil,   ["description"] = "A small and empty plastic bag."},
```

# Job for shared.lua
```lua
['cayoperico'] = {
    label = 'Cayo Perico',
    defaultDuty = true,
    grades = {
        ['0'] = {
            name = 'Member',
            payment = 100
        },
        ['1'] = {
            name = 'Capo',
            payment = 150
        },
        ['2'] = {
            name = 'Druglord',
            payment = 200,
            isboss = true
        },
    },
},
```

# Add the following to the FormatItemInfo(itemData) function
# Can be found at: qb-inventory > html > js > app.js
# This snippet of code adds the info (weight, amount, crop) to the description of the item as seen in the video
```js
} else if (itemData.name == "cayo_deliverynote") {
    $(".item-info-title").html('<p>'+itemData.label+'</p>')
    $(".item-info-description").html('<p>Delivered: ' + itemData.info.amt + '</p> <p> Crop:     ' + itemData.info.crop + '</p> <p> Weight: ' + itemData.info.weight + ' lbs</p>');
```

# If you wish to increase the trunkspace of the CAYOBOAT and CAYODODO licenseplate, then you can add the following to your qb-inventory/client/main.lua under RegisterCommand('inventory', function() where trunkspaces are defined
```lua
if CurrentVehicle == "CAYODODO" then
	maxweight = 1000000
	slots = 5
elseif CurrentVehicle == "CAYOBOAT" then
	maxweight = 200000
	slots = 5
end
```
