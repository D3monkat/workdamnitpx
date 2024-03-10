function GaragePrompt(data, identifier)
    CreateThread(function()
        debugPrint("[GaragePrompt]", "Garage of owned house " .. data.owner)
        if hasKey(data, (Config.framework == "ESX" and PlayerData.identifier or PlayerData.citizenid)) then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                HelpText(true, Locale["prompt_store_vehicle"])
            else
                HelpText(
                    true, Locale["prompt_open_garage"])
            end
            while inZone do
                Wait(2)
                if IsControlJustReleased(0, 38) then
                    HelpText(false)
                    if IsResourceStarted("mb_garage") then
                        TriggerEvent("mb_garage:openPrivate", data.name .. " Garage",
                            data.garage)
                    elseif IsResourceStarted("garage_insurance") then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            exports["garage_insurance"]:storeHouseGarage(data.name)
                        else
                            exports["garage_insurance"]:openHouseGarage(data.name, data.garage)
                        end
                    elseif IsResourceStarted("jg-advancedgarages") then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            TriggerEvent("jg-advancedgarages:client:InsertVehicle", identifier, true)
                        else
                            TriggerEvent("jg-advancedgarages:client:ShowHouseGarage:qs-housing", identifier)
                        end
                    elseif IsResourceStarted("MojiaGarages") then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            TriggerEvent("MojiaGarages:client:storeVehicle")
                        else
                            TriggerEvent("MojiaGarages:client:openGarage")
                        end
                    elseif IsResourceStarted("okokGarage") then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            TriggerEvent("okokGarage:StoreVehiclePrivate")
                        else
                            TriggerEvent("okokGarage:OpenPrivateGarageMenu", GetEntityCoords(PlayerPedId()),
                                GetEntityHeading(PlayerPedId()))
                        end
                    elseif IsResourceStarted("mono_garage") then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            local vehicle = GetVehiclePedIsUsing(PlayerPedId())
                            local plate1 = string.gsub(GetVehicleNumberPlateText(vehicle), "^%s*(.-)%s*$", "%1")
                            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                            TriggerServerEvent("mono_garage:GuardarVehiculo", plate1, json.encode(vehicleProps),
                                data.name, VehToNet(vehicle))
                        else
                            TriggerEvent("mono_garage:garage",
                                { garage = data.name, spawnpos = data.garage, impound = "Auto Impound" })
                        end
                    elseif IsResourceStarted("loaf_garage") then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            exports.loaf_garage:StoreVehicle("property", GetVehiclePedIsUsing(PlayerPedId()))
                        else
                            exports.loaf_garage:BrowseVehicles("property",
                                vec4(data.garage.x, data.garage.y, data.garage.z, data.garage.w))
                        end
                    elseif IsResourceStarted("cd_garage") then
                        if IsPedInAnyVehicle(PlayerPedId()) then
                            TriggerEvent("cd_garage:StoreVehicle_Main", 1, false)
                        else
                            SetEntityCoords(PlayerPedId(),
                                vec3(data.garage.x, data.garage.y, data.garage.z) - vector3(0.0, 0.0, 1.0))
                            SetEntityHeading(PlayerPedId(), data.garage.w)
                            Wait(50)
                            TriggerEvent("cd_garage:PropertyGarage", "quick")
                        end
                    elseif IsResourceStarted('mGarage') or IsResourceStarted('codem-garage') then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            TriggerEvent("codem-garage:storeVehicle", data.name)
                        else
                            TriggerEvent("codem-garage:openHouseGarage", data.name)
                        end
                    elseif IsResourceStarted("luke_garages") then
                        local garage = {
                            label = "Property - " .. data.name,
                            type = "car",
                            zone = {
                                name = data.name,
                                x = data.garage.x,
                                y = data.garage.y,
                                z = data.garage.z,
                                w = data.garage.w
                            },
                            spawns = { vec4(data.garage.x, data.garage.y, data.garage.z, data.garage.w) }
                        }
                        exports.luke_garages:setZone(garage)
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            TriggerEvent("luke_garages:StoreVehicle", { entity = GetVehiclePedIsUsing(PlayerPedId()) })
                        else
                            TriggerEvent("luke_garages:GetOwnedVehicles")
                        end
                    elseif IsResourceStarted("esx_advancedgarage") then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            local vehicle = GetVehiclePedIsUsing(PlayerPedId())
                            local vehProps = ESX.Game.GetVehicleProperties(vehicle)
                            exports.esx_advancedgarage:setGarage({
                                Spawner = vec3(data.garage.x, data.garage.y, data.garage.z), Heading = data.garage.w })
                            TriggerServerCallback("esx_advancedgarage:storeVehicle", function(valid)
                                if valid then
                                    TriggerServerEvent("esx_advancedgarage:setVehicleState", vehProps.plate, true)
                                    ESX.Game.DeleteVehicle(vehicle)
                                end
                            end, vehProps, data.name)
                        else
                            exports.esx_advancedgarage:setGarage({
                                Spawner = vec3(data.garage.x, data.garage.y, data.garage.z), Heading = data.garage.w })
                            exports.esx_advancedgarage:OpenGarageMenu("civ", "cars")
                        end
                    elseif IsResourceStarted("esx_jb_eden_garage2") then
                        local garage = {
                            SpawnPoint = {
                                Pos = { x = data.garage.x, y = data.garage.y, z = data.garage.z },
                                Heading = data.garage.w
                            },
                            DeletePoint = vec3(data.garage.x, data.garage.y, data.garage.z)
                        }
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            TriggerEvent("esx_eden_garage:StockVehicleMenu", "personal", data.name)
                        else
                            TriggerEvent("esx_eden_garage:ListVehiclesMenu", garage, "personal", data.name)
                        end
                    end
                    break
                end
            end
            while IsNuiFocused() do Wait(100) end
            Wait(1000)
            if inZone then
                local updatedData = GetHomeObject(identifier)
                GaragePrompt(updatedData, identifier)
            end
        end
    end)
end
