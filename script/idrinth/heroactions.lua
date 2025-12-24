core:add_listener(
    "idrinth_heroactions_CharacterCharacterTargetAction",
    "CharacterCharacterTargetAction",
    function(context)
        local idrinth = Idrinth.Access.get();
        return idrinth and (context:character() == idrinth);
    end,
    function(context)
        local ability = context:ability();
        local idrinth = Idrinth.Access.get();

        if ability == "hinder_army" then
            if context:mission_result_critial_failure() then
                -- nothing
            elseif context:mission_result_success() then
                cm:apply_effect_bundle_to_character("idrinth_successful_action_army", idrinth, 2);
            elseif context:mission_result_critial_success() then
                cm:replenish_action_points(cm:char_lookup_str(idrinth));
                cm:apply_effect_bundle_to_character("idrinth_successful_action_army_critical", idrinth, 5);
            end;
        elseif ability == "hinder_character" or ability == "hinder_agent" then
            if context:mission_result_critial_failure() then
                -- nothing
            elseif context:mission_result_success() then
                cm:apply_effect_bundle_to_character("idrinth_successful_action_character", idrinth, 2);
            elseif context:mission_result_critial_success() then
                cm:replenish_action_points(cm:char_lookup_str(idrinth));
                cm:apply_effect_bundle_to_character("idrinth_successful_action_character_critical", idrinth, 5);
            end;
        end;
    end,
    true
);