local itemChanceMode = "normal";
local itemChanceFactors = {
    low = 0.5,
    medium = 1,
    high = 1.5,
};
local itemDilemmas = {
    weapon_hero = {
        min_battles_fought = 0,
        min_assassinations = 9,
        min_level = 0,
        key = "idrinth_dilemma_weapon",
        triggered = false,
        allowed_types = {
            "champion"
        }
    },
    weapon_lord = {
        min_battles_fought = 21,
        min_assassinations = 0,
        min_level = 21,
        key = "idrinth_dilemma_weapon",
        triggered = false,
        allowed_types = {
            "general"
        }
    },

    armour = {
        min_battles_fought = 15,
        min_assassinations = 0,
        min_level = 0,
        key = "idrinth_dilemma_armour",
        triggered = false,
        allowed_types = {
            "general",
            "champion"
        }
    },
    talisman = {
        min_battles_fought = 0,
        min_assassinations = 0,
        min_level = 15,
        key = "idrinth_dilemma_talisman",
        triggered = false,
        allowed_types = {
            "general",
            "champion"
        }
    }
};
local godBlessedItemRequirements = "normal";
local uniqueAncillaries = {
    "idrinth_anc_talisman_stone_of_dried_blood",
    "idrinth_anc_talisman_talisman_of_souls",
    "idrinth_anc_talisman_forest_berry_wine",
    "idrinth_anc_weapon_kurnous_blessed_hunting_bow",
    "idrinth_anc_armour_khaines_visage",
    "idrinth_anc_weapon_khaines_thirsting_sword",
    "idrinth_anc_weapon_asuryans_perfection_sword",
    "idrinth_anc_armour_kurnous_forest_cloak",
    "idrinth_anc_armour_asuryans_destiny"
};

core:add_listener(
    "idrinth_items_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        if not context:faction():is_human() then
            return false;
        end
        local idrinth = Idrinth.Access.get(context:faction());
        return idrinth and not idrinth:is_wounded();
    end,
    function(context)
        Idrinth.log("FactionTurnStart", "items");
        local idrinth = Idrinth.Access.get();
        local level = idrinth:rank();
        local factor = 1;
        if godBlessedItemRequirements == "low" then
            factor = 2/3;
        elseif godBlessedItemRequirements == "high" then
            factor = 4/3;
        end;
        for _, data in pairs(itemDilemmas) do
            local allowed = false;
            for _, allowed_type in pairs(data.allowed_types) do
                allowed = allowed or (idrinth:character_type_key() == allowed_type);
            end;
            if allowed and not data.triggered and Idrinth.Statistics.BattlesFought >= data.min_battles_fought * factor and Idrinth.Statistics.CharactersAssassinated >= data.min_assassinations * factor and level >= data.min_level * factor then
                if (cm:random_number(100) <= 25 * itemChanceFactors[itemChanceMode]) then
                    data.triggered = true;
                    cm:trigger_dilemma(context:faction():name(), data.key);
                end;
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_items_CharacterAncillaryGained",
    "CharacterAncillaryGained",
    Idrinth.Access.spawned,
    function(context)
        Idrinth.log("CharacterAncillaryGained", "items");
        local idrinth, faction = Idrinth.Access.get();
        for _, ancillary in pairs(uniqueAncillaries) do
            if context:ancillary() == ancillary and not idrinth:has_ancillary(ancillary) then
                cm:force_remove_ancillary_from_faction(
                    faction,
                    ancillary
                )
                cm:force_add_ancillary(
                    idrinth,
                    ancillary,
                    true,
                    true
                );
            end;
        end;
    end,
    true
);
core:add_listener(
    "idrinth_items_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        Idrinth.log("MctInitialized", "items");
        godBlessedItemRequirements = context:mct():get_mod_by_key("idrinth"):get_option_by_key("god_item_difficulty"):get_finalized_setting();
        itemChanceMode = context:mct():get_mod_by_key("idrinth"):get_option_by_key("god_item_base_chance"):get_finalized_setting();
    end,
    true
)
core:add_listener(
    "idrinth_items_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        Idrinth.log("MctFinalized", "items");
        godBlessedItemRequirements = context:mct():get_mod_by_key("idrinth"):get_option_by_key("god_item_difficulty"):get_finalized_setting();
        itemChanceMode = context:mct():get_mod_by_key("idrinth"):get_option_by_key("god_item_base_chance"):get_finalized_setting();
    end,
    true
);
cm:add_saving_game_callback(
	function(context)
        for name, element in pairs(itemDilemmas) do
            if element.triggered then
                cm:save_named_value("idrinth.item_dilemmas." .. name, 1, context);
            end;
        end;
	end
);
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
            for name, element in pairs(itemDilemmas) do
                element.triggered = (cm:load_named_value("idrinth.item_dilemmas." .. name, 0, context) == 1);
            end;
		end;
	end
);