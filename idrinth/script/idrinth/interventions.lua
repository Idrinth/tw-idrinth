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
        maxCooldown = 15,
    },
    kurnous_medium = {
        khaine = 0,
        kurnous = 200,
        asuryan = 0,
        effect = "idrinth_dilemma_god_favour_kurnous_medium",
        duration = 10,
        cooldown = 0,
        maxCooldown = 15,
    },
    asuryan_medium = {
        khaine = 0,
        kurnous = 0,
        asuryan = 200,
        effect = "idrinth_dilemma_god_favour_asuryan_medium",
        duration = 10,
        cooldown = 0,
        maxCooldown = 15,
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
local cooldownMode = "medium";
local cooldownFactors = {
    low = 0.8,
    medium = 1,
    long = 1.2,
};

Idrinth.Events.addListener(
    "FactionTurnStart",
    function(context)
        if not context:faction():is_human() then
            return false;
        end;
        return Idrinth.Access.get(context:faction()) ~= nil;
    end,
    function(context)
        local eventTriggered = false;
        local khaineUsed = 0;
        local kurnousUsed = 0;
        local asuryanUsed = 0;
        for _, event in pairs(godFavourDilemmas) do
            if event.cooldown > 0 then
                event.cooldown = event.cooldown - 1;
            else
                local prm = context:faction():pooled_resource_manager();
                local hasKhaine = prm:resource("idrinth_khaine"):value() >= event.khaine + khaineUsed;
                local hasKurnous = prm:resource("idrinth_kurnous"):value() >= event.kurnous + kurnousUsed;
                local hasAsuryan = prm:resource("idrinth_asuryan"):value() >= event.asuryan + asuryanUsed;
                local shouldTrigger = cm:random_number(100) > 95 and hasKhaine and hasKurnous and hasAsuryan;
                if shouldTrigger then
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
                    event.cooldown = event.maxCooldown * cooldownFactors[cooldownMode];
                    eventTriggered = true;
                end;
            end;
        end;
        if eventTriggered then
            cm:show_message_event(
                context:faction():name(),
                "message_event_strings_title_idrinth_godly_intervention",
                "message_event_text_idrinth_godly_intervention_subtitle",
                "message_event_text_idrinth_godly_intervention",
                true,
                77779
            );
        end;
    end
);
cm:add_saving_game_callback(
    function(context)
        for name, element in pairs(godFavourDilemmas) do
            if element.cooldown > 0 then
                cm:save_named_value("idrinth.interventions." .. name, element.cooldown, context);
            end;
        end;
        cm:save_named_value("idrinth.interventionCooldownMode", cooldownMode, context);
    end
);
cm:add_loading_game_callback(
    function(context)
        if cm:is_new_game() == false then
            cooldownMode = cm:load_named_value("idrinth.interventionCooldownMode", cooldownMode, context);
            for name, element in pairs(godFavourDilemmas) do
                element.cooldown = cm:load_named_value("idrinth.interventions." .. name, 0, context);
            end;
        end;
    end
);
Idrinth.Events.onMctChange(function()
    cooldownMode = Idrinth.Mct.get("intervention_cooldown");
end);
