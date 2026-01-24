--- @module Idrinth.Army
--- Army and unit management system for the Idrinth mod.
--- Handles unit upgrades, veterancy, blessed animal mechanics, and troop dedications to gods.
--- Provides UI integration for upgrade buttons and unit transformation mechanics.

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

--- Checks if a unit UI component is in a selected state.
--- @param unit userdata The UI component representing the unit.
--- @return boolean True if the unit is selected or hovered while selected.
local isUnitSelected = function(unit)
    if not unit then
        return false;
    end;
    local state = unit:CurrentState();
    return state == STATE_SELECTED_HOVER or state == STATE_SELECTED;
end;
Idrinth.Events.onMctChange(function()
    enableAnimalWAAAGH = Idrinth.Mct.get("animal_waaagh");
    vampireChance = Idrinth.Mct.get("vampire_chance");
end);
--- Gets information about the currently displayed units panel.
--- @return userdata|nil units The units panel UI component, or nil if not found.
--- @return table|nil uiIds Map of unique UI IDs for existing units.
local getSelectedUnitsInfo = function()
    local units = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "units");
    if not units then
        return nil, nil;
    end;
    local uiIds = {};
    Idrinth.Ui.forEachChild(units, function(unit)
        local id = unit:GetContextObjectId(UNIT_CONTEXT);
        if id then
            local uiId = common.get_context_value(UNIT_CONTEXT, id, "UniqueUiId");
            if uiId and uiId ~= "" then
                uiIds[uiId] = true;
            end;
        end;
    end);
    return units, uiIds;
end;
--- Locks or unlocks veteran rank purchasable effects for a faction.
--- @param faction userdata The faction to modify.
--- @param lock boolean True to lock effects, false to unlock.
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
--- Locks or unlocks god favour blessing effects for blessed animals.
--- @param faction userdata The faction to modify.
--- @param lock boolean True to lock effects, false to unlock.
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
--- Creates a callback function to apply veteran rank to a newly created unit.
--- @param uiIds table Map of existing unit UI IDs to filter out.
--- @param expectedType string The expected unit type key for the new unit.
--- @param currentRank number|string The veteran rank to apply.
--- @return function Callback function that finds and upgrades the new unit.
local applyVeteranRankToNewUnit = function(uiIds, expectedType, currentRank)
    return function()
        Idrinth.log("applyVeteranRankToNewUnit", "army");
        local unitsPanel = Idrinth.Ui.findElementWithin("units_panel", "main_units_panel", "units");
        if not unitsPanel then
            return;
        end;
        local newUnit = Idrinth.Ui.findChildWhere(unitsPanel, function(unit)
            local id = unit:GetContextObjectId(UNIT_CONTEXT);
            if not id then
                return false;
            end;
            local unitType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
            local uiId = common.get_context_value(UNIT_CONTEXT, id, "UniqueUiId");
            return not uiIds[uiId] and unitType == expectedType;
        end);
        if not newUnit then
            return;
        end;
        local newId = newUnit:GetContextObjectId(UNIT_CONTEXT);
        local _, faction = Idrinth.Access.get();
        lockVeterans(faction, false);
        local rankKey = is_string(currentRank) and currentRank or (VETERAN_PREFIX .. currentRank);
        local upgradeCmd = "Upgrade(DatabaseRecordContext(\""
            .. UPGRADE_EFFECT_RECORD .. "\", \"" .. rankKey .. "\"))";
        common.call_context_command(UNIT_CONTEXT, newId, upgradeCmd);
        lockVeterans(faction, true);
    end;
