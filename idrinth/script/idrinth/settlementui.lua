--- @module Idrinth.Settlementui
--- Settlement UI panel customization for the Idrinth mod.
--- Adds a button to view Idrinth's chapel foreign slots in the settlement panel.
--- Handles view switching between default, hostile, and chapel slot views.

-- File-local constants for repeated strings
local SETTLEMENT_PANEL = "settlement_panel";
local SETTLEMENT_LIST = "settlement_list";
local SETTLEMENT_VIEW = "settlement_view";
local HOSTILE_SLOTS = "idrinth_settlement_hostile_slots";
local HOSTILE_SLOTS_CAPITAL = "idrinth_settlement_hostile_slots_capital";
local PANEL_BUTTON = "idrinth_settlement_panel_button";
local CONTEXT_SETTLEMENT = "CcoCampaignSettlement";

-- View names
local VIEW_DEFAULT = "default_view";
local VIEW_HOSTILE = "hostile_views";
local VIEW_DISCOVERED = "discovered_views";
local VIEW_ALLIED = "allied_view";

-- Button names
local BUTTON_DEFAULT = "button_default_view";
local BUTTON_ALLY = "button_ally_view";
local BUTTON_FOREIGN = "button_player_foreign_view";
local BUTTON_FOREIGN_TRAP = "button_player_foreign_trap_view";
local BUTTON_DISCOVERED = "button_discovered_view";

local BUTTON_NAMES = {
    BUTTON_DEFAULT,
    BUTTON_ALLY,
    BUTTON_FOREIGN,
    BUTTON_FOREIGN_TRAP,
    BUTTON_DISCOVERED,
    PANEL_BUTTON
};

local buttonToView = {
    [BUTTON_DEFAULT] = VIEW_DEFAULT,
    [BUTTON_ALLY] = VIEW_ALLIED,
    [BUTTON_FOREIGN] = VIEW_HOSTILE,
    [BUTTON_FOREIGN_TRAP] = VIEW_HOSTILE,
    [BUTTON_DISCOVERED] = VIEW_DISCOVERED,
    [PANEL_BUTTON] = HOSTILE_SLOTS,
};

--- Hides all view panels in the settlement view.
--- @param settlement userdata The settlement view UI component.
local hideAllViews = function(settlement)
    UIComponent(settlement:Find(VIEW_DEFAULT)):SetVisible(false);
    UIComponent(settlement:Find(VIEW_HOSTILE)):SetVisible(false);
    UIComponent(settlement:Find(VIEW_DISCOVERED)):SetVisible(false);
    UIComponent(settlement:Find(VIEW_ALLIED)):SetVisible(false);
    UIComponent(settlement:Find(HOSTILE_SLOTS)):SetVisible(false);
end;

--- Shows the view corresponding to a button click.
--- @param settlement userdata The settlement view UI component.
--- @param clickedButton string The name of the clicked button.
local showViewForButton = function(settlement, clickedButton)
    local viewName = buttonToView[clickedButton];
    if viewName then
        UIComponent(settlement:Find(viewName)):SetVisible(true);
    end;
end;

--- Sets up the foreign slot display UI for all settlements in the list.
local settlementForeignSlotDisplay = function()
    local parent = Idrinth.Ui.findElementWithin(SETTLEMENT_PANEL, SETTLEMENT_LIST);
    if not parent then
        return;
    end;
    Idrinth.Ui.forEachChild(parent, function(parentItem, index)
        local settlementSlots = Idrinth.Ui.findElementWithin(
            parentItem, SETTLEMENT_VIEW, VIEW_HOSTILE, "settlement_hostile_slots"
        );
        local settlement = Idrinth.Ui.findElementWithin(parentItem, SETTLEMENT_VIEW);
        if not settlement or not settlementSlots then
            return;
        end;
        local element;
        if index == 1 then
            element = Idrinth.Ui.createOrFind(HOSTILE_SLOTS, settlement, HOSTILE_SLOTS_CAPITAL);
        else
            element = Idrinth.Ui.createOrFind(HOSTILE_SLOTS, settlement);
        end;
        element:SetDockOffset(0, 25);
        element:SetContextObject(settlementSlots:GetContextObject(CONTEXT_SETTLEMENT));
        element:SetVisible(false);
        local buttons = Idrinth.Ui.findElementWithin(
            parentItem, SETTLEMENT_VIEW, "toggle_button_holder", "button_list"
        );
        local button = Idrinth.Ui.createOrFind(PANEL_BUTTON, buttons);
        button:SetContextObject(settlementSlots:GetContextObject(CONTEXT_SETTLEMENT));
    end);
