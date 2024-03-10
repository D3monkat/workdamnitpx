local placing = false
if IsResourceStarted("menuv") then
	furnishMenu = MenuV:CreateMenu("Furnish House", "Furnish your house!", "topright", 255, 0, 0, "size-100", "default",
		"menuv", "house_furnish", "native")
	sellmenu = MenuV:CreateMenu(Locale["sell_furniture"], "Sell your furnitures", "topright", 255, 0, 0, "size-100",
		"default", "menuv", "furniture_sell", "native")
end
---@diagnostic disable-next-line: missing-parameter
RegisterCommand(commands.furnish.name, function()
	if Home and Home.identifier then
		if
			hasKey(Home.identifier, Config.framework == "ESX" and PlayerData.identifier or PlayerData.citizenid)
			or (JobConfig.furnishOtherHouse and PlayerData.job and PlayerData.job.name == JobConfig.job_name)
		then
			TriggerEvent("Housing:furnish")
		else
			Notify(Locale["housing"], Locale["not_allowed"], "error", 2500)
		end
	else
		Notify(Locale["housing"], Locale["not_inside_home"], "error", 2500)
	end
end)

---@diagnostic disable-next-line: missing-parameter
RegisterCommand(commands.editfurniture.name, function()
	if Home and Home.identifier then
		if
			hasKey(Home.identifier, Config.framework == "ESX" and PlayerData.identifier or PlayerData.citizenid)
			or (JobConfig.furnishOtherHouse and PlayerData.job and PlayerData.job.name == JobConfig.job_name)
		then
			TriggerEvent("Housing:editFurniture")
		else
			Notify(Locale["housing"], Locale["not_allowed"], "error", 2500)
		end
	else
		Notify(Locale["housing"], Locale["not_inside_home"], "error", 2500)
	end
end)

AddEventHandler("Housing:furnish", function()
	TriggerServerCallback("Housing:getOwnedFurnitures", function(furnitures)
		local list = {}
		for k, v in pairs(furnitures) do
			if list[v.model] == nil then
				list[v.model] = { value = v, amount = 1 }
			else
				list[v.model].amount += 1
			end
		end
		if IsResourceStarted("menuv") then
			furnishMenu:ClearItems()
			sellmenu:ClearItems()
			local menu_button = furnishMenu:AddButton({ label = Locale["sell_furniture"], value = sellmenu })
			for k, v in pairs(list) do
				debugPrint("[Housing:furnish]", "furniture", v.value.label)
				local object = furnishMenu:AddButton({ label = v.value.label .. " x" .. v.amount })
				local object2 = sellmenu:AddButton({ label = v.value.label .. " x" .. v.amount })

				object:On("select", function()
					furnishMenu:Close()

					PlaceFurniture(v.value)
				end)
				object2:On("select", function()
					sellmenu:Close()
					furnishMenu:Close()

					TriggerServerEvent("Housing:sellFurniture", v.value)
				end)
			end

			furnishMenu:Open()
		elseif GetResourceState("ox_lib") then
			if next(list) ~= nil then
				local place_furn = {}
				place_furn[#place_furn + 1] = {
					label = Locale["sell_furniture"],
					args = { isSubmenu = true },
				}
				for k, v in pairs(list) do
					v.label = v.value.label .. " x" .. v.amount
					table.insert(place_furn, v)
				end
				local sell_furn = table.clone(place_furn)
				table.remove(sell_furn, 1)
				function openSellMenu()
					lib.hideMenu()
					lib.showMenu("sell_furniture")
				end

				lib.registerMenu({
					id = "furnish_menu",
					title = "Furnish House",
					position = "top-right",
					onSideScroll = function(selected, scrollIndex, args) end,
					onSelected = function(selected, scrollIndex, args) end,
					onClose = function() end,
					options = place_furn,
				}, function(selected, scrollIndex, args)
					if args and args.isSubmenu then
						CreateThread(openSellMenu)
					else
						PlaceFurniture(place_furn[selected].value)
					end
				end)
				lib.registerMenu({
					id = "sell_furniture",
					title = Locale["sell_furniture"],
					position = "top-right",
					onSideScroll = function(selected, scrollIndex, args) end,
					onSelected = function(selected, scrollIndex, args) end,
					onClose = function() end,
					options = sell_furn,
				}, function(selected, scrollIndex, args)
					TriggerServerEvent("Housing:sellFurniture", sell_furn[selected].value)
				end)
				lib.showMenu("furnish_menu")
			else
				Notify(Locale["housing"], Locale["no_furniture"], "error", 3000)
			end
		end
	end)
end)

