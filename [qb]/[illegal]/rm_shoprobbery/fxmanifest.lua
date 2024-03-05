fx_version 'cerulean'
games { 'rdr3', 'gta5' }

lua54 'yes'

shared_scripts {
    'config.lua'
}

server_scripts {
    -- '@mysql-async/lib/MySQL.lua',
    'editable_webhook.lua',
	'server.lua'
}

client_scripts {
    'editable_functions.lua',
	'client.lua',
    'safecrack.lua'
}

escrow_ignore {
    '[items]',
    'config.lua',
    'editable_functions.lua',
    'editable_webhook.lua',
    'server.lua',
}
dependency '/assetpacks'