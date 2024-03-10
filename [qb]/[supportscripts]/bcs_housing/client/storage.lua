AddEventHandler('Housing:Storage', function(data)
    if data then
        if not Config.robbery.storageRobbery and not hasKey(data.home, Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            Notify(Locale['housing'], Locale['no_owned_house'], 'error', 3000)
            return
        end
        local function openStorage(data)
            if Config.Inventory == "ox_inventory" then
                exports.ox_inventory:openInventory('stash', { id = data.identifier })
            elseif Config.Inventory == 'qs-inventory' then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_" .. data.identifier)
                TriggerEvent("inventory:client:SetCurrentStash", "Stash_" .. data.identifier)
            elseif Config.Inventory == 'qb-inventory' or Config.Inventory == 'lj-inventory' then
                TriggerServerEvent("inventory:server:OpenInventory", "stash", data.identifier,
                    { maxweight = 100000, slots = data.slots or Config.DefaultSlots })
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4)
                TriggerEvent("inventory:client:SetCurrentStash", data.identifier)
            elseif Config.Inventory == 'chezza' then
                TriggerEvent("inventory:openHouse", data.owner, data.identifier, "House Stash", 25000)
            elseif Config.Inventory == 'core_inventory' then
                TriggerServerEvent('core_inventory:server:openInventory', string.sub(data.identifier, 9), "stash")
            elseif Config.Inventory == 'mInventory' then
                local name = data.identifier
                local maxweight = 100000
                local slot = data.slots or Config.DefaultSlots
                exports["codem-inventory"]:OpenStash(name, maxweight, slot)
            end
        end
        if Config.robbery.storageLockpick and not hasKey(data.home, Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            if IsResourceStarted('qb-lockpick') then
                TriggerEvent('qb-lockpick:client:openLockpick', function(result)
                    if result then
                        TriggerServerEvent('Housing:removeItem', Config.robbery.lockpickItem)
                        openStorage(data)
                    else
                        Notify(Locale['housing'], Locale['failed_lockpick'], 'error', 3000)
                        TriggerServerEvent('Housing:removeItem', Config.robbery.lockpickItem)
                    end
                end)
            elseif IsResourceStarted('ps-ui') then
                exports['ps-ui']:Circle(function(success)
                    if success then
                        TriggerServerEvent('Housing:removeItem', Config.robbery.lockpickItem)
                        openStorage(data)
                    else
                        Notify(Locale['housing'], Locale['failed_lockpick'], 'error', 3000)
                        TriggerServerEvent('Housing:removeItem', Config.robbery.lockpickItem)
                    end
                end, 2, 20)
            else
                local result = exports['lockpick']:startLockpick()
                if result then
                    TriggerServerEvent('Housing:removeItem', Config.robbery.lockpickItem)
                    openStorage(data)
                else
                    Notify(Locale['housing'], Locale['failed_lockpick'], 'error', 3000)
                    TriggerServerEvent('Housing:removeItem', Config.robbery.lockpickItem)
                end
            end
        else
            openStorage(data)
        end
    end
end)

function StoragePrompt(data)
    CreateThread(function()
        HelpText(true, Locale['prompt_open_storage'])
        while inZone do
            Wait(2)
            if IsControlJustReleased(0, 38) then
                HelpText(false)
                local storage = {
                    identifier = 'storage:' .. data.identifier .. ':default',
                    home = data.identifier,
                    owner = data.owner
                }
                TriggerEvent('Housing:Storage', storage)
                break
            end
        end
        while IsNuiFocused() do
            Wait(100)
        end
        Wait(1000)
        if inZone then
            StoragePrompt(data)
        end
    end)
end

---@diagnostic disable-next-line: missing-parameter
RegisterCommand(commands.setstorage.name, function()
    local home = GetHomeObject(Home.identifier)
    if Config.furnitureStorage then
        Notify(Locale['housing'], Locale['furniture_storage_enabled'], 'error', 3000)
        return
    end
    if Home then
        debugPrint('[setstorage]', not (home.storage and home.storage.x))
        if home.owner == (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            if Home.storageZone then
                Home.storageZone:destroy()
            end
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            if Home.object or Home.type == 'shell' then
                debugPrint('[setstorage]', 'Storage previous:', json.encode(home.storage))
                local houseCoords = GetEntityCoords(Home.object)
                local dist = coords - houseCoords
                home.storage = {
                    x = dist.x,
                    y = dist.y,
                    z = dist.z,
                    w = heading
                }
                local storage = GetOffsetFromEntityInWorldCoords(Home.object, dist.x, dist.y, dist.z)
                Home.storageZone = BoxZone:Create(vec3(storage.x, storage.y, storage.z), 1.5, 1.5, {
                    name = "storage-" .. Home.identifier,
                    heading = heading,
                    debugPoly = Config.debug,
                    minZ = storage.z - 1.0,
                    maxZ = storage.z + 1.5
                })
                Home.storageZone:onPlayerInOut(function(isPointInside, point)
                    if isPointInside then
                        local data = home
                        inZone = true
                        StoragePrompt(data)
                    else
                        HelpText(false)
                        inZone = false
                    end
                end)
            else
                home.storage = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                    w = heading
                }
                Home.storageZone = BoxZone:Create(coords, 1.5, 1.5, {
                    name = "storage-" .. Home.identifier,
                    heading = heading,
                    debugPoly = Config.debug,
                    minZ = coords.z - 1.0,
                    maxZ = coords.z + 1.5
                })
                Home.storageZone:onPlayerInOut(function(isPointInside, point)
                    if isPointInside then
                        local data = home
                        inZone = true
                        StoragePrompt(data)
                    else
                        HelpText(false)
                        inZone = false
                    end
                end)
            end
            TriggerServerEvent('Housing:setStorage', home)
        end
    end
end)
