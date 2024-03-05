QBCore = exports['qb-core']:GetCoreObject()
debug = Config.Debug
local balance

-- BOSS MENU FUNCTIONS
QBCore.Functions.CreateCallback('qb-cayoperico:server:getSocietyData', function(source, cb)
    -- Bank
    local result = MySQL.scalar.await('SELECT amount FROM management_funds WHERE job_name = ?', {"cayoperico"})
    balance = result

    -- Employees
    local employees = {}
    local players = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE '%cayoperico%'", {})
    for k, v in pairs(players) do
        local isOnline = QBCore.Functions.GetPlayerByCitizenId(v.citizenid)
        if isOnline then
            employees[#employees+1] = {
                citizenid = isOnline.PlayerData.citizenid,
                grade = isOnline.PlayerData.job.grade,
                name = '🟢 '..isOnline.PlayerData.charinfo.firstname..' '..isOnline.PlayerData.charinfo.lastname
            }
        else
            employees[#employees+1] = {
                citizenid = v.citizenid,
                grade =  json.decode(v.job).grade,
                name = '🔴 '..json.decode(v.charinfo).firstname..' '..json.decode(v.charinfo).lastname
            }
        end

        table.sort(employees, function(a, b)
            return a.grade.level > b.grade.level
        end)
    end

    -- Unemployed
    local unemployed = {}
    local online = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(online) do
        if Player.PlayerData.job.name == "unemployed" then
            unemployed[#unemployed+1] = {
                citizenid = Player.PlayerData.citizenid,
                name = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
            }
        end
    end

    cb({
        bank = balance,
        employees = employees,
        unemployed = unemployed
    })
end)

RegisterServerEvent('qb-cayoperico:server:withdrawBank', function(amount, society)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local job = Player.PlayerData.job.name
    if job == society then
        local result = MySQL.scalar.await('SELECT amount FROM management_funds WHERE job_name = ?', {society})
        local bank = math.floor(result)
        local newBalance = (bank - amount)
        if amount <= bank then
            -- notify client
            TriggerClientEvent('QBCore:Notify', src, "You withdrew "..amount, "success", 2500)    
            
            -- give bank money
            Player.Functions.AddMoney('cash', amount, "Cayoperico bank")

            -- update cached
            balance = newBalance

            -- update database
            MySQL.update('UPDATE management_funds SET amount = ? WHERE job_name = ?', {newBalance, society})
            --exports['qb-management']:RemoveMoney(society, amount)

            --log
            TriggerEvent("qb-log:server:CreateLog", "societies", "Withdraw "..society, "red", "**" .. Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. Player.PlayerData.source .. ")*: Withdrew **" .. amount .. "**. New balance: "..newBalance)
            if debug then
                print("^3[qb-cayoperico] ^5"..Player.PlayerData.name.." withdrew "..amount..". New balance: "..newBalance.." ("..society..")".."^7")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "There is not enough money on the bank account.", "error", 2500)
        end
    end
end)

RegisterServerEvent('qb-cayoperico:server:depositBank', function(amount, society)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local job = Player.PlayerData.job.name
    local sourceBank = Player.PlayerData.money.cash
    if job == society then
        local bank = math.floor(MySQL.scalar.await('SELECT amount FROM management_funds WHERE job_name = ?', {society}))
        local newBalance = (bank + amount)
        if amount <= sourceBank then
            -- notify client
            TriggerClientEvent('QBCore:Notify', src, "You deposited "..amount, "success", 2500)

            -- take bank money
            Player.Functions.RemoveMoney('cash', amount, "Cayoperico bank")

            -- update cached
            balance = newBalance

            -- update database
            MySQL.update('UPDATE management_funds SET amount = ? WHERE job_name = ?', {newBalance, society})
            --exports['qb-management']:AddMoney(society, amount)

            -- log
            TriggerEvent("qb-log:server:CreateLog", "societies", "Deposit "..job, "green", "**" .. Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. Player.PlayerData.source .. ")*: Deposited **" .. amount .. "**. New balance: "..newBalance)
            if debug then
                print("^3[qb-cayoperico] ^5"..Player.PlayerData.name.." deposit "..amount..". New balance: "..newBalance.." ("..society..")".."^7")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "There is not enough money on your bank account.", "error", 2500)
        end
    end
end)

