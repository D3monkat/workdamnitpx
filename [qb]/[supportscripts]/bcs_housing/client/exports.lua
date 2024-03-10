exports('GetOwnedHomes', function()
    local ownedHomes = {}
    for k, data in pairs(Homes) do
        if hasKey(data, (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid)) then
            table.insert(ownedHomes, data)
        end
    end
    for _, apt in pairs(Apartments) do
        for _, data in pairs(apt.rooms) do
            if hasKey(data, (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid)) then
                local room = table.clone(data)
                room.entry = room.apartment.coords
                table.insert(ownedHomes, room)
            end
        end
    end
    return ownedHomes
end)

exports('GetHouseKeys', function()
    local ownedHomes = {}
    for k, data in pairs(Homes) do
        if data.keys and data.keys[Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid] then
            table.insert(ownedHomes, data)
        end
    end
    for _, apt in pairs(Apartments) do
        for _, data in pairs(apt.rooms) do
            if data.keys and data.keys[Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid] then
                local room = table.clone(data)
                room.entry = room.apartment.coords
                table.insert(ownedHomes, room)
            end
        end
    end
    return ownedHomes
end)

exports('GetHomes', function()
    local ownedHomes = {}
    for k, data in pairs(Homes) do
        table.insert(ownedHomes, data)
    end
    for _, apt in pairs(Apartments) do
        for _, data in pairs(apt.rooms) do
            local room = table.clone(data)
            room.entry = room.apartment.coords
            table.insert(ownedHomes, room)
        end
    end
    return ownedHomes
end)

exports('LockHome', function(homeId)
    if hasKey(homeId, (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid)) then
        TriggerServerEvent('Housing:lockHome', homeId)
    end
end)

exports('isLocked', function(homeId)
    return GetHomeObject(homeId).locked
end)

exports('GiveKey', function(homeId, source)
    TriggerServerEvent('Housing:addKeyOwner', source, GetHomeObject(homeId))
end)

exports('RemoveKey', function(homeId, identifier)
    TriggerServerEvent('Housing:removeKeyOwner', identifier, GetHomeObject(homeId))
end)

exports('HasKey', function(homeId)
    return hasKey(homeId, (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid))
end)

exports('GetKeyHolders', function(homeId)
    local data = GetHomeObject(homeId)
    local keyHolders = {}
    for k, v in pairs(data.keys) do
        if k ~= 'amount' then
            table.insert(keyHolders, {
                name = v.name,
                identifier = k
            })
        end
    end
    return keyHolders
end)

exports('SetWaypoint', function(homeId)
    local data = GetHomeObject(homeId)
    ClearGpsPlayerWaypoint()
    SetNewWaypoint(data.entry.x, data.entry.y)
end)

exports('isPlayerInsideHome', function(homeId)
    if homeId then
        return inside and (Home and Home.identifier == homeId)
    else
        return inside
    end
end)
