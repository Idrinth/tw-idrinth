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

local hideAllViews = function(settlement)
    UIComponent(settlement:Find(VIEW_DEFAULT)):SetVisible(false);
    UIComponent(settlement:Find(VIEW_HOSTILE)):SetVisible(false);
    UIComponent(settlement:Find(VIEW_DISCOVERED)):SetVisible(false);
    UIComponent(settlement:Find(VIEW_ALLIED)):SetVisible(false);
    UIComponent(settlement:Find(HOSTILE_SLOTS)):SetVisible(false);
end;

local showViewForButton = function(settlement, clickedButton)
    local viewName = buttonToView[clickedButton];
    if viewName then
        UIComponent(settlement:Find(viewName)):SetVisible(true);
    end;
end;

local settlementForeignSlotDisplay = function()
    local parent = Idrinth.Ui.findElementWithin(SETTLEMENT_PANEL, SETTLEMENT_LIST);
    if not parent then
        return;
    end;
    for i = 1, parent:ChildCount() do
        local parentItem = UIComponent(parent:Find(i));
        local settlementSlots = Idrinth.Ui.findElementWithin(
            parentItem, SETTLEMENT_VIEW, VIEW_HOSTILE, "settlement_hostile_slots"
        );
        local settlement = Idrinth.Ui.findElementWithin(parentItem, SETTLEMENT_VIEW);
        if settlement and settlementSlots then
            local element;
            if i == 1 then
                element = Idrinth.Ui.createOrFind(HOSTILE_SLOTS, settlement, HOSTILE_SLOTS_CAPITAL);
            else
                element = Idrinth.Ui.createOrFind(HOSTILE_SLOTS, settlement);
            end;
            element:SetDockOffset(0, 25);-- 25 down
            element:SetContextObject(settlementSlots:GetContextObject(CONTEXT_SETTLEMENT));
            element:SetVisible(false);
            local buttons = Idrinth.Ui.findElementWithin(
                UIComponent(parent:Find(i)), SETTLEMENT_VIEW, "toggle_button_holder", "button_list"
            );
            local button = Idrinth.Ui.createOrFind(PANEL_BUTTON, buttons);
            button:SetContextObject(settlementSlots:GetContextObject(CONTEXT_SETTLEMENT));
        end;
    end;
end;
local lastClicked = "";
local countActiveButtons = function(buttons)
    local count = 0;
    for j = 1, buttons:ChildCount() do
        local button = UIComponent(buttons:Find(j));
        if button:VisibleFromRoot() and button:CurrentState() == "selected" then
            count = count + 1;
        end;
    end;
    return count;
end;

local handleNoActiveButtons = function(settlement)
    hideAllViews(settlement);
    UIComponent(settlement:Find(VIEW_DEFAULT)):SetVisible(true);
    UIComponent(BUTTON_DEFAULT):SetState("selected");
end;

local handleSingleActiveButton = function(settlement, clickedButton)
    hideAllViews(settlement);
    showViewForButton(settlement, clickedButton);
end;

local handleMultipleActiveButtons = function(settlement, buttons, clickedButton)
    if clickedButton == PANEL_BUTTON then
        for j = 1, buttons:ChildCount() do
            if UIComponent(buttons:Find(j)):VisibleFromRoot() then
                UIComponent(buttons:Find(j)):SetState("active");
            end;
        end;
        UIComponent(buttons:Find(PANEL_BUTTON)):SetState("selected");
        hideAllViews(settlement);
        UIComponent(settlement:Find(HOSTILE_SLOTS)):SetVisible(true);
        return;
    end;
    UIComponent(buttons:Find(PANEL_BUTTON)):SetState("active");
    UIComponent(settlement:Find(HOSTILE_SLOTS)):SetVisible(false);
    showViewForButton(settlement, clickedButton);
end;

local updateSettlementViewState = function(clickedButton)
    local parent = Idrinth.Ui.findElementWithin(SETTLEMENT_PANEL, SETTLEMENT_LIST);
    if not parent then
        return;
    end;
    for i = 1, parent:ChildCount() do
        local buttons = Idrinth.Ui.findElementWithin(
            UIComponent(parent:Find(i)), SETTLEMENT_VIEW, "toggle_button_holder", "button_list"
        );
        if not buttons then
            return;
        end;
        local settlement = Idrinth.Ui.findElementWithin(UIComponent(parent:Find(i)), SETTLEMENT_VIEW);
        local activeButtons = countActiveButtons(buttons);
        if activeButtons == 0 then
            handleNoActiveButtons(settlement);
        elseif activeButtons == 1 then
            handleSingleActiveButton(settlement, clickedButton);
        else
            handleMultipleActiveButtons(settlement, buttons, clickedButton);
        end;
    end;
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