RegisterNetEvent('qb-cayoperico:server:SetJob', function(citizenid, type)
    local src = source
    local sourcePlayer = QBCore.Functions.GetPlayer(src)
    if not sourcePlayer then return end

    local job = sourcePlayer.PlayerData.job.name
    local citizenid = employee.citizenid
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if Player then -- Online
        if action == "promote" then
            if grade <= 4 then
                Player.Functions.SetJob(job, grade)
                TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You successfully promoted "..employee.name, "success", 3500)
                TriggerEvent("qb-log:server:CreateLog", "societies", "Promoted "..job, "blue", "**" .. Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. Player.PlayerData.source .. ")*: Has been promoted to "..job.." "..grade)
            else
                -- MAX GRADE
                TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You can't promote this person (Max Grade).", "error", 3500)
            end
        elseif action == "demote" then
            if grade >= 0 then
                Player.Functions.SetJob(job, grade)
                TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You successfully demoted "..employee.name, "success", 3500)
                TriggerEvent("qb-log:server:CreateLog", "societies", "Demoted "..job, "blue", "**" .. Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. Player.PlayerData.source .. ")*: Has been demoted to "..job.." "..grade)
            else
                -- LOWEST GRADE
                TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You can't demote this person (Min Grade).", "error", 3500)
            end
        elseif action == "fire" then
            Player.Functions.SetJob("unemployed", 0)
            TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You successfully fired "..employee.name, "success", 3500)
            TriggerEvent("qb-log:server:CreateLog", "societies", "Fired "..job, "blue", "**" .. Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. Player.PlayerData.source .. ")*: Has been fired from "..job)
        elseif action == "hire" then
            Player.Functions.SetJob(job, 0)
            TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You successfully hired "..employee.name, "success", 3500)
            TriggerEvent("qb-log:server:CreateLog", "societies", "Hired "..job, "blue", "**" .. Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *" .. Player.PlayerData.source .. ")*: Has been hired for "..job)
        end
    else -- Offline
        if action == "promote" then
            if grade <= 4 then
                local jobInfo = QBCore.Shared.Jobs[job]
                local temp = {
                    name = job,
                    label = jobInfo.label,
                    onduty = true,
                    payment = jobInfo.grades[tostring(grade)].payment,
                    isboss = false,
                    grade = {
                        name = jobInfo.grades[tostring(grade)].name,
                        level = grade
                    }
                }
                MySQL.update('UPDATE players SET job = ? WHERE citizenid = ?', {json.encode(temp), citizenid})
                TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You successfully promoted "..employee.name, "success", 3500)
                TriggerEvent("qb-log:server:CreateLog", "societies", "Offline Promoted "..job, "blue", "**"..employee.name.."** (citizenid: *"..citizenid.."*): Has been promoted to "..job.." "..grade)
            else
                -- MAX GRADE
                TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You can't promote this person (Max Grade).", "error", 3500)
            end
        elseif action == "demote" then
            if grade >= 0 then
                local jobInfo = QBCore.Shared.Jobs[job]
                local temp = {
                    name = job,
                    label = jobInfo.label,
                    onduty = true,
                    type = jobInfo.type,
                    payment = jobInfo.grades[tostring(grade)].payment,
                    isboss = false,
                    grade = {
                        name = jobInfo.grades[tostring(grade)].name,
                        level = grade
                    }
                }
                MySQL.update('UPDATE players SET job = ? WHERE citizenid = ?', {json.encode(temp), citizenid})
                TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You successfully demoted "..employee.name, "success", 3500)
                TriggerEvent("qb-log:server:CreateLog", "societies", "Offline Demoted "..job, "blue", "**"..employee.name.."** (citizenid: *"..citizenid.."*): Has been demoted to "..job.." "..grade)
            else
                -- LOWEST GRADE
                TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You can't demote this person (Min Grade).", "error", 3500)
            end
        elseif action == "fire" then
            local jobInfo = QBCore.Shared.Jobs['unemployed']
            local temp = {
                name = 'unemployed',
                label = jobInfo.label,
                onduty = true,
                payment = jobInfo.grades['0'].payment,
                isboss = false,
                grade = {
                    name = jobInfo.grades['0'].name,
                    level = 0
                }
            }
            MySQL.update('UPDATE players SET job = ? WHERE citizenid = ?', {json.encode(temp), citizenid})
            TriggerClientEvent('QBCore:Notify', sourcePlayer.PlayerData.source, "You successfully fired "..employee.name, "success", 3500)
            TriggerEvent("qb-log:server:CreateLog", "societies", "Offline Fired "..job, "blue", "**"..employee.name.."** (citizenid: *"..citizenid.."*): Has been fired from "..job)
        end
    end
end)

-- Crafting
RegisterNetEvent('qb-cayoperico:server:CraftItem', function(craft, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not craft then return end
    if not index then return end

    -- Check for items
    local hasItems = true
    for _, v in pairs(Config.CraftingCost[craft][index].items) do
        local item = Player.Functions.GetItemByName(v.item)
        if not item or item.amount < v.amount then
            hasItems = false
            break
        end
    end

    -- Craft item
    if hasItems then
        -- Remove Items
        for _, v in pairs(Config.CraftingCost[craft][index].items) do
            Player.Functions.RemoveItem(v.item, v.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.item], "remove", v.amount)
            Wait(250)
        end

        -- Ammo in sets of 10
        local amount = 1
        if craft == 'ammo' then amount = 10 end

        -- Add Items
        Player.Functions.AddItem(Config.CraftingCost[craft][index].item, amount, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.CraftingCost[craft][index].item], "add", amount)

        TriggerClientEvent('QBCore:Notify', src, 'You crafted 1 '..Config.CraftingCost[craft][index].label)
        TriggerEvent("qb-log:server:CreateLog", 'keylabs', "Guncrafting", "black", "**"..Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *(" .. Player.PlayerData.source .. "))*: has crafted "..amount.."x "..Config.CraftingCost[craft][index].label)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have all the items..", "error", 2500)
    end
end)

-- Vehicles
QBCore.Functions.CreateCallback('qb-cayoperico:server:PayFuel', function(source, cb, amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        if Player.PlayerData.money.cash - amount >= 0 then
            Player.Functions.RemoveMoney('cash', amount, "cayo-fuel")
            TriggerClientEvent('QBCore:Notify', source, "You paid "..amount.."$ for fuel...")
            cb(true)
        else
            TriggerClientEvent('QBCore:Notify', source, "You don't have enough cash for fuel...")
            cb(false)
        end
    end
end)

-- DEBUG MODE
RegisterCommand('cayodebug', function(source)
    debug = not debug
    print("^3[qb-cayoperico] ^5".."Debug mode: "..tostring(debug).."^7")
end, true)
