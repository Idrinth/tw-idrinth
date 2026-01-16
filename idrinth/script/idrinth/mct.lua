local mod = nil;

local function init(context)
    mod = context:mct():get_mod_by_key(Idrinth.Constants.MctModKey);
end

local function get(key)
    if mod == nil then
        return nil;
    end
    return mod:get_option_by_key(key):get_finalized_setting();
end

core:add_listener(
    "idrinth_mct_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        init(context);
    end,
    true
);
core:add_listener(
    "idrinth_mct_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        init(context);
    end,
    true
);

return {
    get = get,
};
