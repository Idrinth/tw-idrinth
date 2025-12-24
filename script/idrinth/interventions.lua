local godFavourDilemmas = {
    khaine_large = {
        khaine = 300,
        kurnous = 0,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_khaine_large",
        duration = 15,
        cooldown = 0,
        maxCooldown = 25,
    },
    kurnous_large = {
        khaine = 0,
        kurnous = 300,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_kurnous_large",
        duration = 15,
        cooldown = 0,
        maxCooldown = 25,
    },
    asuryan_large = {
        khaine = 0,
        kurnous = 0,
        asuryan = 300,
        effect = "idrinth_dilemma_god_favour_asuryan_large",
        duration = 15,
        cooldown = 0,
        maxCooldown = 25,
    },
    khaine_medium = {
        khaine = 200,
        kurnous = 0,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_khaine_medium",
        duration = 10,
        cooldown = 0,
        maxCooldown = 17,
    },
    kurnous_medium = {
        khaine = 0,
        kurnous = 200,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_kurnous_medium",
        duration = 10,
        cooldown = 0,
        maxCooldown = 17,
    },
    asuryan_medium = {
        khaine = 0,
        kurnous = 0,
        asuryan = 200,
        effect = "idrinth_dilemma_god_favour_asuryan_medium",
        duration = 10,
        cooldown = 0,
        maxCooldown = 17,
    },
    khaine_small = {
        khaine = 100,
        kurnous = 0,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_khaine_small",
        duration = 5,
        cooldown = 0,
        maxCooldown = 10,
    },
    kurnous_small = {
        khaine = 0,
        kurnous = 100,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_kurnous_small",
        duration = 5,
        cooldown = 0,
        maxCooldown = 10,
    },
    asuryan_small = {
        khaine = 0,
        kurnous = 0,
        asuryan = 100,
        effect = "idrinth_dilemma_god_favour_asuryan_small",
        duration = 5,
        cooldown = 0,
        maxCooldown = 10,
    },
};

core:add_listener(
    "idrinth_interventions_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        return idrinth and context:faction() == faction;
    end,
    function(context)
        local eventTriggered = false;
        local khaineUsed = 0;
        local kurnousUsed = 0;
        local asuryanUsed = 0;
        for pos, event in pairs(godFavourDilemmas) do
            if event.cooldown > 0 then
                event.cooldown = event.cooldown - 1;
            elseif cm:random_number(100) > 95 and context:faction():pooled_resource_manager():resource("idrinth_khaine"):value() >= event.khaine + khaineUsed and context:faction():pooled_resource_manager():resource("idrinth_kurnous"):value() >= event.kurnous + kurnousUsed and context:faction():pooled_resource_manager():resource("idrinth_asuryan"):value() >= event.asuryan + asuryanUsed then
                cm:apply_effect_bundle(
                    event.effect,
                    context:faction():name(),
                    event.duration
                );
                cm:apply_effect_bundle(
                    event.effect .. "_cost",
                    context:faction():name(),
                    1
                );
                asuryanUsed = asuryanUsed + event.asuryan;
                kurnousUsed = kurnousUsed + event.kurnous;
                khaineUsed = khaineUsed + event.khaine;
                event.cooldown = event.maxCooldown;
                eventTriggered = true;
            end;
        end;
        if eventTriggered == true then
            cm:trigger_dilemma(context:faction():name(), "idrinth_dilemma_god_favour");
        end;
    end,
    true
);