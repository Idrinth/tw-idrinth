local unlockLevelAdjustment = nil;
local levelAdjustment = {
    null = 0,
    one = 1,
    three = 3,
    six = 6,
};
local afterUnlockDilemmas = {
    wh2_main_hef_high_elves = "idrinth_dilemma_unlock_high_elves",
    wh_main_vmp_vampire_counts = "idrinth_dilemma_unlock_vampire_counts",
    wh_main_emp_empire = "idrinth_dilemma_unlock_empire",
    wh_dlc05_wef_wood_elves = "idrinth_dilemma_unlock_wood_elves",
    wh3_main_ksl_kislev = "idrinth_dilemma_unlock_kislev",
    mixer_nag_nagash = "idrinth_dilemma_unlock_nagash",
    wh2_main_def_dark_elves = "idrinth_dilemma_unlock_dark_elves",
    wh2_dlc11_cst_vampire_coast = "idrinth_dilemma_unlock_vampire_coast",
    wh_main_brt_bretonnia = "idrinth_dilemma_unlock_bretonnia",
    wh3_main_cth_cathay = "idrinth_dilemma_unlock_cathay",
};
local unlockMissions = {
    wh2_main_hef_high_elves = "idrinth_unlock_wh2_main_hef_high_elves",
    wh_main_vmp_vampire_counts = "idrinth_unlock_wh_main_vmp_vampire_counts",
    wh_main_emp_empire = "idrinth_unlock_wh_main_emp_empire",
    wh_dlc05_wef_wood_elves = "idrinth_unlock_wh_dlc05_wef_wood_elves",
    wh3_main_ksl_kislev = "idrinth_unlock_wh3_main_ksl_kislev",
    mixer_nag_nagash = "idrinth_unlock_mixer_nag_nagash",
    wh2_main_def_dark_elves = "idrinth_unlock_wh2_main_def_dark_elves",
    wh2_dlc11_cst_vampire_coast = "idrinth_unlock_wh2_dlc11_cst_vampire_coast",
    wh_main_brt_bretonnia = "idrinth_unlock_wh_main_brt_bretonnia",
    wh3_main_cth_cathay = "idrinth_unlock_wh3_main_cth_cathay",
};
local unlockForAIRank = {
    wh2_main_hef_high_elves = 20,
    wh_main_vmp_vampire_counts = 26,
    wh_main_emp_empire = 23,
    wh_dlc05_wef_wood_elves = 21,
    wh3_main_ksl_kislev = 22,
    mixer_nag_nagash = 29,
    wh2_main_def_dark_elves = 24,
    wh2_dlc11_cst_vampire_coast = 27,
    wh_main_brt_bretonnia = 25,
    wh3_main_cth_cathay = 28,
};
local nameByCulture = {
    wh2_main_hef_high_elves = {
        forename = "99991000000008",
        familyname = "99991000000009",
        clanname = "99991000000010",
    },
    wh_main_vmp_vampire_counts = {
        forename = "99991000000014",
        familyname = "99991000000015",
        clanname = "99991000000016",
    },
    wh_main_emp_empire = {
        forename = "99991000000005",
        familyname = "99991000000006",
        clanname = "99991000000007",
    },
    wh_dlc05_wef_wood_elves = {
        forename = "99991000000017",
        familyname = "99991000000018",
        clanname = "99991000000019",
    },
    wh3_main_ksl_kislev = {
        forename = "99991000000011",
        familyname = "99991000000012",
        clanname = "99991000000013",
    },
    mixer_nag_nagash = {
        forename = "99991000000011",
        familyname = "99991000000012",
        clanname = "99991000000013",
    },
    wh2_main_def_dark_elves = {
        forename = "99991000000002",
        familyname = "99991000000003",
        clanname = "99991000000004",
    },
    wh2_dlc11_cst_vampire_coast = {
        forename = "99990999999990",
        familyname = "99990999999991",
        clanname = "99990999999992",
    },
    wh_main_brt_bretonnia = {
        forename = "99990999999993",
        familyname = "99990999999994",
        clanname = "99990999999995",
    },
    wh3_main_cth_cathay = {
        forename = "99990999999999",
        familyname = "99991000000000",
        clanname = "99991000000001",
    },
};
local unlockDilemma = "idrinth_unlock_choice";
local unlockMissionStarted = {};
local spawnIdrinthArmy = function(faction, region, x, y)
    cm:create_force_with_general(
        faction:name(),
        "idrinth_hev_high_elf_vampires_chapel_mixed",
        region:name(),
        x,
        y,
        Idrinth.Constants.LordType,
        Idrinth.Constants.LordSubtype,
        "names_name_"..nameByCulture[faction:culture()]["forename"],
        "names_name_"..nameByCulture[faction:culture()]["clanname"],
        "names_name_"..nameByCulture[faction:culture()]["familyname"],
        "",
        false,
        function(cqi)
            local character = cm:get_character_by_cqi(cqi);
            cm:set_character_unique(cm:char_lookup_str(character), true);
            cm:set_character_immortality(cm:char_lookup_str(character), true);
            cm:force_add_trait(
                cm:char_lookup_str(character),
                "idrinth_thalui_name",
                false,
                1
            );
        end;
    );
