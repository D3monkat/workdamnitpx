TriggerEvent('esx_society:registerSociety', JobConfig.job_name, 'Real Estate', 'society_' .. JobConfig.job_name,
    'society_' .. JobConfig.job_name, 'society_' .. JobConfig.job_name, { type = 'public' })

function GetCompanyMoney()
    if IsResourceStarted('esx_addonaccount') then
        local p = promise.new()
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. JobConfig.job_name, function(account)
            p:resolve(account.money)
        end)
        return Citizen.Await(p)
    elseif IsResourceStarted('qb-banking') then
        return exports['qb-banking']:GetAccount(JobConfig.job_name)
    elseif IsResourceStarted('bcs_companymanager') then
        local companyAccount = exports['bcs_companymanager']:GetAccount(JobConfig.job_name)
        return companyAccount.getMoney()
    end
end

function AddCompanyMoney(amount)
    if IsResourceStarted('esx_addonaccount') then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. JobConfig.job_name, function(account)
            account.addMoney(amount)
        end)
    elseif IsResourceStarted('qb-banking') then
        exports['qb-banking']:AddMoney(JobConfig.job_name, amount)
    elseif IsResourceStarted('bcs_companymanager') then
        local companyAccount = exports['bcs_companymanager']:GetAccount(JobConfig.job_name)
        companyAccount.addMoney('money', amount)
    end
end

function RemoveCompanyMoney(amount)
    if IsResourceStarted('esx_addonaccount') then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. JobConfig.job_name, function(account)
            account.removeMoney(amount)
        end)
    elseif IsResourceStarted('qb-banking') then
        exports['qb-banking']:RemoveMoney(JobConfig.job_name, amount)
    elseif IsResourceStarted('bcs_companymanager') then
        local companyAccount = exports['bcs_companymanager']:GetAccount(JobConfig.job_name)
        companyAccount.removeMoney('money', amount)
    end
end
