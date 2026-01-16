local unittypes = {};

-- File-local constants for repeated unit key prefixes
local CP = "idrinth_hev_high_elf_vampires_chapel_";  -- Chapel prefix
local HP = "idrinth_hev_high_elf_vampires_idrinth";  -- Hero prefix

-- Hashmap lookups for O(1) unit type checking
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

unittypes.isChapelUnit = function(unitKey)
    return chapelUnits[unitKey] == true;
end;

unittypes.isSingleEntity = function(unitKey)
    return singleEntityUnits[unitKey] == true;
end;

unittypes.isBlessedAnimal = function(unitKey)
    return blessedAnimalUnits[unitKey] == true;
end;

unittypes.isConstruct = function(unitKey)
    return constructUnits[unitKey] == true;
end;

unittypes.isElven = function(unitKey)
    return elvenUnits[unitKey] == true;
end;

unittypes.isPriest = function(unitKey)
    return priestUnits[unitKey] == true;
end;

unittypes.isVampiric = function(unitKey)
    return vampiricUnits[unitKey] == true;
end;

unittypes.isVarghulf = function(unitKey)
    return varghulfUnits[unitKey] == true;
end;

unittypes.isEliteTroop = function(unitKey)
    return eliteTroopUnits[unitKey] == true;
end;

unittypes.isEnlargedEliteTroop = function(unitKey)
    return enlargedEliteTroopUnits[unitKey] == true;
end;

unittypes.isCavalry = function(unitKey)
    return cavalryUnits[unitKey] == true;
end;

unittypes.isEnlargedCavalry = function(unitKey)
    return enlargedCavalryUnits[unitKey] == true;
end;

unittypes.isHero = function(unitKey)
    return heroUnits[unitKey] == true;
end;

return unittypes;
