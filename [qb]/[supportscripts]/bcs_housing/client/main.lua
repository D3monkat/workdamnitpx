inside = false
local ZONES = {
    ['polyzone'] = true,
    ['garageZone'] = true,
    ['entrance'] = true,
    ['managehouseZone'] = true,
    ['wardrobeZone'] = true,
    ['storageZone'] = true,
    ['frontyardZone'] = true
}
if IsResourceStarted("menuv") then
    ownedHomeMenu = MenuV:CreateMenu('Owned Homes', 'Your owned houses', 'topright', 255, 0, 0, 'size-100', 'default',
        'menuv', 'owned_homes', 'native')
end

RegisterNetEvent('Housing:refreshHome', function(identifier, home, source)
    local currentHome = GetHomeObject(identifier)
    if currentHome and GetPlayerServerId(PlayerId()) ~= source then
        if home then
            local objectHome = Home.object
            debugPrint('[refreshHome]', objectHome, IsEntityAnObject(objectHome), IsAnEntity(objectHome))
            if Home and Home.identifier == identifier then
                if currentHome.spawnedObjects then
                    for k, v in pairs(currentHome.spawnedObjects) do
                        DeleteEntity(v)
                    end
                elseif currentHome.frontyardObjects then
                    for k, v in pairs(currentHome.frontyardObjects) do
                        DeleteEntity(v)
                    end
                end
            end
            for k, v in pairs(home) do
                if not ZONES[k] then
                    currentHome[k] = v
                end
            end
            if not home.owner then
                currentHome.owner = nil
            end
            -- Handle blip refreshes
            if home.complex == 'Individual' then
                deleteBlip(identifier .. '_sell')
                deleteBlip(identifier .. '_owned')
                if home.owner then
                    local data = table.clone(Config.Blips.owned_house)
                    data.coords = home.entry
                    data.label = home.name
                    if data.enable and home.owner == (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
                        createBlip(identifier .. '_owned', data)
                    end
                elseif home.owner == nil then
                    local data = table.clone(Config.Blips.house_sell)
                    data.coords = home.entry
                    data.label = home.name
                    if data.enable then
                        createBlip(identifier .. '_sell', data)
                    end
                end
            else
                RefreshApartmentBlip()
            end
            currentHome.spawnedObjects = {}
            if currentHome.type ~= 'mlo' and next(currentHome.frontyard) then
                currentHome.frontyardObjects = {}
                if not Homes[identifier].frontyardZone then
                    Homes[identifier].frontyardZone = PolyZone:Create(currentHome.frontyard.points, {
                        name = identifier .. '-frontyard',
                        minZ = currentHome.frontyard.minZ,
                        maxZ = currentHome.frontyard.maxZ,
                        debugGrid = Config.debug,
                        gridDivisions = 25
                    })
                    Homes[identifier].frontyardZone:onPlayerInOut(function(isPointInside, point)
                        if isPointInside then
                            if not inside then
                                Home = GetHomeObject(identifier)
                                debugPrint('[frontyardZone]', 'inside frontyard')
                                SpawnFurnitures(identifier, true)
                            end
                        else
                            if not inside and Home.identifier == identifier then
                                Home = {}
                                debugPrint('[frontyardZone]', 'not inside frontyard')
                                DeleteFurnitures(identifier, true)
                            end
                        end
                    end)
                end
            end
            if Home and Home.identifier == identifier then
                Home.object = objectHome
                SpawnFurnitures(identifier)
            end
        else
            if currentHome.owner then
                deleteBlip(identifier .. '_owned')
            else
                deleteBlip(identifier .. '_sell')
            end
            TriggerEvent('qb-garages:client:removeHouseGarage', identifier)
            if currentHome.complex == 'Apartment' then
                local aptId = currentHome.apartment.identifier
                for index, room in pairs(Apartments[aptId].rooms) do
                    if room.identifier == identifier then
                        table.remove(Apartments[aptId].rooms, index)
                        break
                    end
                end
                if #Apartments[aptId].rooms == 0 then
                    Apartments[aptId].entrance:destroy()
                    Apartments[aptId] = nil
                end
                deleteBlip(aptId .. '_sell')
                deleteBlip(aptId .. '_owned')
                RefreshApartmentBlip()
            end
            if currentHome.type == 'mlo' then
                if currentHome.polyzone then
                    currentHome.polyzone:destroy()
                end
            end
            if currentHome.entrance then
                currentHome.entrance:destroy()
            end
            if currentHome.managehouseZone then
                currentHome.managehouseZone:destroy()
            end
            if currentHome.wardrobeZone then
                currentHome.wardrobeZone:destroy()
            end
            if currentHome.storageZone then
                currentHome.storageZone:destroy()
            end
            if currentHome.garageZone then
                currentHome.garageZone:destroy()
            end
            if currentHome.frontyardZone then
                currentHome.frontyardZone:destroy()
            end
            currentHome = nil
        end
        debugPrint('[refreshHome]', 'Home refreshed!')
    end
end)

RegisterNUICallback('initialize', function(data, cb)
    cb({
        locale = UILocale,
    })
end)

RegisterNUICallback('errorForm', function(data, cb)
    Notify(Locale['housing'], data, 'error', 3000)
    cb(1)
end)

RegisterNUICallback('hideFrame', function(data, cb)
    SetNuiFocus(false, false)
    cb(1)
end)

RegisterNUICallback('GetShells', function(data, cb)
    cb(Shells)
end)

RegisterNUICallback('GetIPL', function(data, cb)
    local retval = {}
    for i = 1, #IPL do
        retval[#retval + 1] = {
            name = IPL[i].label,
            value = IPL[i].value,
        }
    end
    cb(retval)
end)

---@diagnostic disable-next-line: missing-parameter
RegisterCommand(commands.createhome.name, function()
    TriggerServerCallback('Housing:checkAllowed', function(allowed)
        if allowed then
            SendNUIMessage({
                action = "display",
                data = {
                    display = 'creator',
                }
            })
            SetNuiFocus(true, true)
        end
    end, 'createhome')
end)

RegisterNUICallback('createHome', function(data, cb)
    local name = data.home.homename
    if name then
        local create = {
            name = name,
            type = string.lower(data.home.hometype),
            payment = data.home.homefor,
            price = tonumber(data.home.homeprice),
            interior = data.home.homeshell,
            mortgages = data.mortgage,
            garage = {},
            cctv = {
                enabled = data.toggles.cctv
            },
            renaming = data.toggles.renaming,
            downpayment = tonumber(data.home.downpayment),
            complex = data.home.complex
        }
        for k, v in pairs(create.mortgages) do
            v.result = tonumber(v.result)
        end
        if create.type == 'mlo' then
            if data.toggles.garage then
                create.enableGarage = data.toggles.garage
            end
            TriggerEvent('Housing:createMLO', create)
        elseif create.complex == 'Apartment' then
            CreateThread(function()
                local nearbyApart = GetNearestApartment()
                local useExisting = false
                if nearbyApart then
                    if IsResourceStarted('bcs_hud') then
                        exports['bcs_hud']:keybind({
                            title = 'Choose',
                            items = {
                                {
                                    description = Locale['keybind_add_to_near_apt'],
                                    buttons = { 'E' }
                                },
                                {
                                    description = Locale['keybind_create_new_apt'],
                                    buttons = { 'G' }
                                }
                            }
                        })
                    else
                        HelpText(true, Locale['prompt_use_existing'])
                    end
                    while true do
                        Wait(2)
                        if IsControlJustReleased(0, 38) then
                            useExisting = true
                            break
                        end
                        if IsControlJustReleased(0, 58) then
                            break
                        end
                    end
                    if IsResourceStarted('bcs_hud') then
                        exports['bcs_hud']:closeKeybind()
                    else
                        HelpText(false)
                    end
                    if useExisting then
                        create.apartment = {
                            name = Apartments[nearbyApart].name,
                            coords = Apartments[nearbyApart].entrance.center,
                            identifier = nearbyApart
                        }
                        if create.type == 'ipl' then
                            create.interior = GetIPLValues(create.interior)
                            TriggerServerEvent('Housing:createHome', create)
                        elseif create.type == 'shell' then
                            TriggerEvent('Housing:createShell', create)
                        end
                    else
                        local input = RequestKeyboardInput('Apartment Name', 'The apartment complex name', 16)
                        local entry = GetCoordsHeading('entrance')
                        create.apartment = {
                            name = input,
                            coords = entry,
                        }
                        if create.type == 'ipl' then
                            create.interior = GetIPLValues(create.interior)
                            TriggerServerEvent('Housing:createHome', create)
                        elseif create.type == 'shell' then
                            TriggerEvent('Housing:createShell', create)
                        end
                    end
                else
                    local input = RequestKeyboardInput('Apartment Name', 'The apartment complex name', 16)
                    local entry = GetCoordsHeading('entrance')
                    create.apartment = {
                        name = input,
                        coords = entry,
                    }
                    if create.type == 'ipl' then
                        create.interior = GetIPLValues(create.interior)
                        TriggerServerEvent('Housing:createHome', create)
                    elseif create.type == 'shell' then
                        TriggerEvent('Housing:createShell', create)
                    end
                end
            end)
        else
            create.entry = GetCoordsHeading('entrance')
            Wait(1000)
            if data.toggles.garage then
                create.garage = GetCoordsHeading('garage')
            end
            if create.type == 'shell' then
                TriggerEvent('Housing:createShell', create)
            else
                create.interior = GetIPLValues(create.interior)
                TriggerServerEvent('Housing:createHome', create)
            end
        end
    else
        Notify(Locale['housing'], Locale['error_create_home'], 'error', 3000)
    end
    cb(1)
end)

RegisterNUICallback('buyHome', function(data, cb)
    TriggerServerEvent('Housing:buyHome', data.identifier)

    cb(1)
end)

RegisterNUICallback('choosePlan', function(data, cb)
    TriggerServerEvent('Housing:choosePlan', data.identifier, data.downpayment, data.plan)

    cb(1)
end)

RegisterNUICallback('payMortgage', function(data, cb)
    if data.type then
        TriggerServerEvent('Housing:payMortgageRemaining', data.identifier)
    else
        TriggerServerEvent('Housing:payMortgage', data.identifier)
    end

    cb(1)
end)

RegisterNUICallback('boxClick', function(data, cb)
    Wait(200)
    if data.event then
        if data.server then
            TriggerServerEvent(data.event, UnpackParams(data.args))
        else
            TriggerEvent(data.event, UnpackParams(data.args))
        end
    end

    cb(1)
end)

AddEventHandler('Housing:createMenu', function(data)
    if data.title and data.boxes then
        SendNUIMessage({
            action = 'display',
            data = {
                display = "selection"
            }
        })
        SetNuiFocus(true, true)
        Wait(100)
        SendNUIMessage({
            action = "setSelection",
            data = data
        })
    end
end)

AddEventHandler('Housing:payMortgage', function(identifier)
    TriggerServerCallback('Housing:checkMortgage', function(data)
        if data then
            SendNUIMessage({
                action = "display",
                data = {
                    display = 'mortgage'
                }
            })
            SetNuiFocus(true, true)
            Wait(100)
            local home = GetHomeObject(identifier)
            SendNUIMessage({
                action = "setMortgage",
                data = {
                    plan = home.plan,
                    data = data,
                    identifier = identifier
                }
            })
        else
            Notify(Locale['housing'], Locale['no_mortgage'], 'error', 3000)
        end
    end, identifier)
end)

AddEventHandler('Housing:buyHome', function(identifier)
    SendNUIMessage({
        action = "display",
        data = {
            display = 'buy'
        }
    })
    SetNuiFocus(true, true)
    Wait(100)
    local data = GetHomeObject(identifier)
    SendNUIMessage({
        action = "setHome",
        data = {
            mortgages = data and data.mortgages or {},
            home = data
        }
    })
end)

AddEventHandler('Housing:renameHouse', function(identifier)
    local data = GetHomeObject(identifier)
    local name = RequestKeyboardInput('House Name', 'Previously: ' .. data.name, 30)
    if name then
        data.name = name
        TriggerServerEvent('Housing:renameHouse', identifier, data)
        Notify(Locale['housing'], string.format(Locale['successfully_renamed'], name), 'success', 3000)
    end
end)

RegisterNetEvent('Housing:enterHome', EnterHome)

AddEventHandler('Housing:knockDoor', KnockDoor)

AddEventHandler('Housing:visitHome', VisitHome)

AddEventHandler('Housing:exitHome', ExitHome)

AddEventHandler('Housing:openHouseManager', OpenHouseManager)

RegisterNetEvent('Housing:sellHome', function(identifier)
    Wait(200)
    TriggerEvent("Housing:createMenu", {
        title = Locale['confirmation_sell_home'],
        subtitle = "Are you sure?",
        boxes = {
            {
                text = {
                    title = "Yes",
                },
                icon = 'fa-solid fa-circle-check',
                event = "Housing:sellHome",
                server = true,
                args = { identifier }
            },
            {
                text = {
                    title = "Cancel",
                },
                icon = 'fa-solid fa-circle-xmark',
            }
        }
    })
end)

AddEventHandler('Housing:dupeLock', function()
    TriggerServerCallback('Housing:getOwnedHomes', function(ownedHomes)
        if IsResourceStarted("menuv") then
            ownedHomeMenu:ClearItems()
            for k, v in pairs(ownedHomes) do
                local homebutton = ownedHomeMenu:AddButton({
                    label = v.name ..
                        ' Keys: ' .. (v.keys and v.keys['amount'] or 0)
                })
                homebutton:On("select", function()
                    TriggerServerEvent('Housing:duplicateKey', v)
                    ownedHomeMenu:Close()
                end)
            end
            ownedHomeMenu:Open()
        elseif GetResourceState('ox_lib') == 'started' then
            local list = {}
            for k, v in pairs(ownedHomes) do
                table.insert(list, { label = v.name .. ' Keys: ' .. (v.keys and v.keys['amount'] or 0), value = v })
            end
            if #list > 0 then
                lib.registerMenu({
                    id = 'housing_key_manage_dupe',
                    title = 'Owned Homes',
                    position = 'top-right',
                    onSideScroll = function(selected, scrollIndex, args)
                    end,
                    onSelected = function(selected, scrollIndex, args)
                    end,
                    onClose = function()
                    end,
                    options = list
                }, function(selected, scrollIndex, args)
                    TriggerServerEvent('Housing:duplicateKey', list[selected].value)
                end)
                lib.showMenu('housing_key_manage_dupe')
            else
                Notify(Locale['housing'], Locale['no_owned_house'], 'error', 3000)
            end
        end
    end)
end)

AddEventHandler('Housing:removeLock', function()
    TriggerServerCallback('Housing:getOwnedHomes', function(ownedHomes)
        if IsResourceStarted("menuv") then
            ownedHomeMenu:ClearItems()
            for k, v in pairs(ownedHomes) do
                local homebutton = ownedHomeMenu:AddButton({
                    label = v.name ..
                        ' Keys: ' .. (v.keys and v.keys['amount'] or 0)
                })
                homebutton:On("select", function()
                    TriggerServerEvent('Housing:deleteKey', v)
                    ownedHomeMenu:Close()
                end)
            end
            ownedHomeMenu:Open()
        elseif GetResourceState('ox_lib') == 'started' then
            local list = {}
            for k, v in pairs(ownedHomes) do
                table.insert(list, { label = v.name .. ' Keys: ' .. (v.keys and v.keys['amount'] or 0), value = v })
            end
            if #list > 0 then
                lib.registerMenu({
                    id = 'housing_key_manage_delete',
                    title = 'Owned Homes',
                    position = 'top-right',
                    onSideScroll = function(selected, scrollIndex, args)
                    end,
                    onSelected = function(selected, scrollIndex, args)
                    end,
                    onClose = function()
                    end,
                    options = list
                }, function(selected, scrollIndex, args)
                    TriggerServerEvent('Housing:deleteKey', list[selected].value)
                end)
                lib.showMenu('housing_key_manage_delete')
            else
                Notify(Locale['housing'], Locale['no_owned_house'], 'error', 3000)
            end
        end
    end)
end)

AddEventHandler('Housing:giveKey', function(src)
    if GetPlayerFromServerId(src) ~= -1 and src ~= GetPlayerServerId(PlayerId()) then
        TriggerServerCallback('Housing:getOwnedHomes', function(ownedHomes)
            if IsResourceStarted("menuv") then
                ownedHomeMenu:ClearItems()
                for k, v in pairs(ownedHomes) do
                    local homebutton = ownedHomeMenu:AddButton({
                        label = v.name .. ' Keys: ' .. (v.keys and v.keys['amount'] or 0) })
                    homebutton:On("select", function()
                        TriggerServerEvent('Housing:addKeyOwner', src, v)
                        ownedHomeMenu:Close()
                    end)
                end
                ownedHomeMenu:Open()
            elseif GetResourceState('ox_lib') == 'started' then
                local list = {}
                for k, v in pairs(ownedHomes) do
                    table.insert(list, { label = v.name .. ' Keys: ' .. (v.keys and v.keys['amount'] or 0), value = v })
                end
                if #list > 0 then
                    lib.registerMenu({
                        id = 'housing_key_manage_give',
                        title = 'Owned Homes',
                        position = 'top-right',
                        onSideScroll = function(selected, scrollIndex, args)
                        end,
                        onSelected = function(selected, scrollIndex, args)
                        end,
                        onClose = function()
                        end,
                        options = list
                    }, function(selected, scrollIndex, args)
                        TriggerServerEvent('Housing:addKeyOwner', src, list[selected].value)
                    end)
                    lib.showMenu('housing_key_manage_give')
                else
                    Notify(Locale['housing'], Locale['no_owned_house'], 'error', 3000)
                end
            end
        end)
    else
        Notify(Locale['housing'], Locale['invalid_input'], 'error', 3000)
    end
end)

AddEventHandler('Housing:removeKey', function(src)
    if GetPlayerFromServerId(src) ~= -1 and src ~= GetPlayerServerId(PlayerId()) then
        TriggerServerCallback('Housing:getOwnedHomes', function(ownedHomes)
            if IsResourceStarted("menuv") then
                ownedHomeMenu:ClearItems()
                for k, v in pairs(ownedHomes) do
                    local homebutton = ownedHomeMenu:AddButton({
                        label = v.name .. ' Have key: ' .. (v.ownKeys and 'Yes' or 'No') })
                    homebutton:On("select", function()
                        if v.ownKeys then
                            TriggerServerEvent('Housing:removeKeyOwner', src, v)
                            ownedHomeMenu:Close()
                        end
                    end)
                end
                ownedHomeMenu:Open()
            elseif GetResourceState('ox_lib') == 'started' then
                local list = {}
                for k, v in pairs(ownedHomes) do
                    table.insert(list, { label = v.name .. ' Have key: ' .. (v.ownKeys and 'Yes' or 'No'), value = v })
                end
                if #list > 0 then
                    lib.registerMenu({
                        id = 'housing_key_manage_remove',
                        title = 'Owned Homes',
                        position = 'top-right',
                        onSideScroll = function(selected, scrollIndex, args)
                        end,
                        onSelected = function(selected, scrollIndex, args)
                        end,
                        onClose = function()
                        end,
                        options = list
                    }, function(selected, scrollIndex, args)
                        if list[selected].value.ownKeys then
                            TriggerServerEvent('Housing:removeKeyOwner', src, list[selected].value)
                        end
                    end)
                    lib.showMenu('housing_key_manage_remove')
                else
                    Notify(Locale['housing'], Locale['no_owned_house'], 'error', 3000)
                end
            end
        end, src)
    else
        Notify(Locale['housing'], Locale['invalid_input'], 'error', 3000)
    end
end)

RegisterCommand(commands.givekey.name, function(_, args)
    TriggerEvent('Housing:giveKey', tonumber(args[1]))
end)

RegisterCommand(commands.removekey.name, function(_, args)
    TriggerEvent('Housing:removeKey', tonumber(args[1]))
end)

RegisterCommand(commands.deletehome.name, function(source, args)
    TriggerServerCallback('Housing:checkAllowed', function(allowed)
        if allowed then
            DeleteHome()
        end
    end, 'deletehome')
end)

RegisterCommand(commands.deleteapartment.name, function(source, args)
    TriggerServerCallback('Housing:checkAllowed', function(allowed)
        if allowed then
            DeleteApartment(table.concat(args, " "))
        end
    end, 'deletehome')
end)
