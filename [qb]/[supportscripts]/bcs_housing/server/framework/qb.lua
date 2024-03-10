loaded = false
CreateThread(function()
    if Config.framework ~= 'QB' then return end
    QBCore = exports['qb-core']:GetCoreObject()
    
    function RegisterServerCallback(func, ...)
        QBCore.Functions.CreateCallback(func, ...)
    end

    function RegisterUsableItem(name, func)
        QBCore.Functions.CreateUseableItem(name, func)
    end

    function GetPlayerFromId(source)
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Player.source = Player.PlayerData.source
            Player.identifier = Player.PlayerData.citizenid
            return Player
        else
            return nil
        end
    end

    function GetPlayerFromIdentifier(identifier)
        local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
        if Player then
            Player.source = Player.PlayerData.source
            Player.identifier = Player.PlayerData.citizenid
            return Player
        else
            return nil
        end
    end

    loaded = true

    function GetMoney(Player,type)
        return Player.Functions.GetMoney(type)
    end

    function RemoveMoney(Player, type, amount, reason)
        Player.Functions.RemoveMoney(type, amount, reason)
    end

    function AddMoney(Player, type, amount, reason)
        if type == 'money' then type = 'cash' end
        Player.Functions.AddMoney(type, amount, reason)
    end

    function GetName(Player)
        return Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    end

    function GetJobName(Player)
        return Player.PlayerData.job.name
    end

    function GetJobLabel(Player)
        return Player.PlayerData.job.label
    end

    function GetJobGrade(Player)
        return Player.PlayerData.job.grade.level
    end

    -- Returns the number of online players of a job
    ---@return number
    function CountJob(job)
        local Players = QBCore.Functions.GetQBPlayers()
        local total = 0
        for k,Player in pairs(Players) do
            if Player.PlayerData.job.name == job then
                total += 1
            end
        end
        return total
    end

    ---@param job string
    ---@return table[]
    function GetFrameworkPlayers(job)
        local list = {}
            local Players = QBCore.Functions.GetQBPlayers()
            for k,Player in pairs(Players) do
                Player.source = Player.PlayerData.source
                Player.identifier = Player.PlayerData.identifier
                if job and Player.PlayerData.job.name == job then
                    list[#list+1] = Player
                elseif not job then
                    list[#list+1] = Player
                end
            end
        return list
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

    AddEventHandler('QBCore:Server:PlayerLoaded', function(Player, isNew)
        TriggerClientEvent('Housing:registerDoors', Player.PlayerData.source, doors, doorState)
        TriggerClientEvent('Housing:loadHomes', Player.PlayerData.source, Homes)
        TriggerClientEvent('Housing:loadApartments', Player.PlayerData.source, Apartments)
        local query = 'SELECT furniture, last_property FROM players WHERE citizenid = @identifier'
        MySQL.single(query,{
            ['@identifier'] = Player.PlayerData.citizenid
        }, function(result)
            if result then
                SaveFurnitureInventory(Player.PlayerData.citizenid, json.decode(result.furniture), false)
                if result.last_property and result.last_property ~= 'outside' and Config.EnableLastProperty then
                    Wait(2500)
                    TriggerClientEvent('Housing:enterHome', Player.PlayerData.source, result.last_property)
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