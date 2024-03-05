-- STORAGES
RegisterNetEvent('qb-cayoperico:client:LiquorStash', function()
    if PlayerJob.name == "cayoperico" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Storage["Liquor"].name, {
            maxweight = Config.Storage["Liquor"].maxweight,
            slots = Config.Storage["Liquor"].slots
        })
        TriggerEvent("inventory:client:SetCurrentStash", Config.Storage["Liquor"].name)
    end
end)

RegisterNetEvent('qb-cayoperico:client:DrugsStash', function()
    if PlayerJob.name == "cayoperico" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Storage["Drugs"].name, {
            maxweight = Config.Storage["Drugs"].maxweight,
            slots = Config.Storage["Drugs"].slots
        })
        TriggerEvent("inventory:client:SetCurrentStash", Config.Storage["Drugs"].name)
    end
end)

RegisterNetEvent('qb-cayoperico:client:ArmoryStash', function()
    if PlayerJob.name == "cayoperico" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Storage["Armory"].name, {
            maxweight = Config.Storage["Armory"].maxweight,
            slots = Config.Storage["Armory"].slots
        })
        TriggerEvent("inventory:client:SetCurrentStash", Config.Storage["Armory"].name)
    end
end)

RegisterNetEvent('qb-cayoperico:client:JewelleryStash', function()
    if PlayerJob.name == "cayoperico" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Storage["Jewellery"].name, {
            maxweight = Config.Storage["Jewellery"].maxweight,
            slots = Config.Storage["Jewellery"].slots
        })
        TriggerEvent("inventory:client:SetCurrentStash", Config.Storage["Jewellery"].name)
    end
end)

RegisterNetEvent('qb-cayoperico:client:OpenPersonalStash', function()
    if PlayerJob.name == "cayoperico" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "cayostash_"..QBCore.Functions.GetPlayerData().citizenid, {
            maxweight = Config.Locations["personalstash"].maxweight,
            slots = Config.Locations["personalstash"].slots
        })
        TriggerEvent("inventory:client:SetCurrentStash", "cayostash_"..QBCore.Functions.GetPlayerData().citizenid)
    end
end)

-- GARAGE MENUS
RegisterNetEvent('qb-cayoperico:client:menu:OpenGarageMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "< Garage Menu",
            txt = "ESC or click to close",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Squaddie",
            txt = "",
            params = {
                event = "qb-cayoperico:client:menu:GarageSpawn",
                args = {
                    model = "squaddie",
                }
            }
        },
        {
            header = "Manchez",
            txt = "",
            params = {
                event = "qb-cayoperico:client:menu:GarageSpawn",
                args = {
                    model = "manchez2",
                }
            }
        },
        {
            header = "Brioso",
            txt = "",
            params = {
                event = "qb-cayoperico:client:menu:GarageSpawn",
                args = {
                    model = "brioso2",
                }
            }
        },
        {
            header = "Winky",
            txt = "",
            params = {
                event = "qb-cayoperico:client:menu:GarageSpawn",
                args = {
                    model = "winky",
                }
            }
        }
    })
end)

RegisterNetEvent('qb-cayoperico:client:menu:DeleteVehicleMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "< Garage Menu",
            txt = "ESC or click to close",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Confirm",
            txt = "This deletes the vehicle",
            params = {
                event = "qb-cayoperico:client:menu:DeleteVehicle",
            }
        }
    })
end)

RegisterNetEvent('qb-cayoperico:client:menu:OpenBoatMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "< Boat Menu",
            txt = "ESC or click to close",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Longfin",
            txt = "Costs 5,000$ Cash",
            params = {
                event = "qb-cayoperico:client:menu:BoatSpawn",
                args = {
                    model = "longfin"
                }
            }
        }
    })
end)

RegisterNetEvent('qb-cayoperico:client:menu:OpenPlaneMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "< Plane Menu",
            txt = "ESC or click to close",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Dodo",
            txt = "Costs 12,000$ Cash",
            params = {
                event = "qb-cayoperico:client:menu:PlaneSpawn",
                args = {
                    model = "dodo"
                }
            }
        }
    })
