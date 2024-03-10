Utils = Utils or exports['lc_utils']:GetUtils()
local menu_active = false
local current_gas_station_id = nil
local job_data = {}
local cooldown = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL
-----------------------------------------------------------------------------------------------------------------------------------------	

function createMarkersThread()
	for gas_station_id,gas_station_data in pairs(Config.gas_station_locations) do
		-- Process owner markers
		Citizen.CreateThreadNow(function()
			local x,y,z = table.unpack(gas_station_data.coord)
			while true do
				local timer = 1500
				if not menu_active then
					local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
					if distance < 10 then
						timer = 2
						Utils.Markers.createMarkerInCoords(gas_station_id,x,y,z,Utils.translate('open'),openOwnerUiCallback,nil,distance)
					end
				end
				Wait(timer)
			end
		end)

		if not Config.trucker_logistics.enable then
			-- Process deliveryman markers
			Citizen.CreateThreadNow(function()
				local x,y,z = table.unpack(gas_station_data.deliveryman_coord)
				while true do
					local timer = 1500
					if not menu_active then
						local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
						if distance < 10 then
							timer = 2
							renderDeliverymanJobBlip(gas_station_id,x,y,z,distance)
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
		for gas_station_id,gas_station_data in pairs(Config.gas_station_locations) do
			local x,y,z = table.unpack(gas_station_data.coord)
			Utils.Target.createTargetInCoords(gas_station_id,x,y,z,openOwnerUiCallback,Utils.translate('open_target'),"fas fa-gas-pump","#2986cc")
		end

		if not Config.trucker_logistics.enable then
			for gas_station_id,gas_station_data in pairs(Config.gas_station_locations) do
				Citizen.CreateThreadNow(function()
					local x,y,z = table.unpack(gas_station_data.deliveryman_coord)
					while true do
						local timer = 1500
						if not menu_active then
							local distance = #(GetEntityCoords(PlayerPedId()) - vector3(x,y,z))
							if distance < 10 then
								timer = 2
								renderDeliverymanJobBlip(gas_station_id,x,y,z,distance)
							end
						end
						Wait(timer)
					end
				end)
			end
		end
	end)
end

function renderDeliverymanJobBlip(gas_station_id,x,y,z,distance)
	Utils.Markers.drawMarker(21,x,y,z)
	if distance < 1.0 then
		if job_data[gas_station_id] == nil then
			Utils.Markers.drawText3D(x,y,z-0.6, Utils.translate('download_jobs'))
			if IsControlJustPressed(0,38) then
				TriggerServerEvent('gas_station:loadJobData',gas_station_id)
			end
		else
			Utils.Markers.drawText3D(x,y,z-0.6, Utils.translate('show_jobs'):format(job_data[gas_station_id].name,job_data[gas_station_id].reward))
			if IsControlJustPressed(0,38) then
				if canStartJob(gas_station_id) then
					current_gas_station_id = gas_station_id
					TriggerServerEvent('gas_station:startDeliverymanJob',gas_station_id,job_data[gas_station_id].id)
				end
			end
		end
	else
		job_data[gas_station_id] = nil
	end
end

function openOwnerUiCallback(gas_station_id)
	current_gas_station_id = gas_station_id
	TriggerServerEvent("gas_station:getData",current_gas_station_id)
end

RegisterNetEvent('gas_station:setJobData')
AddEventHandler('gas_station:setJobData', function(gas_station_id,data)
	job_data[gas_station_id] = data
end)

RegisterNetEvent('gas_station:open')
AddEventHandler('gas_station:open', function(dados,update)
	TriggerScreenblurFadeIn(1000)
	SendNUIMessage({ 
		showmenu = true,
		update = update,
		dados = dados,
		utils = { config = Utils.Config, lang = Utils.Lang },
		resourceName = GetCurrentResourceName()
	})
	if update == false then
		menu_active = true
		SetNuiFocus(true,true)
	end
end)

