Utils = Utils or exports['lc_utils']:GetUtils()
local menu_active = false
local current_market_id = nil
local job_data = {}
local cooldown = nil
local cached_translations = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL
-----------------------------------------------------------------------------------------------------------------------------------------	

function createNPCsThread()
	if not Config.NPCs then return end
	Citizen.CreateThreadNow(function ()
		while true do
			for _, npc_data in pairs(Config.NPCs) do
				for _, pos in pairs(npc_data.pos) do
					local distance = #(GetEntityCoords(PlayerPedId()) - vec3(pos[1],pos[2],pos[3]-1))
					if distance < 50 then
						if not IsEntityAPed(pos.entity) then
							pos.entity = Utils.Peds.spawnPedAtCoords(npc_data.model, pos[1],pos[2],pos[3],pos[4], true, true, npc_data.emote)
						end
					elseif distance > 50 then
						if IsEntityAPed(pos.entity) then
							Utils.Peds.deletePed(pos.entity)
							pos.entity = nil
						end
					end
				end
			end
			Wait(2000)
		end
	end)
end

function createMarkersThread()
	for market_id,market_data in pairs(Config.market_locations) do
		-- Process owner markers
		Citizen.CreateThreadNow(function()
			local x,y,z = table.unpack(market_data.coord)
			while true do
				local timer = 1500
				if not menu_active then
					local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
					if distance < 10 then
						timer = 2
						Utils.Markers.createMarkerInCoords(market_id,x,y,z,cached_translations.open,openOwnerUiCallback,nil,distance)
					end
				end
				Wait(timer)
			end
		end)

		for _,customer_blip_location in pairs(market_data.sell_blip_coords) do
			-- Process customer markers
			Citizen.CreateThreadNow(function()
				local x,y,z = table.unpack(customer_blip_location)
				while true do
					local timer = 1500
					if not menu_active then
						local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
						if distance < 10 then
							timer = 2
							Utils.Markers.createMarkerInCoords(market_id,x,y,z,cached_translations.open_market,openCustomerUiCallback,nil,distance)
						end
					end
					Wait(timer)
				end
			end)
		end

		if not Config.trucker_logistics.enable then
			-- Process deliveryman markers
			Citizen.CreateThreadNow(function()
				local x,y,z = table.unpack(market_data.deliveryman_coord)
				while true do
					local timer = 1500
					if not menu_active then
						local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
						if distance < 10 then
							timer = 2
							renderDeliverymanJobBlip(market_id,x,y,z,distance)
						end
					end
					Wait(timer)
				end
			end)
		end
	end
end

function createTargetsThread()
	Citizen.CreateThreadNow(function()
		for market_id,market_data in pairs(Config.market_locations) do
			local x,y,z = table.unpack(market_data.coord)
			Utils.Target.createTargetInCoords(market_id,x,y,z,openOwnerUiCallback,cached_translations.open_target,"fas fa-shop","#2986cc")

			for customer_blip_id,customer_blip_location in pairs(market_data.sell_blip_coords) do
				local x,y,z = table.unpack(customer_blip_location)
				Utils.Target.createTargetInCoords(market_id,x,y,z,openCustomerUiCallback,cached_translations.open_market_target,"fas fa-shopping-cart","#2986cc",market_id .. ":" .. customer_blip_id)
			end
		end

		if not Config.trucker_logistics.enable then
			for market_id,market_data in pairs(Config.market_locations) do
				Citizen.CreateThreadNow(function()
					local x,y,z = table.unpack(market_data.deliveryman_coord)
					while true do
						local timer = 1500
						if not menu_active then
							local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
							if distance < 10 then
								timer = 2
								renderDeliverymanJobBlip(market_id,x,y,z,distance)
							end
						end
						Wait(timer)
					end
				end)
			end
		end
	end)
end