end)

RegisterNetEvent('qb-cayoperico:client:menu:DeleteBoatMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "< Store Boat",
            txt = "ESC or click to close",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Confirm",
            txt = "This deletes the vehicle",
            params = {
                event = "qb-cayoperico:client:menu:DeleteBoat",
            }
        }
    })
end)

RegisterNetEvent('qb-cayoperico:client:menu:BoatSpawn', function(data)
    local model = data.model
    QBCore.Functions.TriggerCallback('qb-cayoperico:server:PayFuel', function(HasMoney)
        if HasMoney then
            QBCore.Functions.SpawnVehicle(model, function(veh)
                exports['LegacyFuel']:SetFuel(veh, 100.0)
                SetEntityHeading(veh, Config.Locations["boats"].spawnHeading)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                SetVehicleNumberPlateText(veh, "CAYOBOAT")
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                SetVehicleEngineOn(veh, true, true)
            end, Config.Locations["boats"].spawnPoint, true)
        end
    end, 5000)
end)

RegisterNetEvent('qb-cayoperico:client:menu:PlaneSpawn', function(data)
    local model = data.model
    QBCore.Functions.TriggerCallback('qb-cayoperico:server:PayFuel', function(HasMoney)
        if HasMoney then
            QBCore.Functions.SpawnVehicle(model, function(veh)
                exports['LegacyFuel']:SetFuel(veh, 100.0)
                SetEntityHeading(veh, Config.Locations["plane"].spawnHeading)
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                SetVehicleNumberPlateText(veh, "CAYODODO")
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                SetVehicleEngineOn(veh, true, true)
            end, Config.Locations["plane"].spawnPoint, true)
        end
    end, 12000)
end)

RegisterNetEvent('qb-cayoperico:client:menu:DeleteBoat', function()
    local ped = PlayerPedId()
    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
    SetEntityCoords(ped, Config.Locations["boats"].returnPoint.x, Config.Locations["boats"].returnPoint.y, Config.Locations["boats"].returnPoint.z - 1)
    SetEntityHeading(ped, Config.Locations["boats"].returnPoint.w)
end)

RegisterNetEvent('qb-cayoperico:client:menu:DeleteVehicle', function()
    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
end)

RegisterNetEvent('qb-cayoperico:client:menu:GarageSpawn', function(data)
    local model = data.model
    -- SPAWN VEHICLE
    QBCore.Functions.SpawnVehicle(model, function(veh)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end)
end)

-- CRAFTING BENCH
RegisterNetEvent('qb-cayoperico:client:menu:OpenCraftingMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "< Cayoperico Crafting Menu",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Ammo",
            txt = "",
            icon = 'fas fa-hammer',
            params = {
                event = "qb-cayoperico:client:menu:OpenAmmo",
            }
        },
        {
            header = "Weapons",
            txt = "",
            icon = 'fas fa-hammer',
            params = {
                event = "qb-cayoperico:client:menu:OpenWeapons",
            }
        }
    })
end)

