local containsInitiatives = function(cqi)
    if not cqi then
        return false;
    end;
    local character = cm:get_character_by_cqi(cqi);
    if not character then
        return false;
    end;
    local initiative_sets = character:character_details():character_initiative_sets();
    if initiative_sets then
        for i = 0, initiative_sets:num_items() -1 do
            local initiative_set = initiative_sets:item_at(i);
            if initiative_set then
                local local_initiatives = initiative_set:all_initiatives();
                if local_initiatives then
                    for j = 0, local_initiatives:num_items() -1 do
                        local initiative = local_initiatives:item_at(j);
                        if initiative then
                            local initiative_key = initiative:record_key();
                            local isIdrinthInitiative = (initiative_key == "idrinth_khaine_pledge")
                                or (initiative_key == "idrinth_kurnous_pledge")
                                or (initiative_key == "idrinth_asuryan_pledge")
                                or (initiative_key == "idrinth_khaine_prayer")
                                or (initiative_key == "idrinth_kurnous_prayer")
                                or (initiative_key == "idrinth_asuryan_prayer");
                            if isIdrinthInitiative then
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
local setVisibility = function(component, visible)
    Idrinth.log("visible "..tostring(visible).." for "..tostring(component), "characterpanel");
    if not component then
        return;
    end;
    if component:Visible() == visible then
        return;
    end;
    component:SetVisible(visible);
end;
local getChosenCharacterCQI = function()
    if not cm:get_campaign_ui_manager():is_panel_open("character_details_panel") then
        return 0;
    end;
    local characterContext = Idrinth.Ui.findElementWithin("character_details_panel", "character_context_parent");
    if not characterContext then
        return 0;
    end;
    local character = characterContext:GetContextObjectId("CcoCampaignCharacter");
    if not character then
        return 0;
    end;
    return common.get_context_value("CcoCampaignCharacter", character, "CQI");
end;
local setupInitiatives = function()
    local cqi = getChosenCharacterCQI();
    if cqi and containsInitiatives(cqi) then
        return;
    end;
    local initiativesTab = Idrinth.Ui.findElementWithin(
        "character_details_panel", "character_context_parent", "TabGroup", "character_initiatives"
    );
    setVisibility(initiativesTab, false);
end;
local hideIdrinthPanels = function()
    local tabPanels = Idrinth.Ui.findElementWithin(
        "character_details_panel", "character_context_parent", "tab_panels"
    );
    local tabGroup = Idrinth.Ui.findElementWithin(
        "character_details_panel", "character_context_parent", "TabGroup"
    );
    if not tabGroup or not tabPanels then
        return;
    end;
    setVisibility(Idrinth.Ui.findElementWithin(tabGroup, "idrinth_character_details_panel_idrinths_paths_button"), false);
    setVisibility(Idrinth.Ui.findElementWithin(tabPanels, "stats_effects_holder"), true);
    setVisibility(Idrinth.Ui.findElementWithin(tabPanels, "idrinth_character_details_panel_idrinths_paths"), false);
end;
local setupIdrinthsPaths = function()
    if not cm:get_campaign_ui_manager():is_panel_open("character_details_panel") then
        return;
    end;
    local tabPanels = Idrinth.Ui.findElementWithin(
        "character_details_panel", "character_context_parent", "tab_panels"
    );
    local tabGroup = Idrinth.Ui.findElementWithin(
        "character_details_panel", "character_context_parent", "TabGroup"
    );
    if not tabPanels or not tabGroup then
        return;
    end;
    local paths = Idrinth.Ui.createOrFind("idrinth_character_details_panel_idrinths_paths", tabPanels);
    UIComponent(paths:Parent()):Adopt(paths:Address(), 3);
    local pathsButton = Idrinth.Ui.createOrFind("idrinth_character_details_panel_idrinths_paths_button", tabGroup);
    setVisibility(paths, false);
    setVisibility(pathsButton, false);
    local cqi = getChosenCharacterCQI();
    Idrinth.log("cqi: "..tostring(cqi), "characterpanel");
    if not cqi or cqi == 0 or cqi == "0" then
        hideIdrinthPanels();
        return;
    end;
    local character = cm:get_character_by_cqi(cqi);
    Idrinth.log("character: "..tostring(character), "characterpanel");
    if not character then
        hideIdrinthPanels();
        return;
    end;
    local isIdrinth = character:character_subtype_key() == Idrinth.Constants.HeroSubtype or character:character_subtype_key() == Idrinth.Constants.LordSubtype;
    Idrinth.log("is idrinth?: "..tostring(isIdrinth), "characterpanel");
    if isIdrinth then
        Idrinth.log("is idrinth: setting up", "characterpanel");
        setVisibility(pathsButton, true);
        local subtype = Idrinth.Ui.findElementWithin(
            "character_details_panel", "character_context_parent",
            "character_name", "panel_subtitle", "dy_subtype"
        );
        if subtype then
            subtype:SetText("High Elf Vampire");
        end;
        return;
    end;
    Idrinth.log("is NOT idrinth: setting up", "characterpanel");
    hideIdrinthPanels();
