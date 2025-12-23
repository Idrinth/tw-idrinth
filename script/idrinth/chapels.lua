local enableChapels = nil;

local addForeignSlots = function(idrinth, faction)
    if idrinth:region():is_province_capital() then
        cm:add_foreign_slot_set_to_region_for_faction(faction:command_queue_index(), idrinth:region():cqi(), "idrinth_slot_set_chapel_capital");
        return;
    end;
    cm:add_foreign_slot_set_to_region_for_faction(faction:command_queue_index(), idrinth:region():cqi(), "idrinth_slot_set_chapel");
end;
core:add_listener(
    "idrinth_MctInitialized_Handling",
    "MctInitialized",
    true,
    function(context)
        enableChapels = context:mct():get_mod_by_key("idrinth"):get_option_by_key("chapels"):get_finalized_setting();
    end,
    true
)
core:add_listener(
    "idrinth_MctFinalized_Handling",
    "MctFinalized",
    true,
    function(context)
        enableChapels = context:mct():get_mod_by_key("idrinth"):get_option_by_key("chapels"):get_finalized_setting();
    end,
    true
);
core:add_listener(
    "idrinth_modeChapels_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        return context:faction():is_human() and nil == enableChapels;
    end,
    function(context)
        cm:trigger_dilemma(context:faction():name(), "idrinth_chapels_choice");
    end,
    false
);
core:add_listener(
    "idrinth_chapelMode_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == "idrinth_chapels_choice";
    end,
    function(context)
        enableChapels = (context:choice() == 1);
    end,
    true
);
core:add_listener(
    "idrinth_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        return enableChapels and idrinth and not idrinth:is_wounded() and idrinth:has_region() and idrinth:region() and context:faction() == faction;
    end,
    function(context)    
        local idrinth, faction = Idrinth.Access.get();
        local buildingSpawnChance = idrinth:rank();
        if idrinth:is_embedded_in_military_force() then
            if idrinth:embedded_in_military_force():has_general() and idrinth:embedded_in_military_force():general_character():in_settlement() then
                buildingSpawnChance = buildingSpawnChance * 2;
            end;
        else
            buildingSpawnChance = buildingSpawnChance * 1.5;
        end;
        if buildingSpawnChance > cm:random_number(500) then
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
    "idrinth_RegionFactionChangeEvent",
    "RegionFactionChangeEvent",
    Idrinth.Access.spawned,
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        local foreignSlotManager = context:region():foreign_slot_manager_for_faction(faction:name());
        if foreignSlotManager and not foreignSlotManager:is_null_interface() then
            if foreignSlotManager:slots() and not foreignSlotManager:slots():is_empty() then
                for i = 0, foreignSlotManager:slots():num_items() -1 do
                    local slot = foreignSlotManager:slots():item_at(i);
                    if slot and slot:template_key() == "idrinth_hev_high_elf_vampires_chapel" then
                        cm:remove_faction_foreign_slots_from_region(faction:command_queue_index(), context:region():cqi());
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