GoldSquish = LibStub("AceAddon-3.0"):NewAddon("GoldSquish", "AceConsole-3.0", "AceEvent-3.0")

local options = {
    name = "GoldSquish",
    handler = GoldSquish,
    type = "group",
    args = {
        msg = {
            type = "input",
            name = "Message",
            desc = "The message to be displayed when you get home.",
            usage = "<Your message>",
            get = "GetMessage",
            set = "SetMessage",
        },
    },
}

function GoldSquish:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("GoldSquish", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("GoldSquish", "GoldSquish")
    self:RegisterChatCommand("goldsquish", "ChatCommand")
    self:RegisterChatCommand("gs", "ChatCommand")
    GoldSquish.message = "Bienvenue à la maison <3"
end

function GoldSquish:OnEnable()
    self:RegisterEvent("ZONE_CHANGED")
end

function GoldSquish:OnDisable()
end

function GoldSquish:ZONE_CHANGED()
    self:Print(self.message)
end

function GoldSquish:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("gs", "GoldSquish", input)
    end
end

function GoldSquish:GetMessage(info)
    return self.message
end

function GoldSquish:SetMessage(info, newValue)
    self.message = newValue
end
