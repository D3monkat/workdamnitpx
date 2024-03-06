fx_version 'cerulean'
games { 'gta5' }

author 'AS MLO'
description 'AS MLO MapData'
replace_level_meta 'gta5'
this_is_a_map 'yes'

file "sp_manifest.ymt"
file "gta5.meta"
file "as_doortuning.ymt"

data_file "SCENARIO_POINTS_OVERRIDE_PSO_FILE" "sp_manifest.ymt"

escrow_ignore {
    'stream/**/*.ymap',
    'stream/**/*.ybn'
}

dependency '/assetpacks'