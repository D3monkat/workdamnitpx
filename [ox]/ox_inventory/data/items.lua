return {
	["mechanic_tools"] = {
		label = "Mechanic tools", weight = 0, stack = false, close = true, description = "Needed for vehicle repairs",
		client = { image = "mechanic_tools.png", event = "jim-mechanic:client:Repair:Check" }
	},
	["toolbox"] = {
		label = "Toolbox", weight = 0, stack = false, close = true, description = "Needed for Performance part removal",
		client = { image = "toolbox.png", event = "jim-mechanic:client:Menu" }
	},
	["ducttape"] = {
		label = "Duct Tape", weight = 0, stack = false, close = true, description = "Good for quick fixes",
		client = { image = "bodyrepair.png", event = "jim-mechanic:quickrepair" }
	},
	['mechboard'] = { label = 'Mechanic Sheet', weight = 0, stack = false, close = false,
		buttons = {
			{ 	label = 'Copy Parts List',
				action = function(slot)
					local item = exports.ox_inventory:Search('slots', 'mechboard')
					for _, v in pairs(item) do
						if (v.slot == slot) then lib.setClipboard(v.metadata.info.vehlist) break end
					end
				end },
			{ 	label = 'Copy Plate Number',
				action = function(slot)
					local item = exports.ox_inventory:Search('slots', 'mechboard')
					for _, v in pairs(item) do
						if (v.slot == slot) then lib.setClipboard(v.metadata.info.vehplate) break end
					end
				end },
			{	label = 'Copy Vehicle Model',
				action = function(slot)
					local item = exports.ox_inventory:Search('slots', 'mechboard')
					for _, v in pairs(item) do
						if (v.slot == slot) then lib.setClipboard(v.metadata.info.veh) break  end
					end
				end },
		},
	},
	--Performance
	["turbo"] = {
		label = "Supercharger Turbo", weight = 0, stack = false, close = true, description = "Who doesn't need a 65mm Turbo??",
		client = { image = "turbo.png", event = "jim-mechanic:client:applyTurbo", remove = false },
	},
	["car_armor"] = {
		label = "Vehicle Armor", weight = 0, stack = false, close = true, description = "",
		client = { image = "armour.png", event = "jim-mechanic:client:applyArmour", remove = false },
	},
	["nos"] = {
		label = "NOS Bottle", weight = 0, stack = false, close = true, description = "A full bottle of NOS",
		client = { image = "nos.png", event = "jim-mechanic:client:applyNOS", },
	},
	["noscan"] = {
		label = "Empty NOS Bottle", weight = 0, stack = true, close = true, description = "An Empty bottle of NOS",
		client = { image = "noscan.png", }
	},
	["noscolour"] = {
		label = "NOS Colour Injector", weight = 0, stack = true, close = true, description = "Make that purge spray",
		client = { image = "noscolour.png", }
	},
	
	["engine1"] = {
		label = "Tier 1 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine1.png",  event = "jim-mechanic:client:applyEngine", level = 0, remove = false },
	},
	["engine2"] = {
		label = "Tier 2 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine2.png",  event = "jim-mechanic:client:applyEngine", level = 1, remove = false },
	},
	["engine3"] = {
		label = "Tier 3 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine3.png",  event = "jim-mechanic:client:applyEngine", level = 2, remove = false },
	},
	["engine4"] = {
		label = "Tier 4 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine4.png",  event = "jim-mechanic:client:applyEngine", level = 3, remove = false },
	},
	["engine5"] = {
		label = "Tier 5 Engine", weight = 0, stack = false, close = true, description = "",
		client = { image = "engine5.png",  event = "jim-mechanic:client:applyEngine", level = 4, remove = false },
	},
	
	["transmission1"] = {
		label = "Tier 1 Transmission", weight = 0, stack = false, close = true, description = "",
		client = { image = "transmission1.png",  event = "jim-mechanic:client:applyTransmission", level = 0, remove = false },
	},
	["transmission2"] = {
		label = "Tier 2 Transmission", weight = 0, stack = false, close = true, description = "",
		client = { image = "transmission2.png",  event = "jim-mechanic:client:applyTransmission", level = 1, remove = false },
	},
	["transmission3"] = {
		label = "Tier 3 Transmission", weight = 0, stack = false, close = true, description = "",
		client = { image = "transmission3.png",  event = "jim-mechanic:client:applyTransmission", level = 2, remove = false },
	},
	["transmission4"] = {
		label = "Tier 4 Transmission", weight = 0, stack = false, close = true, description = "",
		client = { image = "transmission4.png",  event = "jim-mechanic:client:applyTransmission", level = 3, remove = false },
	},
	
	["brakes1"] = {
		label = "Tier 1 Brakes", weight = 0, stack = false, close = true, description = "",
		client = { image = "brakes1.png",  event = "jim-mechanic:client:applyBrakes", level = 0, remove = false },
	},
	["brakes2"] = {
		label = "Tier 2 Brakes", weight = 0, stack = false, close = true, description = "",
		client = { image = "brakes2.png",  event = "jim-mechanic:client:applyBrakes", level = 1, remove = false },
	},
	["brakes3"] = {
		label = "Tier 3 Brakes", weight = 0, stack = false, close = true, description = "",
		client = { image = "brakes3.png",  event = "jim-mechanic:client:applyBrakes", level = 2, remove = false },
	},
	
	["suspension1"] = {
		label = "Tier 1 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension1.png", event = "jim-mechanic:client:applySuspension",  level = 0, remove = false },
	},
	["suspension2"] = {
		label = "Tier 2 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension2.png", event = "jim-mechanic:client:applySuspension", level = 1, remove = false },
	},
	["suspension3"] = {
		label = "Tier 3 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension3.png", event = "jim-mechanic:client:applySuspension", level = 2, remove = false },
	},
	["suspension4"] = {
		label = "Tier 4 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension4.png", event = "jim-mechanic:client:applySuspension", level = 3, remove = false },
	},
	["suspension5"] = {
		label = "Tier 5 Suspension", weight = 0, stack = false, close = true, description = "",
		client = { image = "suspension5.png", event = "jim-mechanic:client:applySuspension", level = 4, remove = false },
	},
	
	["bprooftires"] = {
		label = "Bulletproof Tires", weight = 0, stack = false, close = true, description = "",
		client = { image = "bprooftires.png", event = "jim-mechanic:client:applyBulletProof", remove = false },
	},
	["drifttires"] = {
		label = "Drift Tires", weight = 0, stack = false, close = true, description = "",
		client = { image = "drifttires.png", event = "jim-mechanic:client:applyDrift", remove = false },
	},
	
	["oilp1"] = {
		label = "Tier 1 Oil Pump", weight = 0, stack = false, close = true, description = "",
		client = { image = "oilp1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "oilp", remove = false },
	},
	["oilp2"] = {
		label = "Tier 2 Oil Pump", weight = 0, stack = false, close = true, description = "",
		client = { image = "oilp2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "oilp", remove = false },
	},
	["oilp3"] = {
		label = "Tier 3 Oil Pump", weight = 0, stack = false, close = true, description = "",
		client = { image = "oilp3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "oilp", remove = false },
	},
	
	["drives1"] = {
		label = "Tier 1 Drive Shaft", weight = 0, stack = false, close = true, description = "",
		client = { image = "drives1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "drives", remove = false },
	},
	["drives2"] = {
		label = "Tier 2 Drive Shaft", weight = 0, stack = false, close = true, description = "",
		client = { image = "drives2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "drives", remove = false },
	},
	["drives3"] = {
		label = "Tier 3 Drive Shaft", weight = 0, stack = false, close = true, description = "",
		client = { image = "drives3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "drives", remove = false },
	},
	
	["cylind1"] = {
		label = "Tier 1 Cylinder Head", weight = 0, stack = false, close = true, description = "",
		client = { image = "cylind1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "cylind", remove = false },
	},
	["cylind2"] = {
		label = "Tier 2 Cylinder Head", weight = 0, stack = false, close = true, description = "",
		client = { image = "cylind2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "cylind", remove = false },
	},
	["cylind3"] = {
		label = "Tier 3 Cylinder Head", weight = 0, stack = false, close = true, description = "",
		client = { image = "cylind3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "cylind", remove = false },
	},
	
	["cables1"] = {
		label = "Tier 1 Battery Cables", weight = 0, stack = false, close = true, description = "",
		client = { image = "cables1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "cables", remove = false },
	},
	["cables2"] = {
		label = "Tier 2 Battery Cables", weight = 0, stack = false, close = true, description = "",
		client = { image = "cables2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "cables", remove = false },
	},
	["cables3"] = {
		label = "Tier 3 Battery Cables", weight = 0, stack = false, close = true, description = "",
		client = { image = "cables3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "cables", remove = false },
	},
	
	["fueltank1"] = {
		label = "Tier 1 Fuel Tank", weight = 0, stack = false, close = true, description = "",
		client = { image = "fueltank1.png", event = "jim-mechanic:client:applyExtraPart", level = 1, mod = "fueltank", remove = false },
	},
	["fueltank2"] = {
		label = "Tier 2 Fuel Tank", weight = 0, stack = false, close = true, description = "",
		client = { image = "fueltank2.png", event = "jim-mechanic:client:applyExtraPart", level = 2, mod = "fueltank", remove = false },
	},
	["fueltank3"] = {
		label = "Tier 3 Fuel Tank", weight = 0, stack = false, close = true, description = "",
		client = { image = "fueltank3.png", event = "jim-mechanic:client:applyExtraPart", level = 3, mod = "fueltank", remove = false },
	},
	
	["antilag"] = {
		label = "AntiLag", weight = 0, stack = false, close = true, description = "",
		client = { image = "antiLag.png", event = "jim-mechanic:client:applyAntiLag", remove = false },
	},
	
	["underglow_controller"] = {
		label = "Neon Controller", weight = 0, stack = false, close = true, description = "",
		client = { image = "underglow_controller.png", event = "jim-mechanic:client:neonMenu", },
	},
	["headlights"] = {
		label = "Xenon Headlights", weight = 0, stack = false, close = true, description = "",
		client = { image = "headlights.png", event = "jim-mechanic:client:applyXenons", },
	},
	
	["tint_supplies"] = {
		label = "Window Tint Kit", weight = 0, stack = false, close = true, description = "",
		client = { image = "tint_supplies.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	
	["customplate"] = {
		label = "Customized Plates", weight = 0, stack = false, close = true, description = "",
		client = { image = "plate.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["hood"] = {
		label = "Vehicle Hood", weight = 0, stack = false, close = true, description = "",
		client = { image = "hood.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["roof"] = {
		label = "Vehicle Roof", weight = 0, stack = false, close = true, description = "",
		client = { image = "roof.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["spoiler"] = {
		label = "Vehicle Spoiler", weight = 0, stack = false, close = true, description = "",
		client = { image = "spoiler.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["bumper"] = {
		label = "Vehicle Bumper", weight = 0, stack = false, close = true, description = "",
		client = { image = "bumper.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["skirts"] = {
		label = "Vehicle Skirts", weight = 0, stack = false, close = true, description = "",
		client = { image = "skirts.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["exhaust"] = {
		label = "Vehicle Exhaust", weight = 0, stack = false, close = true, description = "",
		client = { image = "exhaust.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["seat"] = {
		label = "Seat Cosmetics", weight = 0, stack = false, close = true, description = "",
		client = { image = "seat.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["rollcage"] = {
		label = "Roll Cage", weight = 0, stack = false, close = true, description = "",
		client = { image = "rollcage.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	
	["rims"] = {
		label = "Custom Wheel Rims", weight = 0, stack = false, close = true, description = "",
		client = { image = "rims.png", event = "jim-mechanic:client:Rims:Check", },
	},
	
	["livery"] = {
		label = "Livery Roll", weight = 0, stack = false, close = true, description = "",
		client = { image = "livery.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["paintcan"] = {
		label = "Vehicle Spray Can", weight = 0, stack = false, close = true, description = "",
		client = { image = "spraycan.png", event = "jim-mechanic:client:Paints:Check", },
	},
	["tires"] = {
		label = "Drift Smoke Tires", weight = 0, stack = false, close = true, description = "",
		client = { image = "tires.png", event = "jim-mechanic:client:Tires:Check", },
	},
	
	["horn"] = {
		label = "Custom Vehicle Horn", weight = 0, stack = false, close = true, description = "",
		client = { image = "horn.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	
	["internals"] = {
		label = "Internal Cosmetics", weight = 0, stack = false, close = true, description = "",
		client = { image = "internals.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	["externals"] = {
		label = "Exterior Cosmetics", weight = 0, stack = false, close = true, description = "",
		client = { image = "mirror.png", event = "jim-mechanic:client:Cosmetic:Check", },
	},
	
	["newoil"] = {
		label = "Car Oil", weight = 0, stack = false, close = true, description = "",
		client = { image = "caroil.png", },
	},
	["sparkplugs"] = {
		label = "Spark Plugs", weight = 0, stack = false, close = true, description = "",
		client = { image = "sparkplugs.png", },
	},
	["carbattery"] = {
		label = "Car Battery", weight = 0, stack = false, close = true, description = "",
		client = { image = "carbattery.png", },
	},
	["axleparts"] = {
		label = "Axle Parts", weight = 0, stack = false, close = true, description = "",
		client = { image = "axleparts.png", },
	},
	["sparetire"] = {
		label = "Spare Tire", weight = 0, stack = false, close = true, description = "",
		client = { image = "sparetire.png", },
	},
	
	["harness"] = {
		label = "Race Harness", weight = 0, stack = true, close = true, description = "Racing Harness so no matter what you stay in the car",
		client = { image = "harness.png", event = "jim-mechanic:client:applyHarness", remove = false },
	},
	
	["manual"] = {
		label = "Manual Transmission", weight = 0, stack = true, close = true, description = "Manual Transmission change for vehicles",
		client = { image = "manual.png", event = "jim-mechanic:client:applyManual", remove = false },
	},
	
	["underglow"] = {
		label = "Underglow LEDS", weight = 0, stack = true, close = true, description = "Underglow addition for vehicles",
		client = { image = "underglow.png", event = "jim-mechanic:client:applyUnderglow", remove = false },
	},
	
	["cleaningkit"] = {
		label = "Cleaning Kit", weight = 0, stack = true, close = true, description = "A microfiber cloth with some soap will let your car sparkle again!",
		client = { image = "cleaningkit.png", event = "jim-mechanic:client:cleanVehicle"},
	},
	--[[["repairkit"] = {
		label = "Repairkit", weight = 0, stack = true, close = true, description = "A nice toolbox with stuff to repair your vehicle",
		client = { image = "repairkit.png", event = "jim-mechanic:vehFailure:RepairVehicle", item = "repairkit", full = false },
	},
	["advancedrepairkit"] = {
		label = "Advanced Repairkit", weight = 0, stack = true, close = true, description = "A nice toolbox with stuff to repair your vehicle",
		client = { image = "advancedkit.png", event = "jim-mechanic:vehFailure:RepairVehicle", item = "advancedrepairkit", full = true },
	},]]
	["bmochi"] = { label = "Blue Mochi", weight = 200, stack = true, close = true, description = "", client = { image = "mochiblue.png", hunger = math.random(40, 50) } },
["pmochi"] = { label = "Pink Mochi", weight = 200, stack = true, close = true, description = "", client = { image = "mochipink.png", hunger = math.random(40, 50) } },
["gmochi"] = { label = "Green Mochi", weight = 200, stack = true, close = true, description = "", client = { image = "mochigreen.png", hunger = math.random(40, 50) } },
["omochi"] = { label = "Orange Mochi", weight = 200, stack = true, close = true, description = "", client = { image = "mochiorange.png", hunger = math.random(40, 50) } },
--to push
["bobatea"] = { label = "Boba Teai", weight = 200, stack = true, close = true, description = "", client = { image = "bubbletea.png", thirst = math.random(40, 50) } },
["bbobatea"] = { label = "Blue Boba Tea", weight = 200, stack = true, close = true, description = "", client = { image = "bubbleteablue.png", thirst = math.random(40, 50) } },
["gbobatea"] = { label = "Green Boba Tea", weight = 200, stack = true, close = true, description = "", client = { image = "bubbleteagreen.png", thirst = math.random(40, 50) } },
["pbobatea"] = { label = "Pink Boba Tea", weight = 200, stack = true, close = true, description = "", client = { image = "bubbleteapink.png", thirst = math.random(40, 50) } },
["obobatea"] = { label = "Orange Boba Tea", weight = 200, stack = true, close = true, description = "", client = { image = "bubbleteaorange.png", thirst = math.random(40, 50) } },

["nekolatte"] = { label = "Neko Latte", weight = 200, stack = true, close = true, description = "", client = { image = "latte.png", thirst = math.random(20, 30) } },
["voodoo"] = { label = "Cat Coffee", weight = 200, stack = true, close = true, description = "", client = { image = "catcoffee.png", thirst = math.random(20, 30) } },

["nekolatte"] = { label = "Neko Latte", weight = 200, stack = true, close = true, description = "", client = { image = "latte.png", thirst = math.random(20, 30) } },
["catcoffee"] = { label = "Cat Coffee", weight = 200, stack = true, close = true, description = "", client = { image = "catcoffee.png", thirst = math.random(20, 30) } },

["sake"] = { label = "Sake", weight = 200, stack = true, close = true, description = "", client = { image = "sake.png", thirst = math.random(20, 30) } },

["miso"] = { label = "Miso Soup", weight = 200, stack = true, close = true, description = "", client = { image = "miso.png", hunger = math.random(20, 30) } },
["cake"] = { label = "Strawberry Cake", weight = 200, stack = true, close = true, description = "", client = { image = "cake.png", hunger = math.random(20, 30) } },
["bento"] = { label = "Bento Box", weight = 200, stack = true, close = true, description = "", client = { image = "bento.png", hunger = math.random(20, 30) } },

["riceball"] = { label = "Neko Onigiri", weight = 200, stack = true, close = true, description = "", client = { image = "catrice.png", hunger = math.random(20, 30) } },

["nekocookie"] = { label = "Neko Cookie", weight = 200, stack = true, close = true, description = "", client = { image = "catcookie.png", hunger = math.random(20, 30) } },
["nekodonut"] = { label = "Neko Donut", weight = 200, stack = true, close = true, description = "", client = { image = "catdonut.png", hunger = math.random(20, 30) } },

["boba"] = { label = "Boba", weight = 200, stack = true, close = true, description = "", client = { image = "boba.png", hunger = math.random(20, 30) } },
["flour"] = { label = "Flour", weight = 200, stack = true, close = true, description = "", client = { image = "flour.png", hunger = math.random(20, 30) } },
["rice"] = { label = "Bowl of Rice", weight = 200, stack = true, close = true, description = "", client = { image = "rice.png", hunger = math.random(20, 30) } },
["sugar"] = { label = "Sugar", weight = 200, stack = true, close = true, description = "", client = { image = "sugar.png", hunger = math.random(20, 30) } },
["nori"] = { label = "Nori", weight = 200, stack = true, close = true, description = "", client = { image = "nori.png", } },
["blueberry"] = { label = "Blueberry", weight = 200, stack = true, close = true, description = "", client = { image = "blueberry.png", hunger = math.random(20, 30) } },
["strawberry"] = { label = "Strawberry", weight = 200, stack = true, close = true, description = "", client = { image = "strawberry.png", hunger = math.random(20, 30) } },
["orange"] = { label = "Orange", weight = 200, stack = true, close = true, description = "", client = { image = "orange.png", } },
["mint"] = { label = "Matcha", weight = 200, stack = true, close = true, description = "", client = { image = "matcha.png", } },
["tofu"] = { label = "Tofu", weight = 200, stack = true, close = true, description = "", client = { image = "tofu.png", hunger = math.random(20, 30) } },

["mocha"] = { label = "Mocha Meow", weight = 200, stack = true, close = true, description = "", client = { image = "mochameow.png", thirst = math.random(20, 30) } },

["cakepop"] = { label = "Cat Cake-Pop", weight = 200, stack = true, close = true, description = "", client = { image = "cakepop.png", hunger = math.random(20, 30) } },
["pancake"] = { label = "PawCake", weight = 200, stack = true, close = true, description = "", client = { image = "pawcakes.png", hunger = math.random(20, 30) } },
["pizza"] = { label = "Kitty Pizza", weight = 200, stack = true, close = true, description = "", client = { image = "catpizza.png", hunger = math.random(20, 30) } },
["purrito"] = { label = "Purrito", weight = 200, stack = true, close = true, description = "", client = { image = "purrito.png", hunger = math.random(20, 30) } },

["noodlebowl"] = { label = "Bowl of Noodles", weight = 200, stack = true, close = true, description = "", client = { image = "noodlebowl.png", hunger = math.random(20, 30) } },
["noodles"] = { label = "Instant Noodles", weight = 200, stack = true, close = true, description = "", client = { image = "noodles.png", } },
["ramen"] = { label = "owl of Ramen", weight = 200, stack = true, close = true, description = "", client = { image = "ramen.png", hunger = math.random(20, 30) } },

["milk"] = { label = "Milk", weight = 200, stack = true, close = true, description = "", client = { image = "burger-milk.png", thirst = math.random(20, 30) } },
["onion"] = { label = "Onion", weight = 200, stack = true, close = true, description = "", client = { image = "burger-onion.png", } },

	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['cola'] = {
		label = 'eCola',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},

	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Mastercard',
		stack = false,
		weight = 10,
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},
}
