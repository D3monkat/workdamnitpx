local previewObject
local firstObject

local weatherSyncScripts = { "qb-weathersync", "av_weather", "cd_easytime" }
if IsResourceStarted("menuv") then
    furnitureShopMenu = MenuV:CreateMenu("Furniture Shop",
        "Browse Furniture here!", "topleft",
        255, 0, 0, "size-125", "default",
        "menuv", "shop_furniture")

    for i = 1, #Config.Furnitures do
        local list = {}
        local furn = Config.Furnitures[i]
        for j = 1, #furn.list do
            if not firstObject then firstObject = furn end
            table.insert(list, {
                label = furn.list[j].label .. " $" .. furn.list[j].price,
                value = furn.list[j]
            })
        end

        local slider = furnitureShopMenu:AddSlider({
            label = furn.label,
            values = list
        })

        slider:On("select", function(item, value)
            TriggerServerEvent("Housing:buyFurniture", value, furn.label)
        end)

        slider:On("change", function(item, index)
            if previewObject then DeleteEntity(previewObject) end
            previewObject = CreateObject(list[index].value.model,
                Config.FurnitureShop.furnitureSpawn,
                false, false, false)
            SetEntityHeading(previewObject, 65.2959)
        end)
    end

    furnitureShopMenu:On("close", function(m)
        if previewObject then DeleteEntity(previewObject) end
        FreezeEntityPosition(PlayerPedId(), false)
        RenderScriptCams(false)
        DestroyCam(cam, true)
        cam = nil
    end)
elseif GetResourceState("ox_lib") == "started" then
    local options = {}
    for j = 1, #Config.Furnitures do
        local furn = Config.Furnitures[j]
        local list = {}
        for i = 1, #furn.list, 1 do
            if not firstObject then firstObject = furn.list[i] end
            table.insert(list, furn.list[i].label .. " $" .. furn.list[i].price)
        end

        table.insert(options, { label = furn.label, values = list, close = false })
    end
    lib.registerMenu({
        id = "furniture_shop",
        title = "Furniture Shop Menu",
        position = "top-right",
        onSideScroll = function(selected, scrollIndex, args)
            if previewObject then DeleteEntity(previewObject) end
            previewObject = CreateObject(
                Config.Furnitures[selected].list[scrollIndex]
                .model, Config.FurnitureShop.furnitureSpawn,
                false, false, false)
            SetEntityHeading(previewObject, 65.2959)
        end,
        onSelected = function(selected, scrollIndex, args)
            if scrollIndex then
                if previewObject then DeleteEntity(previewObject) end
                previewObject = CreateObject(
                    Config.Furnitures[selected].list[scrollIndex]
                    .model,
                    Config.FurnitureShop.furnitureSpawn, false,
                    false, false)
                SetEntityHeading(previewObject, 65.2959)
            end
        end,
        onClose = function()
            if previewObject then DeleteEntity(previewObject) end
            FreezeEntityPosition(PlayerPedId(), false)
            RenderScriptCams(false)
            DestroyCam(cam, true)
            cam = nil
        end,
        options = options
    }, function(selected, scrollIndex, args)
        TriggerServerEvent("Housing:buyFurniture",
            Config.Furnitures[selected].list[scrollIndex],
            Config.Furnitures[selected].label)
    end)
end

local Blips = {}
spawnedPeds = {}

local function drawMarker(coord)
    CreateThread(function()
        while inside do
            local sleep = 500
            local pedCoords = GetEntityCoords(PlayerPedId())
            local dist = #(pedCoords - coord)
            if dist < 3.0 then
                sleep = 0
                DrawMarker(Config.EnableMarkers.type, coord, 0.0, 0.0, 0.0, 0,
                    0.0, 0.0, Config.EnableMarkers.size.x,
                    Config.EnableMarkers.size.y,
                    Config.EnableMarkers.size.z,
                    Config.EnableMarkers.color.r,
                    Config.EnableMarkers.color.g,
                    Config.EnableMarkers.color.b, 100, false, true, 2,
                    false, false, false, false)
            end
            Wait(sleep)
        end
    end)
end

-- Apartment functions

function GetApartment(identifier, aptId)
    if aptId then
        for _, room in pairs(Apartments[aptId].rooms) do
            if room.identifier == identifier then return room end
        end
    else
        for _, apt in pairs(Apartments) do
            for _, room in pairs(apt.rooms) do
                if room.identifier == identifier then return room end
            end
        end
    end
    return nil
end

function GetNearestApartment()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local closest = 10
    local closestApt
    for k, v in pairs(Apartments) do
        local coord = vec3(v.entrance.center.x, v.entrance.center.y,
            v.entrance.center.z)
        local dist = #(coord - pedCoords)
        if closest > dist then
            closest = dist
            closestApt = k
        end
    end
    return closestApt
end

-- IPL getter

function GetIPLValues(name)
    for i = 1, #IPL do
        if IPL[i].name == name or IPL[i].label == name then return IPL[i] end
    end
end

-- Enter, Visit, and Exit code

