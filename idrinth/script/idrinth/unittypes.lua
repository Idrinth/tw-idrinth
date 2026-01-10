local unittypes = {};

-- Hashmap lookups for O(1) unit type checking
local chapelUnits = {
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_great_eagle"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_mixed"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_cave_bats"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_hawks"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_wolves"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_outriders"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_stone_wolves"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire"] = true,
    ["idrinth_hef_high_elv_vampires_idrinthgeneral"] = true,
    ["idrinth_hev_high_elf_vampires_idrinthchampion"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_varghulf"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_varghulf"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_varghulf"] = true,
};

local singleEntityUnits = {
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_great_eagle"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_idrinthgeneral"] = true,
    ["idrinth_hev_high_elf_vampires_idrinthchampion"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_varghulf"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_varghulf"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_varghulf"] = true,
};

local blessedAnimalUnits = {
    ["idrinth_hev_high_elf_vampires_chapel_great_eagle"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_cave_bats"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_hawks"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_wolves"] = true,
};

local constructUnits = {
    ["idrinth_hev_high_elf_vampires_chapel_stone_wolves"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_shrine"] = true,
};

local elvenUnits = {
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_mixed"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_outriders"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_idrinthgeneral"] = true,
    ["idrinth_hev_high_elf_vampires_idrinthchampion"] = true,
};

local priestUnits = {
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire"] = true,
};

local vampiricUnits = {
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire"] = true,
    ["idrinth_hev_high_elf_vampires_idrinthgeneral"] = true,
    ["idrinth_hev_high_elf_vampires_idrinthchampion"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_khaine_varghulf"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_kurnous_varghulf"] = true,
    ["idrinth_hev_high_elf_vampires_chapel_asuryan_varghulf"] = true,
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

return unittypes;
