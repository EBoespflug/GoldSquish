GoldSquish = LibStub("AceAddon-3.0"):NewAddon("GoldSquish", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GoldSquish")

local defaults = {
    profile = {
        message = L["Welcome Home!"],
        cps = "100",
        spg = "100",
        squishMode = "x1"
    },
}

local squishTable = {
  ["x10"] = "x10",
  ["x100"] = "x100",
  ["custom"] = "custom"
}

local options = {
    name = "GoldSquish",
    handler = GoldSquish,
    type = "group",
       args = {
           spg = {
               type = "input",
               name = L["Silver per gold"],
               desc = L["The amount of silver contained in one gold."],
               usage = L["exemple_value"],
               set = "SetSPG",
               get = function(info) return GoldSquish.db.profile.spg end,
               order = 10
           },
           cps = {
               type = "input",
               name = L["Copper per silver"],
               desc = L["The amount of copper contained in one silver."],
               usage = L["exemple_value"],
               set = "SetCPS",
               get = function(info) return GoldSquish.db.profile.cps end,
               order = 11
           },
            forceUpdate = {
               type = "execute",
               name = L["Force update"],
               desc = L["Force GoldSquish to apply immediatly the changes"],
               func  = function() GoldSquish:UpdateSquish() end,
               order = 100
           },
            resetToDefault = {
               type = "execute",
               name = L["Reset to default"],
               desc = L["Reset all GoldSquish's Config to default values."],
               func  = "ResetToDefault",
               order = 101
           }
           -- ,
           -- squishMode = {
           --    type = "select",
           --    name = L["Squish mode"],
           --    desc = L["Select the squish mode used to transform the displayed golds."],
           --    value = squishTable
           -- }
       }
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
    self:UpdateSquish()
end

function GoldSquish:OnDisable()
  self:NoSquish()
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

function GoldSquish:GetMode(info)
    return ""
end

function GoldSquish:SetMode(info, newValue)

end

function GoldSquish:SetSPG(info, val)
  self.db.profile.spg = val
  self:UpdateSquish()
end

function GoldSquish:SetCPS(info, val)
  self.db.profile.cps = val
  self:UpdateSquish()
end

function GoldSquish:ResetToDefault()
  self.db.profile.cps = defaults.profile.cps
  self.db.profile.spg = defaults.profile.spg
  self.db.profile.squishMode = defaults.profile.squishMode
  self:UpdateSquish()
end

function GoldSquish:UpdateSquish()
    SILVER_PER_GOLD=self.db.profile.spg
    COPPER_PER_SILVER=self.db.profile.cps
end

function GoldSquish:NoSquish()
  SILVER_PER_GOLD=100
  COPPER_PER_SILVER=100
end
