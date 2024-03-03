return {
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

	["beer"] = {
		label = "Bira",
		weight = 500,
		stack = true,
		close = true,
		description = "Soğuk biradan iyisi yok!",
		client = {
			image = "beer.png",
		}
	},

	["goldbar"] = {
		label = "Altın Bar",
		weight = 2000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "goldbar.png",
		}
	},

	["soybeans"] = {
		label = "Soya Fasulyesi",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "soybeans.png",
		}
	},

	["thermite"] = {
		label = "Termit",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "thermite.png",
		}
	},

	["weed_nutrition"] = {
		label = "Plant Fertilizer",
		weight = 2000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_nutrition.png",
		}
	},

	["sharkhammer"] = {
		label = "Köpek Balığı",
		weight = 5000,
		stack = false,
		close = false,
		description = "Hammerhead Shark",
		client = {
			image = "sharkhammer.png",
		}
	},

	["marijuana_water"] = {
		label = "Bitki Suyu",
		weight = 0,
		stack = true,
		close = true,
		description = "Plant water",
		client = {
			image = "marijuana_water.png",
		}
	},

	["mining_goldnugget"] = {
		label = "Altın Külçe",
		weight = 500,
		stack = true,
		close = true,
		description = "Golden nugget from mining",
		client = {
			image = "mining_goldnugget.png",
		}
	},

	["pinger"] = {
		label = "Pinger",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pinger.png",
		}
	},

	["pants"] = {
		label = "Pantalon",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "pants.png",
		}
	},

	["pixellaptop"] = {
		label = "Pixel Leptop",
		weight = 2000,
		stack = false,
		close = true,
		description = "Boosting Laptop",
		client = {
			image = "tunerchip.png",
		}
	},

	["casino_redchip"] = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Inside Track Chip",
		client = {
			image = "casino_redchip.png",
		}
	},

	["anchovy"] = {
		label = "Anchovy",
		weight = 50,
		stack = true,
		close = true,
		description = "On new years eve a nice fire to stand next to",
		client = {
			image = "anchovy.png",
		}
	},

	["rawpumpkin"] = {
		label = "Ham Kabak",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_pumpkin.png",
		}
	},

	["keepcompanionhusky"] = {
		label = "Husky",
		weight = 500,
		stack = false,
		close = true,
		description = "Husky is your royal companion!",
		client = {
			image = "A_C_Husky.png",
		}
	},

	["raw_beef"] = {
		label = "Çiğ biftek",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_beef.png",
		}
	},

	["keepcompanioncat"] = {
		label = "Cat",
		weight = 500,
		stack = false,
		close = true,
		description = "Cat is your royal companion!",
		client = {
			image = "A_C_Cat_01.png",
		}
	},

	["hotsauce"] = {
		label = "Acı Sos",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "hotsauce.png",
		}
	},

	["firework2"] = {
		label = "Poppelers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework2.png",
		}
	},

	["casino_bluechip"] = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Roulette Chip",
		client = {
			image = "casino_bluechip.png",
		}
	},

	["fishinglootbig"] = {
		label = "Büyük Balık Kutusu",
		weight = 2500,
		stack = true,
		close = true,
		description = "The lock seems to be intact, Might need a key",
		client = {
			image = "fishinglootbig.png",
		}
	},

	["cokebaggy"] = {
		label = "Kokain Torbası",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cocaine_baggy.png",
		}
	},

	["beef"] = {
		label = "Biftek",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "beef.png",
		}
	},

	["kelepceanahtar"] = {
		label = "Kelepçe Anahtarı",
		weight = 250,
		stack = true,
		close = true,
		description = "Kendine ait kelepçeyi açabilen bir anahtar.",
		client = {
			image = "kelepceanahtar.png",
		}
	},

	["keepcompanionrabbit"] = {
		label = "Rabbit",
		weight = 500,
		stack = false,
		close = true,
		description = "Rabbit is your royal companion!",
		client = {
			image = "A_C_Rabbit_01.png",
		}
	},

	["filled_evidence_bag"] = {
		label = "Kanıt Torbası",
		weight = 200,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "evidence.png",
		}
	},

	["meatlion"] = {
		label = "Puma Pençeleri",
		weight = 100,
		stack = true,
		close = false,
		description = "Cougar Claw",
		client = {
			image = "cougarclaw.png",
		}
	},

	["mining_ironfragment"] = {
		label = "Demir Parçası",
		weight = 500,
		stack = true,
		close = true,
		description = "Iron fragment from mining",
		client = {
			image = "mining_ironfragment.png",
		}
	},

	["carettacaretta"] = {
		label = "Kaplumbağa",
		weight = 50,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)",
		client = {
			image = "carettacaretta.png",
		}
	},

	["fishingrod2"] = {
		label = "Fishing Rod (2Lv.)",
		weight = 50,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)",
		client = {
			image = "fishingrod2.png",
		}
	},

	["weed_purple-haze_seed"] = {
		label = "Purple Haze Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_seed.png",
		}
	},

	["marijuana_1oz_low"] = {
		label = "1 ons esrar",
		weight = 2800,
		stack = false,
		close = false,
		description = "1oz low grade marijuana",
		client = {
			image = "marijuana_1oz_low.png",
		}
	},

	["petwaterbottleportable"] = {
		label = "Portable water bottle",
		weight = 1000,
		stack = false,
		close = true,
		description = "Flask to store water for your pets",
		client = {
			image = "petwaterbottleportable.png",
		}
	},

	["mining_stone"] = {
		label = "Maden Taşı",
		weight = 500,
		stack = true,
		close = true,
		description = "Mined Stone",
		client = {
			image = "mining_stone.png",
		}
	},

	["rentalpapers"] = {
		label = "Kira Dekontu",
		weight = 150,
		stack = true,
		close = true,
		description = "Hunting Bait",
		client = {
			image = "rentalpapers.png",
		}
	},

	["weed_og-kush_seed"] = {
		label = "OGKush Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_seed.png",
		}
	},

	["security_card_02"] = {
		label = "Güvenlik Kartı B",
		weight = 0,
		stack = true,
		close = true,
		description = "Bir güvenlik kartı... Ne işe yaradığını kimse bilmiyor",
		client = {
			image = "security_card_02.png",
		}
	},

	["fishbait"] = {
		label = "Balık Yemi",
		weight = 400,
		stack = true,
		close = true,
		description = "Fishing bait",
		client = {
			image = "fishbait.png",
		}
	},

	["casino_member"] = {
		label = "Casino Membership",
		weight = 500,
		stack = false,
		close = false,
		description = "Diamond Casino Member Card",
		client = {
			image = "casino_member.png",
		}
	},

	["weed_brick"] = {
		label = "Ot Tuğlası",
		weight = 1000,
		stack = true,
		close = true,
		description = ".",
		client = {
			image = "weed_brick.png",
		}
	},

	["fish"] = {
		label = "Tiny Fish",
		weight = 50,
		stack = false,
		close = true,
		description = "A nice document",
		client = {
			image = "fish.png",
		}
	},

	["ironoxide"] = {
		label = "Demir Tozu",
		weight = 100,
		stack = true,
		close = false,
		description = "Aliminyumoksit ile birleştirebilirsin.",
		client = {
			image = "ironoxide.png",
		}
	},

	["diving_gear"] = {
		label = "Dalış Takımı",
		weight = 5000,
		stack = false,
		close = true,
		description = "Su altında nefes almak istiyorsan takmalısın",
		client = {
			image = "diving_gear.png",
		}
	},

	["nitrous"] = {
		label = "Nitro",
		weight = 1000,
		stack = true,
		close = true,
		description = "Suuuppprrraaaaaaa",
		client = {
			image = "nitrous.png",
		}
	},

	["chain"] = {
		label = "Chaine",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "chain.png",
		}
	},

	["raw_ham"] = {
		label = "Çiğ Jambon",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_ham.png",
		}
	},

	["labkey"] = {
		label = "Anahtar",
		weight = 500,
		stack = false,
		close = true,
		description = "Bir kilit için anahtar...?",
		client = {
			image = "labkey.png",
		}
	},

	["fishingrod5"] = {
		label = "Fishing Rod (5Lv.)",
		weight = 50,
		stack = true,
		close = true,
		description = "Sneaky Breaky...",
		client = {
			image = "fishingrod5.png",
		}
	},

	["bluepearl"] = {
		label = "Blue Pearl",
		weight = 50,
		stack = true,
		close = true,
		description = "On new years eve a nice fire to stand next to",
		client = {
			image = "bluepearl.png",
		}
	},

	["fishingrod1"] = {
		label = "Fishing Rod (1Lv.)",
		weight = 50,
		stack = true,
		close = false,
		description = "Chips For Casino Gambling",
		client = {
			image = "fishingrod1.png",
		}
	},

	["smallbluefish"] = {
		label = "Small Blue Fish",
		weight = 50,
		stack = true,
		close = true,
		description = "Certificate that proves you own certain stuff",
		client = {
			image = "smallbluefish.png",
		}
	},

	["casino_blackchip"] = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Blackjack Chip",
		client = {
			image = "casino_blackchip.png",
		}
	},

	["meatcoyote"] = {
		label = "Çakal Postu",
		weight = 100,
		stack = true,
		close = false,
		description = "Coyote Pelt",
		client = {
			image = "coyotepelt.png",
		}
	},

	["apple"] = {
		label = "Elma",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "apple.png",
		}
	},

	["methlab"] = {
		label = "Lab",
		weight = 15000,
		stack = true,
		close = false,
		description = "A portable Meth Lab",
		client = {
			image = "lab.png",
		}
	},

	["aluminumoxide"] = {
		label = "Aliminyum Tozu",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "aluminumoxide.png",
		}
	},

	["vpn"] = {
		label = "VPN",
		weight = 700,
		stack = false,
		close = false,
		description = "vpn for good use",
		client = {
			image = "vpn.png",
		}
	},

	["moneybag"] = {
		label = "Para Torbası",
		weight = 0,
		stack = false,
		close = true,
		description = "Para dolu bir torba",
		client = {
			image = "moneybag.png",
		}
	},

	["tshirt"] = {
		label = "T-Shirt",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "tshirt.png",
		}
	},

	["drill"] = {
		label = "Matkap",
		weight = 20000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "drill.png",
		}
	},

	["keepcompanionpug"] = {
		label = "Pug",
		weight = 500,
		stack = false,
		close = true,
		description = "Pug is your royal companion!",
		client = {
			image = "A_C_Pug.png",
		}
	},

	["mining_pan"] = {
		label = "Yıkama Tavası",
		weight = 500,
		stack = false,
		close = true,
		description = "Classic's washing pan",
		client = {
			image = "mining_pan.png",
		}
	},

	["tablet"] = {
		label = "Tablet",
		weight = 2000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tablet.png",
		}
	},

	["pkelepceanahtar"] = {
		label = "Polis Anahtarı",
		weight = 50,
		stack = true,
		close = true,
		description = "Her polis kelepçesini açabilen, polis anahtarı.",
		client = {
			image = "pkelepceanahtar.png",
		}
	},

	["snikkel_candy"] = {
		label = "Snikkel",
		weight = 100,
		stack = true,
		close = true,
		description = "Açlığını yatıştır",
		client = {
			image = "snikkel_candy.png",
		}
	},

	["weed_purple-haze"] = {
		label = "Purple Haze 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "weed_baggy.png",
		}
	},

	["pearlscard"] = {
		label = "İnci Kartı",
		weight = 100,
		stack = true,
		close = true,
		description = "A special member of Pearl's Seafood Restaurant",
		client = {
			image = "pearlscard.png",
		}
	},

	["casino_whitechip"] = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Slot Machine Chip",
		client = {
			image = "casino_whitechip.png",
		}
	},

	["whitepearl"] = {
		label = "White Pearl",
		weight = 50,
		stack = true,
		close = true,
		description = "Sneaky Breaky...",
		client = {
			image = "whitepearl.png",
		}
	},

	["dolphin"] = {
		label = "Yunus Balığı",
		weight = 5000,
		stack = false,
		close = false,
		description = "Dolphin",
		client = {
			image = "dolphin.png",
		}
	},

	["tree_bark"] = {
		label = "Tree Bark",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "treebark.png",
		}
	},

	["marijuana_3.5_mid"] = {
		label = "3.5 gr esrar",
		weight = 2800,
		stack = false,
		close = true,
		description = "3.5g mid grade marijuana",
		client = {
			image = "marijuana_3.5_mid.png",
		}
	},

	["pkelepce"] = {
		label = "Polis Kelepçesi",
		weight = 100,
		stack = true,
		close = true,
		description = "Kaliteli çelikten yapılma, güçlü polis kelepçesi.",
		client = {
			image = "pkelepce.png",
		}
	},

	["yellowpearl"] = {
		label = "Yellow Pearl",
		weight = 50,
		stack = false,
		close = true,
		description = "Money?",
		client = {
			image = "yellowpearl.png",
		}
	},

	["collarpet"] = {
		label = "Pet collar",
		weight = 500,
		stack = true,
		close = true,
		description = "Rename your pets!",
		client = {
			image = "collarpet.png",
		}
	},

	["slicedpie"] = {
		label = "Dilim Pasta",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "slicedpie.png",
		}
	},

	["torso"] = {
		label = "Haut",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "tshirt.png",
		}
	},

	["electronickit"] = {
		label = "Elektronik Kit",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "electronickit.png",
		}
	},

	["helmet"] = {
		label = "Chapeau",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "hat.png",
		}
	},

	["marijuana_baggies"] = {
		label = "Çantalar",
		weight = 0,
		stack = true,
		close = true,
		description = "Need some baggies? i got some baggies",
		client = {
			image = "marijuana_baggies.png",
		}
	},

	["stickynote"] = {
		label = "Yapışkan Not",
		weight = 0,
		stack = false,
		close = false,
		description = "Bir şeyleri hatırlamak için :)",
		client = {
			image = "stickynote.png",
		}
	},

	["fishingboot"] = {
		label = "Eskimiş Bot",
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Boot",
		client = {
			image = "fishingboot.png",
		}
	},

	["meatpig"] = {
		label = "Domuz Eti",
		weight = 100,
		stack = true,
		close = false,
		description = "Pig Meat",
		client = {
			image = "pigpelt.png",
		}
	},

	["iron"] = {
		label = "Demir",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "iron.png",
		}
	},

	["iphone"] = {
		label = "iPhone",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "iphone.png",
		}
	},

	["mining_ironbar"] = {
		label = "Demir Çubuk",
		weight = 500,
		stack = true,
		close = true,
		description = "Iron Bar",
		client = {
			image = "mining_ironbar.png",
		}
	},

	["decals"] = {
		label = "Stickers",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "mask.png",
		}
	},

	["trojan_usb"] = {
		label = "Trojan USB",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "usb_device.png",
		}
	},

	["kapsul"] = {
		label = "Kapsül",
		weight = 200,
		stack = true,
		close = false,
		description = "Bodycam for police officers!",
		client = {
			image = "kapsul.png",
		}
	},

	["casino_goldchip"] = {
		label = "Casino Chip",
		weight = 0,
		stack = true,
		close = false,
		description = "Diamond Casino Chip",
		client = {
			image = "casino_goldchip.png",
		}
	},

	["marijuana_seeds"] = {
		label = "Tohum",
		weight = 500,
		stack = true,
		close = true,
		description = "marijuana seeds",
		client = {
			image = "marijuana_seeds.png",
		}
	},

	["diamond_ring"] = {
		label = "Elmas Yüzük",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "diamond_ring.png",
		}
	},

	["perch"] = {
		label = "Perch",
		weight = 50,
		stack = true,
		close = false,
		description = "Chips For Casino Gambling",
		client = {
			image = "perch.png",
		}
	},

	["cooked_bacon"] = {
		label = "Pişmiş Domuz Pastırması",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cooked_bacon.png",
		}
	},

	["meatcow"] = {
		label = "İnek Postu",
		weight = 100,
		stack = true,
		close = false,
		description = "Cow Pelt",
		client = {
			image = "cowpelt.png",
		}
	},

	["greenpearl"] = {
		label = "Green Pearl",
		weight = 50,
		stack = false,
		close = true,
		description = "Key for a lock...?",
		client = {
			image = "greenpearl.png",
		}
	},

	["garfish"] = {
		label = "Garfish",
		weight = 50,
		stack = false,
		close = true,
		description = "A nice document",
		client = {
			image = "garfish.png",
		}
	},

	["meatboar"] = {
		label = "Domuz Dişleri",
		weight = 100,
		stack = true,
		close = false,
		description = "Boar Tusks",
		client = {
			image = "boartusks.png",
		}
	},

	["fishicebox"] = {
		label = "Balık Kutusu",
		weight = 2500,
		stack = false,
		close = true,
		description = "Ice Box to store all of your fish",
		client = {
			image = "fishicebox.png",
		}
	},

	["goldchain"] = {
		label = "Altın Kolye",
		weight = 1500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "goldchain.png",
		}
	},

	["dendrogyra_coral"] = {
		label = "Beyaz Mercan",
		weight = 1000,
		stack = true,
		close = true,
		description = "Sütun mercanı olarak da bilinir",
		client = {
			image = "dendrogyra_coral.png",
		}
	},

	["petgroomingkit"] = {
		label = "Pet Grooming Kit",
		weight = 1000,
		stack = false,
		close = true,
		description = "Pet Grooming Kit",
		client = {
			image = "petgroomingkit.png",
		}
	},

	["tracker"] = {
		label = "Tracker",
		weight = 700,
		stack = false,
		close = true,
		description = "this laptop need vpn to make it work",
		client = {
			image = "tracker.png",
		}
	},

	["pantfish"] = {
		label = "Pant Fish",
		weight = 50,
		stack = false,
		close = true,
		description = "A bag with cash",
		client = {
			image = "pantfish.png",
		}
	},

	["marijuana_trowel"] = {
		label = "Mala",
		weight = 0,
		stack = true,
		close = true,
		description = "Small handheld garden shovel",
		client = {
			image = "marijuana_trowel.png",
		}
	},

	["meatdeer"] = {
		label = "Geyik Boynuzu",
		weight = 100,
		stack = true,
		close = false,
		description = "Deer Horns",
		client = {
			image = "deerhorns.png",
		}
	},

	["cooked_ham"] = {
		label = "Pişmiş Jambon",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cooked_ham.png",
		}
	},

	["milk"] = {
		label = "Süt",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "milk.png",
		}
	},

	["diving_fill"] = {
		label = "Dalış Tüpü",
		weight = 3000,
		stack = false,
		close = true,
		client = {
			image = "diving_tube.png",
		}
	},

	["grape"] = {
		label = "Üzüm",
		weight = 100,
		stack = true,
		close = false,
		description = "Üzümü sevmeyen yoktur?",
		client = {
			image = "grape.png",
		}
	},

	["weed_ak47_seed"] = {
		label = "AK47 Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_seed.png",
		}
	},

	["bproof"] = {
		label = "Gillet Pare-balle",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "bproof.png",
		}
	},

	["tomatopaste"] = {
		label = "Domates Ezmesi",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tomatopaste.png",
		}
	},

	["empty_evidence_bag"] = {
		label = "Boş Kanıt Torbası",
		weight = 0,
		stack = true,
		close = false,
		description = "DNA, kan ve mermi kovanları için gereken torba.",
		client = {
			image = "evidence.png",
		}
	},

	["snowball"] = {
		label = "Kar Topu",
		weight = 0,
		stack = true,
		close = true,
		description = "Neden isabet etmiyor :D",
		client = {
			image = "snowball.png",
		}
	},

	["marijuana_3.5_low"] = {
		label = "3.5gr Esrar",
		weight = 2800,
		stack = false,
		close = true,
		description = "3.5g low grade marijuana",
		client = {
			image = "marijuana_3.5_low.png",
		}
	},

	["marijuana_phone"] = {
		label = "Yazıcı Telefonu",
		weight = 0,
		stack = true,
		close = true,
		description = "Burner phone used to sell eights",
		client = {
			image = "marijuana_phone.png",
		}
	},

	["keepcompanionretriever"] = {
		label = "Retriever",
		weight = 500,
		stack = false,
		close = true,
		description = "Retriever is your royal companion!",
		client = {
			image = "A_C_Retriever.png",
		}
	},

	["antipatharia_coral"] = {
		label = "Mavi Mercan",
		weight = 1000,
		stack = true,
		close = true,
		description = "Siyah mercanlar veya dikenli mercanlar olarak da bilinir",
		client = {
			image = "antipatharia_coral.png",
		}
	},

	["samsungphone"] = {
		label = "Samsung S10",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "samsungphone.png",
		}
	},

	["bags"] = {
		label = "Sac",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "bag.png",
		}
	},

	["pig_leather"] = {
		label = "Domuz Derisi",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pig_leather.png",
		}
	},

	["twerks_candy"] = {
		label = "Twerks",
		weight = 100,
		stack = true,
		close = true,
		description = "Açlığını yatıştır",
		client = {
			image = "twerks_candy.png",
		}
	},

	["flounder"] = {
		label = "Pisi balığı",
		weight = 2500,
		stack = false,
		close = false,
		description = "Flounder",
		client = {
			image = "flounder.png",
		}
	},

	["water_bottle"] = {
		label = "Su",
		weight = 500,
		stack = true,
		close = true,
		description = "Susuzluk için birebir",
		client = {
			image = "water_bottle.png",
		}
	},

	["glass"] = {
		label = "Cam",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "glass.png",
		}
	},

	["gatecrack"] = {
		label = "Geçit",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "usb_device.png",
		}
	},

	["joint"] = {
		label = "Joint",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "joint.png",
		}
	},

	["mining_washedstone"] = {
		label = "Yıkanmış Taş",
		weight = 500,
		stack = true,
		close = true,
		description = "Wasted Stone",
		client = {
			image = "mining_washedstone.png",
		}
	},

	["weed_og-kush"] = {
		label = "OGKush 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "weed_baggy.png",
		}
	},

	["marijuana_joint"] = {
		label = "Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "1g joint",
		client = {
			image = "marijuana_joint.png",
		}
	},

	["cryptostick"] = {
		label = "Kripto Parçası",
		weight = 200,
		stack = false,
		close = true,
		description = "Paranın geçmediği yerde bu geçer...",
		client = {
			image = "cryptostick.png",
		}
	},

	["bass"] = {
		label = "Bass",
		weight = 1250,
		stack = false,
		close = false,
		description = "A normal fish Tatses pretty good!",
		client = {
			image = "bass.png",
		}
	},

	["disabler"] = {
		label = "Disabler",
		weight = 500,
		stack = true,
		close = true,
		description = "for the boosting contracts",
		client = {
			image = "tablet.png",
		}
	},

	["police_stormram"] = {
		label = "Koçbaşı",
		weight = 5000,
		stack = true,
		close = true,
		description = "Kapıları kırmak için birebir.",
		client = {
			image = "police_stormram.png",
		}
	},

	["keepcompanioncoyote"] = {
		label = "Coyote",
		weight = 500,
		stack = false,
		close = true,
		description = "Coyote is your royal companion!",
		client = {
			image = "A_C_Coyote.png",
		}
	},

	["visa"] = {
		label = "Visa Kart",
		weight = 0,
		stack = false,
		close = false,
		description = "ATM de kullanabileceğiniz kart",
		client = {
			image = "visacard.png",
		}
	},

	["darklaptop"] = {
		label = "Hack Laptop",
		weight = 700,
		stack = false,
		close = true,
		description = "this laptop need vpn to make it work",
		client = {
			image = "laptop.png",
		}
	},

	["keepcompanionhen"] = {
		label = "Hen",
		weight = 500,
		stack = false,
		close = true,
		description = "Hen is your royal companion!",
		client = {
			image = "A_C_Hen.png",
		}
	},

	["handcuffs"] = {
		label = "Kelepçe",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "handcuffs.png",
		}
	},

	["laptop"] = {
		label = "Laptop",
		weight = 4000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "laptop.png",
		}
	},

	["firework1"] = {
		label = "2Brothers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework1.png",
		}
	},

	["keepcompanionmtlion2"] = {
		label = "Panter",
		weight = 500,
		stack = false,
		close = true,
		description = "Panter is your royal companion!",
		client = {
			image = "A_C_MtLion.png",
		}
	},

	["weed_skunk_seed"] = {
		label = "Skunk Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_seed.png",
		}
	},

	["canofcorn"] = {
		label = "Mısır Konservesi",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "canofcorn.png",
		}
	},

	["marijuana_3.5_high"] = {
		label = "3.5g esrar",
		weight = 2800,
		stack = false,
		close = true,
		description = "3.5g high grade marijuana",
		client = {
			image = "marijuana_3.5_high.png",
		}
	},

	["rolex"] = {
		label = "Altın Saat",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "rolex.png",
		}
	},

	["grapes"] = {
		label = "Üzüm",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grapes.png",
		}
	},

	["kurkakola"] = {
		label = "Kola",
		weight = 500,
		stack = true,
		close = true,
		description = "Susuzluk için birebir",
		client = {
			image = "cola.png",
		}
	},

	["weed_skunk"] = {
		label = "Skunk 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "weed_baggy.png",
		}
	},

	["certificate"] = {
		label = "Sertifika",
		weight = 0,
		stack = true,
		close = true,
		description = "Bazı şeylere sahip olduğunuzu kanıtlayan sertifika",
		client = {
			image = "certificate.png",
		}
	},

	["stingray"] = {
		label = "Vatoz",
		weight = 2500,
		stack = false,
		close = false,
		description = "Stingray",
		client = {
			image = "stingray.png",
		}
	},

	["centralchip"] = {
		label = "Sentral Çip",
		weight = 700,
		stack = false,
		close = true,
		description = "this laptop need vpn to make it work",
		client = {
			image = "centralchip.png",
		}
	},

	["marijuana_joint3g"] = {
		label = "Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "3g joint",
		client = {
			image = "marijuana_joint3g.png",
		}
	},

	["advancedrepairkit"] = {
		label = "Gelişmiş Tamir Kiti",
		weight = 4000,
		stack = true,
		close = true,
		description = "Aracınız için gelişmiş tamir kiti",
		client = {
			image = "advancedkit.png",
		}
	},

	["lithium"] = {
		label = "Lithium",
		weight = 1000,
		stack = true,
		close = false,
		description = "Lithium, something you can make Meth with!",
		client = {
			image = "lithium.png",
		}
	},

	["wine"] = {
		label = "Şarap",
		weight = 300,
		stack = true,
		close = false,
		description = "Güzel akşamların vazgeçilmez dostu",
		client = {
			image = "wine.png",
		}
	},

	["greenpepper"] = {
		label = "Yeşil biber",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "greenpepper.png",
		}
	},

	["keepcompanionmtlion"] = {
		label = "MtLion",
		weight = 500,
		stack = false,
		close = true,
		description = "MtLion is your royal companion!",
		client = {
			image = "A_C_MtLion.png",
		}
	},

	["tomato"] = {
		label = "Domates",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tomato.png",
		}
	},

	["mining_copperfragment"] = {
		label = "Bakır Parçası",
		weight = 500,
		stack = true,
		close = true,
		description = "Copper fragment from mining",
		client = {
			image = "mining_copperfragment.png",
		}
	},

	["weaponlicense"] = {
		label = "Silah Lisansı",
		weight = 0,
		stack = false,
		close = true,
		description = "Silah kullanımı için gereken lisans",
		client = {
			image = "weapon_license.png",
		}
	},

	["mackerel"] = {
		label = "Orkinos",
		weight = 2500,
		stack = false,
		close = false,
		description = "Mackerel",
		client = {
			image = "mackerel.png",
		}
	},

	["marijuana_nutrition"] = {
		label = "Bitki Gübresi",
		weight = 0,
		stack = true,
		close = true,
		description = "Plant nutrition",
		client = {
			image = "marijuana_nutrition.png",
		}
	},

	["fishingrod"] = {
		label = "Olta",
		weight = 750,
		stack = true,
		close = true,
		description = "A fishing rod for adventures with friends!!",
		client = {
			image = "fishingrod.png",
		}
	},

	["milkbucket"] = {
		label = "Süt Kovası",
		weight = 75,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "milkbucket.png",
		}
	},

	["apple_juice"] = {
		label = "Elma Suyu",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "apple_juice.png",
		}
	},

	["keepcompanionpoodle"] = {
		label = "Poodle",
		weight = 500,
		stack = false,
		close = true,
		description = "Poodle is your royal companion!",
		client = {
			image = "A_C_Poodle.png",
		}
	},

	["aluminum"] = {
		label = "Aliminyum",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "aluminum.png",
		}
	},

	["rubber"] = {
		label = "Lastik",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "rubber.png",
		}
	},

	["heavyarmor"] = {
		label = "Ağır Zırh",
		weight = 5000,
		stack = true,
		close = true,
		description = "%100 Zırh sağlar.",
		client = {
			image = "armor.png",
		}
	},

	["cooked_sausage"] = {
		label = "Pişmiş Sosis",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cooked_sausage.png",
		}
	},

	["lawyerpass"] = {
		label = "Avukat İzni",
		weight = 0,
		stack = false,
		close = false,
		description = "Bir şüpheliyi temsil edebileceklerini göstermek için avukatlara özel geçiş belgesi",
		client = {
			image = "lawyerpass.png",
		}
	},

	["casino_vip"] = {
		label = "V.I.P Membership",
		weight = 500,
		stack = false,
		close = false,
		description = "Diamond Casino V.I.P Card",
		client = {
			image = "casino_vip.png",
		}
	},

	["fishingrod3"] = {
		label = "Fishing Rod (3Lv.)",
		weight = 50,
		stack = false,
		close = true,
		description = "A bag with cash",
		client = {
			image = "fishingrod3.png",
		}
	},

	["repairkit"] = {
		label = "Tamir Kiti",
		weight = 2500,
		stack = true,
		close = true,
		description = "Aracınız için tamir kiti",
		client = {
			image = "repairkit.png",
		}
	},

	["killerwhale"] = {
		label = "Katil balina",
		weight = 15000,
		stack = false,
		close = false,
		description = "Killer Whale",
		client = {
			image = "killerwhale.png",
		}
	},

	["vodka"] = {
		label = "Votka",
		weight = 500,
		stack = true,
		close = true,
		description = "Rusların en sevdiği içki",
		client = {
			image = "vodka.png",
		}
	},

	["ears"] = {
		label = "Boucle d'oreille",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "bracelet.png",
		}
	},

	["coke_small_brick"] = {
		label = "Kokani Paketi",
		weight = 350,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "coke_small_brick.png",
		}
	},

	["markedbills"] = {
		label = "Kara Para",
		weight = 0,
		stack = false,
		close = true,
		description = "Para?",
		client = {
			image = "markedbills.png",
		}
	},

	["painkillers"] = {
		label = "Ağrı Kesici",
		weight = 0,
		stack = true,
		close = true,
		description = "Kanamayı durdurmanın en hızlı yolu",
		client = {
			image = "painkillers.png",
		}
	},

	["driver_license"] = {
		label = "Ehliyet",
		weight = 0,
		stack = false,
		close = false,
		description = "Araç kullanabileceğinizi gösterme izni",
		client = {
			image = "driver_license.png",
		}
	},

	["binoculars"] = {
		label = "Dürbün",
		weight = 600,
		stack = true,
		close = true,
		description = "...",
		client = {
			image = "binoculars.png",
		}
	},

	["emptycowbucket"] = {
		label = "Boş kova",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "emptybucket.png",
		}
	},

	["marijuana_1oz_high"] = {
		label = "1ons esrar",
		weight = 2800,
		stack = false,
		close = false,
		description = "1oz high grade marijuana",
		client = {
			image = "marijuana_1oz_high.png",
		}
	},

	["arms"] = {
		label = "Gants",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "gloves.png",
		}
	},

	["empty_weed_bag"] = {
		label = "Boş Ot Torbası",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "empty_weed_bag.png",
		}
	},

	["firework3"] = {
		label = "WipeOut",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework3.png",
		}
	},

	["security_card_01"] = {
		label = "Güvenlik Kartı A",
		weight = 0,
		stack = true,
		close = true,
		description = "Bir güvenlik kartı... Ne işe yaradığını kimse bilmiyor",
		client = {
			image = "security_card_01.png",
		}
	},

	["casinochips"] = {
		label = "Kumar Çipi",
		weight = 0,
		stack = true,
		close = false,
		description = "Gazinoda kullanılan çip",
		client = {
			image = "casinochips.png",
		}
	},

	["radioscanner"] = {
		label = "Sinyal Tarayıcı",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "radioscanner.png",
		}
	},

	["raw_pork"] = {
		label = "Çiğ Domuz",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_pork.png",
		}
	},

	["fishingrod4"] = {
		label = "Fishing Rod (4Lv.)",
		weight = 50,
		stack = false,
		close = true,
		description = "The sky is the limit! Woohoo!",
		client = {
			image = "fishingrod4.png",
		}
	},

	["coke_brick"] = {
		label = "Kokain Tuğlası",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "coke_brick.png",
		}
	},

	["fishingtin"] = {
		label = "Boş Kavanoz",
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Tin",
		client = {
			image = "fishingtin.png",
		}
	},

	["sharkfish"] = {
		label = "Shark",
		weight = 50,
		stack = false,
		close = true,
		description = "The sky is the limit! Woohoo!",
		client = {
			image = "sharkfish.png",
		}
	},

	["firstaid"] = {
		label = "İlk Yardım",
		weight = 2500,
		stack = true,
		close = true,
		description = "Ağır yaralar için kullanılan bir paket",
		client = {
			image = "firstaid.png",
		}
	},

	["coffee"] = {
		label = "Kahve",
		weight = 200,
		stack = true,
		close = true,
		description = "Kafein içerir",
		client = {
			image = "coffee.png",
		}
	},

	["corncob"] = {
		label = "Mısır koçanı",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "corncob.png",
		}
	},

	["jerry_can"] = {
		label = "20L Özel Yakıt",
		weight = 20000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "jerry_can.png",
		}
	},

	["redpearl"] = {
		label = "Red Pearl",
		weight = 50,
		stack = true,
		close = true,
		description = "Certificate that proves you own certain stuff",
		client = {
			image = "redpearl.png",
		}
	},

	["id_card"] = {
		label = "Kimlik",
		weight = 0,
		stack = false,
		close = false,
		description = "Kendinizi tanımlamak için tüm bilgilerinizi içeren bir kart",
		client = {
			image = "id_card.png",
		}
	},

	["kelepce"] = {
		label = "Kelepçe",
		weight = 600,
		stack = true,
		close = false,
		description = "Ne yazık ki tüylü modellerinden değil..",
		client = {
			image = "kelepce.png",
		}
	},

	["advancedlockpick"] = {
		label = "Gelişmiş Maymuncuk",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "advancedlockpick.png",
		}
	},

	["raw_bacon"] = {
		label = "Çiğ Pastırma",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_bacon.png",
		}
	},

	["fishingloot"] = {
		label = "Balık Avı",
		weight = 500,
		stack = true,
		close = true,
		description = "Seems to be a corroded from the salt water, Should be easy to open",
		client = {
			image = "fishingloot.png",
		}
	},

	["firstaidforpet"] = {
		label = "First aid for pet",
		weight = 500,
		stack = true,
		close = true,
		description = "Revive your pet!",
		client = {
			image = "firstaidforpet.png",
		}
	},

	["marijuana_lighter"] = {
		label = "Çakmak",
		weight = 0,
		stack = true,
		close = true,
		description = "Cheap tweaker lighter, Still does the job",
		client = {
			image = "marijuana_lighter.png",
		}
	},

	["tree_lumber"] = {
		label = "Lumber",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lumber.png",
		}
	},

	["marijuana_rollingpapers"] = {
		label = "Sarma Kağıtları",
		weight = 0,
		stack = true,
		close = true,
		description = "These aint Raw Rolling Papers!!?",
		client = {
			image = "marijuana_rollingpapers.png",
		}
	},

	["marijuana_1oz_mid"] = {
		label = "1 ons esrar",
		weight = 2800,
		stack = false,
		close = false,
		description = "1oz mid grade marijuana",
		client = {
			image = "marijuana_1oz_mid.png",
		}
	},

	["keepcompanionwesty"] = {
		label = "Westy",
		weight = 500,
		stack = false,
		close = true,
		description = "Westy is your royal companion!",
		client = {
			image = "A_C_Westy.png",
		}
	},

	["plastic"] = {
		label = "Plastik",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "plastic.png",
		}
	},

	["fishtacklebox"] = {
		label = "Olta Kutusu",
		weight = 1000,
		stack = true,
		close = true,
		description = "Seems to be left over tackle box from another fisherman",
		client = {
			image = "fishtacklebox.png",
		}
	},

	["sharktiger"] = {
		label = "Köpek Balığı Kaplanı",
		weight = 5000,
		stack = false,
		close = false,
		description = "Tigershark",
		client = {
			image = "sharktiger.png",
		}
	},

	["shoes"] = {
		label = "Chaussure",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "shoes.png",
		}
	},

	["weed_amnesia"] = {
		label = "Amnesia 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "weed_baggy.png",
		}
	},

	["glasses"] = {
		label = "Lunette",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "glasses.png",
		}
	},

	["crack_baggy"] = {
		label = "Uyuşturucu Torbası",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crack_baggy.png",
		}
	},

	["metalscrap"] = {
		label = "Metal Hurda",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "metalscrap.png",
		}
	},

	["weed_white-widow"] = {
		label = "White Widow 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "weed_baggy.png",
		}
	},

	["chillypepper"] = {
		label = "Acı Biber",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chillypepper.png",
		}
	},

	["meatbird"] = {
		label = "Kuş tüyü",
		weight = 100,
		stack = true,
		close = false,
		description = "Bird Feather",
		client = {
			image = "birdfeather.png",
		}
	},

	["keepcompanionrottweiler"] = {
		label = "Rottweiler",
		weight = 500,
		stack = false,
		close = true,
		description = "Rottweiler is your royal companion!",
		client = {
			image = "A_Rottweiler.png",
		}
	},

	["newspaper"] = {
		label = "Newspaper",
		weight = 6000,
		stack = false,
		close = true,
		description = "Throw this newspaper with important news.!",
		client = {
			image = "newspaper.png",
		}
	},

	["printerdocument"] = {
		label = "Belge",
		weight = 500,
		stack = false,
		close = true,
		description = "Güzel bir döküman",
		client = {
			image = "printerdocument.png",
		}
	},

	["illegalFishBait"] = {
		label = "Illegal Fish Bait",
		weight = 50,
		stack = false,
		close = true,
		description = "A nice document",
		client = {
			image = "illegalFishBait.png",
		}
	},

	["cleaningkit"] = {
		label = "Temizleme Kiti",
		weight = 250,
		stack = true,
		close = true,
		description = "Aracınızı parlatacak olan bez!",
		client = {
			image = "cleaningkit.png",
		}
	},

	["walkstick"] = {
		label = "Baston",
		weight = 1000,
		stack = true,
		close = true,
		description = "Yaşlı dedeler için kullanılan bastonlardan",
		client = {
			image = "walkstick.png",
		}
	},

	["sandwich"] = {
		label = "Sandviç",
		weight = 200,
		stack = true,
		close = true,
		description = "Açlığının çözümü olan sandviç",
		client = {
			image = "sandwich.png",
		}
	},

	["copper"] = {
		label = "Bakır",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "copper.png",
		}
	},

	["fitbit"] = {
		label = "Akıllı Saat",
		weight = 500,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "fitbit.png",
		}
	},

	["oxy"] = {
		label = "Reçeteli Oxy",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "oxy.png",
		}
	},

	["anchor"] = {
		label = "Çapa",
		weight = 2500,
		stack = true,
		close = true,
		description = "Boat Anchor",
		client = {
			image = "anchor.png",
		}
	},

	["marijuana_crop_mid"] = {
		label = "Hasat Edilen Mahsul",
		weight = 5500,
		stack = true,
		close = false,
		description = "mid grade harvested marijuana crop",
		client = {
			image = "marijuana_crop_mid.png",
		}
	},

	["mining_pickaxe"] = {
		label = "Kazma",
		weight = 500,
		stack = false,
		close = true,
		description = "Classic's pickaxe for mining",
		client = {
			image = "mining_pickaxe.png",
		}
	},

	["petfood"] = {
		label = "pet food",
		weight = 500,
		stack = true,
		close = true,
		description = "food for your companion!",
		client = {
			image = "petfood.png",
		}
	},

	["mining_copperbar"] = {
		label = "Bakır çubuk",
		weight = 500,
		stack = true,
		close = true,
		description = "Copper Bar",
		client = {
			image = "mining_copperbar.png",
		}
	},

	["keepcompanionshepherd"] = {
		label = "Shepherd",
		weight = 500,
		stack = false,
		close = true,
		description = "Shepherd is your royal companion!",
		client = {
			image = "A_C_shepherd.png",
		}
	},

	["weed_amnesia_seed"] = {
		label = "Amnesia Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_seed.png",
		}
	},

	["tunerlaptop"] = {
		label = "Çip",
		weight = 2000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "tunerchip.png",
		}
	},

	["codfish"] = {
		label = "Morina",
		weight = 2500,
		stack = false,
		close = false,
		description = "Cod",
		client = {
			image = "codfish.png",
		}
	},

	["watches"] = {
		label = "Montre",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "watch.png",
		}
	},

	["meatrabbit"] = {
		label = "Tavşan Kürkü",
		weight = 100,
		stack = true,
		close = false,
		description = "Rabbit Fur",
		client = {
			image = "rabbitfur.png",
		}
	},

	["marijuana_crop_low"] = {
		label = "Hasat Edilen Mahsul",
		weight = 5500,
		stack = true,
		close = false,
		description = "low grade harvested marijuana crop",
		client = {
			image = "marijuana_crop_low.png",
		}
	},

	["weed_white-widow_seed"] = {
		label = "White Widow Seed",
		weight = 0,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "weed_seed.png",
		}
	},

	["ifaks"] = {
		label = "Yardım Paketi",
		weight = 200,
		stack = true,
		close = true,
		description = "Hafif yaralar ve oluşan stresler için kullanılan eşya.",
		client = {
			image = "ifaks.png",
		}
	},

	["tosti"] = {
		label = "Kızarmış Peynirli Sandviç",
		weight = 200,
		stack = true,
		close = true,
		description = "Yemesi güzel mi güzel",
		client = {
			image = "tosti.png",
		}
	},

	["bodycam"] = {
		label = "Bodycam",
		weight = 200,
		stack = true,
		close = false,
		description = "Bodycam for police officers!",
		client = {
			image = "bodycam.png",
		}
	},

	["mining_goldbar"] = {
		label = "Altın Çubuk",
		weight = 500,
		stack = true,
		close = true,
		description = "Gold Bar",
		client = {
			image = "mining_goldbar.png",
		}
	},

	["cooked_pork"] = {
		label = "Pişmiş Domuz Eti",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cooked_pork.png",
		}
	},

	["10kgoldchain"] = {
		label = "10k Altın Kolye",
		weight = 2000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "10kgoldchain.png",
		}
	},

	["rolling_paper"] = {
		label = "Sarma Kağıdı",
		weight = 0,
		stack = true,
		close = true,
		description = "Bağzı uyuşturucu maddeleri sarabileceğin kağıt.",
		client = {
			image = "rolling_paper.png",
		}
	},

	["hackerphone"] = {
		label = "Hacker Telefonu",
		weight = 700,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "phone.png",
		}
	},

	["raw_sausage"] = {
		label = "Çiğ Sosis",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "raw_sausage.png",
		}
	},

	["harness"] = {
		label = "Yarış Takımı",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "harness.png",
		}
	},

	["steel"] = {
		label = "Çelik",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "steel.png",
		}
	},

	["meth"] = {
		label = "Meth",
		weight = 100,
		stack = true,
		close = true,
		description = "A baggie of Meth",
		client = {
			image = "meth_baggy.png",
		}
	},

	["petnametag"] = {
		label = "Name tag",
		weight = 500,
		stack = true,
		close = true,
		description = "Rename your pet",
		client = {
			image = "petnametag.png",
		}
	},

	["grapejuice"] = {
		label = "Üzüm Suyu",
		weight = 15,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grapejuice.png",
		}
	},

	["bonitosfish"] = {
		label = "Bonitos",
		weight = 50,
		stack = false,
		close = true,
		description = "Key for a lock...?",
		client = {
			image = "bonitosfish.png",
		}
	},

	["huntingbait"] = {
		label = "Av Yemi",
		weight = 150,
		stack = true,
		close = true,
		description = "Hunting Bait",
		client = {
			image = "huntingbait.png",
		}
	},

	["acetone"] = {
		label = "Acetone",
		weight = 5000,
		stack = true,
		close = false,
		description = "It is a colourless, highly volatile and flammable liquid with a characteristic pungent odour.",
		client = {
			image = "acetone.png",
		}
	},

	["screwdriverset"] = {
		label = "Alet Çantası",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "screwdriverset.png",
		}
	},

	["weed_ak47"] = {
		label = "AK47 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "weed_baggy.png",
		}
	},

	["firework4"] = {
		label = "Weeping Willow",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework4.png",
		}
	},

	["whiskey"] = {
		label = "Viski",
		weight = 500,
		stack = true,
		close = true,
		description = "Lüks alkol çeşitlerinden biri",
		client = {
			image = "whiskey.png",
		}
	},

	["wood_plank"] = {
		label = "Wood Plank",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "woodplank.png",
		}
	},

	["bluefish"] = {
		label = "Blue Fish",
		weight = 50,
		stack = false,
		close = true,
		description = "Money?",
		client = {
			image = "bluefish.png",
		}
	},

	["armor"] = {
		label = "Zırh",
		weight = 5000,
		stack = true,
		close = true,
		description = "%75 Zırh sağlar.",
		client = {
			image = "armor.png",
		}
	},

	["xtcbaggy"] = {
		label = "XTC Torbası",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "xtc_baggy.png",
		}
	},

	["eye_color"] = {
		label = "Lentille",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "eye_color.png",
		}
	},

	["mask"] = {
		label = "Masque",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "mask.png",
		}
	},

	["cow_leather"] = {
		label = "İnek Derisi",
		weight = 50,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cow_leather.png",
		}
	},

	["fishingkey"] = {
		label = "Balık Tutma Anahtarı",
		weight = 100,
		stack = true,
		close = true,
		description = "A weathered key that looks usefull",
		client = {
			image = "fishingkey.png",
		}
	},

	["marijuana_scale"] = {
		label = "Ölçek",
		weight = 0,
		stack = true,
		close = false,
		description = "This is not what it looks like",
		client = {
			image = "marijuana_scale.png",
		}
	},

	["bracelets"] = {
		label = "Bracelet",
		weight = 100,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "bracelet.png",
		}
	},

	["lighter"] = {
		label = "Çakmak",
		weight = 0,
		stack = true,
		close = true,
		description = "Yeni yıl arifesinde yanında durmak için güzel bir ateş",
		client = {
			image = "lighter.png",
		}
	},

	["camera"] = {
		label = "CC TV",
		weight = 150,
		stack = true,
		close = true,
		description = "Hunting Bait",
		client = {
			image = "huntingbait.png",
		}
	},

	["marijuana_crop_high"] = {
		label = "Hasat Edilen Mahsul",
		weight = 5500,
		stack = true,
		close = false,
		description = "high grade harvested marijuana crop",
		client = {
			image = "marijuana_crop_high.png",
		}
	},

	["pumpkinpiebox"] = {
		label = "Pasta Kutusu",
		weight = 25,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pumpkinpiebox.png",
		}
	},
}