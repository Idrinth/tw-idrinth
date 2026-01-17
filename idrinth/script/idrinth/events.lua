--- @module Idrinth.Events
--- Event listener management system for the Idrinth mod.
--- Provides wrapper functions for adding game event listeners with automatic logging and naming.
--- Also includes common condition functions for use across listeners.
--- @return table Module with addListener, onMctChange, and Conditions.

--- Adds an event listener with automatic unique naming and optional logging.
--- @param event string The game event name to listen for.
--- @param conditionFunction function|boolean Condition that must be true for callback to fire.
--- @param functionToRun function The callback function to execute when event fires.
--- @param skipLogging boolean|nil If true, skips logging this event trigger.
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

--- Registers a callback for both MctInitialized and MctFinalized events.
--- @param callback function The function to call when MCT settings change.
local onMctChange = function(callback)
    addListener("MctInitialized", true, callback);
    addListener("MctFinalized", true, callback);
end;

--- Common condition functions that can be reused across listeners.
--- @class Conditions
local Conditions = {};

--- Condition for BattleCompleted: checks if battle was fought and Idrinth is spawned.
--- @return boolean True if battle was fought and Idrinth exists.
Conditions.battleFoughtAndSpawned = function()
    if not cm:model():pending_battle():has_been_fought() then
        return false;
    end;
    return Idrinth.Access.spawned();
end;

--- Returns a condition function that checks if a specific panel was opened.
--- @param panelName string The name of the panel to check for.
--- @return function Condition function for PanelOpenedCampaign events.
Conditions.panelOpened = function(panelName)
    return function(context)
        return context.string == panelName;
    end;
end;

--- Returns a condition function that checks if a specific panel is currently open.
--- @param panelName string The name of the panel to check.
--- @return function Condition function that returns true if panel is open.
Conditions.isPanelOpen = function(panelName)
    return function()
        return cm:get_campaign_ui_manager():is_panel_open(panelName);
    end;
end;

--- Returns a condition function that checks if a specific dilemma was triggered.
--- @param dilemmaKey string The dilemma key to check for.
--- @return function Condition function for DilemmaChoiceMadeEvent.
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