end;
--- Upgrades a mixed unit to a god-dedicated troop type.
--- @param god string The god key (asuryan, khaine, or kurnous).
local upgradeUnit = function(god)
    local units, uiIds = getSelectedUnitsInfo();
    if not units then
        return;
    end;
    local selectedUnit = Idrinth.Ui.findChildWhere(units, isUnitSelected);
    if not selectedUnit then
        return;
    end;
    local id = selectedUnit:GetContextObjectId(UNIT_CONTEXT);
    if not id then
        return;
    end;
    local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
    local currentRank = common.get_context_value(UNIT_CONTEXT, id, "ExperienceLevel");
    local price = 300 + 50 * currentRank;
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local lookup = cm:char_lookup_str(character);
    local factionKey = character:faction():name();
    if currentType == CHAPEL_PREFIX .. "mixed" and character:faction():treasury() >= price then
        common.call_context_command(UNIT_CONTEXT, id, "Disband");
        cm:real_callback(function()
            cm:grant_unit_to_character(lookup, CHAPEL_PREFIX .. god);
        end, CALLBACK_DELAY);
        cm:treasury_mod(factionKey, 0 - price);
        cm:faction_add_pooled_resource(
            factionKey, "idrinth_" .. god, "idrinth_" .. god .. "_other", currentRank * currentRank
        );
        cm:real_callback(applyVeteranRankToNewUnit(uiIds, CHAPEL_PREFIX .. god, currentRank), CALLBACK_DELAY * 2);
    end;
end;
local lastXPRank = 0;

--- Upgrades a unit to a larger variant (elite troops or cavalry).
local upgradeSize = function()
    local units, uiIds = getSelectedUnitsInfo();
    if not units then
        return;
    end;
    local selectedUnit = Idrinth.Ui.findChildWhere(units, isUnitSelected);
    if not selectedUnit then
        return;
    end;
    local id = selectedUnit:GetContextObjectId(UNIT_CONTEXT);
    if not id then
        return;
    end;
    local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
    local currentRank = common.get_context_value(UNIT_CONTEXT, id, "ExperienceLevel");
    local currentVeteranRank = 0;
    local hasNoEffect = common.get_context_value(UNIT_CONTEXT, id, "PurchasedEffectsList.IsEmpty");
    if not hasNoEffect then
        currentVeteranRank = common.get_context_value(UNIT_CONTEXT, id, "PurchasedEffectsList.At(0).Key");
    end;
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local lookup = cm:char_lookup_str(character);
    local factionKey = character:faction():name();
    local infantryPrice = 300;
    local cavalryPrice = 250;
    if character:faction():treasury() >= infantryPrice then
        for _, god in pairs(Idrinth.Constants.GodList) do
            local chapelType = CHAPEL_PREFIX .. god;
            local largeType = chapelType .. "_large";
            if currentType == chapelType then
                common.call_context_command(UNIT_CONTEXT, id, "Disband");
                lastXPRank = currentRank;
                cm:real_callback(function()
                    cm:grant_unit_to_character(lookup, largeType);
                end, CALLBACK_DELAY);
                cm:treasury_mod(factionKey, 0 - infantryPrice);
                cm:real_callback(
                    applyVeteranRankToNewUnit(uiIds, largeType, currentVeteranRank),
                    CALLBACK_DELAY * 2
                );
                return;
            end;
        end;
    end;
    local outridersType = CHAPEL_PREFIX .. "outriders";
    if currentType == outridersType and character:faction():treasury() >= cavalryPrice then
        common.call_context_command(UNIT_CONTEXT, id, "Disband");
        lastXPRank = currentRank;
        cm:real_callback(function()
            cm:grant_unit_to_character(lookup, outridersType .. "_large");
        end, CALLBACK_DELAY);
        cm:treasury_mod(factionKey, 0 - cavalryPrice);
    end;
