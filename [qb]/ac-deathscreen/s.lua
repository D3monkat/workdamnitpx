AddEventHandler('qb-playerDied', function(weaponLabel, time)
    TriggerClientEvent('ac-deathscreen:openUI', source, time)
end)