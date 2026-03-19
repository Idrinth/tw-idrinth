--- @module Idrinth.Characterpanel
--- Character panel customization for the Idrinth mod.
--- Adds a custom "Idrinth's Paths" tab to the character details panel.
--- Manages visibility of initiative tabs and custom UI elements for Idrinth.

-- File-local constants for repeated strings
local PANEL_NAME = "character_details_panel";
local CONTEXT_PARENT = "character_context_parent";
local TAB_PANELS = "tab_panels";
local TAB_GROUP = "TabGroup";
local PATHS_PANEL = "idrinth_character_details_panel_idrinths_paths";
local PATHS_BUTTON = "idrinth_character_details_panel_idrinths_paths_button";
local CHARACTER_CONTEXT = "CcoCampaignCharacter";

-- Initiative key constants
local INITIATIVE_KEYS = {
    "idrinth_khaine_pledge",
    "idrinth_kurnous_pledge",
    "idrinth_asuryan_pledge",
    "idrinth_khaine_prayer",
    "idrinth_kurnous_prayer",
    "idrinth_asuryan_prayer",
};
local IDRINTH_INITIATIVES = {};
for _, key in pairs(INITIATIVE_KEYS) do
    IDRINTH_INITIATIVES[key] = true;
end;

--- Checks if a character has any non-Idrinth initiatives.
--- @param cqi number The character command queue index.
--- @return boolean True if the character has other initiatives.
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
                            if not IDRINTH_INITIATIVES[initiative_key] then
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
--- Sets the visibility of a UI component with logging.
--- @param component userdata The UI component.
--- @param visible boolean The desired visibility state.
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
--- Gets the CQI of the currently selected character in the character panel.
--- @return number The character CQI, or 0 if no character is selected.
local getChosenCharacterCQI = function()
    if not cm:get_campaign_ui_manager():is_panel_open(PANEL_NAME) then
        return 0;
    end;
    local characterContext = Idrinth.Ui.findElementWithin(PANEL_NAME, CONTEXT_PARENT);
    if not characterContext then
        return 0;
    end;
    local character = characterContext:GetContextObjectId(CHARACTER_CONTEXT);
    if not character then
        return 0;
    end;
    return common.get_context_value(CHARACTER_CONTEXT, character, "CQI");
end;
--- Sets up the initiatives tab visibility based on the selected character.
local setupInitiatives = function()
    local cqi = getChosenCharacterCQI();
    local initiativesTab = Idrinth.Ui.findElementWithin(
        PANEL_NAME, CONTEXT_PARENT, TAB_GROUP, "character_initiatives"
    );
    setVisibility(initiativesTab, false);
    if containsInitiatives(cqi) then
        setVisibility(initiativesTab, true);
    end;
end;
--- Hides Idrinth-specific panels when viewing a non-Idrinth character.
local hideIdrinthPanels = function()
    local tabPanels = Idrinth.Ui.findElementWithin(
        PANEL_NAME, CONTEXT_PARENT, TAB_PANELS
    );
    local tabGroup = Idrinth.Ui.findElementWithin(
        PANEL_NAME, CONTEXT_PARENT, TAB_GROUP
    );
    if not tabGroup or not tabPanels then
        return;
    end;
    setVisibility(Idrinth.Ui.findElementWithin(tabGroup, PATHS_BUTTON), false);
    setVisibility(Idrinth.Ui.findElementWithin(tabPanels, "stats_effects_holder"), true);
    setVisibility(Idrinth.Ui.findElementWithin(tabPanels, PATHS_PANEL), false);
