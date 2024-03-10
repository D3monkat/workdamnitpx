local Freecam = exports['bcs_housing']
local createdZone, lastCreatedZoneType, lastCreatedZone, createdZoneType, createdZone
local drawZone = false
local data = {}
local garageEnabled = false
local minZ, maxZ, cam
local zplacement = 0.0

-- Drawing
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

AddEventHandler('Housing:createMLO',function(create)
    data = create
    garageEnabled = create.enableGarage
    Freecam:SetActive(true)
    polyStart(data.name)
    createdZoneType = 'poly'
    drawZone = true
    drawThread()
end)

AddEventHandler('Housing:createShell', function(create)
  local shell_list = {}
  for k,v in pairs(Shells) do table.insert(shell_list, k) end
  local entry = create.entry or create.apartment.coords
  zplacement = entry.z - 50.0
  local index = 1
  for i=1, #shell_list do
    if shell_list[i] == create.interior then
      index = i
    end
  end
  RequestModel(create.interior)
  while not HasModelLoaded(create.interior) do
      Wait(1000)
  end
  local homeObject = CreateObject(create.interior, entry.x - 30, entry.y + 25, zplacement, false, false, false)
  cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', entry.x, entry.y, zplacement + 13.0, -15.60, 0.0, 48.5, 45.0, false, 0)
  -- cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
  SetCamParams(cam, entry.x, entry.y, zplacement + 10.0, -15.60, 0.0, 48.5, 45.0, 1000, 0, 0, 2)
  PointCamAtCoord(cam, entry.x - 30, entry.y + 25, zplacement)
  SetCamActive(cam, true)
  RenderScriptCams(true, true, 1000, true, true)
  if IsResourceStarted('bcs_hud') then
    exports['bcs_hud']:keybind({
      title=string.format('Shell: %s', create.interior),
      items={
        {
          description=Locale['keybind_confirm_house'],
          buttons={'ENTER'}
        },
        {
          description=Locale['keybind_cancel'],
          buttons={'BACKSPACE'}
        },
        {
          description=Locale['keybind_rotate'],
          buttons={'←', '→'}
        },
        {
          description=Locale['keybind_adjust_height'],
          buttons={'↑', '↓'}
        },
        {
          description=Locale['keybind_change_shell'],
          buttons={'<', '>'}
        },
        {
          description=Locale['keybind_zoom'],
          buttons={'Z'}
        }
      }
    })            
  else
    displayHelp(string.format(Locale['prompt_create_shell'], create.interior), 'bottom-right')
  end
  local zoom = false
  while true do
      DisableControlAction(0, 20, true)
      DisableControlAction(0, 81, true)
      DisableControlAction(0, 82, true)
      DisableControlAction(0, 172, true)
      DisableControlAction(0, 173, true)
      DisableControlAction(0, 174, true)
      DisableControlAction(0, 175, true)
      DisableControlAction(0, 176, true)
      DisableControlAction(0, 177, true)
      if IsDisabledControlJustReleased(0, 20) then
        if zoom then
          SetCamParams(cam, entry.x - 15, entry.y + 10, zplacement + 13.0, -15.60, 0.0, 48.5, 45.0, 1000, 0, 0, 2)
          PointCamAtCoord(cam, entry.x - 30, entry.y + 25, zplacement)
        else
          SetCamParams(cam, entry.x, entry.y, zplacement + 10.0, -15.60, 0.0, 48.5, 45.0, 1000, 0, 0, 2)
          PointCamAtCoord(cam, entry.x - 30, entry.y + 25, zplacement)
        end
        zoom = not zoom
      end
      if IsDisabledControlJustReleased(0, 176) then
        create.zplacement = round(zplacement, 2)
        TriggerServerEvent('Housing:createHome', create)
        DeleteEntity(homeObject)
        RenderScriptCams(false)
        DestroyCam(cam, true)
        cam = nil
        homeObject = nil
        closeHelp()
        break
      end
      if IsDisabledControlJustReleased(0, 81) then
        if index < #shell_list then
          index = index + 1
          DeleteEntity(homeObject)
          if IsResourceStarted('bcs_hud') then
            exports['bcs_hud']:keybind({
              title=string.format('Shell: %s', shell_list[index]),
              items={
                {
                  description=Locale['keybind_confirm_house'],
                  buttons={'ENTER'}
                },
                {
                  description=Locale['keybind_cancel'],
                  buttons={'BACKSPACE'}
                },
                {
                  description=Locale['keybind_rotate'],
                  buttons={'←', '→'}
                },
                {
                  description=Locale['keybind_adjust_height'],
                  buttons={'↑', '↓'}
                },
                {
                  description=Locale['keybind_change_shell'],
                  buttons={'<', '>'}
                },
                {
                  description=Locale['keybind_zoom'],
                  buttons={'Z'}
                }
              }
            })            
          else
            displayHelp(string.format(Locale['prompt_create_shell'], shell_list[index]), 'bottom-right')
          end
          create.interior = shell_list[index]
          RequestModel(shell_list[index])
          while not HasModelLoaded(shell_list[index]) do
              Wait(1000)
          end
          homeObject = CreateObjectNoOffset(shell_list[index], entry.x - 30, entry.y + 25, zplacement, false, false, false)
        end
      end
      if IsDisabledControlJustReleased(0, 82) then
        if index > 1 then
          index = index - 1
          DeleteEntity(homeObject)
          if IsResourceStarted('bcs_hud') then
            exports['bcs_hud']:keybind({
              title=string.format('Shell: %s', shell_list[index]),
              items={
                {
                  description=Locale['keybind_confirm_house'],
                  buttons={'ENTER'}
                },
                {
                  description=Locale['keybind_cancel'],
                  buttons={'BACKSPACE'}
                },
                {
                  description=Locale['keybind_rotate'],
                  buttons={'←', '→'}
                },
                {
                  description=Locale['keybind_adjust_height'],
                  buttons={'↑', '↓'}
                },
                {
                  description=Locale['keybind_change_shell'],
                  buttons={'<', '>'}
                },
                {
                  description=Locale['keybind_zoom'],
                  buttons={'Z'}
                }
              }
            })            
          else
            displayHelp(string.format(Locale['prompt_create_shell'], shell_list[index]), 'bottom-right')
          end
          create.interior = shell_list[index]
          RequestModel(shell_list[index])
          while not HasModelLoaded(shell_list[index]) do
              Wait(1000)
          end
          homeObject = CreateObjectNoOffset(shell_list[index], entry.x - 30, entry.y + 25, zplacement, false, false, false)
        end
      end
      if IsDisabledControlPressed(0, 172) then
        zplacement = zplacement + 0.5
        SetCamParams(cam, entry.x, entry.y, zplacement + 10.0, -15.60, 0.0, 48.5, 45.0, 100, 0, 0, 2)
        PointCamAtCoord(cam, entry.x - 30, entry.y + 25, zplacement)
        SetEntityCoords(homeObject, entry.x - 30, entry.y + 25, zplacement)
      end
      if IsDisabledControlPressed(0, 173) then
        zplacement = zplacement - 0.5
        SetCamParams(cam, entry.x, entry.y, zplacement + 10.0, -15.60, 0.0, 48.5, 45.0, 100, 0, 0, 2)
        PointCamAtCoord(cam, entry.x - 30, entry.y + 25, zplacement)
        SetEntityCoords(homeObject, entry.x - 30, entry.y + 25, zplacement)
      end
      if IsDisabledControlPressed(0, 174) then
        SetEntityHeading(homeObject, GetEntityHeading(homeObject) - 1.0)
      end
      if IsDisabledControlPressed(0, 175) then
        SetEntityHeading(homeObject, GetEntityHeading(homeObject) + 1.0)
      end
      if IsDisabledControlJustReleased(0, 177) then
        DeleteEntity(homeObject)
        RenderScriptCams(false)
        DestroyCam(cam, true)
        cam = nil
        homeObject = nil
        closeHelp()
        TriggerEvent('Housing:notify','Housing',Locale['canceled_house'], 'warning', 3000)
        break
      end
    Wait(0)
  end
end)

