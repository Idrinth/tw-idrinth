local enableExtendedCultures = false;
local cachedCultures = nil;
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

core:add_listener(
    "idrinth_cultures_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "cultures");
        enableExtendedCultures = context:mct():get_mod_by_key("idrinth"):get_option_by_key("expanded_spawn"):get_finalized_setting();
        cachedCultures = nil;
    end,
    true
)
core:add_listener(
    "idrinth_cultures_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        Idrinth.log("MctFinalized", "cultures");
        enableExtendedCultures = context:mct():get_mod_by_key("idrinth"):get_option_by_key("expanded_spawn"):get_finalized_setting();
        cachedCultures = nil;
    end,
    true
);
core:add_listener(
    "idrinth_cultures_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == "idrinth_mode_choice";
    end,
    function(context)
        Idrinth.log("DilemmaChoiceMadeEvent", "cultures");
        enableExtendedCultures = context:choice() == 1;
        cachedCultures = nil;
    end,
    true
);
core:add_listener(
    "idrinth_cultures_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        return context:faction():is_human() and enableExtendedCultures == nil;
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "cultures");
        cm:trigger_dilemma(context:faction():name(), "idrinth_mode_choice");
    end,
    false
);
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

return get;