---Create the prop and control the placement
---@param data any
---@param object number
---@param index number
function PlaceFurniture(data, object, index)
	debugPrint("[PlaceFurniture]", "Furniture model: " .. data.model)
	local moving = true
	if not object then
		moving = false
		LoadModel(data.model)
		object = CreateObjectNoOffset(data.model, GetEntityCoords(PlayerPedId()), false, false, false)
	end
	local initPos = GetEntityCoords(object)
	local initHeading = GetEntityHeading(object)
	local initRotation = GetEntityRotation(object)
	SetEntityCollision(object, false)
	SetEntityAlpha(object, 80)
	SetEntityDrawOutline(object, true)
	FreezeEntityPosition(object, true)
	debugPrint("[PlaceFurniture]", "Furniture spawned: " .. object)
	local moveSpeed = 0.01
	placing = true
	if IsResourceStarted("bcs_hud") then
		exports["bcs_hud"]:keybind({
			title = "Furnish House",
			items = {
				{
					description = Locale["keybind_place_furniture"],
					buttons = { "E" },
				},
				{
					description = Locale["keybind_cancel"],
					buttons = { "BACKSPACE" },
				},
				{
					description = Locale["keybind_leftright"],
					buttons = { "←", "→" },
				},
				{
					description = Locale["keybind_forward_backward"],
					buttons = { "↑", "↓" },
				},
				{
					description = Locale["keybind_change_height"],
					buttons = { "SCROLL" },
				},
				{
					description = Locale["keybind_put_object_floor"],
					buttons = { "Z" },
				},
				{
					description = Locale["keybind_rotate"],
					buttons = { ",", "." },
				},
				{
					description = Locale["keybind_change_speed"],
					buttons = { "CAPSLOCK", "L SHIFT" },
				},
				{
					description = Locale["keybind_pitch"],
					buttons = { "←", "→" },
				},
				{
					description = Locale["keybind_roll"],
					buttons = { "↑", "↓" },
				},
				{
					description = Locale["keybind_teleport"],
					buttons = { "`", "~" },
				},
			},
		})
	else
		displayHelp(Locale["prompt_furnish"], "bottom-right")
	end

	while placing do
		Wait(0)
		DisableControlAction(0, 20, true)
		if IsDisabledControlJustReleased(0, 20) then
			PlaceObjectOnGroundProperly(object)
		end

		if IsControlPressed(0, 171) then
			moveSpeed = moveSpeed + 0.005
		end
		if IsControlPressed(0, 254) then
			moveSpeed = moveSpeed - 0.005
		end
		if moveSpeed > 1.0 or moveSpeed < 0.01 then
			moveSpeed = 0.01
		end

		if IsControlPressed(0, 15) then
			SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, 0.0, 0.0, moveSpeed))
		end
		if IsControlPressed(0, 50) then
			SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, 0.0, 0.0, -moveSpeed))
		end

		-- Place confirm
		if IsControlJustReleased(0, 38) then
			SetEntityCollision(object, true)
			SetEntityDrawOutline(object, false)
			ResetEntityAlpha(object)

			local canPlace = ConfirmPlacement(object, data, index)
			if not canPlace then
				if moving then
					SetEntityCoordsNoOffset(object, initPos)
					SetEntityHeading(object, initHeading)
					SetEntityRotation(object, initRotation)
					SetEntityCollision(object, true)
					SetEntityDrawOutline(object, false)
					ResetEntityAlpha(object)
				else
					DeleteEntity(object)
				end
			end
			placing = false
		elseif IsControlJustReleased(0, 177) then
			placing = false
			if moving then
				SetEntityCoordsNoOffset(object, initPos)
				SetEntityHeading(object, initHeading)
				SetEntityCollision(object, true)
				SetEntityDrawOutline(object, false)
				ResetEntityAlpha(object)
			else
				DeleteEntity(object)
			end
		end

		-- Teleport object
		if IsControlJustReleased(0, 243) then
			SetEntityCoordsNoOffset(object, GetEntityCoords(PlayerPedId()))
		end

		-- Heading
		if IsControlPressed(0, 82) then
			SetEntityHeading(object, GetEntityHeading(object) - 0.5)
		elseif IsControlPressed(0, 81) then
			SetEntityHeading(object, GetEntityHeading(object) + 0.5)
		end

		-- Rotation
		if IsControlPressed(0, 21) and IsControlPressed(0, 189) then
			local rotation = GetEntityRotation(object)
			SetEntityRotation(object, rotation.x - 1.0, rotation.y, rotation.z)
		elseif IsControlPressed(0, 21) and IsControlPressed(0, 190) then
			local rotation = GetEntityRotation(object)
			SetEntityRotation(object, rotation.x + 1.0, rotation.y, rotation.z)
		elseif IsControlPressed(0, 21) and IsControlPressed(0, 187) then
			local rotation = GetEntityRotation(object)
			SetEntityRotation(object, rotation.x, rotation.y - 1.0, rotation.z)
		elseif IsControlPressed(0, 21) and IsControlPressed(0, 188) then
			local rotation = GetEntityRotation(object)
			SetEntityRotation(object, rotation.x, rotation.y + 1.0, rotation.z)
		end

		-- movement
		if IsControlPressed(0, 187) and not IsControlPressed(0, 21) and not IsControlPressed(0, 36) then -- down
			SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, 0.0, moveSpeed, 0.0))
		elseif IsControlPressed(0, 188) and not IsControlPressed(0, 21) and not IsControlPressed(0, 36) then -- up
			SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, 0.0, -moveSpeed, 0.0))
		elseif IsControlPressed(0, 189) and not IsControlPressed(0, 21) and not IsControlPressed(0, 36) then -- left
			SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, moveSpeed, 0.0, 0.0))
		elseif IsControlPressed(0, 190) and not IsControlPressed(0, 21) and not IsControlPressed(0, 36) then -- right
			SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(object, -moveSpeed, 0.0, 0.0))
		end
	end
	closeHelp()