end;
local spawnIdrinth = function(agentType, faction)
    if agentType == Idrinth.Constants.LordType then
        if faction:faction_leader():has_region() then
            local x, y = cm:find_valid_spawn_location_for_character_from_position(
                faction:name(),
                faction:faction_leader():logical_position_x(),
                faction:faction_leader():logical_position_y(),
                true
            );
            spawnIdrinthArmy(faction, faction:faction_leader():region(), x, y);
        elseif faction:has_home_region() then
            local x, y = cm:find_valid_spawn_location_for_character_from_position(
                faction:name(),
                faction:home_region():settlement():logical_position_x(),
                faction:home_region():settlement():logical_position_y(),
                true
            );
            spawnIdrinthArmy(faction, faction:home_region(), x, y);
        end;
    elseif agentType == Idrinth.Constants.HeroType then         
        if faction:faction_leader():has_region() then
            cm:spawn_unique_agent_at_character(
                faction:command_queue_index(),
                Idrinth.Constants.HeroSubtype,
                faction:faction_leader():command_queue_index(),
                true
            );
        elseif faction:has_home_region() then
            cm:spawn_unique_agent_at_region(
                faction:cqi(),
                Idrinth.Constants.HeroSubtype,
                faction:home_region():cqi(),
                true
            );
        end;
    end;
    idrinth = Idrinth.Access.get();
    if not idrinth then
        return;
    end;
    cm:replenish_action_points(cm:char_lookup_str(idrinth));
    for _, culture in pairs(Idrinth.Cultures.get()) do
        for _, faction in pairs(cm:get_factions_by_culture(culture)) do
            if faction:is_human() and unlockMissionStarted[faction:name()] then
                cm:cancel_custom_mission(faction:name(), unlockMissions[culture]);
                unlockMissionStarted[faction:name()] = false;
            elseif faction:is_human() and faction == context:faction() then
                cm:trigger_dilemma(
                    faction:name(),
                    afterUnlockDilemmas[culture]
                );
            end;
        end;
    end;
end;

