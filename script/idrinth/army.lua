local enableWAAAGHUpgrades = function()
    if not cm:get_campaign_ui_manager():is_panel_open("units_panel") then
        return;
    end;
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local idrinth = Idrinth.Access.get();
    if character == idrinth then
        local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        if not parent then
            return;
        end;
        core:get_or_create_component(
            "idrinth_units_panel_blessings_button",
            "ui/idrinth/idrinth_units_panel_blessings_button.twui.xml",
            parent
        );
        for i = 1, parent:ChildCount() - 1 do
            local child = parent:Find(i);
            if child then
                UIComponent(child):SetVisible(false);
            end;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button");
        set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "tabgroup", "tab_horde_buildings");
        set_component_visible_with_parent(false, core:get_ui_root(), "units_panel", "main_units_panel", "unit_count_frame_holder", "frame");
        set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "icon_list", "dy_upkeep");
        find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt"):SetText("Knight-Scholar Idrinth Thalui");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "horde_growth");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "equipment");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "subpanel_effect_bundles");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "rank");
    end;
end;
local enableArmyUpgrades = function()
    if not cm:get_campaign_ui_manager():is_panel_open("units_panel") then
        return;
    end;
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local idrinth = Idrinth.Access.get();
    if character == idrinth then
        local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        if not parent then
            return;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        core:get_or_create_component(
            "idrinth_units_panel_warband_button",
            "ui/idrinth/idrinth_units_panel_warband_button.twui.xml",
            parent
        );
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "button_warbands_upgrade");
    end;
end;
core:add_listener(
    "idrinth_army_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        return idrinth and not idrinth:is_wounded() and idrinth:has_military_force() and not idrinth:is_carrying_troops() and context:faction() == faction;
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "army");
        local idrinth = Idrinth.Access.get();
        cm:spawn_transported_force_at_military_force(idrinth:military_force():command_queue_index(), "idrinth_hev_high_elf_vampires_idrinth_support", 1);
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp",
    "ComponentLClickUp",
    function(context)
        return context.string == "tab_transported_army";
    end,
    function(context)
        Idrinth.log("ComponentLClickUp", "army");
        Idrinth.Ui.nowAndThen(enableWAAAGHUpgrades);
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_2",
    "ComponentLClickUp",
    function(context)
        return context.string == "tab_army";
    end,
    function(context)
        Idrinth.log("ComponentLClickUp", "army");
        Idrinth.Ui.nowAndThen(enableArmyUpgrades)
    end,
    true
);
core:add_listener(
    "idrinth_army_PanelOpenedCampaign",
    "PanelOpenedCampaign",
    function(context)
        return context.string == "units_panel";
    end,
    function(context)
        Idrinth.log("PanelOpenedCampaign", "army");
        set_component_visible_with_parent(false, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "button_warbands_upgrade");
        set_component_visible_with_parent(false, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button");
    end,
    true
);