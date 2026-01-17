--- @module Idrinth.Cultures
--- Culture management module for the Idrinth mod.
--- Determines which cultures can spawn Idrinth (base vs extended mode).
--- Extended mode adds additional cultures like Dark Elves, Vampire Coast, etc.
--- @return table Module with get and isAllowed functions.

local enableExtendedCultures = false;
local cachedCultures = nil;
local cachedCultureMap = nil;
local baseCultures = {
    "wh2_main_hef_high_elves",
    "wh3_main_ksl_kislev",
    "wh_main_emp_empire",
    "wh_main_vmp_vampire_counts",
    "wh_dlc05_wef_wood_elves",
};
local extendedCultures = {
    "mixer_nag_nagash",
    "wh2_main_def_dark_elves",
    "wh2_dlc11_cst_vampire_coast",
    "wh_main_brt_bretonnia",
    "wh3_main_cth_cathay"
};

Idrinth.Events.onMctChange(function()
    enableExtendedCultures = Idrinth.Mct.get("expanded_spawn");
    cachedCultures = nil;
    cachedCultureMap = nil;
end);
Idrinth.Events.addListener(
    "DilemmaChoiceMadeEvent",
    Idrinth.Events.Conditions.dilemmaIs("idrinth_mode_choice"),
    function(context)
        enableExtendedCultures = context:choice() == 1;
        cachedCultures = nil;
        cachedCultureMap = nil;
    end
);
Idrinth.Events.addListener(
    "FactionTurnStart",
    function(context)
        return context:faction():is_human() and enableExtendedCultures == nil;
    end,
    function(context)
        cm:trigger_dilemma(context:faction():name(), "idrinth_mode_choice");
    end
);
--- Gets the list of cultures that can spawn Idrinth.
--- @return table Array of culture key strings.
local get = function()
    if cachedCultures then
        return cachedCultures;
    end;
    if not enableExtendedCultures then
        cachedCultures = baseCultures;
        return cachedCultures;
    end;
    cachedCultures = {};
    for _, culture in pairs(baseCultures) do
        table.insert(cachedCultures, culture);
    end;
    for _, culture in pairs(extendedCultures) do
        table.insert(cachedCultures, culture);
    end;
    return cachedCultures;
end;

--- Checks if a culture is allowed to spawn Idrinth.
--- @param culture string The culture key to check.
--- @return boolean True if the culture can spawn Idrinth.
local isAllowed = function(culture)
    if not cachedCultureMap then
        cachedCultureMap = {};
        for _, c in pairs(get()) do
            cachedCultureMap[c] = true;
        end;
    end;
    return cachedCultureMap[culture] == true;
end;

return {
    get = get,
    isAllowed = isAllowed,
};
