local enableLogging = false;

core:add_listener(
    "idrinth_logging_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "logging");
        enableLogging = context:mct():get_mod_by_key("idrinth"):get_option_by_key("logging"):get_finalized_setting();
    end,
    true
)
core:add_listener(
    "idrinth_logging_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        Idrinth.log("MctFinalized", "logging");
        enableLogging = context:mct():get_mod_by_key("idrinth"):get_option_by_key("logging"):get_finalized_setting();
    end,
    true
);

local lua_start_time = os.clock();
local file = nil;
local log = function(thing, logtype)
    out(thing);
    if not enableLogging then
        return;
    end;
    if not file then
        file = io.open("idrinth." .. os.date("%y%m%d%H%M") .. ".log", "a");
    end;
    local str_from_script = tostring(thing) or "";
    local timestamp = "<" .. string.format("%.1f", os.clock() - lua_start_time) .. "s>";
    local output_str_table = {timestamp, string.format("%" .. (11 - string.len(timestamp)) .."s", " ")};
    table.insert(output_str_table, str_from_script);
    local output_str = table.concat(output_str_table);
    if not logtype then
        logtype = "base";
    end;
    file:write("[" .. logtype .. "] " .. output_str .. "\n");
end;

return log;