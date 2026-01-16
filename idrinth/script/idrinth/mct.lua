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

Idrinth.Events.addListener("MctInitialized", true, init);
Idrinth.Events.addListener("MctFinalized", true, init);

return {
    get = get,
};
