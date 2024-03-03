fx_version 'cerulean'
game 'gta5'

files {
    'data/*.meta'
}

author 'TRClassic'

description 'Vehicle Data'

version '1.0'

client_scripts {
    'client.lua',
    'veh_names.lua'
}


escrow_ignore {
    'stream/*.ytd',
    'veh_names'
}

server_script 'veh_data.lua'

lua54 'yes'
dependency '/assetpacks'