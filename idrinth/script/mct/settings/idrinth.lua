--- @module MCT.Idrinth
--- Mod Configuration Tool (MCT) settings definition for the Idrinth mod.
--- Provides user-configurable options for spawn settings, features, cooldowns, and chances.

--- Adds a dropdown option to an MCT mod.
--- @param mod userdata The MCT mod object.
--- @param key string The option key.
--- @param values table Array of value keys for the dropdown.
--- @param defaultValue string The default value key.
--- @param global boolean Whether the option is global.
--- @return userdata The created dropdown option.
local addDropdown = function(mod, key, values, defaultValue, global)
    local dropdown = mod:add_new_option(key, "dropdown");
    local dropdownValues = {};
    for _, vkey in pairs(values) do
        table.insert(dropdownValues, {
            key = vkey,
            text = "mct_idrinth_"..key.."_options_"..vkey.."_text",
        });
    end;
    dropdown:add_dropdown_values(dropdownValues);
    dropdown:set_default_value(defaultValue);
    dropdown:set_is_global(global);
    return dropdown;
end;
--- Adds a checkbox option to an MCT mod.
--- @param mod userdata The MCT mod object.
--- @param key string The option key.
--- @param defaultValue boolean The default value.
--- @param global boolean Whether the option is global.
--- @return userdata The created checkbox option.
local addCheckbox = function(mod, key, defaultValue, global)
    local checkbox = mod:add_new_option(key, "checkbox");
    checkbox:set_default_value(defaultValue);
    checkbox:set_is_global(global);
    return checkbox;
end;
--- Adds a section with multiple options to an MCT mod.
--- @param mod userdata The MCT mod object.
--- @param key string The section key.
--- @param elements table Map of element keys to config objects (element type, values, default).
--- @param global boolean Whether options in this section are global.
local addSection = function(mod, key, elements, global)
    mod:add_new_section(key, "mct_idrinth_section_"..key.."_name");
    for elementKey, config in pairs(elements) do
        if config.element == "checkbox" then
           addCheckbox(mod, elementKey, config.default, global);
        elseif config.element == "dropdown" then
            addDropdown(mod, elementKey, config.values, config.default, global);
        end;
    end;
end;

local mct = get_mct();
if mct then
    local idrinth = mct:register_mod("idrinth");
    idrinth:set_workshop_id("3449820771");
    local version = require("script/idrinth/version");
    idrinth:set_version(version.iteration, version.main .. "." .. version.feature .. "." .. version.bug);
    idrinth:set_main_image("ui/flags/idrinth_hev_high_elf_vampires/mon_256.png", 256, 256);

    addSection(idrinth, "idrinth_spawn", {
        expanded_spawn = {
            element = "checkbox",
            default = false,
        },
        level_adjustment = {
            element = "dropdown",
            values = {"null", "one", "three", "six"},
            default = "null"
        },
        god_item_difficulty = {
            element = "dropdown",
            values = {"low", "normal", "high"},
            default = "normal"
        },
        chapel_chance = {
            element = "dropdown",
            values = {"low", "normal", "high"},
            default = "normal"
        },
    }, false);
    addSection(idrinth, "idrinth_features", {
        story_events = {
            element = "checkbox",
            default = true,
        },
        chapels = {
            element = "checkbox",
            default = true,
        },
        names = {
            element = "checkbox",
            default = true,
        },
        animal_waaagh = {
            element = "checkbox",
            default = true,
        },
        elf_slayer_traits = {
            element = "checkbox",
            default = true,
        },
        devotion_traits = {
            element = "checkbox",
            default = true,
        },
        interventions = {
            element = "checkbox",
            default = true,
        },
    }, false);
    addSection(idrinth, "idrinth_other", {
        logging = {
            element = "checkbox",
            default = false,
        },
        base_logging = {
            element = "checkbox",
            default = false,
        };
    }, true);
    addSection(idrinth, "idrinth_cooldowns", {
        dilemma_cooldown = {
            element = "dropdown",
            values = {"low", "medium", "long"},
            default = "medium"
        },
        intervention_cooldown = {
            element = "dropdown",
            values = {"low", "medium", "long"},
            default = "medium"
        };
    }, false);
    addSection(idrinth, "idrinth_chances", {
        vampire_chance = {
            element = "dropdown",
            values = {"low", "normal", "high"},
            default = "normal"
        },
        story_dilemma_base_chance = {
            element = "dropdown",
            values = {"low", "normal", "high"},
            default = "normal"
        },
        god_item_base_chance = {
            element = "dropdown",
            values = {"low", "normal", "high"},
            default = "normal"
        },
    }, false);
end;