function EnterHome(identifier)
    local data = GetHomeObject(identifier)

    if data then
        if PlayerData and not hasKey(data, (Config.framework == "ESX" and PlayerData.identifier or PlayerData.citizenid)) then
            TriggerServerEvent("Housing:alertOwner", identifier)
        end
        Home = table.clone(data)
        data.spawnedObjects = {}
        Home.entry = data.complex == "Individual" and data.entry or data.apartment.coords
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do Wait(10) end
        local entry = {}
        if data.type == "shell" then
            TriggerServerEvent("Housing:enter", Home.identifier)
            RequestModel(data.interior)
            while not HasModelLoaded(data.interior) do Wait(1000) end
            Home.object = CreateObjectNoOffset(data.interior, Home.entry.x,
                Home.entry.y, data.zplacement,
                false, false, false)
            FreezeEntityPosition(Home.object, true)
            Home.polyzone = EntityZone:Create(Home.object, {
                name = "HouseShell",
                debugPoly = Config.debug,
                useZ = true
            })
            entry = GetOffsetFromEntityInWorldCoords(Home.object, Shells[data.interior])
            SetEntityCoordsNoOffset(PlayerPedId(), entry)
        elseif data.type == "ipl" then
            entry = vec3(data.interior.entry.x, data.interior.entry.y,
                data.interior.entry.z)
            Home.entryInside = entry
            TriggerServerEvent("Housing:enter", Home.identifier)
            SetEntityCoordsNoOffset(PlayerPedId(), entry)
            SetEntityHeading(PlayerPedId(), data.interior.heading)
        end
        if data.players then
            table.insert(data.players, GetPlayerServerId(PlayerId()))
        else
            data.players = { GetPlayerServerId(PlayerId()) }
        end
        DoScreenFadeIn(500)
        inside = true
        if Config.target then
            AddTargetBoxZone("HouseEntrance", {
                coords = entry,
                length = 2.0,
                width = 2.0,
                heading = GetEntityHeading(Home.object),
                debugPoly = Config.debug,
                minZ = entry.z - 1.0,
                maxZ = entry.z + 2.0
            }, {
                options = {
                    {
                        event = "Housing:exitHome",
                        icon = "fas fa-door-open",
                        label = "Exit House"
                    }, {
                    label = "Manage Home",
                    icon = "fas fa-home",
                    action = function()
                        OpenHouseManager(Home, true)
                    end,
                    canInteract = function()
                        return IsHomeOwner(Home.identifier)
                    end
                }, {
                    label = Locale["lock_home"],
                    icon = "fa-solid fa-lock",
                    action = function()
                        TriggerServerEvent("Housing:lockHome",
                            Home.identifier)
                    end,
                    canInteract = function()
                        return hasKey(Home.identifier,
                            Config.framework == "ESX" and PlayerData.identifier or PlayerData.citizenid)
                    end
                }
                },
                distance = 3.5
            })
        else
            Home.HouseEntrance = BoxZone:Create(entry, 2.0, 2.0, {
                name = "HouseEntrance-" .. Home.identifier,
                heading = GetEntityHeading(Home.object),
                debugPoly = Config.debug,
                minZ = entry.z - 1.0,
                maxZ = entry.z + 2.0
            })
            Home.HouseEntrance:onPlayerInOut(
                function(isPointInside, point)
                    if isPointInside then
                        HelpText(true, Locale["prompt_home_menu"])
                        inZone = true
                        local boxes = {}
                        table.insert(boxes, {
                            text = { title = "Exit House" },
                            icon = "fa-solid fa-door-open",
                            event = "Housing:exitHome"
                        })
                        if IsHomeOwner(Home.identifier) then
                            table.insert(boxes, {
                                text = { title = "Manage Home" },
                                icon = "fa-solid fa-home",
                                event = "Housing:openHouseManager",
                                args = { Home, true }
                            })
                        end
                        if hasKey(Home.identifier, Config.framework == "ESX" and
                                PlayerData.identifier or
                                PlayerData.citizenid) then
                            table.insert(boxes, {
                                text = {
                                    title = Locale["lock_home"],
                                    body = Locale["lock_home_body"]
                                },
                                icon = "fa-solid fa-lock",
                                server = true,
                                event = "Housing:lockHome",
                                args = { Home.identifier }
                            })
                        end
                        CreateThread(function()
                            while inZone do
                                if IsControlJustPressed(0, 38) then
                                    HelpText(false)
                                    TriggerEvent("Housing:createMenu", {
                                        title = data.name,
                                        subtitle = "House Menu",
                                        boxes = boxes
                                    })
                                    break
                                end
                                Wait(0)
                            end
                        end)
                    else
                        HelpText(false)
                        inZone = false
                    end
                end)
        end
        if data.wardrobe and data.wardrobe.x then
            local wardrobe = vec3(0, 0, 0)
            if Home.type == "shell" then
                wardrobe = GetOffsetFromEntityInWorldCoords(Home.object,
                    data.wardrobe.x,
                    data.wardrobe.y,
                    data.wardrobe.z)
            else
                wardrobe = vec3(data.wardrobe.x, data.wardrobe.y,
                    data.wardrobe.z)
            end
            Home.wardrobeZone = BoxZone:Create(
                vec3(wardrobe.x, wardrobe.y, wardrobe.z),
                1.5, 1.5, {
                    name = "wardrobe-" .. Home.identifier,
                    heading = data.wardrobe.w,
                    debugPoly = Config.debug,
                    minZ = wardrobe.z - 1.0,
                    maxZ = wardrobe.z + 1.5
                })
            if Config.EnableMarkers.enable then
                drawMarker(vec3(wardrobe.x, wardrobe.y, wardrobe.z))
            end
            Home.wardrobeZone:onPlayerInOut(
                function(isPointInside, point)
                    if isPointInside then
                        local identifier = Home.identifier
                        local data = GetHomeObject(identifier)
                        inZone = true
                        WardrobePrompt(data, identifier)
                    else
                        HelpText(false)
                        inZone = false
                    end
                end)
        end
        if data.storage and data.storage.x and not Config.furnitureStorage then
            local storage = vec3(0, 0, 0)
            if Home.type == "shell" then
                storage = GetOffsetFromEntityInWorldCoords(Home.object,
                    data.storage.x,
                    data.storage.y,
                    data.storage.z)
            else
                storage = vec3(data.storage.x, data.storage.y, data.storage.z)
            end
            Home.storageZone = BoxZone:Create(
                vec3(storage.x, storage.y, storage.z), 1.5,
                1.5, {
                    name = "storage-" .. Home.identifier,
                    heading = data.storage.w,
                    debugPoly = Config.debug,
                    minZ = storage.z - 1.0,
                    maxZ = storage.z + 1.5
                })
            if Config.EnableMarkers.enable then
                drawMarker(vec3(storage.x, storage.y, storage.z))
            end
            Home.storageZone:onPlayerInOut(
                function(isPointInside, point)
                    if isPointInside then
                        local identifier = Home.identifier
                        local data = GetHomeObject(identifier)
                        inZone = true
                        StoragePrompt(data)
                    else
                        HelpText(false)
                        inZone = false
                    end
                end)
        end
        TriggerServerEvent('qb-houses:server:SetInsideMeta', Home.identifier, true)
        CreateThread(function()
            TriggerEvent("vSync:toggle", true)
            TriggerEvent("weathersync:toggleSync")
            TriggerEvent("qb-weathersync:client:DisableSync")
            TriggerEvent("av_weather:freeze", true, 18, 00, "CLEAR", false)
            TriggerEvent('cd_easytime:PauseSync', true)
            local hasWeathersync = false
            for _, script in pairs(weatherSyncScripts) do
                if GetResourceState(script) == "started" then
                    hasWeathersync = true
                end
            end
            while inside do
                if not hasWeathersync then
                    SetRainLevel(0.0)
                    SetWeatherTypePersist("CLEAR")
                    SetWeatherTypeNow("CLEAR")
                    SetWeatherTypeNowPersist("CLEAR")
                    NetworkOverrideClockTime(18, 0, 0)
                end
                Wait(500)
            end
            SetRainLevel(-1) -- sets rain back to server's current weather
            TriggerEvent("av_weather:freeze", true)
            TriggerEvent('cd_easytime:PauseSync', false)
            TriggerEvent("qb-weathersync:client:EnableSync")
            TriggerEvent("vSync:toggle", false)
            TriggerEvent("weathersync:toggleSync")
        end)
        SpawnFurnitures(Home.identifier)
        Wait(2000)
        debugPrint("[EnterHome]", "Spawned furniture list",
            json.encode(data.spawnedObjects))
        TriggerServerEvent("Housing:updateLastProperty", Home.identifier)
    end
    TriggerServerEvent("Housing:syncHome", identifier, data)
    TriggerServerEvent("Housing:addlog", "action",
        Locale["log_player_enter_home"],
        string.format(Locale["log_player_enter_home_msg"],
            data.name, PlayerData.name,
            Config.framework == "ESX" and
            PlayerData.identifier or
            PlayerData.citizenid))