function renderDeliverymanJobBlip(market_id,x,y,z,distance)
	Utils.Markers.drawMarker(21,x,y,z)
	if distance < 1.0 then
		if job_data[market_id] == nil then
			Utils.Markers.drawText3D(x,y,z-0.6, cached_translations.download_jobs)
			if IsControlJustPressed(0,38) then
				TriggerServerEvent('stores:loadJobData',market_id)
			end
		else
			Utils.Markers.drawText3D(x,y,z-0.6, cached_translations.show_jobs:format(job_data[market_id].name,job_data[market_id].reward))
			if IsControlJustPressed(0,38) then
				if canStartJob(market_id) then
					current_market_id = market_id
					TriggerServerEvent('stores:startDeliverymanJob',current_market_id,job_data[market_id].id)
				end
			end
		end
	else
		job_data[market_id] = nil
	end
end

function openOwnerUiCallback(market_id)
	current_market_id = market_id
	TriggerServerEvent("stores:getData",current_market_id)
end

function openCustomerUiCallback(market_id)
	current_market_id = market_id
	TriggerServerEvent("stores:openMarket",current_market_id)
end

RegisterNetEvent('stores:setJobData')
AddEventHandler('stores:setJobData', function(market_id,data)
	job_data[market_id] = data
end)

RegisterNetEvent('stores:open')
AddEventHandler('stores:open', function(dados,update,isMarket)
	TriggerScreenblurFadeIn(1000)
	SendNUIMessage({
		showmenu = true,
		update = update,
		isMarket = isMarket,
		dados = dados,
		utils = { config = Utils.Config, lang = Utils.Lang },
		resourceName = GetCurrentResourceName()
	})
	if update == false then
		menu_active = true
		SetNuiFocus(true,true)
	end
end)

