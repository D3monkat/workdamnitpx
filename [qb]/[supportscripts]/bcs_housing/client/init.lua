Home, Homes, Apartments = {}, {}, {}
inZone = false

RegisterNetEvent('Housing:initialize', function()
    local store = Config.FurnitureShop
    local IkeaZone = BoxZone:Create(store.coords, store.length, store.width, {
        name = "ikea",
        heading = store.heading,
        debugPoly = Config.debug,
        minZ = store.minZ,
        maxZ = store.maxZ
    })
    if Config.EnableMarkers.enable then
        CreateThread(function()
            while true do
                local sleep = 500
                local pedCoords = GetEntityCoords(PlayerPedId())
                local dist = #(pedCoords - store.coords)
                if dist < 3.0 then
                    sleep = 0
                    DrawMarker(Config.EnableMarkers.type, store.coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0,
                        Config.EnableMarkers.size.x, Config.EnableMarkers.size.y, Config.EnableMarkers.size.z,
                        Config.EnableMarkers.color.r, Config.EnableMarkers.color.g, Config.EnableMarkers.color.b, 100,
                        false, true, 2, false, false, false, false)
                end
                Wait(sleep)
            end
        end)
    end
    IkeaZone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inZone = true
            HelpText(true, Locale['prompt_furniture'])
            CreateThread(function()
                local function FurniturePrompt()
                    while inZone do
                        Wait(2)
                        if IsControlJustReleased(0, 38) then
                            HelpText(false)
                            OpenFurnitureStore()
                            break
                        end
                    end
                end
                FurniturePrompt()
            end)
        else
            HelpText(false)
            inZone = false
        end
    end)
    createBlip('furniture-store', store)
    local locksmith = Config.locksmith
    if locksmith.enable then
        for index, info in pairs(locksmith.locations) do
            spawnPed('Locksmith-Housing-' .. index, info.ped, info.coords)
            createBlip('Locksmith-Housing-' .. index, info)
            if Config.target then
                AddTargetModel({ GetHashKey(info.ped) }, {
                    options = {
                        {
                            event = "Housing:dupeLock",
                            icon = "fas fa-user-lock",
                            label = "Duplicate Keys",
                        },
                        {
                            event = "Housing:removeLock",
                            icon = "fas fa-lock",
                            label = "Remove Key",
                        },
                    },
                    distance = 2
                })
            else
                info.zone = BoxZone:Create(vec3(info.coords.x, info.coords.y, info.coords.z), 2.0,
                    2.0, {
                        name = "Locksmith-Housing",
                        heading = GetEntityHeading(object),
                        debugPoly = Config.debug,
                        minZ = info.coords.z - 1.0,
                        maxZ = info.coords.z + 2.0
                    })
                info.zone:onPlayerInOut(function(isPointInside, point)
                    if isPointInside then
                        HelpText(true, Locale['prompt_locksmith_menu'])
                        inZone = true
                        CreateThread(function()
                            while inZone do
                                if IsControlJustPressed(0, 38) then
                                    HelpText(false)
                                    TriggerEvent("Housing:createMenu", {
                                        title = 'Locksmith Menu',
                                        subtitle = "Locksmith",
                                        boxes = {
                                            {
                                                text = {
                                                    title = "Duplicate Keys",
                                                },
                                                icon = 'fa-solid fa-user-lock',
                                                event = "Housing:dupeLock",
                                            },
                                            {
                                                text = {
                                                    title = "Remove Key",
                                                },
                                                icon = 'fa-solid fa-lock',
                                                event = "Housing:removeLock",
                                            },
                                        }
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
        end
    end
    for _, v in pairs(commands) do
        TriggerEvent('chat:addSuggestion', '/' .. v.name, v.help, v.params)
    end
end)

local function LoadApartment(aptId, v)
    for _, room in pairs(v) do
        if not Apartments[aptId] then
            Apartments[aptId] = {}
            Apartments[aptId].rooms = {}
            Apartments[aptId].rooms[#Apartments[aptId].rooms + 1] = room
            local entry = room.apartment.coords
            Apartments[aptId].name = room.apartment.name
            Apartments[aptId].entrance = BoxZone:Create(vec3(entry.x, entry.y, entry.z), 1.5, 1.5, {
                name = "entry-" .. aptId,
                heading = entry.w,
                debugPoly = Config.debug,
                minZ = entry.z - 1.0,
                maxZ = entry.z + 1.5
            })
            if Config.EnableMarkers.enable then
                CreateThread(function()
                    while true do
                        local sleep = 500
                        local pedCoords = GetEntityCoords(PlayerPedId())
                        local dist = #(pedCoords - vec3(entry.x, entry.y, entry.z))
                        if dist < 3.0 then
                            sleep = 0
                            DrawMarker(Config.EnableMarkers.type, vec3(entry.x, entry.y, entry.z), 0.0, 0.0, 0.0, 0,
                                0.0, 0.0, Config.EnableMarkers.size.x, Config.EnableMarkers.size.y,
                                Config.EnableMarkers.size.z, Config.EnableMarkers.color.r,
                                Config.EnableMarkers.color.g, Config.EnableMarkers.color.b, 100, false, true, 2,
                                false, false, false, false)
                        end
                        Wait(sleep)
                    end
                end)
            end
            Apartments[aptId].entrance:onPlayerInOut(function(isPointInside, point)
                if isPointInside then
                    local data = Apartments[aptId]
                    inZone = true
                    if room.type == 'shell' or room.type == 'ipl' then
                        ApartmentEntrance(data)
                    end
                else
                    HelpText(false)
                    inZone = false
                end
            end)
        else
            if not (GetApartment(room.identifier, aptId) and true or false) then
                Apartments[aptId].rooms[#Apartments[aptId].rooms + 1] = room
            end
        end
        while not PlayerData or (PlayerData and (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) == nil) do
            Wait(100)
        end
    end
end

RegisterNetEvent('Housing:loadApartment', function(aptId, apt)
    LoadApartment(aptId, apt)
    RefreshApartmentBlip()
end)

RegisterNetEvent('Housing:loadApartments', function(apts)
    debugPrint('[init:loadApartments]', 'Loading apartments')
    for aptId, v in pairs(apts) do
        LoadApartment(aptId, v)
    end
    RefreshApartmentBlip()
end)

local function LoadHome(home)
    if not home.complex or home.complex ~= 'Apartment' then
        if not Homes[home.identifier] then
            local entry = home.entry
            Homes[home.identifier] = home
            debugPrint('[init:loadHomes]', Homes[home.identifier].name, home.entry)
            if home.garage and home.garage.x then
                Homes[home.identifier].garageZone = BoxZone:Create(vec3(home.garage.x, home.garage.y, home.garage.z), 3.0,
                    3.0, {
                        name = "garage-" .. home.identifier,
                        heading = home.garage.w,
                        debugPoly = Config.debug,
                        minZ = home.garage.z - 1.0,
                        maxZ = home.garage.z + 1.5
                    })
                if Config.EnableMarkers.enable then
                    CreateThread(function()
                        while true do
                            local sleep = 500
                            local pedCoords = GetEntityCoords(PlayerPedId())
                            local dist = #(pedCoords - vec3(home.garage.x, home.garage.y, home.garage.z))
                            if dist < 3.0 then
                                sleep = 0
                                DrawMarker(Config.EnableMarkers.type, vec3(home.garage.x, home.garage.y, home.garage.z),
                                    0.0,
                                    0.0, 0.0, 0, 0.0, 0.0, Config.EnableMarkers.size.x, Config.EnableMarkers.size.y,
                                    Config.EnableMarkers.size.z, Config.EnableMarkers.color.r,
                                    Config.EnableMarkers.color.g, Config.EnableMarkers.color.b, 100, false, true, 2,
                                    false, false, false, false)
                            end
                            Wait(sleep)
                        end
                    end)
                end
                if GetResourceState('qb-garages') == 'started' then
                    local houseInfo = {
                        label = Homes[home.identifier].name,
                        type = 'house',
                        takeVehicle = home.garage
                    }
                    TriggerEvent('qb-garages:client:addHouseGarage', Homes[home.identifier].identifier, houseInfo)
                elseif GetResourceState('qs-advancedgarages') == 'started' then
                    local houseInfo = {
                        label = Homes[home.identifier].name,
                        type = 'house',
                        takeVehicle = home.garage
                    }
                    TriggerEvent('advancedgarages:AddShellGarage', Homes[home.identifier].identifier, houseInfo)
                end
                Homes[home.identifier].garageZone:onPlayerInOut(function(isPointInside, point)
                    if isPointInside and Homes[home.identifier].owner then
                        TriggerEvent('MojiaGarages:client:currentGarage', true, Homes[home.identifier].name)
                        TriggerEvent('advancedgarages:SetShellGarageData', Homes[home.identifier].identifier,
                            hasKey(home.identifier,
                                Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid))
                        TriggerEvent('qb-garages:client:setHouseGarage', Homes[home.identifier].identifier,
                            hasKey(home.identifier,
                                Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid))
                        local identifier = home.identifier
                        local data = GetHomeObject(identifier)
                        inZone = true
                        if GetResourceState('qb-garages') ~= 'started' and GetResourceState('qs-advancedgarages') ~= 'started' then
                            GaragePrompt(data, identifier)
                        end
                    else
                        TriggerEvent('MojiaGarages:client:currentGarage', false, nil)
                        HelpText(false)
                        inZone = false
                    end
                end)
            end
            Homes[home.identifier].entrance = BoxZone:Create(vec3(entry.x, entry.y, entry.z), 1.5, 1.5, {
                name = "entry-" .. home.identifier,
                heading = entry.w,
                debugPoly = Config.debug,
                minZ = entry.z - 1.0,
                maxZ = entry.z + 1.5
            })
            if Config.EnableMarkers.enable then
                CreateThread(function()
                    while true do
                        local sleep = 500
                        local pedCoords = GetEntityCoords(PlayerPedId())
                        local dist = #(pedCoords - vec3(entry.x, entry.y, entry.z))
                        if dist < 3.0 then
                            sleep = 0
                            DrawMarker(Config.EnableMarkers.type, vec3(entry.x, entry.y, entry.z), 0.0, 0.0, 0.0, 0,
                                0.0, 0.0, Config.EnableMarkers.size.x, Config.EnableMarkers.size.y,
                                Config.EnableMarkers.size.z, Config.EnableMarkers.color.r,
                                Config.EnableMarkers.color.g, Config.EnableMarkers.color.b, 100, false, true, 2,
                                false, false, false, false)
                        end
                        Wait(sleep)
                    end
                end)
            end
            Homes[home.identifier].entrance:onPlayerInOut(function(isPointInside, point)
                if isPointInside then
                    local identifier = home.identifier
                    local data = GetHomeObject(identifier)
                    inZone = true
                    if home.type == 'shell' or home.type == 'ipl' then
                        InteriorEntrance(data, identifier)
                    elseif home.type == 'mlo' then
                        MLOEntrance(data, identifier)
                    end
                else
                    HelpText(false)
                    inZone = false
                end
            end)
            if home.type == 'mlo' then
                if home.wardrobe.x then
                    Homes[home.identifier].wardrobeZone = BoxZone:Create(
                        vec3(home.wardrobe.x, home.wardrobe.y, home.wardrobe.z), 1.5, 1.5,
                        {
                            name = "wardrobe-" .. home.identifier,
                            heading = home.wardrobe.w,
                            debugPoly = Config.debug,
                            minZ = home.wardrobe.z - 1.0,
                            maxZ = home.wardrobe.z + 1.5
                        })
                    if Config.EnableMarkers.enable then
                        CreateThread(function()
                            while true do
                                local sleep = 500
                                local pedCoords = GetEntityCoords(PlayerPedId())
                                local dist = #(pedCoords - vec3(home.wardrobe.x, home.wardrobe.y, home.wardrobe.z))
                                if dist < 3.0 then
                                    sleep = 0
                                    DrawMarker(Config.EnableMarkers.type,
                                        vec3(home.wardrobe.x, home.wardrobe.y, home.wardrobe.z), 0.0, 0.0, 0.0, 0, 0.0,
                                        0.0,
                                        Config.EnableMarkers.size.x, Config.EnableMarkers.size.y,
                                        Config.EnableMarkers.size.z, Config.EnableMarkers.color.r,
                                        Config.EnableMarkers.color.g, Config.EnableMarkers.color.b, 100, false, true,
                                        2, false, false, false, false)
                                end
                                Wait(sleep)
                            end
                        end)
                    end
                    Homes[home.identifier].wardrobeZone:onPlayerInOut(function(isPointInside, point)
                        if isPointInside then
                            local identifier = home.identifier
                            local data = GetHomeObject(identifier)
                            inZone = true
                            WardrobePrompt(data, identifier)
                        else
                            HelpText(false)
                            inZone = false
                        end
                    end)
                end
                if not Config.furnitureStorage and home.storage and home.storage.x then
                    Homes[home.identifier].storageZone = BoxZone:Create(
                        vec3(home.storage.x, home.storage.y, home.storage.z), 1.5, 1.5, {
                            name = "storage-" .. home.identifier,
                            heading = home.storage.w,
                            debugPoly = Config.debug,
                            minZ = home.storage.z - 1.0,
                            maxZ = home.storage.z + 1.5
                        })
                    if Config.EnableMarkers.enable then
                        CreateThread(function()
                            while true do
                                local sleep = 500
                                local pedCoords = GetEntityCoords(PlayerPedId())
                                local dist = #(pedCoords - vec3(home.storage.x, home.storage.y, home.storage.z))
                                if dist < 3.0 then
                                    sleep = 0
                                    DrawMarker(Config.EnableMarkers.type,
                                        vec3(home.storage.x, home.storage.y, home.storage.z),
                                        0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.EnableMarkers.size.x,
                                        Config.EnableMarkers.size.y, Config.EnableMarkers.size.z,
                                        Config.EnableMarkers.color.r, Config.EnableMarkers.color.g,
                                        Config.EnableMarkers.color.b, 100, false, true, 2, false, false, false, false)
                                end
                                Wait(sleep)
                            end
                        end)
                    end
                    Homes[home.identifier].storageZone:onPlayerInOut(function(isPointInside, point)
                        if isPointInside then
                            local identifier = home.identifier
                            local data = GetHomeObject(identifier)
                            inZone = true
                            StoragePrompt(data)
                        else
                            HelpText(false)
                            inZone = false
                        end
                    end)
                end
                if home.managehouse.x then
                    Homes[home.identifier].managehouseZone = BoxZone:Create(
                        vec3(home.managehouse.x, home.managehouse.y, home.managehouse.z), 1.5, 1.5, {
                            name = "managehouse-" .. home.identifier,
                            heading = home.managehouse.w,
                            debugPoly = Config.debug,
                            minZ = home.managehouse.z - 1.0,
                            maxZ = home.managehouse.z + 1.5
                        })
                    if Config.EnableMarkers.enable then
                        CreateThread(function()
                            while true do
                                local sleep = 500
                                local pedCoords = GetEntityCoords(PlayerPedId())
                                local dist = #(pedCoords - vec3(home.managehouse.x, home.managehouse.y, home.managehouse.z))
                                if dist < 3.0 then
                                    sleep = 0
                                    DrawMarker(Config.EnableMarkers.type,
                                        vec3(home.managehouse.x, home.managehouse.y, home.managehouse.z), 0.0, 0.0, 0.0,
                                        0,
                                        0.0, 0.0, Config.EnableMarkers.size.x, Config.EnableMarkers.size.y,
                                        Config.EnableMarkers.size.z, Config.EnableMarkers.color.r,
                                        Config.EnableMarkers.color.g, Config.EnableMarkers.color.b, 100, false, true,
                                        2, false, false, false, false)
                                end
                                Wait(sleep)
                            end
                        end)
                    end
                    Homes[home.identifier].managehouseZone:onPlayerInOut(function(isPointInside, point)
                        if isPointInside then
                            local identifier = home.identifier
                            local data = GetHomeObject(identifier)
                            inZone = true
                            ManageHousePrompt(data, identifier)
                        else
                            HelpText(false)
                            inZone = false
                        end
                    end)
                end
                Homes[home.identifier].polyzone = PolyZone:Create(home.points, {
                    name = home.name,
                    minZ = home.minZ,
                    maxZ = home.maxZ,
                    debugGrid = Config.debug,
                    gridDivisions = 25
                })
                Homes[home.identifier].spawnedObjects = {}
                Homes[home.identifier].polyzone:onPlayerInOut(function(isPointInside, point)
                    if isPointInside then
                        inside = true
                        Home = Homes[home.identifier]
                        SpawnFurnitures(home.identifier)
                        debugPrint('[MLOPolyzone]', 'Player is inside MLO of ' .. home.name)
                    else
                        DeleteFurnitures(home.identifier)
                        Home = {}
                        inside = false
                        debugPrint('[MLOPolyzone]', 'Player is outside MLO of ' .. home.name)
                    end
                end)
            else
                if next(home.frontyard) then
                    Homes[home.identifier].frontyardZone = PolyZone:Create(home.frontyard.points, {
                        name = home.identifier .. '-frontyard',
                        minZ = home.frontyard.minZ,
                        maxZ = home.frontyard.maxZ,
                        debugGrid = Config.debug,
                        gridDivisions = 25
                    })
                    Homes[home.identifier].frontyardZone:onPlayerInOut(function(isPointInside, point)
                        if isPointInside then
                            if not inside then
                                Home = GetHomeObject(home.identifier)
                                debugPrint('[frontyardZone]', 'inside frontyard')
                                SpawnFurnitures(home.identifier, true)
                            end
                        else
                            if not inside and Home.identifier == home.identifier then
                                Home = {}
                                debugPrint('[frontyardZone]', 'not inside frontyard')
                                DeleteFurnitures(home.identifier, true)
                            end
                        end
                    end)
                    Homes[home.identifier].frontyardObjects = {}
                end
            end
            while not PlayerData or (PlayerData and (Config.framework == 'ESX' and PlayerData.identifier or PlayerData.citizenid) == nil) do
                Wait(100)
            end
            if not home.owner then
                local data = table.clone(Config.Blips.house_sell)
                data.coords = home.entry
                if data.enable then
                    createBlip(home.identifier .. '_sell', data)
                end
            elseif PlayerData and hasKey(home.identifier, Config.framework == "ESX" and PlayerData.identifier or PlayerData.citizenid) then
                local data = table.clone(Config.Blips.owned_house)
                data.coords = home.entry
                data.label = home.name
                if data.enable then
                    createBlip(home.identifier .. '_owned', data)
                end
            end
        end
    end
end

RegisterNetEvent('Housing:loadHome', function(home)
    LoadHome(home)
end)

RegisterNetEvent('Housing:loadHomes', function(homes)
    debugPrint('[init:loadHomes]', 'Loading home')
    for k, v in pairs(homes) do
        LoadHome(v)
    end
end)