end

function VisitHome(identifier)
    local data = GetHomeObject(identifier)
    if data then
        local pedCoords = GetEntityCoords(PlayerPedId())
        Home = table.clone(data)
        Home.entry = pedCoords
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do Wait(10) end
        local entry = {}
        if data.type == "shell" then
            RequestModel(data.interior)
            while not HasModelLoaded(data.interior) do Wait(1000) end
            Home.object = CreateObjectNoOffset(data.interior, Home.entry.x,
                Home.entry.y, data.zplacement,
                false, false, false)
            Home.polyzone = EntityZone:Create(Home.object, {
                name = "HouseShell",
                debugPoly = Config.debug,
                useZ = true
            })
            entry = GetOffsetFromEntityInWorldCoords(Home.object,
                Shells[data.interior])
            SetEntityCoords(PlayerPedId(), entry)
            FreezeEntityPosition(Home.object, true)
        elseif data.type == "ipl" then
            entry = vec3(data.interior.entry.x, data.interior.entry.y,
                data.interior.entry.z)
            Home.entryInside = entry
            SetEntityCoordsNoOffset(PlayerPedId(), entry)
            SetEntityHeading(PlayerPedId(), data.interior.heading)
        end
        Home.identifier = identifier
        Home.furniture = data
        data.spawnedObjects = {}
        DoScreenFadeIn(500)
        inside = true
        if Config.target then
            AddTargetBoxZone("HouseEntrance", {
                name = "HouseEntrance",
                coords = entry,
                length = 2.0,
                width = 2.0,
                heading = GetEntityHeading(Home.object),
                debugPoly = Config.debug,
                minZ = entry.z - 1.0,
                maxZ = entry.z + 2.0
            }, {
                options = {
                    {
                        event = "Housing:exitHome",
                        icon = "fas fa-door-open",
                        label = "Exit House"
                    }
                },
                distance = 3.5
            })
        else
            Home.HouseEntrance = BoxZone:Create(entry, 2.0, 2.0, {
                name = "HouseEntrance-" .. Home.identifier,
                heading = GetEntityHeading(Home.object),
                debugPoly = Config.debug,
                minZ = entry.z - 1.0,
                maxZ = entry.z + 2.0
            })
            Home.HouseEntrance:onPlayerInOut(
                function(isPointInside, point)
                    if isPointInside then
                        HelpText(true, Locale["prompt_leave_home"])
                        inZone = true
                        CreateThread(function()
                            while inZone do
                                if IsControlJustPressed(0, 38) then
                                    HelpText(false)
                                    TriggerEvent("Housing:exitHome")
                                    break
                                end
                                Wait(0)
                            end
                        end)
                    else
                        HelpText(false)
                        inZone = false
                    end
                end)
        end
        CreateThread(function()
            TriggerEvent("vSync:toggle", true)
            TriggerEvent("weathersync:toggleSync")
            TriggerEvent("qb-weathersync:client:DisableSync")
            TriggerEvent("av_weather:freeze", true, 18, 00, "CLEAR", false)
            TriggerEvent('cd_easytime:PauseSync', true)
            local hasWeathersync = false
            for _, script in pairs(weatherSyncScripts) do
                if GetResourceState(script) == "started" then
                    hasWeathersync = true
                end
            end
            while inside do
                if not hasWeathersync then
                    SetRainLevel(0.0)
                    SetWeatherTypePersist("CLEAR")
                    SetWeatherTypeNow("CLEAR")
                    SetWeatherTypeNowPersist("CLEAR")
                    NetworkOverrideClockTime(18, 0, 0)
                end
                Wait(500)
            end
            SetRainLevel(-1) -- sets rain back to server's current weather
            TriggerEvent("av_weather:freeze", false)
            TriggerEvent('cd_easytime:PauseSync', false)
            TriggerEvent("qb-weathersync:client:EnableSync")
            TriggerEvent("weathersync:toggleSync")
            TriggerEvent("vSync:toggle", false)
        end)
        TriggerServerEvent("Housing:addlog", "action",
            Locale["log_player_enter_home"],
            string.format(Locale["log_player_enter_home_msg"],
                data.name, PlayerData.name,
                Config.framework == "ESX" and
                PlayerData.identifier or
                PlayerData.citizenid))
    end
