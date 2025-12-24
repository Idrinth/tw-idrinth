local settlementForeignSlotDisplay = function(context)
    local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
    if not parent then
        return;
    end;
    for i = 1, parent:ChildCount() do
        local settlementSlots = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "hostile_views", "settlement_hostile_slots");
        local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
        local element;
        if i == 1 then
            element = core:get_or_create_component(
                "idrinth_settlement_hostile_slots",
                "ui/idrinth/idrinth_settlement_hostile_slots_capital.twui.xml",
                settlement
            );
        else
            element = core:get_or_create_component(
                "idrinth_settlement_hostile_slots",
                "ui/idrinth/idrinth_settlement_hostile_slots.twui.xml",
                settlement
            );
        end;
        element:SetDockOffset(0, 25);-- 25 down
        element:SetContextObject(settlementSlots:GetContextObject("CcoCampaignSettlement"));
        element:SetVisible(false);
        local buttons = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
        local button = core:get_or_create_component(
            "idrinth_settlement_panel_button",
            "ui/idrinth/idrinth_settlement_panel_button.twui.xml",
            buttons
        );
        button:SetContextObject(settlementSlots:GetContextObject("CcoCampaignSettlement"));
    end;
end;
local lastClicked = "";

core:add_listener(
    "idrinth_settlementui_ComponentLClickUp",
    "ComponentLClickUp",
    function(context)
        if not Idrinth.Access.spawned() then
            return false;
        end;
        return context.string == "button_default_view" or context.string == "button_ally_view" or context.string == "button_player_foreign_view" or context.string == "button_player_foreign_trap_view" or context.string == "button_discovered_view" or context.string == "idrinth_settlement_panel_button";
    end,
    function(context)
        lastClicked = context.string;
        Idrinth.Ui.nowAndThen(
            function()
                if lastClicked == "idrinth_settlement_panel_button" then
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
                elseif lastClicked == "button_default_view" or lastClicked == "button_ally_view" or lastClicked == "button_player_foreign_view" or lastClicked == "button_player_foreign_trap_view" or lastClicked == "button_discovered_view" then
                    local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
                    if not parent then
                        return;
                    end;            
                    for i = 0, parent:ChildCount() - 1 do
                        local buttons = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
                        if UIComponent(buttons:Find(lastClicked)):CurrentState() == "selected" and UIComponent(buttons:Find("idrinth_settlement_panel_button")):CurrentState() == "selected" and UIComponent(buttons:Find("idrinth_settlement_panel_button")):VisibleFromRoot() then
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
            end
        );
    end,
    true
);
core:add_listener(
    "idrinth_settlementui_PanelOpenedCampaign",
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    settlementForeignSlotDisplay,
    true
);
core:add_listener(
    "idrinth_settlementui_PanelOpenedCampaign_2",
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    settlementForeignSlotDisplay,
    true
);
core:add_listener(
    "idrinth_settlementui_CampaignSettlementSelectedAny",
    "CampaignSettlementSelectedAny",
    Idrinth.Access.spawned,
    settlementForeignSlotDisplay,
    true
);