end;
local lastClicked = "";

--- Counts the number of active (selected) buttons in a button list.
--- @param buttons userdata The button list UI component.
--- @return number The count of selected buttons.
local countActiveButtons = function(buttons)
    return Idrinth.Ui.countChildrenWhere(buttons, function(button)
        return button:VisibleFromRoot() and button:CurrentState() == "selected";
    end);
end;

--- Handles the case when no buttons are active by showing the default view.
--- @param settlement userdata The settlement view UI component.
local handleNoActiveButtons = function(settlement, buttons, clickedButton)
    hideAllViews(settlement);
    showViewForButton(settlement, clickedButton);
    UIComponent(buttons:Find(clickedButton)):SetState("selected");
end;

--- Handles the case when a single button is active.
--- @param settlement userdata The settlement view UI component.
--- @param clickedButton string The name of the clicked button.
local handleSingleActiveButton = function(settlement, clickedButton)
    hideAllViews(settlement);
    showViewForButton(settlement, clickedButton);
end;

--- Handles the case when multiple buttons are active.
--- @param settlement userdata The settlement view UI component.
--- @param buttons userdata The button list UI component.
--- @param clickedButton string The name of the clicked button.
local handleMultipleActiveButtons = function(settlement, buttons, clickedButton)
    if clickedButton == PANEL_BUTTON then
        Idrinth.Ui.forEachChild(buttons, function(button)
            if button:VisibleFromRoot() then
                button:SetState("active");
            end;
        end);
        UIComponent(buttons:Find(PANEL_BUTTON)):SetState("selected");
        hideAllViews(settlement);
        UIComponent(settlement:Find(HOSTILE_SLOTS)):SetVisible(true);
        return;
    end;
    UIComponent(buttons:Find(PANEL_BUTTON)):SetState("active");
    UIComponent(settlement:Find(HOSTILE_SLOTS)):SetVisible(false);
    showViewForButton(settlement, clickedButton);
end;

--- Updates the settlement view state based on which button was clicked.
--- @param clickedButton string The name of the clicked button.
local updateSettlementViewState = function(clickedButton)
    local parent = Idrinth.Ui.findElementWithin(SETTLEMENT_PANEL, SETTLEMENT_LIST);
    if not parent then
        return;
    end;
    Idrinth.Ui.forEachChild(parent, function(parentItem)
        local buttons = Idrinth.Ui.findElementWithin(
            parentItem, SETTLEMENT_VIEW, "toggle_button_holder", "button_list"
        );
        if not buttons then
            return false;
        end;
        local settlement = Idrinth.Ui.findElementWithin(parentItem, SETTLEMENT_VIEW);
        local activeButtons = countActiveButtons(buttons);
        if activeButtons == 0 then
            handleNoActiveButtons(settlement, buttons, clickedButton);
        elseif activeButtons == 1 then
            handleSingleActiveButton(settlement, clickedButton);
        else
            handleMultipleActiveButtons(settlement, buttons, clickedButton);
        end;
    end);
end;

Idrinth.Events.addListener(
    "ComponentLClickUp",
    function(context)
        if not Idrinth.Access.spawned() then
            return false;
        end;
        for _, name in pairs(BUTTON_NAMES) do
            if context.string == name then
                return true;
            end;
        end;
        return false;
    end,
    function(context)
        lastClicked = context.string;
        Idrinth.Ui.nowAndThen(
            function()
                updateSettlementViewState(lastClicked);
            end
        );
    end
);
Idrinth.Events.addListener(
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    function()
        settlementForeignSlotDisplay();
    end
);
Idrinth.Events.addListener(
    "PanelOpenedCampaign",
    Idrinth.Access.spawned,
    function()
        settlementForeignSlotDisplay();
    end
);
Idrinth.Events.addListener(
    "CampaignSettlementSelectedAny",
    Idrinth.Access.spawned,
    function()
        settlementForeignSlotDisplay();
    end
);
