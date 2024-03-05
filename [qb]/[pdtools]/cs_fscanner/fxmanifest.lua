fx_version 'adamant'
version '1.2'
game 'gta5'
author 'CodeStudio: https://discord.gg/ESwSKregtt'
description 'Code Studio Fingerprint Scanner'

ui_page 'ui/index.html'


client_script 'main/client.lua'
server_scripts {'@oxmysql/lib/MySQL.lua', 'main/server.lua', 'config/open.lua'}
shared_scripts {'config/shared.lua', 'main/function.lua'}


files {
	'ui/**',
}

escrow_ignore {'config/*.lua'}

lua54 'yes'

dependency '/assetpacks'