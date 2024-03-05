
CodeStudio.ServerType = 'QB'  ---Your Server Type QB/ESX/false

CodeStudio.OpenUI = {
    useCommand = true,
    Command_Name = 'ftest',

    useItem = true, 
    Item_Name = 'finger_scanner'
}


---EDIT THIS AS PER YOUR SERVER NEEDS---


if CodeStudio.OpenUI.useItem then 
    if CodeStudio.ServerType == 'ESX' then
        ------ESX CODE------
        
        ESX = exports['es_extended']:getSharedObject()

        ESX.RegisterUsableItem(CodeStudio.OpenUI.Item_Name, function(source)
            TriggerClientEvent('cs:fscanner:openUI', source)
        end)

    elseif CodeStudio.ServerType == 'QB' then
        ------QB CODE------

        QBCore = exports['qb-core']:GetCoreObject()

        QBCore.Functions.CreateUseableItem(CodeStudio.OpenUI.Item_Name, function(source)
            TriggerClientEvent('cs:fscanner:openUI', source)
        end)

    else

        --YOU CAN ADD YOUR CUSTOM EVENTS HERE

    end
end




if CodeStudio.OpenUI.useCommand then
    if CodeStudio.ServerType == "ESX" then 

        RegisterCommand(CodeStudio.OpenUI.Command_Name, function(source)
            if source > 0 then
                TriggerClientEvent('cs:fscanner:openUI', source)
            end
        end, false)

    elseif CodeStudio.ServerType == "QB" then

        QBCore.Commands.Add(CodeStudio.OpenUI.Command_Name, "Open Alcohol Tester", {}, false, function(source, args)
            TriggerClientEvent('cs:fscanner:openUI', source)
        end)

    else
        RegisterCommand(CodeStudio.OpenUI.Command_Name, function(source)
            if source > 0 then
                TriggerClientEvent('cs:fscanner:openUI', source)
            end
        end, false)
    end
end


-----Info Fetch-----

function GetPlayerDetail(pID)
    local pData = {}

    if CodeStudio.ServerType == "ESX" then 
        local Player = ESX.GetPlayerFromId(pID)
        pData = {
            firstname = Player.get('firstName'),
            lastname = Player.get('lastName'),
            dob = Player.get('dateofbirth'),
            finger = GetFingerID(Player.identifier),         -- Dont Edit This
            gender = Player.get('sex')
        }
        if pData.gender == 'm' then 
            pData.gender = CodeStudio.Language.male_txt 
        else
            pData.gender = CodeStudio.Language.female_txt 
        end
    elseif CodeStudio.ServerType == "QB" then
        local Player = QBCore.Functions.GetPlayer(pID)
        pData = {
            firstname = Player.PlayerData.charinfo.firstname,
            lastname = Player.PlayerData.charinfo.lastname,
            dob = Player.PlayerData.charinfo.birthdate,
            finger = Player.PlayerData.metadata["fingerprint"],
            gender = Player.PlayerData.charinfo.gender
        }
        if pData.gender == 0 then 
            pData.gender = CodeStudio.Language.male_txt 
        else
            pData.gender = CodeStudio.Language.female_txt 
        end
    else
        --YOU CAN ADD YOUR CUSTOM EVENTS HERE
    end

    return pData
end



-- Fingerprint Fetching and Creating for NON-QB Servers -- 


function GetFingerID(identifier)
    if not CodeStudio.Enable_Fingerprint_ID then
        return false
    end

    local Return_ID = nil
    local result = MySQL.Sync.fetchScalar('SELECT fingerprint FROM users WHERE identifier = ?', {identifier})
    if not result or result == '0' or result == '' then
        local NewFinger = CreateFingerId()
        MySQL.Sync.execute('UPDATE users SET fingerprint = ? WHERE identifier = ?', {NewFinger, identifier})
        Return_ID = NewFinger
    else
        Return_ID = result
    end

    return Return_ID
end

function CreateFingerId()
    local UniqueFound = false
    local FingerId = nil
    while not UniqueFound do  -- You can change how your fingerprint ID should look --
        FingerId = tostring(RandomStr(2) .. RandomInt(3) .. RandomStr(1) .. RandomInt(2) .. RandomStr(3)) 
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM users WHERE fingerprint = ?', { FingerId })
        if result == 0 then
            UniqueFound = true
        end
    end
    return FingerId
end


--- Discord Logs ---

function SendDiscordLog(self, target)
    local webHook = CodeStudio.DicordLogs
    local embedData = {
        {
            ['title'] = "Test Performed",
            ['color'] = 65280,
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = '**Tested By: **' ..self.firstname.." "..self.lastname.."\n\n**Target Player: **"..target.firstname.." "..target.lastname
            .."\n**Date of Birth: **"..target.dob.."\n**Gender: **"..target.gender..'\n**Finger Print: **'..target.finger
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'Figer Print Department', embeds = embedData}), { ['Content-Type'] = 'application/json' })
end