end;
--- Applies a god favour blessing to a blessed animal unit.
--- @param god string The god key (asuryan, khaine, or kurnous).
local upgradeAnimal = function(god)
    local units = getSelectedUnitsInfo();
    if not units then
        return;
    end;
    local selectedUnit = Idrinth.Ui.findChildWhere(units, isUnitSelected);
    if not selectedUnit then
        return;
    end;
    local id = selectedUnit:GetContextObjectId(UNIT_CONTEXT);
    if not id then
        return;
    end;
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
    _, faction = Idrinth.Access.get();
    if godFavourBlessings[currentType] and godFavourBlessings[currentType][god] then
        lockAnimalBlessings(character:faction(), false);
        local blessing = godFavourBlessings[currentType][god];
        local costTreasury = common.get_context_value(UNIT_CONTEXT, id, "DatabaseRecordContext(\""
            .. UPGRADE_EFFECT_RECORD .. "\", \"" .. blessing .. "\").CostContext.TreasuryCost");
        if faction:treasury() + costTreasury < 0 then
            lockAnimalBlessings(character:faction(), true);
            return;
        end;
        local upgradeCmd = "Upgrade(DatabaseRecordContext(\""
            .. UPGRADE_EFFECT_RECORD .. "\", \"" .. blessing .. "\"))";
        common.call_context_command(UNIT_CONTEXT, id, upgradeCmd);
        lockAnimalBlessings(character:faction(), true);
    end;
end;
--- Attempts to transform a priest into a vampire or varghulf.
--- Requires sufficient treasury and god resource. Outcome is randomized.
--- @param god string The god key (asuryan, khaine, or kurnous).
local upgradePriest = function(god)
    local units, uiIds = getSelectedUnitsInfo();
    if not units then
        return;
    end;
    local selectedUnit = Idrinth.Ui.findChildWhere(units, isUnitSelected);
    if not selectedUnit then
        return;
    end;
    local id = selectedUnit:GetContextObjectId(UNIT_CONTEXT);
    if not id then
        return;
    end;
    local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
    local currentRank = common.get_context_value(UNIT_CONTEXT, id, "ExperienceLevel");
    local leaderType = CHAPEL_PREFIX .. god .. "_leader";
    local godResource = "idrinth_" .. god;
    local character = cm:get_character_by_cqi(cm:get_campaign_ui_manager():get_char_selected_cqi());
    local pooledResourceManager = character:faction():pooled_resource_manager();
    local hasEnoughTreasury = character:faction():treasury() >= 1000;
    local hasEnoughResource = pooledResourceManager:resource(godResource):value() >= 250;
    if currentType ~= leaderType or not hasEnoughTreasury or not hasEnoughResource then
        return;
    end;
    local lookup = cm:char_lookup_str(character);
    local factionKey = character:faction():name();
    common.call_context_command(UNIT_CONTEXT, id, "Disband");
    cm:treasury_mod(factionKey, -1000);
    cm:faction_add_pooled_resource(factionKey, godResource, godResource .. "_other", -250);
    local randomNum = cm:random_number(100);
    local vampireType = leaderType .. "_vampire";
    local varghulfType = CHAPEL_PREFIX .. god .. "_varghulf";
    if randomNum < vampireChances[vampireChance] + currentRank * 4 then
        cm:real_callback(function()
            cm:grant_unit_to_character(lookup, vampireType);
        end, CALLBACK_DELAY);
        cm:real_callback(applyVeteranRankToNewUnit(uiIds, vampireType, currentRank), CALLBACK_DELAY * 2);
    elseif randomNum < 3 * vampireChances[vampireChance] + currentRank * 6 then
        cm:real_callback(function()
            cm:grant_unit_to_character(lookup, varghulfType);
        end, CALLBACK_DELAY);
        cm:real_callback(applyVeteranRankToNewUnit(uiIds, varghulfType, currentRank), CALLBACK_DELAY * 2);
    end;
end;
--- Sets a localized tooltip on a UI element.
--- @param element userdata The UI component.
--- @param loc_key string The localization key for the tooltip text.
local setTooltip = function(element, loc_key)
    element:SetTooltipText(common.get_localised_string(loc_key), loc_key, true);