end

function ExitHome()
    if Home.type == "ipl" or Home.type == "shell" then
        TriggerServerEvent("Housing:exit", Home.identifier)
    end
    local data = GetHomeObject(Home.identifier)

    if data.players then
        debugPrint("[ExitHome]", json.encode(data.players))
        for i = 1, #data.players do
            if data.players[i] == GetPlayerServerId(PlayerId()) then
                table.remove(data.players, i)
            end
        end
    end
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
    FreezeEntityPosition(PlayerPedId(), true)
    DeleteEntity(Home.object)
    debugPrint("[ExitHome]", json.encode(data.players))
    DeleteFurnitures(Home.identifier)
    Wait(500)
    debugPrint("[ExitHome]", json.encode(data.players))
    if Home.wardrobeZone then Home.wardrobeZone:destroy() end
    if Home.storageZone then Home.storageZone:destroy() end
    if Home.HouseEntrance then Home.HouseEntrance:destroy() end
    if Home.type == "shell" then
        PolyZone.ensureMetatable(Home.polyzone)
        Home.polyzone:destroy()
        Home.polyzone = nil
    end
    if Config.target then RemoveTargetZone("HouseEntrance") end
    TriggerServerEvent("Housing:updateLastProperty", "outside")
    TriggerServerEvent("Housing:syncHome", Home.identifier, data)
    if Config.AutoLock and hasKey(Home.identifier, Config.framework == "ESX" and
            PlayerData.identifier or PlayerData.citizenid) and IsHouseEmpty(data) then
        TriggerServerEvent('Housing:lockHome', Home.identifier)
    end
    local exitCoords = vec3(Home.entry.x, Home.entry.y, Home.entry.z)
    Home = {}
    inside = false
    SetEntityCoords(PlayerPedId(), exitCoords)
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(500)
    TriggerServerEvent("Housing:addlog", "action",
        Locale["log_player_left_home"],
        string.format(Locale["log_player_left_home_msg"],
            data.name, PlayerData.name,
            Config.framework == "ESX" and
            PlayerData.identifier or
            PlayerData.citizenid))
end

function IsHouseEmpty(data)
    return data.players and #data.players == 0 or true
end

-- Furniture spawn and deletion and store

