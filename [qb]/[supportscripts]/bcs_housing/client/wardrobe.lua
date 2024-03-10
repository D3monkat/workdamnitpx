if IsResourceStarted("menuv") then
	wardrobe_menu = MenuV:CreateMenu(Locale["wardrobe"], Locale["wardrobe_description"], "topright", 255, 0, 0,
		"size-100", "default", "menuv", "house_wardrobe", "native")
	wardrobe_change = MenuV:CreateMenu(Locale["wardrobe"], Locale["change_description"], "topright", 255, 0, 0,
		"size-100", "default", "menuv", "house_wardrobe_change", "native")
	wardrobe_delete = MenuV:CreateMenu(Locale["wardrobe"], Locale["delete_description"], "topright", 255, 0, 0,
		"size-100", "default", "menuv", "house_wardrobe_delete", "native")
elseif GetResourceState("ox_lib") == "started" then
	lib.registerContext({
		id = "wardrobe_menu",
		title = Locale["wardrobe"],
		onExit = function() end,
		options = {
			{
				title = Locale["change_outfit"],
				description = Locale["change_description"],
				event = "Housing:wardrobe_change",
			},
			{
				title = Locale["delete_outfit"],
				description = Locale["delete_description"],
				event = "Housing:wardrobe_delete",
			},
			{
				title = Locale["save_outfit"],
				event = "Housing:saveOutfit",
			},
		},
	})
end

AddEventHandler("Housing:saveOutfit", function()
	lib.hideContext()
	local name = RequestKeyboardInput(Locale["outfit_name"], Locale["outfit_desc"], 16)
	if name then
		if IsResourceStarted("fivem-appearance") or IsResourceStarted("illenium-appearance") then
			local appearance
			if IsResourceStarted("fivem-appearance") then
				appearance = exports["fivem-appearance"]:getPedAppearance(PlayerPedId())
			else
				appearance = exports["illenium-appearance"]:getPedAppearance(PlayerPedId())
			end
			TriggerServerEvent("Housing:saveOutfit", Home.identifier, name, appearance)
			Notify(Locale["wardrobe"], Locale["saved_outfit"], "success", 2500)
		else
			TriggerEvent("skinchanger:getSkin", function(skin)
				TriggerServerEvent("Housing:saveOutfit", Home.identifier, name, skin)
				Notify(Locale["wardrobe"], Locale["saved_outfit"], "success", 2500)
			end)
		end
	end
end)

AddEventHandler("Housing:wardrobe_change", function()
	lib.hideContext()
	lib.showMenu("wardrobe_change")
end)

AddEventHandler("Housing:wardrobe_delete", function()
	lib.hideContext()
	lib.showMenu("wardrobe_delete")
end)

function OpenWardrobe(identifier)
	TriggerServerCallback("Housing:getWardrobe", function(list)
		if IsResourceStarted("menuv") then
			wardrobe_menu:ClearItems()
			local change = wardrobe_menu:AddButton({ label = Locale["change_outfit"], value = wardrobe_change })
			local delete = wardrobe_menu:AddButton({ label = Locale["delete_outfit"], value = wardrobe_delete })
			wardrobe_change:ClearItems()
			wardrobe_delete:ClearItems()
			for i = 1, #list, 1 do
				local outfit_change = wardrobe_change:AddButton({ label = list[i] })
				local outfit_delete = wardrobe_delete:AddButton({ label = list[i] })
				outfit_change:On("select", function()
					TriggerServerCallback("Housing:getOutfit", function(clothes)
						if IsResourceStarted("fivem-appearance") or IsResourceStarted("illenium-appearance") then
							if not clothes.model then
								clothes.model = "mp_m_freemode_01"
							end
							if IsResourceStarted("fivem-appearance") then
								exports["fivem-appearance"]:setPlayerAppearance(clothes)
							else
								TriggerEvent('illenium-appearance:client:changeOutfit', clothes)
							end
							Notify(Locale["wardrobe"], Locale["loaded_outfit"], "success", 2500)
						else
							TriggerEvent("skinchanger:getSkin", function(skin)
								TriggerEvent("skinchanger:loadClothes", skin, clothes)
								TriggerEvent("esx_skin:setLastSkin", skin)

								TriggerEvent("skinchanger:getSkin", function(skin)
									TriggerServerEvent("esx_skin:save", skin)
									Notify(Locale["wardrobe"], Locale["loaded_outfit"], "success", 2500)
								end)
							end)
						end
						wardrobe_change:Close()
						wardrobe_menu:Close()
					end, identifier, list[i])
				end)
				outfit_delete:On("select", function()
					TriggerServerEvent("Housing:deleteOutfit", identifier, list[i])
					wardrobe_delete:Close()
					wardrobe_menu:Close()
				end)
			end
			local saveOutfit = wardrobe_menu:AddButton({ label = Locale["save_outfit"] })
			saveOutfit:On("select", function()
				local name = RequestKeyboardInput(Locale["outfit_name"], Locale["outfit_desc"], 16)
				if name and name ~= "" then
					if IsResourceStarted("fivem-appearance") or IsResourceStarted("illenium-appearance") then
						local appearance
						if IsResourceStarted("fivem-appearance") then
							appearance = exports["fivem-appearance"]:getPedAppearance(PlayerPedId())
						else
							appearance = exports["illenium-appearance"]:getPedAppearance(PlayerPedId())
						end
						TriggerServerEvent("Housing:saveOutfit", identifier, name, appearance)
						Notify(Locale["wardrobe"], Locale["saved_outfit"], "success", 2500)
					else
						TriggerEvent("skinchanger:getSkin", function(skin)
							TriggerServerEvent("Housing:saveOutfit", identifier, name, skin)
							Notify(Locale["wardrobe"], Locale["saved_outfit"], "success", 2500)
						end)
					end
				else
					Notify(Locale["wardrobe"], Locale["invalid_input"], "error", 3000)
				end
				wardrobe_menu:Close()
			end)
			wardrobe_menu:Open()
		elseif GetResourceState("ox_lib") == "started" then
			local options = {}
			for i = 1, #list, 1 do
				table.insert(options, { label = list[i] })
			end
			if #options == 0 then
				table.insert(options, { label = "No saved outfit" })
			end
			lib.registerMenu({
				id = "wardrobe_change",
				title = Locale["wardrobe"],
				position = "top-right",
				onSideScroll = function(selected, scrollIndex, args) end,
				onSelected = function(selected, scrollIndex, args) end,
				onClose = function() end,
				options = options,
			}, function(selected, scrollIndex, args)
				if #options > 0 then
					TriggerServerCallback("Housing:getOutfit", function(clothes)
						if IsResourceStarted("fivem-appearance") or IsResourceStarted("illenium-appearance") then
							if not clothes.model then
								clothes.model = "mp_m_freemode_01"
							end
							if IsResourceStarted("fivem-appearance") then
								exports["fivem-appearance"]:setPlayerAppearance(clothes)
							else
								TriggerEvent('illenium-appearance:client:changeOutfit', clothes)
							end
							Notify(Locale["wardrobe"], Locale["loaded_outfit"], "success", 2500)
						else
							TriggerEvent("skinchanger:getSkin", function(skin)
								TriggerEvent("skinchanger:loadClothes", skin, clothes)
								TriggerEvent("esx_skin:setLastSkin", skin)

								TriggerEvent("skinchanger:getSkin", function(skin)
									TriggerServerEvent("esx_skin:save", skin)
									Notify(Locale["wardrobe"], Locale["loaded_outfit"], "success", 2500)
								end)
							end)
						end
					end, identifier, options[selected].label)
				end
			end)
			lib.registerMenu({
				id = "wardrobe_delete",
				title = Locale["wardrobe"],
				position = "top-right",
				onSideScroll = function(selected, scrollIndex, args) end,
				onSelected = function(selected, scrollIndex, args) end,
				onClose = function() end,
				options = options,
			}, function(selected, scrollIndex, args)
				if #options > 0 then
					TriggerServerEvent("Housing:deleteOutfit", identifier, options[selected].label)
				end
			end)
			lib.showContext("wardrobe_menu")
		end
	end, identifier)
