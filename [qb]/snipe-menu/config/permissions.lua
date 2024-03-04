
--[[
    All the roles here can access the admin menu
    Only the GOD can set the panels for the other roles
    There are 3 options
    1. God -> can access all the commands
    
    IMPORTANT: DO NOT REMOVE GOD ROLE, IF YOU DO SO, YOU WILL NOT BE ABLE TO ACCESS THE ADMIN MENU AT ALL

    If you have a new role, you can add it here and select to give either God, Admin or Moderator or any of the custom perms you want

    eg. ["new_role"] = "God",
    eg. ["dev"] = "Admin",
]]--
Config.GodRoles = {
    ["god"] = "God", -- This is the biggest role (DO NOT REMOVE THIS ROLE)
    ["admin"] = "Admin", -- This is just a custom role
    ["mod"] = "Moderator", -- This is just a custom role
    -- ["new_role1"] = "Test", -- if you want to add more roles just add them here
    -- ["new_role2"] = "Test", -- if you want to add more roles just add them here
    -- ["new_role3"] = "Test",
    -- if you want to add more roles just add them here
    -- ["NEW_ROLE_HERE"] = "God",
    -- ["NEW_ROLE_HERE"] = "Admin",
    -- ["NEW_ROLE_HERE"] = "Moderator",
}

Config.Permissions = {
["fivem:1651474"] = "god", 
    ["char1:12334"] = "god", -- charid for ESX
}

