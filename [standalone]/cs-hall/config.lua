config = {
    -- Set whether you want to be informed in your server's console about updates regarding this resource.
    ['updatesCheck'] = true,

    -- Enabling debug will draw lines useful for debugging, especially when creating a new config entry.
    ['debug'] = false,

    -- The DUI URL, by default loaded locally.
    ['duiUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/index.html',

    -- Strings through-out the resource to translate them if you wish.
    ['lang'] = {
        ['addToQueue'] = 'Add to Queue',
        ['bassSmoke'] = 'Bass Smoke',
        ['bassSparklers'] = 'Bass Sparklers',
        ['triggerSmoke'] = 'Trigger Smoke',
        ['triggerSparklers'] = 'Trigger Sparklers',
        ['whiteSpotlights'] = 'White Spotlights',
        ['dynamicSpotlights'] = 'Dynamic Spotlights',
        ['photorythmicSpotlights'] = 'Photorythmic Spotlights',
        ['videoToggle'] = 'Video Toggle',
        ['screenControl'] = 'Screen Control',
        ['remoteControl'] = 'Remote Control',
        ['play'] = 'Play',
        ['queueNow'] = 'Queue Now',
        ['queueNext'] = 'Queue Next',
        ['remove'] = 'Remove',
        ['pause'] = 'Pause',
        ['stop'] = 'Stop',
        ['skip'] = 'Skip',
        ['loop'] = 'Loop',
        ['volume'] = 'Volume',
        ['invalidUrl'] = 'URL invalid.',
        ['invalidYouTubeUrl'] = 'YouTube URL invalid.',
        ['invalidTwitchUrl'] = 'Twitch URL invalid.',
        ['urlPlaceholder'] = 'YouTube / Twitch URL',
        ['sourceError'] = 'Playable media error occured.',
        ['twitchChannelOffline'] = 'Twitch channel offline.',
        ['twitchVodSubOnly'] = 'Twitch video subs-only.',
        ['twitchError'] = 'Twitch error occured.',
        ['youtubeError'] = 'YouTube error occured.',
        ['sourceNotFound'] = 'Playable media not be found.',
        ['liveFeed'] = 'Live Feed',
        ['twitchClip'] = 'Twitch Clip',
        ['queueLimitReached'] = 'The queue has already too many entries.',
        ['scenes'] = 'Scenes',
        ['allUrlPlaceholder'] = 'URL',
        ['frame'] = 'Frame'
    },

    -- Loading related timeouts, default values should work in most servers.
    ['timeouts'] = {
        ['scaleformRequestMs'] = 30000,
        ['assetLoadMs'] = 30000,
        ['syncAssetLoadMs'] = 3000
    },

    -- Visit our Discord over at https://criticalscripts.shop/discord to get more entries and share yours too!

    ['entries'] = {
        -- Vanilla Unicorn
        -- If you are using the default Vanilla Unicorn or a similar variant of it, keep it enabled below.

        -- This entry does not require an extra map.


        ['tequilala'] = {
            ['enabled'] = true,

            ['idleWallpaperUrl'] = 'https://files.criticalscripts.shop/cs-hall-dui/wallpaper.png',

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['disableEmitters'] = {
                'se_dlc_biker_tequilala_exterior_emitter'
            },

            ['area'] = {
                ['range'] = 200.0,
                ['center'] = vector3(-553.06, 285.08, 82.18),

                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 75.18,
                                ['max'] = 91.79
                            },
        
                            ['points'] = {
                                vector2(-570.96, 279.91),
                                vector2(-552.28, 277.12),
                                vector2(-550.34, 277.07),
                                vector2(-548.56, 291.37),
                                vector2(-560.45, 293.28),
                                vector2(-560.78, 290.6),
                                vector2(-568.01, 291.47)
                            }
                        }
                    }
                }
            },

            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector'
            },

            ['monitors'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_screen_02',
                    ['position'] = vector3(-572.21, 294.10, 79.70),
                    ['heading'] = 356.30
                },

                {
                    ['hash'] = 'ba_prop_battle_club_screen_02',
                    ['position'] = vector3(-558.11, 285.67, 84.60),
                    ['heading'] = 84.70
                }
            },

            ['screens'] = {
                {
                    ['hash'] = 'h4_prop_battle_club_screen',
                    ['position'] = vector3(-549.84, 284.85, 86.94),
                    ['heading'] = 266.22,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(-549.84, 284.85, 85.20)
                    },
                },

                {
                    ['hash'] = 'prop_strip_pole_01',
                    ['position'] = vector3(-549.84, 284.85, 86.94),
                    ['heading'] = 258.49,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(-549.84, 284.85, 85.20)
                    }
                }
            },

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-554.56, 288.39, 86.38),
                    ['heading'] = 360.0,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-554.74, 281.89, 86.38),
                    ['heading'] = 160.0,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-555.58, 284.96, 86.50),
                    ['heading'] = 80.0,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-552.73, 282.02, 86.90),
                    ['heading'] = 169.0,
                    ['color'] = {15, 3, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-551.95, 288.52, 86.40),
                    ['heading'] = 359.0,
                    ['color'] = {255, 5, 190}
                }
            },

            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(-552.43, 289.95, 81.15),
                    ['heading'] = 326.78,
                    ['color'] = {255, 0, 255}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(-550.12, 280.04, 82),
                    ['heading'] = 223.54,
                    ['color'] = {255, 0, 255}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(-552.6, 280.55, 82),
                    ['heading'] = 216.92,
                    ['color'] = {255, 0, 255}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(-556.5, 280, 81.15),
                    ['heading'] = 174.18,
                    ['color'] = {255, 0, 255}
                }
            },

            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(-552.19, 288.47, 82),
                    ['heading'] = 0.0,
                    ['color'] = {175, 0, 175}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(-552.79, 280.17, 82),
                    ['heading'] = 0.0,
                    ['color'] = {175, 0, 175}
                }
            },

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-554.61, 283.21, 82.18),
                    ['heading'] = 98.22,
                    ['soundOffset'] = vector3(0, 0, 1.4)
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-555.75, 290.27, 82.18),
                    ['heading'] = 129.74,
                    ['soundOffset'] = vector3(0, 0, 1.4)
                }
            }
        },

        
