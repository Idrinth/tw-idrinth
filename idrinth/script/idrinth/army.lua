local vampireChance = "normal";
local enableAnimalWAAAGH = true;
local vampireChances = {
    low = 10,
    normal = 15,
    high = 20,
};

-- File-local constants for repeated strings
local UNIT_CONTEXT = "CcoCampaignUnit";
local STATE_SELECTED = "selected";
local STATE_SELECTED_HOVER = "selected_hover";
local CALLBACK_DELAY = 150;
local VETERAN_PREFIX = "idrinth_veteran_";
local CHAPEL_PREFIX = "idrinth_hev_high_elf_vampires_chapel_";
local UPGRADE_EFFECT_RECORD = "CcoUnitPurchasableEffectRecord";
Idrinth.Events.addListener(
    "army",
    "MctInitialized",
    true,
    function()
        enableAnimalWAAAGH = Idrinth.Mct.get("animal_waaagh");
        vampireChance = Idrinth.Mct.get("vampire_chance");
    end
);
Idrinth.Events.addListener(
    "army",
    "MctFinalized",
    true,
    function()
        enableAnimalWAAAGH = Idrinth.Mct.get("animal_waaagh");
        vampireChance = Idrinth.Mct.get("vampire_chance");
    end
);
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
            local id = unit:GetContextObjectId(UNIT_CONTEXT);
            if id then
                local uiId = common.get_context_value(UNIT_CONTEXT, id, "UniqueUiId");
                if uiId and uiId ~= "" then
                    uiIds[uiId] = true;
                end;
            end;
        end;
    end;
    return units, character, uiIds;
end;
local lockVeterans = function(faction, lock)
    if lock then
        cm:callback(
            function()
                for num = 0, 9 do
                    cm:faction_set_unit_purchasable_effect_lock_state(
                        faction,
                        VETERAN_PREFIX..num,
                        "",
                        true
                    );
                end;
            end,
            1
        );
    end;
    for num = 0, 9 do
        cm:faction_set_unit_purchasable_effect_lock_state(
            faction,
            VETERAN_PREFIX..num,
            "",
            false
        );
    end;
end;
local godFavourBlessings = {
    [CHAPEL_PREFIX.."cave_bats"] = {
        asuryan = "idrinth_asuryan_god_favour_cave_bats",
        kurnous = "idrinth_kurnous_god_favour_cave_bats",
        khaine = "idrinth_khaine_god_favour_cave_bats",
    },
    [CHAPEL_PREFIX.."wolves"] = {
        asuryan = "idrinth_asuryan_god_favour_wolves",
        kurnous = "idrinth_kurnous_god_favour_wolves",
        khaine = "idrinth_khaine_god_favour_wolves",
    },
    [CHAPEL_PREFIX.."hawks"] = {
        asuryan = "idrinth_asuryan_god_favour_hawks",
        kurnous = "idrinth_kurnous_god_favour_hawks",
        khaine = "idrinth_khaine_god_favour_hawks",
    },
    [CHAPEL_PREFIX.."great_eagle"] = {
        asuryan = "idrinth_asuryan_god_favour_great_eagles",
        kurnous = "idrinth_kurnous_god_favour_great_eagles",
        khaine = "idrinth_khaine_god_favour_great_eagles",
    },
};
local lockAnimalBlessings = function(faction, lock)
    if lock then
        cm:callback(
            function()
                for _, blessings in pairs(godFavourBlessings) do
                    for _, blessing in pairs(blessings) do
                        cm:faction_set_unit_purchasable_effect_lock_state(
                            faction,
                            blessing,
                            "",
                            true
                        );
                    end;
                end;
            end,
            1
        );
    end;
    for _, blessings in pairs(godFavourBlessings) do
        for _, blessing in pairs(blessings) do
            cm:faction_set_unit_purchasable_effect_lock_state(
                faction,
                blessing,
                "",
                false
            );
        end;
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
                local newId = newUnit:GetContextObjectId(UNIT_CONTEXT);
                if newId then
                    local newType = common.get_context_value(UNIT_CONTEXT, newId, "UnitRecordContext.Key");
                    local newUiId = common.get_context_value(UNIT_CONTEXT, newId, "UniqueUiId");
                    if not uiIds[newUiId] and newType == expectedType then
                        local _, faction = Idrinth.Access.get();
                        lockVeterans(faction, false);
                        if is_string(currentRank) then
                            local upgradeCmd = "Upgrade(DatabaseRecordContext("
                                .. "\"" .. UPGRADE_EFFECT_RECORD .. "\", \"" .. currentRank .. "\"))";
                            common.call_context_command(UNIT_CONTEXT, newId, upgradeCmd);
                        else
                            local upgradeCmd = "Upgrade(DatabaseRecordContext("
                                .. "\"" .. UPGRADE_EFFECT_RECORD .. "\", \"" .. VETERAN_PREFIX
                                .. currentRank .. "\"))";
                            common.call_context_command(UNIT_CONTEXT, newId, upgradeCmd);
                        end;
                        lockVeterans(faction, true);
                        return;
                    end;
                end;
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
        if unit and (unit:CurrentState() == STATE_SELECTED_HOVER or unit:CurrentState() == STATE_SELECTED) then
            local id = unit:GetContextObjectId(UNIT_CONTEXT);
            if id then
                local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
                local currentRank = common.get_context_value(UNIT_CONTEXT, id, "ExperienceLevel");
                local price = 300 + 50 * currentRank;
                if currentType == CHAPEL_PREFIX.."mixed" and character:faction():treasury() >= price then
                    common.call_context_command(UNIT_CONTEXT, id, "Disband");
                    cm:grant_unit_to_character(cm:char_lookup_str(character), CHAPEL_PREFIX..god);
                    cm:treasury_mod(factionKey, 0 - price);
                    cm:faction_add_pooled_resource(factionKey, "idrinth_"..god, "idrinth_"..god.."_other", currentRank * currentRank);
                    cm:real_callback(applyVeteranRankToNewUnit(uiIds, CHAPEL_PREFIX..god, currentRank), CALLBACK_DELAY);
                    return;
                end;
            end;
        end;
    end;
