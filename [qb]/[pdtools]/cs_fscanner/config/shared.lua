CodeStudio = {}

CodeStudio.Wait_TIme = 2    --Scaning Waiting Time in seconds

CodeStudio.Animations = {
    Enable = true,
    Scanner_Prop = `prop_police_phone`,

    Use_Anim = 'idle_f',
    Use_Dict = 'random@hitch_lift'
}

CodeStudio.Enable_Fingerprint_ID = true     --Enable/Disable Fingerprint ID in scanner

CodeStudio.DicordLogs = false  -- Put discord webhook to enable discord logs

----Notifications Customization----

function Notify(msg)

    SetNotificationTextEntry('STRING') --- DELETE ME IF YOU ARE USING ANOTHER SYSTEM
    AddTextComponentString(msg)  --- DELETE ME IF YOU ARE USING ANOTHER SYSTEM
    DrawNotification(0,1)  --- DELETE ME IF YOU ARE USING ANOTHER SYSTEM
  
    --MORE EXAMPLES OF NOTIFICATIONS.

    -- [CodeStudio Notification*] --

    -- exports['cs_notification']:Notify({  -- https://codestudio.tebex.io/package/5680775
    --     type = 'primary',  
    --     title = 'Fingerprint Scanner',
    --     description = msg
    -- })

    --exports['qb-core']:Notify(msg, "primary")
end


----Language Editor----

CodeStudio.Language = {
    welcome_txt = 'WELCOME',
    department_txt = 'Fingerprint Scanner Department',
    new_scan = 'New Scan',
    view_history = 'History',
    history_head = 'History',
    view_btn = 'View',
    report_head = 'Report',
    scaning_txt = 'Please put your finger on the scanner',
    male_txt = 'Male',
    female_txt = 'Female'
}