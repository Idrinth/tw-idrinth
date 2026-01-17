--- @module Idrinth.log
--- Logging system for the Idrinth mod.
--- Provides timestamped logging to file and optional base game out() logging.
--- Logging can be enabled/disabled via MCT settings.
--- @return function log function for writing log messages.

local enableLogging = false;

local enableBaseGameLogging = false;
local lua_start_time = os.clock();
local logfile = "idrinth." .. os.date("%y%m%d%H%M") .. ".log";

--- Updates logging settings from MCT configuration.
local updateMctSettings = function()
    enableLogging = Idrinth.Mct.get("logging");
    enableBaseGameLogging = Idrinth.Mct.get("base_logging");
end;
Idrinth.Events.onMctChange(updateMctSettings);
Idrinth.Events.addListener(
    "ScriptEventIdrinthLogMessageReady",
    true,
    function(context)
        local file = io.open(logfile, "a");
        file:write(tostring(context:message()));
        file:close();
    end,
    true
);

--- Logs a message with timestamp and category.
--- @param thing any The value to log (will be converted to string).
--- @param logtype string|nil The category/type of log message (e.g., "army", "ui", "traits").
local log = function(thing, logtype)
    if enableBaseGameLogging then
        out("=== IDRINTH DEBUG ===");
        out(logtype or "unknown");
        out(thing);
    end;
    if not enableLogging then
        return;
    end;
    local str_from_script = tostring(thing) or "";
    local timestamp = "<" .. string.format("%.1f", os.clock() - lua_start_time) .. "s>";
    local output_str_table = {timestamp, string.format("%" .. (11 - string.len(timestamp)) .."s", " ")};
    table.insert(output_str_table, str_from_script);
    local output_str = table.concat(output_str_table);
    if not logtype then
        logtype = "unknown";
    end;
    core:trigger_custom_event(
        "ScriptEventIdrinthLogMessageReady",
        {
            message = "[" .. logtype .. "] " .. output_str .. "\n",
        }
    );
end;

return log;