RegisterNetEvent('qb-cayoperico:client:menu:OpenAmmo', function()
    local menu = {
        {
            header = "< Go Back",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-cayoperico:client:menu:OpenCraftingMenu",
            }
        }
    }

    for k, v in ipairs(Config.CraftingCost['ammo']) do
        local text = ''
        for i=1, #v.items do
            text = text.. QBCore.Shared.Items[v.items[i].item]['label']..": "..v.items[i].amount.." <br>"
        end

        menu[#menu+1] = {
            header = v.label,
            txt = text,
            icon = 'fas fa-screwdriver-wrench',
            params = {
                event = "qb-cayoperico:client:CraftItem",
                args = {
                    craft = 'ammo',
                    index = k
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-cayoperico:client:menu:OpenWeapons', function()
    local menu = {
        {
            header = "< Go Back",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-cayoperico:client:menu:OpenCraftingMenu",
            }
        }
    }

    for k, v in ipairs(Config.CraftingCost['weapons']) do
        local text = ''
        for i=1, #v.items do
            text = text.. QBCore.Shared.Items[v.items[i].item]['label']..": "..v.items[i].amount.." <br>"
        end

        menu[#menu+1] = {
            header = v.label,
            txt = text,
            icon = 'fas fa-screwdriver-wrench',
            params = {
                event = "qb-cayoperico:client:CraftItem",
                args = {
                    craft = 'weapons',
                    index = k
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-cayoperico:client:CraftItem', function(data)
    QBCore.Functions.Progressbar("CraftWeapon", "Crafting...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-cayoperico:server:CraftItem', data.craft, data.index)
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end)

-- BOSS MENU FUNCTIONS
RegisterNetEvent('qb-cayoperico:client:BossMenu', function()
    if PlayerJob.name == "cayoperico" and PlayerJob.grade.level == 2 then
        QBCore.Functions.Progressbar("Opening laptop", "Booting systems...", 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            QBCore.Functions.TriggerCallback('qb-cayoperico:server:getSocietyData', function(data)
                bank = data.bank
                employees = data.employees
                unemployed = data.unemployed
                TriggerEvent('qb-cayoperico:client:menu:OpenBossMenu')
            end)
        end, function() -- Cancel
            QBCore.Functions.Notify("Canceled..", "error")
        end)
    end
end)

RegisterNetEvent('qb-cayoperico:client:menu:OpenBossMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Cayoperico Boss Menu",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Manage Employees",
            txt = "",
            icon = "fas fa-address-book",
            params = {
                event = "qb-cayoperico:client:menu:OpenEmployees",
            }
        },
        {
            header = "Hire Employee",
            txt = "(Must be unemployed)",
            icon = "fas fa-universal-access",
            params = {
                event = "qb-cayoperico:client:menu:OpenHire",
            }
        },
        {
            header = "Treasury",
            txt = "($ "..bank..")",
            icon = "fas fa-dollar-sign",
            params = {
                event = "qb-cayoperico:client:menu:OpenBank",
            }
        },
    })
end)

RegisterNetEvent('qb-cayoperico:client:menu:OpenEmployees', function()
    local menu = {
        {
            header = "Go Back",
            txt = "",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-cayoperico:client:menu:OpenBossMenu"
            }
        }
    }
    for k, v in pairs(employees) do
        menu[#menu+1] = {
            header = v.name,
            txt = v.citizenid.." - "..v.grade.name,
            icon = 'fas fa-address-card',
            params = {
                event = "qb-cayoperico:client:menu:FirePromote",
                args = {
                    employee = v
                }
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-cayoperico:client:menu:OpenHire', function()
    local menu = {
        {
            header = "Go Back",
            icon = 'fas fa-angle-left',
            txt = "",
            params = {
                event = "qb-cayoperico:client:menu:OpenBossMenu"
            }
        }
    }
    for k, v in pairs(unemployed) do
        menu[#menu+1] = {
            header = v.name,
            txt = v.citizenid,
            icon = 'fas fa-address-card',
            params = {
                event = "qb-cayoperico:client:menu:Hire",
                args = {
                    player = v
                }
            } 
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-cayoperico:client:menu:OpenBank', function()
    exports['qb-menu']:openMenu({
        {
            header = "Go Back",
            txt = "",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-cayoperico:client:menu:OpenBossMenu"
            }
        },
        {
            header = "Deposit",
            txt = "",
            icon = 'fas fa-plus',
            params = {
                event = "qb-cayoperico:client:menu:Deposit",
            }
        },
        {
            header = "Withdraw",
            txt = "",
            icon = 'fas fa-minus',
            params = {
                event = "qb-cayoperico:client:menu:Withdraw",
            }
        },
    })
end)

RegisterNetEvent('qb-cayoperico:client:menu:Deposit', function()
    local input = exports['qb-input']:ShowInput({
        header = "Deposit Money",
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if input then
        if not input.amount then return end
        local amount = tonumber(input.amount)
        if amount > 0 then
            bank = bank + amount
            TriggerServerEvent('qb-cayoperico:server:depositBank', amount, PlayerJob.name)
            TriggerEvent('qb-cayoperico:client:menu:OpenBank')
        else
            QBCore.Functions.Notify('Invalid amount..', 'error', 2500)
        end
    end
end)

RegisterNetEvent('qb-cayoperico:client:menu:Withdraw', function(data)
    local input = exports['qb-input']:ShowInput({
        header = "Withdraw Money",
        submitText = "Submit",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if input then
        if not input.amount then return end
        local amount = tonumber(input.amount)
        if amount > 0 then
            if bank >= amount then
                bank = bank - amount
                TriggerServerEvent('qb-cayoperico:server:withdrawBank', amount, PlayerJob.name)
            else
                QBCore.Functions.Notify("There is not enough money on the bank account.", "error", 2500)
            end
            TriggerEvent('qb-cayoperico:client:menu:OpenBank')
        else
            QBCore.Functions.Notify('Invalid amount..', 'error', 2500)
        end
    end
end)

RegisterNetEvent('qb-cayoperico:client:menu:FirePromote', function(data)
    local citizenid = data.employee.citizenid
    local sourceGrade = PlayerJob.grade.level
    local targetGrade = data.employee.grade.level
    local input = exports['qb-input']:ShowInput({
        header = "Employee Management",
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'action',
                text = "Fire/Demote/Promote"
            }
        }
    })
    if input then
        if not input.action then return end
        local answer = string.lower(input.action)
        if answer == "fire" then
            if sourceGrade > targetGrade then
                TriggerServerEvent('qb-cayoperico:server:SetJob', data.employee, "fire", 0)
            else
                QBCore.Functions.Notify("You cannot fire employees with the same or higher rank", "error", 2500)
            end
        elseif answer == "promote" then
            -- CAN ONLY PROMOTE UNDER YOU
            if sourceGrade > targetGrade then
                TriggerServerEvent('qb-cayoperico:server:SetJob', data.employee, "promote", targetGrade+1)
            else
                QBCore.Functions.Notify("You cannot promote employees with the same or higher rank", "error", 2500)
            end
        elseif answer == "demote" then
            -- CAN ONLY DEMOTE UNDER YOU
            if sourceGrade > targetGrade then
                TriggerServerEvent('qb-cayoperico:server:SetJob', data.employee, "demote", targetGrade-1)
            else
                QBCore.Functions.Notify("You cannot demote employees with the same or higher rank", "error", 2500)
            end
        else
            QBCore.Functions.Notify("Invalid argument", "error", 2500)
        end
    end
end)

RegisterNetEvent('qb-cayoperico:client:menu:Hire', function(data)
    local citizenid = data.employee.citizenid
    local input = exports['qb-input']:ShowInput({
        header = "Hire "..data.employee.charinfo.firstname.." "..data.employee.charinfo.lastname,
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'action',
                text = "Type 'Confirm'"
            }
        }
    })
    if input then
        if not input.action then return end
        local answer = string.lower(input.action)
        if answer == "confirm" then
            TriggerServerEvent('qb-cayoperico:server:SetJob', citizenid, PlayerJob.name, "hire")
        else
            QBCore.Functions.Notify("Invalid argument", "error")
        end
    end
end)

-- Garages
CreateThread(function()
    while true do
        Wait(3)
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inRange = false
            if PlayerJob.name == "cayoperico" then
                -- VEHICLES
                for k, v in pairs(Config.Vehicles) do
                    if #(pos - v.coords) < 9 then
                        inRange = true
                        DrawMarker(39, v.coords.x, v.coords.y, v.coords.z , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 242, 148, 41, 255, false, false, false, 1, false, false, false)
                        if #(pos - v.coords) < 1 then
                            if IsPedOnFoot(ped) then
                                DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "~g~[E]~w~ - Open Garage")
                                if IsControlJustPressed(0, 38) then
                                    TriggerEvent('qb-cayoperico:client:menu:OpenGarageMenu')
                                end
                            else
                                DrawText3Ds(v.coords.x, v.coords.y, v.coords.z, "~g~[E]~w~ - Store Vehicle")
                                if IsControlJustPressed(0, 38) then
                                    TriggerEvent('qb-cayoperico:client:menu:DeleteVehicleMenu')
                                end
                            end
                        end
                    end
                end

                -- CAPO RANK
                if PlayerJob.grade.level >= 1 then
                    if #(pos - Config.Locations["boats"].coords) < 7 then
                        inRange = true
                        if not IsPedOnFoot(ped) then
                            DrawMarker(35, Config.Locations["boats"].spawnPoint.x, Config.Locations["boats"].spawnPoint.y, Config.Locations["boats"].spawnPoint.z , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 242, 148, 41, 255, false, false, false, 1, false, false, false)
                            DrawText3Ds(Config.Locations["boats"].spawnPoint.x, Config.Locations["boats"].spawnPoint.y, Config.Locations["boats"].spawnPoint.z, "~g~[E]~w~ - Store Boat")
                            if IsControlJustPressed(0, 38) then
                                TriggerEvent('qb-cayoperico:client:menu:DeleteBoatMenu')
                            end
                        end
                    end
                end

                -- BOSS RANK
                if PlayerJob.grade.level == 2 then
                    if #(pos - Config.Locations["plane"].spawnPoint) < 5 then
                        inRange = true
                        if not IsPedOnFoot(ped) then
                            DrawMarker(33, Config.Locations["plane"].spawnPoint.x, Config.Locations["plane"].spawnPoint.y, Config.Locations["plane"].spawnPoint.z , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 242, 148, 41, 255, false, false, false, 1, false, false, false)
                            DrawText3Ds(Config.Locations["plane"].spawnPoint.x, Config.Locations["plane"].spawnPoint.y, Config.Locations["plane"].spawnPoint.z, "~g~[E]~w~ - Store Plane")
                            if IsControlJustPressed(0, 38) then
                                TriggerEvent('qb-cayoperico:client:menu:DeleteVehicleMenu')
                            end
                        end
                    end
                end

                if not inRange then Wait(2000) end
            else
                Wait(10000)
            end
        else
            Wait(5000)
        end
    end
end)

-- Blips
CreateThread(function()
    while PlayerJob == nil do Wait(10) end
    if PlayerJob.name == "cayoperico" and PlayerJob.grade.level == 2 then
        local blip = AddBlipForCoord(4962.49, -5107.39, 2.98)
        SetBlipSprite(blip, 567)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Cayo Crafting")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while PlayerJob == nil do Wait(10) end
    if PlayerJob.name == "cayoperico" then
        local blip = AddBlipForCoord(5011.1191, -5752.252, 28.845258)
        SetBlipSprite(blip, 568)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Cayo Boss")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while PlayerJob == nil do Wait(10) end
    if PlayerJob.name == "cayoperico" then
        local blip = AddBlipForCoord(5200.9516, -5141.781, 5.3366193)
        SetBlipSprite(blip, 496)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Cayo Processing")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while PlayerJob == nil do Wait(10) end
    if PlayerJob.name == "cayoperico" and PlayerJob.grade.level >= 1 then
        local blip = AddBlipForCoord(5065.2817, -4596.291, 2.8537364)
        SetBlipSprite(blip, 501)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Cayo Packaging")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while PlayerJob == nil do Wait(10) end
    if PlayerJob.name == "cayoperico" and PlayerJob.grade.level >= 1 then
        local blip = AddBlipForCoord(Config.Locations['boats'].coords.x, Config.Locations['boats'].coords.y, Config.Locations['boats'].coords.z)
        SetBlipSprite(blip, 404)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Cayo Boats")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while PlayerJob == nil do Wait(10) end
    if PlayerJob.name == "cayoperico" then
        local blip = AddBlipForCoord(5332.2885, -5262.341, 32.554645)
        SetBlipSprite(blip, 469)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Cayo Fields")
        EndTextCommandSetBlipName(blip)
    end
end)
