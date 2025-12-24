local placesOfInterest = {
    drakenhof = {
        key = "idrinth_story_dilemma_drakenhof",
        triggered = false,
        region = "wh3_main_combi_region_castle_drakenhof"
    },
    temple_of_khaine = {
        key = "idrinth_story_dilemma_temple_of_khaine",
        triggered = false,
        region = "wh3_main_combi_region_temple_of_khaine"
    },
    shrine_of_khaine = {
        key = "idrinth_story_dilemma_shrine_of_khaine",
        triggered = false,
        region = "wh3_main_combi_region_shrine_of_khaine"
    },
    temple_of_asuryan = {
        key = "idrinth_story_dilemma_temple_of_asuryan",
        triggered = false,
        region = "wh3_main_combi_region_shrine_of_asuryan"
    },
    temple_of_kurnous = {
        key = "idrinth_story_dilemma_temple_of_kurnous",
        triggered = false,
        region = "wh3_main_combi_region_shrine_of_kurnous"
    },
    shrine_of_loec = {
        key = "idrinth_story_dilemma_shrine_of_loec",
        triggered = false,
        region = "wh3_main_combi_region_shrine_of_loec"
    },
    hel_fenn = {
        key = "idrinth_story_dilemma_hel_fenn",
        triggered = false,
        region = "wh3_main_combi_region_waldenhof"
    },
    black_pyramid = {
        key = "idrinth_story_dilemma_black_pyramid",
        triggered = false,
        region = "wh3_main_combi_region_black_pyramid_of_nagash"
    },
    vauls_anvil_ulthuan = {
        key = "idrinth_story_dilemma_vauls_anvil_ulthuan",
        triggered = false,
        region = "wh3_main_combi_region_vauls_anvil_ulthuan"
    },
    vauls_anvil_naggaroth = {
        key = "idrinth_story_dilemma_vauls_anvil_naggaroth",
        triggered = false,
        region = "wh3_main_combi_region_vauls_anvil_naggaroth"
    },
    vauls_anvil_loren = {
        key = "idrinth_story_dilemma_vauls_anvil_loren",
        triggered = false,
        region = "wh3_main_combi_region_vauls_anvil_loren"
    },
    tower_of_hoeth = {
        key = "idrinth_story_dilemma_tower_of_hoeth",
        triggered = false,
        region = "wh3_main_combi_region_white_tower_of_hoeth"
    },
    blood_keep = {
        key = "idrinth_story_dilemma_blood_keep",
        triggered = false,
        region = ""
    },
    oak_of_ages = {
        key = "idrinth_story_dilemma_oak_of_ages",
        triggered = false,
        region = "wh3_main_combi_region_the_oak_of_ages"
    },
    the_galleons_graveyard = {
        key = "idrinth_story_dilemma_the_galleons_graveyard",
        triggered = false,
        region = "wh3_main_combi_region_the_galleons_graveyard"
    },
    sartosa = {
        key = "idrinth_story_dilemma_sartosa",
        triggered = false,
        region = "wh3_main_combi_region_sartosa"
    },
    lahmia = {
        key = "idrinth_story_dilemma_lahmia",
        triggered = false,
        region = "wh3_main_combi_region_lahmia"
    },
    ghrond = {
        key = "idrinth_story_dilemma_ghrond",
        triggered = false,
        region = "wh3_main_combi_region_ghrond"
    }
};
local enablePointsOfInterest = nil;

core:add_listener(
    "idrinth_pointsofinterest_MctInitialized",
    "MctInitialized",
    true,
    function(context)
        enablePointsOfInterest = context:mct():get_mod_by_key("idrinth"):get_option_by_key("story_events"):get_finalized_setting();
    end,
    true
)
core:add_listener(
    "idrinth_pointsofinterest_MctFinalized",
    "MctFinalized",
    true,
    function(context)
        enablePointsOfInterest = context:mct():get_mod_by_key("idrinth"):get_option_by_key("story_events"):get_finalized_setting(); 
    end,
    true
);
core:add_listener(
    "idrinth_pointsofinterest_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == "idrinth_story_choice";
    end,
    function(context)
        enablePointsOfInterest = (context:choice() == 1);
    end,
    true
);
core:add_listener(
    "idrinth_pointsofinterest_FactionTurnStart",
    "FactionTurnStart",
    function(context)
        return enablePointsOfInterest == nil and context:faction():is_human();
    end,
    function(context)
        cm:trigger_dilemma(context:faction():name(), "idrinth_story_choice");
    end,
    false
);
core:add_listener(
    "idrinth_pointsofinterest_FactionTurnStart_2",
    "FactionTurnStart",
    function(context)
        local idrinth, faction = Idrinth.Access.get();
        return enablePointsOfInterest and idrinth and not idrinth:is_wounded() and idrinth:region() and idrinth:has_region() and context:faction() == faction;
    end,
    function(context)    
        local faction_key = context:faction():name();
        local idrinth = Idrinth.Access.get();
        for region, data in pairs(placesOfInterest) do
            if data.region == idrinth:region():name() and not data.triggered then
                cm:trigger_dilemma(faction_key, data.key);
                placesOfInterest[region].triggered = true;
                return;
            end;            
        end;
    end,
    true
);
cm:add_saving_game_callback(
	function(context)
        if enablePointsOfInterest then
            cm:save_named_value("idrinth.enablePointsOfInterest", 1, context);         
        end;
	end
);
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
            enablePointsOfInterest = (cm:load_named_value("idrinth.enablePointsOfInterest", 0, context) == 1);
		end;
	end
);