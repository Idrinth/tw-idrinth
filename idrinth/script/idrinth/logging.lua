local enableLogging = false;

local enableBaseGameLogging = false;
local lua_start_time = os.clock();
local logfile = "idrinth." .. os.date("%y%m%d%H%M") .. ".log";

core:add_listener(
    "idrinth_logging_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "logging");
        enableLogging = context:mct():get_mod_by_key(Idrinth.Constants.MctModKey):get_option_by_key("logging"):get_finalized_setting();
        enableBaseGameLogging = context:mct():get_mod_by_key(Idrinth.Constants.MctModKey):get_option_by_key("base_logging"):get_finalized_setting();
    end,
    true
);
core:add_listener(
    "idrinth_logging_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        Idrinth.log("MctFinalized", "logging");
        enableLogging = context:mct():get_mod_by_key(Idrinth.Constants.MctModKey):get_option_by_key("logging"):get_finalized_setting();
        enableBaseGameLogging = context:mct():get_mod_by_key(Idrinth.Constants.MctModKey):get_option_by_key("base_logging"):get_finalized_setting();
    end,
    true
);
core:add_listener(
    "idrinth_logging_ScriptEventIdrinthLogMessageReady",
    "ScriptEventIdrinthLogMessageReady",
    true,
    function(context)
        local file = io.open(logfile, "a");
        file:write(tostring(context:message()));
        file:close();
    end,
    true
);

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
