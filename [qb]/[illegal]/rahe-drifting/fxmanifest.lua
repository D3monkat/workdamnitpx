fx_version 'cerulean'
game 'gta5'

lua54 'yes'
use_fxv2_oal 'yes'

author 'RAHE'
description 'RAHE Drifting system'
version '1.0.0'

export 'openDriftingTablet'
server_export 'openDriftingTablet'

client_scripts {
    'tablet/tabs/**/client.lua',
    'tablet/client.lua',

    'game/**/client.lua',

    'config/client.lua',
    'config/cl_translations.lua',
    'api/client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/server.lua',
    'config/sv_translations.lua',
    'tablet/tabs/**/server.lua',
    'tablet/server.lua',
    'tablet/tabs/leaderboard/ratings.js',
    'game/**/server.lua',
    'api/server.lua',
}

shared_scripts {
    'game/shared.lua',
    'config/shared.lua',
    '@ox_lib/init.lua',
}

ui_page 'tablet/nui/index.html'

files {
    'tablet/nui/index.html',
    'tablet/nui/style.css',
    'tablet/nui/tailwind.css',
    'tablet/nui/alpine.js',
    'tablet/nui/translations.js',
    'tablet/nui/translations_en.js',
    'tablet/nui/tailwind.css',
    'tablet/nui/img/track.png',
    'tablet/nui/img/background-frame.png',
    'tablet/nui/img/cloud-green.png',
    'tablet/nui/img/logo-green.png',
}

escrow_ignore {
    'api/client.lua',
    'api/server.lua',
    'config/*.lua',
}
dependency '/assetpacks'