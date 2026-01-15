local statistics = {
    ActiveRounds = 0,
    BattlesFought = 0,
    CharactersAssassinated = 0,
    ChapelsFounded = 0,
};
cm:add_saving_game_callback(
    function(context)
        cm:save_named_value("idrinth.activeRounds", statistics.ActiveRounds, context);
        cm:save_named_value("idrinth.battlesFought", statistics.BattlesFought, context);
        cm:save_named_value("idrinth.charactersAssassinated", statistics.CharactersAssassinated, context);
    end;
);
cm:add_loading_game_callback(
    function(context)
        if cm:is_new_game() then
            return;
        end;
        statistics.ActiveRounds = cm:load_named_value("idrinth.activeRounds", statistics.ActiveRounds, context);
        statistics.BattlesFought = cm:load_named_value("idrinth.battlesFought", statistics.BattlesFought, context);
        statistics.CharactersAssassinated = cm:load_named_value("idrinth.charactersAssassinated", statistics.CharactersAssassinated, context);
    end;
);
core:add_listener(
    "idrinth_statistics_CharacterCharacterTargetAction",
    "CharacterCharacterTargetAction",
    function(context)
        local idrinth = Idrinth.Access.get();
        return idrinth and (context:character() == idrinth);
    end,
    function(context)
        Idrinth.log("CharacterCharacterTargetAction", "statistics");
        local ability = context:ability();

        if ability == "hinder_character" or ability == "hinder_agent" then
            if context:mission_result_critial_failure() then
                -- nothing
            elseif context:mission_result_success() then
                statistics.charactersAssassinated = statistics.charactersAssassinated + 1;
            elseif context:mission_result_critial_success() then
                statistics.charactersAssassinated = statistics.charactersAssassinated + 1;
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_statistics_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth;
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "statistics");
        local idrinth = Idrinth.Access.get();
        if idrinth:is_wounded() then
            return;
        end;
        statistics.ActiveRounds = statistics.ActiveRounds + 1;
    end,
    true
);
return statistics;