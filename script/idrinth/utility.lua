IdrinthUtility = {};

IdrinthUtility.settlementForeignSlotDisplay = function(context)
    log("IDRINTH DEBUG: ===== CREATING SETTLEMENT DETAIL UI =====");
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
IdrinthUtility.nowAndThen(callback)
    callback();
    cm:callback(callback, 1);
end;