end;
local lastXPRank = 0;
local upgradeSize = function()
    local units, character, uiIds = getSelectedUnitsInfo();
    if not units then
        return;
    end;
    local factionKey = character:faction():name();
    for i = 1, units:ChildCount() do
        local unit = UIComponent(units:Find(i));
        if unit and (unit:CurrentState() == STATE_SELECTED_HOVER or unit:CurrentState() == STATE_SELECTED) then
            local id = unit:GetContextObjectId(UNIT_CONTEXT);
            if id then
                local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
                local currentRank = common.get_context_value(UNIT_CONTEXT, id, "ExperienceLevel");
                local currentVeteranRank = 0;
                local hasNoEffect = common.get_context_value(UNIT_CONTEXT, id, "PurchasedEffectsList.IsEmpty");
                if not hasNoEffect then
                    currentVeteranRank = common.get_context_value(UNIT_CONTEXT, id, "PurchasedEffectsList.At(0).Key");
                end;
                local infantryPrice = 300;
                local cavalryPrice = 250;
                if character:faction():treasury() >= infantryPrice then
                    for _, god in pairs(Idrinth.Constants.GodList) do
                        local chapelType = CHAPEL_PREFIX .. god;
                        local largeType = chapelType .. "_large";
                        if currentType == chapelType and character:faction():treasury() >= infantryPrice then
                            common.call_context_command(UNIT_CONTEXT, id, "Disband");
                            lastXPRank = currentRank;
                            cm:grant_unit_to_character(cm:char_lookup_str(character), largeType);
                            cm:treasury_mod(factionKey, 0 - infantryPrice);
                            cm:real_callback(
                                applyVeteranRankToNewUnit(uiIds, largeType, currentVeteranRank),
                                CALLBACK_DELAY
                            );
                            return;
                        end;
                    end;
                end;
                local outridersType = CHAPEL_PREFIX.."outriders";
                if currentType == outridersType and character:faction():treasury() >= cavalryPrice then
                    common.call_context_command(UNIT_CONTEXT, id, "Disband");
                    lastXPRank = currentRank;
                    cm:grant_unit_to_character(
                        cm:char_lookup_str(character),
                        outridersType .. "_large"
                    );
                    cm:treasury_mod(factionKey, 0 - cavalryPrice);
                    return;
                end;
            end;
        end;
    end;
