local settlementForeignSlotDisplay = function()
    local parent = Idrinth.Ui.findElementWithin("settlement_panel", "settlement_list");
    if not parent then
        return;
    end;
    for i = 1, parent:ChildCount() do
        local settlementSlots = Idrinth.Ui.findElementWithin(UIComponent(parent:Find(i)), "settlement_view", "hostile_views", "settlement_hostile_slots");
        local settlement = Idrinth.Ui.findElementWithin(UIComponent(parent:Find(i)), "settlement_view");
        if settlement and settlementSlots then
            local element;
            if i == 1 then
                element = Idrinth.Ui.createOrFind("idrinth_settlement_hostile_slots", settlement, "idrinth_settlement_hostile_slots_capital");
            else
                element = Idrinth.Ui.createOrFind("idrinth_settlement_hostile_slots", settlement);
            end;
            element:SetDockOffset(0, 25);-- 25 down
            element:SetContextObject(settlementSlots:GetContextObject("CcoCampaignSettlement"));
            element:SetVisible(false);
            local buttons = Idrinth.Ui.findElementWithin(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
            local button = Idrinth.Ui.createOrFind("idrinth_settlement_panel_button", buttons);
            button:SetContextObject(settlementSlots:GetContextObject("CcoCampaignSettlement"));
        end;
    end;
end;
local lastClicked = "";
local updateSettlementViewState = function(clickedButton)
    local parent = Idrinth.Ui.findElementWithin("settlement_panel", "settlement_list");
    if not parent then
        return;
    end;
    for i = 1, parent:ChildCount() do
        local buttons = Idrinth.Ui.findElementWithin(UIComponent(parent:Find(i)), "settlement_view", "toggle_button_holder", "button_list");
        if buttons then
            local activeButtons = 0;
            for j = 1, buttons:ChildCount() do
                local button = UIComponent(buttons:Find(j));
                if button:VisibleFromRoot() and button:CurrentState() == "selected" then
                    activeButtons = activeButtons + 1;
                end;
            end;
            if activeButtons == 0 then
                local settlement = Idrinth.Ui.findElementWithin(UIComponent(parent:Find(i)), "settlement_view");
                UIComponent(settlement:Find("default_view")):SetVisible(true);
                UIComponent(settlement:Find("hostile_views")):SetVisible(false);
                UIComponent(settlement:Find("discovered_views")):SetVisible(false);
                UIComponent(settlement:Find("allied_view")):SetVisible(false);
                UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(false);
                UIComponent("button_default_view"):SetState("selected");
            elseif activeButtons == 1 then
                local settlement = Idrinth.Ui.findElementWithin(UIComponent(parent:Find(i)), "settlement_view");
                UIComponent(settlement:Find("default_view")):SetVisible(false);
                UIComponent(settlement:Find("hostile_views")):SetVisible(false);
                UIComponent(settlement:Find("discovered_views")):SetVisible(false);
                UIComponent(settlement:Find("allied_view")):SetVisible(false);
                UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(false);
                if clickedButton == "button_default_view" then
                    UIComponent(settlement:Find("default_view")):SetVisible(true);
                elseif clickedButton == "button_ally_view" then
                    UIComponent(settlement:Find("allied_view")):SetVisible(true);
                elseif clickedButton == "button_player_foreign_view" then
                    UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                elseif clickedButton == "button_player_foreign_trap_view" then
                    UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                elseif clickedButton == "button_discovered_view" then
                    UIComponent(settlement:Find("discovered_views")):SetVisible(true);
                elseif clickedButton == "idrinth_settlement_panel_button" then
                    UIComponent(settlement:Find("idrinth_settlement_hostile_slots")):SetVisible(true);
                end;
            elseif activeButtons > 1 then
                local settlement = Idrinth.Ui.findElementWithin(UIComponent(parent:Find(i)), "settlement_view");
                if clickedButton == "idrinth_settlement_panel_button" then
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
                    if clickedButton == "button_default_view" then
                        UIComponent(settlement:Find("default_view")):SetVisible(true);
                    elseif clickedButton == "button_ally_view" then
                        UIComponent(settlement:Find("allied_view")):SetVisible(true);
                    elseif clickedButton == "button_player_foreign_view" then
                        UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                    elseif clickedButton == "button_player_foreign_trap_view" then
                        UIComponent(settlement:Find("hostile_views")):SetVisible(true);
                    elseif clickedButton == "button_discovered_view" then
                        UIComponent(settlement:Find("discovered_views")):SetVisible(true);
                    end;
                end;
            end;
        end;
    end;
end;

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
                updateSettlementViewState(lastClicked);
            end
        );
    end,
    true
);
core:add_listener(
    "idrinth_settlementui_PanelOpenedCampaign",
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    function()
        Idrinth.log("PanelOpenedCampaign", "settlementui");
        settlementForeignSlotDisplay();
    end,
    true
);
core:add_listener(
    "idrinth_settlementui_PanelOpenedCampaign_2",
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    function()
        Idrinth.log("PanelOpenedCampaign", "settlementui");
        settlementForeignSlotDisplay();
    end,
    true
);
core:add_listener(
    "idrinth_settlementui_CampaignSettlementSelectedAny",
    "CampaignSettlementSelectedAny",
    Idrinth.Access.spawned,
    function()
        Idrinth.log("CampaignSettlementSelectedAny", "settlementui");
        settlementForeignSlotDisplay();
    end,
    true
);