end;
--- Sets up Idrinth's Paths panel and button in the character details panel.
local setupIdrinthsPaths = function()
    if not cm:get_campaign_ui_manager():is_panel_open(PANEL_NAME) then
        return;
    end;
    local tabPanels = Idrinth.Ui.findElementWithin(
        PANEL_NAME, CONTEXT_PARENT, TAB_PANELS
    );
    local tabGroup = Idrinth.Ui.findElementWithin(
        PANEL_NAME, CONTEXT_PARENT, TAB_GROUP
    );
    if not tabPanels or not tabGroup then
        return;
    end;
    local paths = Idrinth.Ui.createOrFind(PATHS_PANEL, tabPanels);
    UIComponent(paths:Parent()):Adopt(paths:Address(), 3);
    local pathsButton = Idrinth.Ui.createOrFind(PATHS_BUTTON, tabGroup);
    setVisibility(paths, false);
    setVisibility(pathsButton, false);
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
    local isIdrinth = character:character_subtype_key() == Idrinth.Constants.HeroSubtype
        or character:character_subtype_key() == Idrinth.Constants.LordSubtype;
    Idrinth.log("is idrinth?: "..tostring(isIdrinth), "characterpanel");
    if isIdrinth then
        Idrinth.log("is idrinth: setting up", "characterpanel");
        setVisibility(pathsButton, true);
        local subtype = Idrinth.Ui.findElementWithin(
            PANEL_NAME, CONTEXT_PARENT,
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
Idrinth.Events.addListener(
    "CharacterSelected",
    function()
        return cm:get_campaign_ui_manager():is_panel_open(PANEL_NAME);
    end,
    function()
        Idrinth.Ui.nowAndThen(setupIdrinthsPaths);
        Idrinth.Ui.nowAndThen(setupInitiatives);
    end
);
Idrinth.Events.addListener(
    "CharacterSkillPointAllocated",
    true,
    function()
        Idrinth.Ui.nowAndThen(setupIdrinthsPaths);
        Idrinth.Ui.nowAndThen(setupInitiatives);
    end
);
Idrinth.Events.addListener(
    "PanelOpenedCampaign",
    Idrinth.Events.Conditions.panelOpened(PANEL_NAME),
    function()
        Idrinth.Ui.nowAndThen(setupIdrinthsPaths);
        Idrinth.Ui.nowAndThen(setupInitiatives);
    end
);
Idrinth.Events.addListener(
    "ComponentLClickUp",
    function(context)
        local isPanelOpen = cm:get_campaign_ui_manager():is_panel_open(PANEL_NAME);
        return isPanelOpen and context.string == PATHS_BUTTON;
    end,
    function()
        local uiRoot = core:get_ui_root();
        set_component_visible_with_parent(
            true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, PATHS_PANEL
        );
        set_component_visible_with_parent(
            false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "character_details_subpanel"
        );
        set_component_visible_with_parent(false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "skills_subpanel");
        set_component_visible_with_parent(
            false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "sla_eternal_dance_subpanel"
        );
        set_component_visible_with_parent(false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "quests_subpanel");
        set_component_visible_with_parent(
            false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "character_initiatives_holder"
        );
        set_component_visible_with_parent(false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "fragments_subpanel");
        set_component_visible_with_parent(false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "vows_subpanel");
        set_component_visible_with_parent(
            false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_GROUP, "character_initiatives"
        );
    end
);
Idrinth.Events.addListener(
    "ComponentLClickUp",
    Idrinth.Events.Conditions.isPanelOpen(PANEL_NAME),
    function(context)
        if context.string == PATHS_BUTTON then
            return;
        end;
        Idrinth.Ui.nowAndThen(setupInitiatives);
        local uiRoot = core:get_ui_root();
        set_component_visible_with_parent(false, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, PATHS_PANEL);
        if context.string == "details" then
            set_component_visible_with_parent(
                true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "stats_effects_holder"
            );
            set_component_visible_with_parent(
                true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "character_details_subpanel"
            );
        elseif context.string == "skills" then
            set_component_visible_with_parent(
                true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "stats_effects_holder"
            );
            set_component_visible_with_parent(true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "skills_subpanel");
        elseif context.string == "eternal_dance" then
            set_component_visible_with_parent(
                true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "sla_eternal_dance_subpanel"
            );
        elseif context.string == "quests" then
            set_component_visible_with_parent(true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "quests");
        elseif context.string == "fragments" then
            set_component_visible_with_parent(
                true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "fragments_subpanel"
            );
        elseif context.string == "vows" then
            set_component_visible_with_parent(true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "vows_subpanel");
        elseif context.string == "changeling" then
            set_component_visible_with_parent(
                true, uiRoot, PANEL_NAME, CONTEXT_PARENT, TAB_PANELS, "formless_horror_subpanel"
            );
        end;
    end
);
