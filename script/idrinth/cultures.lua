local enableExtendedCultures = false;
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
        enableExtendedCultures = context:mct():get_mod_by_key("idrinth"):get_option_by_key("expanded_spawn"):get_finalized_setting();
    end,
    true
)
core:add_listener(
    "idrinth_cultures_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        enableExtendedCultures = context:mct():get_mod_by_key("idrinth"):get_option_by_key("expanded_spawn"):get_finalized_setting();
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
        enableExtendedCultures = context:choice() == 1;
    end,
    true
);
core:add_listener(
    "idrinth_cultures_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        return mayDisplaySettingsDilemma(context, settings.expandedCulturesActive);
    end,
    function(context)
        cm:trigger_dilemma(context:faction():name(), "idrinth_mode_choice");
    end,
    false
);
local get = function()
    if not enableExtendedCultures then
        return baseCultures;
    end;
    local cultures = {};
    for culture in baseCultures do
        table.insert(cultures, culture);
    end;
    for culture in extendedCultures do
        table.insert(cultures, culture);
    end;
    return cultures;
end;

return get;