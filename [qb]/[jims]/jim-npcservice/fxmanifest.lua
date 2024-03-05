name "Jim-NPCService"
author "Jimathy"
version "1.0"
description "NPC Service Script By Jimathy"
fx_version "cerulean"
game "gta5"
lua54 'yes'

shared_scripts { 'config.lua', 'shared/*.lua', 'locales/*.lua' }
server_scripts { 'server.lua', }
client_scripts { 'client/*.lua' }

--client_script '@warmenu/warmenu.lua'

shared_script '@ox_lib/init.lua'

escrow_ignore {
	'*.lua',
	'client/*.lua',
	'locales/*.lua',
	'shared/blips.lua', 'shared/destinations.lua'
}

shared_script '@es_extended/imports.lua'
dependency '/assetpacks'