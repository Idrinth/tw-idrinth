local mct = get_mct()
if mct then
    local idrinth = mct:register_mod("idrinth")
    idrinth:set_title("Idrinth Thalui - The High Elven Vampire Loremaster")
    idrinth:set_workshop_id("3449820771")
    idrinth:set_version(71, "1.0.0")
    idrinth:set_main_image("ui/flags/idrinth_hev_high_elf_vampires/mon_256.png", 256, 256)
    idrinth:set_description("Once a respected High Elven Loremaster, Idrinth Thalui met his mortal end during the bloody Vampire Wars, only to rise again as one of the very creatures he fought against. Now this Knight-Scholar walks a precarious path between his elven heritage and vampiric curse, seeking purpose in a world torn by Chaos.\nWill you guide him toward redemption or embrace the darkness within? His fate rests in your hands.\n\nUnique Recruitment\n\nIdrinth can be recruited by those who might value his dual nature:\n- The Empire (seeking arcane knowledge)\n- Kislev (desperate for powerful allies)\n- High Elves (wishing to reclaim one of their own)\n- Wood Elves (valuing his connection to Kurnous)\n- Vampire Counts (embracing his newfound power)\n\nLooser Lore Mode\n\nIn the looser lore mode some less likely factions are added, that represent desperate alliances:\n- Bretonnia\n- Cathay\n- Dark Elves\n- Legions of Nagash(modded Faction)\n- Vampire Coast\n\nKey Features\n\nDivine Favor System\n\nBalance your allegiance between three powerful Elven deities, each offering unique paths to unify Idrinth's fractured existence:\n- Khaine: Embrace aggression with enhanced melee prowess and damage output\n- Asuryan: Seek balance through improved defenses and magical resistance\n- Kurnous: Channel the hunter's path with ranged superiority and mobility\n\nChapel System(optional)\n\nBased on the divine influences, Idrinth can found chapels that noticably affect garrison size, power and god favour use as well as benefiting the local economy and growth.\n\nNarrative Dilemmas\n\nFace critical choices that shape Idrinth's character and determine his relationship with the divine. Will you embrace your elven roots or surrender to vampiric power? Each decision affects your divine favor and unlocks permanent bonuses.\n\nDivine Artifact Sets\n\nCollect and equip powerful god-aligned artifacts that enhance Idrinth's abilities. Complete a set to earn special bonuses that complement your chosen divine path.\n\nElven Slayer Consequences\n\nA dynamic trait system that tracks your battles against elven factions. The more elves you slay, the more you'll be known, despised, and eventually hated among their kind, with significant diplomatic and divine favor consequences.\n\nArcane Versatility\nMaster spells from multiple magical lores, reflecting Idrinth's scholarly background and vampiric transformation:\n- Lore of Vampires\n- Lore of Death\n- Lore of Shadows\n\nALPHA VERSION NOTICE\nThis mod is in EARLY ALPHA development. You may encounter:\n- Devotion systems currently non-functional\n- Balance adjustments ongoing\n- Prayer system temporarily replaced by random triggering godly interventions\n\nYour feedback is essential for improvement! Please report any issues you encounter.")
    idrinth:set_author("Björn 'Idrinth' Büttner")
    
    idrinth:add_new_section("idrinth_spawn", "Spawn Options")
    local expanded_spawn = idrinth:add_new_option("expanded_spawn", "checkbox")
    expanded_spawn:set_default_value(false)

    expanded_spawn:set_text("Expanded Spawn Cultures")
    expanded_spawn:set_tooltip_text("Allows Idrinth to spawn for Bretonnia, Cathay, the Legions of Nagash, Dark Elves and Vampire Coast as well.")
    expanded_spawn:set_is_global(false)

    local level_adjustment = idrinth:add_new_option("level_adjustment", "dropdown")
    level_adjustment:add_dropdown_values({
        {
            key = "null",
            text = "Early Game",
        },
        {
            key = "one",
            text = "Late Early Game",
        },
        {
            key = "three",
            text = "Early Mid Game",
        },
        {
            key = "six",
            text = "Mid Game",
        }
    })
    level_adjustment:set_default_value("null")
    level_adjustment:set_text("Level Requirement")
    level_adjustment:set_tooltip_text("Modifies the level requirement to get Idrinth's unlock quest.")
    level_adjustment:set_is_global(false)

    local god_item_difficulty = idrinth:add_new_option("god_item_difficulty", "dropdown")
    god_item_difficulty:add_dropdown_values({
        {
            key = "low",
            text = "Low Requirements",
        },
        {
            key = "normal",
            text = "Normal Requirements",
        },
        {
            key = "high",
            text = "High Requirements",
        }
    })
    god_item_difficulty:set_default_value("normal")
    god_item_difficulty:set_text("God-Blessed Item Difficulty")
    god_item_difficulty:set_tooltip_text("Modifies the requirements for receiving the god blessed items.")
    god_item_difficulty:set_is_global(false)

    idrinth:add_new_section("idrinth_features", "Features")
    local story_events = idrinth:add_new_option("story_events", "checkbox")
    story_events:set_default_value(true)

    story_events:set_text("Enable Story Events")
    story_events:set_tooltip_text("Allows Idrinth to notify the player when reaching specific regions important to him.")
    story_events:set_is_global(false)
    
    local chapels = idrinth:add_new_option("chapels", "checkbox")
    chapels:set_default_value(true)

    chapels:set_text("Chapels")
    chapels:set_tooltip_text("Allows Idrinth to found chapels that strengthen the defences of cities and affect god favor generation.")
    chapels:set_is_global(false)

    local dilemma_cooldown = idrinth:add_new_option("dilemma_cooldown", "dropdown")
    dilemma_cooldown:add_dropdown_values({
        {
            key = "low",
            text = "Low (1 + [1-2])",
        },
        {
            key = "medium",
            text = "Medium (2 + [1-3])",
        },
        {
            key = "long",
            text = "Long (3 + [1-4])",
        }
    })
    dilemma_cooldown:set_default_value("medium")
    dilemma_cooldown:set_text("Dilemma Cooldown")
    dilemma_cooldown:set_tooltip_text("Modifies the cooldown between dilemmas that require decisions.")
    dilemma_cooldown:set_is_global(false)
end;