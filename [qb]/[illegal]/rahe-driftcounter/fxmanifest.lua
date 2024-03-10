--[[ FX Information ]]--
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

--[[ Resource Information ]]--
name 'rahe-driftcounter'
author 'RAHE Development'
description 'RAHE Driftcounter'
version '1.0.0'

--[[ Manifest ]]--
dependencies {
    '/server:5181',
    '/onesync',
}

ui_page 'client/index.html'

files {
    'client/tailwind.css',
    'client/alpine.js',
    'client/index.html',
    'client/drifticon.png'
}

shared_scripts {
    "config/shared.lua",
}

client_scripts {
    "client/*.lua",
}

escrow_ignore {
    'client/*.lua',
    'config/*.lua'
}

dependency '/assetpacks'