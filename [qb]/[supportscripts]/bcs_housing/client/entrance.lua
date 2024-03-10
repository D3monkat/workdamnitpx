local tries = 0

function Dispatch()
    local data = exports['cd_dispatch']:GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = { 'police' },
        coords = data.coords,
        title = 'House Robbery',
        message = 'A ' .. data.sex .. ' robbing a house at ' .. data.street,
        flash = 0,
        unique_id = data.unique_id,
        sound = 1,
        blip = {
            sprite = 431,
            scale = 1.2,
            colour = 3,
            flashes = false,
            text = '911 - House Robbery',
            time = 5,
            radius = 0,
        }
    })
end

---Add tries if lockpicks fails. After certain amount of tries, alert and reset tries
---@param identifier string
function AddTries(identifier)
    if tries < Config.robbery.alertAfterFailed then
        tries += 1
    else
        tries = 0
        Dispatch()
        TriggerServerEvent("Housing:alertLockpick", identifier)
    end
end

---Trigger checks after lockpick minigames
---@param success boolean
---@param identifier string
function LockpickResult(success, identifier)
    if success then
        if IsNearMLODoor() then
            OpenDoor()
        else
            TriggerServerEvent('Housing:lockHome', identifier, true)
        end
        Dispatch()
        TriggerServerEvent("Housing:alertLockpick", identifier)
    else
        AddTries(identifier)
        Notify(Locale['housing'], Locale['failed_lockpick'], 'error', 3000)
        TriggerServerEvent('Housing:removeItem', Config.robbery.lockpickItem)
    end
end

RegisterNetEvent('Housing:startLockpick', function(identifier)
    if not identifier then
        identifier = Home.identifier
    end
    TriggerServerCallback('Housing:checkRobbery', function(allowed)
        if allowed then
            TriggerServerCallback('Housing:checkItem', function(have)
                if have then
                    if identifier or IsNearMLODoor() then
                        if GetResourceState('qb-lockpick') == 'started' then
                            TriggerEvent('qb-lockpick:client:openLockpick', function(result)
                                LockpickResult(result, identifier)
                            end)
                        else
                            local result = exports['lockpick']:startLockpick()
                            LockpickResult(result, identifier)
                        end
                    else
                        Notify(Locale['housing'], Locale['not_near_any_door'], 'error', 3000)
                    end
                else
                    Notify(Locale['housing'], string.format(Locale['not_enough_item'], 'Lockpick'), 'error', 3000)
                end
            end, Config.robbery.lockpickItem)
        else
            Notify(Locale['housing'], Locale['not_enough_police'], 'error', 3000)
        end
    end, identifier)
end)

AddEventHandler('Housing:raidDoor', function(identifier)
    if IsResourceStarted('ox_lib') then
        if lib.progressBar({
                duration = 10000,
                label = 'Raiding door',
                anim = {
                    dict = 'veh@break_in@0h@p_m_one@',
                    clip = 'low_force_entry_ds'
                },
            }) then
            if IsNearMLODoor() then
                OpenDoor()
                Notify(Locale['housing'], Locale['house_raided'], 'success', 3000)
            else
                TriggerServerEvent('Housing:lockHome', identifier, true)
                TriggerEvent('Housing:enterHome', identifier)
                Notify(Locale['housing'], Locale['house_raided'], 'success', 3000)
            end
        end
    elseif IsResourceStarted('progressbar') then
        exports.progressbar:Progress({
            name = 'raiding_police',
            duration = 10000,
            label = 'Raiding door',
            canCancel = false,
            useWhileDead = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = 'veh@break_in@0h@p_m_one@',
                anim = 'low_force_entry_ds'
            },
        }, function(notCancelled)
            if not notCancelled then
                if IsNearMLODoor() then
                    OpenDoor()
                    Notify(Locale['housing'], Locale['house_raided'], 'success', 3000)
                else
                    TriggerServerEvent('Housing:lockHome', identifier, true)
                    TriggerEvent('Housing:enterHome', identifier)
                    Notify(Locale['housing'], Locale['house_raided'], 'success', 3000)
                end
            end
        end)
    end
end)