function SpawnFurnitures(identifier, frontyard)
    local timeout = 0
    local home = GetHomeObject(identifier)
    while not home.furniture do
        Wait(100)
        timeout = timeout + 1
        if timeout > 200 then
            print("[Housing Error]", "Timeout received", identifier)
            break
        end
    end
    if timeout > 200 then return end
    for key, value in pairs(home.furniture) do
        if (frontyard and frontyard == value.frontyard) or
            (not frontyard and not value.frontyard) then
            debugPrint("[SpawnFurnitures]",
                "Spawning furniture prop: " .. value.model,
                json.encode(value.coords))
            local furncoords
            if value.frontyard and frontyard then
                furncoords = vec3(Home.entry.x, Home.entry.y, Home.entry.z) +
                    vec3(value.coords.x, value.coords.y,
                        value.coords.z)
            elseif home.type == "shell" then
                furncoords = GetOffsetFromEntityInWorldCoords(Home.object, vec3(
                    value.coords.x,
                    value.coords.y,
                    value.coords.z))
            elseif home.type == "ipl" then
                furncoords = vec3(Home.entryInside.x, Home.entryInside.y,
                        Home.entryInside.z) +
                    vec3(value.coords.x, value.coords.y,
                        value.coords.z)
            else
                furncoords = vec3(Home.entry.x, Home.entry.y, Home.entry.z) +
                    vec3(value.coords.x, value.coords.y,
                        value.coords.z)
            end
            debugPrint("[SpawnFurnitures]", json.encode(furncoords))
            local object = CreateObject(value.model, furncoords, false, false,
                false)
            SetEntityCoordsNoOffset(object, furncoords)
            SetEntityHeading(object, value.heading)
            local rotation = value.rotation and
                vec3(value.rotation.x, value.rotation.y,
                    value.rotation.z) or
                vec3(0, 0, value.heading)
            SetEntityRotation(object, rotation)
            FreezeEntityPosition(object, true)
            debugPrint("[SpawnFurnitures]", "Furniture created: " .. object)
            if Config.furnitureStorage and Config.target and value.category ==
                "Storage" then
                AddTargetEntity("storage:" .. home.identifier .. ":" ..
                    value.data.identifier, object, {
                        options = {
                            {
                                identifier = "storage:" .. home.identifier .. ":" ..
                                    value.data.identifier,
                                owner = Home.owner,
                                home = home.identifier,
                                event = "Housing:Storage",
                                icon = "fas fa-box-open",
                                label = "Open Storage",
                                slots = value.data.slot or Config.DefaultSlots
                            }
                        },
                        distance = 4
                    })
            elseif Config.furnitureStorage and not Config.target and
                value.category == "Storage" then
                Home["storage:" .. home.identifier .. ":" ..
                value.data.identifier] =
                    BoxZone:Create(furncoords, 1.5, 1.5, {
                        name = "Open Storage",
                        heading = GetEntityHeading(object),
                        debugPoly = Config.debug,
                        minZ = furncoords.z - 1.0,
                        maxZ = furncoords.z + 2.0
                    })
                Home["storage:" .. home.identifier .. ":" ..
                    value.data.identifier]:onPlayerInOut(
                    function(isPointInside, point)
                        if isPointInside then
                            HelpText(true, Locale["prompt_open_storage"])
                            inZone = true
                            CreateThread(function()
                                while inZone do
                                    if IsControlJustPressed(0, 38) then
                                        HelpText(false)
                                        TriggerEvent("Housing:Storage", {
                                            identifier = "storage:" .. home.identifier .. ":" .. value.data.identifier,
                                            home = home.identifier,
                                            owner = Home.owner,
                                            slots = value.data.slot or Config.DefaultSlots
                                        })
                                        break
                                    end
                                    Wait(0)
                                end
                            end)
                        else
                            HelpText(false)
                            inZone = false
                        end
                    end)
            end
            if value.frontyard then
                table.insert(home.frontyardObjects, object)
                debugPrint("[SpawnFurnitures]",
                    json.encode(home.frontyardObjects))
            else
                table.insert(home.spawnedObjects, object)
                debugPrint("[SpawnFurnitures]", json.encode(home.spawnedObjects))
            end
        end
    end
    -- Experimental qb-weed
    TriggerEvent("qb-weed:client:getHousePlants", identifier)
end

function DeleteFurnitures(identifier, frontyard)
    local data = GetHomeObject(identifier) or {}
    if data.furniture then
        for k, v in pairs(data.furniture) do
            if (frontyard and frontyard == v.frontyard) or
                (not frontyard and not v.frontyard) then
                if v.category == "Storage" then
                    if Config.target then
                        RemoveTargetZone(
                            "storage:" .. identifier .. ":" .. v.data.identifier)
                    else
                        if Home["storage:" .. identifier .. ":" ..
                            v.data.identifier] then
                            Home["storage:" .. identifier .. ":" ..
                                v.data.identifier]:destroy()
                            Home["storage:" .. identifier .. ":" ..
                            v.data.identifier] = nil
                        end
                    end
                end
            end
        end
    end
    if frontyard then
        for k, v in pairs(data.frontyardObjects) do
            debugPrint(v)
            RemoveTargetEntity(v, { "Open Storage" })
            DeleteEntity(v)
        end
        data.frontyardObjects = {}
    else
        for k, v in pairs(data.spawnedObjects) do
            debugPrint(v)
            RemoveTargetEntity(v, { "Open Storage" })
            DeleteEntity(v)
        end
        data.spawnedObjects = {}
    end
    -- Experimental qb-weed
    TriggerEvent("qb-weed:client:leaveHouse")
end

