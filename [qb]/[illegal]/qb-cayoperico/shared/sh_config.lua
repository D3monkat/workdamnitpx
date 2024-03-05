Config = Config or {}

Config.Debug = true

Config.LockPick = 'ps-ui' -- 'ps-ui' for ps-ui or 'qb-lock' for qb-lock circle minigame, other values will give no minigame

Config.Locations = {
    ["personalstash"] = {
        coords = vector3(5010.3325, -5758.835, 28.852993),
        maxweight = 1500000,
        slots = 40
    },
    ["bossmenu"] = {
        coords = vector3(5013.6176, -5754.855, 28.900136)
    },
    ["weaponbench"] = {
        coords = vector3(4962.49, -5107.39, 2.98)
    },
    ["boats"] = {
        coords = vector3(4898.41, -5168.72, 2.47),
        coordsHeading = 159.83,
        spawnPoint = vector3(4892.79, -5166.78, 0.75),
        spawnHeading = 339.68,
        returnPoint = vector4(4897.62, -5170.42, 2.48, 340.38)
    },
    ["plane"] = {
        coords = vector3(4428.83, -4450.77, 7.24),
        coordsHeading = 201.7,
        spawnPoint = vector3(4504.61, -4487.15, 5.0),
        spawnHeading = 110.2
    },
    ["deposit"] = {
        coords = vector3(5326.74, -5266.49, 33.1),
        coordsHeading = 321.72,
    }
}

Config.Storage = {
    ["Drugs"] = {
        name = "cayo_cokestash",
        maxweight = 4000000,
        slots = 40,
    },
    ["Jewellery"] = {
        name = "cayo_jewellery",
        maxweight = 1000000,
        slots = 40,
    },
    ["Armory"] = {
        name = "cayo_armory",
        maxweight = 4000000,
        slots = 40,
    },
    ["Liquor"] = {
        name = "cayo_liquor",
        maxweight = 1000000,
        slots = 40,
    }
}

Config.Vehicles = {
    [1] = {coords = vector3(4972.96, -5739.2, 19.88)},
    [2] = {coords = vector3(4918.53, -5235.88, 2.52)},
    [3] = {coords = vector3(5072.5, -4599.49, 2.85)},
    [4] = {coords = vector3(4431.54, -4463.53, 4.33)},
    [5] = {coords = vector3(5185.1, -5133.03, 3.34)}
}

Config.CraftingCost = {
    ['weapons'] = {
        [1] = {
            label = 'Assault Rifle',
            item = 'weapon_assaultrifle',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 280
                },
                [2] = {
                    item = 'steel',
                    amount = 200
                },
                [3] = {
                    item = 'rubber',
                    amount = 200
                }
            }
        },
        [2] = {
            label = 'Compact Rifle',
            item = 'weapon_compactrifle',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 295
                },
                [2] = {
                    item = 'steel',
                    amount = 220
                },
                [3] = {
                    item = 'rubber',
                    amount = 295
                }
            }
        },
        [3] = {
            label = 'Mini SMG',
            item = 'weapon_minismg',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 195
                },
                [2] = {
                    item = 'steel',
                    amount = 220
                },
                [3] = {
                    item = 'rubber',
                    amount = 295
                }
            }
        },
    },
    ['ammo'] = {
        [1] = {
            label = 'Pistol Ammo',
            item = 'pistol_ammo',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 25
                },
                [2] = {
                    item = 'aluminum',
                    amount = 18
                },
                [3] = {
                    item = 'copper',
                    amount = 30
                }
            }
        },
        [2] = {
            label = 'SMG Ammo',
            item = 'smg_ammo',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 28
                },
                [2] = {
                    item = 'aluminum',
                    amount = 25
                },
                [3] = {
                    item = 'copper',
                    amount = 35
                }
            }
        },
        [3] = {
            label = 'Rifle Ammo',
            item = 'rifle_ammo',
            items = {
                [1] = {
                    item = 'metalscrap',
                    amount = 295
                },
                [2] = {
                    item = 'aluminum',
                    amount = 240
                },
                [3] = {
                    item = 'copper',
                    amount = 340
                }
            }
        },
    }
}
