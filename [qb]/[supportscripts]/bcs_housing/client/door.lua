local doors = {}
local showedEntity = nil
local doorState = {}
local pulsed = false
local shown = false

---@diagnostic disable-next-line: missing-parameter
RegisterCommand(commands.addhomedoor.name, function(source, args)
    TriggerServerCallback('Housing:checkAllowed', function (allowed)
        debugPrint('[addHomeDoor]', Home, Home.type)
        if not Home or Home.type ~= 'mlo' then
            TriggerEvent('Housing:notify', Locale['housing'], Locale['not_inside_MLO'], 'error', 3000)
            return
        end
        if not allowed and not hasKey(Home, Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            TriggerEvent('Housing:notify', Locale['housing'], Locale['not_owned_home'], 'error', 3000)
            return
        end
        if not args[1] or not args[2] then 
            TriggerEvent('Housing:notify', Locale['housing'], Locale['incomplete_arguments'], 'error', 3000)
            return 
        end
        if type(tonumber(args[2])) ~= 'number' then
            TriggerEvent('Housing:notify', Locale['housing'], Locale[''], 'error', 3000)
            return
        end
        local currentDoors, entities = {}, {}
        HelpText(true, Locale['prompt_add_door'])
        while true do
            Wait(1)
            local ped = PlayerPedId()
            local _coords = GetEntityCoords(ped)
            local hit, coords, entity = RayCastGamePlayCamera(5000.0)
    
            if args[1] == 'single' then
                DrawLine(_coords, coords, 255, 0, 0, 255)
                if IsEntityAnObject(entity) then
                    DrawLine(_coords, coords, 0, 255, 34, 255)
                    if showedEntity ~= entity then
                        SetEntityDrawOutline(showedEntity, false)
                        showedEntity = entity
                    end
                    if IsControlJustPressed(1, 38) then
                        local min, max = GetModelDimensions(GetEntityModel(entity))
                        local points = {
                            GetOffsetFromEntityInWorldCoords(entity, min.x, min.y, min.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, min.x, min.y, max.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, min.x, max.y, max.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, min.x, max.y, min.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, max.x, min.y, min.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, max.x, min.y, max.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, max.x, max.y, max.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, max.x, max.y, min.z).xy
                        }

                        local centroid = vec2(0, 0)

                        for i = 1, 8 do
                            centroid += points[i]
                        end
                        centroid = centroid / 8
                        local _doorCoords = vec3(centroid.x, centroid.y, GetEntityCoords(entity).z)
                        local _doorModel = GetEntityModel(entity)
                        local _heading = GetEntityHeading(entity)
                        SetEntityDrawOutline(entity, false)
                        local data = {
                            model = _doorModel, 
                            coords = _doorCoords, 
                            heading = _heading, 
                            type = 'single', 
                            distance= 2,
                            home = Home.identifier
                        }
                        if not IsDoorOverlap(data.coords) then
                            TriggerServerEvent('Housing:addDoor', data)
                            HelpText(false)
                            break
                        else
                            Notify(Locale['housing'], Locale['door_exist'], 'error', 3000)
                        end
                    end
                    SetEntityDrawOutline(entity, true)
                else
                    if showedEntity ~= entity then
                        SetEntityDrawOutline(showedEntity, false)
                        showedEntity = entity
                    end
                end
            elseif args[1] == 'double' then
                DrawLine(_coords, coords, 255, 0, 0, 255)
                if IsEntityAnObject(entity) then
                    for k,v in pairs(entities) do
                        SetEntityDrawOutline(v, true)
                    end
                    if #currentDoors < 2 then
                        DrawLine(_coords, coords, 0, 255, 34, 255)
                    else
                        DrawLine(_coords, coords, 0, 255, 34, 255)
                    end
                    if IsControlJustPressed(1, 38) then
                        local min, max = GetModelDimensions(GetEntityModel(entity))
                        local points = {
                            GetOffsetFromEntityInWorldCoords(entity, min.x, min.y, min.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, min.x, min.y, max.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, min.x, max.y, max.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, min.x, max.y, min.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, max.x, min.y, min.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, max.x, min.y, max.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, max.x, max.y, max.z).xy,
                            GetOffsetFromEntityInWorldCoords(entity, max.x, max.y, min.z).xy
                        }

                        local centroid = vec2(0, 0)

                        for i = 1, 8 do
                            centroid += points[i]
                        end
                        centroid = centroid / 8
                        local _doorCoords = vec3(centroid.x, centroid.y, GetEntityCoords(entity).z)
                        local _doorModel = GetEntityModel(entity)
                        local _heading = GetEntityHeading(entity)
                        table.insert(currentDoors, {coords = _doorCoords, model=_doorModel, heading=heading})
                        table.insert(entities, entity)
                        if #currentDoors == 2 then
                            for k,v in pairs(entities) do
                                SetEntityDrawOutline(v, false)
                            end
                            entities = {}
                            local data = {
                                double=currentDoors, 
                                type='double', 
                                distance=2,
                                home = Home.identifier
                            }
                            if not IsDoorOverlap(_doorCoords) then
                                TriggerServerEvent('Housing:addDoor', data)
                                currentDoors = {}
                                HelpText(false)
                                break
                            else
                                currentDoors = {}
                                Notify(Locale['housing'], Locale['door_exist'], 'error', 3000)
                            end
                        end
                    end
                end
            end
        end
    end, 'createdoor')
end)

RegisterCommand(commands.deletehomedoor.name, function(source, args)
    TriggerServerCallback('Housing:checkAllowed', function (allowed)
        if not Home or Home.type ~= 'mlo' then
            TriggerEvent('Housing:notify', Locale['housing'], Locale['not_inside_MLO'], 'error', 3000)
            return
        end
        if not allowed and not hasKey(Home, Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            TriggerEvent('Housing:notify', Locale['housing'], Locale['not_owned_home'], 'error', 3000)
            return
        end
        HelpText(true, Locale['prompt_delete_door'])
        while true do
            Wait(1)
            local ped = PlayerPedId()
            local _coords = GetEntityCoords(ped)
            local hit, coords, entity = RayCastGamePlayCamera(5000.0)

            DrawLine(_coords, coords, 255, 0, 0, 255)
            if IsEntityAnObject(entity) then
                DrawLine(_coords, coords, 0, 255, 34, 255)
                if showedEntity ~= entity then
                    SetEntityDrawOutline(showedEntity, false)
                    showedEntity = entity
                end
                if IsControlJustPressed(1, 38) then
                    local _doorCoords = GetEntityCoords(entity)
                    local _doorModel = GetEntityModel(entity)
                    local _heading = GetEntityHeading(entity)
                    SetEntityDrawOutline(entity, false)
                    DeleteDoor(_doorCoords)
                    HelpText(false)
                    break
                end
                SetEntityDrawOutline(entity, true)
            else
                if showedEntity ~= entity then
                    SetEntityDrawOutline(showedEntity, false)
                    showedEntity = entity
                end
            end
        end
    end, 'createdoor')
end)

CreateThread(function()
    while true do 
        local state = false
        local sleep = 500
        local pedCoords = GetEntityCoords(PlayerPedId())
        local nearby = false
        for k,v in pairs(doors) do
            if v.type == 'single' then
                v.coords = vec3(v['coords']['x'], v['coords']['y'], v['coords']['z'])
                local dist = #(pedCoords - v.coords)

                if dist < 30 then
                    door = GetClosestObjectOfType(v['coords']['x'], v['coords']['y'], v['coords']['z'], 1.0, v["model"], false, false, false)
                    if not IsDoorRegisteredWithSystem(v.model.. "door"..k) then
                        AddDoorToSystem(v.model.. "door"..k, v.model, v.coords, false, false, false)
                    end
                    if doorState[k] ~= nil then
                        DoorSystemSetDoorState(v.model.. "door"..k, 4, false, false) 
                    else
                        DoorSystemSetDoorState(v.model.. "door"..k, 0, false, false) 
                    end
                end
                if dist < v.distance then
                    nearby = true
                    if not shown then
                        shown = true
                        if doorState[k] == nil then
                            HelpText(true, Locale['prompt_lock_door'])
                        else
                            HelpText(true, Locale['prompt_unlock_door'])
                        end
                    end
                    door = GetClosestObjectOfType(v['coords']['x'], v['coords']['y'], v['coords']['z'], 1.0, v["model"], false, false, false)
                    if doorState[k] ~= nil then
                        DoorSystemSetDoorState(v.model.. "door"..k, 4, false, false) 
                        if pulsed then
                            TriggerServerEvent("Housing:updateDoor", k, nil)
                            doorState[k] = nil
                            pulsed = false
                        end
                    else
                        DoorSystemSetDoorState(v.model.. "door"..k, 0, false, false) 
                        if pulsed then
                            TriggerServerEvent("Housing:updateDoor", k, "locked")
                            doorState[k] = "locked"
                            pulsed = false
                        end
                    end
                end
            elseif v.type == 'double' then
                v.double[1].coords= vec3(v.double[1]['coords']['x'], v.double[1]['coords']['y'], v.double[1]['coords']['z'])
                v.double[2].coords= vec3(v.double[2]['coords']['x'], v.double[2]['coords']['y'], v.double[2]['coords']['z'])
                local dist = #(pedCoords - v.double[1].coords)
                local doorCoords = v.double[1].coords
                local doorCoords2 = v.double[2].coords

                if dist < 30 then
                    door = GetClosestObjectOfType(doorCoords['x'], doorCoords['y'], doorCoords['z'], 1.0, v.double[1]["model"], false, false, false)
                    door2 = GetClosestObjectOfType(doorCoords2['x'], doorCoords2['y'], doorCoords2['z'], 1.0, v.double[2]["model"], false, false, false)
                    if not IsDoorRegisteredWithSystem(v.double[1].model.. "door1"..k) then
                        AddDoorToSystem(v.double[1].model.. "door1"..k, v.double[1].model, doorCoords, false, false, false)
                    elseif not IsDoorRegisteredWithSystem(v.double[2].model..'door2'..k) then
                        AddDoorToSystem(v.double[2].model.. "door2"..k, v.double[2].model, doorCoords2, false, false, false)
                    end
                    if doorState[k] ~= nil then
                        DoorSystemSetDoorState(v.double[1].model.. "door1"..k, 4, false, false) 
                        DoorSystemSetDoorState(v.double[2].model.. "door2"..k, 4, false, false) 
                    else
                        DoorSystemSetDoorState(v.double[1].model.. "door1"..k, 0, false, false) 
                        DoorSystemSetDoorState(v.double[2].model.. "door2"..k, 0, false, false) 
                    end
                end
                if dist < v.distance then
                    nearby = true
                    if not shown then
                        shown = true
                        if doorState[k] == nil then
                            HelpText(true, Locale['prompt_lock_door'])
                        else
                            HelpText(true, Locale['prompt_unlock_door'])
                        end
                    end
                    door = GetClosestObjectOfType(doorCoords['x'], doorCoords['y'], doorCoords['z'], 1.0, v.double[1]["model"], false, false, false)
                    door2 = GetClosestObjectOfType(doorCoords2['x'], doorCoords2['y'], doorCoords2['z'], 1.0, v.double[2]["model"], false, false, false)
                    if doorState[k] ~= nil then
                        DoorSystemSetDoorState(v.double[1].model.. "door1"..k, 4, false, false) 
                        DoorSystemSetDoorState(v.double[2].model.. "door2"..k, 4, false, false) 
                        if pulsed then
                            TriggerServerEvent("Housing:updateDoor", k, nil)
                            doorState[k] = nil
                            pulsed = false
                        end
                    else
                        DoorSystemSetDoorState(v.double[1].model.. "door1"..k, 0, false, false) 
                        DoorSystemSetDoorState(v.double[2].model.. "door2"..k, 0, false, false) 
                        if pulsed then
                            TriggerServerEvent("Housing:updateDoor", k, "locked")
                            doorState[k] = "locked"
                            pulsed = false
                        end
                    end
                end
                sleep = 500
            end
        end
        if shown and not nearby then
            shown = false
            HelpText(false)
        end
        Wait(sleep)
    end
end)

function IsNearMLODoor()
    return shown
end

function DeleteDoor(coords)
    for i=1, #doors do
        if doors[i].type == 'single' then
            local doorCoords = vec3(doors[i]['coords']['x'], doors[i]['coords']['y'], doors[i]['coords']['z'])
            local dist = #(coords - doorCoords)
            if dist < 3.0 then
                doorState[i] = nil
                DoorSystemSetDoorState(doors[i].model.. "door"..i, 0, false, false) 
                TriggerServerEvent('Housing:deleteDoor', i, doorCoords)
                break
            end
        else
            local doorCoords = vec3(doors[i].double[1]['coords']['x'], doors[i].double[1]['coords']['y'], doors[i].double[1]['coords']['z'])
            local dist = #(coords - doorCoords)
            if dist < 3.0 then
                doorState[i] = nil
                DoorSystemSetDoorState(doors[i].double[1].model.. "door1"..i, 0, false, false) 
                DoorSystemSetDoorState(doors[i].double[2].model.. "door2"..i, 0, false, false) 
                TriggerServerEvent('Housing:deleteDoor', i, doorCoords)
                break
            end
        end
    end
end

function IsDoorOverlap(coords)
    for i=1, #doors do
        if doors[i].type == 'single' then
            local dist = #(coords - vec3(doors[i]['coords']['x'], doors[i]['coords']['y'], doors[i]['coords']['z']))
            if dist < 0.5 then
                return true
            end
        else
            local doorCoords = vec3(doors[i].double[1]['coords']['x'], doors[i].double[1]['coords']['y'], doors[i].double[1]['coords']['z'])
            local dist = #(coords - doorCoords)
            if dist < 1.0 then
                return true
            end
        end
    end
    return false
end

RegisterNetEvent('Housing:registerDoors', function(data, state)
    doors = data
    doorState = state
    debugPrint('[registerDoors]', 'registering doors')
end)

RegisterNetEvent('Housing:updateDoors', function(data, state)
    doors = data
    doorState = state
    debugPrint('[updateDoors]', 'updating doors')
end)

RegisterNetEvent('Housing:updateDoorState', function(id, value)
    doorState[id] = value
end)

CreateThread(function()
    while not TriggerServerCallback do
        Wait(100)
    end
    TriggerServerCallback('Housing:getDoors', function(doors, state)
        doors = doors
        doorState = state
    end)
end)

function OpenDoor()
    pulsed = true
    Wait(500)
    shown = false
    HelpText(false)
end

RegisterCommand(commands.lockdoor.name, function()
    if shown then
        if hasKey(Home and Home.identifier and Home or GetNearestHome(), Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            pulsed = true
            Wait(500)
            shown = false
            HelpText(false)
        else
            TriggerEvent('Housing:notify', Locale['housing'], Locale['not_owned_home'], 'error', 3000)
        end
    end
end)

RegisterKeyMapping(commands.lockdoor.name, Locale['command_lock'], 'keyboard', Config.keybinds.lockdoor)