core:add_listener(
    "idrinth_unlocks_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "unlocks");
        unlockLevelAdjustment = levelAdjustment[context:mct():get_mod_by_key("idrinth"):get_option_by_key("level_adjustment"):get_finalized_setting()];
    end,
    true
);
core:add_listener(
    "idrinth_unlocks_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        Idrinth.log("MctFinalized", "unlocks");
        unlockLevelAdjustment = levelAdjustment[context:mct():get_mod_by_key("idrinth"):get_option_by_key("level_adjustment"):get_finalized_setting()];
    end,
    true
);
core:add_listener(
    "idrinth_unlocks_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == "idrinth_levelMinimum_choice";
    end,
    function(context)
        Idrinth.log("DilemmaChoiceMadeEvent", "unlocks");
        if context:choice() == 1 then
            settings.unlockLevelAdjustment = 0;
            return;
        end;
        if context:choice() == 2 then
            settings.unlockLevelAdjustment = 1;
            return;
        end;
        if context:choice() == 3 then
            settings.unlockLevelAdjustment = 3;
            return;
        end;
        if context:choice() == 4 then
            settings.unlockLevelAdjustment = 6;
            return;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_unlocks_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        return Idrinth.mayConfigure() and context:faction():is_human() and unlockLevelAdjustment == nil;
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "unlocks");
        cm:trigger_dilemma(context:faction():name(), "idrinth_levelMinimum_choice");
    end,
    false
);
core:add_listener(
    "idrinth_unlocks_FactionTurnStart_2",
    "FactionTurnStart",
    function(context)
        if not context:faction():is_human() then
            return false;
        end;
        if Idrinth.Access.spawned() then
            return false;
        end;
        local rankShift = unlockLevelAdjustment;
        if rankShift == nil then
            rankShift = 0;
        end;
        for _, culture in pairs(Idrinth.Cultures.get()) do
            for _, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction == context:faction() then
                    local general = cm:get_highest_ranked_general_for_faction(context:faction());
                    if not general then
                        return false;
                    end;
                    local maxRank = general:rank();
                    if maxRank < 5 + rankShift then
                        return false;
                    end;
                    return true;
                end;
            end;
        end;
        return false;
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "unlocks");
        if unlockMissionStarted[context:faction():name()] then
            return;
        end;
        if cm:mission_is_active_for_faction(context:faction(), unlockMissions[context:faction():culture()]) then
            unlockMissionStarted[context:faction():name()] = true;
            return;
        end;
        unlockMissionStarted[context:faction():name()] = true;
        cm:trigger_mission(
            context:faction():name(),
            unlockMissions[context:faction():culture()],
            true
        );
    end,
    true
);
core:add_listener(
    "idrinth_unlocks_FactionTurnStart_3",
    "FactionTurnStart",
    function(context)
        if context:faction():is_human() then
            return;
        end;
        if Idrinth.Access.spawned() then
            return false;
        end;
        local rankShift = unlockLevelAdjustment;
        if rankShift == nil then
            rankShift = 0;
        end;
        for _, culture in pairs(Idrinth.Cultures.get()) do
            for _, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction == context:faction() then
                    local general = cm:get_highest_ranked_general_for_faction(context:faction());
                    if not general then
                        return false;
                    end;
                    local maxRank = general:rank();
                    if maxRank < unlockForAIRank[culture] + rankShift then
                        return false;
                    end;
                    return cm:random_number(100) > 95;
                end;
            end;
        end;
        return false;
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "unlocks");
        agentType = Idrinth.Constants.HeroType;
        if cm:random_number(100) > 50 then
            agentType = Idrinth.Constants.LordType;
        end;
        spawnIdrinth(agentType, context:faction());
    end,
    true
);
core:add_listener(
    "idrinth_unlocks_MissionSucceeded",
    "MissionSucceeded",
    function(context)
        if Idrinth.Access.spawned() then
            return false;
        end;
        for _, mission in pairs(unlockMissions) do
            if context:mission():mission_record_key() == mission then
                return true;
            end;
        end;
        return false;
    end,
    function(context)
        Idrinth.log("MissionSucceeded", "unlocks");
        cm:trigger_dilemma(context:faction():name(), "idrinth_unlock_choice");
    end,
    true
);
core:add_listener(
    "idrinth_unlocks_DilemmaChoiceMadeEvent_3",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == "idrinth_unlock_choice" and not Idrinth.Access.spawned();
    end,
    function(context)
        Idrinth.log("DilemmaChoiceMadeEvent", "unlocks");
        if context:choice() == 1 then
            return;
        end;
        agentType = Idrinth.Constants.HeroType;
        if context:choice() == 2 then
            agentType = Idrinth.Constants.LordType;
        end;
        spawnIdrinth(agentType, context:faction());
    end,
    true
);
cm:add_saving_game_callback(
    function(context)
        for _, faction in pairs(Idrinth.factions) do
            if unlockMissionStarted[faction] then
                cm:save_named_value("idrinth.unlocks."..faction, 1, context);
            end;
        end;
    end
);
cm:add_loading_game_callback(
    function(context)
        if cm:is_new_game() == false then
            for _, faction in pairs(Idrinth.factions) do
                unlockMissionStarted[faction] = (cm:load_named_value("idrinth.unlocks."..faction, 0, context) == 1);
            end;
        end;
    end
);