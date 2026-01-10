local unittypes = {};

unittypes.isChapelUnit = function(unitKey)
    return unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_great_eagle" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine" or unitKey == "idrinth_hev_high_elf_vampires_chapel_mixed" or unitKey== "idrinth_hev_high_elf_vampires_chapel_cave_bats" or unitKey == "idrinth_hev_high_elf_vampires_chapel_hawks" or unitKey == "idrinth_hev_high_elf_vampires_chapel_wolves" or unitKey == "idrinth_hev_high_elf_vampires_chapel_outriders" or unitKey == "idrinth_hev_high_elf_vampires_chapel_stone_wolves" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire" or "idrinth_hef_high_elv_vampires_idrinthgeneral" or "idrinth_hev_high_elf_vampires_idrinthchampion" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_varghulf" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_varghulf" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_varghulf";
end;
unittypes.isSingleEntity = function(unitKey)
    return unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_great_eagle" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire" or "idrinth_hev_high_elf_vampires_idrinthgeneral" or "idrinth_hev_high_elf_vampires_idrinthchampion" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_varghulf" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_varghulf" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_varghulf";
end;
unittypes.isBlessedAnimal = function(unitKey)
    return unitKey == "idrinth_hev_high_elf_vampires_chapel_great_eagle" or unitKey== "idrinth_hev_high_elf_vampires_chapel_cave_bats" or unitKey == "idrinth_hev_high_elf_vampires_chapel_hawks" or unitKey == "idrinth_hev_high_elf_vampires_chapel_wolves";
end;
unittypes.isConstruct = function(unitKey)
    return unitKey == "idrinth_hev_high_elf_vampires_chapel_stone_wolves" or unitKey == "idrinth_hev_high_elf_vampires_chapel_shrine";
end;
unittypes.isElven = function(unitKey)
    return unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine" or unitKey == "idrinth_hev_high_elf_vampires_chapel_mixed" or unitKey == "idrinth_hev_high_elf_vampires_chapel_outriders" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire" or "idrinth_hev_high_elf_vampires_idrinthgeneral" or "idrinth_hev_high_elf_vampires_idrinthchampion";
end;
unittypes.isPriest = function(unitKey)
    return unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire";
end;
unittypes.isVampiric = function(unitKey)
    return unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire" or "idrinth_hev_high_elf_vampires_idrinthgeneral" or "idrinth_hev_high_elfv_vampires_idrinthchampion" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_varghulf" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_varghulf" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_varghulf";
end;

return unittypes;