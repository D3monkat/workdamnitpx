RegisterNetEvent('illenium-appearance:client:applyOutfit', function(outfitData)
    local ped = PlayerPedId()

    -- Make sure the player's ped is valid and the outfit data is not nil
    if ped and outfitData then
        -- Example of applying the outfit
        -- This is a simplified example; you'll need to adjust it to fit the Illenium appearance system's API
        for component, value in pairs(outfitData) do
            if component == "torso_1" then
                SetPedComponentVariation(ped, 11, value, 0, 2) -- 11 is the component ID for torso in GTA V
            elseif component == "torso_2" then
                SetPedComponentVariation(ped, 11, GetPedDrawableVariation(ped, 11), value, 2) -- Adjusting the texture of the torso component
            end
            -- Add more conditions for other components like pants, shoes, etc., following the pattern above.
        end

        -- Notify the player of the change
        QBCore.Functions.Notify("Outfit applied successfully!", "success")
    else
        -- Error handling if the ped is invalid or outfitData is nil
        QBCore.Functions.Notify("Failed to apply outfit.", "error")
    end
end)
