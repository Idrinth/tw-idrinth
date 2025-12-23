local addSlayerTraits = function(asuryan, kurnous, khaine, idrinth_lookup)
    cm:force_add_trait(
        idrinth_lookup,
        "idrinth_slayer_elves_asuryan",
        true,
        asuryan
    );
    cm:force_add_trait(
        idrinth_lookup,
        "idrinth_slayer_elves_kurnous",
        true,
        kurnous
    );
    cm:force_add_trait(
        idrinth_lookup,
        "idrinth_slayer_elves_khaine",
        true,
        khaine
    );
end;
core:add_listener(
    "idrinth_BattleCompleted",
    "BattleCompleted",
    function(context)
        return Idrinth.Access.spawned() and cm:model():pending_battle():has_been_fought();
    end,
    function(context)
        local idrinth, idrinthFaction = Idrinth.Access.get();
        local attackerWon = false;
        if cm:pending_battle_cache_attacker_victory() then
            attackerWon = true;
        end;
        local defenderWon = false;
        if cm:pending_battle_cache_defender_victory() then
            defenderWon = true;
        end;
        local idrinthIsAttacker = false;
        local idrinthFactionName = nil;
        local attackerCharacters = 0;
        for i = 1, cm:pending_battle_cache_num_attackers() do
            local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i);
            local characters = cm:pending_battle_cache_get_attacker_embedded_character_subtypes(i);
            local general = cm:get_character_by_cqi(char_cqi);
            if general then
                attackerCharacters = attackerCharacters + 1;
                if general:character_subtype(Idrinth.Constants.BaseType..Idrinth.Constants.LordType) then
                    idrinthIsAttacker = true;
                    idrinthFactionName = faction_name;
                end;
            end;
            for j=1, #characters do
                attackerCharacters = attackerCharacters + 1;
                if characters[j] == Idrinth.Constants.BaseType..Idrinth.Constants.HeroType then
                    idrinthIsAttacker = true;
                    idrinthFactionName = faction_name;
                elseif characters[j] == Idrinth.Constants.BaseType..Idrinth.Constants.LordType then
                    idrinthIsAttacker = true;
                    idrinthFactionName = faction_name;
                end;
            end;
        end;
        local idrinthIsDefender = false;
        local defenderCharacters = 0;
        for i = 1, cm:pending_battle_cache_num_defenders() do
            local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(i);
            local characters = cm:pending_battle_cache_get_defender_embedded_character_subtypes(i);
            local general = cm:get_character_by_cqi(char_cqi);
            if general then
                defenderCharacters = defenderCharacters + 1;
                if general:character_subtype(Idrinth.Constants.BaseType..Idrinth.Constants.LordType) then
                    idrinthIsDefender = true;
                    idrinthFactionName = faction_name;
                end;
            end;
            for j=1, #characters do
                defenderCharacters = defenderCharacters + 1;
                if characters[j] == Idrinth.Constants.BaseType..Idrinth.Constants.HeroType then
                    idrinthIsDefender = true;
                    idrinthFactionName = faction_name;
                elseif characters[j] == Idrinth.Constants.BaseType..Idrinth.Constants.LordType then
                    idrinthIsDefender = true;
                    idrinthFactionName = faction_name;
                end;
            end;
        end;
        if idrinthIsAttacker then
            Idrinth.Statistics.BattlesFought = Idrinth.Statistics.BattlesFought + 1;
            if not attackerWon then
                for i = 1, cm:pending_battle_cache_num_defenders() do
                    local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(i);
                    local general = cm:get_character_by_cqi(char_cqi);
                    if general then
                        cm:force_add_trait(
                            cm:char_lookup_str(general),
                            "idrinth_killer",
                            true,
                            1
                        );
                    end;
                end;
            end;
            if cm:pending_battle_cache_culture_is_defender("wh2_main_hef_high_elves") then
                addSlayerTraits(3, 2, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_defender("wh_dlc05_wef_wood_elves") then
                addSlayerTraits(2, 3, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_defender("wh2_main_def_dark_elves") then
                addSlayerTraits(2, 1, 3, cm:char_lookup_str(idrinth));
            end;
        elseif idrinthIsDefender then
            Idrinth.Statistics.BattlesFought = Idrinth.Statistics.BattlesFought + 1;
            if not defenderWon then
                for i = 1, cm:pending_battle_cache_num_attackers() do
                    local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i);
                    local general = cm:get_character_by_cqi(char_cqi);
                    if general then
                        cm:force_add_trait(
                            cm:char_lookup_str(general),
                            "idrinth_killer",
                            true,
                            1
                        );
                    end;
                end;
            end;
            if cm:pending_battle_cache_culture_is_attacker("wh2_main_hef_high_elves") then
                addSlayerTraits(3, 2, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_attacker("wh_dlc05_wef_wood_elves") then
                addSlayerTraits(2, 3, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_attacker("wh2_main_def_dark_elves") then
                addSlayerTraits(2, 1, 3, cm:char_lookup_str(idrinth));
            end;
        end;
    end,
    true
);