end;
local upgradeAnimal = function(god)
    local units, character = getSelectedUnitsInfo();
    if not units then
        return;
    end;
    for i = 1, units:ChildCount() do
        local unit = UIComponent(units:Find(i));
        if unit and (unit:CurrentState() == STATE_SELECTED_HOVER or unit:CurrentState() == STATE_SELECTED) then
            local id = unit:GetContextObjectId(UNIT_CONTEXT);
            if id then
                local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
                if godFavourBlessings[currentType] and godFavourBlessings[currentType][god] then
                    lockAnimalBlessings(character:faction(), false);
                    local blessing = godFavourBlessings[currentType][god];
                    local upgradeCmd = "Upgrade(DatabaseRecordContext("
                        .. "\"" .. UPGRADE_EFFECT_RECORD .. "\", \"" .. blessing .. "\"))";
                    common.call_context_command(UNIT_CONTEXT, id, upgradeCmd);
                    lockAnimalBlessings(character:faction(), true);
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
        if unit and (unit:CurrentState() == STATE_SELECTED_HOVER or unit:CurrentState() == STATE_SELECTED) then
            local id = unit:GetContextObjectId(UNIT_CONTEXT);
            if id then
                local currentType = common.get_context_value(
                    UNIT_CONTEXT, id, "UnitRecordContext.Key"
                );
                local currentRank = common.get_context_value(
                    UNIT_CONTEXT, id, "ExperienceLevel"
                );
                local leaderType = CHAPEL_PREFIX .. god .. "_leader";
                local godResource = "idrinth_" .. god;
                local hasEnoughTreasury = character:faction():treasury() >= 1000;
                local hasEnoughResource = pooledResourceManager:resource(godResource):value() >= 250;
                if currentType == leaderType and hasEnoughTreasury and hasEnoughResource then
                    common.call_context_command(UNIT_CONTEXT, id, "Disband");
                    cm:treasury_mod(factionKey, -1000);
                    cm:faction_add_pooled_resource(
                        factionKey, godResource, godResource .. "_other", -250
                    );
                    local randomNum = cm:random(100);
                    local vampireType = leaderType .. "_vampire";
                    local varghulfType = CHAPEL_PREFIX .. god .. "_varghulf";
                    if randomNum < vampireChances[vampireChance] + currentRank * 4 then
                        cm:grant_unit_to_character(cm:char_lookup_str(character), vampireType);
                        cm:real_callback(
                            applyVeteranRankToNewUnit(uiIds, vampireType, currentRank), CALLBACK_DELAY
                        );
                    elseif randomNum < 3 * vampireChances[vampireChance] + currentRank * 6 then
                        cm:grant_unit_to_character(cm:char_lookup_str(character), varghulfType);
                        cm:real_callback(
                            applyVeteranRankToNewUnit(uiIds, varghulfType, currentRank), CALLBACK_DELAY
                        );
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
    for i = 0, units:ChildCount() - 1 do
        local unit = UIComponent(units:Find(i));
        if unit and (unit:CurrentState() == STATE_SELECTED_HOVER or unit:CurrentState() == STATE_SELECTED) then
            local id = unit:GetContextObjectId(UNIT_CONTEXT);
            if id then
                local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
                if currentType then
                    if selectedType == "" then
                        selectedType = currentType;
                    elseif selectedType ~= currentType then
                        hasMultipleTypes = true;
                    end;
                end;
            end;
        end;
        if unit then
            local id = unit:GetContextObjectId(UNIT_CONTEXT);
            if id then
                local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
                if Idrinth.Unittypes.isBlessedAnimal(currentType) then
                    local cardHolder = UIComponent(unit:Find("card_image_holder"));
                    local icon = UIComponent(cardHolder:Find("upgrade_effect_icon"));
                    local waaagh = UIComponent(cardHolder:Find("waaagh_unit_marker"));
                    waaagh:SetVisible(false);
                    local hasNoEffect = common.get_context_value(
                        UNIT_CONTEXT, id, "PurchasedEffectsList.IsEmpty"
                    );
                    if not hasNoEffect then
                        icon:SetVisible(true);
                        local iconPath = common.get_context_value(
                            UNIT_CONTEXT, id,
                            "PurchasedEffectsList.At(0).EffectBundleContext.IconPath"
                        );
                        icon:SetImagePath(iconPath);
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
    local asuryanPriestUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_asuryan_priest", buttonWrapper, "idrinth_button_upgrade_asuryan"
    );
    local khainePriestUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_khaine_priest", buttonWrapper, "idrinth_button_upgrade_khaine"
    );
    local kurnousPriestUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_kurnous_priest", buttonWrapper, "idrinth_button_upgrade_kurnous"
    );
    local asuryanTroopsUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_asuryan_troops", buttonWrapper, "idrinth_button_upgrade_asuryan"
    );
    local khaineTroopsUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_khaine_troops", buttonWrapper, "idrinth_button_upgrade_khaine"
    );
    local kurnousTroopsUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_kurnous_troops", buttonWrapper, "idrinth_button_upgrade_kurnous"
    );
    local asuryanAnimalsUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_asuryan_animals", buttonWrapper, "idrinth_button_upgrade_asuryan"
    );
    local khaineAnimalsUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_khaine_animals", buttonWrapper, "idrinth_button_upgrade_khaine"
    );
    local kurnousAnimalsUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_kurnous_animals", buttonWrapper, "idrinth_button_upgrade_kurnous"
    );
    local sizeUpgrade = Idrinth.Ui.createOrFind(
        "idrinth_button_upgrade_size", buttonWrapper, "idrinth_button_upgrade_size"
    );
    Idrinth.log("UI built", "army");
    asuryanPriestUpgrade:SetVisible(false);
    khainePriestUpgrade:SetVisible(false);
    kurnousPriestUpgrade:SetVisible(false);
    asuryanTroopsUpgrade:SetVisible(false);
    khaineTroopsUpgrade:SetVisible(false);
    kurnousTroopsUpgrade:SetVisible(false);
    asuryanAnimalsUpgrade:SetVisible(false);
    khaineAnimalsUpgrade:SetVisible(false);
    kurnousAnimalsUpgrade:SetVisible(false);
    sizeUpgrade:SetVisible(false);
    if selectedType == CHAPEL_PREFIX.."asuryan_leader" then
        asuryanPriestUpgrade:SetVisible(true);
        setTooltip(asuryanPriestUpgrade, "upgrade_tooltips_idrinth_priest_asuryan");
    elseif selectedType == CHAPEL_PREFIX.."khaine_leader" then
        khainePriestUpgrade:SetVisible(true);
        setTooltip(khainePriestUpgrade, "upgrade_tooltips_idrinth_priest_khaine");
    elseif selectedType == CHAPEL_PREFIX.."kurnous_leader" then
        kurnousPriestUpgrade:SetVisible(true);
        setTooltip(kurnousPriestUpgrade, "upgrade_tooltips_idrinth_priest_kurnous");
    elseif selectedType == CHAPEL_PREFIX.."mixed" then
        asuryanTroopsUpgrade:SetVisible(true);
        setTooltip(asuryanTroopsUpgrade, "upgrade_tooltips_idrinth_unit_asuryan");
        khaineTroopsUpgrade:SetVisible(true);
        setTooltip(khaineTroopsUpgrade, "upgrade_tooltips_idrinth_unit_khaine");
        kurnousTroopsUpgrade:SetVisible(true);
        setTooltip(kurnousTroopsUpgrade, "upgrade_tooltips_idrinth_unit_kurnous");
    elseif selectedType == CHAPEL_PREFIX.."wolves" then
        asuryanAnimalsUpgrade:SetVisible(true);
        setTooltip(asuryanAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_asuryan_wolves");
        khaineAnimalsUpgrade:SetVisible(true);
        setTooltip(khaineAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_khaine_wolves");
        kurnousAnimalsUpgrade:SetVisible(true);
        setTooltip(kurnousAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_kurnous_wolves");
    elseif selectedType == CHAPEL_PREFIX.."cave_bats" then
        asuryanAnimalsUpgrade:SetVisible(true);
        setTooltip(asuryanAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_asuryan_bats");
        khaineAnimalsUpgrade:SetVisible(true);
        setTooltip(khaineAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_khaine_bats");
        kurnousAnimalsUpgrade:SetVisible(true);
        setTooltip(kurnousAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_kurnous_bats");
    elseif selectedType == CHAPEL_PREFIX.."hawks" then
        asuryanAnimalsUpgrade:SetVisible(true);
        setTooltip(asuryanAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_asuryan_hawks");
        khaineAnimalsUpgrade:SetVisible(true);
        setTooltip(khaineAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_khaine_hawks");
        kurnousAnimalsUpgrade:SetVisible(true);
        setTooltip(kurnousAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_kurnous_hawks");
    elseif selectedType == CHAPEL_PREFIX.."great_eagle" then
        asuryanAnimalsUpgrade:SetVisible(true);
        setTooltip(asuryanAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_asuryan_eagle");
        khaineAnimalsUpgrade:SetVisible(true);
        setTooltip(khaineAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_khaine_eagle");
        kurnousAnimalsUpgrade:SetVisible(true);
        setTooltip(kurnousAnimalsUpgrade, "upgrade_tooltips_idrinth_animal_kurnous_eagle");
    elseif selectedType == CHAPEL_PREFIX.."asuryan" then
        sizeUpgrade:SetVisible(true);
        setTooltip(asuryanAnimalsUpgrade, "upgrade_tooltips_idrinth_size_asuryan");
    elseif selectedType == CHAPEL_PREFIX.."khaine" then
        sizeUpgrade:SetVisible(true);
        setTooltip(asuryanAnimalsUpgrade, "upgrade_tooltips_idrinth_size_khaine");
    elseif selectedType == CHAPEL_PREFIX.."kurnous" then
        sizeUpgrade:SetVisible(true);
        setTooltip(asuryanAnimalsUpgrade, "upgrade_tooltips_idrinth_size_kurnous");
    elseif selectedType == CHAPEL_PREFIX.."outriders" then
        sizeUpgrade:SetVisible(true);
        setTooltip(asuryanAnimalsUpgrade, "upgrade_tooltips_idrinth_size_outriders");
    end;
end;
Idrinth.Events.addListener(
    "army",
    "UnitCreated",
    function(context)
        local unitKey = context:unit():unit_key();
        return Idrinth.Unittypes.isVampiric(unitKey) or Idrinth.Unittypes.isEliteTroop(unitKey) or Idrinth.Unittypes.isEnlargedEliteTroop(unitKey);
    end,
    function(context)
        lockVeterans(context:unit():faction(), false);
        local effectList = context:unit():get_unit_purchasable_effects();
        for i = 0, effectList:num_items() - 1 do
            local effect = effectList:item_at(i);
            if effect:record_key() == VETERAN_PREFIX.."0" then
                cm:faction_purchase_unit_effect(context:unit():faction(), context:unit(), effect);
                Idrinth.log("Added "..VETERAN_PREFIX.."0 to new unit", "army");
                lockVeterans(context:unit():faction(), true);
                return;
            end;
        end;
        lockVeterans(context:unit():faction(), true);
    end
);
Idrinth.Events.addListener(
    "army",
    "UnitCreated",
    function(context)
        local unitKey = context:unit():unit_key();
        return Idrinth.Unittypes.isEnlargedCavalry(unitKey) or Idrinth.Unittypes.isEnlargedEliteTroop(unitKey);
    end,
    function(context)
        Idrinth.log("UnitCreated, rank to apply: "..lastXPRank, "army");
        if lastXPRank > 0 then
            cm:add_experience_to_unit(context:unit(), lastXPRank);
            lastXPRank = 0;
        end;
    end
);
Idrinth.Events.addListener(
    "army",
    "FactionTurnStart",
    function(context)
        if not enableAnimalWAAAGH then
            return;
        end;
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth and not idrinth:is_wounded() and idrinth:has_military_force() and not idrinth:is_carrying_troops();
    end,
    function()
        local idrinth = Idrinth.Access.get();
        cm:spawn_transported_force_at_military_force(
            idrinth:military_force():command_queue_index(),
            "idrinth_hev_high_elf_vampires_idrinth_support",
            1
        );
    end
);
local buttonMap = {
    idrinth_button_upgrade_asuryan_troops = function()
        upgradeUnit(Idrinth.Constants.Gods.Asuryan);
    end,
    idrinth_button_upgrade_khaine_troops = function()
        upgradeUnit(Idrinth.Constants.Gods.Khaine);
    end,
    idrinth_button_upgrade_kurnous_troops = function()
        upgradeUnit(Idrinth.Constants.Gods.Kurnous);
    end,
    idrinth_button_upgrade_asuryan_priest = function()
        upgradePriest(Idrinth.Constants.Gods.Asuryan);
    end,
    idrinth_button_upgrade_khaine_priest = function()
        upgradePriest(Idrinth.Constants.Gods.Khaine);
    end,
    idrinth_button_upgrade_kurnous_priest = function()
        upgradePriest(Idrinth.Constants.Gods.Kurnous);
    end,
    idrinth_button_upgrade_asuryan_animals = function()
        upgradeAnimal(Idrinth.Constants.Gods.Asuryan);
    end,
    idrinth_button_upgrade_khaine_animals = function()
        upgradeAnimal(Idrinth.Constants.Gods.Khaine);
    end,
    idrinth_button_upgrade_kurnous_animals = function()
        upgradeAnimal(Idrinth.Constants.Gods.Kurnous);
    end,
    idrinth_button_upgrade_size = function()
        upgradeSize();
    end,
};
Idrinth.Events.addListener(
    "army",
    "ComponentLClickUp",
    true,
    function(context)
        Idrinth.Ui.nowAndThen(handleUpgradeButtons);
        if context.string and buttonMap[context.string] then
            buttonMap[context.string]();
        end;
    end
);
Idrinth.Events.addListener(
    "army",
    "PanelOpenedCampaign",
    function(context)
        return context.string == "units_panel";
    end,
    function()
        Idrinth.Ui.nowAndThen(handleUpgradeButtons);
    end
);
cm:add_first_tick_callback(
    function()
        lockVeterans(cm:get_local_faction(), true);
        lockAnimalBlessings(cm:get_local_faction(), true);
    end
);