function OpenFurnitureStore()
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",
        Config.FurnitureShop.camCoords, 0.0, 0.0,
        0.0, 45.0, false, 0)
    SetCamParams(cam, Config.FurnitureShop.camCoords, 0.0, 0.0, 0.0, 45.0, 1000,
        0, 0, 2)
    PointCamAtCoord(cam, Config.FurnitureShop.furnitureSpawn.x,
        Config.FurnitureShop.furnitureSpawn.y,
        Config.FurnitureShop.furnitureSpawn.z)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, true)
    if IsResourceStarted("menuv") then
        FreezeEntityPosition(PlayerPedId(), true)
        previewObject = CreateObject(firstObject.list[1].model,
            Config.FurnitureShop.furnitureSpawn, false,
            false, false)
        SetEntityHeading(previewObject, 65.2959)
        furnitureShopMenu:Open()
        CreateThread(function()
            Wait(1000)
            if IsResourceStarted("bcs_hud") then
                exports["bcs_hud"]:keybind({
                    title = "Furniture Shop",
                    items = {
                        {
                            description = Locale["keybind_quit"],
                            buttons = { "BACKSPACE" }
                        },
                        {
                            description = Locale["keybind_rotate"],
                            buttons = { ",", "." }
                        }
                    }
                })
            else
                displayHelp(Locale["prompt_furnitureshop"], "bottom-right")
            end
            while true do
                DisableControlAction(0, 81, true)
                DisableControlAction(0, 82, true)
                if IsDisabledControlPressed(0, 82) then
                    SetEntityHeading(previewObject,
                        GetEntityHeading(previewObject) - 1.0)
                end
                if IsDisabledControlPressed(0, 81) then
                    SetEntityHeading(previewObject,
                        GetEntityHeading(previewObject) + 1.0)
                end
                Wait(0)
                if not furnitureShopMenu.IsOpen then break end
            end
            closeHelp()
        end)
    elseif GetResourceState("ox_lib") == "started" then
        CreateThread(function()
            if IsResourceStarted("bcs_hud") then
                exports["bcs_hud"]:keybind({
                    title = "Furniture Shop",
                    items = {
                        {
                            description = Locale["keybind_quit"],
                            buttons = { "BACKSPACE" }
                        },
                        {
                            description = Locale["keybind_rotate"],
                            buttons = { ",", "." }
                        }
                    }
                })
            else
                displayHelp(Locale["prompt_furnitureshop"], "bottom-right")
            end
            while lib.getOpenMenu() do
                DisableControlAction(0, 81, true)
                DisableControlAction(0, 82, true)
                if IsDisabledControlPressed(0, 82) then
                    SetEntityHeading(previewObject,
                        GetEntityHeading(previewObject) - 1.0)
                end
                if IsDisabledControlPressed(0, 81) then
                    SetEntityHeading(previewObject,
                        GetEntityHeading(previewObject) + 1.0)
                end
                Wait(0)
            end
            closeHelp()
        end)
        lib.showMenu("furniture_shop")
    end
end

-- Misc functions

function GetNearestHome()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local nearest = 100
    local home
    for k, v in pairs(Homes) do
        local dist = #(pedCoords - vec3(v.entry.x, v.entry.y, v.entry.z))
        if dist < 10.0 and dist < nearest then
            debugPrint("[GetNearestHome]", "Nearest Home found! " .. v.name)
            nearest = dist
            home = v
        end
    end
    return home or false
end

function DeleteHome(identifier)
    HelpText(false)
    if identifier then
        TriggerServerEvent("Housing:deleteHome", identifier)
    else
        local home = GetNearestHome()
        if home then
            inZone = false
            TriggerServerEvent("Housing:deleteHome", home.identifier)
        end
    end
end

function DeleteApartment(name)
    HelpText(false)
    local found = false
    for _, apt in pairs(Apartments) do
        for _, room in pairs(apt.rooms) do
            if room.name == name then
                found = true
                TriggerServerEvent("Housing:deleteHome", room.identifier)
                break
            end
        end
        if found then
            inZone = false
            break
        end
    end
    if not found then
        Notify(Locale["housing"], string.format(Locale["apt_not_found"], name),
            "error", 3000)
    end
end

function AvailableRooms(rooms) -- To check if there is any available room in the apartment or complex thats being passed
    local totalRooms = #rooms
    local ownsARoom = false
    for _, v in pairs(rooms) do
        if v.owner then
            if PlayerData and v.owner ==
                (Config.framework == "ESX" and PlayerData.identifier or
                    PlayerData.citizenid) then
                ownsARoom = true
            end
            totalRooms = totalRooms - 1
        end
    end
    return totalRooms, ownsARoom
end

function GetHomeObject(identifier)
    return Homes[identifier] or GetApartment(identifier) or {}
end

function GetCoordsHeading(name)
    HelpText(true, "Press ~E~ to set " .. name)
    while true do
        Wait(0)
        if IsControlJustReleased(0, 38) then break end
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    HelpText(false)
    return {
        x = round(x, 2),
        y = round(y, 2),
        z = round(z, 2),
        w = round(GetEntityHeading(PlayerPedId()), 2)
    }
end

function IsHomeOwner(identifier)
    local home = GetHomeObject(identifier)
    return home.owner ==
        (Config.framework == "ESX" and PlayerData.identifier or
            PlayerData.citizenid)
