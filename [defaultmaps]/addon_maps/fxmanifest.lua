fx_version 'adamant'
game 'gta5'

client_script 'client.lua'
-- client_script 'island.lua'
file "interiorproxies.meta"
data_file "INTERIOR_PROXY_ORDER_FILE" "interiorproxies.meta"



--druglabs
data_file 'DLC_ITYP_REQUEST' 'stream/druglabs/cocaine_boat/patoche_thug1.ytyp'

--housing_shells
file {
    'stream/housing_shells/shellprops.ytyp',
    'stream/housing_shells/shellpropsv2.ytyp',
    'stream/housing_shells/shellpropsv9.ytyp',
    'stream/housing_shells/shellpropsv10.ytyp',
    'stream/housing_shells/shellpropsv12.ytyp',
    'stream/housing_shells/playerhouse_hotel.ytyp',
    'stream/housing_shells/playerhouse_hotel.ytyp',
    'stream/housing_shells/playerhouse_tier3.ytyp',
    'stream/housing_shells/shellpropsv8.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/shellprops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/shellpropsv2.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/shellpropsv9.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/shellpropsv10.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/shellpropsv12.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/v_int_20.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/playerhouse_hotel.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/playerhouse_tier1.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/playerhouse_tier3.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/housing_shells/shellpropsv8.ytyp'

--laundry
data_file 'TIMECYCLEMOD_FILE' 'laun_timecycle_mods_1.xml'
data_file 'AUDIO_GAMEDATA' 'audio/dps_v_laund_game.dat'
data_file 'AUDIO_DYNAMIXDATA' 'audio/dps_v_laund_mix.dat'

files {
	'laun_timecycle_mods_1.xml',
	'audio/dps_v_laund_game.dat151.rel',
	'audio/dps_v_laund_mix.dat15.rel',
}

--minigolf_map
data_file 'DLC_ITYP_REQUEST' 'stream/minigolf_map/minigolf_patoche_list.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/minigolf_map/patoche_minigolf_out.ytyp'

--mlo_dealership
file 'stream/mlo_dealership/vg_aston/vg_aston.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/mlo_dealership/vg_aston/vg_aston.ytyp'

--motel_shells
--files {
--	'stream/motel_shells/playerhouse_hotel/playerhouse_hotel.ytyp',
--	'stream/motel_shells/playerhouse_appartment_motel/playerhouse_appartment_motel.ytyp',
--	'stream/motel_shells/pinkcage/gabz_pinkcage.ytyp'
--}
--data_file 'DLC_ITYP_REQUEST' 'stream/motel_shells/v_int_20.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/motel_shells/playerhouse_hotel/playerhouse_hotel.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/motel_shells/playerhouse_appartment_motel/playerhouse_appartment_motel.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/motel_shells/pinkcage/gabz_pinkcage.ytyp'

--mrpd
--data_file 'TIMECYCLEMOD_FILE' 'gabz_mrpd_timecycle.xml'
-- data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
--files {
--	'gabz_mrpd_timecycle.xml',
	-- 'interiorproxies.meta'
--}
--client_script {
--    "gabz_mrpd_entitysets.lua"
--}

--pacificbank
files {
    'stream/pacificbank/k4mb1_ornate_bank.ytyp'
}
data_file 'DLC_ITYP_REQUEST' 'stream/pacificbank/k4mb1_ornate_bank.ytyp'


--mcd
--data_file 'DLC_ITYP_REQUEST' 'stream/mcd/ch_dlc_int_02_ch.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/mcd/mcd2'
--data_file 'DLC_ITYP_REQUEST' 'stream/mcd/ch_prop_ch_casino_backarea.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/mcd/ch_prop_ch_casino_main.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/mcd/ch_prop_ch_casino_vault.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/mcd/h4_dlc_int_05_h4.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/mcd/h4_prop_h4_island_02.ytyp'

--cayo_perico
-- data_file 'DLC_ITYP_REQUEST' 'stream/cayo_perico/int_cayo_props.ytyp'
-- data_file 'DLC_ITYP_REQUEST' 'stream/cayo_perico/med/int_cayo_med_props.ytyp'

-- data_file "SCALEFORM_DLC_FILE" "stream/cayo_perico/cpminimap/int3232302352.gfx"

-- files {
--     "stream/cayo_perico/cpminimap/int3232302352.gfx",
-- }

--mansions
files {
    'stream/mansions/modern_mansion2/kambi_modern.ytyp'
}
data_file 'DLC_ITYP_REQUEST' 'stream/mansions/modern_mansion2/kambi_modernhouse.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/mansions/vineyard_mansion2/fv_props.ytyp'

--houses
data_file 'DLC_ITYP_REQUEST' 'stream/houses/mirrorpark_houses/vg_cc_props.ytyp'

--davispd
data_file "TIMECYCLEMOD_FILE" "gabz_timecycle_mods1.xml"
files {"gabz_timecycle_mods1.xml"}
client_script {"gabz_entityset_mods1.lua"}