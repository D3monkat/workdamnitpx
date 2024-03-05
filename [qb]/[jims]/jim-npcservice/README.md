# WHAT IS IT!?
This is a script that makes great use of GTA5's NPC AI functions to recreate city services

Such as:
- Taxi and Limo service system
- Working Airports and pilots that fly you to other airports (such as Cayo Perico)
- Working Helicopters and pilots that fly you to other airports (such as Cayo Perico)
- Working Ambulance system where players can be escorted to a hospital or revived on the spot
- Car Autopilot Drive system


# How does it work!?

## Taxis and Limo's

This is a recreation of the story mode taxi services.

These are possibly the most advanced parts of the script and the base of the rest of the script

The player who summoned the taxi will control it, but other users can enter the vehicle if there is space

If you don't enter the taxi in 2 minutes, the taxi will leave

Controls:
- `E` to show the destination list, this is the list of locations preset in the `destinations.lua` and also your current waypoint
- `SPACE` tell the driver to speed up or slow down
- `ENTER` If enabled in the config the passenger can skip the journey

You can summon a taxi in different ways
- Enable Payphones in the config and it will highlight every payphone nearby on your minimap and then you only need to target it to call for a taxi
- Making use of the provided export to bring the service menu up for users

## Ambulances

This was created from experiences of being in servers and there either being no ambulance workers online or them being too busy.

This creates an ambulance that will pick up the player or revive them on the spot

This will need to be triggered by an export

I recommend putting it in a check if anyone with the ambulance job is online, if not call an npc ambulance or in extreme just replace ambulance workers with the export and summon the ambulance every time.
This is server preference.

## Airports and Helicopter Travel
This is basically intented to be a luxurious way to travel around the city, but also a bridge for Cayo Perico if you have it enabled in your server

Simply visit the airport worker npc, target and pick a location

They will wait 2 minutes to take off, and in that time other users can board the same plane too.

After 2 minutes the plane takes off to their destination

They will attempt to reach their destination by following a preset route

But due to genuis Ped AI, planes sometimes...miss and circle around till they can land properly

## AutoPilot
This is kind of experimental but added to see if it was possible
This makes it so the "car" will drive itself to the current waypoint

It's a set speed, and a set driving style so the car won't try to run people over and such

Players can disable it by basically "turning the wheel"

This can be easily disabled in the config

# Installation

To start:
- Place in your resources
- Add ensure jim-npcservice to your server.cfg
- Start server

Then the more advanced:
- Setup the config.lua how you like
- You don't need to touch the Airport and Helipad coords (these are preset) unless you wish to add more somehow

What the Config does:
#### General
- The script supports different menu's and notification systems
    - "qb" for `qb-core`, "ox" for `ox_lib` and "gta" for defaults and `warmenu`
- There is a fuel export option purely because when testing, hud's don't update fuel with GTA fuel natives unless you're the driver
- `metric` to change distance calculations, "Km" or "Mi"

#### Taxi's And Limos
- `taxiEnable` enables or disables taxi features of the script

- `freeTaxi` to disable being charged for taxi's
- `canskip` Enables the ability for the owner of the taxi to skip to destination for extra cost
- `cam` to add a story mode style camera when choosing destinations in a taxi
- `CommandCall` to enable use of a / command to call taxi's
- `Command` to chooose what / command to be typed *default "calltaxi"
- `CellAnim` to show a quick anim when calling a taxi

- `Payphones` make payphones usable to call taxis
- `ShowNearbyPayPhones` shows nearby payphones on the minimap
- `PayPhoneModels` is the list of payphone models that are made to be usable in the script

#### AutoPilot
- `ambiEnable` enables or disables ambulance features of the script
- `autoEnable` enables or disables autopilot features
- `enableKeyPress` - Enables the FivemKeyMapping for enabling autopilot (default is apostrophe ' )

#### Ambulance
- `ambiEnable` enables or disables ambulance features of the script

- `QuickRevive` Enables being revived on the spot for players
- `TakeToHospital` Enables being taken to the chosen hospital

If these ^ are both enabled it will show an option menu for players when ambulance arrives

- `QuickReviveCost` - The cost for quickreviving
- `TakeToHospitalCost` - The cost for being escorted to hospital

#### Airports
- `planeEnable` enables or disables airport features of the script

- `CayoPericoPort` This enables the Cayo Perico location to be accessible via airports
- `PlaneCost` This is how much it costs for all players to ride a plane (0 = free)

#### Helipad
- `heliEnable` enables or disables heliopter features of the script

- `CayoPericoHeli` This enables the Cayo Perico location to be accessible via airports
- `HeliCost` This is how much it costs for all players to ride a helicopter (0 = free)

#### Global Variables
- The ped models that will be used for each service
- The vehicle models that will be used for each service

# Exports:
### Taxis And Limos:
To show the menu to choose a Taxi or Limo:
```lua
exports["jim-npcservice"]:callCab()
```

To just summon a Taxi:
```lua
exports["jim-npcservice"]:callTaxi("taxi")
```
To just summon a Limo:
```lua
exports["jim-npcservice"]:callTaxi("stretch")
```

### Ambulance
To just summon a Ambulance:
```lua
exports["jim-npcservice"]:callAmbi()
```

This comes with added options of custom vehicle model and custom ped models:
(my brain imagined a mafia car picking up the player and taking them to a mob doctor)
```lua
exports["jim-npcservice"]:callAmbi(carModel, pedModel)
```

### Autopilot
To trigger auto pilot in any car, use this export:
```lua
exports["jim-npcservice"]:startAutoPilot()
```

# Compatability
This script is compatible with `ox_lib` and `qb-core` and `warmenu`

The use of callback's locks this to frameworks.
Checking if the planes and heli's are is in use or not to stop double spawning.
And for getting cash values from the server side

### `qb-core`
By default qb-core support is enabled, with the core export being at the bottom of the config.
This is only used for callbacks

### `ox_lib`
For native `ox_lib` support in the script, you will need to uncomment the two `ox_lib` line from the fxmanifest.lua and restart your server

### `qbx_core`
This scipt supports qbox, which is a mix of `qb-core` and `ox_lib`, check the config for what optons to set for it

### `ex_extended`
This script works with `es_extended` for cash payments, but I recommend running `ox_lib` and `ox_target` for rest of the functionality, , check the config for what optons to set for it

### `WarMenu`
To make use of the GTA style menu system, uncomment the `warmenu` line from the fxmanifest.lua and restart your server