--  Party kawaii
    ['party_kawaii_universestore'] = {
        ['enabled'] = true,
        ['permissions'] = false,
        ['autoAdjustTime'] = false,
        ['idleWallpaperUrl'] = 'https://as1.ftcdn.net/v2/jpg/05/59/26/68/1000_F_559266834_5AB7JDKaGhnjdPZ5ogBKmU3NHk0kidpk.jpg',
        ['maxVolumePercent'] = 150,
    
    
        ['area'] = {
            ['range'] = 200.0,
            ['center'] = vector3(-606.2399, 107.1919, 72.26459),
            ['height'] = nil,
            ['polygons'] = nil
        },
    
        ['disableEmitters'] = nil,
    
        ['scaleform'] = nil,
        ['replacers'] = {
            ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
            ['h4_prop_battle_club_projector'] = 'script_rt_club_projector'
        },
        
        ['monitors'] = nil,   
        ['screens'] = nil,
        ['spotlights'] = nil,
            
        ['bass']  =  {
         ['smoke'] = {
                ['cooldownMs'] = 30000,
                ['colorWithDynamicSpotlights'] = true
            },
         ['sparklers'] = {
                ['cooldownMs'] = 30000,
                ['colorWithDynamicSpotlights'] = true
            },
            
        },
        ['spotlights'] = {
                           {  --1
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-606.2221, 110.3594, 68.21099),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 140.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },
    
                {  ---2
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-606.2221, 107.2057, 68.21099),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },
    
                { ---3
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-606.2221, 103.8119, 68.21099),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },
    
                {  --- 4
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-606.2221, 110.3594, 72.41982),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 30.0,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },
                {  --5
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-606.2221, 107.2057, 72.41982),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },
    
                {  ---6
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-606.2221, 103.8119, 72.41982),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },
    
                { ---7
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-601.7, 107.1337, 68.35337),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },
    
                {  --- 8
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-601.7477, 102.6589, 68.35337),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 30.0,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },
                {  --9
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-601.8414, 98.29521, 68.35337),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },
    
                {  ---10
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-601.9572, 93.80285, 68.35337),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },
    
                { ---11
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(-601.9572, 89.26273, 68.35337),
                    ['rotation'] = vector3(0.0,  0, -90.0),
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },
    
    
                
            },
    
         ['smokers'] = {
             {
                 ['hash'] = 'ba_prop_club_smoke_machine',
                 ['visible'] = true,
    
                 ['fx'] = {
                     ['library'] = 'scr_ba_club',
                     ['effect'] = 'scr_ba_club_smoke_machine',
                 },
    
                 ['position'] = vector3(-606.6436, 104.0199, 63.55949),
                 ['rotation'] = vector3(0.0, 0.0, -90),
                 ['heading'] = 90.0,
                 ['color'] = {253, 122, 255}
             },
                          {
                 ['hash'] = 'ba_prop_club_smoke_machine',
                 ['visible'] = true,
    
                 ['fx'] = {
                     ['library'] = 'scr_ba_club',
                     ['effect'] = 'scr_ba_club_smoke_machine',
                 },
    
                 ['position'] = vector3(-606.6436, 110.3185, 63.55949),
                 ['rotation'] = vector3(0.0, 0.0, -90),
                 ['heading'] = 90.0,
                 ['color'] = {253, 122, 255}
             }
                      
         },
    
          ['sparklers'] = {
              { --1
                  ['hash'] = 'prop_cs_pour_tube',
                  ['visible'] = true,
    
                  ['fx'] = {
                     ['library'] = 'scr_ih_club',
                     ['effect'] = 'scr_ih_club_sparkler',
                 },
    
                  ['position'] = vector3(-609.2957, 103.6496, 63.44432),
                  ['rotation'] = nil,
                  ['heading'] = 0.0,
                  ['lodDistance'] = nil,
                  ['color'] = {90, 173, 22}
              },
              { --2
                  ['hash'] = 'prop_cs_pour_tube',
                  ['visible'] = true,
    
                  ['fx'] = {
                     ['library'] = 'scr_ih_club',
                     ['effect'] = 'scr_ih_club_sparkler',
                 },
    
                  ['position'] = vector3(-609.2957, 110.5706, 63.44432),
                  ['rotation'] = nil,
                  ['heading'] = 0.0,
                  ['lodDistance'] = nil,
                  ['color'] = {90, 173, 22}
              },
              { --3
                  ['hash'] = 'prop_cs_pour_tube',
                  ['visible'] = true,
    
                  ['fx'] = {
                     ['library'] = 'scr_ih_club',
                     ['effect'] = 'scr_ih_club_sparkler',
                 },
    
                  ['position'] = vector3(-609.2957, 109.2633, 63.44432),
                  ['rotation'] = nil,
                  ['heading'] = 0.0,
                  ['lodDistance'] = nil,
                  ['color'] = {90, 173, 22}
              },
              { --4
                  ['hash'] = 'prop_cs_pour_tube',
                  ['visible'] = true,
    
                  ['fx'] = {
                     ['library'] = 'scr_ih_club',
                     ['effect'] = 'scr_ih_club_sparkler',
                 },
    
                  ['position'] = vector3(-609.2957, 105.0706, 63.44432),
                  ['rotation'] = nil,
                  ['heading'] = 0.0,
                  ['lodDistance'] = nil,
                  ['color'] = {90, 173, 22}
              },
              { --5
                  ['hash'] = 'prop_cs_pour_tube',
                  ['visible'] = true,
    
                  ['fx'] = {
                     ['library'] = 'scr_ih_club',
                     ['effect'] = 'scr_ih_club_sparkler',
                 },
    
                  ['position'] = vector3(-609.2957, 106.3649, 63.44432),
                  ['rotation'] = nil,
                  ['heading'] = 0.0,
                  ['lodDistance'] = nil,
                  ['color'] = {90, 173, 22}
              },
              { --6
                  ['hash'] = 'prop_cs_pour_tube',
                  ['visible'] = true,
    
                  ['fx'] = {
                     ['library'] = 'scr_ih_club',
                     ['effect'] = 'scr_ih_club_sparkler',
                 },
    
                  ['position'] = vector3(-609.2957, 108.1087, 63.44432),
                  ['rotation'] = nil,
                  ['heading'] = 0.0,
                  ['lodDistance'] = nil,
                  ['color'] = {90, 173, 22}
              }, 	  
          },
           
    
        ['speakers'] = {
            {
                ['hash'] = 'xs_propintarena_speakers_01a',
                ['visible'] = false,
                ['position'] = vector3(-606.2221, 110.3594, 68.21099),
                ['rotation'] = nil,
                ['heading'] = 141.38,
                ['lodDistance'] = nil,
                ['soundOffset'] = nil,
                ['distanceOffset'] = nil,
                ['maxDistance'] = 110.0,
                ['refDistance'] = 55.0,
                ['rolloffFactor'] = 1.25,
                ['coneInnerAngle'] = 90,
                ['coneOuterAngle'] = 180,
                ['coneOuterGain'] = 0.5,
                ['fadeDurationMs'] = 250,
                ['volumeMultiplier'] = 2.0,
                ['lowPassGainReductionPercent'] = 15
            }
        },
    },
        
        ['fivedevs_vanilla_unicorn'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cdn.discordapp.com/attachments/1080187767511847045/1135839700729475082/Untitled_design.gif',
            ['maxVolumePercent'] = 100,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['area'] = {
                ['range'] = 128.0,
                ['center'] = vector3(103.64, -1292.14, 29.2),
                ['height'] = nil,

                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 27.0,
                                ['max'] = 32.0
                            },
        
                            ['points'] = {
                                vector2(139.37, -1286.14),
                                vector2(136.05, -1279.98),
                                vector2(133.24, -1275.47),
                                vector2(128.67, -1276.76),
                                vector2(121.51, -1278.23),
                                vector2(114.19, -1278.97),
                                vector2(110.07, -1280.59),
                                vector2(100.52, -1282.48),
                                vector2(101.44, -1285.23),
                                vector2(104.67, -1290.09),
                                vector2(114.25, -1305.41),
                                vector2(126.52, -1298.37),
                                vector2(124.38, -1295.31),
                                vector2(129.06, -1292.22)
                            }
                        }
                    }
                }
            },

            ['disableEmitters'] = {
                'LOS_SANTOS_VANILLA_UNICORN_01_STAGE',
                'LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM',
                'LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM'
            },

            ['scaleform'] = nil,

            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector'
            },

            ['monitors'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_screen_02',
                    ['position'] = vector3(109.34, -1296.68, 31.22),
                    ['rotation'] = nil,
                    ['heading'] = 120.39,
                    ['lodDistance'] = nil
                }
            },

            ['screens'] = {
                {
                    ['hash'] = 'h4_prop_battle_club_screen',
                    ['position'] = vector3(119.56, -1298.4, 32.53),
                    ['rotation'] = nil,
                    ['heading'] = 206.84,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(119.56, -1298.4, 33.53)
                    },
                },

                {
                    ['hash'] = 'prop_strip_pole_01',
                    ['position'] = vector3(103.27879333496, -1292.5457763672, 33.45863571167),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(103.27879333496, -1292.5457763672, 31.61610946655)
                    }
                }
            },

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(119.69, -1282.76, 32.90),
                    ['rotation'] = nil,
                    ['heading'] = 357.17,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(108.9, -1288.73, 32.90),
                    ['rotation'] = nil,
                    ['heading'] = 60.91,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(116.74, -1300.65, 32.90),
                    ['rotation'] = nil,
                    ['heading'] = 236.77,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(122.73, -1297.07, 32.90),
                    ['rotation'] = nil,
                    ['heading'] = 177.46,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(123.6, -1288.43, 32.10),
                    ['rotation'] = nil,
                    ['heading'] = 300.00,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 5, 190}
                }
            },

            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(110.45, -1298.54, 28.42),
                    ['rotation'] = nil,
                    ['heading'] = 283.82,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 0, 255}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(108.2, -1295.15, 28.42),
                    ['rotation'] = nil,
                    ['heading'] = 293.63,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 0, 255}
                }
            },

            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(118.94, -1290.43, 28.43),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(119.59, -1291.61, 28.43),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(113.61, -1293.45, 28.43),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(114.38, -1294.62, 28.43),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                }
            },

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(124.15, -1295.75, 28.52),
                    ['rotation'] = nil,
                    ['heading'] = 207.95,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 52.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(116.43, -1300.22, 28.52),
                    ['rotation'] = nil,
                    ['heading'] = 215.77,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                }
            }
        },



    ['parking_cinema_large'] = {
    ['enabled'] = true,
    ['autoAdjustTime'] = false,
    ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
    ['maxVolumePercent'] = 200,
    ['smokeFxMultiplier'] = 3,
    ['smokeTimeoutMs'] = 5000,
    ['sparklerFxMultiplier'] = 1,
    ['sparklerTimeoutMs'] = 1500,
    ['delayBetweenSmokeChainMs'] = 1500,
    ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
    ['featureDelayWithControllerInterfaceClosedMs'] = 500,

    ['bass'] = nil,

    ['area'] = {
        ['range'] = 128.0,
        ['center'] = vector3(-1708.77, -905.75, 14.07),
        ['height'] = nil,
        ['polygons'] = nil
    },

    ['disableEmitters'] = nil,

    ['scaleform'] = {
        ['solid'] = true,
        ['flag'] = false,
        ['position'] = vector3(-1700.55, -911.95, 18.35),
        ['rotation'] = vector3(0.0, 0.0, -140.35),
        ['scale'] = vector3(0.845, 0.455, 0.0)
    },

    ['replacers'] = nil,

    ['monitors'] = {
        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1708.0703, -906.0299, 10.112692),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1708.0703, -906.0239, 16.045633),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1713.1582, -901.8113, 10.112692),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1703.5819, -909.75867, 10.112692),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1713.1582, -901.8113, 16.045633),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1703.5796, -909.75867, 16.045633),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1708.4623, -905.87384, 15.529058),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1708.4103, -905.9194, 10.596061),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1713.2186, -901.93274, 15.529058),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1713.2185, -901.93225, 10.599154),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1704.3209, -909.3089, 15.529058),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1704.3209, -909.3089, 10.591772),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_billb_frame01a',
            ['position'] = vector3(-1702.4642, -912.5856, 6.7018266),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_billb_frame01a',
            ['position'] = vector3(-1716.6082, -900.8562, 6.7031603),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_billb_frame01a',
            ['position'] = vector3(-1709.3938, -906.8314, 6.6993837),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        }        
    },

    ['screens'] = nil,

    ['spotlights'] = {
        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1700.0432, -912.8055, 16.997484),
            ['rotation'] = vector3(79.81944, 39.95835, -168.51068),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {255, 255, 0}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1699.9872, -912.75525, 18.572235),
            ['rotation'] = vector3(-89.1767, 15.263356, 62.73788),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {15, 3, 255}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1717.0707, -898.5253, 16.99997),
            ['rotation'] = vector3(79.8196, 39.95832, 4.3027616),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {3, 83, 255}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1717.0271, -898.52234, 18.567598),
            ['rotation'] = vector3(-89.17813, 15.263419, -116.71412),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {255, 5, 190}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1708.5563, -905.6041, 19.142105),
            ['rotation'] = vector3(0.6012019, -179.44646, 145.56659),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {255, 1, 1}
        }
    },

    ['smokers'] = nil,
    ['sparklers'] = nil,

    ['speakers'] = {
        {
            ['hash'] = 'xs_propintarena_speakers_01a',
            ['visible'] = false,
            ['position'] = vector3(-1708.5303, -905.79474, 16.172209),
            ['rotation'] = vector3(-0.39775264,86.46773, 48.647858),
            ['heading'] = nil,
            ['lodDistance'] = nil,
            ['soundOffset'] = nil,
            ['distanceOffset'] = vector3(0.75, -0.66, 0),
            ['maxDistance'] = 32.0,
            ['refDistance'] = 16.0,
            ['rolloffFactor'] = 1.25,
            ['coneInnerAngle'] = 90,
            ['coneOuterAngle'] = 180,
            ['coneOuterGain'] = 0.5,
            ['fadeDurationMs'] = 250,
            ['volumeMultiplier'] = 1.0,
            ['lowPassGainReductionPercent'] = 15
        }
    }
},
        -- Beach Bar
        -- If you have the Cayo Perico island in your server and you want the beach bar setup, enable it below.

        ['beach_bar'] = {
            ['enabled'] = false,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 50,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = false
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = false
                }
            },

            ['area'] = {
                ['range'] = 128.0,
                ['center'] = vector3(4893.82, -4907.77, 3.3),
                ['height'] = nil,
                ['polygons'] = nil
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector'
            },

            ['monitors'] = {
                {
                    ['hash'] = 'h4_prop_battle_club_screen',
                    ['position'] = vector3(4893.3828125, -4906.6821289062, 8.1490092254639),
                    ['rotation'] = nil,
                    ['heading'] = 355.92108154297,
                    ['lodDistance'] = nil
                }
            },

            ['screens'] = nil,

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(4885.8608398438, -4918.0571289062, 6.9639296531677),
                    ['rotation'] = nil,
                    ['heading'] = 36.255199432373,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(4892.9873046875, -4933.119140625, 7.9055228233337),
                    ['rotation'] = nil,
                    ['heading'] = 199.39436340332,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(4898.630859375, -4928.7680664062, 7.9144740104675),
                    ['rotation'] = nil,
                    ['heading'] = 240.46636962891,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(4890.9223632812, -4933.2202148438, 7.3254413604736),
                    ['rotation'] = nil,
                    ['heading'] = 202.10606384277,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(4899.2270507812, -4926.7075195312, 7.2875466346741),
                    ['rotation'] = nil,
                    ['heading'] = 232.05226135254,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 5, 190}
                }
            },

            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(4891.4643554688, -4905.8627929688, 2.46),
                    ['rotation'] = nil,
                    ['heading'] = 348.95,
                    ['lodDistance'] = nil,
                    ['color'] = {248, 184, 120}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(4895.4653320312, -4905.94921875, 2.46),
                    ['rotation'] = nil,
                    ['heading'] = 6.36,
                    ['lodDistance'] = nil,
                    ['color'] = {248, 184, 120}
                }
            },

            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(4890.49, -4907.72, 2.355297088623),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {248, 184, 120}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(4896.49, -4908.14, 2.355297088623),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {248, 184, 120}
                }
            },

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(4890.46, -4906.92, 2.33),
                    ['rotation'] = nil,
                    ['heading'] = 2.99,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(4896.46, -4907.49, 2.33),
                    ['rotation'] = nil,
                    ['heading'] = 2.99,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                }
            }
        },

        -- Gabz's Vanilla Unicorn (https://www.youtube.com/watch?v=o9UV9tdLU30)
        -- If you have this interior enable it below, and disable the default "vanilla" entry.

        ['gabz_vanilla_unicorn'] = {
            ['enabled'] = false,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 50,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['area'] = {
                ['range'] = 128.0,
                ['center'] = vector3(103.64, -1292.14, 29.2),
                ['height'] = nil,

                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 27.0,
                                ['max'] = 32.0
                            },
        
                            ['points'] = {
                                vector2(119.42, -1299.34),
                                vector2(116.07, -1294.06),
                                vector2(114.62, -1292.96),
                                vector2(104.46, -1299.08),
                                vector2(97.68, -1287.27),
                                vector2(107.61, -1281.02),
                                vector2(119.01, -1279.61),
                                vector2(125.75, -1277.27),
                                vector2(128.81, -1276.93),
                                vector2(134.08, -1287.12),
                                vector2(130.99, -1289.47),
                                vector2(132.76, -1292.06),
                                vector2(134.37, -1294.44),
                                vector2(128.49, -1298.07),
                                vector2(124.62, -1300.01),
                                vector2(122.72, -1297.48)
                            }
                        }
                    }
                }
            },

            ['disableEmitters'] = {
                'LOS_SANTOS_VANILLA_UNICORN_01_STAGE',
                'LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM',
                'LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM'
            },

            ['scaleform'] = nil,

            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['h4_prop_battle_club_projector'] = 'script_rt_club_projector'
            },

            ['monitors'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_screen_02',
                    ['position'] = vector3(122.83245849609, -1282.1744384766, 30.500564575195),
                    ['rotation'] = nil,
                    ['heading'] = 209.32180786133,
                    ['lodDistance'] = nil
                }
            },

            ['screens'] = {
                {
                    ['hash'] = 'h4_prop_battle_club_screen',
                    ['position'] = vector3(103.27879333496, -1292.5457763672, 33.85863571167),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(103.27879333496, -1292.5457763672, 32.01610946655)
                    },
                },

                {
                    ['hash'] = 'prop_strip_pole_01',
                    ['position'] = vector3(103.27879333496, -1292.5457763672, 33.45863571167),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,

                    ['advance'] = {
                        ['durationMs'] = 15000,
                        ['position'] = vector3(103.27879333496, -1292.5457763672, 31.61610946655)
                    }
                }
            },

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(104.79130554199, -1291.6781005859, 32.583999633789),
                    ['rotation'] = nil,
                    ['heading'] = 120.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(108.38147735596, -1296.1878662109, 32.080726623535),
                    ['rotation'] = nil,
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(110.11848449707, -1295.0183105469, 32.080333709717),
                    ['rotation'] = nil,
                    ['heading'] = 210.0,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(102.0936050415, -1285.4376220703, 32.090923309326),
                    ['rotation'] = nil,
                    ['heading'] = 30.0,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(104.02025604248, -1284.3253173828, 32.090923309326),
                    ['rotation'] = nil,
                    ['heading'] = 30.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 5, 190}
                }
            },

            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(103.99552154541, -1296.3807373047, 28.256807327271),
                    ['rotation'] = nil,
                    ['heading'] = 141.53,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 0, 255}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(100.32069396973, -1289.9753417969, 28.256807327271),
                    ['rotation'] = nil,
                    ['heading'] = 97.29,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 0, 255}
                }
            },

            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(105.01, -1289.6500244141, 28.270687103271),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(106.60453033447, -1292.4583740234, 28.270687103271),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {175, 0, 175}
                }
            },

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(98.9, -1287.81, 27.24342918396),
                    ['rotation'] = nil,
                    ['heading'] = 98.22,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(104.78, -1297.79, 27.24342918396),
                    ['rotation'] = nil,
                    ['heading'] = 129.74,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 16.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                }
            }
        },

        -- Breze's Medusa Nightclub (https://www.youtube.com/watch?v=WkSDHNS9UDY)
        -- If you have this interior enable it below.

        ['breze_medusa_nightclub'] = {
            ['enabled'] = false,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 50,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = false
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = false
                }
            },

            ['area'] = {
                ['range'] = 128.0,
                ['center'] = vector3(745.37, -554.77, 28.65),
                ['height'] = nil,

                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 26.0,
                                ['max'] = 32.0
                            },
        
                            ['points'] = {
                                vector2(757.49, -535.57),
                                vector2(749.46, -535.36),
                                vector2(746.87, -536.82),
                                vector2(729.46, -572.98),
                                vector2(758.1, -586.28),
                                vector2(757.7, -545.72)
                            }
                        },
                        
                        {
                            ['height'] = {
                                ['min'] = 32.0,
                                ['max'] = 36.0
                            },
        
                            ['points'] = {
                                vector2(754.14, -569.86),
                                vector2(754.17, -574.41),
                                vector2(751.19, -577.98),
                                vector2(746.51, -578.33),
                                vector2(742.82, -575.05),
                                vector2(743.16, -570.34),
                                vector2(746.01, -567.21),
                                vector2(750.68, -567.06)
                            }
                        }
                    }
                }
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv'
            },

            ['monitors'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_screen_02',
                    ['position'] = vector3(738.32971191406, -554.88000488281, 30.901714324951),
                    ['rotation'] = nil,
                    ['heading'] = 64.16,
                    ['lodDistance'] = nil
                }
            },

            ['screens'] = nil,

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(738.67272949219, -555.03344726562, 32.444766998291),
                    ['rotation'] = nil,
                    ['heading'] = 71.46,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(756.40258789062, -548.21002197266, 32.436893463135),
                    ['rotation'] = nil,
                    ['heading'] = 271.3,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(756.66101074219, -561.20684814453, 32.434928894043),
                    ['rotation'] = nil,
                    ['heading'] = 271.3,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 5, 190}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(747.39, -561.07, 32.44),
                    ['rotation'] = nil,
                    ['heading'] = 96.2,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(747.38, -548.41, 32.44),
                    ['rotation'] = nil,
                    ['heading'] = 85.57,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                }
            },

            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(754.189453125, -558.76391601562, 27.639999389648),
                    ['rotation'] = nil,
                    ['heading'] = 299.15716552734,
                    ['lodDistance'] = nil,
                    ['color'] = {0, 255, 0}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(754.10021972656, -550.59643554688, 27.639999389648),
                    ['rotation'] = nil,
                    ['heading'] = 238.93334960938,
                    ['lodDistance'] = nil,
                    ['color'] = {0, 255, 0}
                }
            },

            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(753.32, -551.51, 27.647521972656),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {0, 255, 0}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,
    
                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(753.32, -557.85, 27.647521972656),
                    ['rotation'] = nil,
                    ['heading'] = 238.93334960938,
                    ['lodDistance'] = nil,
                    ['color'] = {0, 255, 0}
                }
            },

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(754.42, -557.88, 27.6),
                    ['rotation'] = nil,
                    ['heading'] = 274.2,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.7),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(754.26, -551.53, 27.6),
                    ['rotation'] = nil,
                    ['heading'] = 272.5,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.7),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 32.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 15
                }
            }
        },

        -- UncleJust's Vinewood Nightclub (https://www.youtube.com/watch?v=bwcH_KODvPI)
        -- If you have this interior enable it below.

        ['unclejust_vinewood_nightclub'] = {
            ['enabled'] = false,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 50,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },

                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },

            ['area'] = {
                ['range'] = 36.0,
                ['center'] = vector3(372.44, 276.53, 91.19),
                ['height'] = nil,

                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 90.0,
                                ['max'] = 93.0
                            },

                            ['points'] = {
                                vector2(346.24, 276.08),
                                vector2(349.61, 289.9),
                                vector2(381.23, 281.63),
                                vector2(377.56, 267.11),
                                vector2(350.76, 270.37),
                                vector2(350.36, 274.86)
                            }
                        },

                        {
                            ['height'] = {
                                ['min'] = 93.0,
                                ['max'] = 96.0
                            },

                            ['points'] = {
                                vector2(353.52, 272.84),
                                vector2(355.83, 278.45),
                                vector2(354.04, 279.21),
                                vector2(357.58, 288.01),
                                vector2(381.36, 281.72),
                                vector2(377.67, 267.05),
                                vector2(372.51, 268.12),
                                vector2(371.01, 262.22),
                                vector2(361.28, 264.88),
                                vector2(362.92, 270.56)
                            }
                        }
                    }
                }
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['ba_prop_battle_club_projector'] = 'script_rt_club_projector'
            },

            ['monitors'] = nil,
            ['screens'] = nil,

            ['spotlights'] = {
                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(363.42559814453, 276.72326660156, 92.779304504395),
                    ['rotation'] = nil,
                    ['heading'] = 76.13468170166,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 5, 190}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(364.55303955078, 280.58059692383, 92.794158935547),
                    ['rotation'] = nil,
                    ['heading'] = 75.477386474609,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 255, 0}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(365.38845825195, 273.95819091797, 92.779861450195),
                    ['rotation'] = nil,
                    ['heading'] = 158.18849182129,
                    ['lodDistance'] = nil,
                    ['color'] = {3, 83, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(369.53955078125, 272.80334472656, 92.794219970703),
                    ['rotation'] = nil,
                    ['heading'] = 148.77075195312,
                    ['lodDistance'] = nil,
                    ['color'] = {15, 3, 255}
                },

                {
                    ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
                    ['hash'] = 'cs_prop_hall_spotlight',
                    ['position'] = vector3(373.92681884766, 276.08227539062, 93.283363342285),
                    ['rotation'] = nil,
                    ['heading'] = 250.84906005859,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 1, 1}
                }
            },

            ['smokers'] = {
                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(361.63854980469, 275.40472412109, 90.170631408691),
                    ['rotation'] = nil,
                    ['heading'] = 88.489730834961,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 215, 0}
                },

                {
                    ['hash'] = 'ba_prop_club_smoke_machine',
                    ['visible'] = false,

                    ['fx'] = {
                        ['library'] = 'scr_ba_club',
                        ['effect'] = 'scr_ba_club_smoke_machine',
                    },

                    ['position'] = vector3(367.10723876953, 282.82067871094, 90.174537658691),
                    ['rotation'] = nil,
                    ['heading'] = 2.2324018478394,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 215, 0}
                }
            },

            ['sparklers'] = {
                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(373.81, 279.13, 90.178985595703),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 215, 0}
                },

                {
                    ['hash'] = 'prop_cs_pour_tube',
                    ['visible'] = true,

                    ['fx'] = {
                        ['library'] = 'scr_ih_club',
                        ['effect'] = 'scr_ih_club_sparkler',
                    },

                    ['position'] = vector3(372.41, 274.05, 90.178985595703),
                    ['rotation'] = nil,
                    ['heading'] = 0.0,
                    ['lodDistance'] = nil,
                    ['color'] = {255, 215, 0}
                }
            },

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_small',
                    ['visible'] = false,
                    ['position'] = vector3(374.18133544922, 279.08819580078, 90.181503295898),
                    ['rotation'] = nil,
                    ['heading'] = 263.55068969727,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_small',
                    ['visible'] = false,
                    ['position'] = vector3(372.68405151367, 273.84048461914, 90.180465698242),
                    ['rotation'] = nil,
                    ['heading'] = 257.89999389648,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                }
            }
        },


        ['bumper_cars'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 50,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = nil,

            ['area'] = {
                ['range'] = 36.0,
                ['center'] = vector3(-1655.34, -1053.53, 13.56),
                ['height'] = nil,

                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 12.0,
                                ['max'] = 18.0
                            },
        
                            ['points'] = {
                                vector2(-1664.1574707032, -1089.3540039062),
                                vector2(-1685.7916259766, -1071.241821289),
                                vector2(-1645.9460449218, -1024.1666259766),
                                vector2(-1624.4719238282, -1042.3699951172)
                            }
                        }
                    }
                }
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['v_ilev_cin_screen'] = 'script_rt_cinscreen'
            },

            ['monitors'] = nil,
            ['screens'] = nil,
            ['spotlights'] = nil,
            ['smokers'] = nil,
            ['sparklers'] = nil,

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_small',
                    ['visible'] = false,
                    ['position'] = vector3(-1624.64, -1042.37, 18.52),
                    ['rotation'] = nil,
                    ['heading'] = 95.00,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_small',
                    ['visible'] = false,
                    ['position'] = vector3(-1645.93, -1024.83, 18.58),
                    ['rotation'] = nil,
                    ['heading'] = 180.34,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_small',
                    ['visible'] = false,
                    ['position'] = vector3(-1684.7, -1070.75, 18.34),
                    ['rotation'] = nil,
                    ['heading'] = 280.34,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_small',
                    ['visible'] = false,
                    ['position'] = vector3(-1664.02, -1089.06, 18.59),
                    ['rotation'] = nil,
                    ['heading'] = 355.34,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },
            }
        },

        -- UncleJust's Vinewood Cinema (https://www.youtube.com/watch?v=ozpJeC7wv7k)
        -- If you have this interior enable it below.

        ['unclejust_vinewood_cinema'] = {
            ['enabled'] = false,
            ['autoAdjustTime'] = true,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 50,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,

            ['bass'] = nil,

            ['area'] = {
                ['range'] = 36.0,
                ['center'] = vector3(339.75, 193.22, 103.01),
                ['height'] = nil,

                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 98.0,
                                ['max'] = 118.0
                            },
        
                            ['points'] = {
                                vector2(326.45, 195.36),
                                vector2(338.11, 230.24),
                                vector2(362.55, 220.3),
                                vector2(350.45, 187.15),
                            }
                        }
                    }
                }
            },

            ['disableEmitters'] = nil,
            ['scaleform'] = nil,

            ['replacers'] = {
                ['v_ilev_cin_screen'] = 'script_rt_cinscreen'
            },

            ['monitors'] = nil,
            ['screens'] = nil,
            ['spotlights'] = nil,
            ['smokers'] = nil,
            ['sparklers'] = nil,

            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_small',
                    ['visible'] = false,
                    ['position'] = vector3(331.96, 195.93, 102.0),
                    ['rotation'] = nil,
                    ['heading'] = 154.93,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_small',
                    ['visible'] = false,
                    ['position'] = vector3(346.34, 190.79, 102.0),
                    ['rotation'] = nil,
                    ['heading'] = 177.34,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.4),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 28.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.5,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 1.0,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 90
                }
            }
        },

                ---------------------------------- F I V 3 D E V S - B A H A M A - M A M A ' S -------------------------------