end

---Search for the furniture in the home furniture table
---@param coords any
---@return boolean | number
---@return boolean | number
function SearchFurniture(coords)
	local home = GetHomeObject(Home.identifier)
	for k, v in pairs(home.furniture) do
		local furncoords
		if Home.type == "mlo" or v.frontyard then
			furncoords = vec3(home.entry.x, home.entry.y, home.entry.z) + vec3(v.coords.x, v.coords.y, v.coords.z)
		elseif Home.type == "ipl" then
			furncoords = vec3(Home.entryInside.x, Home.entryInside.y, Home.entryInside.z)
				+ vec3(v.coords.x, v.coords.y, v.coords.z)
		else
			furncoords = GetOffsetFromEntityInWorldCoords(Home.object, v.coords.x, v.coords.y, v.coords.z)
		end
		local dist = #(coords - furncoords)
		debugPrint("[SearchFurniture]", coords, furncoords, dist)
		if dist < 1.0 then
			return k, v
		end
	end
	return false, false
end

function EditFurniture()
	displayHelp("Press ~E~ to move<br>Press ~G~ to delete<br>Press ~BACKSPACE~ to cancel")
	local home = GetHomeObject(Home.identifier)
	while true do
		Wait(1)
		local ped = PlayerPedId()
		local _coords = GetEntityCoords(ped)
		local hit, coords, entity = RayCastGamePlayCamera(5000.0)
		DrawLine(_coords, coords, 255, 0, 0, 255)
		if IsEntityAnObject(entity) then
			DrawLine(_coords, coords, 0, 255, 34, 255)

			if IsControlJustReleased(0, 38) then
				local entCoords = GetEntityCoords(entity)
				local furnIndex, furnData = SearchFurniture(entCoords)

				if furnData then
					CreateThread(function()
						PlaceFurniture(furnData, entity, furnIndex)
					end)
					closeHelp()
					break
				else
					Notify(Locale["housing"], Locale["furniture_not_found"], "error", 3000)
				end
			end

			if IsControlJustReleased(0, 47) then
				local spawnIndex
				if inside or home.type == "mlo" then
					for k, v in pairs(home.spawnedObjects) do
						debugPrint("[editFurniture]", entity, v, k)
						if entity == v then
							spawnIndex = k
							break
						end
					end
				else
					for k, v in pairs(home.frontyardObjects) do
						debugPrint("[editFurniture]", entity, v, k)
						if entity == v then
							spawnIndex = k
							break
						end
					end
				end
				if spawnIndex then
					debugPrint("[editFurniture]", "Spawn Index: " .. spawnIndex)
					local entCoords = GetEntityCoords(entity)
					local furnIndex, furnData = SearchFurniture(entCoords)
					Notify(Locale["housing"], Locale["furniture_stored"], "error", 3000)
					if inside or home.type == "mlo" then
						table.remove(home.spawnedObjects, spawnIndex)
					else
						table.remove(home.frontyardObjects, spawnIndex)
					end
					table.remove(home.furniture, furnIndex)
					DeleteEntity(entity)
					TriggerServerEvent("Housing:storeFurniture", home, furnData)
					closeHelp()
					break
				end
			end
		end
		if IsControlJustReleased(0, 177) then
			if entity and IsEntityAnObject(entity) then
				SetEntityDrawOutline(entity, false)
			end
			closeHelp()
			break
		end
	end
