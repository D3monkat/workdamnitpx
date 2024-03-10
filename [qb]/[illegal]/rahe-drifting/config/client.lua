clConfig = {
    -- The distance from which players see the 3D text and can press a key to join
    joinProximity = 60,

    -- The keybind which players have to press to join a race
    joinKeybind = 51,

    -- Radius of the invisible 3D checkpoints, meters. Set to 0.0 if you don't wish to use floating arrows. The bigger this value, the bigger the arrows.
    checkpointRadius = 5.0,

    -- Checkpoint proximity, meters
    checkpointProximity = 25.0,

    -- Height of 3D checkpoints, meters
    checkpointHeight = 0.0,

    -- Color of the point blips (when drifting, when creating a track). By default - 7 (purple)
    checkpointBlipColor = 7,

    -- Color of the GPS route (when drifting). By default - 7 (purple)
    routeColor = 7,

    -- The minimum length that a track should be (in meters).
    minimumTrackLength = 100,

    -- The distance from which track objects are created
    objectRenderDistance = 300,

    -- If a sound should be played when a player drives through a checkpoint.
    checkpointSoundEnabled = true,

    -- If a sound should be played when player finishes a race.
    finishSoundEnabled = true,

    -- Track creation keybinds - https://docs.fivem.net/docs/game-references/controls/
    -- The key to place points (default 38 (E))
    pointPlacingKey = 38,

    -- The key to delete objects / points (default L CTRL (36))
    pointAndObjectDeletingKey = 36,

    -- The key combination to place objects (default Shift + pointPlacingKey (21, 38))
    objectPlacingFirstKey = 21,

    -- The key to increase object distance (default Arrow Up, 172)
    objectDistanceIncreaseKey = 172,

    -- The key to decrease object distance (default Arrow Down, 173)
    objectDistanceDecreaseKey = 173,

    -- The first key to rotate object (default Arrow Left, 174)
    objectRotationFirstKey = 174,

    -- The second key to rotate object (default Arrow Left, 175)
    objectRotationSecondKey = 175,

    -- The key to change the selected object (default CAPS, 171)
    objectChangingKey = 171,

    -- Font of the floating 3D text at race starts. Used with SetTextFont
    textFont = 4,

    -- The objects which players can use when creating a track.
    placeableObjectNames = { "prop_offroad_tyres02", "prop_offroad_tyres01_tu", "ba_prop_battle_barrier_02a", "xs_prop_barrier_5m_01a", "prop_barrier_wat_03b", "prop_air_barrier", "prop_tri_start_banner", "prop_tri_finish_banner", "prop_beachflag_01", "prop_beachflag_02", "prop_golfflag", "prop_air_conelight", "bkr_int_02_barrel_rack_02", "ar_prop_ar_cp_tower_01a", "stt_prop_race_gantry_01"}
}