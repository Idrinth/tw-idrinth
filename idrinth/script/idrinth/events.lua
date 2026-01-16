local addListener = function(event, conditionFunction, functionToRun)
    local info = debug.getinfo(2, "Sl");
    local source = info.source;
    local line = info.currentline;
    -- Extract just the filename from the path (e.g., "@script/idrinth/army.lua" -> "army")
    local sourceFile = source:match("([^/]+)%.lua$") or source;

    core:add_listener(
        "idrinth_" .. sourceFile .. "_" .. event .. "_" .. line,
        event,
        conditionFunction,
        function(context)
            Idrinth.log("source: " .. sourceFile .. ":" .. line .. " event: " .. event, "events");
            functionToRun(context);
        end,
        true
    );
end;

return {
    addListener = addListener,
};
