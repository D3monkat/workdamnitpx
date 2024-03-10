fx_version 'cerulean'
game 		'gta5'
lua54 		'yes'
version      '2.11.1'

author	'Baguscodestudio'
description 'FiveM Housing script with complete feature'

this_is_a_map 'yes'

ui_page 'html/index.html'

files {
	"stream/starter_shells_k4mb1.ytyp",
	-- "stream/shellprops.ytyp",
	-- "stream/shellpropsv4.ytyp",
	-- "stream/shellpropv2s.ytyp",
	-- "stream/shellpropsv5.ytyp",
	-- "stream/shellprops.ytyp",
	-- "stream/shellpropsv7.ytyp",
	-- "stream/shellpropsv8.ytyp",
	-- "stream/shellpropsv10.ytyp",
	-- "stream/shellpropsv9.ytyp",
	"interiorproxies.meta",
	'html/index.html',
	'html/**/*'
}

data_file 'DLC_ITYP_REQUEST' 'starter_shells_k4mb1.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellprops.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellpropsv5.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellpropsv2.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellpropsv4.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellpropsv3.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellpropsv7.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellpropsv8.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellpropsv10.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'shellpropsv9.ytyp'

data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

shared_scripts {
	'data/locale.lua',
	'@ox_lib/init.lua',	
	'utils.lua'
}

client_scripts {
	'@PolyZone/client.lua',
  	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
    '@menuv/menuv.lua',
	'config/*.lua',
	'data/furniture.lua',
	'client/framework/*.lua',
	'client/freecam/utils.lua',
	'client/freecam/config.lua',
	'client/freecam/camera.lua',
	'client/freecam/exports.lua',
	'client/freecam/main.lua',
	'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'config/*.lua',
	'config/server/*.lua',
	'data/furniture.lua',
	'server/framework/*.lua',
	'server/*.lua'
}

dependencies {
	'oxmysql',
	'PolyZone',
}

escrow_ignore {
	'utils.lua',
	'config/*.lua',
	'config/server/*.lua',
	'stream/*.ytd',
	'stream/*.ydr',
	'stream/*.ymf',
	'stream/*.ytyp',
	'stream/*.ymap',
	'data/*.lua',
	'client/**/*.lua',
	'server/framework/*.lua',
	'server/editable.lua',
	'server/export.lua',
	'server/job.lua',
	'interiorproxies.meta'
}
dependency '/assetpacks'