end;
local upgradeButtonConfigs = {
    [CHAPEL_PREFIX.."asuryan_leader"] = {
        buttons = {"asuryanPriestUpgrade"},
        tooltips = {"upgrade_tooltips_idrinth_priest_asuryan"},
    },
    [CHAPEL_PREFIX.."khaine_leader"] = {
        buttons = {"khainePriestUpgrade"},
        tooltips = {"upgrade_tooltips_idrinth_priest_khaine"},
    },
    [CHAPEL_PREFIX.."kurnous_leader"] = {
        buttons = {"kurnousPriestUpgrade"},
        tooltips = {"upgrade_tooltips_idrinth_priest_kurnous"},
    },
    [CHAPEL_PREFIX.."mixed"] = {
        buttons = {"asuryanTroopsUpgrade", "khaineTroopsUpgrade", "kurnousTroopsUpgrade"},
        tooltips = {
            "upgrade_tooltips_idrinth_unit_asuryan",
            "upgrade_tooltips_idrinth_unit_khaine",
            "upgrade_tooltips_idrinth_unit_kurnous",
        },
    },
    [CHAPEL_PREFIX.."wolves"] = {
        buttons = {"asuryanAnimalsUpgrade", "khaineAnimalsUpgrade", "kurnousAnimalsUpgrade"},
        tooltips = {
            "upgrade_tooltips_idrinth_animal_asuryan_wolves",
            "upgrade_tooltips_idrinth_animal_khaine_wolves",
            "upgrade_tooltips_idrinth_animal_kurnous_wolves",
        },
    },
    [CHAPEL_PREFIX.."cave_bats"] = {
        buttons = {"asuryanAnimalsUpgrade", "khaineAnimalsUpgrade", "kurnousAnimalsUpgrade"},
        tooltips = {
            "upgrade_tooltips_idrinth_animal_asuryan_bats",
            "upgrade_tooltips_idrinth_animal_khaine_bats",
            "upgrade_tooltips_idrinth_animal_kurnous_bats",
        },
    },
    [CHAPEL_PREFIX.."hawks"] = {
        buttons = {"asuryanAnimalsUpgrade", "khaineAnimalsUpgrade", "kurnousAnimalsUpgrade"},
        tooltips = {
            "upgrade_tooltips_idrinth_animal_asuryan_hawks",
            "upgrade_tooltips_idrinth_animal_khaine_hawks",
            "upgrade_tooltips_idrinth_animal_kurnous_hawks",
        },
    },
    [CHAPEL_PREFIX.."great_eagle"] = {
        buttons = {"asuryanAnimalsUpgrade", "khaineAnimalsUpgrade", "kurnousAnimalsUpgrade"},
        tooltips = {
            "upgrade_tooltips_idrinth_animal_asuryan_eagle",
            "upgrade_tooltips_idrinth_animal_khaine_eagle",
            "upgrade_tooltips_idrinth_animal_kurnous_eagle",
        },
    },
    [CHAPEL_PREFIX.."asuryan"] = {
        buttons = {"sizeUpgrade"},
        tooltips = {"upgrade_tooltips_idrinth_size_asuryan"},
    },
    [CHAPEL_PREFIX.."khaine"] = {
        buttons = {"sizeUpgrade"},
        tooltips = {"upgrade_tooltips_idrinth_size_khaine"},
    },
    [CHAPEL_PREFIX.."kurnous"] = {
        buttons = {"sizeUpgrade"},
        tooltips = {"upgrade_tooltips_idrinth_size_kurnous"},
    },
    [CHAPEL_PREFIX.."outriders"] = {
        buttons = {"sizeUpgrade"},
        tooltips = {"upgrade_tooltips_idrinth_size_outriders"},
    },
};
--- Updates icon display for blessed animal units to show their god favour blessing.
--- @param unit userdata The unit UI component.
local updateBlessedAnimalIcons = function(unit)
    local id = unit:GetContextObjectId(UNIT_CONTEXT);
    if not id then
        return;
    end;
    local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
    if not Idrinth.Unittypes.isBlessedAnimal(currentType) then
        return;
    end;
    local cardHolder = UIComponent(unit:Find("card_image_holder"));
    local icon = UIComponent(cardHolder:Find("upgrade_effect_icon"));
    local waaagh = UIComponent(cardHolder:Find("waaagh_unit_marker"));
    waaagh:SetVisible(false);
    local hasNoEffect = common.get_context_value(UNIT_CONTEXT, id, "PurchasedEffectsList.IsEmpty");
    if not hasNoEffect then
        icon:SetVisible(true);
        local iconPath = common.get_context_value(
            UNIT_CONTEXT, id, "PurchasedEffectsList.At(0).EffectBundleContext.IconPath"
        );
        icon:SetImagePath(iconPath);
    end;
