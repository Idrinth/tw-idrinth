cm:add_saving_game_callback(
	function(context)
        IdrinthUtility.log("IDRINTH DEBUG FUNCTION: SavingGameCallback");
		cm:save_named_value("idrinth.unlockLevelAdjustment", Idrinth._unlockLevelAdjustment, context);
		for name, element in pairs(Idrinth._unlockMissionStarted) do
            if element then
                cm:save_named_value("idrinth.unlocks." .. name, 1, context);
            end;
		end;
		if Idrinth._expandedCulturesActive then
            cm:save_named_value("idrinth.expandedCultures", 1, context)
        end;
        for name, element in pairs(Idrinth._godFavourDilemmas) do
            cm:save_named_value("idrinth.godFavour." .. name, element.cooldown, context);
        end;
        for name, element in pairs(Idrinth._item_dilemmas) do
            if element.triggered then
                cm:save_named_value("idrinth.item_dilemmas." .. name, 1, context);
            end;
        end;
        cm:save_named_value("idrinth.version.main", Idrinth.Version.main, context);
        cm:save_named_value("idrinth.version.feature", Idrinth.Version.feature, context);
        cm:save_named_value("idrinth.version.bug", Idrinth.Version.bug, context);
        for region, data in pairs(Idrinth.place_of_interest) do
            if data.triggered then
                cm:save_named_value("idrinth.poi."..region, 1, context)
            end;            
        end;
	end
);
cm:add_loading_game_callback(
	function(context)
        IdrinthUtility.log("IDRINTH DEBUG FUNCTION: LoadingGameCallback");
		if cm:is_new_game() == false then
            Idrinth._expandedCulturesActive = (cm:load_named_value("idrinth.expandedCultures", 0, context) == 1);
            Idrinth._unlockLevelAdjustment = cm:load_named_value("idrinth.unlockLevelAdjustment", 0, context);
            for name, element in pairs(Idrinth._godFavourDilemmas) do
                element.cooldown = cm:load_named_value("idrinth.godFavour." .. name, 0, context);
            end;
            for name, element in pairs(Idrinth._item_dilemmas) do
                element.triggered = (cm:load_named_value("idrinth.item_dilemmas." .. name, 0, context) == 1);
            end;
            for name, element in pairs(Idrinth.place_of_interest) do
                element.triggered = (cm:load_named_value("idrinth.poi." .. name, 0, context) == 1);
            end;
            for name in Idrinth.Factions do
                local stored = cm:load_named_value("idrinth.unlocks." .. name, 0, context);
                if stored == 1 then
                    Idrinth._unlockMissionStarted[name] = true;
                elseif stored == "1" then
                    Idrinth._unlockMissionStarted[name] = true;
                end;
            end;
		end;
	end
);