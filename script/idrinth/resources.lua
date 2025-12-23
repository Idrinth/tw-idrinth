local resourceChangedListener = function(context)
    if context:amount() == 0 then
        return;
    end;
    local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
    local resources = {"khaine", "kurnous", "asuryan"};
    for resource in resources do
        if context:resource():key() == "idrinth_"..resource then
            local element = core:get_or_create_component(
                "idrinth_pooled_resource_asuryan",
                "ui/idrinth/idrinth_pooled_resource_asuryan.twui.xml",
                parent
            );
            UIComponent(element:Find(0)):SetText(context:resource():value());
        end;
    end;
end;
local createResourceUI = function()
    local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
    core:get_or_create_component(
        "idrinth_pooled_resource_asuryan",
        "ui/idrinth/idrinth_pooled_resource_asuryan.twui.xml",
        parent
    );
    core:get_or_create_component(
        "idrinth_pooled_resource_kurnous",
        "ui/idrinth/idrinth_pooled_resource_kurnous.twui.xml",
        parent
    );
    core:get_or_create_component(
        "idrinth_pooled_resource_khaine",
        "ui/idrinth/idrinth_pooled_resource_khaine.twui.xml",
        parent
    );
end;
cm:add_first_tick_callback(                                                                       
    function()
        local idrinth, faction = Idrinth.Access.get();
        if faction == cm:get_local_faction() then
            createResourceUI();
            cm:add_pooled_resource_changed_listener_by_faction(
                "idrinth_PooledResourceListener",
                faction:name(),
                resourceChangedListener,
                true
            )
        end;
    end
);
core:add_listener(
    "idrinth_unlock_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == Idrinth.Constants.UnlockDilemma;
    end,
    function(context)
        if context:choice() == 1 then
            return;
        end
        createResourceUI();
        cm:add_pooled_resource_changed_listener_by_faction(
            "idrinth_PooledResourceListener",
            context:faction():name(),
            resourceChangedListener,
            true
        );
    end,
    true
);
core:add_listener(
    "idrinth_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        return idrinth and context:faction() == faction;
    end,
    function(context)
        local addResource = function(name, faction)
            local amount = cm:random_number(35);
            if amount == 0 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus5",
                    faction:name(),
                    1
                );
            elseif amount < 3 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus4",
                    faction:name(),
                    1
                );
            elseif amount < 6 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus3",
                    faction:name(),
                    1
                );
            elseif amount < 10 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus2",
                    faction:name(),
                    1
                );
            elseif amount < 15 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_minus1",
                    faction:name(),
                    1
                );
            elseif amount < 21 then
                -- 0 change
            elseif amount < 26 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus1",
                    faction:name(),
                    1
                );
            elseif amount < 30 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus2",
                    faction:name(),
                    1
                );
            elseif amount < 33 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus3",
                    faction:name(),
                    1
                );
            elseif amount < 35 then
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus4",
                    faction:name(),
                    1
                );
            else
                cm:apply_effect_bundle(
                    "idrinth_" .. name .. "_god_favour_plus5",
                    faction:name(),
                    1
                );
            end;
        end;
        addResource("asuryan", faction);
        addResource("kurnous", faction);
        addResource("khaine", faction);
    end,
    true
);
core:add_listener(
    "idrinth_CharacterCharacterTargetAction",
    "CharacterCharacterTargetAction",
    function(context)
        local idrinth = Idrinth.Access.get();
        if not idrinth then
            return false;
        end;
        return context:character() == idrinth;
    end,
    function(context)
        local ability = context:ability();
        local idrinth = Idrinth.Access.get();

        if ability == "hinder_army" then
            if context:mission_result_critial_failure() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_asuryan_other", -5);
            elseif context:mission_result_success() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_asuryan_other", 5);
            elseif context:mission_result_critial_success() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_asuryan_other", 15);
            end;
        elseif ability == "hinder_character" or ability == "hinder_agent" then
            if context:mission_result_critial_failure() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_kurnous_other", -5);
            elseif context:mission_result_success() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_kurnous_other", 5);
                cm:apply_effect_bundle_to_character("idrinth_successful_action_character", idrinth, 2);
            elseif context:mission_result_critial_success() then
                cm:pooled_resource_factor_transaction(context:character():faction():pooled_resource_manager(), "idrinth_kurnous_other", 15);
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_BattleCompleted",
    "BattleCompleted",
    function(context)
        return Idrinth.Access.spawned() and cm:model():pending_battle():has_been_fought();
    end,
    function(context)
        local addResource = function(name, faction, amount, battleResult)
            local results = {
                asuryan = {
                    heroic_victory = 125,
                    decisive_victory = 150,
                    close_victory = 100,
                    pyrrhic_victory = 50,
                    valiant_defeat = 75,
                    close_defeat = 75,
                    decisive_defeat = 25,
                    crushing_defeat = 0
                },
                kurnous = {
                    heroic_victory = 125,
                    decisive_victory = 100,
                    close_victory = 100,
                    pyrrhic_victory = 100,
                    valiant_defeat = 25,
                    close_defeat = 25,
                    decisive_defeat = 25,
                    crushing_defeat = 25
                },
                khaine = {
                    heroic_victory = 150,
                    decisive_victory = 125,
                    close_victory = 100,
                    pyrrhic_victory = 75,
                    valiant_defeat = 75,
                    close_defeat = 50,
                    decisive_defeat = 25,
                    crushing_defeat = 0
                }
            };
            local amt = amount * results[name][battleResult]/100 * (0.94 + cm:random_number(11)/100);
            cm:pooled_resource_factor_transaction(faction:pooled_resource_manager(), "idrinth_" .. name .. "_battles", am);
        end;
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
        local attackerCharacters = 0;
        for i = 1, cm:pending_battle_cache_num_attackers() do
            local char_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i);
            local characters = cm:pending_battle_cache_get_attacker_embedded_character_subtypes(i);
            local general = cm:get_character_by_cqi(char_cqi);
            if general then
                attackerCharacters = attackerCharacters + 1;
                if general:character_subtype("idrinth_hev_high_elf_vampires_idrinthgeneral") then
                    idrinthIsAttacker = true;
                end;
            end;
            for j=1, #characters do
                attackerCharacters = attackerCharacters + 1;
                if characters[j] == "idrinth_hev_high_elf_vampires_idrinthchampion" then
                    idrinthIsAttacker = true;
                end;
                if characters[j] == "idrinth_hev_high_elf_vampires_idrinthgeneral" then
                    idrinthIsAttacker = true;
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
                if general:character_subtype("idrinth_hev_high_elf_vampires_idrinthgeneral") then
                    idrinthIsDefender = true;
                end;
            end;
            for j=1, #characters do
                defenderCharacters = defenderCharacters + 1;
                if characters[j] == "idrinth_hev_high_elf_vampires_idrinthchampion" then
                    idrinthIsDefender = true;
                end;
                if characters[j] == "idrinth_hev_high_elf_vampires_idrinthgeneral" then
                    idrinthIsDefender = true;
                end;
            end;
        end;
        if idrinthIsAttacker then
            local base = 1;
            if attackerWon then
                base = 5;
            end;
            addResource(
                "asuryan",
                idrinthFaction,
                base + (1 - cm:model():pending_battle():percentage_of_attacker_killed()) * cm:pending_battle_cache_defender_value()/cm:pending_battle_cache_attacker_value(),
                cm:model():pending_battle():attacker_battle_result()
            );
            addResource(
                "kurnous",
                idrinthFaction,
                base + (1 + defenderCharacters)/(1 + attackerCharacters) * 5,
                cm:model():pending_battle():attacker_battle_result()
            );
            addResource(
                "khaine",
                idrinthFaction,
                base + cm:model():pending_battle():attacker_kills() * 0.0175,
                cm:model():pending_battle():attacker_battle_result()
            );
        elseif idrinthIsDefender then
            local base = 1;
            if defenderWon then
                base = 5;
            end;
            addResource(
                "asuryan",
                idrinthFaction,
                base + (1 - cm:model():pending_battle():percentage_of_defender_killed()) * cm:pending_battle_cache_attacker_value()/cm:pending_battle_cache_defender_value(),
                cm:model():pending_battle():defender_battle_result()
            );
            addResource(
                "kurnous",
                idrinthFaction,
                base + (1 + attackerCharacters)/(1 + defenderCharacters) * 5,
                cm:model():pending_battle():defender_battle_result()
            );
            addResource(
                "khaine",
                idrinthFaction,
                base + cm:model():pending_battle():defender_kills() * 0.0075,
                cm:model():pending_battle():defender_battle_result()
            );
        end;
    end,
    true
);