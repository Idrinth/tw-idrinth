local cooldown = 0;
local cooldownMode = "medium";
local chanceMode = "normal";
local chanceFactors = {
    low = 0.5,
    normal = 1,
    high = 1.5,
};
local dilemmas = {
    high_elves = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_high_elves",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.5,
            wh_dlc05_wef_wood_elves = 0.3,
            wh_main_emp_empire = 0.15,
            wh3_main_ksl_kislev = 0.1,
            wh_main_vmp_vampire_counts = 0.05,
        }
    },
    wood_elves = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_wood_elves",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.3,
            wh_dlc05_wef_wood_elves = 0.5,
            wh_main_emp_empire = 0.15,
            wh3_main_ksl_kislev = 0.1,
            wh_main_vmp_vampire_counts = 0.05,
        };
    },
    kislev = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_kislev",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.1,
            wh_dlc05_wef_wood_elves = 0.05,
            wh_main_emp_empire = 0.3,
            wh3_main_ksl_kislev = 0.5,
            wh_main_vmp_vampire_counts = 0.15,
        };
    },
    empire = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_empire",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.1,
            wh_dlc05_wef_wood_elves = 0.05,
            wh_main_emp_empire = 0.5,
            wh3_main_ksl_kislev = 0.3,
            wh_main_vmp_vampire_counts = 0.15,
        };
    },
    vampire_counts = {
        min_rounds = 15,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_vampire_counts",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.1,
            wh_dlc05_wef_wood_elves = 0.05,
            wh_main_emp_empire = 0.3,
            wh3_main_ksl_kislev = 0.15,
            wh_main_vmp_vampire_counts = 0.5,
        };
    },
    dwarves = {
        min_rounds = 20,
        min_battles_fought = 10,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_dwarves",
        triggered = false,
        chance = 0.01,
        chances = {
            wh2_main_hef_high_elves = 0.15,
            wh_dlc05_wef_wood_elves = 0.15,
            wh_main_emp_empire = 0.25,
            wh3_main_ksl_kislev = 0.2,
            wh_main_vmp_vampire_counts = 0.1,
        };
    };
};
core:add_listener(
    "idrinth_story_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        if not context:faction():is_human() then
            return false;
        end;
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth and not idrinth:is_wounded();
    end,
    function()
        Idrinth.log("FactionTurnStart", "story");
        local idrinth, faction, culture = Idrinth.Access.get();
        local level = idrinth:rank();
        if cooldown > 0 then
            cooldown = cooldown - 1;
            return;
        end;
        local digit_bonus = 0;
        local battlesFought = Idrinth.Statistics.BattlesFought;
        local increment = 1;
        while battlesFought > 0 do
            digit_bonus = digit_bonus + increment;
            battlesFought = math.floor(battlesFought / 10);
            increment = increment + 1;
        end;
        local activeRounds = Idrinth.Statistics.ActiveRounds;
        increment = 1;
        while activeRounds > 0 do
            digit_bonus = digit_bonus + increment;
            activeRounds = math.floor(activeRounds / 10);
            increment = increment + 1;
        end;
        local assassinationsDone = Idrinth.Statistics.CharactersAssassinated;
        increment = 1;
        while assassinationsDone > 0 do
            digit_bonus = digit_bonus + increment;
            assassinationsDone = math.floor(assassinationsDone / 10);
            increment = increment + 1;
        end;
        local dilemmasTriggered = 0;
        for _, data in pairs(dilemmas) do
            if data.triggered then
                dilemmasTriggered = dilemmasTriggered + 1;
            end;
        end;
        for _, data in pairs(dilemmas) do
            local hasRounds = Idrinth.Statistics.ActiveRounds >= data.min_rounds;
            local hasBattles = Idrinth.Statistics.BattlesFought >= data.min_battles_fought;
            local hasAssassinations = Idrinth.Statistics.CharactersAssassinated >= data.min_assassinations;
            local hasLevel = level >= data.min_level;
            local meetsRequirements = not data.triggered and hasRounds and hasBattles and hasAssassinations and hasLevel;
            if meetsRequirements then
                local chance = data.chances[culture];
                if not chance then
                    chance = data.chance;
                end;
                local threshold = chance * chanceFactors[chanceMode] + digit_bonus / 100 - dilemmasTriggered / 100;
                if chance and (cm:random_number(100) / 100 <= threshold) then
                    data.triggered = true;
                    cm:trigger_dilemma(faction:name(), data.key);
                    if cooldownMode == "low" then
                        cooldown = cm:random_number(2) + 1;
                    elseif cooldownMode == "medium" then
                        cooldown = cm:random_number(3) + 2;
                    else
                        cooldown = cm:random_number(4) + 3;
                    end;
                    return;
                end;
            end;
        end;
    end,
    true
);
cm:add_saving_game_callback(
    function(context)
        for name, element in pairs(dilemmas) do
            if element.triggered then
                cm:save_named_value("idrinth.dilemmas." .. name, 1, context);
            end;
        end;
        cm:save_named_value("idrinth.dilemmaCooldown", cooldown, context);
    end
);
cm:add_loading_game_callback(
    function(context)
        if cm:is_new_game() == false then
            cooldown = cm:load_named_value("idrinth.dilemmaCooldown", cooldown, context);
            for name, element in pairs(dilemmas) do
                element.triggered = (cm:load_named_value("idrinth.dilemmas." .. name, 0, context) == 1);
            end;
        end;
    end
);
core:add_listener(
    "idrinth_story_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "story");
        cooldownMode = context:mct():get_mod_by_key("idrinth"):get_option_by_key("dilemma_cooldown"):get_finalized_setting();
        chanceMode = context:mct():get_mod_by_key("idrinth"):get_option_by_key("story_dilemma_base_chance"):get_finalized_setting();
    end,
    true
);
core:add_listener(
    "idrinth_story_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        Idrinth.log("MctFinalized", "story");
        cooldownMode = context:mct():get_mod_by_key("idrinth"):get_option_by_key("dilemma_cooldown"):get_finalized_setting();
        chanceMode = context:mct():get_mod_by_key("idrinth"):get_option_by_key("story_dilemma_base_chance"):get_finalized_setting();
    end,
    true
);