RegisterNetEvent('stores:openRequest')
AddEventHandler('stores:openRequest', function(price, market_categories)
	SendNUIMessage({
		showmenu = true,
		price = price,
		market_categories = market_categories,
		utils = { config = Utils.Config, lang = Utils.Lang },
		resourceName = GetCurrentResourceName(),
	})
	SetNuiFocus(true,true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback('post', function(body, cb)
	if cooldown == nil then
		cooldown = true

		if body.event == "changeTheme" then
			exports['lc_utils']:changeTheme(body.data.dark_theme)
		end
		if body.event == "close" then
			closeUI()
		elseif (body.event == "startImportJob" or body.event == "startExportJob") and not canStartJob(current_market_id) then
			-- Do nothing :)
		else
			TriggerServerEvent('stores:'..body.event,current_market_id,body.event,body.data)
		end
		cb(200)

		SetTimeout(100,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('loadBalanceHistory', function(body, cb)
	Utils.Callback.TriggerServerCallback('stores:loadBalanceHistory', function(store_balance)
		cb(store_balance)
	end,current_market_id,body.data)
end)

RegisterNUICallback('close', function(data, cb)
	closeUI()
	cb(200)
end)

RegisterNetEvent('stores:closeUI')
AddEventHandler('stores:closeUI', function()
	closeUI()
end)

function closeUI()
	current_market_id = nil
	menu_active = false
	SetNuiFocus(false,false)
	SendNUIMessage({ hidemenu = true })
	TriggerScreenblurFadeOut(1000)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('stores:startJob')
AddEventHandler('stores:startJob', function(truck_level,is_import)
	local key = current_market_id
	job_data[key] = nil

	local destination
	if is_import then
		destination = vector3(table.unpack(Config.delivery_locations[math.random(#Config.delivery_locations)]))
	else
		destination = vector3(table.unpack(Config.export_locations[math.random(#Config.export_locations)]))
	end
	local distance_traveled = Utils.Math.round(((#(GetEntityCoords(PlayerPedId()) - destination) * 2)/1000), 2)
	local route_blip = Utils.Blips.createBlipForCoords(destination.x,destination.y,destination.z,Config.route_blip.id,Config.route_blip.color,Utils.translate('blip_route'),0.8,true)

	local garage_coord = vector4(table.unpack(Config.market_locations[key]['garage_coord']))
	local truck_model = Config.market_types[Config.market_locations[key].type].trucks[truck_level]
	local blip_data = { name = Utils.translate('truck_blip'), sprite = 477, color = 26 }
	local properties = { plate = Utils.Vehicles.generateTempVehiclePlateWithPrefix(GetCurrentResourceName()) }
	local truck_vehicle,truck_blip = Utils.Vehicles.spawnVehicle(truck_model,garage_coord.x,garage_coord.y,garage_coord.z,garage_coord.w,blip_data,properties)
	exports['lc_utils']:notify("success",Utils.translate('already_is_in_garage'))

	closeUI()
	local object = nil
	local delivery_phase = 1
	local timer = 2000
	while IsEntityAVehicle(truck_vehicle) do
		timer = 2000
		local ped = PlayerPedId()
		local current_vehicle = GetVehiclePedIsIn(ped,false)

		if delivery_phase == 1 then
			if is_import then
				local distance = #(GetEntityCoords(PlayerPedId()) - destination)
				if distance <= 50 then
					timer = 2
					Utils.Markers.drawMarker(39,destination.x,destination.y,destination.z,1.0)
					if distance <= 2 then
						Utils.Markers.drawText3D(destination.x,destination.y,destination.z-0.6, Utils.translate('objective_marker'))
						if IsControlJustPressed(0,38) then
							if not (IsPedSittingInAnyVehicle(ped) or IsPedInAnyVehicle(ped, true)) then
								object = createObjectAttachedToEntity("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
								SetVehicleDoorOpen(truck_vehicle,2,false,false)
								SetVehicleDoorOpen(truck_vehicle,3,false,false)
								SetVehicleDoorOpen(truck_vehicle,5,false,false)

								Utils.Blips.removeBlip(route_blip)
								delivery_phase = 2

								exports['lc_utils']:notify("success",Utils.translate('bring_to_van'))
							else
								exports['lc_utils']:notify("error",Utils.translate('out_of_veh'))
							end
						end
					end
				end
			else
				local distance = #(GetEntityCoords(PlayerPedId()) - destination)
				if current_vehicle == truck_vehicle and distance <= 50 then
					timer = 2
					Utils.Markers.drawMarker(39,destination.x,destination.y,destination.z,1.0)
					if distance <= 2 then
						Utils.Markers.drawText2D(Utils.translate('objective_marker_3'),8,0.5,0.95,0.50,255,255,255,235)
						if IsControlJustPressed(0,38) then
							BringVehicleToHalt(truck_vehicle, 2.5, 1, false)
							Citizen.Wait(10)
							DoScreenFadeOut(500)
							Citizen.Wait(500)
							Utils.Blips.removeBlip(route_blip)
							route_blip = Utils.Blips.createBlipForCoords(garage_coord.x,garage_coord.y,garage_coord.z,Config.route_blip.id,Config.route_blip.color,Utils.translate('blip_route'),0.8,true)
							delivery_phase = 3
							PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", false)
							Citizen.Wait(1000)
							DoScreenFadeIn(1000)
							Utils.Scaleform.showScaleform(Utils.translate('sucess_2'), Utils.translate('sucess_in_progess_2'), 3)
						end
					end
				end
			end
		elseif delivery_phase == 2 then
			if is_import then
				local xa,ya,za = table.unpack(GetWorldPositionOfEntityBone(truck_vehicle,GetEntityBoneIndexByName(truck_vehicle,"door_dside_r")))
				local xb,yb,zb = table.unpack(GetWorldPositionOfEntityBone(truck_vehicle,GetEntityBoneIndexByName(truck_vehicle,"door_pside_r")))
				local vehicle_trunk = vector3((xa+xb)/2,(ya+yb)/2,((za+zb)/2)-1.0)
				local distance = #(GetEntityCoords(ped) - vehicle_trunk)

				if distance <= 50 then
					timer = 2
					Utils.Markers.drawMarker(39,vehicle_trunk.x,vehicle_trunk.y,vehicle_trunk.z+1.5,1.0)
					if distance <= 2.0 then
						Utils.Markers.drawText3D(vehicle_trunk.x,vehicle_trunk.y,vehicle_trunk.z+1.0, Utils.translate('objective_marker_2'))
						if IsControlJustPressed(0,38) then
							if not (IsPedSittingInAnyVehicle(ped) or IsPedInAnyVehicle(ped, true))  then
								deleteObject(object)
								route_blip = Utils.Blips.createBlipForCoords(garage_coord.x,garage_coord.y,garage_coord.z,Config.route_blip.id,Config.route_blip.color,Utils.translate('blip_route'),0.8,true)
								delivery_phase = 3

								exports['lc_utils']:notify("success",Utils.translate('bring_to_store'))

								SetTimeout(3000,function()
									SetVehicleDoorShut(truck_vehicle,2,false)
									SetVehicleDoorShut(truck_vehicle,3,false)
									SetVehicleDoorShut(truck_vehicle,5,false)
								end)
							else
								exports['lc_utils']:notify("error",Utils.translate('out_of_veh'))
							end
						end
					end
				end
			end
		elseif delivery_phase == 3 then
			local distance = #(GetEntityCoords(ped) - garage_coord.xyz)
			if distance <= 50 and current_vehicle == truck_vehicle then
				timer = 2
				Utils.Markers.drawMarker(39,garage_coord.x,garage_coord.y,garage_coord.z+1.5,1.0)
				if distance <= 4 then
					BringVehicleToHalt(truck_vehicle, 2.5, 1, false)
					Citizen.Wait(10)
					DoScreenFadeOut(500)
					Citizen.Wait(500)
					Utils.Blips.removeBlip(truck_blip)
					Utils.Blips.removeBlip(route_blip)
					Utils.Vehicles.deleteVehicle(truck_vehicle)
					PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", false)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
					if is_import then
						Utils.Scaleform.showScaleform(Utils.translate('sucess'), Utils.translate('sucess_finished'), 3)
						TriggerServerEvent("stores:finishImportJob",key,distance_traveled)
					else
						Utils.Scaleform.showScaleform(Utils.translate('sucess_2'), Utils.translate('sucess_finished_2'), 3)
						TriggerServerEvent("stores:finishExportJob",key,distance_traveled)
					end
					return
				end
			end
		end

		local vehicles = { truck_vehicle }
		local peds = { ped }
		local has_error, error_message = Utils.Entity.isThereSomethingWrongWithThoseBoys(vehicles,peds)
		if has_error then
			deleteObject(object)
			Utils.Vehicles.removeKeysFromPlate(truck_vehicle,truck_model)
			Utils.Blips.removeBlip(truck_blip)
			Utils.Blips.removeBlip(route_blip)
			PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", false)
			if Utils.Table.contains({'vehicle_almost_destroyed','vehicle_undriveable','ped_is_dead'}, error_message) then
				SetVehicleEngineHealth(truck_vehicle,-4000)
				SetVehicleUndriveable(truck_vehicle,true)
			end
			if error_message == 'ped_is_dead' then
				exports['lc_utils']:notify("error",Utils.translate('you_died'))
			else
				exports['lc_utils']:notify("error",Utils.translate('vehicle_destroyed'))
			end
			TriggerServerEvent("stores:failed")
			return
		end

		Citizen.Wait(timer)
	end
	deleteObject(object)
	Utils.Blips.removeBlip(truck_blip)
	Utils.Blips.removeBlip(route_blip)
	exports['lc_utils']:notify("error",Utils.translate('vehicle_destroyed'))
	TriggerServerEvent("stores:failed")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- createObjectAttachedToEntity
-----------------------------------------------------------------------------------------------------------------------------------------

function createObjectAttachedToEntity(dict,anim,prop,flag,hand)
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Citizen.Wait(10)
	end

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end

	TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,false,false,false)
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
	local object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
	SetEntityCollision(object,false,false)
	AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
	return object
end

function deleteObject(object)
	if DoesEntityExist(object) and IsEntityAnObject(object) then
		Utils.Animations.stopPlayerAnim(true)
		SetEntityAsMissionEntity(object, false, true)
		DeleteObject(object)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- createBlips
-----------------------------------------------------------------------------------------------------------------------------------------

local market_blips = {}

Citizen.CreateThread(function()
	Wait(5000)
	TriggerServerEvent("stores:getBlips")
end)

RegisterNetEvent('stores:setBlips')
AddEventHandler('stores:setBlips', function(blips_table)
	for k,v in pairs(Config.market_locations) do
		if v.map_blip_coord then
			local x,y,z = table.unpack(v.map_blip_coord)
			local blips = Config.market_types[v.type].blips
			if blips_table[k] and blips_table[k].market_blip and blips_table[k].market_name and blips_table[k].market_color then
				market_blips[k] = Utils.Blips.createBlipForCoords(x,y,z,tonumber(blips_table[k].market_blip),tonumber(blips_table[k].market_color),blips_table[k].market_name,blips.scale)
			else
				market_blips[k] = Utils.Blips.createBlipForCoords(x,y,z,blips.id,blips.color,blips.name,blips.scale)
			end
			if Config.group_map_blips then
				SetBlipCategory(market_blips[k],10)
			end
		end
	end
end)

RegisterNetEvent('stores:updateBlip')
AddEventHandler('stores:updateBlip', function(key,name,color,blip)
	if Config.market_locations[key].map_blip_coord then
		Utils.Blips.removeBlip(market_blips[key])
		local x,y,z = table.unpack(Config.market_locations[key].map_blip_coord)
		local blips = Config.market_types[Config.market_locations[key].type].blips
		market_blips[key] = Utils.Blips.createBlipForCoords(x,y,z,tonumber(blip),tonumber(color),name,blips.scale)
		if Config.group_map_blips then
			SetBlipCategory(market_blips[key],10)
		end
	end
end)

function canStartJob(market_id)
	local x,y,z = table.unpack(Config.market_locations[market_id]['garage_coord'])
	local isSpawnPointClear = Utils.Vehicles.isSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
	if isSpawnPointClear == false then
		exports['lc_utils']:notify("error",Utils.translate('occupied_places'))
		return false
	end
	return true
end

RegisterNetEvent('stores:Notify')
AddEventHandler('stores:Notify', function(type,message)
	exports['lc_utils']:notify(type,message)
end)

Citizen.CreateThread(function()
	Wait(1000)
	SetNuiFocus(false,false)

	Utils.loadLanguageFile(Lang)

	cached_translations = {
		open = Utils.translate('open'),
		open_market = Utils.translate('open_market'),
		open_target = Utils.translate('open_target'),
		open_market_target = Utils.translate('open_market_target'),
		show_jobs = Utils.translate('show_jobs'),
		download_jobs = Utils.translate('download_jobs'),
	}

	for k, _ in pairs(Config.export_locations) do
		if Config.export_locations[k][4] then
			Config.export_locations[k][4] = nil
		end
	end
	for k, _ in pairs(Config.delivery_locations) do
		if Config.delivery_locations[k][4] then
			Config.delivery_locations[k][4] = nil
		end
	end

	if Utils.Config.custom_scripts_compatibility.target == "disabled" then
		createMarkersThread()
	else
		createTargetsThread()
	end
	createNPCsThread()
end)

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end

	deleteAllPeds()
	deleteAllBlips()
end)

function deleteAllBlips()
	for k, v in pairs(market_blips) do
		Utils.Blips.removeBlip(market_blips[k])
		market_blips[k] = nil
	end
end

function deleteAllPeds()
	if not Config.NPCs then return end
	for _, npc_data in pairs(Config.NPCs) do
		for _, pos in pairs(npc_data.pos) do
			if IsEntityAPed(pos.entity) then
				Utils.Peds.deletePed(pos.entity)
				pos.entity = nil
			end
		end
	end
end