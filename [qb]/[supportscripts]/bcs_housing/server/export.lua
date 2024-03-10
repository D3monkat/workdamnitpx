exports('GetOwnedHomes', function(plyId)
    local ownedHomes = {}
    for k, data in pairs(Homes) do
        if data.owner == plyId then
            table.insert(ownedHomes, data)
        end
    end
    return ownedHomes
end)

exports('GetHomesForSale', function()
    local HomesForSale = {}
    for k, data in pairs(Homes) do
        if not data.owner then
            table.insert(HomesForSale, data)
        end
    end
    return HomesForSale
end)

exports('GetHouseKeys', function(plyId)
    local ownedHomes = {}
    for k, data in pairs(Homes) do
        if data.keys and data.keys[plyId] then
            table.insert(ownedHomes, data)
        end
    end
    return ownedHomes
end)

exports("LockHome", LockHome)

exports('isLocked', function(homeId)
    return Homes[homeId].locked
end)

exports('DuplicateKey', function(homeId, source)
    TriggerEvent('Housing:duplicateKey', Homes[homeId], source)
end)

exports('GiveKey', function(homeId, source)
    TriggerEvent('Housing:addKeyOwner', source, Homes[homeId])
end)

exports('RemoveKey', function(homeId, identifier)
    TriggerEvent('Housing:removeKeyOwner', identifier, Homes[homeId])
end)

exports('RevokeOwnership', RevokeOwnership)

exports('RevokePropertyByIdentifier', function(identifier)
    for k, v in pairs(Homes) do
        if v.owner and v.owner == identifier then
            RevokeOwnership(k)
        end
    end
end)

exports('HasKey', function(homeId, plyId)
    return hasKey(plyId, Homes[homeId])
end)

exports('GetKeyHolders', function(homeId)
    local data = Homes[homeId]
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
