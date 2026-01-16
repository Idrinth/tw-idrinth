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
local adjustDevotionTraitsBy = function(idrinth, devotion, points)
    local negative = idrinth:trait_points(devotion.."_negative");
    local positive = idrinth:trait_points(devotion.."_positive");

    local total = positive - negative + points;

    local idrinth_lookup = cm:char_lookup_str(idrinth);

    cm:disable_event_feed_events(true);
    cm:force_remove_trait(idrinth_lookup, devotion.."_positive");
    cm:force_remove_trait(idrinth_lookup, devotion.."_negative");
    cm:disable_event_feed_events(false);

    local movedPastTier = false;
    if points > 0 then
        if total >= 5 and total - points < 5 then
            movedPastTier = true;
        elseif total >= 15 and total - points < 15 then
            movedPastTier = true;
        elseif total >= 35 and total - points < 35 then
            movedPastTier = true;
        end;
    else
        if total <= -10 and total + points > -10 then
            movedPastTier = true;
        elseif total <= -25 and total + points > -25 then
            movedPastTier = true;
        end;
    end;

    if total < -25 then
        total = -25;
    end;
    if total > 35 then
        total = 35;
    end;

    if total < 0 then
        cm:force_add_trait(
            idrinth_lookup,
            devotion.."_negative",
            movedPastTier,
            0 - total
        );
    elseif total > 0 then
        cm:force_add_trait(
            idrinth_lookup,
            devotion.."_positive",
            movedPastTier,
            total
        );
    end;
    Idrinth.log("Total "..devotion.." is: "..total, "traits");
    return total;
end;
Idrinth.Events.addListener(
    "FactionTurnStart",
    function(context)
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth and not idrinth:is_wounded();
    end,
    function()
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
                            local totalValue = adjustDevotionTraitsBy(idrinth, devotion, 1);
                            for otherDevotion, _ in pairs(relevantDevotions) do
                                if otherDevotion ~= devotion then
                                    if totalValue > 34 then
                                        adjustDevotionTraitsBy(idrinth, otherDevotion, -4);
                                    elseif totalValue > 14 then
                                        adjustDevotionTraitsBy(idrinth, otherDevotion, -2);
                                    elseif totalValue > 4 then
                                        adjustDevotionTraitsBy(idrinth, otherDevotion, -1);
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
    end
);
Idrinth.Events.addListener(
    "BattleCompleted",
    Idrinth.Events.Conditions.battleFoughtAndSpawned,
    function()
        local attackerWon = false;
        if cm:pending_battle_cache_attacker_victory() then
            attackerWon = true;
        end;
        local defenderWon = false;
        if cm:pending_battle_cache_defender_victory() then
            defenderWon = true;
        end;
        local idrinthIsAttacker = false;
        local attackerCharacters = 0;
        for i = 1, cm:pending_battle_cache_num_attackers() do
            local char_cqi = cm:pending_battle_cache_get_attacker(i);
            local characters = cm:pending_battle_cache_get_attacker_embedded_character_subtypes(i);
            local general = cm:get_character_by_cqi(char_cqi);
            if general then
                attackerCharacters = attackerCharacters + 1;
                if general:character_subtype(Idrinth.Constants.LordSubtype) then
                    idrinthIsAttacker = true;
                end;
            end;
            for j=1, #characters do
                attackerCharacters = attackerCharacters + 1;
                if characters[j] == Idrinth.Constants.HeroSubtype then
                    idrinthIsAttacker = true;
                elseif characters[j] == Idrinth.Constants.LordSubtype then
                    idrinthIsAttacker = true;
                end;
            end;
        end;
        local idrinthIsDefender = false;
        local defenderCharacters = 0;
        for i = 1, cm:pending_battle_cache_num_defenders() do
            local char_cqi = cm:pending_battle_cache_get_defender(i);
            local characters = cm:pending_battle_cache_get_defender_embedded_character_subtypes(i);
            local general = cm:get_character_by_cqi(char_cqi);
            if general then
                defenderCharacters = defenderCharacters + 1;
                if general:character_subtype(Idrinth.Constants.LordSubtype) then
                    idrinthIsDefender = true;
                end;
            end;
            for j=1, #characters do
                defenderCharacters = defenderCharacters + 1;
                if characters[j] == Idrinth.Constants.HeroSubtype then
                    idrinthIsDefender = true;
                elseif characters[j] == Idrinth.Constants.LordSubtype then
                    idrinthIsDefender = true;
                end;
            end;
        end;
        if idrinthIsAttacker then
            Idrinth.Statistics.BattlesFought = Idrinth.Statistics.BattlesFought + 1;
            if not attackerWon then
                for i = 1, cm:pending_battle_cache_num_defenders() do
                    local char_cqi = cm:pending_battle_cache_get_defender(i);
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
            local idrinth = Idrinth.Access.get();
            if cm:pending_battle_cache_culture_is_defender(Idrinth.Constants.Cultures.HighElves) then
                addSlayerTraits(4, 2, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_defender(Idrinth.Constants.Cultures.WoodElves) then
                addSlayerTraits(2, 4, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_defender(Idrinth.Constants.Cultures.DarkElves) then
                addSlayerTraits(2, 1, 4, cm:char_lookup_str(idrinth));
            end;
        elseif idrinthIsDefender then
            Idrinth.Statistics.BattlesFought = Idrinth.Statistics.BattlesFought + 1;
            if not defenderWon then
                for i = 1, cm:pending_battle_cache_num_attackers() do
                    local char_cqi = cm:pending_battle_cache_get_attacker(i);
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
            local idrinth = Idrinth.Access.get();
            if cm:pending_battle_cache_culture_is_attacker(Idrinth.Constants.Cultures.HighElves) then
                addSlayerTraits(4, 2, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_attacker(Idrinth.Constants.Cultures.WoodElves) then
                addSlayerTraits(2, 4, 1, cm:char_lookup_str(idrinth));
            end;
            if cm:pending_battle_cache_culture_is_attacker(Idrinth.Constants.Cultures.DarkElves) then
                addSlayerTraits(2, 1, 4, cm:char_lookup_str(idrinth));
            end;
        end;
    end
);
