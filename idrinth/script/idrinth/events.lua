local internalCounter = 0;

local addListener = function(sourceFile, event, conditionFunction, functionToRun)
    internalCounter = internalCounter + 1;
    local handlerId = internalCounter;
    core:add_listener(
        "idrinth_" .. sourceFile .. "_" .. event .. "_" .. handlerId,
        event,
        conditionFunction,
        function(context)
            Idrinth.log("source: " .. sourceFile .. " event: " .. event .. " handler: " .. handlerId, "events");
            functionToRun(context);
        end,
        true
    );
end;

return {
    addListener = addListener,
};
