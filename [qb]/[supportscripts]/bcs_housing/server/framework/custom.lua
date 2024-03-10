loaded = false
CreateThread(function()
    if Config.framework == 'ESX' or Config.framework == 'QB' then return end
    function RegisterServerCallback(func, ...)
        RegisterServerCallback(func, ...)
    end

    ---@param name string
    ---@param func function
    function RegisterUsableItem(name, func)
        RegisterUsableItem(name, func)
    end

    ---@param source number
    function GetPlayerFromId(source)
        return GetPlayerFromId(source)
    end

    ---@param identifier string
    function GetPlayerFromIdentifier(identifier)
        return GetPlayerFromIdentifier(identifier)
    end

    loaded = true

    ---@param Player table
    ---@param type string
    ---@return number
    function GetMoney(Player, type)
        return Player.getAccount(type).money
    end

    ---@param xPlayer table
    ---@param type string
    ---@param amount number
    function RemoveMoney(xPlayer, type, amount)
        xPlayer.removeAccountMoney(type, amount)
    end

    ---@param xPlayer table
    ---@param type string
    ---@param amount number
    function AddMoney(xPlayer, type, amount)
        xPlayer.addAccountMoney(type, amount)
    end

    ---@param xPlayer table
    ---@return string
    function GetName(xPlayer)
        return xPlayer.getName()
    end

    ---@param xPlayer table
    ---@return string
    function GetJobName(xPlayer)
        return xPlayer.job.name
    end

    ---@param xPlayer table
    ---@return string
    function GetJobLabel(xPlayer)
        return xPlayer.job.label
    end

    ---@param xPlayer table
    ---@return number
    function GetJobGrade(xPlayer)
        return xPlayer.job.grade
    end

    -- Returns the number of online players of a job
    ---@return number
    function CountJob(job)
        return GetPlayers('job', job)
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
        local result = MySQL.single.await('SELECT money FROM players WHERE citizenid=?', {identifier})
        return next(result) and json.decode(result.money) or {}
    end

    function UpdateOfflineAccount(account, identifier)
        return MySQL.update.await("UPDATE players SET money=? WHERE citizenid=?", {json.encode(account), identifier})
    end

    function InitializePlayersFurnitures()
        MySQL.Async.fetchAll('SELECT citizenid, furniture FROM players',{
        }, function(result)
            if result then
                for k,v in pairs(result) do
                    SaveFurnitureInventory(v.citizenid, json.decode(v.furniture), false)
                end
            end
        end)
    end

    ---@param xPlayer table
    ---@param admin string
    function CheckAdminGroup(xPlayer, admin)
        return QBCore.Functions.HasPermission(xPlayer.PlayerData.source, admin)
    end

    ---@param source number
    ---@param xPlayer table
    AddEventHandler('framework:playerLoaded', function(source, xPlayer) -- triggered when player logins
        TriggerClientEvent('Housing:registerDoors', -1, doors, doorState)
        TriggerClientEvent('Housing:loadHomes', source, Homes)
        TriggerClientEvent('Housing:loadApartments', source, Apartments)
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
        SaveFurniture = "UPDATE players SET furniture = ? WHERE citizenid = ?",
        SelectFurniture = 'SELECT furniture FROM players WHERE citizenid = @identifier',
        UpdateLastProperty = 'UPDATE players SET last_property=? WHERE citizenid=?',
    }
end)