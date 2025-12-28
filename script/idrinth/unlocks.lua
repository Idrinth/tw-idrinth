local unlockLevelAdjustment = nil;
local levelAdjustment = {
    null = 0,
    one = 1,
    three = 3,
    six = 6
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
local unlockDilemma = "idrinth_unlock_choice";
local unlockMissionStarted = {};

core:add_listener(
    "idrinth_unlocks_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "unlocks");
        unlockLevelAdjustment = levelAdjustment[context:mct():get_mod_by_key("idrinth"):get_option_by_key("level_adjustment"):get_finalized_setting()];
    end,
    true
)
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
        end
        if context:choice() == 2 then
            settings.unlockLevelAdjustment = 1;
            return;
        end
        if context:choice() == 3 then
            settings.unlockLevelAdjustment = 3;
            return;
        end
        if context:choice() == 4 then
            settings.unlockLevelAdjustment = 6;
            return;
        end
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
        if Idrinth.Access.spawned() then
            return false;
        end;
        local rankShift = unlockLevelAdjustment;
        if rankShift == nil then
            rankShift = 0;
        end;
        for _, culture in pairs(Idrinth.cultures()) do
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
                    return context:faction():is_human();
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
        if Idrinth.Access.spawned() then
            return false;
        end;
        local rankShift = unlockLevelAdjustment;
        if rankShift == nil then
            rankShift = 0;
        end;
        for _, culture in pairs(Idrinth.cultures()) do
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
                    return cm:random_number(100) > 95 and not faction:is_human();
                end;
            end;
        end;
        return false;
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "unlocks");
        cm:spawn_unique_agent_at_character(
            context:faction():command_queue_index(),
            Idrinth.Constants.BaseType..Idrinth.Constants.HeroType,
            context:faction():faction_leader():command_queue_index(),
            true
        );
        idrinth = Idrinth.Access.get();
        cm:replenish_action_points(cm:char_lookup_str(idrinth));
        for _, culture in pairs(Idrinth.cultures()) do
            for _, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction:is_human() and unlockMissionStarted[faction:name()] then
                    cm:cancel_custom_mission(faction, unlockMissions[culture]);
                    unlockMissionStarted[faction:name()] = false;
                end;
            end;
        end;
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
        end
        if context:choice() == 2 then
            if context:faction():faction_leader():has_region() then
                local x, y = cm:find_valid_spawn_location_for_character_from_position(
                    context:faction():name(),
                    context:faction():faction_leader():logical_position_x(),
                    context:faction():faction_leader():logical_position_y(),
                    true
                );
                cm:create_force_with_general(
                    context:faction():name(),
                    "idrinth_hev_high_elf_vampires_chapel_mixed",
                    context:faction():faction_leader():region():name(),
                    x,
                    y,
                    Idrinth.Constants.LordType,
                    Idrinth.Constants.BaseType .. Idrinth.Constants.LordType,
                    "names_name_99990999999990",
                    "names_name_99990999999992",
                    "names_name_99990999999991",
                    "",
                    false,
                    function(cqi)
                        local character = cm:get_character_by_cqi(cqi);
                        cm:change_character_custom_name(
                            character,
                            "Idrinth",
                            "Thalui",
                            "Knight-Scholar",
                            ""
                        );
                        cm:set_character_unique(cm:char_lookup_str(character), true);
                        cm:set_character_immortality(cm:char_lookup_str(character), true);
                    end
                );
            elseif context:faction():has_home_region() then
                local x, y = cm:find_valid_spawn_location_for_character_from_position(
                    context:faction():name(),
                    context:faction():home_region():settlement():logical_position_x(),
                    context:faction():home_region():settlement():logical_position_y(),
                    true
                );
                cm:create_force_with_general(
                    context:faction():name(),
                    "idrinth_hev_high_elf_vampires_chapel_mixed",
                    context:faction():home_region():name(),
                    x,
                    y,
                    Idrinth.Constants.LordType,
                    Idrinth.Constants.BaseType .. Idrinth.Constants.LordType,
                    "names_name_99990999999990",
                    "names_name_99990999999992",
                    "names_name_99990999999991",
                    "",
                    false,
                    function(cqi)
                        local character = cm:get_character_by_cqi(cqi);
                        cm:change_character_custom_name(
                            character,
                            "Idrinth",
                            "Thalui",
                            "Knight-Scholar",
                            ""
                        );
                        cm:set_character_unique(cm:char_lookup_str(character), true);
                        cm:set_character_immortality(cm:char_lookup_str(character), true);
                    end
                );
            end;
        elseif context:choice() == 0 then         
            if context:faction():faction_leader():has_region() then
                cm:spawn_unique_agent_at_character(
                    context:faction():command_queue_index(),
                    Idrinth.Constants.BaseType .. Idrinth.Constants.HeroType,
                    context:faction():faction_leader():command_queue_index(),
                    true
                );
            elseif context:faction():has_home_region() then
                cm:spawn_unique_agent_at_region(
                    context:faction():cqi(),
                    Idrinth.Constants.BaseType .. Idrinth.Constants.HeroType,
                    context:faction():home_region():cqi(),
                    true
                );
            end;
        end;
        idrinth = Idrinth.Access.get();
        if not idrinth then
            return;
        end;
        cm:replenish_action_points(cm:char_lookup_str(idrinth));
        for _, culture in pairs(Idrinth.cultures()) do
            for _, faction in pairs(cm:get_factions_by_culture(culture)) do
                if faction:is_human() and unlockMissionStarted[faction:name()] and not faction == context:faction() then
                    cm:cancel_custom_mission(faction, unlockMissions[culture]);
                    unlockMissionStarted[faction:name()] = false;
                elseif faction:is_human() and faction == context:faction() then
                    cm:trigger_dilemma(
                        faction:name(),
                        afterUnlockDilemmas[culture]
                    );
                end;
            end;
        end;
    end,
    true
);