RegisterCommand(commands.raid.name, function()
    if Config.robbery.enableRaid and isPolice() then
        local house = GetNearestHome()
        if IsNearMLODoor() then
            TriggerEvent('Housing:raidDoor')
        elseif house then
            TriggerEvent('Housing:raidDoor', house.identifier)
        else
            Notify(Locale['housing'], Locale['not_near_any_door'], 'error', 3000)
        end
    end
end)

function ApartmentEntrance(data)
    CreateThread(function()
        HelpText(true, Locale['prompt_apartment_menu'])
        local boxes = {}
        table.insert(boxes, {
            text = {
                title = 'Owned Apartments Filter'
            },
            icon = 'fa-solid fa-door-open',
            event = "Housing:aptEntrance:owned",
            args = { data, true }
        })
        for _, room in pairs(data.rooms) do
            table.insert(boxes, {
                text = {
                    title = room.name
                },
                icon = 'fa-solid fa-door-open',
                event = "Housing:aptEntrance",
                args = { room, room.identifier }
            })
        end
        while inZone do
            Wait(2)
            if IsControlJustReleased(0, 38) then
                HelpText(false)
                TriggerEvent("Housing:createMenu", {
                    title = data.name,
                    subtitle = "Aparment Entrance Menu",
                    boxes = boxes,
                })
                break
            end
        end
        while IsNuiFocused() do
            Wait(1000)
        end
        Wait(200)
        if inZone then
            ApartmentEntrance(data)
        end
    end)
end

