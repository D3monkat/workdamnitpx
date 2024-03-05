fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lionh34rt#4305'
description 'Cayo Perico ecosystem for QBCore'
version '1.1'

dependencies {
    'qb-target',
    'PolyZone'
}

shared_script {
    'shared/sh_config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua',
    'server/sv_drugs.lua',
    'server/sv_radar.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    'client/cl_main.lua',
    'client/cl_drugs.lua',
    'client/cl_interactions.lua',
    'client/cl_radar.lua'
}
