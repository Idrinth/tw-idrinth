local statistics = {
    ActiveRounds = 0,
    BattlesFought = 0,
    CharactersAssassinated = 0
}
cm:add_saving_game_callback(
	function(context)
        IdrinthUtility.log("IDRINTH DEBUG FUNCTION: SavingGameCallback");
		cm:save_named_value("idrinth.activeRounds", statistics.ActiveRounds, context);
		cm:save_named_value("idrinth.battlesFought", statistics.BattlesFought, context);
		cm:save_named_value("idrinth.charactersAssassinated", statistics.CharactersAssassinated, context);
	end
);
cm:add_loading_game_callback(
	function(context)
        IdrinthUtility.log("IDRINTH DEBUG FUNCTION: LoadingGameCallback");
		if cm:is_new_game() == false then
            statistics.ActiveRounds = cm:load_named_value("idrinth.activeRounds", statistics.ActiveRounds, context);
            statistics.BattlesFought = cm:load_named_value("idrinth.battlesFought", statistics.BattlesFought, context);
            statistics.CharactersAssassinated = cm:load_named_value("idrinth.charactersAssassinated", statistics.CharactersAssassinated, context);
		end;
	end
);

core:add_listener(
    "idrinth_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        return idrinth and context:faction() == faction;
    end,
    function(context)    
        IdrinthUtility.log("IDRINTH DEBUG FUNCTION: FactionTurnStart");
        local idrinth = Idrinth.Access.get();
        if idrinth:is_wounded() then
            IdrinthUtility.log("IDRINTH DEBUG: ===== IDRINTH WOUNDED =====");
            return;
        end;
        statistics.ActiveRounds = Idrinth.Statistics.ActiveRounds + 1;
    end,
    true
);
return statistics;