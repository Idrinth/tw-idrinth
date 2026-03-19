--- @module Idrinth.Statistics
--- Combat statistics tracking for the Idrinth mod.
--- Tracks active rounds, battles fought, characters assassinated, and chapels founded.
--- Statistics are persisted across save/load cycles.
--- @return table Statistics table with ActiveRounds, BattlesFought, CharactersAssassinated, ChapelsFounded.

local statistics = {
    ActiveRounds = 0,
    BattlesFought = 0,
    CharactersAssassinated = 0,
    ChapelsFounded = 0,
};
cm:add_saving_game_callback(
    function(context)
        cm:save_named_value("idrinth.activeRounds", statistics.ActiveRounds, context);
        cm:save_named_value("idrinth.battlesFought", statistics.BattlesFought, context);
        cm:save_named_value("idrinth.charactersAssassinated", statistics.CharactersAssassinated, context);
    end
);
cm:add_loading_game_callback(
    function(context)
        if cm:is_new_game() then
            return;
        end;
        statistics.ActiveRounds = cm:load_named_value("idrinth.activeRounds", statistics.ActiveRounds, context);
        statistics.BattlesFought = cm:load_named_value("idrinth.battlesFought", statistics.BattlesFought, context);
        statistics.CharactersAssassinated = cm:load_named_value(
            "idrinth.charactersAssassinated", statistics.CharactersAssassinated, context
        );
    end
);
Idrinth.Events.addListener(
    "CharacterCharacterTargetAction",
    function(context)
        local idrinth = Idrinth.Access.get();
        return idrinth and (context:character() == idrinth);
    end,
    function(context)
        local ability = context:ability();

        if ability == "hinder_character" or ability == "hinder_agent" then
            if context:mission_result_success() or context:mission_result_critial_success() then
                statistics.charactersAssassinated = statistics.charactersAssassinated + 1;
            end;
        end;
    end
);
Idrinth.Events.addListener(
    "FactionTurnStart",
    function(context)
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth and not idrinth:is_wounded();
    end,
    function()
        statistics.ActiveRounds = statistics.ActiveRounds + 1;
    end
);
return statistics;
