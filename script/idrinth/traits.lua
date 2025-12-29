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
    "idrinth_traits_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        return idrinth and not idrinth:is_wounded() and context:faction() == faction;
    end,
    function()
        Idrinth.log("FactionTurnStart", "traits");
        local relevantDevotions = {
            idrinth_devotion_asuryan = "idrinth_asuryan_pledge",
            idrinth_devotion_khaine = "idrinth_khaine_pledge",
            idrinth_devotion_kurnous = "idrinth_kurnous_pledge",
        };
        local idrinth = Idrinth.Access.get();
        local initiatives = idrinth:character_details():character_initiative_sets();
        Idrinth.log(initiatives:num_items(), "traits");
        for i = 0, initiatives:num_items() - 1 do
            local initiativeSet = initiatives:item_at(i);
            if initiativeSet then
                local initiative = initiativeSet:active_initiatives();
                if initiative and not initiative:is_empty() then
                    local activeInitiative = initiative:item_at(0);
                    for devotion, devotionInitiative in pairs(relevantDevotions) do
                        Idrinth.log(activeInitiative:record_key() .. "=" .. devotionInitiative, "traits");
                        if activeInitiative:record_key() == devotionInitiative then
                            cm:force_add_trait(
                                cm:char_lookup_str(idrinth),
                                devotion.."_positive",
                                true,
                                1
                            );
                            for otherDevotion, _ in pairs(relevantDevotions) do
                                if not (otherDevotion == devotion) then
                                    if idrinth:trait_points(devotion.."_positive") > 34 then
                                        cm:force_add_trait(
                                            cm:char_lookup_str(idrinth),
                                            devotion.."_negative",
                                            true,
                                            4
                                        );
                                    elseif idrinth:trait_points(devotion.."_positive") > 14 then
                                        cm:force_add_trait(
                                            cm:char_lookup_str(idrinth),
                                            devotion.."_negative",
                                            true,
                                            2
                                        );
                                    elseif idrinth:trait_points(devotion.."_positive") > 4 then
                                        cm:force_add_trait(
                                            cm:char_lookup_str(idrinth),
                                            devotion.."_negative",
                                            true,
                                            1
                                        );
                                    end;
                                end;
                            end;
                        end;
                    end;
                else
                    Idrinth.log("no active initiative in set", "traits");
                end;
            else
                Idrinth.log("empty initiative set", "traits");
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_traits_BattleCompleted",
    "BattleCompleted",
    function(context)
        return Idrinth.Access.spawned() and cm:model():pending_battle():has_been_fought();
    end,
    function(context)
        Idrinth.log("BattleCompleted", "traits");
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
                addSlayerTraits(4, 2, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_defender("wh_dlc05_wef_wood_elves") then
                addSlayerTraits(2, 4, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_defender("wh2_main_def_dark_elves") then
                addSlayerTraits(2, 1, 4, cm:char_lookup_str(idrinth));
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
                addSlayerTraits(4, 2, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_attacker("wh_dlc05_wef_wood_elves") then
                addSlayerTraits(2, 4, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_attacker("wh2_main_def_dark_elves") then
                addSlayerTraits(2, 1, 4, cm:char_lookup_str(idrinth));
            end;
        end;
    end,
    true
);