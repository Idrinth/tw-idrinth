local fixLordType = function()
    if not cm:get_campaign_ui_manager():is_panel_open("character_panel") then
        return;
    end;
    local parent = find_uicomponent(core:get_ui_root(), "character_panel", "character_panel_info_holder", "general_selection_panel", "main_holder", "character_list_parent", "character_list", "listview", "list_clip", "list_box");
    if not parent then
        return;
    end;
    if parent:ChildCount() == 0 then
        return;
    end;
    for i = 1, parent:ChildCount() do
        local child = parent:Find(i);
        if child then
            if UIComponent(child):Visible() then
                local subtype = find_uicomponent(UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                if subtype then
                    local character = subtype:GetContextObjectId("CcoCampaignCharacter");
                    if character then
                        local subtype_string = common.get_context_value("CcoCampaignCharacter", character, "AgentSubtypeRecordContext.Key")
                        local isIdrinth = subtype_string == Idrinth.Constants.BaseType..Idrinth.Constants.HeroType or subtype_string == Idrinth.Constants.BaseType..Idrinth.Constants.LordType;
                        if isIdrinth and subtype and not subtype:Visible() then
                            set_component_visible_with_parent(true, UIComponent(child), "info_holder", "details_holder", "dy_subtype");
                            subtype:SetText("High Elf Vampire");
                        end;
                        return;
                    end;
                end;
            end;
        end;
    end;
end;
core:add_listener(
    "idrinth_recruitingui_ComponentLClickUp",
    "ComponentLClickUp",
    function(context)
        if context.string ~= "legendary_lords" then
            return false;
        end
        return Idrinth.Access.spawned();
    end,
    function(context)
        Idrinth.log("ComponentLClickUp", "recruitingui");
        Idrinth.Ui.nowAndThen(fixLordType);
    end,
    true
);
core:add_listener(
    "idrinth_recruitingui_PanelOpenedCampaign",
    "PanelOpenedCampaign",
    function(context)
        if context.string ~= "character_panel" then
            return false;
        end
        return Idrinth.Access.spawned();
    end,
    function(context)
        Idrinth.log("PanelOpenedCampaign", "recruitingui");
        Idrinth.Ui.nowAndThen(fixLordType);
    end,
    true
);