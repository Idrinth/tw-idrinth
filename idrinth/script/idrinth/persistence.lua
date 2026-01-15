cm:add_saving_game_callback(
    function(context)
        cm:save_named_value("idrinth.version.main", Idrinth.Version.main, context);
        cm:save_named_value("idrinth.version.feature", Idrinth.Version.feature, context);
        cm:save_named_value("idrinth.version.bug", Idrinth.Version.bug, context);
    end;
);