RegisterNetEvent('Housing:aptEntrance:owned', function(data)
    local boxes = {}
    for _, room in pairs(data.rooms) do
        if room.owner == (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            table.insert(boxes, {
                text = {
                    title = room.name
                },
                icon = 'fa-solid fa-door-open',
                event = "Housing:aptEntrance",
                args = { room, room.identifier }
            })
        end
    end
    TriggerEvent("Housing:createMenu", {
        title = data.name,
        subtitle = "Owned Aparment Entrance Menu",
        boxes = boxes,
    })
end)

function InteriorEntrance(data, identifier)
    CreateThread(function()
        if data.owner then
            debugPrint('[InteriorEntrance]', 'Entrance of owned house ' .. data.owner)
            TriggerServerCallback('Housing:isOwner', function(isOwner)
                debugPrint('[InteriorEntrance]', 'Lock condition', data.locked)
                local boxes = {}
                if isOwner and not data.locked then
                    HelpText(true, Locale['prompt_enter_home'])
                    table.insert(boxes, {
                        text = {
                            title = Locale['enter_home']
                        },
                        icon = 'fa-solid fa-door-open',
                        event = "Housing:enterHome",
                        args = { identifier }
                    })
                    table.insert(boxes, {
                        text = {
                            title = Locale['lock_home'],
                            body = Locale['lock_home_body'],
                        },
                        icon = 'fa-solid fa-lock',
                        server = true,
                        event = "Housing:lockHome",
                        args = { identifier }
                    })
                    if PlayerData and data.owner == (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
                        table.insert(boxes, {
                            text = {
                                title = Locale['sell_home'],
                                body = Locale['sell_home_body'],
                            },
                            event = "Housing:sellHome",
                            icon = 'fa-solid fa-money-bill',
                            args = { identifier }
                        })
                        table.insert(boxes, {
                            text = {
                                title = Locale['transfer_home'],
                                body = Locale['transfer_home_body']
                            },
                            event = "Housing:transferHome",
                            icon = 'fa-solid fa-right-left',
                            args = { identifier }
                        })
                        table.insert(boxes, {
                            text = {
                                title = Locale['add_cctv'],
                                body = Locale['add_cctv_body']
                            },
                            event = "Housing:addCCTV",
                            icon = 'fa-solid fa-right-left',
                            args = { identifier }
                        })
                    end
                elseif data.locked and isOwner then
                    HelpText(true, Locale['prompt_unlock_door'])
                    while inZone do
                        Wait(2)
                        if IsControlJustReleased(0, 38) then
                            HelpText(false)
                            TriggerServerEvent('Housing:lockHome', identifier)
                            break
                        end
                    end
                    while IsNuiFocused() or busy do
                        Wait(1000)
                    end
                    Wait(200)
                    if inZone then
                        local updatedData = GetHomeObject(identifier)
                        InteriorEntrance(updatedData, identifier)
                    end
                elseif not data.locked then
                    HelpText(true, Locale['prompt_enter_home'])
                    table.insert(boxes, {
                        text = {
                            title = Locale['enter_home']
                        },
                        icon = 'fa-solid fa-door-open',
                        event = "Housing:enterHome",
                        args = { identifier }
                    })
                elseif data.locked then
                    HelpText(true, Locale['prompt_enter_home'])
                    if Config.robbery.enable then
                        table.insert(boxes, {
                            text = {
                                title = Locale['lockpick_home'],
                                body = Locale['lockpick_home_body'],
                            },
                            icon = 'fa-solid fa-lock-open',
                            event = "Housing:startLockpick",
                            args = { identifier }
                        })
                    end
                    table.insert(boxes, {
                        text = {
                            title = Locale['knock_door'],
                        },
                        icon = 'fa-solid fa-lock-open',
                        event = "Housing:knockDoor",
                        args = { identifier }
                    })
                    if Config.robbery.enableRaid and isPolice() then
                        table.insert(boxes, {
                            text = {
                                title = Locale['raid_home'],
                                body = Locale['raid_home_body']
                            },
                            icon = 'fa-solid fa-hand-fist',
                            event = "Housing:raidDoor",
                            args = { identifier }
                        })
                    end
                end
                if boxes and #boxes > 0 then
                    while inZone do
                        Wait(2)
                        if IsControlJustReleased(0, 38) then
                            HelpText(false)
                            TriggerEvent("Housing:createMenu", {
                                title = data.name,
                                subtitle = "House Entrance Menu",
                                boxes = boxes,
                            })
                            break
                        end
                    end
                    while IsNuiFocused() or busy do
                        Wait(1000)
                    end
                    Wait(200)
                    if inZone then
                        local updatedData = GetHomeObject(identifier)
                        InteriorEntrance(updatedData, identifier)
                    end
                end
            end, data)
        else
            HelpText(true, Locale['prompt_buy_home'])
            while inZone do
                Wait(2)
                if IsControlJustReleased(0, 38) then
                    HelpText(false)
                    TriggerEvent("Housing:createMenu", {
                        title = data.name,
                        subtitle = 'House Menu',
                        boxes = {
                            {
                                text = {
                                    title = data.payment == 'Rent' and Locale['rent_home'] or Locale['buy_home']
                                },
                                icon = 'fa-solid fa-sack-dollar',
                                event = "Housing:buyHome",
                                args = { identifier }
                            },
                            {
                                text = {
                                    title = Locale['preview_home']
                                },
                                icon = 'fa-solid fa-eye',
                                event = "Housing:visitHome",
                                args = { identifier }
                            }
                        }
                    })
                    break
                end
            end
            while IsNuiFocused() do
                Wait(1000)
            end
            Wait(200)
            if inZone then
                local updatedData = GetHomeObject(identifier)
                InteriorEntrance(updatedData, identifier)
            end
        end
    end)
end

RegisterNetEvent('Housing:aptEntrance', function(data, identifier)
    Wait(200)
    if data.owner then
        debugPrint('[aptEntrance]', 'Entrance of owned house ' .. data.owner)
        TriggerServerCallback('Housing:isOwner', function(isOwner)
            debugPrint('[aptEntrance]', 'Lock condition', data.locked)
            local boxes = {}
            if isOwner and not data.locked then
                table.insert(boxes, {
                    text = {
                        title = Locale['enter_home']
                    },
                    icon = 'fa-solid fa-door-open',
                    event = "Housing:enterHome",
                    args = { identifier }
                })
                table.insert(boxes, {
                    text = {
                        title = Locale['lock_home'],
                        body = Locale['lock_home_body'],
                    },
                    icon = 'fa-solid fa-lock',
                    server = true,
                    event = "Housing:lockHome",
                    args = { identifier }
                })
                if PlayerData and data.owner == (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
                    table.insert(boxes, {
                        text = {
                            title = Locale['sell_home'],
                            body = Locale['sell_home_body'],
                        },
                        event = "Housing:sellHome",
                        icon = 'fa-solid fa-money-bill',
                        args = { identifier }
                    })
                    table.insert(boxes, {
                        text = {
                            title = Locale['transfer_home'],
                            body = Locale['transfer_home_body']
                        },
                        event = "Housing:transferHome",
                        icon = 'fa-solid fa-right-left',
                        args = { identifier }
                    })
                end
            elseif data.locked and isOwner then
                table.insert(boxes, {
                    text = {
                        title = Locale['lock_home'],
                        body = Locale['lock_home_body'],
                    },
                    icon = 'fa-solid fa-lock',
                    server = true,
                    event = "Housing:lockHome",
                    args = { identifier }
                })
            elseif not data.locked then
                table.insert(boxes, {
                    text = {
                        title = Locale['enter_home']
                    },
                    icon = 'fa-solid fa-door-open',
                    event = "Housing:enterHome",
                    args = { identifier }
                })
            elseif data.locked then
                if Config.robbery.enable then
                    table.insert(boxes, {
                        text = {
                            title = Locale['lockpick_home'],
                            body = Locale['lockpick_home_body'],
                        },
                        icon = 'fa-solid fa-lock-open',
                        event = "Housing:startLockpick",
                        args = { identifier }
                    })
                end
                table.insert(boxes, {
                    text = {
                        title = Locale['knock_door'],
                    },
                    icon = 'fa-solid fa-lock-open',
                    event = "Housing:knockDoor",
                    args = { identifier }
                })
                if Config.robbery.enableRaid and isPolice() then
                    table.insert(boxes, {
                        text = {
                            title = Locale['raid_home'],
                            body = Locale['raid_home_body']
                        },
                        icon = 'fa-solid fa-hand-fist',
                        event = "Housing:raidDoor",
                        args = { identifier }
                    })
                end
            end
            TriggerEvent("Housing:createMenu", {
                title = data.name,
                subtitle = "House Entrance Menu",
                boxes = boxes,
            })
        end, data)
    else
        TriggerEvent("Housing:createMenu", {
            title = data.name,
            subtitle = 'House Menu',
            boxes = {
                {
                    text = {
                        title = data.payment == 'Rent' and Locale['rent_home'] or Locale['buy_home']
                    },
                    icon = 'fa-solid fa-sack-dollar',
                    event = "Housing:buyHome",
                    args = { identifier }
                },
                {
                    text = {
                        title = Locale['preview_home']
                    },
                    icon = 'fa-solid fa-eye',
                    event = "Housing:visitHome",
                    args = { identifier }
                }
            }
        })
    end
end)

function MLOEntrance(data, identifier)
    CreateThread(function()
        if not data.owner then
            HelpText(true, Locale['prompt_buy_home'])
            while inZone do
                Wait(2)
                if IsControlJustReleased(0, 38) then
                    HelpText(false)
                    TriggerEvent("Housing:createMenu", {
                        title = data.name,
                        subtitle = "House Menu",
                        boxes = {
                            {
                                text = {
                                    title = Homes[identifier].payment == 'Rent' and Locale['rent_home'] or
                                        Locale['buy_home']
                                },
                                icon = 'fa-solid fa-sack-dollar',
                                event = "Housing:buyHome",
                                args = { identifier }
                            }
                        }
                    })
                    break
                end
            end
        elseif PlayerData and data.owner == (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) then
            HelpText(true, Locale['prompt_entrance_menu'])
            while inZone do
                Wait(2)
                if IsControlJustReleased(0, 58) then
                    HelpText(false)
                    TriggerEvent("Housing:createMenu", {
                        title = data.name,
                        subtitle = "Entrance Menu",
                        boxes = {
                            {
                                text = {
                                    title = Locale['add_cctv'],
                                    body = Locale['add_cctv_body']
                                },
                                icon = 'fa-solid fa-sack-dollar',
                                event = "Housing:addCCTV",
                                args = { identifier }
                            }
                        }
                    })
                    break
                end
            end
        end
    end)
end
