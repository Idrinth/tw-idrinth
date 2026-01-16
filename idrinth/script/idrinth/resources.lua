-- File-local constants
local RESOURCE_PREFIX = "idrinth_";
local GOD_FAVOUR_BATTLES_SUFFIX = "_battles";

local resourceChangedListener = function(context)
    if context:amount() == 0 then
        return;
    end;
    local parent = Idrinth.Ui.findElementWithin(Idrinth.Constants.Panels.HudCampaign, "resources_bar_holder", "resources_bar");
    if not parent then
        return;
    end;
    for _, resource in pairs(Idrinth.Constants.GodList) do
        if context:resource():key() == RESOURCE_PREFIX..resource then
            local element = Idrinth.Ui.createOrFind("idrinth_pooled_resource_"..resource, parent);
            UIComponent(element:Find(0)):SetText(context:resource():value());
        end;
    end;
end;
local applyRandomResourceBonus = function(name, faction)
    local amount = cm:random_number(35);
    if amount == 0 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_minus5",
            faction:name(),
            1
        );
    elseif amount < 3 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_minus4",
            faction:name(),
            1
        );
    elseif amount < 6 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_minus3",
            faction:name(),
            1
        );
    elseif amount < 10 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_minus2",
            faction:name(),
            1
        );
    elseif amount < 15 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_minus1",
            faction:name(),
            1
        );
    elseif amount < 21 then
        -- 0 change
    elseif amount < 26 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_plus1",
            faction:name(),
            1
        );
    elseif amount < 30 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_plus2",
            faction:name(),
            1
        );
    elseif amount < 33 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_plus3",
            faction:name(),
            1
        );
    elseif amount < 35 then
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_plus4",
            faction:name(),
            1
        );
    else
        cm:apply_effect_bundle(
            RESOURCE_PREFIX .. name .. "_god_favour_plus5",
            faction:name(),
            1
        );
    end;
end;
local battleResultModifiers = {
    [Idrinth.Constants.Gods.Asuryan] = {
        heroic_victory = 125,
        decisive_victory = 150,
        close_victory = 100,
        pyrrhic_victory = 50,
        valiant_defeat = 75,
        close_defeat = 75,
        decisive_defeat = 25,
        crushing_defeat = 0
    },
    [Idrinth.Constants.Gods.Kurnous] = {
        heroic_victory = 125,
        decisive_victory = 100,
        close_victory = 100,
        pyrrhic_victory = 100,
        valiant_defeat = 25,
        close_defeat = 25,
        decisive_defeat = 25,
        crushing_defeat = 25
    },
    [Idrinth.Constants.Gods.Khaine] = {
        heroic_victory = 150,
        decisive_victory = 125,
        close_victory = 100,
        pyrrhic_victory = 75,
        valiant_defeat = 75,
        close_defeat = 50,
        decisive_defeat = 25,
        crushing_defeat = 0
    };
};
local applyBattleResourceTransaction = function(name, faction, amount, battleResult)
    local amt = amount * battleResultModifiers[name][battleResult]/100 * (0.94 + cm:random_number(11)/100);
    cm:pooled_resource_factor_transaction(faction:pooled_resource_manager(), RESOURCE_PREFIX .. name .. GOD_FAVOUR_BATTLES_SUFFIX, amt);
end;
local createResourceUI = function()
    local parent = Idrinth.Ui.findElementWithin(Idrinth.Constants.Panels.HudCampaign, "resources_bar_holder", "resources_bar");
    if not parent then
        return;
    end;
    Idrinth.Ui.createOrFind("idrinth_pooled_resource_" .. Idrinth.Constants.Gods.Asuryan, parent);
    Idrinth.Ui.createOrFind("idrinth_pooled_resource_" .. Idrinth.Constants.Gods.Kurnous, parent);
    Idrinth.Ui.createOrFind("idrinth_pooled_resource_" .. Idrinth.Constants.Gods.Khaine, parent);
