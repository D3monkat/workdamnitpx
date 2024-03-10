svConfig = {
    -- The time (in seconds) between players starting in a drifting race.
    timeBetweenStarts = 15,

    -- Competition race prize pool size (per generated race)
    -- For example if set to $9000 and $11000, the prize pool of a race will be between $9,000 and $11,000.
    minCompetitionPrizePool = 100000,
    maxCompetitionPrizePool = 140000,

    -- The prize the player will receive when he doesn't finish a race (is disqualified, DNF)
    competitionDnfPrizeMoney = 1000,

    -- At what time are the competitions inserted into the application
    competitionGenerationHour = 14,

    -- The time (in minutes) that people have to drive a competition track. This means your tracks shouldn't last longer than this.
    competitionMaxTime = 12,

    -- The Discord webhook URL where notifications should be sent. It will send the starting races, times & classes
    competitionNotificationWebHook = '',

    -- The logo which will be attached to the notification message sent
    competitionDiscordLogo = 'https://i.imgur.com/hezZIVS.png',

    -- Should tracks be generated from verified tracks (true) or from all tracks (false).
    useVerifiedTracks = true,

    -- The track IDs which are verified and will be used if useVerifiedTracks is true.
    verifiedTrackIds = {8, 10, 11, 12, 13, 14, 23, 28, 25},

    -- At what time do the competitions start (this specifies the start for the first race)
    competitionHour = 19,
    competitionMinute = 0,

    -- How many competitions are generated per generation.
    competitionsPerGeneration = 4,

    -- The duration in minutes, how long drifting competitions usually take place in your server (depends on how many people you have competing etc).
    approximateCompetitionDuration = 20,

    -- The break time in minutes, how long should people have between competitions.
    breakTimeBetweenCompetitions = 10,

    -- When a circuit track is chosen for a competition race, then how many laps should it be? Will be randomly selected between these two values.
    competitionMinLaps = 3,
    competitionMaxLaps = 6,

    -- At least how many participants should a race have for it to be displayed in the 'Races' tab? By default set to 2 to reduce 1-player race spam.
    minimumParticipantsForRaceTab = 2,

    -- Luck weight
    competitionChanceWeights = {
        ['S'] = 100,
        ['A'] = 0,
        ['B'] = 0,
        ['C'] = 0,
        ['D'] = 0
    },

    -- The minimum amount of people that a competition race must have for it to start.
    minimumCompetitionParticipantAmount = 1,

    -- TRACK CREATION RESTRICTION (true / false)
    -- If set to false, then everyone can create tracks. If true, then only selected people / ratings can create tracks (configure below).
    isTrackCreationRestricted = false,

    -- Choose one of the two types (identifier / rating) and comment out the other.
    -- When IDENTIFIER is selected, then only people with certain identifiers can create tracks.
    -- When RATING is selected, then people with certain rating or higher rating can create tracks.
    trackRestrictionType = 'IDENTIFIER',
    trackRestrictionType = 'RATING',

    -- Comma separated list of string identifiers that are allowed to create tracks (used when restriction is enabled & trackRestrictionType is set to IDENTIFIER).
    -- Identifier string values should be taken from ra_drifting_user_settings.player_identifier
    trackRestrictionIdentifiers = {'1', '2', '3'},

    -- The ELO rating from which people are allowed to create tracks (used when restriction is enabled & trackRestrictionType is set to RATING).
    trackRestrictionRating = 1700,

    -- COMPETITION CREATION RESTRICTION (true / false)
    -- If set to false, then people with 1750 ELO or higher can start competition tracks. If true, then only selected people can create tracks (configure below).
    isCompetitionCreationRestricted = false,

    -- Comma separated list of string identifiers that are allowed to start competition races (used when restriction is enabled).
    -- Identifier string values should be taken from ra_drifting_user_settings.player_identifier
    competitionRestrictionIdentifiers = {'1', '2', '3'},

    -- The duration before the start of a race when players are frozen and countdown is shown (in seconds)
    freezeDuration = 5,

    -- If phasing (no collisions) should be enabled during races.
    phasingEnabled = true,

    -- This value is only used when phasingEnabled is true. Set it as 0 to have it on for the entire race. Any other value than 0 will mean seconds
    -- from the start of the race. For example a value of 15 means that after the first 15 seconds of the race, phasing will be disabled.
    phasingDuration = 0,

    -- Used to alert players after the race start to alert about the phasing disabling. So when this is set to 10, there will be a notification
    -- 10 seconds after the race start. After 15, the phasing will stop (phasingDuration). Set this to 0 if you don't wish to send a notification.
    phasingNotification = 0,

    -- This value is only used when phasingEnabled is true. Determines when should phasing be used, values possible: 'ALL', 'COMPETITION', 'NORMAL'
    -- ALL: Phasing is enabled in both (normal races and competition races).
    -- COMPETITION: Phasing is only enabled only in competition races.
    -- NORMAL: Phasing is only enabled only in normal races.
    phasingMode = 'ALL'
}