['bahama_mamas'] = {
    ['enabled'] = true,
    ['autoAdjustTime'] = false,
    ['idleWallpaperUrl'] = 'https://i.imgur.com/caUFkXQ.png',
    ['maxVolumePercent'] = 200,
    ['smokeFxMultiplier'] = 50,
    ['smokeTimeoutMs'] = 5000,
    ['sparklerFxMultiplier'] = 2,
    ['sparklerTimeoutMs'] = 10000,
    ['delayBetweenSmokeChainMs'] = 1500,
    ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
    ['featureDelayWithControllerInterfaceClosedMs'] = 500,

    ['bass'] = {
        ['smoke'] = {
            ['cooldownMs'] = 30000,
            ['colorWithDynamicSpotlights'] = true
        },

        ['sparklers'] = {
            ['cooldownMs'] = 30000,
            ['colorWithDynamicSpotlights'] = true
        }
    },

    ['area'] = {
        ['range'] = 128.0,
        ['center'] = vector3(-1390.92, -616.56, 30.7),
        ['height'] = nil,

        ['polygons'] = {
            ['applyLowPassFilterOutside'] = true,
            ['invertLowPassApplication'] = false,
            ['hideReplacersOutside'] = true,

            ['entries'] = {
                {
                    ['height'] = {
                        ['min'] = 28.0,
                        ['max'] = 38.0
                    },

                    ['points'] = {
                        vector2(-1401.413696289, -596.328125),
                        vector2(-1404.9089355468, -598.86462402344),
                        vector2(-1407.0158691406, -601.61889648438),
                        vector2(-1408.5404052734, -604.67236328125),
                        vector2(-1408.9681396484, -606.62072753906),
                        vector2(-1409.2697753906, -608.60479736328),
                        vector2(-1409.2413330078, -610.48376464844),
                        vector2(-1408.9764404296, -612.27325439454),
                        vector2(-1408.4095458984, -613.27600097656),
                        vector2(-1406.8780517578, -615.56494140625),
                        vector2(-1399.9211425782, -626.35858154296),
                        vector2(-1369.5202636718, -606.62811279296),
                        vector2(-1379.962524414, -590.52020263672),
                        vector2(-1388.4901123046, -595.3583984375),
                        vector2(-1391.1838378906, -590.71112060546),
                        vector2(-1400.8452148438, -596.8544921875)
                      
                    }
                }
            }
        } 
    },

    ['disableEmitters'] = nil,
    ['scaleform'] = nil,
    ['replacers'] = nil,
    ['screens'] = nil,
    ['smokers'] = nil,
    ['sparklers'] = nil,
    ['spotlights'] = {
        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.MID,                       
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] =vector3(-1393.65, -602.22, 38.02),
            ['rotation'] = nil,
            ['heading'] = 51.46,
            ['lodDistance'] = nil,
            ['color'] = {1, 255, 255}                                      
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.MID,                        
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1392.94, -618.31, 38.02),
            ['rotation'] = nil,
            ['heading'] = 172.43,
            ['lodDistance'] = nil,
            ['color'] = {255, 1, 255}                                      
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,                    
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1398.21, -608.69, 38.02),
            ['rotation'] = nil,
            ['heading'] = 98.55,
            ['lodDistance'] = nil,
            ['color'] = {1, 255, 255}
        },
        
        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,                    
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1384.82, -614.28, 38.02),
            ['rotation'] = nil,
            ['heading'] = 213.08,
            ['lodDistance'] = nil,
            ['color'] = {255, 1, 255}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,                    
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1398.29, -599.21, 38.02),
            ['rotation'] = nil,
            ['heading'] = 96.15,
            ['lodDistance'] = nil,
            ['color'] = {1, 255, 255}                                      
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,                    
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1380.22, -602.73, 38.02),
            ['rotation'] = nil,
            ['heading'] = 323.88,
            ['lodDistance'] = nil,
            ['color'] = {255, 1, 255}                                      
        },
    },

    ['speakers'] = {
        {
            ['hash'] = 'ba_prop_battle_club_speaker_small',
            ['visible'] = false,
            ['position'] = vector3(-1400.0, -596.76, 32.21),
            ['rotation'] = nil,
            ['heading'] = 29.21,
            ['lodDistance'] = nil,
            ['soundOffset'] = vector3(0.0, 0.0, 1.0),
            ['directionOffset'] = nil,
            ['maxDistance'] = 30.0,
            ['refDistance'] = 24.0,
            ['rolloffFactor'] = 1.25,
            ['coneInnerAngle'] = 90,
            ['coneOuterAngle'] = 180,
            ['coneOuterGain'] = 0.5,
            ['fadeDurationMs'] = 250,
            ['volumeMultiplier'] = 1.0,
            ['lowPassGainReductionPercent'] = 0
        },
        {
            ['hash'] = 'ba_prop_battle_club_speaker_small',
            ['visible'] = false,
            ['position'] = vector3(-1399.85, -625.86, 32.21),
            ['rotation'] = nil,
            ['heading'] = 160.03,
            ['lodDistance'] = nil,
            ['soundOffset'] = vector3(0.0, 0.0, 1.0),
            ['directionOffset'] = nil,
            ['maxDistance'] = 30.0,
            ['refDistance'] = 24.0,
            ['rolloffFactor'] = 1.25,
            ['coneInnerAngle'] = 90,
            ['coneOuterAngle'] = 180,
            ['coneOuterGain'] = 0.5,
            ['fadeDurationMs'] = 250,
            ['volumeMultiplier'] = 1.0,
            ['lowPassGainReductionPercent'] = 0
        },
        {
            ['hash'] = 'ba_prop_battle_club_speaker_small',
            ['visible'] = false,
            ['position'] = vector3(-1386.18, -607.13, 31.22),
            ['rotation'] = nil,
            ['heading'] = 95.73,
            ['lodDistance'] = nil,
            ['soundOffset'] = vector3(0.0, 0.0, 1.0),
            ['directionOffset'] = nil,
            ['maxDistance'] = 30.0,
            ['refDistance'] = 24.0,
            ['rolloffFactor'] = 1.25,
            ['coneInnerAngle'] = 90,
            ['coneOuterAngle'] = 180,
            ['coneOuterGain'] = 0.5,
            ['fadeDurationMs'] = 250,
            ['volumeMultiplier'] = 1.0,
            ['lowPassGainReductionPercent'] = 0
        },
        {
            ['hash'] = 'ba_prop_battle_club_speaker_small',
            ['visible'] = false,
            ['position'] = vector3(-1393.46, -604.61, 31.22),
            ['rotation'] = nil,
            ['heading'] = 190.59,
            ['lodDistance'] = nil,
            ['soundOffset'] = vector3(0.0, 0.0, 1.0),
            ['directionOffset'] = nil,
            ['maxDistance'] = 30.0,
            ['refDistance'] = 24.0,
            ['rolloffFactor'] = 1.25,
            ['coneInnerAngle'] = 90,
            ['coneOuterAngle'] = 180,
            ['coneOuterGain'] = 0.5,
            ['fadeDurationMs'] = 250,
            ['volumeMultiplier'] = 1.0,
            ['lowPassGainReductionPercent'] = 0
        }
    }
},

        ['uwucafe']={
            ['enabled']=true,
            ['autoAdjustTime'] = true,
            ['maxVolumePercent'] = 100,
            ['area']={
                ['range'] = 25,
                ['center'] = vec3(-580.235, -1060.512, 22.347),
                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,

                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 21.5,
                                ['max'] = 25.0
                            },
        
                            ['points'] = {
                                vector2(-572.70556640625, -1068.6639404297),
                                vector2(-574.89697265625, -1069.0395507813),
                                vector2(-587.18908691406, -1069.0395507813),
                                vector2(-587.48895263672, -1064.5407714844),
                                vector2(-591.44683837891, -1064.5455322266),
                                vector2(-591.44683837891, -1054.30078125),
                                vector2(-587.18908691406, -1054.6967773438),
                                vector2(-587.18835449219, -1051.5379638672),
                                vector2(-584.29486083984, -1051.5308837891),
                                vector2(-584.29486083984, -1048.7022705078),
                                vector2(-581.64312744141, -1048.6951904297),
                                vector2(-581.6416015625, -1049.9976806641),
                                vector2(-575.91772460938, -1049.9869384766),
                                vector2(-575.91180419922, -1048.6951904297),
                                vector2(-566.30938720703, -1048.7015380859),
                                vector2(-566.28204345703, -1050.6121826172),
                                vector2(-568.17401123047, -1050.6049804688),
                                vector2(-570.84423828125, -1050.7213134766),
                                vector2(-570.79809570313, -1057.5396728516)
                            }
                        }
                    }
                }
            },
            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vec3(-579.082, -1050.0, 24.973),
                    ['heading'] = 356.57,
                    ['soundOffset'] = vector3(0, 0, 0),
                    ['refDistance'] = 32.0,
                    ['lodDistance'] = 256.0,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                },
 
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vec3(-581.075, -1069.043, 24.843),
                    ['heading'] = 186.48,
                    ['soundOffset'] = vector3(0, 0, 0),
                    ['refDistance'] = 32.0,
                    ['lodDistance'] = 256.0,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                },
            },
        },

        ['cat_cafe'] = {
            ['enabled'] = false,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 150,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
        
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },
        
            ['area'] = {
                ['range'] = 36.0,
                ['center'] = vector3(-579.89, -1059.46, 22.34),
                ['height'] = nil,
        
                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,
        
                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 20.0,
                                ['max'] = 30.0
                            },
        
                            ['points'] = {
                                vector2(-600.42224121094, -1068.9382324219),
                                vector2(-586.19537353516, -1069.6312255859),
                                vector2(-584.69494628906, -1069.8532714844),
                                vector2(-581.70947265625, -1069.5817871094),
                                vector2(-573.11157226562, -1069.7077636719),
                                vector2(-566.71313476562, -1069.8015136719),
                                vector2(-565.81335449219, -1069.8146972656),
                                vector2(-566.07019042969, -1059.8282470703),
                                vector2(-566.07379150391, -1053.9296875),
                                vector2(-566.07720947266, -1048.3310546875),
                                vector2(-570.96856689453, -1048.53515625),
                                vector2(-576.47497558594, -1048.5041503906),
                                vector2(-581.20184326172, -1048.0346679688),
                                vector2(-582.56433105469, -1047.9940185547),
                                vector2(-582.78930664062, -1040.4072265625),
                                vector2(-590.39715576172, -1040.7967529297),
                                vector2(-599.89123535156, -1040.8895263672),
                                vector2(-601.18933105469, -1040.9605712891)
                            }
                        }
                    }
                }
            },
        
            ['disableEmitters'] = nil,
            ['scaleform'] = nil,
        
            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['ba_prop_battle_club_projector'] = 'script_rt_club_projector'
            },
        
            ['monitors'] = nil,
            ['screens'] = nil,
        
            ['spotlights'] = nil,
        
            ['smokers'] = nil,
        
            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-586.93, -1068.81, 25.24),
                    ['rotation'] = nil,
                    ['heading'] = 312.55068969727,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-575.11, -1057.98, 25.27), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 134.89999389648,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-591.2, -1064.29, 24.84), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 328.89999389648,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
            }
        },
        ['rex_diner'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 150,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
        
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },
        
            ['area'] = {
                ['range'] = 36.0,
                ['center'] = vector3(2539.48, 2586.87, 38.5),
                ['height'] = nil,
        
                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,
        
                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 37.0,
                                ['max'] = 40.0
                            },
        
                            ['points'] = {
                                vector2(2542.4377441406, 2591.4853515625),
                                vector2(2537.7019042968, 2591.77734375),
                                vector2(2537.0190429688, 2591.6193847656),
                                vector2(2535.0336914062, 2593.8122558594),
                                vector2(2526.2763671875, 2593.6472167968),
                                vector2(2523.0170898438, 2590.962890625),
                                vector2(2522.8256835938, 2578.5910644532),
                                vector2(2550.6552734375, 2578.2839355468),
                                vector2(2550.3063964844, 2591.587890625)
                            }
                        }
                    }
                }
            },
        
            ['disableEmitters'] = nil,
            ['scaleform'] = nil,
        
            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['ba_prop_battle_club_projector'] = 'script_rt_club_projector'
            },
        
            ['monitors'] = nil,
            ['screens'] = nil,
        
            ['spotlights'] = nil,
        
            ['smokers'] = nil,
        
            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(2523.61, 2590.96, 40.08),
                    ['rotation'] = nil,
                    ['heading'] = 258.54,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(2523.26, 2584.41, 40.34), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 301.92,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(2550.28, 2584.86, 40.37), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 66.65,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
            }
        },
        ['shopsunsetmotors'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 150,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
        
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },
        
            ['area'] = {
                ['range'] = 36.0,
                ['center'] = vector3(-13.393, -1666.911, 29.491),
                ['height'] = nil,
        
                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = false,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,
        
                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 37.0,
                                ['max'] = 40.0
                            },
        
                            ['points'] = {
                                vector2(9.178, -1664.905),
                                vector2(-13.105, -1651.272),
                                vector2(-27.376, -1670.562),
                                vector2(-22.273, -1670.203),
                                vector2(-10.791, -1679.204),
                                vector2(0.715, -1674.726)
                            }
                        }
                    }
                }
            },
        
            ['disableEmitters'] = nil,
            ['scaleform'] = nil,
        
            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['ba_prop_battle_club_projector'] = 'script_rt_club_projector'
            },
        
            ['monitors'] = nil,
            ['screens'] = nil,
             
            ['spotlights'] = nil,
        
            ['smokers'] = nil,
        
            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(4.291, -1670.719, 30.051),
                    ['rotation'] = nil,
                    ['heading'] = 200.19,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-10.321, -1678.82, 30.615), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 16.66,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-23.748, -1664.491, 31.332), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 151.7,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-15.528, -1654.741, 32.401), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 296.62,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
            }
        },
        ['hornys'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 150,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
        
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },
        
            ['area'] = {
                ['range'] = 26.0,
                ['center'] = vector3(1243.595, -360.026, 69.629),
                ['height'] = nil,
        
                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = false,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,
        
                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 37.0,
                                ['max'] = 40.0
                            },
        
                            ['points'] = {
                                vector2(1233.451, -363.446),
                                vector2(1250.249, -368.223),
                                vector2(1254.859, -351.286),
                                vector2(1251.593, -350.372),
                                vector2(1250.168, -353.508),
                                vector2(1238.015, -347.526)
                            }
                        }
                    }
                }
            },
        
            ['disableEmitters'] = nil,
            ['scaleform'] = nil,
        
            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['ba_prop_battle_club_projector'] = 'script_rt_club_projector'
            },
        
            ['monitors'] = nil,
            ['screens'] = nil,
             
            ['spotlights'] = nil,
        
            ['smokers'] = nil,
        
            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(1234.041, -363.285, 70.121),
                    ['rotation'] = nil,
                    ['heading'] = 200.19,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(1250.316, -368.283, 70.309), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 16.66,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },

                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(1254.818, -351.269, 70.113), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 151.7,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(1241.641, -349.918, 69.929), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 296.62,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
            }
        },
        ['shopbennys'] = {
            ['enabled'] = true,
            ['autoAdjustTime'] = false,
            ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
            ['maxVolumePercent'] = 150,
            ['smokeFxMultiplier'] = 3,
            ['smokeTimeoutMs'] = 5000,
            ['sparklerFxMultiplier'] = 1,
            ['sparklerTimeoutMs'] = 1500,
            ['delayBetweenSmokeChainMs'] = 1500,
            ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
            ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
            ['bass'] = {
                ['smoke'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                },
        
                ['sparklers'] = {
                    ['cooldownMs'] = 30000,
                    ['colorWithDynamicSpotlights'] = true
                }
            },
        
            ['area'] = {
                ['range'] = 36.0,
                ['center'] = vector3(-211.06, -1327.3, 31.3),
                ['height'] = nil,
        
                ['polygons'] = {
                    ['applyLowPassFilterOutside'] = true,
                    ['invertLowPassApplication'] = false,
                    ['hideReplacersOutside'] = true,
        
                    ['entries'] = {
                        {
                            ['height'] = {
                                ['min'] = 30.0,
                                ['max'] = 37.50
                            },
        
                            ['points'] = {
                                vector2(-231.447, -1311.703),
                                vector2(-186.61, -1311.704),
                                vector2(-186.543, -1342.483),
                                vector2(-231.518, -1342.27)
                            }
                        }
                    }
                }
            },
        
            ['disableEmitters'] = nil,
            ['scaleform'] = nil,
        
            ['replacers'] = {
                ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                ['ba_prop_battle_club_projector'] = 'script_rt_club_projector'
            },
        
            ['monitors'] = nil,
            ['screens'] = nil,
        
            ['spotlights'] = nil,
        
            ['smokers'] = nil,
        
            ['speakers'] = {
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(225.6, -1314.03, 34.12),
                    ['rotation'] = nil,
                    ['heading'] = 220.13,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-224.83, -1339.59, 31.84), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 326.75,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
        
                {
                    ['hash'] = 'ba_prop_battle_club_speaker_large',
                    ['visible'] = false,
                    ['position'] = vector3(-194.46, -1314.25, 36.76), --- vector3(-591.2, -1064.29, 24.84)
                    ['rotation'] = nil,
                    ['heading'] = 132.03,
                    ['lodDistance'] = nil,
                    ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                    ['directionOffset'] = nil,
                    ['maxDistance'] = 50.0,
                    ['refDistance'] = 24.0,
                    ['rolloffFactor'] = 1.25,
                    ['coneInnerAngle'] = 90,
                    ['coneOuterAngle'] = 180,
                    ['coneOuterGain'] = 0.5,
                    ['fadeDurationMs'] = 250,
                    ['volumeMultiplier'] = 1.0,
                    ['lowPassGainReductionPercent'] = 0
                },
            }
        },
        -- This entry does not require an extra map.

