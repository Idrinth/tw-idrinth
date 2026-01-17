--- @module Idrinth.Recruitingui
--- Recruitment UI customization for the Idrinth mod.
--- Fixes the lord type display to show "High Elf Vampire" for Idrinth.
--- Corrects visibility issues for subtype text in the character recruitment list.

--- Checks if a subtype string matches Idrinth's hero or lord subtype.
--- @param subtype_string string The subtype key to check.
--- @return boolean True if the subtype is Idrinth.
local isIdrinthSubtype = function(subtype_string)
    return subtype_string == Idrinth.Constants.HeroSubtype or subtype_string == Idrinth.Constants.LordSubtype;
end;

--- Processes a character list child component to fix Idrinth's subtype display.
--- @param childComponent userdata The character list item UI component.
--- @return boolean True if processing should continue to next child.
local processCharacterChild = function(childComponent)
    if not childComponent:Visible() then
        return false;
    end;
    local subtype = Idrinth.Ui.findElementWithin(childComponent, "info_holder", "details_holder", "dy_subtype");
    if not subtype then
        return false;
    end;
    local character = subtype:GetContextObjectId("CcoCampaignCharacter");
    if not character then
        return false;
    end;
    local subtype_string = common.get_context_value("CcoCampaignCharacter", character, "AgentSubtypeRecordContext.Key");
    if isIdrinthSubtype(subtype_string) and not subtype:Visible() then
        set_component_visible_with_parent(true, childComponent, "info_holder", "details_holder", "dy_subtype");
        subtype:SetText("High Elf Vampire");
    end;
    return true;
end;

--- Fixes the lord type display in the recruitment panel for Idrinth.
local fixLordType = function()
    if not cm:get_campaign_ui_manager():is_panel_open("character_panel") then
        return;
    end;
    local parent = Idrinth.Ui.findElementWithin(
        "character_panel", "character_panel_info_holder", "general_selection_panel",
        "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box"
    );
    if not parent or parent:ChildCount() == 0 then
        return;
    end;
    Idrinth.Ui.findChildWhere(parent, processCharacterChild);
end;
Idrinth.Events.addListener(
    "ComponentLClickUp",
    function(context)
        if context.string ~= "legendary_lords" then
            return false;
        end;
        return Idrinth.Access.spawned();
    end,
    function()
        Idrinth.Ui.nowAndThen(fixLordType);
    end
);
Idrinth.Events.addListener(
    "PanelOpenedCampaign",
    function(context)
        if context.string ~= "character_panel" then
            return false;
        end;
        return Idrinth.Access.spawned();
    end,
    function()
        Idrinth.Ui.nowAndThen(fixLordType);
    end
);
