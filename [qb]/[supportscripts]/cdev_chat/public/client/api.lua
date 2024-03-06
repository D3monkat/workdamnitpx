local ChatResourceAPI = {}

-- /me and /do integration (optional)

local peds = {}

local function displayText(ped, text, yOffset, isDo)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local targetPos = GetEntityCoords(ped)
    local dist = #(playerPos - targetPos)
    local los = HasEntityClearLosToEntity(playerPed, ped, 17)

    if dist <= 250 and los then
        if not peds[ped] then
            peds[ped] = {
                time = GetGameTimer() + 5000,
                text = text,
                yOffset = yOffset,
                exists = true,
                isDo = isDo
            }

            Citizen.CreateThread(function()
                while peds[ped] and (GetGameTimer() <= peds[ped].time or peds[ped].isDo == true) do
                    local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, peds[ped].yOffset)
                    clib.wrappers.DrawText3D(peds[ped].text, pos, 0.5, { 255, 255, 255, 255 }, false, 4)
                    Wait(0)
                end

                peds[ped] = nil
            end)
        end
    end
end

RegisterNetEvent("displayMeAboveHead")
AddEventHandler("displayMeAboveHead", function(target, message)
    local player = GetPlayerFromServerId(target)
    if player == -1 then return end

    local ped = GetPlayerPed(player)

    if not DoesEntityExist(ped) then
        return
    end

    local offset = PublicSharedChatConfig.MeAndDoCommand.Offset


    displayText(ped, "~r~** " .. message .. " **", offset, false)
end)

RegisterNetEvent("displayDoAboveHead")
AddEventHandler("displayDoAboveHead", function(target, message)
    local player = GetPlayerFromServerId(target)
    if player == -1 then return end

    local ped = GetPlayerPed(player)

    if not DoesEntityExist(ped) then
        return
    end

    local offset = PublicSharedChatConfig.MeAndDoCommand.Offset

    displayText(ped, "~b~** " .. message .. " **", offset, true)
end)

RegisterNetEvent("disableDoAboveHead")
AddEventHandler("disableDoAboveHead", function(target)
    local player = GetPlayerFromServerId(target)
    if player == -1 then return end

    local ped = GetPlayerPed(player)

    if not DoesEntityExist(ped) then
        return
    end

    if peds[ped] and peds[ped].isDo then
        peds[ped] = nil
    end
end)

if PublicSharedChatConfig.MeAndDoCommand.UseMeAndDoCommand then
    TriggerEvent("chat:addSuggestion", '/do', "Displays an action or emote your character is performing.")
    TriggerEvent("chat:addSuggestion", '/me', "Describe or respond in roleplay.")
end
