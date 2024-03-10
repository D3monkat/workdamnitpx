function HelpText(show, message)
    if show then
        -- exports['ataUI']:openText('e', message, 'light', 'blue', 'blue')
        -- TriggerEvent('cd_drawtextui:ShowUI', 'show', message)
        lib.showTextUI(message)
        -- ESX.TextUI(message)
        -- exports['okokTextUI']:Open(message, 'lightblue', 'right')
        -- exports['qb-core']:DrawText(message)
        -- exports['bcs_hud']:displayHelp(message)
    else
        -- exports['ataUI']:closeText()
        -- TriggerEvent('cd_drawtextui:HideUI')
        lib.hideTextUI()
        -- ESX.HideUI()
        -- exports['okokTextUI']:Close()
        -- exports['qb-core']:HideText()
        -- exports['bcs_hud']:closeHelp()
    end
end

function Notify(title, message, type, duration)
    -- ===== QB uncomment below =====
    if type == 'info' or type == 'warning' then
        type = 'primary'
    end
    QBCore.Functions.Notify(message, type, duration)
    -- ===== QB uncomment above ======

    -- exports['ataUI']:Alert({
    --     Theme='dark',
    --     Type=type,
    --     title=title,
    --     msg=message,
    --     time=duration
    -- })
    -- exports['bcs_hud']:SendAlert(title, message, type, duration)
    -- exports['okokNotify']:Alert(title, message, duration, type)
    -- ESX.ShowNotification(message)
end

function debugPrint(...)
    if Config.debug then
        print(...)
    end
end

RegisterNetEvent('Housing:notify', Notify)

Config = {
    framework = 'QB', -- ESX or QB or custom
    target = false,
    debug = false,
    -- options are:
    -- ox_inventory
    -- qs-inventory
    -- qb-inventory
    -- lj-inventory
    -- core_inventory
    -- chezza
    Inventory = "ox_inventory",
    DefaultAccount = 'bank',   -- for buying house and furnitures
    DefaultSlots = 10,         -- Default slots for inventory
    SaveDoorsWhenSold = true,  -- When MLO is sold, should the door locks persist?
    AutoLock = false,          -- Auto lock doors when you exit a shell or ipl (if house is empty & person haskey)
    EnableLastProperty = true, -- When players logout inside a shell or IPL, they will login inside it
    LimitKeys = 4,             -- maximum amount of keys per house that can be duplicated
    LimitHouses = 0,           -- maximum amount of players owned houses, if 0 then no limit is placed
    exportname = {
        es_extended = "es_extended",
        qtarget = 'qtarget',
        qbtarget = 'qb-target',
        ox_target = 'ox_target'
    },
    useDataStore = false,         -- For ESX, saving wardrobe/outfit in esx_datastore
    furnitureStorage = true,      -- if false, use /setstorage to set the storage in your home
    sellFurniturePercentage = 50, -- Selling unused furniture for half price (50%)
    keybinds = {
        lockdoor = 'E'
    },
    AdminGroups = { -- admins can make houses
        'superadmin',
        'admin',
        'moderator'
    },
    EnableMarkers = {
        enable = false, -- enable marker (small decrease in performance)
        type = 20,      -- the marker type
        color = { r = 237, g = 170, b = 26 },
        size = { x = 1.0, y = 1.0, z = 1.0 },
    },
    creation = {
        MaxFrontyardDistance = 100, -- Maximum distance of the frontyard point from the entry point of the house
    },
    robbery = {
        enable = true,
        lockpickItem = 'lockpick',
        alertAfterFailed = 5,         -- Alert police after certain amount of times
        alertLockpick = true,         -- Alert owner and key owners when house is lockpicked
        alertNonOwnerEntering = true, -- Alert owner and key owners when non-owner enters the house
        storageLockpick = true,       -- Requires non owner to lockpick storage before accessing it
        storageRobbery = true,        -- Disable stash robbery or non owner to access it
        alertPolice = true,           -- Alert police if lockpick succeed
        minPolice = 0,                -- Minimum police to do a lockpick
        enableRaid = true,            -- Police raid
        offlineRobbery = false,       -- Enable robbery even if the owner of the house is offline
        policeName = {
            ['police'] = 2,
            ['bcso'] = 2
        }, -- Police job name and minimum grade
    },
    rent = {
        rentCheckTimer = 10 * 60,     -- Check Rent every 10 minute
        rentTimer = 1,                -- pay rent per day in example every 1 day
        paymentAccount = 'bank',      -- account for manual payment
        autoRemove = 2 * 7,           -- this will remove the rented home after 2 weeks of no payment
        autoPayment = true,           -- auto pay rent when the player joins
        autoPaymentAccount = 'bank',
        deleteAfterAutoRemove = false -- Deletes the home after being revoked from the player
    },
    mortgage = {
        checkTimer = 60 * 60,    -- Check mortgage every 1 hour
        weeks = 7,               -- Days,
        months = 30,             -- Days,
        paymentAccount = 'bank', -- account for manual payment
        autoPaymentAccount = 'bank',
        removeAfter = 7,         -- Days
        returnMoneyAfterRemoval = false,
        deleteAfterAutoRemove = false
    },
    locksmith = {
        enable = true,
        locations = {
            {
                coords = vector4(158.1572, 6654.481, 31.66717, 131.2029),
                ped = 's_m_y_dwservice_01',
                sprite = 255,
                colour = 44,
                scale = 1.0,
                label = 'Locksmith'
            },
            -- {
            --     coords = vector4(-81.9154, -1329.2770, 29.2796, 101.5406),
            --     ped = 's_m_y_dwservice_01',
            --     sprite = 255,
            --     colour = 44,
            --     scale = 1.0,
            --     label = 'Locksmith'
            -- }
        }

    },
    Blips = {
        house_sell = {
            enable = true,
            sprite = 350,
            colour = 43,
            scale = 0.5,
            label = 'House for Sale'
        },
        owned_house = {
            enable = true,
            sprite = 40,
            colour = 60,
            scale = 0.8,
        },
        owned_apartment = {
            enable = true,
            sprite = 475,
            colour = 47,
            scale = 0.8,
        },
        apartment_available = {
            enable = true,
            sprite = 475,
            colour = 2,
            scale = 0.8,
        },
        apartment_unavailable = {
            enable = true,
            sprite = 475,
            colour = 76,
            scale = 0.8,
        },
    },
    -- CREDITS TO ESX_PROPERTY V2
    CCTV = {
        HeightAboveDoor = 1.5, -- Height above the door to place the cctv camera
        FOV = 80.0,            -- Camera Field of View
        MaxLeftRotation = 80,
        MaxZoom = 30,
        MinZoom = 100,
        MaxRightRotation = -50,
        MaxUpRotation = 10,
        MaxDownRotation = -45,
        RotateSpeed = 0.3,    -- Camera Rotation Speed
        Controls = {
            Left = 34,        -- LEFT Arrow
            Right = 35,       -- RIGHT Arrow
            Screenshot = 201, -- ENTER
            NightVision = 38, -- E
            ZoomIn = 96,      -- UP Arrow
            ZoomOut = 97,     -- DOWN Arrow
            Up = 32,          -- UP Arrow
            Down = 33,        -- DOWN Arrow
            Exit = 194,       -- BACKSPACE
        }
    }
}

Config.SQLQueries = {}
