local enableChapels = nil;
local chapelMode = "normal";
local eventIdCreated = 77777;
local eventIdDestroyed = 77778;

local addForeignSlots = function(idrinth, faction)
    cm:show_message_event_located(
        faction:name(),
        "message_event_strings_title_idrinth_chapel_founded",
        "regions_onscreen_"..idrinth:region():name(),
        "message_event_text_idrinth_chapel_founded",
        idrinth:region():settlement():logical_position_x(),
        idrinth:region():settlement():logical_position_y(),
        true,
        eventIdCreated
    );
    cm:apply_effect_bundle_to_region("idrinth_chapel_slots_present", idrinth:region():name(), 0);
    local factionCqi = faction:command_queue_index();
    local regionCqi = idrinth:region():cqi();
    if idrinth:region():is_province_capital() then
        cm:add_foreign_slot_set_to_region_for_faction(
            factionCqi, regionCqi, "idrinth_slot_set_chapel_capital"
        );
        return;
    end;
    cm:add_foreign_slot_set_to_region_for_faction(
        factionCqi, regionCqi, "idrinth_slot_set_chapel"
    );
end;
core:add_listener(
    "idrinth_chapels_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "chapels");
        local mod = context:mct():get_mod_by_key("idrinth");
        enableChapels = mod:get_option_by_key("chapels"):get_finalized_setting();
        chapelMode = mod:get_option_by_key("chapel_chance"):get_finalized_setting();
    end,
    true
);
core:add_listener(
    "idrinth_chapels_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        Idrinth.log("MctFinalized", "chapels");
        local mod = context:mct():get_mod_by_key("idrinth");
        enableChapels = mod:get_option_by_key("chapels"):get_finalized_setting();
        chapelMode = mod:get_option_by_key("chapel_chance"):get_finalized_setting();
    end,
    true
);
core:add_listener(
    "idrinth_chapels_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        return Idrinth.mayConfigure() and context:faction():is_human() and nil == enableChapels;
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "chapels");
        cm:trigger_dilemma(context:faction():name(), "idrinth_chapels_choice");
    end,
    false
);
core:add_listener(
    "idrinth_chapels_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == "idrinth_chapels_choice";
    end,
    function(context)
        Idrinth.log("DilemmaChoiceMadeEvent", "chapels");
        enableChapels = (context:choice() == 1);
    end,
    true
);
core:add_listener(
    "idrinth_chapels_FactionTurnStart_2",
    "FactionTurnStart",
    function(context)
        if not enableChapels then
            return false;
        end;
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth and not idrinth:is_wounded() and idrinth:has_region() and idrinth:region();
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "chapels");
        local idrinth, faction = Idrinth.Access.get();
        local buildingSpawnChance = idrinth:rank();
        if idrinth:is_embedded_in_military_force() then
            if idrinth:embedded_in_military_force():has_general() and idrinth:embedded_in_military_force():general_character():in_settlement() then
                buildingSpawnChance = buildingSpawnChance * 2;
            end;
        else
            buildingSpawnChance = buildingSpawnChance * 1.5;
        end;
        local max = 550;
        if chapelMode == "low" then
            max = 600;
        elseif chapelMode == "high" then
            max = 350;
        end;
        if buildingSpawnChance > cm:random_number(max) then
            local foreignSlotManager = idrinth:region():foreign_slot_manager_for_faction(context:faction():name());
            if foreignSlotManager and not foreignSlotManager:is_null_interface() then
                local found = false;
                if foreignSlotManager:slots() and not foreignSlotManager:slots():is_empty() then
                    for i = 0, foreignSlotManager:slots():num_items() -1 do
                        local slot = foreignSlotManager:slots():item_at(i);
                        if slot and slot:template_key() == "idrinth_hev_high_elf_vampires_chapel" then
                            found = true;
                        end;
                    end;
                end;
                if not found then
                    addForeignSlots(idrinth, faction);
                end;
            elseif not foreignSlotManager or foreignSlotManager:is_null_interface() then
                addForeignSlots(idrinth, faction);
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_chapels_RegionFactionChangeEvent",
    "RegionFactionChangeEvent",
    Idrinth.Access.spawned,
    function(context)
        Idrinth.log("RegionFactionChangeEvent", "chapels");
        local _, faction = Idrinth.Access.get();
        local foreignSlotManager = context:region():foreign_slot_manager_for_faction(faction:name());
        if foreignSlotManager and not foreignSlotManager:is_null_interface() then
            if foreignSlotManager:slots() and not foreignSlotManager:slots():is_empty() then
                for i = 0, foreignSlotManager:slots():num_items() -1 do
                    local slot = foreignSlotManager:slots():item_at(i);
                    if slot and slot:template_key() == "idrinth_hev_high_elf_vampires_chapel" then
                        cm:remove_faction_foreign_slots_from_region(faction:command_queue_index(), context:region():cqi());
                        cm:show_message_event_located(
                            faction:name(),
                            "message_event_strings_title_idrinth_chapel_lost",
                            "regions_onscreen_"..context:region():name(),
                            "message_event_text_idrinth_chapel_lost",
                            context:region():settlement():logical_position_x(),
                            context:region():settlement():logical_position_y(),
                            true,
                            eventIdDestroyed
                        );
                        cm:remove_effect_bundle_from_region("idrinth_chapel_slots_present", context:region():name());
                        return;
                    end;
                end;
            end;
        end;
    end,
    true
);
cm:add_saving_game_callback(
    function(context)
        if enableChapels then
            cm:save_named_value("idrinth.enableChapels", 1, context);
        end;
    end
);
cm:add_loading_game_callback(
    function(context)
        if cm:is_new_game() == false then
            enableChapels = (cm:load_named_value("idrinth.enableChapels", 0, context) == 1);
        end;
    end
);