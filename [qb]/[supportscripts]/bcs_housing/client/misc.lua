function ManageHousePrompt(data, identifier)
    CreateThread(function()
        if data.owner and data.owner == (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            HelpText(true, Locale['prompt_open_managehouse'])
            while inZone do
                Wait(2)
                if IsControlJustReleased(0, 38) then
                    HelpText(false)
                    OpenHouseManager(data)
                    break
                end
            end
            while IsNuiFocused() do
                Wait(100)
            end
            Wait(200)
            if inZone then
                ManageHousePrompt(data)
            end
        end
    end)
end

RegisterNetEvent('Housing:transferHome', function(identifier)
    local target = RequestKeyboardInput(Locale['transfer'], Locale['transfer_desc'], 4)
    if target and type(tonumber(target) == 'number') then
        local data = GetHomeObject(identifier)
        if PlayerData and (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) == data.owner then
            TriggerServerEvent('Housing:transferOwner', identifier, tonumber(target))
        else
            -- Cheater
        end
    else
        Notify(Locale['housing'], Locale['invalid_input'], 'error', 3000)
    end
end)

RegisterNetEvent('Housing:logout', function()
    if inside then
        if Home.type == 'shell' then
            ExitHome()
        end
        TriggerServerEvent('Housing:LogoutLocation')
    else
        Notify(Locale['housing'], Locale['not_inside_home'], 'error', 3000)
    end
end)

RegisterNetEvent('Housing:blipAlert', function(identifier)
    local Home = GetHomeObject(identifier)
    local coords = Home.complex == 'Individual' and Home.entry or Home.apartment.coords
    local alpha = 250
    local houseRobberyBlip = AddBlipForRadius(coords.x, coords.y, coords.z, 30.0)

    SetBlipHighDetail(houseRobberyBlip, true)
    SetBlipColour(houseRobberyBlip, 1)
    SetBlipAlpha(houseRobberyBlip, alpha)
    SetBlipAsShortRange(houseRobberyBlip, true)

    Notify(Locale['housing'], string.format(Locale['robbery_in_progress'], Home.name), 'warning', 5000)

    while alpha ~= 0 do
        Citizen.Wait(30 * 4)
        alpha = alpha - 1
        SetBlipAlpha(houseRobberyBlip, alpha)

        if alpha == 0 then
            RemoveBlip(houseRobberyBlip)
            return
        end
    end
end)

if Config.debug then
    local debug = {}

    RegisterCommand('testshell', function(src, args)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        debug.model = args[1]
        debug.shell = CreateObjectNoOffset(debug.model, x, y, z - 100, false, false, false)
        FreezeEntityPosition(debug.shell, true)
        SetEntityCoords(PlayerPedId(), x, y, z - 100)
    end)

    RegisterCommand('deleteshell', function()
        DeleteEntity(debug.shell)
        debug = {}
    end)

    RegisterCommand('getoffset', function()
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local houseCoords = GetEntityCoords(debug.shell)
        local xdist = coords.x - houseCoords.x
        local ydist = coords.y - houseCoords.y
        local zdist = coords.z - houseCoords.z
        print('X: ' .. xdist)
        print('Y: ' .. ydist)
        print('Z: ' .. zdist)
        TriggerServerEvent('Housing:writeoffset', debug.model, xdist, ydist, zdist, heading)
    end)

    RegisterCommand('addIPL', function(src, args, raw)
        local name = args[1]
        table.remove(args, 1)
        local label = table.concat(args, ' ')
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        TriggerServerEvent('Housing:writeIPL', label, name, coords.x, coords.y, coords.z, heading)
    end)
end
