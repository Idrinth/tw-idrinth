--- @module Idrinth.log
--- Logging system for the Idrinth mod.
--- Provides timestamped logging to file and optional base game out() logging.
--- Logging can be enabled/disabled via MCT settings.
--- @return function log function for writing log messages.

local enableLogging = false;
local enableBaseGameLogging = false;
local enableGroovyLogging = false;
local lua_start_time = os.clock();
local logfile = "idrinth." .. os.date("%y%m%d%H%M") .. ".log";
local lg = nil;
local log = function(text)
    if lg == nil and get_vlog ~= nil then
        lg = get_vlog("[idrinth]");
    end;
    if lg ~= nil then
        lg(text);
    end;
end;

--- Updates logging settings from MCT configuration.
local updateMctSettings = function()
    enableLogging = Idrinth.Mct.get("logging");
    enableBaseGameLogging = Idrinth.Mct.get("base_logging");
    enableGroovyLogging = Idrinth.Mct.get("groovy_logging");
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
local log_value = function(thing, logtype)
    if not logtype then
        logtype = "unknown";
    end;
    if enableBaseGameLogging then
        out("=== IDRINTH DEBUG ===");
        out(logtype);
        out(thing);
    end;
    if enableGroovyLogging then
        log(logtype .. ": " .. thing);
    end;
    if not enableLogging then
        return;
    end;
    local str_from_script = tostring(thing) or "";
    local timestamp = "<" .. string.format("%.1f", os.clock() - lua_start_time) .. "s>";
    local output_str_table = {timestamp, string.format("%" .. (11 - string.len(timestamp)) .."s", " ")};
    table.insert(output_str_table, str_from_script);
    local output_str = table.concat(output_str_table);
    core:trigger_custom_event(
        "ScriptEventIdrinthLogMessageReady",
        {
            message = "[" .. logtype .. "] " .. output_str .. "\n",
        }
    );
end;

return log_value;
