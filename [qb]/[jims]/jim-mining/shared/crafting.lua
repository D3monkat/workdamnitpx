Crafting = {
	SmeltMenu = {
		Recipes = {
			{ ["copper"] = { ["copperore"] = 1 }, ['amount'] = 4 },
			{ ["goldingot"] = { ["goldore"] = 1 } },
			{ ["goldingot"] = { ["goldchain"] = 3 } },
			{ ["goldingot"] = { ["gold_ring"] = 4 } },
			{ ["silveringot"] = { ["silverore"] = 1 } },
			{ ["silveringot"] = { ["silverchain"] = 3 } },
			{ ["silveringot"] = { ["silver_ring"] = 4 } },
			{ ["iron"] = { ["ironore"] = 1 } },
			{ ["steel"] = { ["ironore"] = 1, ["carbon"] = 1 } },
			{ ["aluminum"] = { ["can"] = 2, }, ['amount'] = 3 },
			{ ["glass"] = { ["bottle"] = 2, }, ['amount'] = 2 },
		},
	},
	GemCut = {
		Recipes = {
			{
				["emerald"] = {
					["uncut_emerald"] = 1,
				}
			},
			{
				["diamond"] = {
					["uncut_diamond"] = 1
				},
			},
			{
				["ruby"] = {
					["uncut_ruby"] = 1
				},
			},
			{
				["sapphire"] = {
					["uncut_sapphire"] = 1
				},
			},
		},
	},
	RingCut = {
		Recipes = {
			{ ["gold_ring"] = { ["goldingot"] = 1 }, ['amount'] = 3 },
			{ ["silver_ring"] = { ["silveringot"] = 1 }, ['amount'] = 3 },
			{ ["diamond_ring"] = { ["gold_ring"] = 1, ["diamond"] = 1 }, },
			{ ["emerald_ring"] = { ["gold_ring"] = 1, ["emerald"] = 1 }, },
			{ ["ruby_ring"] = { ["gold_ring"] = 1, ["ruby"] = 1 }, },
			{ ["sapphire_ring"] = { ["gold_ring"] = 1, ["sapphire"] = 1 }, },

			{ ["diamond_ring_silver"] = { ["silver_ring"] = 1, ["diamond"] = 1 }, },
			{ ["emerald_ring_silver"] = { ["silver_ring"] = 1, ["emerald"] = 1 }, },
			{ ["ruby_ring_silver"] = { ["silver_ring"] = 1, ["ruby"] = 1 }, },
			{ ["sapphire_ring_silver"] = { ["silver_ring"] = 1, ["sapphire"] = 1 }, },
		},
	},
	NeckCut = {
		Recipes = {
			{ ["goldchain"] = { ["goldingot"] = 1 }, ['amount'] = 3  },
			{ ["silverchain"] = { ["silveringot"] = 1 }, ['amount'] = 3  },
			{ ["diamond_necklace"] = { ["goldchain"] = 1, ["diamond"] = 1 }, },
			{ ["ruby_necklace"] = { ["goldchain"] = 1, ["ruby"] = 1 }, },
			{ ["sapphire_necklace"] = { ["goldchain"] = 1, ["sapphire"] = 1 }, },
			{ ["emerald_necklace"] = { ["goldchain"] = 1, ["emerald"] = 1 }, },

			{ ["diamond_necklace_silver"] = { ["silverchain"] = 1, ["diamond"] = 1 }, },
			{ ["ruby_necklace_silver"] = { ["silverchain"] = 1, ["ruby"] = 1 }, },
			{ ["sapphire_necklace_silver"] = { ["silverchain"] = 1, ["sapphire"] = 1 }, },
			{ ["emerald_necklace_silver"] = { ["silverchain"] = 1, ["emerald"] = 1 }, },
		},
	},
	EarCut = {
		Recipes = {
			{ ["goldearring"] = { ["goldingot"] = 1 }, ['amount'] = 3  },
			{ ["silverearring"] = { ["silveringot"] = 1 }, ['amount'] = 3  },
			{ ["diamond_earring"] = { ["goldearring"] = 1, ["diamond"] = 1 }, },
			{ ["ruby_earring"] = { ["goldearring"] = 1, ["ruby"] = 1 }, },
			{ ["sapphire_earring"] = { ["goldearring"] = 1, ["sapphire"] = 1 }, },
			{ ["emerald_earring"] = { ["goldearring"] = 1, ["emerald"] = 1 }, },

			{ ["diamond_earring_silver"] = { ["silverearring"] = 1, ["diamond"] = 1 }, },
			{ ["ruby_earring_silver"] = { ["silverearring"] = 1, ["ruby"] = 1 }, },
			{ ["sapphire_earring_silver"] = { ["silverearring"] = 1, ["sapphire"] = 1 }, },
			{ ["emerald_earring_silver"] = { ["silverearring"] = 1, ["emerald"] = 1 }, },
		},
	},
}