end;

--- Finds the selected unit type, returning nil if multiple different types are selected.
--- @param units userdata The units panel UI component.
--- @return string|nil The unit type key if all selected units are the same type, nil otherwise.
local getSelectedUnitType = function(units)
    local selectedType = "";
    local hasMultipleTypes = false;
    Idrinth.Ui.forEachChild(units, function(unit)
        if not isUnitSelected(unit) then
            return;
        end;
        local id = unit:GetContextObjectId(UNIT_CONTEXT);
        if not id then
            return;
        end;
        local currentType = common.get_context_value(UNIT_CONTEXT, id, "UnitRecordContext.Key");
        if not currentType then
            return;
        end;
        if selectedType == "" then
            selectedType = currentType;
        elseif selectedType ~= currentType then
            hasMultipleTypes = true;
        end;
    end);
    if hasMultipleTypes then
        return nil;
    end;
    return selectedType;
end;

--- Handles the display and visibility of upgrade buttons based on selected unit type.
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
    -- Update icons for all blessed animals
    Idrinth.Ui.forEachChild(units, updateBlessedAnimalIcons);
    -- Determine selected unit type
    local selectedType = getSelectedUnitType(units);
    if not selectedType or selectedType == "" then
        return;
    end;
    Idrinth.log("Selected: " .. tostring(selectedType), "army");
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
    local allButtons = {
        asuryanPriestUpgrade = asuryanPriestUpgrade,
        khainePriestUpgrade = khainePriestUpgrade,
        kurnousPriestUpgrade = kurnousPriestUpgrade,
        asuryanTroopsUpgrade = asuryanTroopsUpgrade,
        khaineTroopsUpgrade = khaineTroopsUpgrade,
        kurnousTroopsUpgrade = kurnousTroopsUpgrade,
        asuryanAnimalsUpgrade = asuryanAnimalsUpgrade,
        khaineAnimalsUpgrade = khaineAnimalsUpgrade,
        kurnousAnimalsUpgrade = kurnousAnimalsUpgrade,
        sizeUpgrade = sizeUpgrade,
    };
    for _, btn in pairs(allButtons) do
        btn:SetVisible(false);
    end;
    local config = upgradeButtonConfigs[selectedType];
    if not config then
        return;
    end;
    for idx, buttonName in ipairs(config.buttons) do
        local btn = allButtons[buttonName];
        btn:SetVisible(true);
        setTooltip(btn, config.tooltips[idx]);
    end;
end;
Idrinth.Events.addListener(
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
    "FactionTurnStart",
    function(context)
        if not enableAnimalWAAAGH then
            return;
        end;
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth
            and not idrinth:is_wounded()
            and idrinth:has_military_force()
            and not idrinth:is_carrying_troops();
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
    "PanelOpenedCampaign",
    Idrinth.Events.Conditions.panelOpened("units_panel"),
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
Idrinth.Event.addListener(
    "MilitaryForceCreated",
    true,
    function(context)
        local force = context.military_force();
        if force:has_general() and force:general_character():character_subtype_key() == Idrinth.Constants.LordSubtype then
            local resourceManager = force:pooled_resource_manager();
            if not resourceManager:resource("magic") then
            
            end;
        end;
    end
);