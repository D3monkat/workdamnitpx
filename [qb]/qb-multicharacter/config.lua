Config = {}
Config.StartingApartment = false -- Enable/disable starting apartments (make sure to set default spawn coords)
Config.Interior = vector3(-1094.41, -2760.14, 21.34) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(-1094.41, -2760.14, 21.34) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(-216.46, -1038.94, 30.14, 69.9) -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(-1086.62, -2794.07, 21.34, 346.44) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(-1080.65, -2812.77, 24.34, 150.76) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = true -- Define if the player can delete the character or not

Config.DefaultNumberOfCharacters = 5 -- min = 1 | max = 5
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}

Config.PedCords = {
    [1] = vector4(-1083.7, -2819.33, 25.37, 327.58),
    [2] = vector4(-1080.82, -2821.1, 25.37, 331.74),
    [3] = vector4(-1087.18, -2817.55, 25.37, 330.36),
    [4] = vector4(-1090.15, -2815.91, 25.37, 329.89),
    [5] = vector4(-1078.18, -2822.9, 25.37, 330.63),
}

Config.TrainCoord = {
    Heading = 268.7,
    Start = vector3(-523.14, -665.62, -9879.9),
    Stop = vector3(-498.32, -665.63, -68549.9),
}

Config.Clothing = {
    ['qb-clothing'] = false,
    ['fivem-appearance'] = false,
    ['illenium-appearance'] = true,
}

Config.Housing = { --New
    ['ps-housing'] = true, --https://github.com/Project-Sloth/ps-housing
    ['qb-houses'] = false,
}