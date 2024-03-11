fx_version 'cerulean'
game 'gta5'
author 'Dmo'
description 'FiorBostonHood'
version '1.0.0'
lua54 'yes'
this_is_a_map 'yes'

file 'stream/cartelli.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/cartelli.ytyp'

file 'stream/nuova_terra.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/nuova_terra.ytyp'

file 'stream/scala_est.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/scala_est.ytyp'

file 'stream/ter_vf.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ter_vf.ytyp'

file 'stream/vvf_ytyp.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/vvf_ytyp.ytyp'

file 'stream/fiorbostoncourt.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/fiorbostoncourt.ytyp'

file 'stream/bosttosn.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/bosttosn.ytyp'

file 'stream/fiorpark.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/fiorpark.ytyp'

file 'stream/bosttoon.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/bosttoon.ytyp'

server_scripts {
    'version_check.lua',
}

escrow_ignore {
    'stream/**/*.ytd',
}
dependency '/assetpacks'
dependency '/assetpacks'