RegisterNetEvent('gas_station:openRequest')
AddEventHandler('gas_station:openRequest', function(price)
	SendNUIMessage({ 
		showmenu = true,
		price = price,
		utils = { config = Utils.Config, lang = Utils.Lang },
		resourceName = GetCurrentResourceName()
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
		elseif (body.event == "startContract") and not canStartJob(current_gas_station_id) then
			-- Do nothing :)
		else
			TriggerServerEvent('gas_station:'..body.event,current_gas_station_id,body.event,body.data)
		end
		cb(200)

		SetTimeout(100,function()
			cooldown = nil
		end)
	end
end)

RegisterNUICallback('loadBalanceHistory', function(data, cb)
	Utils.Callback.TriggerServerCallback('gas_station:loadBalanceHistory', function(gas_station_balance)
		cb(gas_station_balance)
	end,current_gas_station_id,data)
end)

RegisterNUICallback('close', function(data, cb)
	closeUI()
	cb(200)
end)

RegisterNetEvent('gas_station:closeUI')
AddEventHandler('gas_station:closeUI', function()
	closeUI()
end)

function closeUI()
	current_gas_station_id = nil
	menu_active = false
	SetNuiFocus(false,false)
	SendNUIMessage({ hidemenu = true })
	TriggerScreenblurFadeOut(1000)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('gas_station:startContract')
AddEventHandler('gas_station:startContract', function(truck_level,ressuply_id,type)
	local key = current_gas_station_id
	job_data[key] = nil

	local rand
	local destination
	local distance_traveled
	local cont = 0
	repeat
		rand = math.random(#Config.delivery_locations)
		destination = vector3(table.unpack(Config.delivery_locations[rand]))
		distance_traveled = Utils.Math.round(((#(GetEntityCoords(PlayerPedId()) - destination) * 2)/1000), 2)
		cont = cont + 1
		if cont >= (#Config.delivery_locations*2) then
			exports['lc_utils']:notify("error",Utils.translate('not_found_location'))
			return
		end
	until IsInsideDistance(key,distance_traveled,ressuply_id)
	local route_blip = Utils.Blips.createBlipForCoords(destination.x,destination.y,destination.z,Config.route_blip.id,Config.route_blip.color,Utils.translate('blip_route'),0.8,true)

	local garage_coord = vector4(table.unpack(Config.gas_station_locations[key]['truck_coord']))
	local truck_model = Config.trucks[truck_level].truck
	local blip_data = { name = Utils.translate('truck_blip'), sprite = 477, color = 26 }
	local properties = { plate = Utils.Vehicles.generateTempVehiclePlateWithPrefix(GetCurrentResourceName()) }
	local truck_vehicle,truck_blip = Utils.Vehicles.spawnVehicle(truck_model,garage_coord.x,garage_coord.y,garage_coord.z,garage_coord.w,blip_data,properties)

	local trailer_vehicle,trailer_blip
	local trailer_model = Config.trucks[truck_level].trailer
	if Config.trucks[truck_level].trailer then
		local tgarage_coord = vector4(table.unpack(Config.gas_station_locations[key]['trailer_coord']))
		local tblip_data = { name = Utils.translate('truck_blip'), sprite = 479, color = 26 }
		local tproperties = { plate = Utils.Vehicles.generateTempVehiclePlateWithPrefix(GetCurrentResourceName()) }
		trailer_vehicle,trailer_blip = Utils.Vehicles.spawnVehicle(trailer_model,tgarage_coord.x,tgarage_coord.y,tgarage_coord.z,tgarage_coord.w,tblip_data,tproperties)
	end
	exports['lc_utils']:notify("success",Utils.translate('already_is_in_garage'))

	closeUI()
	local delivery_phase = 1
	local timer = 2000
	while IsEntityAVehicle(truck_vehicle) and (Config.trucks[truck_level].trailer == nil or IsEntityAVehicle(trailer_vehicle)) do
		timer = 2000
		local ped = PlayerPedId()
		local current_vehicle = GetVehiclePedIsIn(ped,false)

		if delivery_phase == 1 then
			local distance = #(GetEntityCoords(ped) - destination)
			if distance <= 50 and current_vehicle == truck_vehicle and (IsEntityAVehicle(trailer_vehicle) == false or IsEntityAttachedToEntity(truck_vehicle,trailer_vehicle)) then
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
						delivery_phase = 2
						PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", false)
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
						Utils.Scaleform.showScaleform(Utils.translate('sucess_2'), Utils.translate('sucess_in_progess_2'), 3)
					end
				end
			end
		elseif delivery_phase == 2 then
			local distance = #(GetEntityCoords(ped) - garage_coord.xyz)
			if distance <= 50 and current_vehicle == truck_vehicle and (IsEntityAVehicle(trailer_vehicle) == false or IsEntityAttachedToEntity(truck_vehicle,trailer_vehicle)) then
				timer = 2
				Utils.Markers.drawMarker(39,garage_coord.x,garage_coord.y,garage_coord.z,1.0)
				if distance <= 4 then
					BringVehicleToHalt(truck_vehicle, 2.5, 1, false)
					Citizen.Wait(10)
					DoScreenFadeOut(500)
					Citizen.Wait(500)
					Utils.Vehicles.deleteVehicle(truck_vehicle)
					Utils.Vehicles.deleteVehicle(trailer_vehicle)
					Utils.Blips.removeBlip(truck_blip)
					Utils.Blips.removeBlip(trailer_blip)
					Utils.Blips.removeBlip(route_blip)
					PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", false)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
					Utils.Scaleform.showScaleform(Utils.translate('sucess_2'), Utils.translate('sucess_finished_2'), 3)
					TriggerServerEvent("gas_station:finishContract",key,ressuply_id,distance_traveled,type)
					return
				end
			end
		end

		local vehicles = { truck_vehicle, trailer_vehicle }
		local peds = { ped }
		local has_error, error_message = Utils.Entity.isThereSomethingWrongWithThoseBoys(vehicles,peds)
		if has_error then
			Utils.Vehicles.removeKeysFromPlate(truck_vehicle, truck_model)
			Utils.Vehicles.removeKeysFromPlate(trailer_vehicle, trailer_model)
			Utils.Blips.removeBlip(truck_blip)
			Utils.Blips.removeBlip(trailer_blip)
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
			TriggerServerEvent("gas_station:failed")
			return
		end
		Citizen.Wait(timer)
	end
	Utils.Blips.removeBlip(truck_blip)
	Utils.Blips.removeBlip(trailer_blip)
	Utils.Blips.removeBlip(route_blip)
	if IsEntityAVehicle(truck_vehicle) then
		SetVehicleEngineHealth(truck_vehicle,-4000)
		SetVehicleUndriveable(truck_vehicle,true)
	end
	if IsEntityAVehicle(trailer_vehicle) then
		SetVehicleEngineHealth(trailer_vehicle,-4000)
		SetVehicleUndriveable(trailer_vehicle,true)
	end
	exports['lc_utils']:notify("error",Utils.translate('vehicle_destroyed'))
	TriggerServerEvent("gas_station:failed")
end)

function IsInsideDistance(key,distance_traveled,ressuply_id)
	return distance_traveled <= Config.gas_station_types[Config.gas_station_locations[key].type].ressuply[ressuply_id].max_distance
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- createBlips
-----------------------------------------------------------------------------------------------------------------------------------------

local gas_station_blips = {}

Citizen.CreateThread(function()
	Wait(5000)
	TriggerServerEvent("gas_station:getBlips")
end)

RegisterNetEvent('gas_station:setBlips')
AddEventHandler('gas_station:setBlips', function(blips_table)
	for k,v in pairs(Config.gas_station_locations) do
		if v.map_blip_coord then
			local x,y,z = table.unpack(v.map_blip_coord)
			local blips = Config.gas_station_types[v.type].blips
			if blips_table[k] and blips_table[k].gas_station_blip and blips_table[k].gas_station_name and blips_table[k].gas_station_color then
				gas_station_blips[k] = Utils.Blips.createBlipForCoords(x,y,z,tonumber(blips_table[k].gas_station_blip),tonumber(blips_table[k].gas_station_color),blips_table[k].gas_station_name,blips.scale)
			else
				gas_station_blips[k] = Utils.Blips.createBlipForCoords(x,y,z,blips.id,blips.color,blips.name,blips.scale)
			end
			if Config.group_map_blips then
				SetBlipCategory(gas_station_blips[k],10)
			end
		end
	end
end)

RegisterNetEvent('gas_station:updateBlip')
AddEventHandler('gas_station:updateBlip', function(key,name,color,blip)
	if Config.gas_station_locations[key].map_blip_coord then
		Utils.Blips.removeBlip(gas_station_blips[key])
		local x,y,z = table.unpack(Config.gas_station_locations[key].map_blip_coord)
		local blips = Config.gas_station_types[Config.gas_station_locations[key].type].blips
		gas_station_blips[key] = Utils.Blips.createBlipForCoords(x,y,z,tonumber(blip),tonumber(color),name,blips.scale)
		if Config.group_map_blips then
			SetBlipCategory(gas_station_blips[key],10)
		end
	end
end)

function canStartJob(gas_station_id)
	local x,y,z = table.unpack(Config.gas_station_locations[gas_station_id]['truck_coord'])
	local isTruckSpawnPointClear = Utils.Vehicles.isSpawnPointClear({['x']=x,['y']=y,['z']=z},5.001)
	if isTruckSpawnPointClear == false then
		exports['lc_utils']:notify("error",Utils.translate('occupied_places'))
		return false
	else
		local x2,y2,z2 = table.unpack(Config.gas_station_locations[gas_station_id]['trailer_coord'])
		local isTrailerSpawnPointClear = Utils.Vehicles.isSpawnPointClear({['x']=x2,['y']=y2,['z']=z2},5.001)
		if isTrailerSpawnPointClear == false then
			exports['lc_utils']:notify("error",Utils.translate('occupied_places'))
			return false
		end
	end
	return true
end

RegisterNetEvent('gas_station:Notify')
AddEventHandler('gas_station:Notify', function(type,message)
	exports['lc_utils']:notify(type,message)
end)

Citizen.CreateThread(function()
	Wait(1000)
	SetNuiFocus(false,false)

	Utils.loadLanguageFile(Lang)

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
end)

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end

	deleteAllBlips()
end)

function deleteAllBlips()
	for k, v in pairs(gas_station_blips) do
		Utils.Blips.removeBlip(gas_station_blips[k])
		gas_station_blips[k] = nil
	end
end