end

function LockHome(identifier)
    if identifier then
        TriggerServerEvent("Housing:lockHome", identifier)
    else
        local home = GetNearestHome()
        if home then
            TriggerServerEvent("Housing:lockHome", home.identifier)
        end
    end
end

function KnockDoor(identifier)
    local home = GetHomeObject(identifier)
    if home.players then
        TriggerServerEvent("Housing:knockDoor", home.players, identifier)
    else
        Notify(Locale["housing"], Locale["no_one_inside"], "error", 3000)
    end
end

function LoadModel(model)
    local timer = GetGameTimer() + 10000

    if not HasModelLoaded(model) and IsModelInCdimage(model) then
        RequestModel(model)
        while not HasModelLoaded(model) and timer >= GetGameTimer() do -- give it time to load
            Wait(50)
        end
    end
end

function createBlip(id, data)
    if not Blips[id] then
        Blips[id] = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
        SetBlipSprite(Blips[id], data.sprite)
        SetBlipDisplay(Blips[id], 4)
        SetBlipScale(Blips[id], data.scale)
        SetBlipColour(Blips[id], data.colour)
        SetBlipAsShortRange(Blips[id], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.label)
        EndTextCommandSetBlipName(Blips[id])
    end
end

function deleteBlip(id)
    if Blips[id] then
        RemoveBlip(Blips[id])
        Blips[id] = nil
    end
end

function RemoveAllBlip()
    for k, v in pairs(Blips) do
        RemoveBlip(v)
        Blips[k] = nil
    end
end

function RefreshApartmentBlip()
    -- Create blips for apartments
    for _, v in pairs(Apartments) do
        local emptyRooms, ownsARoom = AvailableRooms(v.rooms)
        for _, room in pairs(v.rooms) do
            local aptId = room.apartment.identifier
            deleteBlip(aptId .. "_sell")
            deleteBlip(aptId .. "_owned")
            if not Blips[aptId .. "_sell"] and not Blips[aptId .. "_owned"] then
                if emptyRooms > 0 and not ownsARoom then
                    local data = table.clone(Config.Blips.apartment_available)
                    data.coords = room.apartment.coords
                    data.label = room.apartment.name
                    if data.enable then
                        createBlip(aptId .. "_sell", data)
                    end
                    break
                elseif emptyRooms == 0 and not ownsARoom then
                    local data = table.clone(Config.Blips.apartment_unavailable)
                    data.coords = room.apartment.coords
                    data.label = room.apartment.name
                    if data.enable then
                        createBlip(aptId .. "_sell", data)
                    end
                    break
                elseif ownsARoom then
                    local data = table.clone(Config.Blips.owned_apartment)
                    data.coords = room.apartment.coords
                    data.label = room.apartment.name
                    if data.enable then
                        createBlip(aptId .. "_owned", data)
                    end
                    break
                end
            end
        end
    end
end

function spawnPed(id, ped, coords, animDict, animName)
    local pedModel = ped

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        RequestModel(pedModel)
        Wait(100)
    end

    local createdPed = CreatePed(5, pedModel, coords.x, coords.y,
        coords.z - 1.0, coords.w, false, false)
    ClearPedTasks(createdPed)
    ClearPedSecondaryTask(createdPed)
    TaskSetBlockingOfNonTemporaryEvents(createdPed, true)
    SetPedFleeAttributes(createdPed, 0, 0)
    SetPedCombatAttributes(createdPed, 17, 1)

    SetPedSeeingRange(createdPed, 0.0)
    SetPedHearingRange(createdPed, 0.0)
    SetPedAlertness(createdPed, 0)
    SetPedKeepTask(createdPed, true)

    if animDict and animName then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do Citizen.Wait(1) end
        TaskPlayAnim(createdPed, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
    end

    spawnedPeds[id] = createdPed

    FreezeEntityPosition(createdPed, true)
    SetEntityInvincible(createdPed, true)
end

function deletePed(id)
    DeletePed(spawnedPeds[id])
    spawnedPeds[id] = nil
end

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        TriggerEvent("Housing:initialize")
    end
end)

AddEventHandler("onResourceStop", function(resourcename)
    if GetCurrentResourceName() == resourcename then
        for k, v in pairs(spawnedPeds) do DeletePed(v) end
        for k, v in pairs(Homes) do
            if v.type == "mlo" then
                debugPrint("[onResourceStop]",
                    json.encode(Homes[k].spawnedObjects))
                for k, v in pairs(v.spawnedObjects) do
                    debugPrint("[onResourceStop]", "Deleting MLO furniture", v)
                    DeleteEntity(v)
                end
            elseif next(v.frontyard) then
                debugPrint("[onResourceStop]",
                    json.encode(Homes[k].frontyardObjects))
                for k, v in pairs(v.frontyardObjects) do
                    debugPrint("[onResourceStop]",
                        "Deleting Frontyard Furniture", v)
                    DeleteEntity(v)
                end
            end
        end
    end
end)

UnpackParams = function(arguments, i)
    if not arguments then return end
    local index = i or 1

    if index <= #arguments then
        return arguments[index], UnpackParams(arguments, index + 1)
    end
end