end

AddEventHandler("Housing:editFurniture", EditFurniture)

---Confirm the prop placement
---@param object number
---@param data any
---@param moving boolean
---@return boolean
function ConfirmPlacement(object, data, moving)
	if not Home or (Home.type ~= "ipl" and not Home.polyzone and Home.frontyard and not next(Home.frontyard)) then
		TriggerEvent("Housing:notify", Locale["housing"], Locale["not_inside_home"], "error", 3000)
		return false
	end
	local insidePoly = (Home.polyzone and Home.polyzone:isPointInside(GetEntityCoords(object)))
		or (Home.frontyardZone and Home.frontyardZone:isPointInside(GetEntityCoords(object)))
		or false
	local insideFrontyard = Home.frontyardZone and Home.frontyardZone:isPointInside(GetEntityCoords(object)) or false
	if (Home.type == "mlo" and not insidePoly) or (Home.type ~= "mlo" and not inside and not insideFrontyard) then
		TriggerEvent("Housing:notify", Locale["housing"], Locale["not_inside_home"], "error", 3000)
		return false
	end
	local home = GetHomeObject(Home.identifier) or {}
	local furncoords = GetEntityCoords(object)
	local homecoords
	if Home.type == "mlo" or (insideFrontyard and not inside) then
		homecoords = Home.entry
	elseif Home.type == "ipl" then
		homecoords = Home.entryInside
	else
		homecoords = GetEntityCoords(Home.object)
	end
	local rotation = GetEntityRotation(object)
	local furniture = {
		coords = {
			x = round(furncoords.x - homecoords.x, 4),
			y = round(furncoords.y - homecoords.y, 4),
			z = round(furncoords.z - homecoords.z, 4),
		},
		heading = round(GetEntityHeading(object) - GetEntityHeading(Home.object), 4),
		rotation = { x = round(rotation.x, 2), y = round(rotation.y, 2), z = round(rotation.z, 2) },
		model = data.model,
		label = data.label,
		category = data.category,
		frontyard = insideFrontyard and not inside,
	}
	furniture.data = data.data
	if Config.furnitureStorage and Config.target and data.category == "Storage" then
		RemoveTargetEntity(object, "Open Storage")
		AddTargetEntity("storage:" .. Home.identifier .. ":" .. furniture.data.identifier, object, {
			options = {
				{
					identifier = "storage:" .. Home.identifier .. ":" .. furniture.data.identifier,
					owner = Home.owner,
					home = Home.identifier,
					event = "Housing:Storage",
					icon = "fas fa-box-open",
					label = "Open Storage",
					slots = furniture.data.slot or Config.DefaultSlots,
				},
			},
			distance = 3.5,
		})
	elseif Config.furnitureStorage and not Config.target and data.category == "Storage" then
		if Home["storage:" .. Home.identifier .. ":" .. furniture.data.identifier] then
			Home["storage:" .. Home.identifier .. ":" .. furniture.data.identifier]:destroy()
		end
		Home["storage:" .. Home.identifier .. ":" .. furniture.data.identifier] = BoxZone:Create(furncoords, 1.5, 1.5, {
			name = "storage:" .. Home.identifier .. ":" .. furniture.data.identifier,
			heading = GetEntityHeading(object),
			debugPoly = Config.debug,
			minZ = furncoords.z - 1.0,
			maxZ = furncoords.z + 2.0,
		})
		Home["storage:" .. Home.identifier .. ":" .. furniture.data.identifier]:onPlayerInOut(
			function(isPointInside, point)
				if isPointInside then
					HelpText(true, Locale["prompt_open_storage"])
					inZone = true
					CreateThread(function()
						while inZone do
							if IsControlJustPressed(0, 38) then
								HelpText(false)
								TriggerEvent("Housing:Storage", {
									identifier = "storage:" .. Home.identifier .. ":" .. furniture.data.identifier,
									owner = Home.owner,
									home = Home.identifier,
									slots = furniture.data.slot or Config.DefaultSlots,
								})
								break
							end
							Wait(0)
						end
					end)
				else
					HelpText(false)
					inZone = false
				end
			end
		)
	end
	if not moving then
		if inside or home.type == "mlo" then
			home.spawnedObjects[#home.spawnedObjects + 1] = object
		else
			home.frontyardObjects[#home.frontyardObjects + 1] = object
		end
		home.furniture[#home.furniture + 1] = furniture
	else
		home.furniture[moving] = furniture
	end
	TriggerServerEvent("Housing:placeFurniture", home, furniture)
	return true
end
