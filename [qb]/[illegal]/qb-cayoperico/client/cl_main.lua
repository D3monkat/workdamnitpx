QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}
employees = {}
bank = 0
unemployed = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerJob = {}
    bank = 0
    employees = {}
    unemployed = {}
end)

AddEventHandler('onClientResourceStart',function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    -- PERSONAL STASH
    exports['qb-target']:AddBoxZone("CayoPersonalStash", vector3(5010.0, -5759.55, 28.85), 1.0, 1.3, {
        name = "CayoPersonalStash",
        heading = 149.57,
        debugPoly = false,
        minZ = 27.42,
        maxZ = 29.72
        }, {
        options = {
            {
                type = "client",
                event = "qb-cayoperico:client:OpenPersonalStash",
                icon = "fas fa-hand-holding",
                label = "Personal Stash",
                job = "cayoperico"
            }
        },
        distance = 2.0
    })

    -- BOSS MENU
    exports['qb-target']:AddBoxZone("CayoBossMenu", vector3(5012.52, -5754.96, 28.42), 1.2, 3.0, {
        name = "CayoBossMenu",
        heading = 58.93,
        debugPoly = false,
        minZ = 27.18,
        maxZ = 29.32
        }, {
        options = {
            {
                type = "client",
                event = "qb-cayoperico:client:BossMenu",
                icon = "fas fa-suitcase",
                label = "Boss Menu",
                job = {["cayoperico"] = 2}
            }
        },
        distance = 3.5
    })

    -- liquor stash
    exports['qb-target']:AddBoxZone("CayoLiquor", vector3(4999.2, -5745.3, 14.03), 0.5, 1.6, {
        name = "CayoLiquor",
        heading = 324.98,
        debugPoly = false,
        minZ = 13.7,
        maxZ = 15.9
        }, {
        options = {
            {
                type = "client",
                event = "qb-cayoperico:client:LiquorStash",
                icon = "fas fa-wine-bottle",
                label = "Liquor Cabinet",
                job = "cayoperico" 
            }
        },
        distance = 2.0
    })

    -- armory
    exports['qb-target']:AddBoxZone("CayoArmory", vector3(5017.11, -5745.04, 15.73), 0.9, 1.8, {
        name = "CayoArmory",
        heading = 330.32,
        debugPoly = false,
        minZ = 14.7,
        maxZ = 15.9
        }, {
        options = {
            {
                type = "client",
                event = "qb-cayoperico:client:ArmoryStash",
                icon = "fas fa-hand-holding",
                label = "Armory",
                job = "cayoperico"
            }
        },
        distance = 2.0
    })

    -- armory
    exports['qb-target']:AddBoxZone("CayoJewellery", vector3(5014.47, -5752.64, 16.73), 0.8, 1.8, {
        name = "CayoJewellery",
        heading = 237.89,
        debugPoly = false,
        minZ = 14.7,
        maxZ = 16.2
        }, {
        options = {
            {
                type = "client",
                event = "qb-cayoperico:client:JewelleryStash",
                icon = "far fa-gem",
                label = "Jewellery",
                job = "cayoperico"
            }
        },
        distance = 2.0
    })

    -- drugsstash1
    exports['qb-target']:AddBoxZone("CayoDrugs1", vector3(5011.23, -5757.66, 15.24), 1.0, 1.0, {
        name = "CayoDrugs1",
        heading = 238.11,
        debugPoly = false,
        minZ = 14.7,
        maxZ = 16.2
        }, {
        options = {
            {
                type = "client",
                event = "qb-cayoperico:client:DrugsStash",
                icon = "fas fa-hand-holding",
                label = "Drugs Stash",
                job = {["cayoperico"] = 1}
            }
        },
        distance = 2.5
    })

    -- drugsstash2
    exports['qb-target']:AddBoxZone("CayoDrugs2", vector3(5074.71, -4595.22, 3.04), 3.6, 2.4, {
        name = "CayoDrugs2",
        heading = 343.11,
        debugPoly = false,
        minZ = 1.7,
        maxZ = 4.2
        }, {
        options = {
            {
                type = "client",
                event = "qb-cayoperico:client:DrugsStash",
                icon = "fas fa-hand-holding",
                label = "Drugs Stash",
                job = {["cayoperico"] = 1}
            }
        },
        distance = 4.0
    })

    -- Crafting
    exports['qb-target']:AddBoxZone("CayoCrafting", vector3(4962.64, -5106.62, 4.03), 0.9, 2.3, {
        name = "CayoCrafting",
        heading = 336.66,
        debugPoly = false,
        minZ = 2.62,
        maxZ = 3.0
        }, {
        options = {
            {
                type = "client",
                event = "qb-cayoperico:client:menu:OpenCraftingMenu",
                icon = "fas fa-drafting-compass",
                label = "Crafting Bench",
                job = {["cayoperico"] = 2}
            }
        },
        distance = 2.0
    })

    -- Clothing
    exports['qb-target']:AddBoxZone("CayoClothing", vector3(5003.94, -5748.73, 14.94), 0.9, 1.6, {
        name = "CayoClothing",
        heading = 329.85,
        debugPoly = false,
        minZ = 14.7,
        maxZ = 14.9
        }, {
        options = {
            {
                type = "client",
                event = "qb-clothing:client:openMenu",
                icon = "fas fa-tshirt",
                label = "Clothing",
                job = "cayoperico"
            },
            {
                type = "client",
                event = "qb-clothing:client:openOutfitMenu",
                icon = "fas fa-tshirt",
                label = "Outfits",
                job = "cayoperico"
            }
        },
        distance = 2.0
    })

    -- Boat
    exports['qb-target']:SpawnPed({
        model = 'ig_gustavo',
        coords = vector4(Config.Locations['boats'].coords.x, Config.Locations['boats'].coords.y, Config.Locations['boats'].coords.z, Config.Locations['boats'].coordsHeading),
        minusOne = true,
        freeze = true,
        invincible = true,
        blockevents = true,
        target = {
            options = {
                {
                    type = "client",
                    event = "qb-cayoperico:client:menu:OpenBoatMenu",
                    icon = "fas fa-anchor",
                    label = "Grab Boat (Fuel: 5,000$)",
                    job = {["cayoperico"] = 1}
                }
            },
            distance = 1.5
        },
    })

    -- Plane
    exports['qb-target']:SpawnPed({
        model = 'ig_gustavo',
        coords = vector4(Config.Locations['plane'].coords.x, Config.Locations['plane'].coords.y, Config.Locations['plane'].coords.z, Config.Locations['plane'].coordsHeading),
        minusOne = true,
        freeze = true,
        invincible = true,
        blockevents = true,
        target = {
            options = {
                {
                    type = "client",
                    event = "qb-cayoperico:client:menu:OpenPlaneMenu",
                    icon = "fas fa-plane",
                    label = "Grab Plane (Fuel: 12,000$)",
                    job = {["cayoperico"] = 2}
                }
            },
            distance = 1.5
        },
    })

    -- CROP DISPENSER
    exports['qb-target']:SpawnPed({
        model = 's_m_m_fieldworker_01',
        coords = vector4(Config.Locations['deposit'].coords.x, Config.Locations['deposit'].coords.y, Config.Locations['deposit'].coords.z, Config.Locations['deposit'].coordsHeading),
        minusOne = true,
        freeze = true,
        invincible = true,
        blockevents = true,
        target = {
            options = {
                {
                    type = "client",
                    event = "qb-cayoperico:client:ExchangeCrop",
                    icon = "fas fa-cannabis",
                    label = "Exchange Notes",
                    job = "cayoperico"
                },
                {
                    type = "client",
                    event = "qb-cayoperico:client:DepositCrop",
                    icon = "fas fa-cannabis",
                    label = "Deliver Crop"
                }
            },
            distance = 1.5
        },
    })
end)