function OpenHouseManager(home, isShell)
    local boxes = {
        {
            text = {
                title = Locale["furnish_home"],
                body = Locale["furnish_home_body"]
            },
            event = "Housing:furnish",
            icon = "fa-solid fa-house",
            args = { home.identifier }
        }, {
        text = {
            title = Locale["edit_furniture"],
            body = Locale["edit_furniture_body"]
        },
        event = "Housing:editFurniture",
        icon = "fa-solid fa-couch"
    }, {
        text = {
            title = Locale["pay_mortgage"],
            body = Locale["pay_mortgage_body"]
        },
        event = "Housing:payMortgage",
        icon = "fa-solid fa-money-bill",
        args = { home.identifier }
    }, {
        text = { title = Locale["rename_house"] },
        event = "Housing:renameHouse",
        icon = "fa-solid fa-house",
        args = { home.identifier }
    }, {
        text = { title = Locale["view_cctv"] },
        event = "Housing:viewCCTV",
        icon = "fa-solid fa-video",
        args = { home.identifier }
    }
    }
    if home.payment == "Rent" then
        table.insert(boxes, {
            text = { title = Locale["pay_rent"], body = Locale["pay_rent_body"] },
            event = "Housing:payRent",
            server = true,
            icon = "fa-solid fa-money-bill",
            args = { home.identifier }
        })
        table.insert(boxes, {
            text = {
                title = Locale["check_rent"],
                body = Locale["check_rent_body"]
            },
            event = "Housing:checkRent",
            server = true,
            icon = "fa-regular fa-calendar-days",
            args = { home.identifier }
        })
    end
    if not isShell then
        table.insert(boxes, {
            text = {
                title = Locale["sell_home"],
                body = Locale["sell_home_body"]
            },
            event = "Housing:sellHome",
            icon = "fa-solid fa-money-bill",
            args = { home.identifier }
        })
        table.insert(boxes, {
            text = {
                title = Locale["transfer_home"],
                body = Locale["transfer_home_body"]
            },
            event = "Housing:transferHome",
            icon = "fa-solid fa-right-left",
            args = { home.identifier }
        })
    end
    if hasKey(home.identifier, Config.framework == "ESX" and
            PlayerData.identifier or PlayerData.citizenid) and isShell then
        table.insert(boxes, {
            text = {
                title = Locale["lock_home"],
                body = Locale["lock_home_body"]
            },
            icon = "fa-solid fa-lock",
            server = true,
            event = "Housing:lockHome",
            args = { home.identifier }
        })
    end
    TriggerEvent("Housing:createMenu",
        { title = "House Manager Menu", boxes = boxes })
end

function hasKey(home, identifier)
    local homeObj
    if type(home) == "table" then
        homeObj = GetHomeObject(home.identifier)
    elseif type(home) == "string" then
        homeObj = GetHomeObject(home)
    end
    if homeObj and next(homeObj) ~= nil then -- next(homeObj) ~= nil to check if the homeObj table is empty
        debugPrint("[hasKey]", homeObj.identifier, homeObj.owner)
        return (homeObj.owner and homeObj.owner == identifier) or homeObj.keys[identifier]
    else
        return false
    end
end

RayCastGamePlayCamera = function(distance, custom)
    -- https://github.com/Risky-Shot/new_banking/blob/main/new_banking/client/client.lua
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    if custom then
        cameraRotation = custom.rotation
        cameraCoord = custom.camera
    end
    local direction = RotationToDirection(cameraRotation)
    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local a, b, c, d, e = GetShapeTestResult(
        StartShapeTestRay(cameraCoord.x, cameraCoord.y,
            cameraCoord.z, destination.x,
            destination.y, destination.z,
            -1, PlayerPedId(), 0))
    return b, c, e
end

RotationToDirection = function(rotation)
    -- https://github.com/Risky-Shot/new_banking/blob/main/new_banking/client/client.lua
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) *
            math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) *
            math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function RequestKeyboardInput(title, description, maxlength)
    -- UpdateOnscreenKeyboard 2 = cancel 1 = enter 0 = normal
    AddTextEntry("RequestKeyboardInput", title .. " " .. description)
    DisplayOnscreenKeyboard(1, "RequestKeyboardInput", "", "", "", "", "",
        maxlength)
    local p = promise.new()
    CreateThread(function()
        while p do
            Wait(100)
            if UpdateOnscreenKeyboard() == 1 then
                local result = GetOnscreenKeyboardResult()
                CancelOnscreenKeyboard()
                p:resolve(result)
                p = nil
            elseif UpdateOnscreenKeyboard() == 2 then
                CancelOnscreenKeyboard()
                p:resolve("Invalid")
                p = nil
            end
        end
    end)
    return Citizen.Await(p)
end

function isPolice()
    return PlayerData.job and Config.robbery.policeName[PlayerData.job.name] and
        Config.robbery.policeName[PlayerData.job.name] <=
        (Config.framework == 'ESX' and PlayerData.job.grade or PlayerData.job.level)
end

-- HUD

function displayHelp(text, position)
    SendNUIMessage({
        action = "displayHelp",
        data = { text = text, position = position or "top-left" }
    })
end

function closeHelp()
    if IsResourceStarted("bcs_hud") then exports["bcs_hud"]:closeKeybind() end
    SendNUIMessage({ action = "closeHelp", data = {} })
end
