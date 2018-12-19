-- main.lua - GoldSquish
-- @author Etienne Boespflug
-- @version 1.0

GoldSquish = LibStub("AceAddon-3.0"):NewAddon("GoldSquish", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GoldSquish")

local defaults = {
    profile = {
        cps = "100",
        spg = "100",
        squishMode = "x1"
    },
}

local squishTable = {
  ["x0.000000001"] = "x0.000000001",
  ["x0.000001"] = "x0.000001",
  ["x0.001"] = "x0.001",
  ["x0.01"] = "x0.01",
  ["x0.1"] = "x0.1",
  ["x1"] = "x1",
  ["x10"] = "x10",
  ["x100"] = "x100",
  ["x1000"] = "x1000",
  ["x1000000"] = "x1000000",
  ["x1000000000"] = "x1000000000",
  ["Custom"] = L["Custom"]
}

local options = {
    name = "GoldSquish",
    handler = GoldSquish,
    type = "group",
       args = {
           squishMode = {
              type = "select",
              name = L["Squish mode"],
              desc = L["Select the squish mode used to transform the displayed golds."],
              style = "dropdown",
              values = squishTable,
              get = function() return GoldSquish.db.profile.squishMode end,
              set = "SetMode",
              order = 10
           },
           spg = {
               type = "input",
               name = L["Silver per gold"],
               desc = L["The amount of silver contained in one gold."],
               usage = L["exemple_value"],
               set = "SetSPG",
               get = function(info) return GoldSquish.db.profile.spg end,
               order = 11
           },
           cps = {
               type = "input",
               name = L["Copper per silver"],
               desc = L["The amount of copper contained in one silver."],
               usage = L["exemple_value"],
               set = "SetCPS",
               get = function(info) return GoldSquish.db.profile.cps end,
               order = 12
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
    self:UpdateSquish()
end

function GoldSquish:OnDisable()
    self:NoSquish()
end

function GoldSquish:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("gs", "GoldSquish", input)
    end
end

function GoldSquish:SetMode(info, val)
  if val == "Custom" then
    -- do nothing
  elseif val == "x0.000000001" then
    self.db.profile.spg = "10000000"
    self.db.profile.cps = "1000000"
  elseif val == "x0.000001" then
    self.db.profile.spg = "100000"
    self.db.profile.cps = "100000"
  elseif val == "x0.001" then
    self.db.profile.spg = "10000"
    self.db.profile.cps = "1000"
  elseif val == "x0.01" then
    self.db.profile.spg = "1000"
    self.db.profile.cps = "1000"
  elseif val == "x0.1" then
    self.db.profile.spg = "1000"
    self.db.profile.cps = "100"
  elseif val == "x1" then
    self.db.profile.spg = "100"
    self.db.profile.cps = "100"
  elseif val == "x10" then
    self.db.profile.spg = "100"
    self.db.profile.cps = "10"
  elseif val == "x100" then
    self.db.profile.spg = "10"
    self.db.profile.cps = "10"
  elseif val == "x1000" then
    self.db.profile.spg = "10"
    self.db.profile.cps = "1"
  elseif val == "x1000000" then
    self.db.profile.spg = "0.1"
    self.db.profile.cps = "0.1"
  elseif val == "x1000000000" then
    self.db.profile.spg = "0.01"
    self.db.profile.cps = "0.001"
  end
  self.db.profile.squishMode = val
  self:UpdateSquish()
end

function GoldSquish:SetSPG(info, val)
  self.db.profile.spg = val
  self.db.profile.squishMode = "Custom"
  self:UpdateSquish()
end

function GoldSquish:SetCPS(info, val)
  self.db.profile.cps = val
  self.db.profile.squishMode = "Custom"
  self:UpdateSquish()
end

function GoldSquish:ResetToDefault()
  self.db.profile.cps = defaults.profile.cps
  self.db.profile.spg = defaults.profile.spg
  self.db.profile.squishMode = defaults.profile.squishMode
  self:UpdateSquish()
end

function GoldSquish:UpdateSquish()
  self:changeSquish(self.db.profile.spg, self.db.profile.cps)
end

function GoldSquish:changeSquish(spg, cps)
  SILVER_PER_GOLD=spg
  COPPER_PER_SILVER=cps
end

function GoldSquish:NoSquish()
  SILVER_PER_GOLD=100
  COPPER_PER_SILVER=100
end
