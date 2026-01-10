local enableRenaming = true;

core:add_listener(
    "idrinth_renaming_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "renaming");
        enableRenaming = context:mct():get_mod_by_key("idrinth"):get_option_by_key("names"):get_finalized_setting();
    end,
    true
)
core:add_listener(
    "idrinth_renaming_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        Idrinth.log("MctFinalized", "renaming");
        enableRenaming = context:mct():get_mod_by_key("idrinth"):get_option_by_key("names"):get_finalized_setting();
    end,
    true
);
core:add_listener(
    "idrinth_renaming_UnitCreated",
    "UnitCreated",
    function(context)
        if not enableRenaming then
            return false;
        end;
        if not Idrinth.Access.spawned() then
            return false;
        end;
        local unitKey = context:unit():unit_key();
        return unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_great_eagle" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine" or unitKey == "idrinth_hev_high_elf_vampires_chapel_mixed" or unitKey== "idrinth_hev_high_elf_vampires_chapel_cave_bats" or unitKey == "idrinth_hev_high_elf_vampires_chapel_hawks" or unitKey == "idrinth_hev_high_elf_vampires_chapel_wolves" or unitKey == "idrinth_hev_high_elf_vampires_chapel_outriders" or unitKey == "idrinth_hev_high_elf_vampires_chapel_stone_wolves" or unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire";
    end,
    function(context)
        Idrinth.log("UnitCreated", "renaming");
        local length = #Idrinth.Names;
        local name = Idrinth.Names[cm:random_number(length)];
        local finalName = "";
        local unitKey = context:unit():unit_key();
        if unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" or unitKey == "idrinth_hev_high_elf_vampires_chapel_great_eagle" then
            finalName = name;
        elseif unitKey == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire" or unitKey == "idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire" then
            finalName = name.." Thalui";
        elseif string.ends_with(name, "s") then
            finalName = name .. "' " .. common.get_localised_string("land_units_onscreen_name_" .. unitKey);
        else
            finalName = name .. "'s " .. common.get_localised_string("land_units_onscreen_name_" .. unitKey);
        end;
        cm:change_custom_unit_name(context:unit(), finalName);
        if context:unit():has_unit_commander() then
            cm:change_character_custom_name(
                context:unit():unit_commander(),
                finalName,
                "",
                "",
                ""
            );
        end;
    end,
    true
);