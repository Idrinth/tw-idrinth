local getSelectedUnitsInfo = function()
    local units = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "units");
    if not units then
        return nil, nil, nil;
    end;
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local uiIds = {};
    for i = 1, units:ChildCount() do
        local unit = UIComponent(units:Find(i));
        if unit then
            local id = unit:GetContextObjectId("CcoCampaignUnit");
            if id then
                local uiId = common.get_context_value("CcoCampaignUnit", id, "UniqueUiId");
                if uiId and uiId ~= "" then
                    uiIds[uiId] = true;
                end;
            end;
        end;
    end;
    return units, character, uiIds;
end;
local lockVeterans = function(faction, lock)
    for num = 0, 9 do
        cm:faction_set_unit_purchasable_effect_lock_state(
            faction,
            "idrinth_veteran_"..num,
            "",
            lock
        );
    end;
end;
local applyVeteranRankToNewUnit = function(uiIds, expectedType, currentRank)
    return function()
        Idrinth.log("applyVeteranRankToNewUnit", "army");
        local unitsPanel = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "units");
        if not unitsPanel then
            return;
        end;
        for j = 1, unitsPanel:ChildCount() do
            local newUnit = UIComponent(unitsPanel:Find(j));
            if newUnit then
                local newId = newUnit:GetContextObjectId("CcoCampaignUnit");
                if newId then
                    local newType = common.get_context_value("CcoCampaignUnit", newId, "UnitRecordContext.Key");
                    local newUiId = common.get_context_value("CcoCampaignUnit", newId, "UniqueUiId");
                    if not uiIds[newUiId] and newType == expectedType then
                        local _, faction = Idrinth.Access.get();
                        lockVeterans(faction, false);
                        common.call_context_command("CcoCampaignUnit", newId, "Upgrade(DatabaseRecordContext(\"CcoUnitPurchasableEffectRecord\", \"idrinth_veteran_"..currentRank.."\"))");
                        lockVeterans(faction, true);
                        return;
                    end;
                end;
            end;
        end;
    end;
end;
local displayWAAAGHUpradePanel = function(blessingsPanel)
    if not cm:get_campaign_ui_manager():is_panel_open("units_panel") then
        set_component_visible_with_parent(false, core:get_ui_root(), "idrinth_units_panel_blessings");
        return;
    end;
    local landUnitCard = Idrinth.Ui.findElementWithin(blessingsPanel, "scrap_upgrades_list_box", "unit_card_parent", "land_unit_card");
    local upgrades = Idrinth.Ui.findElementWithin(blessingsPanel, "scrap_upgrades_list_box", "scrap_upgrades_parent", "list_clip", "list_box");
    local units = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "units");
    local selectedType = "";
    for i = 1, units:ChildCount() do
        local unit = UIComponent(units:Find(i));
        if unit and unit:CurrentState() == "selected" then
            local ccoCampaignUnit = unit:GetContextObject("CcoCampaignUnit");
            local currentType = common.get_context_value("CcoCampaignUnit", unit:GetContextObjectId("CcoCampaignUnit"), "CcoMainUnit.Key");
            landUnitCard:SetContextObject(ccoCampaignUnit);
            upgrades:SetContextObject(ccoCampaignUnit);
            if selectedType == "" then
                selectedType = currentType;
            elseif selectedType ~= currentType then
                unit:SetState("active");
            end;
        end;
    end;
end;
local upgradeUnit = function(god)
    local units, character, uiIds = getSelectedUnitsInfo();
    if not units then
        return;
    end;
    local factionKey = character:faction():name();
    for i = 1, units:ChildCount() do
        local unit = UIComponent(units:Find(i));
        if unit and (unit:CurrentState() == "selected_hover" or unit:CurrentState() == "selected") then
            local id = unit:GetContextObjectId("CcoCampaignUnit");
            if id then
                local currentType = common.get_context_value("CcoCampaignUnit", id, "UnitRecordContext.Key");
                local currentRank = common.get_context_value("CcoCampaignUnit", id, "ExperienceLevel");
                if currentType == "idrinth_hev_high_elf_vampires_chapel_mixed" and character:faction():treasury() >= 300 then
                    common.call_context_command("CcoCampaignUnit", id, "Disband");
                    cm:grant_unit_to_character(cm:char_lookup_str(character), "idrinth_hev_high_elf_vampires_chapel_"..god);
                    cm:treasury_mod(factionKey, -300);
                    cm:real_callback(applyVeteranRankToNewUnit(uiIds, "idrinth_hev_high_elf_vampires_chapel_"..god, currentRank), 150);
                    return;
                end;
            end;
        end;
    end;
