--- @module Idrinth.Mct
--- Mod Configuration Tool (MCT) integration module.
--- Provides access to MCT settings for the Idrinth mod.
--- @return table Module with get function to retrieve MCT option values.

local mod = nil;

--- Initializes the MCT mod reference when MCT is ready.
--- @param context table The MCT event context containing mct() accessor.
local function init(context)
    mod = context:mct():get_mod_by_key(Idrinth.Constants.MctModKey);
end

--- Gets the finalized value of an MCT option.
--- @param key string The option key to retrieve.
--- @return any|nil The option value, or nil if MCT not initialized.
local function get(key)
    if mod == nil then
        return nil;
    end
    if not key or key == "" then
        return nil;
    end;
    local option = mod:get_option_by_key(key);
    if not option then
        Idrinth.log("Undefined key "..tostring(key), "mct")
        return nil;
    end;
    return option:get_finalized_setting();
end

Idrinth.Events.onMctChange(init);

return {
    get = get,
};
