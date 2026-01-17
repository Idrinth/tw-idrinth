local addListener = function(event, conditionFunction, functionToRun, skipLogging)
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
            if not skipLogging then
                Idrinth.log("source: " .. sourceFile .. ":" .. line .. " event: " .. event, "events");
            end;
            functionToRun(context);
        end,
        true
    );
end;

-- Helper to register both MctInitialized and MctFinalized listeners with the same callback
local onMctChange = function(callback)
    addListener("MctInitialized", true, callback);
    addListener("MctFinalized", true, callback);
end;

-- Common condition functions that can be reused across listeners
local Conditions = {};

-- Condition for BattleCompleted: checks if battle was fought and Idrinth is spawned
Conditions.battleFoughtAndSpawned = function()
    if not cm:model():pending_battle():has_been_fought() then
        return false;
    end;
    return Idrinth.Access.spawned();
end;

-- Returns a condition function that checks if a specific panel is open
Conditions.panelOpened = function(panelName)
    return function(context)
        return context.string == panelName;
    end;
end;

-- Returns a condition function that checks if a specific panel is currently open
Conditions.isPanelOpen = function(panelName)
    return function()
        return cm:get_campaign_ui_manager():is_panel_open(panelName);
    end;
end;

-- Condition that checks if a specific dilemma was chosen
Conditions.dilemmaIs = function(dilemmaKey)
    return function(context)
        return context:dilemma() == dilemmaKey;
    end;
end;

return {
    addListener = addListener,
    onMctChange = onMctChange,
    Conditions = Conditions,
};
