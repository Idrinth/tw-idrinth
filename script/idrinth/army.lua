core:add_listener(
    "idrinth_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        return idrinth and context:faction() == faction;
    end,
    function(context)    
        local idrinth = Idrinth.Access.get();
        if idrinth:is_wounded() then
            return;
        end;
        if idrinth:has_military_force() and not idrinth:is_carrying_troops() then
            cm:spawn_transported_force_at_military_force(idrinth:military_force():command_queue_index(), "idrinth_hev_high_elf_vampires_idrinth_support", 1)
        end;
    end,
    true
);