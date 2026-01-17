--- @module Idrinth.Unittypes
--- Unit type classification module for the Idrinth mod.
--- Provides predicate functions to check unit types (chapel units, vampires, priests, etc.).
--- @return table Module with isChapelUnit, isSingleEntity, isBlessedAnimal, isConstruct, isElven, isPriest, isVampiric, isVarghulf, isEliteTroop, isEnlargedEliteTroop, isCavalry, isEnlargedCavalry, isHero.

local unittypes = {};

local CP = "idrinth_hev_high_elf_vampires_chapel_";
local HP = "idrinth_hev_high_elf_vampires_idrinth";

local chapelUnits = {
    [CP.."asuryan_leader"] = true,
    [CP.."kurnous_leader"] = true,
    [CP.."khaine_leader"] = true,
    [CP.."great_eagle"] = true,
    [CP.."asuryan"] = true,
    [CP.."kurnous"] = true,
    [CP.."khaine"] = true,
    [CP.."mixed"] = true,
    [CP.."cave_bats"] = true,
    [CP.."hawks"] = true,
    [CP.."wolves"] = true,
    [CP.."outriders"] = true,
    [CP.."stone_wolves"] = true,
    [CP.."asuryan_leader_vampire"] = true,
    [CP.."kurnous_leader_vampire"] = true,
    [CP.."khaine_leader_vampire"] = true,
    [HP.."general"] = true,
    [HP.."champion"] = true,
    [CP.."khaine_varghulf"] = true,
    [CP.."kurnous_varghulf"] = true,
    [CP.."asuryan_varghulf"] = true,
    [CP.."asuryan_large"] = true,
    [CP.."kurnous_large"] = true,
    [CP.."khaine_large"] = true,
    [CP.."outriders_large"] = true,
};

local singleEntityUnits = {
    [CP.."asuryan_leader"] = true,
    [CP.."kurnous_leader"] = true,
    [CP.."khaine_leader"] = true,
    [CP.."great_eagle"] = true,
    [CP.."asuryan_leader_vampire"] = true,
    [CP.."kurnous_leader_vampire"] = true,
    [CP.."khaine_leader_vampire"] = true,
    [HP.."general"] = true,
    [HP.."champion"] = true,
    [CP.."khaine_varghulf"] = true,
    [CP.."kurnous_varghulf"] = true,
    [CP.."asuryan_varghulf"] = true,
};

local blessedAnimalUnits = {
    [CP.."great_eagle"] = true,
    [CP.."cave_bats"] = true,
    [CP.."hawks"] = true,
    [CP.."wolves"] = true,
};

local constructUnits = {
    [CP.."stone_wolves"] = true,
    [CP.."shrine"] = true,
};

local elvenUnits = {
    [CP.."asuryan_leader"] = true,
    [CP.."kurnous_leader"] = true,
    [CP.."khaine_leader"] = true,
    [CP.."asuryan"] = true,
    [CP.."kurnous"] = true,
    [CP.."khaine"] = true,
    [CP.."mixed"] = true,
    [CP.."outriders"] = true,
    [CP.."asuryan_leader_vampire"] = true,
    [CP.."kurnous_leader_vampire"] = true,
    [CP.."khaine_leader_vampire"] = true,
    [HP.."general"] = true,
    [HP.."champion"] = true,
    [CP.."asuryan_large"] = true,
    [CP.."kurnous_large"] = true,
    [CP.."khaine_large"] = true,
    [CP.."outriders_large"] = true,
};

local priestUnits = {
    [CP.."asuryan_leader"] = true,
    [CP.."kurnous_leader"] = true,
    [CP.."khaine_leader"] = true,
    [CP.."asuryan_leader_vampire"] = true,
    [CP.."kurnous_leader_vampire"] = true,
    [CP.."khaine_leader_vampire"] = true,
};

local vampiricUnits = {
    [CP.."asuryan_leader_vampire"] = true,
    [CP.."kurnous_leader_vampire"] = true,
    [CP.."khaine_leader_vampire"] = true,
    [HP.."general"] = true,
    [HP.."champion"] = true,
    [CP.."khaine_varghulf"] = true,
    [CP.."kurnous_varghulf"] = true,
    [CP.."asuryan_varghulf"] = true,
};

local varghulfUnits = {
    [CP.."khaine_varghulf"] = true,
    [CP.."kurnous_varghulf"] = true,
    [CP.."asuryan_varghulf"] = true,
};

local eliteTroopUnits = {
    [CP.."asuryan"] = true,
    [CP.."kurnous"] = true,
    [CP.."khaine"] = true,
};

local enlargedEliteTroopUnits = {
    [CP.."asuryan_large"] = true,
    [CP.."kurnous_large"] = true,
    [CP.."khaine_large"] = true,
};

local cavalryUnits = {
    [CP.."outriders"] = true,
    [CP.."outriders_large"] = true,
};

local enlargedCavalryUnits = {
    [CP.."outriders_large"] = true,
};

local heroUnits = {
    [HP.."general"] = true,
    [HP.."champion"] = true,
};

--- Checks if a unit is a chapel-recruitable unit.
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is a chapel unit.
unittypes.isChapelUnit = function(unitKey)
    return chapelUnits[unitKey] == true;
end;

--- Checks if a unit is a single entity (heroes, priests, varghulfs).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is a single entity.
unittypes.isSingleEntity = function(unitKey)
    return singleEntityUnits[unitKey] == true;
end;

--- Checks if a unit is a blessed animal (eagle, bats, hawks, wolves).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is a blessed animal.
unittypes.isBlessedAnimal = function(unitKey)
    return blessedAnimalUnits[unitKey] == true;
end;

--- Checks if a unit is a construct (stone wolves, shrine).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is a construct.
unittypes.isConstruct = function(unitKey)
    return constructUnits[unitKey] == true;
end;

--- Checks if a unit has elven composition.
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is elven.
unittypes.isElven = function(unitKey)
    return elvenUnits[unitKey] == true;
end;

--- Checks if a unit is a priest (god leaders).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is a priest.
unittypes.isPriest = function(unitKey)
    return priestUnits[unitKey] == true;
end;

--- Checks if a unit is vampiric (vampire priests, varghulfs, hero units).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is vampiric.
unittypes.isVampiric = function(unitKey)
    return vampiricUnits[unitKey] == true;
end;

--- Checks if a unit is a varghulf.
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is a varghulf.
unittypes.isVarghulf = function(unitKey)
    return varghulfUnits[unitKey] == true;
end;

--- Checks if a unit is an elite troop (god-dedicated infantry).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is an elite troop.
unittypes.isEliteTroop = function(unitKey)
    return eliteTroopUnits[unitKey] == true;
end;

--- Checks if a unit is an enlarged elite troop (larger variant).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is an enlarged elite troop.
unittypes.isEnlargedEliteTroop = function(unitKey)
    return enlargedEliteTroopUnits[unitKey] == true;
end;

--- Checks if a unit is cavalry (outriders).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is cavalry.
unittypes.isCavalry = function(unitKey)
    return cavalryUnits[unitKey] == true;
end;

--- Checks if a unit is enlarged cavalry.
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is enlarged cavalry.
unittypes.isEnlargedCavalry = function(unitKey)
    return enlargedCavalryUnits[unitKey] == true;
end;

--- Checks if a unit is a hero unit (Idrinth general or champion).
--- @param unitKey string The unit record key to check.
--- @return boolean True if the unit is a hero.
unittypes.isHero = function(unitKey)
    return heroUnits[unitKey] == true;
end;

return unittypes;