end

function WardrobePrompt(data, identifier)
	CreateThread(function()
		if hasKey(data, (Config.framework == "ESX" and PlayerData.identifier or PlayerData.citizenid)) then
			HelpText(true, Locale["prompt_open_wardrobe"])
			while inZone do
				Wait(2)
				if IsControlJustReleased(0, 38) then
					HelpText(false)
					if Config.framework == "QB" then
						TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
						TriggerEvent("qb-clothing:client:openOutfitMenu")
					else
						OpenWardrobe(identifier)
					end
					break
				end
			end
			while IsNuiFocused() do
				Wait(100)
			end
			Wait(1000)
			if inZone then
				WardrobePrompt(data, identifier)
			end
		end
	end)
end

RegisterCommand(commands.setwardrobe.name, function()
	local home = GetHomeObject(Home.identifier)
	if Home then
		if home.owner == (Config.framework == "ESX" and PlayerData.identifier or PlayerData.citizenid) then
			if Home.wardrobeZone then
				Home.wardrobeZone:destroy()
			end
			local coords = GetEntityCoords(PlayerPedId())
			local heading = GetEntityHeading(PlayerPedId())
			if Home.object or Home.type == "shell" then
				local houseCoords = GetEntityCoords(Home.object)
				local dist = coords - houseCoords
				home.wardrobe = {
					x = dist.x,
					y = dist.y,
					z = dist.z,
					w = heading,
				}
				local wardrobe = GetOffsetFromEntityInWorldCoords(Home.object, dist.x, dist.y, dist.z)
				Home.wardrobeZone = BoxZone:Create(vec3(wardrobe.x, wardrobe.y, wardrobe.z), 1.5, 1.5, {
					name = "wardrobe-" .. Home.identifier,
					heading = heading,
					debugPoly = Config.debug,
					minZ = wardrobe.z - 1.0,
					maxZ = wardrobe.z + 1.5,
				})
				Home.wardrobeZone:onPlayerInOut(function(isPointInside, point)
					if isPointInside then
						local data = home
						inZone = true
						WardrobePrompt(data, Home.identifier)
					else
						HelpText(false)
						inZone = false
					end
				end)
			else
				home.wardrobe = {
					x = coords.x,
					y = coords.y,
					z = coords.z,
					w = heading,
				}
				Home.wardrobeZone = BoxZone:Create(coords, 1.5, 1.5, {
					name = "wardrobe-" .. Home.identifier,
					heading = heading,
					debugPoly = Config.debug,
					minZ = coords.z - 1.0,
					maxZ = coords.z + 1.5,
				})
				Home.wardrobeZone:onPlayerInOut(function(isPointInside, point)
					if isPointInside then
						local data = home
						inZone = true
						WardrobePrompt(data, Home.identifier)
					else
						HelpText(false)
						inZone = false
					end
				end)
			end
			TriggerServerEvent("Housing:setWardrobe", home)
		end
	end
end)
