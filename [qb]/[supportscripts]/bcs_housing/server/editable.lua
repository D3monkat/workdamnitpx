function RegisterStorage(identifier, furniture, home)
    if Config.Inventory == 'ox_inventory' then
        local stash = {
            id = 'storage:' .. identifier .. ':' .. furniture.data.identifier,
            label = home.name .. ' Storage',
            slots = furniture.data.slot or Config.DefaultSlots,
            weight = 100000,
            owner = home.owner
        }
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner)
    end
end

---Pay for furniture in the shop, you can customize it to use item or other stuff
---@param xPlayer any ESX or QB player object
---@param value {price: number, label: string, model: string}
---@return boolean
function PayFurniture(xPlayer, value)
    if GetMoney(xPlayer, Config.DefaultAccount) >= value.price then
        RemoveMoney(xPlayer, Config.DefaultAccount, value.price, 'Buy furniture ' .. value.label)
        return true
    end
    return false
end

CreateThread(function()
    RegisterServerCallback('Housing:checkItem', function(source, cb, item, amount)
        local amount = amount or 1
        local xPlayer = GetPlayerFromId(source)
        if xPlayer then
            if Config.inventory == 'ox_inventory' then
                local xItem = exports.ox_inventory:Search(source, 'count', item)
                cb(xItem >= amount)
            elseif Config.framework == 'ESX' then
                cb(xPlayer.getInventoryItem(item).count >= amount)
            else
                local xItem = xPlayer.Functions.GetItemByName(item)
                if xItem and xItem.amount >= amount then
                    cb(true)
                else
                    cb(false)
                end
            end
        else
            cb(false)
        end
    end)

    if Config.robbery.enable then
        RegisterUsableItem(Config.robbery.lockpickItem, function(source)
            TriggerClientEvent('Housing:startLockpick', source)
        end)
    end

    RegisterServerCallback('Housing:checkRobbery', function(source, cb, identifier)
        local police = CountJob('police')
        if police >= Config.robbery.minPolice then
            if Config.robbery.offlineRobbery then
                cb(true)
            else
                local home = Homes[identifier]
                if home and home.owner then
                    local xPlayer = GetPlayerFromIdentifier(home.owner)
                    if xPlayer then
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            end
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('Housing:removeItem', function(item, amount)
    local amount = amount or 1
    local xPlayer = GetPlayerFromId(source)
    if xPlayer then
        if Config.framework == 'ESX' then
            xPlayer.removeInventoryItem(item, amount)
        elseif Config.framework == 'QB' then
            xPlayer.Functions.RemoveItem(item, amount)
        end
    end
end)

CreateThread(function()
    versionCheck('baguscodestudio/bcs-housing-control')
    if Config.framework == 'QB' then
        RegisterCommand(commands.logout, function(source, args, rawCommands)
            TriggerClientEvent('Housing:logout', source)
        end)
    end
end)

RegisterNetEvent('Housing:LogoutLocation', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local MyItems = Player.PlayerData.items
    MySQL.update('UPDATE players SET inventory = ? WHERE citizenid = ?',
        { json.encode(MyItems), Player.PlayerData.citizenid })
    QBCore.Player.Logout(src)
    TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
end)

--- Sends a message to desired phone script
---@param identifier string Player identifier
---@param msgData {sender: string, subject: string, message: string}
function SendPhoneMessage(identifier, msgData)
    if IsResourceStarted('qb-phone') then
        exports['qb-phone']:sendNewMailToOffline(identifier, msgData)
    elseif IsResourceStarted('gksphone') then
        msgData.image = '/html/static/img/icons/mail.png'
        exports["gksphone"]:SendNewMailOffline(identifier, msgData)
    elseif IsResourceStarted('roadphone') then
        msgData.image = '/public/html/static/img/icons/app/mail.png'
        TriggerEvent('roadphone:receiveMail:offline', identifier, msgData)
    elseif IsResourceStarted('qs-smartphone') then
        TriggerEvent('qs-smartphone:server:sendNewMailToOffline', identifier, msgData)
    end
end

function discordlog(type, title, msg)
    local data = sv_config[type]
    if data then
        PerformHttpRequest(data.webhook, function(err, text, headers)
            end, 'POST',
            json.encode({
                username = data.username,
                avatar_url = data.avatar,
                embeds = {
                    {
                        ['title'] = title,
                        ['color'] = data.color,
                        ['description'] = msg,
                        ['footer'] = { ['text'] = sv_config.server }
                    },
                }
            }),
            { ['Content-Type'] = 'application/json' }, {})
    end
end

RegisterServerEvent('Housing:addlog', discordlog)

function versionCheck(repository)
    local resource = GetInvokingResource() or GetCurrentResourceName()

    local currentVersion = GetResourceMetadata(resource, 'version', 0)

    if currentVersion then
        currentVersion = currentVersion:match('%d%.%d+%.%d+')
    end

    if not currentVersion then
        return print(("^1Unable to determine current resource version for '%s' ^0"):format(
            resource))
    end

    SetTimeout(1000, function()
        PerformHttpRequest(('https://api.github.com/repos/%s/releases/latest'):format(repository),
            function(status, response)
                if status ~= 200 then return end

                response = json.decode(response)
                if response.prerelease then return end

                local latestVersion = response.tag_name:match('%d%.%d+%.%d+')
                if not latestVersion or latestVersion == currentVersion then return end

                local cMajor, cMinor = string.strsplit('.', currentVersion, 2)
                local lMajor, lMinor = string.strsplit('.', latestVersion, 2)

                if tonumber(cMajor) < tonumber(lMajor) or tonumber(cMinor) < tonumber(lMinor) then
                    return print(('^3An update is available for %s (current version: %s)\r\n%s^0'):format(resource,
                        currentVersion, response.html_url))
                end
            end, 'GET')
    end)
end
