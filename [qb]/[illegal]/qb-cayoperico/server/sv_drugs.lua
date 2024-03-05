RegisterNetEvent('qb-cayoperico:server:GetCrop', function(crop)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local receiveAmount = math.random(1, 2)
    local item
    if crop == "weed" then
        item = "cayo_weed1"
    elseif crop == "coke" then
        item = "cayo_coke1"
    end
    
    Player.Functions.AddItem(item, receiveAmount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
    TriggerClientEvent('QBCore:Notify', src, 'You harvested ' .. receiveAmount .. " "..QBCore.Shared.Items[item]["label"])
end)

RegisterNetEvent('qb-cayoperico:server:GetProcessed', function(crop)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local takeItem
    local giveItem
    if crop == "weed" then
        takeItem = "cayo_weed1"
        giveItem = "cayo_weed2"
    elseif crop == "coke" then
        takeItem = "cayo_coke1"
        giveItem = "cayo_coke2"
    end

    if Player.Functions.GetItemByName(takeItem) then
        local takeAmount = 4
        if Player.Functions.GetItemByName(takeItem).amount >= takeAmount then
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[takeItem], "remove")
            Player.Functions.RemoveItem(takeItem, takeAmount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[giveItem], "add")
            Player.Functions.AddItem(giveItem, 1)
            TriggerClientEvent('QBCore:Notify', src, "You received 1 "..QBCore.Shared.Items[giveItem]["label"])
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough "..QBCore.Shared.Items[giveItem]["label"])
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have anything to process")
    end    
end)

RegisterNetEvent('qb-cayoperico:server:GetPackaged', function(crop)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local takeItem
    local giveItem
    if crop == "weed" then
        takeItem = "cayo_weed2"
        giveItem = "cayo_weed3"
    elseif crop == "coke" then
        takeItem = "cayo_coke2"
        giveItem = "cayo_coke3"
    end

    if Player.Functions.GetItemByName(takeItem) then
        local takeAmount = 18
        if Player.Functions.GetItemByName(takeItem).amount >= takeAmount then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[takeItem], "remove")
            Player.Functions.RemoveItem(takeItem, takeAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[giveItem], "add")
            Player.Functions.AddItem(giveItem, 1)
            TriggerClientEvent('QBCore:Notify', src, "You received 1 "..QBCore.Shared.Items[giveItem]["label"])
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough "..QBCore.Shared.Items[giveItem]["label"])
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have anything to package")
    end    
end)

RegisterNetEvent('qb-cayoperico:server:DepositHarvest', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.GetItemByName("cayo_coke1") then
        if Player.Functions.GetItemByName("cayo_coke1").amount >= 20 then
            local amount = Player.Functions.GetItemByName("cayo_coke1").amount
            Player.Functions.RemoveItem("cayo_coke1", amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cayo_coke1"], "remove", amount)
            local info = {
                amt = amount,
                crop = "Coca Leaves",
                weight = amount*2
            }
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cayo_deliverynote"], "add", 1)
            Player.Functions.AddItem("cayo_deliverynote", 1, false, info)
        else
            TriggerClientEvent('QBCore:Notify', src, "You need atleast 20 Coca Leaves..", "error", 2500)
        end
    end

    if Player.Functions.GetItemByName("cayo_weed1") then
        if Player.Functions.GetItemByName("cayo_weed1").amount >= 20 then
            local amount = Player.Functions.GetItemByName("cayo_weed1").amount
            Player.Functions.RemoveItem("cayo_weed1", amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cayo_weed1"], "remove", amount)
            local info = {
                amt = amount,
                crop = "Weed Branches",
                weight = amount*2
            }
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cayo_deliverynote"], "add", 1)
            Player.Functions.AddItem("cayo_deliverynote", 1, false, info)
        else
            TriggerClientEvent('QBCore:Notify', src, "You need atleast 20 Weed Branches..", "error", 2500)
        end
    end
end)

RegisterNetEvent('qb-cayoperico:server:ExchangeNote', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.GetItemByName("cayo_deliverynote") then
        local amount = Player.Functions.GetItemByName("cayo_deliverynote").info.amt
        local type = Player.Functions.GetItemByName("cayo_deliverynote").info.crop
        local weight = Player.Functions.GetItemByName("cayo_deliverynote").info.weight*1000
        local giveItem
        if type == "Coca Leaves" then
            giveItem = "cayo_coke1"
        elseif type == "Weed Branches" then
            giveItem = "cayo_weed1"
        end
        local TotalWeight = QBCore.Player.GetTotalWeight(Player.PlayerData.items)
        if weight + TotalWeight <= QBCore.Config.Player.MaxWeight then
            Player.Functions.RemoveItem("cayo_deliverynote", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cayo_deliverynote"], "remove")
            Player.Functions.AddItem(giveItem, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[giveItem], "add")
        else
            TriggerClientEvent('QBCore:Notify', src, "Not enough room in your pockets..", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have a delivery note on you..", "error")
    end
end)

QBCore.Functions.CreateUseableItem("cayo_coke3", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.Functions.GetItemByName("cayo_coke3") and Player.Functions.GetItemByName("empty_plastic_bag") then
        TriggerClientEvent('qb-cayoperico:client:CuttingBricks', src, "coke")
    else
        TriggerClientEvent('QBCore:Notify', src, "You need some baggies..", "error")
    end
end)

QBCore.Functions.CreateUseableItem("cayo_weed3", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.Functions.GetItemByName("cayo_weed3") and Player.Functions.GetItemByName("empty_plastic_bag") then
        TriggerClientEvent('qb-cayoperico:client:CuttingBricks', src, "weed")
    else
        TriggerClientEvent('QBCore:Notify', src, "You need some baggies..", "error")
    end
end)

RegisterNetEvent('qb-cayoperico:server:CuttingBricks', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local TotalWeight = QBCore.Player.GetTotalWeight(Player.PlayerData.items)
    local giveItem
    local takeItem
    if type == "coke" then
        giveItem = "cokebaggy"
        takeItem = "cayo_coke3"
    elseif type == "weed" then
        giveItem = "weed_skunk"
        takeItem = "cayo_weed3"
    end

    if Player.Functions.GetItemByName(takeItem) and Player.Functions.GetItemByName("empty_plastic_bag") then
        if (TotalWeight - QBCore.Shared.Items[takeItem]['weight'] + (QBCore.Shared.Items[giveItem]['weight'] * 100)) <= QBCore.Config.Player.MaxWeight then
            Player.Functions.RemoveItem(takeItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[takeItem], "remove")
            Player.Functions.RemoveItem("empty_plastic_bag", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["empty_plastic_bag"], "remove")
            Player.Functions.AddItem(giveItem, 100)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[giveItem], "add")
            TriggerClientEvent('QBCore:Notify', src, "You put your "..type.."bricks in smaller bags..", "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "Your pockets weigh too much..", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You need some baggies..", "error")
    end
end)