end;
cm:add_first_tick_callback(
    function()
        local _, faction = Idrinth.Access.get();
        if faction == cm:get_local_faction() then
            Idrinth.Ui.nowAndThen(createResourceUI);
            cm:add_pooled_resource_changed_listener_by_faction(
                "idrinth_PooledResourceListener",
                faction:name(),
                resourceChangedListener,
                true
            );
        end;
    end
);
Idrinth.Events.addListener(
    "resources",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == Idrinth.Constants.UnlockDilemma;
    end,
    function(context)
        if context:choice() == 1 then
            return;
        end;
        Idrinth.Ui.nowAndThen(createResourceUI);
        cm:add_pooled_resource_changed_listener_by_faction(
            "idrinth_PooledResourceListener",
            context:faction():name(),
            resourceChangedListener,
            true
        );
    end
);
Idrinth.Events.addListener(
    "resources",
    "FactionTurnStart",
    function(context)
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth;
    end,
    function(context)
        applyRandomResourceBonus(Idrinth.Constants.Gods.Asuryan, context:faction());
        applyRandomResourceBonus(Idrinth.Constants.Gods.Kurnous, context:faction());
        applyRandomResourceBonus(Idrinth.Constants.Gods.Khaine, context:faction());
    end
);
Idrinth.Events.addListener(
    "resources",
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

        local prm = context:character():faction():pooled_resource_manager();
        if ability == "hinder_army" then
            if context:mission_result_critial_failure() then
                cm:pooled_resource_factor_transaction(prm, "idrinth_asuryan_other", -5);
            elseif context:mission_result_success() then
                cm:pooled_resource_factor_transaction(prm, "idrinth_asuryan_other", 5);
            elseif context:mission_result_critial_success() then
                cm:pooled_resource_factor_transaction(prm, "idrinth_asuryan_other", 15);
            end;
        elseif ability == "hinder_character" or ability == "hinder_agent" then
            if context:mission_result_critial_failure() then
                cm:pooled_resource_factor_transaction(prm, "idrinth_kurnous_other", -5);
            elseif context:mission_result_success() then
                cm:pooled_resource_factor_transaction(prm, "idrinth_kurnous_other", 5);
                cm:apply_effect_bundle_to_character("idrinth_successful_action_character", idrinth, 2);
            elseif context:mission_result_critial_success() then
                cm:pooled_resource_factor_transaction(prm, "idrinth_kurnous_other", 15);
            end;
        end;
    end
);
Idrinth.Events.addListener(
    "resources",
    "BattleCompleted",
    function()
        if not cm:model():pending_battle():has_been_fought() then
            return false;
        end;
        return Idrinth.Access.spawned();
    end,
    function()
        local pending_battle = cm:model():pending_battle();
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
                end;
                if characters[j] == Idrinth.Constants.LordSubtype then
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
                end;
                if characters[j] == Idrinth.Constants.LordSubtype then
                    idrinthIsDefender = true;
                end;
            end;
        end;
        if idrinthIsAttacker then
            local base = 1;
            if attackerWon then
                base = 5;
            end;
            local _, idrinthFaction = Idrinth.Access.get();
            local attackerKilledPct = pending_battle:percentage_of_attacker_killed();
            local defenderValue = cm:pending_battle_cache_defender_value();
            local attackerValue = cm:pending_battle_cache_attacker_value();
            local asuryanAmount = base + (1 - attackerKilledPct) * defenderValue / attackerValue;
            applyBattleResourceTransaction(
                Idrinth.Constants.Gods.Asuryan,
                idrinthFaction,
                asuryanAmount,
                pending_battle:attacker_battle_result()
            );
            applyBattleResourceTransaction(
                Idrinth.Constants.Gods.Kurnous,
                idrinthFaction,
                base + (1 + defenderCharacters)/(1 + attackerCharacters) * 5,
                pending_battle:attacker_battle_result()
            );
            applyBattleResourceTransaction(
                Idrinth.Constants.Gods.Khaine,
                idrinthFaction,
                base + pending_battle:attacker_kills() * 0.0175,
                pending_battle:attacker_battle_result()
            );
        elseif idrinthIsDefender then
            local base = 1;
            if defenderWon then
                base = 5;
            end;
            local _, idrinthFaction = Idrinth.Access.get();
            local defenderKilledPct = pending_battle:percentage_of_defender_killed();
            local attackerVal = cm:pending_battle_cache_attacker_value();
            local defenderVal = cm:pending_battle_cache_defender_value();
            local asuryanAmt = base + (1 - defenderKilledPct) * attackerVal / defenderVal;
            applyBattleResourceTransaction(
                Idrinth.Constants.Gods.Asuryan,
                idrinthFaction,
                asuryanAmt,
                pending_battle:defender_battle_result()
            );
            applyBattleResourceTransaction(
                Idrinth.Constants.Gods.Kurnous,
                idrinthFaction,
                base + (1 + attackerCharacters)/(1 + defenderCharacters) * 5,
                pending_battle:defender_battle_result()
            );
            applyBattleResourceTransaction(
                Idrinth.Constants.Gods.Khaine,
                idrinthFaction,
                base + pending_battle:defender_kills() * 0.0075,
                pending_battle:defender_battle_result()
            );
        end;
    end
);
