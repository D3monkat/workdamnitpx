loaded = false
CreateThread(function()
    if Config.framework ~= 'ESX' then return end
    ESX = exports['es_extended']:getSharedObject()
    
    function RegisterServerCallback(func, ...)
        ESX.RegisterServerCallback(func, ...)
    end

    function RegisterUsableItem(name, func)
        ESX.RegisterUsableItem(name, func)
    end

    function GetPlayerFromId(source)
        return ESX.GetPlayerFromId(source)
    end

    function GetPlayerFromIdentifier(identifier)
        return ESX.GetPlayerFromIdentifier(identifier)
    end

    loaded = true

    function GetMoney(Player, type)
        return Player.getAccount(type).money
    end

    function RemoveMoney(xPlayer, type, amount)
        xPlayer.removeAccountMoney(type, amount)
    end

    function AddMoney(xPlayer, type, amount)
        xPlayer.addAccountMoney(type, amount)
    end

    function GetName(xPlayer)
        return xPlayer.getName()
    end

    function GetJobName(xPlayer)
        return xPlayer.job.name
    end

    function GetJobLabel(xPlayer)
        return xPlayer.job.label
    end

    function GetJobGrade(xPlayer)
        return xPlayer.job.grade
    end

    -- Returns the number of online players of a job
    ---@return number
    function CountJob(job)
        return #ESX.GetExtendedPlayers('job', job)
    end

    ---@param job string
    ---@return table[]
    function GetFrameworkPlayers(job)
        if job then
            return ESX.GetExtendedPlayers('job', job)
        else
            return ESX.GetExtendedPlayers()
        end
    end

    function GetOfflineAccount(identifier)
        local result = MySQL.single.await('SELECT accounts FROM users WHERE identifier=?', {identifier})
        return next(result) and json.decode(result.accounts) or {}
    end

    function UpdateOfflineAccount(account, identifier)
        return MySQL.update.await("UPDATE users SET accounts=? WHERE identifier=?", {json.encode(account), identifier})
    end

    function InitializePlayersFurnitures()
        MySQL.Async.fetchAll('SELECT identifier, furniture FROM users',{
        }, function(result)
            if result then
                for k,v in pairs(result) do
                    SaveFurnitureInventory(v.identifier, json.decode(v.furniture), false)
                end
            end
        end)
    end

    ---@param xPlayer table
    ---@param admin string
    function CheckAdminGroup(xPlayer, admin)
        return xPlayer.getGroup() == admin
    end

    AddEventHandler('esx:playerLoaded', function(source, xPlayer)
        TriggerClientEvent('Housing:registerDoors', source, doors, doorState)
        TriggerClientEvent('Housing:loadHomes', source, Homes)
        TriggerClientEvent('Housing:loadApartments', source, Apartments)
        TriggerClientEvent('Housing:initialize', xPlayer.source)
        local query = 'SELECT furniture, last_property FROM users WHERE identifier = @identifier'
        MySQL.single(query,{
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if result then
                SaveFurnitureInventory(xPlayer.identifier, json.decode(result.furniture), false)
                if result.last_property and result.last_property ~= 'outside' and Config.EnableLastProperty then
                    Wait(2500)
                    TriggerClientEvent('Housing:enterHome', source, result.last_property)
                end
            end
        end)
    end)
    
    Config.SQLQueries[Config.framework] = {
        SaveFurniture = "UPDATE users SET furniture = ? WHERE identifier = ?",
        SelectFurniture = 'SELECT furniture FROM users WHERE identifier = @identifier',
        UpdateLastProperty = 'UPDATE users SET last_property=? WHERE identifier=?',
    }
end)