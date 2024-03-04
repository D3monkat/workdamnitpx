Config = {
	Lan = "en",

	System = {
		Debug = false,
		Notify = "ox",
		drawText = "ox",
	},

	General = {
		ShowTrainBlips = true,			-- Show nearby train blips
		showStationBlips = true,
		requireMetroTicket = true,		-- Do metro trains require tickets
		chargeBank = true,				-- charge players bank account
		chargeAmount = math.random(100, 500),				-- amount per ticket

		seatPlayer = true,				-- Forcibly seat player in train saet, if false they are allowed to walk around
	},
}