['parking_cinema_large'] = {
    ['enabled'] = true,
    ['autoAdjustTime'] = false,
    ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
    ['maxVolumePercent'] = 200,
    ['smokeFxMultiplier'] = 3,
    ['smokeTimeoutMs'] = 5000,
    ['sparklerFxMultiplier'] = 1,
    ['sparklerTimeoutMs'] = 1500,
    ['delayBetweenSmokeChainMs'] = 1500,
    ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
    ['featureDelayWithControllerInterfaceClosedMs'] = 500,

    ['bass'] = nil,

    ['area'] = {
        ['range'] = 128.0,
        ['center'] = vector3(-1708.77, -905.75, 14.07),
        ['height'] = nil,
        ['polygons'] = nil
    },

    ['disableEmitters'] = nil,

    ['scaleform'] = {
        ['solid'] = true,
        ['flag'] = false,
        ['position'] = vector3(-1700.55, -911.95, 18.35),
        ['rotation'] = vector3(0.0, 0.0, -140.35),
        ['scale'] = vector3(0.845, 0.455, 0.0)
    },

    ['replacers'] = nil,

    ['monitors'] = {
        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1708.0703, -906.0299, 10.112692),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1708.0703, -906.0239, 16.045633),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1713.1582, -901.8113, 10.112692),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1703.5819, -909.75867, 10.112692),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1713.1582, -901.8113, 16.045633),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1703.5796, -909.75867, 16.045633),
            ['rotation'] = nil,
            ['heading'] = -39.74569,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1708.4623, -905.87384, 15.529058),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1708.4103, -905.9194, 10.596061),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1713.2186, -901.93274, 15.529058),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1713.2185, -901.93225, 10.599154),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1704.3209, -909.3089, 15.529058),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_huge_display_02',
            ['position'] = vector3(-1704.3209, -909.3089, 10.591772),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_billb_frame01a',
            ['position'] = vector3(-1702.4642, -912.5856, 6.7018266),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_billb_frame01a',
            ['position'] = vector3(-1716.6082, -900.8562, 6.7031603),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        },

        {
            ['hash'] = 'prop_billb_frame01a',
            ['position'] = vector3(-1709.3938, -906.8314, 6.6993837),
            ['rotation'] = nil,
            ['heading'] = 140.35075,
            ['lodDistance'] = 128
        }        
    },

    ['screens'] = nil,

    ['spotlights'] = {
        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.MID,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1700.0432, -912.8055, 16.997484),
            ['rotation'] = vector3(79.81944, 39.95835, -168.51068),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {255, 255, 0}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.LOW_MID,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1699.9872, -912.75525, 18.572235),
            ['rotation'] = vector3(-89.1767, 15.263356, 62.73788),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {15, 3, 255}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.TREBLE,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1717.0707, -898.5253, 16.99997),
            ['rotation'] = vector3(79.8196, 39.95832, 4.3027616),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {3, 83, 255}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.HIGH_MID,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1717.0271, -898.52234, 18.567598),
            ['rotation'] = vector3(-89.17813, 15.263419, -116.71412),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {255, 5, 190}
        },

        {
            ['soundSyncType'] = SOUND_SYNC_TYPE.BASS,
            ['hash'] = 'cs_prop_hall_spotlight',
            ['position'] = vector3(-1708.5563, -905.6041, 19.142105),
            ['rotation'] = vector3(0.6012019, -179.44646, 145.56659),
            ['heading'] = nil,
            ['lodDistance'] = 128,
            ['color'] = {255, 1, 1}
        }
    },

    ['smokers'] = nil,
    ['sparklers'] = nil,

    ['speakers'] = {
        {
            ['hash'] = 'xs_propintarena_speakers_01a',
            ['visible'] = false,
            ['position'] = vector3(-1708.5303, -905.79474, 16.172209),
            ['rotation'] = vector3(-0.39775264,86.46773, 48.647858),
            ['heading'] = nil,
            ['lodDistance'] = nil,
            ['soundOffset'] = nil,
            ['distanceOffset'] = vector3(0.75, -0.66, 0),
            ['maxDistance'] = 32.0,
            ['refDistance'] = 16.0,
            ['rolloffFactor'] = 1.25,
            ['coneInnerAngle'] = 90,
            ['coneOuterAngle'] = 180,
            ['coneOuterGain'] = 0.5,
            ['fadeDurationMs'] = 250,
            ['volumeMultiplier'] = 1.0,
            ['lowPassGainReductionPercent'] = 15
        }
    }
},
        ['bighouse'] = {
                ['enabled'] = true,
                ['autoAdjustTime'] = false,
                ['idleWallpaperUrl'] = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/client/dui/images/wallpaper.png',
                ['maxVolumePercent'] = 150,
                ['smokeFxMultiplier'] = 3,
                ['smokeTimeoutMs'] = 5000,
                ['sparklerFxMultiplier'] = 1,
                ['sparklerTimeoutMs'] = 1500,
                ['delayBetweenSmokeChainMs'] = 1500,
                ['delayToTriggerBassEffectsAfterPlayingMs'] = 2500,
                ['featureDelayWithControllerInterfaceClosedMs'] = 500,
        
                ['bass'] = {
                    ['smoke'] = {
                        ['cooldownMs'] = 30000,
                        ['colorWithDynamicSpotlights'] = true
                    },
        
                    ['sparklers'] = {
                        ['cooldownMs'] = 30000,
                        ['colorWithDynamicSpotlights'] = true
                    }
                },
        
                ['area'] = {
                    ['range'] = 36.0,
                    ['center'] = vector3(493.51, -1534.46, 29.27),
                    ['height'] = nil,
        
                    ['polygons'] = {
                        ['applyLowPassFilterOutside'] = true,
                        ['invertLowPassApplication'] = false,
                        ['hideReplacersOutside'] = true,
        
                        ['entries'] = {
                            {
                                ['height'] = {
                                    ['min'] = 20.0,
                                    ['max'] = 35.0
                                },
            
                                ['points'] = {
                                    vector2(503.14544677734, -1530.5162353516),
                                    vector2(492.53186035156, -1543.5721435547),
                                    vector2(481.91708374023, -1534.9523925781),
                                    vector2(492.12023925781, -1522.9079589844)
                                    }
                                }
                            }
                        }
                    }
                },
        
                ['disableEmitters'] = nil,
                ['scaleform'] = nil,
        
                ['replacers'] = {
                    ['ba_prop_battle_club_screen'] = 'script_rt_club_tv',
                    ['ba_prop_battle_club_projector'] = 'script_rt_club_projector'
                },
        
                ['monitors'] = nil,
                ['screens'] = nil,
        
                ['spotlights'] = nil,
        
                ['smokers'] = nil,
        
                ['speakers'] = {
                    {
                        ['hash'] = 'ba_prop_battle_club_speaker_large',
                        ['visible'] = false,
                        ['position'] = vector3(490.91, -1541.69, 30.81),
                        ['rotation'] = nil,
                        ['heading'] = 339.19,
                        ['lodDistance'] = nil,
                        ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                        ['directionOffset'] = nil,
                        ['maxDistance'] = 50.0,
                        ['refDistance'] = 24.0,
                        ['rolloffFactor'] = 1.25,
                        ['coneInnerAngle'] = 90,
                        ['coneOuterAngle'] = 180,
                        ['coneOuterGain'] = 0.5,
                        ['fadeDurationMs'] = 250,
                        ['volumeMultiplier'] = 1.0,
                        ['lowPassGainReductionPercent'] = 0
                    },
        
                    {
                        ['hash'] = 'ba_prop_battle_club_speaker_large',
                        ['visible'] = false,
                        ['position'] = vector3(485.61, -1537.21, 30.44), --- vector3(-591.2, -1064.29, 24.84)
                        ['rotation'] = nil,
                        ['heading'] = 273.31,
                        ['lodDistance'] = nil,
                        ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                        ['directionOffset'] = nil,
                        ['maxDistance'] = 50.0,
                        ['refDistance'] = 24.0,
                        ['rolloffFactor'] = 1.25,
                        ['coneInnerAngle'] = 90,
                        ['coneOuterAngle'] = 180,
                        ['coneOuterGain'] = 0.5,
                        ['fadeDurationMs'] = 250,
                        ['volumeMultiplier'] = 1.0,
                        ['lowPassGainReductionPercent'] = 0
                    },
        
                    {
                        ['hash'] = 'ba_prop_battle_club_speaker_large',
                        ['visible'] = false,
                        ['position'] = vector3(495.14, -1525.73, 31.29), --- vector3(-591.2, -1064.29, 24.84)
                        ['rotation'] = nil,
                        ['heading'] = 163.55,
                        ['lodDistance'] = nil,
                        ['soundOffset'] = vector3(0.0, 0.0, 1.0),
                        ['directionOffset'] = nil,
                        ['maxDistance'] = 50.0,
                        ['refDistance'] = 24.0,
                        ['rolloffFactor'] = 1.25,
                        ['coneInnerAngle'] = 90,
                        ['coneOuterAngle'] = 180,
                        ['coneOuterGain'] = 0.5,
                        ['fadeDurationMs'] = 250,
                        ['volumeMultiplier'] = 1.0,
                        ['lowPassGainReductionPercent'] = 0
                    },
                }
            },



        -- Below you can find a full config entry reference.

        -- ['key'] = {
        --     ['enabled'] = boolean,
        --     ['autoAdjustTime'] = boolean,
        --     ['idleWallpaperUrl'] = string,
        --     ['maxVolumePercent'] = number,
        --     ['smokeFxMultiplier'] = number,
        --     ['smokeTimeoutMs'] = number,
        --     ['sparklerFxMultiplier'] = number,
        --     ['sparklerTimeoutMs'] = number,
        --     ['delayBetweenSmokeChainMs'] = number,
        --     ['delayToTriggerBassEffectsAfterPlayingMs'] = number,
        --     ['featureDelayWithControllerInterfaceClosedMs'] = number,

        --     ['bass'] = {
        --         ['smoke'] = {
        --             ['cooldownMs'] = number,
        --             ['colorWithDynamicSpotlights'] = boolean
        --         },

        --         ['sparklers'] = {
        --             ['cooldownMs'] = number,
        --             ['colorWithDynamicSpotlights'] = boolean
        --         }
        --     },

        --     ['area'] = {
        --         ['range'] = number,
        --         ['center'] = vector3(number, number, number),

        --         ['height'] = {
        --             ['min'] = number,
        --             ['max'] = number
        --         },

        --         ['polygons'] = {
        --             ['applyLowPassFilterOutside'] = boolean,
        --             ['invertLowPassApplication'] = boolean,
        --             ['hideReplacersOutside'] = boolean,

        --             ['entries'] = {
        --                 {
        --                     ['height'] = {
        --                         ['min'] = number,
        --                         ['max'] = number
        --                     },
        
        --                     ['points'] = {
        --                         vector2(number, number),
        --                         ...
        --                     ]
        --                 }
        --             ]
        --         }
        --     },

        --     ['disableEmitters'] = {string, ...},

        --     ['scaleform'] = {
        --         ['solid'] = boolean,
        --         ['flag'] = boolean,
        --         ['position'] = vector3(number, number, number),
        --         ['rotation'] = vector3(number, number, number),
        --         ['scale'] = vector3(number, number, number)
        --     },

        --     ['replacers'] = {
        --         ['key'] = value,
        --         ...
        --     },

        --     ['monitors'] = {
        --         {
        --             ['hash'] = string,
        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number
        --         },
        --         ...
        --     },

        --     ['screens'] = {
        --         {
        --             ['hash'] = string,
        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,

        --             ['advance'] = {
        --                 ['durationMs'] = number,
        --                 ['position'] = vector3(number, number, numbe)]
        --             }
        --         },
        --         ...
        --     },

        --     ['spotlights'] = {
        --         {
        --             ['soundSyncType'] = SOUND_SYNC_TYPE,
        --             ['hash'] = string,
        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,
        --             ['color'] = {number, number, number}
        --         },
        --         ...
        --     },

        --     ['smokers'] = {
        --         {
        --             ['hash'] = string,
        --             ['visible'] = boolean,
    
        --             ['fx'] = {
        --                 ['library'] = string,
        --                 ['effect'] = string,
        --             },

        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,
        --             ['color'] = {number, number, number}
        --         },
        --         ...
        --     },

        --     ['sparklers'] = {
        --         {
        --             ['hash'] = string,
        --             ['visible'] = boolean,
    
        --             ['fx'] = {
        --                 ['library'] = string,
        --                 ['effect'] = string,
        --             },

        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,
        --             ['color'] = {number, number, number}
        --         },
        --         ...
        --     },

        --     ['speakers'] = {
        --         {
        --             ['hash'] = string,
        --             ['visible'] = boolean,
        --             ['position'] = vector3(number, number, number),
        --             ['rotation'] = vector3(number, number, number),
        --             ['heading'] = number,
        --             ['lodDistance'] = number,
        --             ['soundOffset'] = vector3(number, number, number),
        --             ['directionOffset'] = vector3(number, number, number),
        --             ['maxDistance'] = number,
        --             ['refDistance'] = number,
        --             ['rolloffFactor'] = number,
        --             ['coneInnerAngle'] = number,
        --             ['coneOuterAngle'] = number,
        --             ['coneOuterGain'] = number,
        --             ['fadeDurationMs'] = number,
        --             ['volumeMultiplier'] = number,
        --             ['lowPassGainReductionPercent'] = number
        --         },
        --         ...
        --     ]
        -- }
    }