function polyStart(name)
  local coords = GetEntityCoords(PlayerPedId())
  if IsResourceStarted('bcs_hud') then
    exports['bcs_hud']:keybind({
      title='Polyzone Creation',
      items={
        {
          description=Locale['keybind_cancel'],
          buttons={'BACKSPACE'}
        },
        {
          description=Locale['keybind_finish'],
          buttons={'X'}
        },
        {
          description=Locale['keybind_add_point'],
          buttons={'G'}
        },
        {
          description=Locale['keybind_change_z'],
          buttons={',', '.'}
        },
        {
          description=Locale['keybind_move_point'],
          buttons={'←', '→', '↑', '↓' }
        },
        {
          description=Locale['keybind_noclip'],
          buttons={'W', 'A', 'S', 'D'}
        },
        {
          description=Locale['keybind_noclip_updown'],
          buttons={'Q', 'E'}
        },
        {
          description=Locale['keybind_noclip_speed'],
          buttons={'L Alt', 'L Shift'}
        }
      }
    })    
  else
    displayHelp(Locale['prompt_create_mlo'], 'bottom-right')
  end
  minZ, maxZ = coords.z - 20.0, coords.z + 20
  createdZone = PolyZone:Create({vector2(coords.x, coords.y)}, {name = tostring(name), useGrid=false, minZ=minZ, maxZ=maxZ})
  Citizen.CreateThread(function()
    local _coords = Freecam:GetPosition() + vec3(0,0,-0.5)
    local freeRot = Freecam:GetRotation()
    local custom = {camera=_coords, rotation=freeRot}
    local hit, coords, entity = RayCastGamePlayCamera(5000.0, custom)
    local pointCoord = coords
    while createdZone do
      DrawLine(vec3(pointCoord.x, pointCoord.y, 0.0), vec3(pointCoord.x, pointCoord.y, pointCoord.z + 50), 255, 0, 0, 255)
      lastPoint = createdZone.points[#createdZone.points]
      lastPoint = vector3(pointCoord.x, pointCoord.y, 0.0)
      createdZone.points[#createdZone.points] = lastPoint.xy
      DisableControlAction(0, 58, true)
      if IsDisabledControlJustReleased(0, 58) then
        TriggerEvent('Housing:notify','Housing','Point Added', 'success', 3000)
        TriggerEvent('Housing:polyzone:pzadd')
      end

      -- change minZ maxZ
      DisableControlAction(0, 82, true)
      DisableControlAction(0, 81, true)
      if IsDisabledControlPressed(0, 82) then
        local input = RequestKeyboardInput('MinZ', 'Input minZ (Current: '..minZ..')', 10)
        if input and type(tonumber(input)) == 'number' then
          createdZone.minZ = tonumber(input) + 0.0
          minZ = createdZone.minZ
        else
          Notify(Locale['housing'], Locale['invalid_input'], 'error', 3000)
        end
      end
      if IsDisabledControlPressed(0,81) then
        local input = RequestKeyboardInput('MaxZ', 'Input maxZ (Current: '..maxZ..')', 10)
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
        minZ, maxZ = nil, nil
        Freecam:SetActive(false)
        closeHelp()
        TriggerEvent('Housing:notify','Housing',Locale['canceled_house'], 'warning', 3000)
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
          TriggerEvent('Housing:notify','Housing','Finish Zone', 'success', 3000)
          Freecam:SetActive(false)
          closeHelp()
          polyFinish()
          
          lastCreatedZoneType = createdZoneType
          lastCreatedZone = createdZone

          drawZone = false
          createdZone = nil
          createdZoneType = nil
          minZ, maxZ = nil, nil
        else
          TriggerEvent('Housing:notify','Housing','Please set the minimum and maximum Z coordinate.', 'error', 3000)
        end
      end
      Wait(0)
    end
  end)
end

function polyFinish()
  data.entry = GetCoordsHeading('Home entrance')
  Wait(1000)
  if garageEnabled then
    data.garage = GetCoordsHeading('Garage')
  end
  Wait(1000)
  data.wardrobe = GetCoordsHeading('Wardrobe')
  Wait(1000)
  data.managehouse = GetCoordsHeading('House management')
  Wait(1000)
  TriggerServerEvent("Housing:finishMLO",
  {
    name=createdZone.name, 
    points=createdZone.points, 
    minZ=minZ, maxZ=maxZ, 
    garage=data.garage or {}, 
    entry=data.entry, 
    price=data.price, 
    payment=data.payment, 
    cctv = data.cctv,
    downpayment=data.downpayment,
    wardrobe = data.wardrobe,
    managehouse = data.managehouse,
    mortgages = data.mortgages
  })
  data = {}
end

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