end;
core:add_listener(
    "idrinth_characterpanel_CharacterSelected",
    "CharacterSelected",
    function()
        return cm:get_campaign_ui_manager():is_panel_open("character_details_panel");
    end,
    function()
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
    function()
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
    function()
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
        local isPanelOpen = cm:get_campaign_ui_manager():is_panel_open("character_details_panel");
        return isPanelOpen and context.string == "idrinth_character_details_panel_idrinths_paths_button";
    end,
    function()
        Idrinth.log("ComponentLClickUp", "characterpanel");
        local uiRoot = core:get_ui_root();
        local panel = "character_details_panel";
        local ctx = "character_context_parent";
        local tabs = "tab_panels";
        set_component_visible_with_parent(
            true, uiRoot, panel, ctx, tabs, "idrinth_character_details_panel_idrinths_paths"
        );
        set_component_visible_with_parent(
            false, uiRoot, panel, ctx, tabs, "character_details_subpanel"
        );
        set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, "skills_subpanel");
        set_component_visible_with_parent(
            false, uiRoot, panel, ctx, tabs, "sla_eternal_dance_subpanel"
        );
        set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, "quests_subpanel");
        set_component_visible_with_parent(
            false, uiRoot, panel, ctx, tabs, "character_initiatives_holder"
        );
        set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, "fragments_subpanel");
        set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, "vows_subpanel");
        set_component_visible_with_parent(
            false, uiRoot, panel, ctx, "TabGroup", "character_initiatives"
        );
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
        local uiRoot = core:get_ui_root();
        local panel = "character_details_panel";
        local ctx = "character_context_parent";
        local tabs = "tab_panels";
        local pathsPanel = "idrinth_character_details_panel_idrinths_paths";
        if context.string == "details" then
            set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, pathsPanel);
            set_component_visible_with_parent(true, uiRoot, panel, ctx, tabs, "stats_effects_holder");
            set_component_visible_with_parent(
                true, uiRoot, panel, ctx, tabs, "character_details_subpanel"
            );
        elseif context.string == "skills" then
            set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, pathsPanel);
            set_component_visible_with_parent(true, uiRoot, panel, ctx, tabs, "stats_effects_holder");
            set_component_visible_with_parent(true, uiRoot, panel, ctx, tabs, "skills_subpanel");
        elseif context.string == "eternal_dance" then
            set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, pathsPanel);
            set_component_visible_with_parent(
                true, uiRoot, panel, ctx, tabs, "sla_eternal_dance_subpanel"
            );
        elseif context.string == "quests" then
            set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, pathsPanel);
            set_component_visible_with_parent(true, uiRoot, panel, ctx, tabs, "quests");
        elseif context.string == "fragments" then
            set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, pathsPanel);
            set_component_visible_with_parent(true, uiRoot, panel, ctx, tabs, "fragments_subpanel");
        elseif context.string == "vows" then
            set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, pathsPanel);
            set_component_visible_with_parent(true, uiRoot, panel, ctx, tabs, "vows_subpanel");
        elseif context.string == "changeling" then
            set_component_visible_with_parent(false, uiRoot, panel, ctx, tabs, pathsPanel);
            set_component_visible_with_parent(
                true, uiRoot, panel, ctx, tabs, "formless_horror_subpanel"
            );
        end;
    end,
    true
);