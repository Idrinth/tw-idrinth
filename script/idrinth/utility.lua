IdrinthUtility = {};
IdrinthUtility.loadMCTSettings = function(context)
    Idrinth._hasModConfig = true;

    local my_mod = context:mct():get_mod_by_key("idrinth")

    Idrinth._expandedCulturesActive = my_mod:get_option_by_key("expanded_spawn"):get_finalized_setting()

    Idrinth._unlockLevelAdjustment = Idrinth._levelAdjustment[my_mod:get_option_by_key("level_adjustment"):get_finalized_setting()]

    Idrinth._dilemmaCooldownMode = my_mod:get_option_by_key("dilemma_cooldown"):get_finalized_setting()

    Idrinth._enableChapels = my_mod:get_option_by_key("chapels"):get_finalized_setting()

    Idrinth._enableStoryEvents = my_mod:get_option_by_key("story_events"):get_finalized_setting()

    Idrinth._godBlessedItemRequirements = my_mod:get_option_by_key("god_item_difficulty"):get_finalized_setting()

    Idrinth._enableRenaming = my_mod:get_option_by_key("names"):get_finalized_setting()
    
    Idrinth._enableLogging = my_mod:get_option_by_key("logging"):get_finalized_setting();
end;
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
IdrinthUtility.createResourceUI = function()
    local parent = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
    log("IDRINTH DEBUG: ===== CREATING UI =====");
    core:get_or_create_component(
        "idrinth_pooled_resource_asuryan",
        "ui/idrinth/idrinth_pooled_resource_asuryan.twui.xml",
        parent
    );
    core:get_or_create_component(
        "idrinth_pooled_resource_kurnous",
        "ui/idrinth/idrinth_pooled_resource_kurnous.twui.xml",
        parent
    );
    core:get_or_create_component(
        "idrinth_pooled_resource_khaine",
        "ui/idrinth/idrinth_pooled_resource_khaine.twui.xml",
        parent
    );
end;
IdrinthUtility.getIdrinthFromFaction = function(faction)
    local idrinthChampion = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth._type, Idrinth._subtype .. Idrinth._type);
    if idrinthChampion then
        return idrinthChampione;
    end;
    local idrinthGeneral = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth._type2, Idrinth._subtype .. Idrinth._type2);
    if idrinthGeneral then
        return idrinthGeneral;
    end;
    return nil;
end;
lua_start_time = os.clock();
file = io.open("idrinth." .. os.date("%y%m%d%H%M") .. ".log", "a");
IdrinthUtility.log = function(thing, logtype)
    out(thing);
    if not Idrinth._enableLogging then
        return;
    end;
    if not file then
        return;
    end;
    local str_from_script = tostring(thing) or "";
    local timestamp = "<" .. string.format("%.1f", os.clock() - lua_start_time) .. "s>";
    local output_str_table = {timestamp, string.format("%" .. (11 - string.len(timestamp)) .."s", " ")};
    table.insert(output_str_table, str_from_script);
    local output_str = table.concat(output_str_table);
    if not logtype then
        logtype = "base";
    end;
    file:write("[" .. logtype .. "] " .. output_str .. "\n");
end;