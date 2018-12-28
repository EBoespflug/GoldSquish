-- frFR.lua - GoldSquish
-- @author Etienne Boespflug
-- @version 1.0

local L = LibStub("AceLocale-3.0"):NewLocale("GoldSquish", "frFR")

-- Chat commands
L["goldsquish"] = true
L["gs"] = true

-- Mode
L["Squish mode"] = "Mode"
L["Select the squish mode used to transform the displayed golds."] = "Selectionne le niveau avec lequel la modification de la monnaie est percue."
L["Custom"] = "Personnalisé"

-- SPG & CPS
L["Silver per gold"] = "PAs par PO"
L["The amount of silver contained in one gold."] = "Le nombre de pièce(s) d'argent contenue(s) dans une pièce d'or."
L["Copper per silver"] = "PCs par PA"
L["The amount of copper contained in one silver."] = "Le nombre de pièce(s) de cuivre contenue(s) dans une pièce d'argent."
L["exemple_value"] = "<ex: 0.1, 100, 1000>" -- usage

-- Force update
L["Force update"] = true
L["Force GoldSquish to apply immediatly the changes"] = true

-- Reset to default
L["Reset to default"] = true
L["Reset all GoldSquish's Config to default values."] = true

-- Force update
L["Force update"] = "Forcez la mise à jour"
L["Force GoldSquish to apply immediatly the changes"] = "Force GoldeSquish à appliquer la modification de monnaie immédiatement."

-- Reset to default
L["Reset to default"] = "Réinitialiser"
L["Reset all GoldSquish's Config to default values."] = "Réinitialiser la configuration de GoldSquish aux valeurs par défaut."

-- Errors
L["squishMode_error"] = function(X)
   return "erreur : valeur non reconnue : " .. X .. ".";
end
L["SPG_typeError"] = function(X)
   return "erreur : valeur invalide : " .. X .. ".";
end
L["CPS_typeError"] = function(X)
   return "erreur : valeur invalide : " .. X .. ".";
end