end;
local upgradePriest = function(god)
    local units, character, uiIds = getSelectedUnitsInfo();
    if not units then
        return;
    end;
    local pooledResourceManager = character:faction():pooled_resource_manager();
    local factionKey = character:faction():name();
    for i = 1, units:ChildCount() do
        local unit = UIComponent(units:Find(i));
        if unit and (unit:CurrentState() == "selected_hover" or unit:CurrentState() == "selected") then
            local id = unit:GetContextObjectId("CcoCampaignUnit");
            if id then
                local currentType = common.get_context_value("CcoCampaignUnit", id, "UnitRecordContext.Key");
                local currentRank = common.get_context_value("CcoCampaignUnit", id, "ExperienceLevel");
                if currentType == "idrinth_hev_high_elf_vampires_chapel_"..god.."_leader" and character:faction():treasury() >= 1000 and pooledResourceManager:resource("idrinth_"..god):value() >= 250 then
                    common.call_context_command("CcoCampaignUnit", id, "Disband");
                    cm:treasury_mod(factionKey, -1000);
                    cm:faction_add_pooled_resource(factionKey, "idrinth_"..god, "idrinth_"..god.."_other", -250);
                    local randomNum = cm:random(100);
                    if randomNum < 15 + currentRank * 4 then
                        cm:grant_unit_to_character(cm:char_lookup_str(character), "idrinth_hev_high_elf_vampires_chapel_"..god.."_leader_vampire");
                        cm:real_callback(applyVeteranRankToNewUnit(uiIds, "idrinth_hev_high_elf_vampires_chapel_"..god.."_leader_vampire", currentRank), 150);
                    elseif randomNum < 45 + currentRank * 6 then
                        cm:grant_unit_to_character(cm:char_lookup_str(character), "idrinth_hev_high_elf_vampires_chapel_"..god.."_varghulf");
                        cm:real_callback(applyVeteranRankToNewUnit(uiIds, "idrinth_hev_high_elf_vampires_chapel_"..god.."_varghulf", currentRank), 150);
                    end;
                    return;
                end;
            end;
        end;
    end;
end;
local setTooltip = function(element, loc_key)
    element:SetTooltipText(common.get_localised_string(loc_key), loc_key, true);
end;
local handleUpgradeButtons = function()
    if not cm:get_campaign_ui_manager():is_panel_open("units_panel") then
        return;
    end;
    Idrinth.log("handleUpgradeButtons", "army");
    local buttonWrapper = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "button_group_unit");
    if not buttonWrapper then
        return;
    end;
    Idrinth.log("handleUpgradeButtons: building buttons", "army");
    local units = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "units");
    if not units then
        return;
    end;
    local selectedType = "";
    local hasMultipleTypes = false;
    for i = 1, units:ChildCount() do
        local unit = UIComponent(units:Find(i));
        if unit and (unit:CurrentState() == "selected_hover" or unit:CurrentState() == "selected") then
            local id = unit:GetContextObjectId("CcoCampaignUnit");
            if id then
                local currentType = common.get_context_value("CcoCampaignUnit", id, "UnitRecordContext.Key");
                if currentType then
                    if selectedType == "" then
                        selectedType = currentType;
                    elseif selectedType ~= currentType then
                        hasMultipleTypes = true;
                    end;
                end;
            end;
        end;
    end;
    if not selectedType or selectedType == "" then
        return;
    end;
    if hasMultipleTypes then
        Idrinth.log("Selected multiple unit types", "army");
        return;
    end;
    Idrinth.log("Selected: "..tostring(selectedType), "army");
    local asuryanPriestUpgrade = Idrinth.Ui.createOrFind("idrinth_button_upgrade_asuryan_priest", buttonWrapper, "idrinth_button_upgrade_asuryan");
    local khainePriestUpgrade = Idrinth.Ui.createOrFind("idrinth_button_upgrade_khaine_priest", buttonWrapper, "idrinth_button_upgrade_khaine");
    local kurnousPriestUpgrade = Idrinth.Ui.createOrFind("idrinth_button_upgrade_kurnous_priest", buttonWrapper, "idrinth_button_upgrade_kurnous");
    local asuryanTroopsUpgrade = Idrinth.Ui.createOrFind("idrinth_button_upgrade_asuryan_troops", buttonWrapper, "idrinth_button_upgrade_asuryan");
    local khaineTroopsUpgrade = Idrinth.Ui.createOrFind("idrinth_button_upgrade_khaine_troops", buttonWrapper, "idrinth_button_upgrade_khaine");
    local kurnousTroopsUpgrade = Idrinth.Ui.createOrFind("idrinth_button_upgrade_kurnous_troops", buttonWrapper, "idrinth_button_upgrade_kurnous");
    Idrinth.log("UI built", "army");
    asuryanPriestUpgrade:SetVisible(false);
    khainePriestUpgrade:SetVisible(false);
    kurnousPriestUpgrade:SetVisible(false);
    asuryanTroopsUpgrade:SetVisible(false);
    khaineTroopsUpgrade:SetVisible(false);
    kurnousTroopsUpgrade:SetVisible(false);
    if selectedType == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader" then
        asuryanPriestUpgrade:SetVisible(true);
        setTooltip(asuryanPriestUpgrade, "upgrade_tooltips_idrinth_priest_asuryan");
    elseif selectedType == "idrinth_hev_high_elf_vampires_chapel_khaine_leader" then
        khainePriestUpgrade:SetVisible(true);
        setTooltip(khainePriestUpgrade, "upgrade_tooltips_idrinth_priest_khaine");
    elseif selectedType == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader" then
        kurnousPriestUpgrade:SetVisible(true);
        setTooltip(kurnousPriestUpgrade, "upgrade_tooltips_idrinth_priest_kurnous");
    elseif selectedType == "idrinth_hev_high_elf_vampires_chapel_mixed" then
        asuryanTroopsUpgrade:SetVisible(true);
        setTooltip(asuryanTroopsUpgrade, "upgrade_tooltips_idrinth_unit_asuryan");
        khaineTroopsUpgrade:SetVisible(true);
        setTooltip(khaineTroopsUpgrade, "upgrade_tooltips_idrinth_unit_khaine");
        kurnousTroopsUpgrade:SetVisible(true);
        setTooltip(kurnousTroopsUpgrade, "upgrade_tooltips_idrinth_unit_kurnous");
    end;
