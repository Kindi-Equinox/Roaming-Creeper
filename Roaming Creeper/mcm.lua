local config = require("kindi.roaming creeper.config")
local EasyMCM = require("easyMCM.EasyMCM")
local pageDescription =
    "Welcome to Roaming Creeper. \n\nCreeper will go around towns in Vvardenfell to trade wares and items with locals everyday. He now buys and sells more types of items including very rare ones. \n\nHe can be randomly found inside any Tradehouses, Inns or Taverns. Creeper will return to Ghorak Manor on every 1st day of the month. \n\n\n\n"
local template = EasyMCM.createTemplate {}
template.name = "Roaming Creeper"
template:saveOnClose("roaming_creeper", config)

local page = template:createSideBarPage{
    label = "Main",
    description = pageDescription,
    noScroll = false
}

local general = page:createCategory("General")

local onoff = general:createOnOffButton{
    label = "Toggle the mod status",
    description = "When OFF, creeper will not roam and will stay at Ghorak Manor and his wares will not reset.",
    variable = EasyMCM.createTableVariable {
        id = "modActive",
        table = config
    },
    callback = function()
        if config.modActive == true then
            tes3.messageBox("Roaming Creeper is turned ON")
        else
            tes3.messageBox("Roaming Creeper is turned OFF")
            event.trigger("RC:Kindi_ModOff")
        end
    end
}

local debug = general:createOnOffButton{
    label = "Toggle debug mode",
    description = "Debugging purposes only. Shows creeper activity.",
    variable = EasyMCM.createTableVariable {
        id = "debug",
        table = config
    },
    callback = function()
        if config.debug == true then
            tes3.messageBox("Debug is turned ON")
        else
            tes3.messageBox("Debug is turned OFF")

        end
    end
}

--[[general:createYesNoButton{
    label = "Reset Creeper inventory?",
    description = "Items sold to the Creeper will be removed everytime the Creeper moves to another place",
    variable = EasyMCM.createTableVariable {
        id = "removeSold",
        table = config
    },
    callback = function()
        if config.removeSold == true then
            tes3.messageBox("Turned ON")
        else
            tes3.messageBox("Turned OFF")

        end
    end
}]]

general:createButton{
    inGameOnly = true,
    label = "Reveal the Creeper's current location",
    buttonText = "Reveal",
    description = "Don't use too much",
    callback = function()
        if not tes3.getReference("scamp_creeper") then
            return
        end
        tes3.messageBox(("Creeper is currently in %s"):format(tes3.getReference("scamp_creeper").cell))
    end
}

general:createButton{
    inGameOnly = true,
    label = "Go to Creeper's current location",
    buttonText = "Go",
    description = "Don't use too much",
    callback = function()
        if not tes3.getReference("scamp_creeper") then
            return
        end
        tes3.positionCell {
            cell = tes3.getReference("scamp_creeper").cell,
            reference = tes3.player,
            position = tes3.getReference("scamp_creeper").position,
            orientation = tes3.getReference("scamp_creeper").orientation
        }
    end
}

EasyMCM.register(template)

