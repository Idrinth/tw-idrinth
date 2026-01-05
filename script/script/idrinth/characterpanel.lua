local containsInitiatives = function(cqi)
    local character = cm:get_character_by_cqi(cqi);
    if not character then
        return false;
    end;
    local initiative_sets = character:character_details():character_initiative_sets();
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
                            if (initiative_key == "idrinth_khaine_pledge") or (initiative_key == "idrinth_kurnous_pledge") or (initiative_key == "idrinth_asuryan_pledge") or (initiative_key == "idrinth_khaine_prayer") or (initiative_key == "idrinth_kurnous_prayer") or (initiative_key == "idrinth_asuryan_prayer") then
                                --idrinth is the only one who gets his initiatives
                            else
                                return true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
    return false;
end;
local setupInitiatives = function()
    if not cm:get_campaign_ui_manager():is_panel_open("character_details_panel") then
        return;
    end;
    local character = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent"):GetContextObjectId("CcoCampaignCharacter");
    if character and containsInitiatives(common.get_context_value("CcoCampaignCharacter", character, "CQI")) then
        return;
    end;
    set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives")
end;
local setupIdrinthsPaths = function()
    if not cm:get_campaign_ui_manager():is_panel_open("character_details_panel") then
        return;
    end;
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
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    if not character then
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")            
        set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "stats_effects_holder");
        set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
        return;
    end;
    local isIdrinth = character:character_subtype_key() == Idrinth.Constants.HeroSubtype or character:character_subtype_key() == Idrinth.Constants.LordSubtype;
    if isIdrinth then   
        set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")
        local subtype = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent", "character_name", "panel_subtitle", "dy_subtype");
        if subtype then
            subtype:SetText("High Elf Vampire");
        end;
        return;
    end
    set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "TabGroup", "idrinth_character_details_panel_idrinths_paths_button")            
    set_component_visible_with_parent(true, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "stats_effects_holder");
    set_component_visible_with_parent(false, core:get_ui_root(), "character_details_panel", "character_context_parent", "tab_panels", "idrinth_character_details_panel_idrinths_paths");
end;
core:add_listener(
    "idrinth_characterpanel_CharacterSelected",
    "CharacterSelected",
    function()
        return cm:get_campaign_ui_manager():is_panel_open("character_details_panel");
    end,
    function(context)
        Idrinth.log("CharacterSelected", "characterpanel");
        Idrinth.Ui.nowAndThen(setupIdrinthsPaths);
        Idrinth.Ui.nowAndThen(setupInitiatives);
    end,
    true
);
core:add_listener(
    "idrinth_characterpanel_CharacterSkillPointAllocated",
    "CharacterSkillPointAllocated",
    true,
    function(context)
        Idrinth.log("CharacterSkillPointAllocated", "characterpanel");
        Idrinth.Ui.nowAndThen(setupIdrinthsPaths);
        Idrinth.Ui.nowAndThen(setupInitiatives);
    end,
    true
);
core:add_listener(
    "idrinth_characterpanel_PanelOpenedCampaign",
    "PanelOpenedCampaign",
    function(context)
        return context.string == "character_details_panel";
    end,
    function(context)
        Idrinth.log("PanelOpenedCampaign", "characterpanel");
        Idrinth.Ui.nowAndThen(setupIdrinthsPaths);
        Idrinth.Ui.nowAndThen(setupInitiatives);
    end,
    true
);
core:add_listener(
    "idrinth_characterpanel_ComponentLClickUp",
    "ComponentLClickUp",
    function(context)
        return cm:get_campaign_ui_manager():is_panel_open("character_details_panel") and context.string == "idrinth_character_details_panel_idrinths_paths_button";
    end,
    function(context)
        Idrinth.log("ComponentLClickUp", "characterpanel");
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
    "idrinth_characterpanel_ComponentLClickUp_2",
    "ComponentLClickUp",
    function()
        return cm:get_campaign_ui_manager():is_panel_open("character_details_panel");
    end,
    function(context)
        Idrinth.log("ComponentLClickUp", "characterpanel");
        if context.string == "idrinth_character_details_panel_idrinths_paths_button" then
            return;
        end;
        Idrinth.Ui.nowAndThen(setupInitiatives);
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