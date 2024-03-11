QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Listen for item usage
QBCore.Functions.CreateUseableItem("jacket_cool", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        -- Define the outfit data for the Cool Jacket. You'll need to adjust these values based on the desired appearance.
        local outfitData = {
            ["torso_1"] = 15, -- The drawable ID for the top piece
            ["torso_2"] = 0, -- The texture variant for the top piece
            -- Add other components as needed, like pants, shoes, etc.
        }

        -- Trigger the client event to apply the clothing change, passing the outfit data
        TriggerClientEvent('illenium-appearance:client:applyOutfit', source, outfitData)

        -- Optionally, remove the jacket item from the player's inventory after use
        Player.Functions.RemoveItem("jacket_cool", 1)
        TriggerClientEvent('QBCore:Notify', source, 'You have put on the Cool Jacket.', 'success')

        -- If you have a logging system or want to announce the change, you can do it here.
    end
end)
