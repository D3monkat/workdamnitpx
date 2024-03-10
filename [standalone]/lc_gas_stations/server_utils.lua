WebhookURL = "WEBHOOK" -- Webhook to send logs to discord

function beforeBuyGasStation(source,gas_station_id,price)
	-- Here you can do any verification when a player is buying a gas station, like if player has the permission to that or anything else you want to check before buy the gas station. return true or false
	return true
end