require("script/idrinth/init")

Idrinth = {};
Idrinth._self = nil;
Idrinth._lastSelectionAgent = nil;
core:add_listener(
    "idrinth_enableTypeDisplayInRecruitingPanel_action",
    "ComponentLClickUp",
    function(context)
        return Idrinth.Access.spawned() and context.string == "legendary_lords" and Idrinth._characterPanelOpen;
    end,
    function(context)
        local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
        if not parent then
            IdrinthUtility.log("Couldn't find character recruitment panel.")
            return;
        end;
        if parent:ChildCount() == 0 then
            return;
        end;
        for i = 1, parent:ChildCount() - 1 do
            local child = parent:Find(i);
            if child then
                if UIComponent(child):Visible() then
                    local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                    if subtype and not subtype:Visible() then
                        set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                        subtype:SetText("High Elf Vampire");
                    end;
                    return;
                end;
            end;
        end;
        cm:callback(
            function()
                local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
                if not parent then
                    IdrinthUtility.log("Couldn't find character recruitment panel.")
                    return;
                end;
                if parent:ChildCount() == 0 then
                    return;
                end;
                for i = 1, parent:ChildCount() - 1 do
                    local child = parent:Find(i);
                    if child then
                        if UIComponent(child):Visible() then
                            local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                            if subtype and not subtype:Visible() then
                                set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                                subtype:SetText("High Elf Vampire");
                            end;
                            return;
                        end;
                    end;
                end;
            end,
            1
        )
    end,
    true
);
core:add_listener(
    "idrinth_enableTypeDisplayInRecruitingPanel_stop",
    "PanelClosedCampaign",
    function(context)
        return Idrinth.Access.spawned() and context.string == "character_panel";
    end,
    function(context)
        IdrinthUtility.log("LEFT CHARACTER PANEL")
        Idrinth._characterPanelOpen = false;
    end,
    true
);
core:add_listener(
    "idrinth_enableTypeDisplayInRecruitingPanel_start",
    "PanelOpenedCampaign",
    function(context)
        return Idrinth.Access.spawned() and context.string == "character_panel";
    end,
    function(context)
        IdrinthUtility.log("ENTERED CHARACTER PANEL")
        Idrinth._characterPanelOpen = true;
        local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
        if not parent then
            IdrinthUtility.log("Couldn't find character recruitment panel.")
            return;
        end;
        if parent:ChildCount() == 0 then
            return;
        end;
        for i = 1, parent:ChildCount() - 1 do
            local child = parent:Find(i);
            if child then
                if UIComponent(child):Visible() then
                    local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                    if subtype and not subtype:Visible() then
                        set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                        subtype:SetText("High Elf Vampire");
                    end;
                    return;
                end;
            end;
        end;
        cm:callback(
            function()
                local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
                if not parent then
                    IdrinthUtility.log("Couldn't find character recruitment panel.")
                    return;
                end;
                if parent:ChildCount() == 0 then
                    return;
                end;
                for i = 1, parent:ChildCount() - 1 do
                    local child = parent:Find(i);
                    if child then
                        if UIComponent(child):Visible() then
                            local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                            if subtype and not subtype:Visible() then
                                set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                                subtype:SetText("High Elf Vampire");
                            end;
                            return;
                        end;
                    end;
                end;
            end,
            1
        )
    end,
    true
);
Idrinth._selectedUnits = nil;

