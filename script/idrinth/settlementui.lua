local settlementForeignSlotDisplay = function(context)
    local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
    if not parent or parent == core:get_ui_root() then
        return;
    end;
    for i = 1, parent:ChildCount() do
        local settlementSlots = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "hostile_views", "settlement_hostile_slots");
        local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
        if settlement and settlementSlots then
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
        Idrinth.log("ComponentLClickUp", "settlementui");
        lastClicked = context.string;
        Idrinth.Ui.nowAndThen(
            function()
                local parent = find_uicomponent(core:get_ui_root(), "settlement_panel", "settlement_list");
                if not parent or parent == core:get_ui_root() then
                    return;
                end;
                for i = 1, parent:ChildCount() do
                    local buttons = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
                    if buttons then
                        local activeButtons = 0;
                        for j = 1, buttons:ChildCount() do
                            local button = UIComponent(buttons:Find(j));
                            if button:VisibleFromRoot() and button:CurrentState() == "selected" then
                                activeButtons = activeButtons + 1;
                            end;
                        end;
                        if activeButtons == 0 then
                            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
                            UIComponent(settlement:Find("default_view")):SetVisible(true);
                            UIComponent(settlement:Find("hostile_views")):SetVisible(false);
                            UIComponent(settlement:Find("discovered_views")):SetVisible(false);
                            UIComponent(settlement:Find("allied_view")):SetVisible(false);
                            UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(false);
                            UIComponent("button_default_view"):SetState("selected");
                        elseif activeButtons == 1 then
                            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
                            UIComponent(settlement:Find("default_view")):SetVisible(false);
                            UIComponent(settlement:Find("hostile_views")):SetVisible(false);
                            UIComponent(settlement:Find("discovered_views")):SetVisible(false);
                            UIComponent(settlement:Find("allied_view")):SetVisible(false);
                            UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(false);
                            if lastClicked == "button_default_view" then
                                UIComponent(settlement:Find("default_view")):SetVisible(true);
                            elseif lastClicked == "button_ally_view" then
                                UIComponent(settlement:Find("allied_view")):SetVisible(true);
                            elseif lastClicked == "button_player_foreign_view" then
                                UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                            elseif lastClicked == "button_player_foreign_trap_view" then
                                UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                            elseif lastClicked == "button_discovered_view" then
                                UIComponent(settlement:Find("discovered_views")):SetVisible(true);
                            elseif lastClicked == "idrinth_settlement_panel_button" then
                                UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(true);
                            end;
                        elseif activeButtons > 1 then
                            local settlement = find_uicomponent(UIComponent(parent:Find(i)), "settlement_view");
                            if lastClicked == "idrinth_settlement_panel_button" then
                                for j = 1, buttons:ChildCount() do
                                    if UIComponent(buttons:Find(j)):VisibleFromRoot() then
                                        UIComponent(buttons:Find(j)):SetState("active");
                                    end;
                                end;
                                UIComponent(buttons:Find("idrinth_settlement_panel_button")):SetState("selected");
                                UIComponent(settlement:Find("default_view")):SetVisible(false);
                                UIComponent(settlement:Find("hostile_views")):SetVisible(false);
                                UIComponent(settlement:Find("discovered_views")):SetVisible(false);
                                UIComponent(settlement:Find("allied_view")):SetVisible(false);
                                UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(true);
                            else
                                UIComponent(buttons:Find("idrinth_settlement_panel_button")):SetState("active");
                                UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(false);
                                if lastClicked == "button_default_view" then
                                    UIComponent(settlement:Find("default_view")):SetVisible(true);
                                elseif lastClicked == "button_ally_view" then
                                    UIComponent(settlement:Find("allied_view")):SetVisible(true);
                                elseif lastClicked == "button_player_foreign_view" then
                                    UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                                elseif lastClicked == "button_player_foreign_trap_view" then
                                    UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                                elseif lastClicked == "button_discovered_view" then
                                    UIComponent(settlement:Find("discovered_views")):SetVisible(true);
                                end;
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
    function(context)
        Idrinth.log("PanelOpenedCampaign", "settlementui");
        settlementForeignSlotDisplay(context);
    end,
    true
);
core:add_listener(
    "idrinth_settlementui_PanelOpenedCampaign_2",
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    function(context)
        Idrinth.log("PanelOpenedCampaign", "settlementui");
        settlementForeignSlotDisplay(context);
    end,
    true
);
core:add_listener(
    "idrinth_settlementui_CampaignSettlementSelectedAny",
    "CampaignSettlementSelectedAny",
    Idrinth.Access.spawned,
    function(context)
        Idrinth.log("CampaignSettlementSelectedAny", "settlementui");
        settlementForeignSlotDisplay(context);
    end,
    true
);