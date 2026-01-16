local isIdrinthSubtype = function(subtype_string)
    return subtype_string == Idrinth.Constants.HeroSubtype or subtype_string == Idrinth.Constants.LordSubtype;
end;

local processCharacterChild = function(child)
    local childComponent = UIComponent(child);
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
    for i = 1, parent:ChildCount() do
        local child = parent:Find(i);
        if child and processCharacterChild(child) then
            return;
        end;
    end;
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
