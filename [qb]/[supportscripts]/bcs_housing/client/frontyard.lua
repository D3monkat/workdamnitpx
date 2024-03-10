local Freecam = exports['bcs_housing']
local createdZone, lastCreatedZoneType, lastCreatedZone, createdZoneType, createdZone
local drawZone = false
local minZ, maxZ, cam = 0.0, 150.0

local function drawThread()
  Citizen.CreateThread(function()
    while drawZone do
      if createdZone then
        createdZone:draw()
      end
      Wait(0)
    end
  end)
end

RegisterCommand(commands.setfrontyard.name, function()
  TriggerServerCallback('Housing:checkAllowed', function(allowed)
    if allowed then
      local home = GetNearestHome()
      if home then
        if home.type == 'mlo' or home.complex == 'Apartment' then
          Notify(Locale['housing'], Locale['house_cannot_have_frontyard'], 'error', 3000)
          return
        end
        Freecam:SetActive(true)
        frontyardStart(home.identifier .. '-frontyard', home.identifier)
        createdZoneType = 'poly'
        drawZone = true
        drawThread()
      else
        Notify(Locale['housing'], Locale['not_near_any_home'], 'error', 2000)
      end
    end
  end, 'frontyard')
end, false)

RegisterNetEvent("Housing:polyzone:pzadd")
AddEventHandler("Housing:polyzone:pzadd", function()
  if createdZone == nil or createdZoneType ~= 'poly' then
    return
  end

  local coords = GetEntityCoords(PlayerPedId())

  createdZone.points[#createdZone.points + 1] = vector2(coords.x, coords.y)
end)

RegisterNetEvent("Housing:polyzone:pzundo")
AddEventHandler("Housing:polyzone:pzundo", function()
  if createdZone == nil or createdZoneType ~= 'poly' then
    return
  end

  createdZone.points[#createdZone.points] = nil
  if #createdZone.points == 0 then
    TriggerEvent("Housing:polyzone:pzcancel")
  end
end)

function frontyardStart(name, identifier)
  local coords = GetEntityCoords(PlayerPedId())
  if IsResourceStarted('bcs_hud') then
    exports['bcs_hud']:keybind({
      title = 'Polyzone Creation',
      items = {
        {
          description = Locale['keybind_cancel'],
          buttons = { 'BACKSPACE' }
        },
        {
          description = Locale['keybind_finish'],
          buttons = { 'X' }
        },
        {
          description = Locale['keybind_add_point'],
          buttons = { 'G' }
        },
        {
          description = Locale['keybind_change_z'],
          buttons = { ',', '.' }
        },
        {
          description = Locale['keybind_move_point'],
          buttons = { '←', '→', '↑', '↓' }
        },
        {
          description = Locale['keybind_noclip'],
          buttons = { 'W', 'A', 'S', 'D' }
        },
        {
          description = Locale['keybind_noclip_updown'],
          buttons = { 'Q', 'E' }
        },
        {
          description = Locale['keybind_noclip_speed'],
          buttons = { 'L Alt', 'L Shift' }
        }
      }
    })
  else
    displayHelp(Locale['prompt_create_mlo'], 'bottom-right')
  end
  minZ, maxZ = coords.z - 20.0, coords.z + 20
  createdZone = PolyZone:Create({ vector2(coords.x, coords.y) },
    { name = tostring(name), useGrid = false, minZ = minZ, maxZ = maxZ })
  CreateThread(function()
    local _coords = Freecam:GetPosition() + vec3(0, 0, -0.5)
    local freeRot = Freecam:GetRotation()
    local custom = { camera = _coords, rotation = freeRot }
    local hit, coords, entity = RayCastGamePlayCamera(5000.0, custom)
    local pointCoord = coords
    local entry = Homes[identifier].complex == 'Apartment' and Homes[identifier].apartment.coord or
        Homes[identifier].entry
    entry = vector3(entry.x, entry.y, entry.z)
    while createdZone do
      DrawLine(vec3(pointCoord.x, pointCoord.y, 0.0), vec3(pointCoord.x, pointCoord.y, pointCoord.z + 50), 255, 0, 0, 255)
      lastPoint = createdZone.points[#createdZone.points]
      lastPoint = vector3(pointCoord.x, pointCoord.y, 0.0)
      createdZone.points[#createdZone.points] = lastPoint.xy
      DisableControlAction(0, 58, true)
      if IsDisabledControlJustReleased(0, 58) then
        if #(entry - pointCoord) <= Config.creation.MaxFrontyardDistance then
          TriggerEvent('Housing:notify', 'Housing', 'Point Added', 'success', 3000)
          TriggerEvent('Housing:polyzone:pzadd')
        else
          Notify(Locale['housing'], Locale['point_too_far'], 'error', 3000)
        end
      end

      -- change minZ maxZ
      DisableControlAction(0, 82, true)
      DisableControlAction(0, 81, true)
      if IsDisabledControlPressed(0, 82) then
        local input = RequestKeyboardInput('MinZ', 'Input minZ (Current: ' .. minZ .. ')', 10)
        if input and type(tonumber(input)) == 'number' then
          createdZone.minZ = tonumber(input) + 0.0
          minZ = createdZone.minZ
        else
          Notify(Locale['housing'], Locale['invalid_input'], 'error', 3000)
        end
      end
      if IsDisabledControlPressed(0, 81) then
        local input = RequestKeyboardInput('MaxZ', 'Input maxZ (Current: ' .. maxZ .. ')', 10)
        if input and type(tonumber(input)) == 'number' then
          createdZone.maxZ = tonumber(input) + 0.0
          maxZ = createdZone.maxZ
        else
          Notify(Locale['housing'], Locale['invalid_input'], 'error', 3000)
        end
      end

      DisableControlAction(0, 177, true)
      if IsDisabledControlJustReleased(0, 177) then
        createdZone:destroy()
        lastCreatedZoneType = createdZoneType
        lastCreatedZone = createdZone

        drawZone = false
        createdZone = nil
        createdZoneType = nil
        minZ, maxZ = 0.0, 150.0
        Freecam:SetActive(false)
        closeHelp()
        TriggerEvent('Housing:notify', 'Housing', Locale['canceled_frontyard'], 'warning', 3000)
      end

      DisableControlAction(0, 187, true)
      DisableControlAction(0, 188, true)
      DisableControlAction(0, 189, true)
      DisableControlAction(0, 190, true)
      if IsDisabledControlPressed(0, 187) then -- down
        local vecX, vecY, vecZ, pos = Freecam:GetMatrix()
        pointCoord = pointCoord + vecY * -0.1
      end
      if IsDisabledControlPressed(0, 188) then -- up
        local vecX, vecY, vecZ, pos = Freecam:GetMatrix()
        pointCoord = pointCoord + vecY * 0.1
      end
      if IsDisabledControlPressed(0, 189) then -- left
        local vecX, vecY, vecZ, pos = Freecam:GetMatrix()
        pointCoord = pointCoord + vecX * -0.1
      end
      if IsDisabledControlPressed(0, 190) then -- right
        local vecX, vecY, vecZ, pos = Freecam:GetMatrix()
        pointCoord = pointCoord + vecX * 0.1
      end

      DisableControlAction(0, 73, true)
      if IsDisabledControlJustReleased(0, 73) then
        if minZ and maxZ then
          TriggerEvent('Housing:notify', 'Housing', 'Finish Zone', 'success', 3000)
          Freecam:SetActive(false)
          closeHelp()
          frontyardFinish(identifier)

          lastCreatedZoneType = createdZoneType
          lastCreatedZone = createdZone

          drawZone = false
          createdZone = nil
          createdZoneType = nil
          minZ, maxZ = 0.0, 150.0
        else
          TriggerEvent('Housing:notify', 'Housing', 'Please set the minimum and maximum Z coordinate.', 'error', 3000)
        end
      end
      Wait(0)
    end
  end)
end

function frontyardFinish(identifier)
  TriggerServerEvent("Housing:server:finishFrontyard",
    {
      identifier = identifier,
      points = createdZone.points,
      minZ = minZ,
      maxZ = maxZ,
    })
end
