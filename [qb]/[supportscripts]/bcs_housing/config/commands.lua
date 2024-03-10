commands = {
    lockdoor = {
        name='lockdoor', -- the command
        help="Lock/unlock your door",
        params={}
    },
    addhomedoor = {
        name='addhomedoor',
        help='Add a door for your Home',
        params={
            {name="door type", help="single or double"},
            {name="distance", help="door prompt distance"}
        }
    },
    raid = {
        name='raid',
        help='Raid home door for police',
        params={}
    },
    givekey = {
        name='givekey',
        help='Give your house key to someone',
        params={
            {name="player id", help="Player Server ID"},
        }
    },
    removekey = {
        name='removekey',
        help='Remove your house key from someone',
        params={
            {name="player id", help="Player Server ID"},
        }
    },
    logout = {
        name='logouthome',
        help='Logout of character from home',
        params={}
    },
    deletehomedoor = {
        name='deletehomedoor',
        help='Delete a door for your home',
        params={}
    },
    createhome = {
        name='createhome',
        help='Create a new home',
        params={}
    },
    deletehome = {
        name='deletehome',
        help='Remove nearby home',
        params={}
    },
    deleteapartment = {
        name='deleteapartment',
        help='Remove an apartment',
        params={
            {name="name", help="apt room name"},
        }
    },
    setfrontyard = {
        name='setfrontyard',
        help='Set a frontyard for Home IPL / Shell to enable furniture',
        params={}
    },
    setwardrobe = {
        name='setwardrobe',
        help='Set a wardrobe for your home',
        params={}
    },
    setstorage = {
        name='setstorage',
        help='Set a storage for your home',
        params={}
    },
    furnish = {
        name='furnish',
        help='Furnish your home',
        params={}
    },
    editfurniture = {
        name='editfurniture',
        help='Edit existing furniture in your home',
        params={}
    }
}