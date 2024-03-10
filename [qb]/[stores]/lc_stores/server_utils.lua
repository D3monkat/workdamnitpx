WebhookURL = "WEBHOOK" -- Webhook to send logs to discord

function beforeBuyMarket(source,market_id,price)
	-- Here you can do any verification when a player is buying a market, like if player has the permission to that or anything else you want to check before buy the market. return true or false
	return true
end

function afterBuyMarket(source,market_id,price)
	-- Here you can run any code right after the player purchase a business
end

function beforeBuyItem(source,market_id,item_id,amount,total_price)
	-- Here you can do any verification when a player is buying an item in a market, like if player has gun license or anything else you want to check before buy the item. return true or false
	return true
end

function afterBuyItem(source,market_id,item_id,amount,total_price,account)
	-- Here you can run any code just after the player purchased any item, like government taxes or anything else
end