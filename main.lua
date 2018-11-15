GoldSquish = LibStub("AceAddon-3.0"):NewAddon("GoldSquish", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GoldSquish")
i=0.1
SILVER_PER_GOLD=i
local defaults = {
    profile = {
        message = L["Welcome Home!"],
        showInChat = false,
        showOnScreen = true,
    },
}

local options = {
    name = "GoldSquish",
    handler = GoldSquish,
    type = "group",
       args = {
           msg = {
               type = "input",
               name = L["Message"],
               desc = L["The message to be displayed when you get home."],
               usage = L["<Your message>"],
               get = "GetMessage",
               set = "SetMessage",
           },
           showInChat = {
               type = "toggle",
               name = L["Show in Chat"],
               desc = L["Toggles the display of the message in the chat window."],
               get = "IsShowInChat",
               set = "ToggleShowInChat",
           },
           showOnScreen = {
               type = "toggle",
               name = L["Show on Screen"],
               desc = L["Toggles the display of the message on the screen."],
               get = "IsShowOnScreen",
               set = "ToggleShowOnScreen"
           },
           squishMode = {
              type = "select",
              name = L["Squish mode"],
              desc = L["Select the squish mode used to transform the displayed golds."],

           }
       },
}

function GoldSquish:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("GoldSquishDB", defaults, true)


    LibStub("AceConfig-3.0"):RegisterOptionsTable("GoldSquish", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("GoldSquish", "GoldSquish")
    self:RegisterChatCommand("goldsquish", "ChatCommand")
    self:RegisterChatCommand("gs", "ChatCommand")
end

function GoldSquish:OnEnable()
    self:RegisterEvent("ZONE_CHANGED")
end

function GoldSquish:OnDisable()
end

function GoldSquish:ZONE_CHANGED()
   if self.db.profile.showInChat then
       self:Print(self.db.profile.message)
   end

   if self.db.profile.showOnScreen then
       UIErrorsFrame:AddMessage(self.db.profile.message, 1.0, 1.0, 1.0, 5.0)
   end
end

function GoldSquish:IsShowInChat(info)
    return self.db.profile.showInChat
end

function GoldSquish:ToggleShowInChat(info, value)
    self.db.profile.showInChat = value
end

function GoldSquish:IsShowOnScreen(info)
    return self.db.profile.showOnScreen
end

function GoldSquish:ToggleShowOnScreen(info, value)
    self.db.profile.showOnScreen = value
end

function GoldSquish:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("gs", "GoldSquish", input)
    end
end

function GoldSquish:GetMessage(info)
    return self.db.profile.message
end

function GoldSquish:SetMessage(info, newValue)
    self.db.profile.message = newValue
end