core:add_listener(
    "idrinth_enableWAAAGHUpgradesPanel_unitHandling",
    "RefreshUnitSelection",
    function(context)
        return Idrinth.Access.spawned();
    end,
    function(context)
        -- test
        IdrinthUtility.log("context:RefreshUnitSelection")
    end,
    true
);
core:add_listener(
    "idrinth_enableWAAAGHUpgrades",
    "ComponentLClickUp",
    function(context)
        return Idrinth.Access.spawned() and context.string == "tab_transported_army";
    end,
    function(context)
        if not Idrinth._self then
            IdrinthUtility.log("IDRINTH DEBUG: opening waaagh view for someone else than Idrinth")
            return;
        end;
        IdrinthUtility.log("IDRINTH DEBUG: opening waaagh view")
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
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button")
        set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "tabgroup", "tab_horde_buildings")
        set_component_visible_with_parent(false, core:get_ui_root(), "units_panel", "main_units_panel", "unit_count_frame_holder", "frame")
        set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "icon_list", "dy_upkeep")
        find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt"):SetText("Knight-Scholar Idrinth Thalui")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "horde_growth")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "equipment")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "subpanel_effect_bundles")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "rank")
        cm:callback(
            function()
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button")
                set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "tabgroup", "tab_horde_buildings")
                set_component_visible_with_parent(false, core:get_ui_root(), "units_panel", "main_units_panel", "unit_count_frame_holder", "frame")
                set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "icon_list", "dy_upkeep")
                find_uicomponent(core:get_ui_root(), "units_panel", "main_units_panel", "header", "button_focus", "dy_txt"):SetText("Knight-Scholar Idrinth Thalui")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "horde_growth")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "equipment")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "subpanel_effect_bundles")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "rank")
            end,
            1
        );
    end,
    true
);
core:add_listener(
    "idrinth_enableArmyUpgrades",
    "ComponentLClickUp",
    function(context)
        return Idrinth.Access.spawned() and context.string == "tab_army";
    end,
    function(context)
        if not Idrinth._self then
            IdrinthUtility.log("IDRINTH DEBUG: opening army view for someone else than Idrinth")
            return;
        end;
        IdrinthUtility.log("IDRINTH DEBUG: opening army view")
        local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        if not parent then
            return;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel")
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army")
        core:get_or_create_component(
            "idrinth_units_panel_warband_button",
            "ui/idrinth/idrinth_units_panel_warband_button.twui.xml",
            parent
        );
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "button_warbands_upgrade")
        cm:callback(
            function()
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel")
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army")
                core:get_or_create_component(
                    "idrinth_units_panel_warband_button",
                    "ui/idrinth/idrinth_units_panel_warband_button.twui.xml",
                    parent
                );
                set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "button_warbands_upgrade")
            end,
            1
        );
    end,
    true
);
core:add_listener(
    "idrinth_checkIfIdrinthIsSelected",
    "CharacterSelected",
    true,
    function(context) 
        IdrinthUtility.log("IDRINTH DEBUG: is idrinth?")
        local isIdrinth = context:character():character_subtype_key() == "idrinth_hev_high_elf_vampires_idrinthchampion" or context:character():character_subtype_key() == "idrinth_hev_high_elf_vampires_idrinthgeneral";
        if isIdrinth then
            Idrinth._self = context:character();            
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
            local subtype = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "character_name", "panel_subtitle", "dy_subtype");
            if subtype then
                subtype:SetText("High Elf Vampire");
            end;
            cm:callback(
                function()
                    if not Idrinth._self then
                        return;
                    end;
                    set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
                    local subtype = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "character_name", "panel_subtitle", "dy_subtype");
                    if subtype then
                        subtype:SetText("High Elf Vampire");
                    end;
                end,
                1
            );
        else
            Idrinth._self = nil;            
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")            
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "stats_effects_holder");
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
        end;
        local initiative_sets = context:character():character_details():character_initiative_sets();
        local has_actual_initiative_sets = false;
        if initiative_sets then
            for i = 0, initiative_sets:num_items() -1 do
                local initiative_set = initiative_sets:item_at(i)
                if initiative_set then
                    local local_initiatives = initiative_set:all_initiatives();
                    if local_initiatives then
                        for j = 0, local_initiatives:num_items() -1 do
                            local initiative = local_initiatives:item_at(j);
                            if initiative then
                                local initiative_key = initiative:record_key();
                                IdrinthUtility.log(initiative_key);
                                if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                    --idrinth is the only one who gets his initiatives
                                else
                                    has_actual_initiative_sets = true;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        if not has_actual_initiative_sets then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
        end;
        Idrinth._lastSelectionAgent = context:character();
        cm:callback(
            function()
                local initiative_sets = Idrinth._lastSelectionAgent:character_details():character_initiative_sets();
                local has_actual_initiative_sets = false;
                if initiative_sets then
                    for i = 0, initiative_sets:num_items() -1 do
                        local initiative_set = initiative_sets:item_at(i)
                        if initiative_set then
                            local local_initiatives = initiative_set:all_initiatives();
                            if local_initiatives then
                                for j = 0, local_initiatives:num_items() -1 do
                                    local initiative = local_initiatives:item_at(j);
                                    if initiative then
                                        local initiative_key = initiative:record_key()
                                        if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                            --idrinth is the only one who gets his initiatives
                                        else
                                            has_actual_initiative_sets = true;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                if not has_actual_initiative_sets then
                    set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
                end;
            end,
            1
        );
    end,
    true
);
core:add_listener(
    "idrinth_CharacterCharacterTargetAction",
    "CharacterCharacterTargetAction",
    function(context)
        local idrinth = Idrinth.Access.get();
        if not idrinth then
            return false;
        end;
        return (context:character() == idrinth);
    end,
    function(context)    
        IdrinthUtility.log("IDRINTH DEBUG FUNCTION: CharacterCharacterTargetAction");
        local ability = context:ability();
        local idrinth = Idrinth.Access.get();

        if ability == "hinder_army" then
            if context:mission_result_critial_failure() then
                -- nothing
            elseif context:mission_result_success() then
                cm:apply_effect_bundle_to_character("idrinth_successful_action_army", idrinth, 2);
            elseif context:mission_result_critial_success() then
                cm:replenish_action_points(cm:char_lookup_str(idrinth));
                cm:apply_effect_bundle_to_character("idrinth_successful_action_army_critical", idrinth, 5);
            end;
        elseif ability == "hinder_character" or ability == "hinder_agent" then
            if context:mission_result_critial_failure() then
                -- nothing
            elseif context:mission_result_success() then
                Idrinth.charactersAssassinated = Idrinth.charactersAssassinated + 1;
                cm:apply_effect_bundle_to_character("idrinth_successful_action_character", idrinth, 2);
            elseif context:mission_result_critial_success() then
                Idrinth.charactersAssassinated = Idrinth.charactersAssassinated + 1;
                cm:replenish_action_points(cm:char_lookup_str(idrinth));
                cm:apply_effect_bundle_to_character("idrinth_successful_action_character_critical", idrinth, 5);
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_CharacterInfoPanelOpened",
    "PanelOpenedCampaign",
    function(context)
        return context.string == "character_details_panel";
    end,
    function(context)
        IdrinthUtility.log("IDRINTH DEBUG: ===== CREATING CHARACTER DETAIL UI =====");
        local paths = core:get_or_create_component(
            "idrinth_character_details_panel_idrinths_paths",
            "ui/idrinth/idrinth_character_details_panel_idrinths_paths.twui.xml",
            find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels")
        );
        UIComponent(paths:Parent()):Adopt(paths:Address(), 3);
        core:get_or_create_component(
            "idrinth_character_details_panel_idrinths_paths_button",
            "ui/idrinth/idrinth_character_details_panel_idrinths_paths_button.twui.xml",
            find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup")
        );
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths")
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
        if Idrinth._lastSelectionAgent then
            if not Idrinth._self then
                local initiative_sets = Idrinth._lastSelectionAgent:character_details():character_initiative_sets();
                local has_actual_initiative_sets = false;
                if initiative_sets then
                    for i = 0, initiative_sets:num_items() -1 do
                        local initiative_set = initiative_sets:item_at(i)
                        if initiative_set then
                            local local_initiatives = initiative_set:all_initiatives();
                            if local_initiatives then
                                for j = 0, local_initiatives:num_items() -1 do
                                    local initiative = local_initiatives:item_at(j);
                                    if initiative then
                                        local initiative_key = initiative:record_key();
                                        IdrinthUtility.log(initiative_key);
                                        if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                            --idrinth is the only one who gets his initiatives
                                        else
                                            has_actual_initiative_sets = true;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                if not has_actual_initiative_sets then
                    set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
                end;
                cm:callback(
                    function()
                        local initiative_sets = Idrinth._lastSelectionAgent:character_details():character_initiative_sets();
                        local has_actual_initiative_sets = false;
                        if initiative_sets then
                            for i = 0, initiative_sets:num_items() -1 do
                                local initiative_set = initiative_sets:item_at(i)
                                if initiative_set then
                                    local local_initiatives = initiative_set:all_initiatives();
                                    if local_initiatives then
                                        for j = 0, local_initiatives:num_items() -1 do
                                            local initiative = local_initiatives:item_at(j);
                                            if initiative then
                                                local initiative_key = initiative:record_key()
                                                if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                                    --idrinth is the only one who gets his initiatives
                                                else
                                                    has_actual_initiative_sets = true;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        if not has_actual_initiative_sets then
                            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
                        end;
                    end,
                    1
                );
            end;
            return;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
        find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "character_name", "panel_subtitle", "dy_subtype"):SetText("High Elf Vampire")
    end,
    true
);
core:add_listener(
    "idrinth_enableIdrinthsPaths",
    "ComponentLClickUp",
    function(context)
        return Idrinth.Access.spawned() and context.string == "idrinth_character_details_panel_idrinths_paths_button";
    end,
    function(context)
        set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");      
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "character_details_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "skills_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "sla_eternal_dance_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "quests_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "character_initiatives_holder");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "fragments_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "vows_subpanel");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
    end,
    true
);
core:add_listener(
    "idrinth_disableIdrinthsPaths",
    "ComponentLClickUp",
    Idrinth.Access.spawned,
    function(context)
        if context.string == "idrinth_character_details_panel_idrinths_paths_button" then
            return;
        end;
        if context.string == "details" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "stats_effects_holder");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "character_details_subpanel");
        elseif context.string == "skills" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "stats_effects_holder");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "skills_subpanel");
        elseif context.string == "eternal_dance" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "sla_eternal_dance_subpanel");
        elseif context.string == "quests" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "quests");
        elseif context.string == "fragments" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "fragments_subpanel");
        elseif context.string == "vows" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "vows_subpanel");
        elseif context.string == "changeling" then
            set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
            set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "formless_horror_subpanel");
        end;
    end,
    true
);
Idrinth._lastClicked = "";
core:add_listener(
    "idrinth_OpenChapelView",
    "ComponentLClickUp",
    function(context)
        if not Idrinth.Access.spawned() then
            return false;
        end;
        return context.string == "button_default_view" or context.string == "button_ally_view" or context.string == "button_player_foreign_view" or context.string == "button_player_foreign_trap_view" or context.string == "button_discovered_view" or context.string == "idrinth_settlement_panel_button";
    end,
    function(context)
        Idrinth._lastClicked = context.string;
        cm:callback(
            function()
                if Idrinth._lastClicked == "idrinth_settlement_panel_button" then
                    local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
                    if not parent then
                        return;
                    end;
                    for i = 0, parent:ChildCount() - 1 do
                        local buttons = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
                        if UIComponent(buttons:Find("idrinth_settlement_panel_button")):VisibleFromRoot() and UIComponent(buttons:Find("idrinth_settlement_panel_button")):CurrentState() == "selected" then
                            for j = 0, buttons:ChildCount() - 1 do
                                if UIComponent(buttons:Find(j)):VisibleFromRoot() then
                                    UIComponent(buttons:Find(j)):SetState("active");
                                end;
                            end;
                            UIComponent(buttons:Find("idrinth_settlement_panel_button")):SetState("selected");
                            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
                            UIComponent(settlement:Find("default_view")):SetVisible(false);
                            UIComponent(settlement:Find("hostile_views")):SetVisible(false);
                            UIComponent(settlement:Find("discovered_views")):SetVisible(false);
                            UIComponent(settlement:Find("allied_view")):SetVisible(false);
                            UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(true);
                        end;
                    end;
                elseif Idrinth._lastClicked == "button_default_view" or Idrinth._lastClicked == "button_ally_view" or Idrinth._lastClicked == "button_player_foreign_view" or Idrinth._lastClicked == "button_player_foreign_trap_view" or Idrinth._lastClicked == "button_discovered_view" then
                    local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
                    if not parent then
                        return;
                    end;            
                    for i = 0, parent:ChildCount() - 1 do
                        local buttons = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
                        if UIComponent(buttons:Find(Idrinth._lastClicked)):CurrentState() == "selected" and UIComponent(buttons:Find("idrinth_settlement_panel_button")):CurrentState() == "selected" and UIComponent(buttons:Find("idrinth_settlement_panel_button")):VisibleFromRoot() then
                            UIComponent(buttons:Find("idrinth_settlement_panel_button")):SetState("active");
                            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
                            UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(false);
                            if context.string == "button_default_view" then
                                UIComponent(settlement:Find("default_view")):SetVisible(true);
                            elseif context.string == "button_ally_view" then
                                UIComponent(settlement:Find("allied_view")):SetVisible(true);
                            elseif context.string == "button_player_foreign_view" then
                                UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                            elseif context.string == "button_player_foreign_trap_view" then
                                UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                            elseif context.string == "button_discovered_view" then
                                UIComponent(settlement:Find("discovered_views")):SetVisible(true);
                            end;
                        end;
                    end;
                end;
            end,
            1
        );
    end,
    true
);
core:add_listener(
    "idrinth_SettlementPanelOpened",
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    IdrinthUtility.settlementForeignSlotDisplay,
    true
);
core:add_listener(
    "idrinth_BuildingBrowserPanelOpened",
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    IdrinthUtility.settlementForeignSlotDisplay,
    true
);
core:add_listener(
    "idrinth_SettlementSelected",
    "CampaignSettlementSelectedAny",
    Idrinth.Access.spawned,
    IdrinthUtility.settlementForeignSlotDisplay,
    true
);