end;
local enableWAAAGHUpgrades = function()
    if not cm:get_campaign_ui_manager():is_panel_open("units_panel") then
        return;
    end;
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local idrinth = Idrinth.Access.get();
    if character == idrinth then
        local parent = Idrinth.Ui.findElementWithin("hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        if not parent then
            return;
        end;
        Idrinth.Ui.createOrFind("idrinth_units_panel_blessings_button", parent);
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button");
        set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "tabgroup", "tab_horde_buildings");
        set_component_visible_with_parent(false, core:get_ui_root(), "units_panel", "main_units_panel", "unit_count_frame_holder", "frame");
        set_component_visible_with_parent(true, core:get_ui_root(), "units_panel", "main_units_panel", "icon_list", "dy_upkeep");
        local dyTxt = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "header", "button_focus", "dy_txt");
        if dyTxt then
            dyTxt:SetText("Knight-Scholar Idrinth Thalui");
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "horde_growth");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "equipment");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "subpanel_effect_bundles");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "info_panel_holder", "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent", "rank");
    end;
end;
local enableArmyUpgrades = function()
    if not cm:get_campaign_ui_manager():is_panel_open("units_panel") then
        return;
    end;
    set_component_visible_with_parent(false, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button");
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local idrinth = Idrinth.Access.get();
    if character == idrinth then
        local parent = Idrinth.Ui.findElementWithin("hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
        if not parent then
            return;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel");
        set_component_visible_with_parent(true, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army");
    end;
end;
local applyVeteranRankToCreatedUnit = function(unitKey, faction)
    return function()
        Idrinth.log("applyVeteranRankToCreatedUnit", "army");
        local unitsPanel = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "units");
        if not unitsPanel then
            lockVeterans(faction, true);
            return;
        end;
        for j = 1, unitsPanel:ChildCount() do
            local unit = UIComponent(unitsPanel:Find(j));
            if unit then
                local id = unit:GetContextObjectId("CcoCampaignUnit");
                if id then
                    local unitType = common.get_context_value("CcoCampaignUnit", id, "UnitRecordContext.Key");
                    if unitType == unitKey then
                        local currentRank = common.get_context_value("CcoCampaignUnit", id, "ExperienceLevel");
                        if currentRank == 0 then
                            common.call_context_command("CcoCampaignUnit", id, "Upgrade(DatabaseRecordContext(\"CcoUnitPurchasableEffectRecord\", \"idrinth_veteran_0\"))");
                            Idrinth.log("Added idrinth_veteran_0 to new unit via UI context", "army");
                            lockVeterans(faction, true);
                            return;
                        end;
                    end;
                end;
            end;
        end;
        lockVeterans(faction, true);
    end;
end;
core:add_listener(
    "idrinth_army_UnitCreated",
    "UnitCreated",
    function(context)
        return context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_asuryan_leader_vampire" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_kurnous_leader_vampire" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_khaine_leader_vampire" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_asuryan" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_kurnous" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_khaine" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_asuryan_varghulf" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_kurnous_varghulf" or context:unit():unit_key() == "idrinth_hev_high_elf_vampires_chapel_khaine_varghulf";
    end,
    function(context)
        Idrinth.log("UnitCreated", "army");
        local faction = context:unit():faction();
        local unitKey = context:unit():unit_key();
        lockVeterans(faction, false);
        cm:real_callback(applyVeteranRankToCreatedUnit(unitKey, faction), 150);
    end,
    true
)
core:add_listener(
    "idrinth_army_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth and not idrinth:is_wounded() and idrinth:has_military_force() and not idrinth:is_carrying_troops();
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "army");
        local idrinth = Idrinth.Access.get();
        cm:spawn_transported_force_at_military_force(idrinth:military_force():command_queue_index(), "idrinth_hev_high_elf_vampires_idrinth_support", 1);
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp",
    "ComponentLClickUp",
    function(context)
        return context.string == "tab_transported_army";
    end,
    function(context)
        Idrinth.log("ComponentLClickUp", "army");
        Idrinth.Ui.nowAndThen(enableWAAAGHUpgrades);
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_2",
    "ComponentLClickUp",
    function(context)
        return context.string == "tab_army";
    end,
    function(context)
        Idrinth.log("ComponentLClickUp", "army");
        Idrinth.Ui.nowAndThen(enableArmyUpgrades);
        Idrinth.Ui.nowAndThen(handleUpgradeButtons);
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_3",
    "ComponentLClickUp",
    function(context)
        return context.string == "idrinth_units_panel_blessings_button";
    end,
    function(context)
        Idrinth.log("ComponentLClickUp", "army");
        local blessingsPanel = Idrinth.Ui.createOrFind("idrinth_units_panel_blessings", core:get_ui_root());
        if blessingsPanel:Visible() then
            set_component_visible_with_parent(false, core:get_ui_root(), "idrinth_units_panel_blessings");
            return;
        end;
        set_component_visible_with_parent(true, core:get_ui_root(), "idrinth_units_panel_blessings");
        blessingsPanel:SetDockOffset(0, -275);-- 275 up
        Idrinth.Ui.nowAndThen(function()
            displayWAAAGHUpradePanel(blessingsPanel);
        end);
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_4",
    "ComponentLClickUp",
    true,
    function(context)
        Idrinth.log("ComponentLClickUp", "army");
        Idrinth.Ui.nowAndThen(handleUpgradeButtons);
        local blessingsPanel = Idrinth.Ui.findElementWithin("idrinth_units_panel_blessings");
        if not blessingsPanel or not blessingsPanel:Visible() then
            return;
        end;
        Idrinth.Ui.nowAndThen(function()
            displayWAAAGHUpradePanel(blessingsPanel);
        end);
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_5",
    "ComponentLClickUp",
    function(context)
        return context.string == "idrinth_button_upgrade_kurnous_troops"
    end,
    function(context)
        upgradeUnit("kurnous");
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_6",
    "ComponentLClickUp",
    function(context)
        return context.string == "idrinth_button_upgrade_asuryan_troops"
    end,
    function(context)
        upgradeUnit("asuryan");
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_7",
    "ComponentLClickUp",
    function(context)
        return context.string == "idrinth_button_upgrade_khaine_troops"
    end,
    function(context)
        upgradeUnit("khaine");
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_8",
    "ComponentLClickUp",
    function(context)
        return context.string == "idrinth_button_upgrade_kurnous_priest"
    end,
    function(context)
        upgradePriest("kurnous");
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_9",
    "ComponentLClickUp",
    function(context)
        return context.string == "idrinth_button_upgrade_asuryan_priest"
    end,
    function(context)
        upgradePriest("asuryan");
    end,
    true
);
core:add_listener(
    "idrinth_army_ComponentLClickUp_10",
    "ComponentLClickUp",
    function(context)
        return context.string == "idrinth_button_upgrade_khaine_priest"
    end,
    function(context)
        upgradePriest("khaine");
    end,
    true
);
core:add_listener(
    "idrinth_army_PanelOpenedCampaign",
    "PanelOpenedCampaign",
    function(context)
        return context.string == "units_panel";
    end,
    function(context)
        Idrinth.log("PanelOpenedCampaign", "army");
        set_component_visible_with_parent(false, core:get_ui_root(), "hud_campaign", "hud_center_docker", "hud_center", "small_bar", "button_subpanel_parent", "button_subpanel", "button_group_army", "idrinth_units_panel_blessings_button");
        Idrinth.Ui.nowAndThen(handleUpgradeButtons);
    end,
    true
);
cm:add_first_tick_callback(                                                                       
    function()
        lockVeterans(cm:get_local_faction(), true);
    end
);
