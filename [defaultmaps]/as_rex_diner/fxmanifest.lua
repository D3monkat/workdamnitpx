fx_version 'cerulean'
games { 'gta5' }

author 'AS MLO - Azzox X Swarex'
description 'AS MLO Rex Diner & Al\'s Garage'
version '1.2'
lua54 'yes'
this_is_a_map 'yes'

client_script 'staticEmitter.lua'

file "staticEmitter.lua"

escrow_ignore {
    'stream/**/*.ytd',
    'stream/**/*.ymap',
    'stream/**/*.ytyp'
}
dependency '/assetpacks'