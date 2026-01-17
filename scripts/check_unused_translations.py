#!/usr/bin/env python3
"""
Check for unused translation keys in the Idrinth mod.

This script detects translation keys defined in .loc.tsv files that are not
referenced by database tables, Lua scripts, or TWUI XML files.

Exit codes:
    0 - No unused translations found
    1 - Unused translations detected
"""

import re
import sys
from pathlib import Path
from typing import Set, Dict, List, Tuple


# Define the mapping from database table types to translation key patterns
# Format: table_name -> [(prefix, suffix_list)]
# The translation keys are constructed as: prefix + suffix + db_key
DB_TABLE_MAPPINGS: Dict[str, List[Tuple[str, List[str]]]] = {
    "ancillaries_tables": [
        ("ancillaries_", ["onscreen_name_", "colour_text_", "explanation_text_"])
    ],
    "ancillary_sets_tables": [
        ("ancillary_sets_", ["name_", "description_"])
    ],
    "agent_subtypes_tables": [
        ("agent_subtypes_", ["onscreen_name_", "description_text_override_"])
    ],
    "agent_culture_details_tables": [
        ("agent_culture_details_", ["onscreen_name_", "description_text_"])
    ],
    "agent_recruitment_categories_tables": [
        ("agent_recruitment_categories_", ["onscreen_name_"])
    ],
    "building_chains_tables": [
        ("building_chains_", ["chain_tooltip_", "encyclopedia_name_", "encyclopedia_group_", "encyclopedia_description_"])
    ],
    "building_culture_variants_tables": [
        ("building_culture_variants_", ["name_", "description_"])
    ],
    "building_sets_tables": [
        ("building_sets_", ["onscreen_name_", "onscreen_description_"])
    ],
    "building_short_description_texts_tables": [
        ("building_short_description_texts_", ["short_description_"])
    ],
    "character_trait_levels_tables": [
        ("character_trait_levels_", ["onscreen_name_", "colour_text_", "explanation_text_", "removal_text_"])
    ],
    "character_skills_tables": [
        ("character_skills_", ["localised_name_", "localised_description_"])
    ],
    "cultures_tables": [
        ("cultures_", ["name_", "frontend_description_"])
    ],
    "cultures_subcultures_tables": [
        ("cultures_subcultures_", ["name_", "battle_playstyle_description_", "confederation_screen_name_", "confederation_summary_name_"])
    ],
    "dilemmas_tables": [
        ("dilemmas_", ["localised_title_", "localised_description_"])
    ],
    # Note: cdir_events_dilemma_choice_details is handled specially in generate_expected_translation_keys
    "effect_bundles_tables": [
        ("effect_bundles_", ["localised_title_", "localised_description_"])
    ],
    "effects_tables": [
        ("effects_", ["description_"])
    ],
    "effects_additional_tooltip_details_tables": [
        ("effects_additional_tooltip_details_", ["localised_description_"])
    ],
    "factions_tables": [
        ("factions_", ["screen_name_", "screen_adjective_", "screen_name_when_rebels_", "attack_desc_", "defend_desc_"])
    ],
    "initiative_sets_tables": [
        ("initiative_sets_", ["localised_name_", "localised_description_"])
    ],
    "initiative_set_categories_tables": [
        ("initiative_set_categories_", ["display_name_"])
    ],
    "initiatives_tables": [
        ("initiatives_", ["localised_name_", "localised_description_"])
    ],
    "land_units_tables": [
        ("land_units_", ["onscreen_name_", "concealed_name_"])
    ],
    "missions_tables": [
        ("missions_", ["localised_title_", "localised_description_", "localised_mission_completed_text_"])
    ],
    "message_event_strings_tables": [
        ("message_event_strings_", ["text_"])
    ],
    "pooled_resources_tables": [
        ("pooled_resources_", ["display_name_", "description_", "positive_factors_display_name_", "negative_factors_display_name_"])
    ],
    "special_ability_groups_tables": [
        ("special_ability_groups_", ["name_"])
    ],
    "special_ability_phases_tables": [
        ("special_ability_phases_", ["onscreen_name_", "description_"])
    ],
    "technology_node_sets_tables": [
        ("technology_node_sets_", ["localised_name_", "encyclopaedia_string_", "tooltip_string_"])
    ],
    "ui_unit_groupings_tables": [
        ("ui_unit_groupings_", ["onscreen_"])
    ],
    "unit_abilities_tables": [
        ("unit_abilities_", ["onscreen_name_", "tooltip_text_"])
    ],
    "unit_description_historical_texts_tables": [
        ("unit_description_historical_texts_", ["text_"])
    ],
    "unit_description_short_texts_tables": [
        ("unit_description_short_texts_", ["text_"])
    ],
    "names_tables": [
        ("names_", ["name_"])
    ],
}

# Translation prefixes for special file types that don't follow the standard pattern
SPECIAL_PREFIXES = [
    "mct_idrinth_",
    "campaign_localised_strings_string_",
    "campaign_payload_ui_details_",
    "uied_component_texts_",
    "upgrade_tooltips_",
]


def get_project_root() -> Path:
    """Get the project root directory."""
    script_dir = Path(__file__).resolve().parent
    return script_dir.parent


def read_translation_keys(text_db_path: Path) -> Set[str]:
    """Read all translation keys from .loc.tsv files."""
    keys = set()

    for tsv_file in text_db_path.glob("*.loc.tsv"):
        with open(tsv_file, "r", encoding="utf-8") as f:
            for line_num, line in enumerate(f, 1):
                # Skip header and comment lines
                if line_num == 1 or line.startswith("#"):
                    continue

                parts = line.strip().split("\t")
                if parts and parts[0]:
                    keys.add(parts[0])

    return keys


def read_db_keys(db_path: Path) -> Dict[str, Set[str]]:
    """Read database keys from TSV files, organized by table type."""
    table_keys: Dict[str, Set[str]] = {}

    for table_dir in db_path.iterdir():
        if not table_dir.is_dir():
            continue

        table_name = table_dir.name
        tsv_file = table_dir / "idrinth.tsv"

        if not tsv_file.exists():
            continue

        keys = set()
        with open(tsv_file, "r", encoding="utf-8") as f:
            header = None
            key_index = 0

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    # Find the 'key' column index
                    if "key" in header:
                        key_index = header.index("key")
                    continue

                # Skip comment lines
                if line.startswith("#"):
                    continue

                if parts and len(parts) > key_index and parts[key_index]:
                    keys.add(parts[key_index])

        if keys:
            table_keys[table_name] = keys

    return table_keys


def read_composite_db_keys(db_path: Path) -> Dict[str, Set[str]]:
    """
    Read composite keys from special database tables.
    These tables have translation keys built from multiple columns.
    """
    composite_keys: Dict[str, Set[str]] = {}

    # cdir_events_dilemma_choice_details: translation key = dilemma_key + choice_key
    choice_details_file = db_path / "cdir_events_dilemma_choice_details_tables" / "idrinth.tsv"
    if choice_details_file.exists():
        keys = set()
        with open(choice_details_file, "r", encoding="utf-8") as f:
            header = None
            choice_key_idx = 0
            dilemma_key_idx = 1

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    if "choice_key" in header:
                        choice_key_idx = header.index("choice_key")
                    if "dilemma_key" in header:
                        dilemma_key_idx = header.index("dilemma_key")
                    continue

                if line.startswith("#"):
                    continue

                if parts and len(parts) > max(choice_key_idx, dilemma_key_idx):
                    choice_key = parts[choice_key_idx]
                    dilemma_key = parts[dilemma_key_idx]
                    # Composite key: dilemma_key + choice_key (no separator)
                    keys.add(f"{dilemma_key}{choice_key}")

        if keys:
            composite_keys["cdir_events_dilemma_choice_details_tables"] = keys

    # Also generate choice label keys from dilemmas_tables directly
    # The game may auto-lookup choice labels for dilemmas even without explicit choice_details entries
    dilemmas_file = db_path / "dilemmas_tables" / "idrinth.tsv"
    if dilemmas_file.exists():
        dilemma_keys = set()
        with open(dilemmas_file, "r", encoding="utf-8") as f:
            header = None
            key_idx = 0

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    if "key" in header:
                        key_idx = header.index("key")
                    continue

                if line.startswith("#"):
                    continue

                if parts and len(parts) > key_idx and parts[key_idx]:
                    dilemma_key = parts[key_idx]
                    # Generate possible choice labels (FIRST, SECOND, THIRD)
                    for choice in ["FIRST", "SECOND", "THIRD"]:
                        dilemma_keys.add(f"{dilemma_key}{choice}")

        if dilemma_keys:
            if "cdir_events_dilemma_choice_details_tables" in composite_keys:
                composite_keys["cdir_events_dilemma_choice_details_tables"].update(dilemma_keys)
            else:
                composite_keys["cdir_events_dilemma_choice_details_tables"] = dilemma_keys

    return composite_keys


def read_column_referenced_keys(db_path: Path) -> Set[str]:
    """
    Read translation keys referenced in specific database columns.
    Some tables have columns that directly reference translation key identifiers.
    """
    referenced_keys = set()

    # agent_actions_tables: unique_id column generates effects_additional_tooltip_details keys
    agent_actions_file = db_path / "agent_actions_tables" / "idrinth.tsv"
    if agent_actions_file.exists():
        with open(agent_actions_file, "r", encoding="utf-8") as f:
            header = None
            unique_id_idx = 0

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    if "unique_id" in header:
                        unique_id_idx = header.index("unique_id")
                    continue

                if line.startswith("#"):
                    continue

                if parts and len(parts) > unique_id_idx and parts[unique_id_idx]:
                    unique_id = parts[unique_id_idx]
                    # Generate the effects_additional_tooltip_details translation key
                    referenced_keys.add(f"effects_additional_tooltip_details_localised_description_{unique_id}")

    # building_culture_variants has 'short_description' column that references
    # building_short_description_texts keys, and 'icon' column for shared names
    bcv_file = db_path / "building_culture_variants_tables" / "idrinth.tsv"
    if bcv_file.exists():
        with open(bcv_file, "r", encoding="utf-8") as f:
            header = None
            short_desc_idx = -1
            icon_idx = -1

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    if "short_description" in header:
                        short_desc_idx = header.index("short_description")
                    if "icon" in header:
                        icon_idx = header.index("icon")
                    continue

                if line.startswith("#"):
                    continue

                if short_desc_idx >= 0 and len(parts) > short_desc_idx and parts[short_desc_idx]:
                    # Generate the translation key from short_description value
                    short_desc = parts[short_desc_idx]
                    referenced_keys.add(f"building_short_description_texts_short_description_{short_desc}")

                if icon_idx >= 0 and len(parts) > icon_idx and parts[icon_idx]:
                    # The icon column contains shared translation key references
                    icon = parts[icon_idx]
                    referenced_keys.add(f"building_culture_variants_name_{icon}")
                    referenced_keys.add(f"building_culture_variants_description_{icon}")

    # land_units has historical_description_text and short_description_text columns
    # that reference unit_description keys
    lu_file = db_path / "land_units_tables" / "idrinth.tsv"
    if lu_file.exists():
        with open(lu_file, "r", encoding="utf-8") as f:
            header = None
            hist_desc_idx = -1
            short_desc_idx = -1

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    if "historical_description_text" in header:
                        hist_desc_idx = header.index("historical_description_text")
                    if "short_description_text" in header:
                        short_desc_idx = header.index("short_description_text")
                    continue

                if line.startswith("#"):
                    continue

                if hist_desc_idx >= 0 and len(parts) > hist_desc_idx and parts[hist_desc_idx]:
                    value = parts[hist_desc_idx]
                    referenced_keys.add(f"unit_description_historical_texts_text_{value}")

                if short_desc_idx >= 0 and len(parts) > short_desc_idx and parts[short_desc_idx]:
                    value = parts[short_desc_idx]
                    referenced_keys.add(f"unit_description_short_texts_text_{value}")

    # main_units_tables has a land_unit column that references land_units for translation
    # Also the unit column itself can be used for translation lookups
    mu_file = db_path / "main_units_tables" / "idrinth.tsv"
    if mu_file.exists():
        with open(mu_file, "r", encoding="utf-8") as f:
            header = None
            unit_idx = -1
            land_unit_idx = -1

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    if "unit" in header:
                        unit_idx = header.index("unit")
                    if "land_unit" in header:
                        land_unit_idx = header.index("land_unit")
                    continue

                if line.startswith("#"):
                    continue

                # The unit column (main unit key) can also be used for translation lookups
                if unit_idx >= 0 and len(parts) > unit_idx and parts[unit_idx]:
                    unit = parts[unit_idx]
                    referenced_keys.add(f"land_units_onscreen_name_{unit}")
                    referenced_keys.add(f"land_units_concealed_name_{unit}")

                if land_unit_idx >= 0 and len(parts) > land_unit_idx and parts[land_unit_idx]:
                    land_unit = parts[land_unit_idx]
                    # main_units reference land_units for their translation keys
                    referenced_keys.add(f"land_units_onscreen_name_{land_unit}")
                    referenced_keys.add(f"land_units_concealed_name_{land_unit}")

    # special_ability_phases may use shared base keys (without _multi/_single suffix)
    sap_file = db_path / "special_ability_phases_tables" / "idrinth.tsv"
    if sap_file.exists():
        with open(sap_file, "r", encoding="utf-8") as f:
            header = None
            key_idx = 0

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    if "key" in header:
                        key_idx = header.index("key")
                    continue

                if line.startswith("#"):
                    continue

                if parts and len(parts) > key_idx and parts[key_idx]:
                    key = parts[key_idx]
                    # Also add the base key without _multi/_single suffix
                    for suffix in ["_multi", "_single"]:
                        if key.endswith(suffix):
                            base_key = key[:-len(suffix)]
                            referenced_keys.add(f"special_ability_phases_onscreen_name_{base_key}")
                            referenced_keys.add(f"special_ability_phases_description_{base_key}")

    return referenced_keys


def generate_expected_translation_keys(
    table_keys: Dict[str, Set[str]],
    composite_keys: Dict[str, Set[str]]
) -> Set[str]:
    """Generate expected translation keys from database table keys."""
    expected_keys = set()

    for table_name, db_keys in table_keys.items():
        if table_name in DB_TABLE_MAPPINGS:
            for prefix, suffixes in DB_TABLE_MAPPINGS[table_name]:
                for db_key in db_keys:
                    for suffix in suffixes:
                        expected_keys.add(f"{prefix}{suffix}{db_key}")
                        # For effects_tables, also generate keys without 'enable_' prefix
                        # e.g., effect key 'idrinth_effect_agent_action_enable_assist_army_training'
                        # can have translation key 'effects_description_idrinth_effect_agent_action_assist_army_training'
                        if table_name == "effects_tables" and "_enable_" in db_key:
                            key_without_enable = db_key.replace("_enable_", "_", 1)
                            expected_keys.add(f"{prefix}{suffix}{key_without_enable}")

    # Handle composite keys
    for table_name, comp_keys in composite_keys.items():
        if table_name == "cdir_events_dilemma_choice_details_tables":
            for comp_key in comp_keys:
                expected_keys.add(f"cdir_events_dilemma_choice_details_localised_choice_label_{comp_key}")

    return expected_keys


def scan_lua_for_translation_keys(script_path: Path, all_translation_keys: Set[str]) -> Set[str]:
    """Scan Lua files for translation key references."""
    found_keys = set()

    # Patterns to match translation key usage in Lua
    patterns = [
        # common.get_localised_string("key") or common.get_localised_string('key')
        re.compile(r'get_localised_string\s*\(\s*["\']([^"\']+)["\']'),
        # String concatenation patterns like "prefix_" .. variable
        re.compile(r'["\']([a-z_]+)["\']\s*\.\.\s*'),
        # Direct string literals that look like translation keys (containing idrinth)
        re.compile(r'["\']([a-z][a-z0-9_]*idrinth[a-z0-9_]*)["\']'),
        # upgrade_tooltips keys used in army.lua
        re.compile(r'["\']((upgrade_tooltips|mct)_[a-z0-9_]+)["\']'),
    ]

    for lua_file in script_path.rglob("*.lua"):
        try:
            with open(lua_file, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()

                for pattern in patterns:
                    matches = pattern.findall(content)
                    for match in matches:
                        # Handle tuple matches from patterns with groups
                        key = match[0] if isinstance(match, tuple) else match
                        # Check if this is a known translation key
                        if key in all_translation_keys:
                            found_keys.add(key)
                        # Also check for prefix patterns that are used with concatenation
                        for trans_key in all_translation_keys:
                            if trans_key.startswith(key):
                                found_keys.add(trans_key)
        except IOError:
            continue

    return found_keys


def scan_lua_for_dynamic_keys(script_path: Path, all_translation_keys: Set[str]) -> Set[str]:
    """
    Scan Lua files for dynamic key patterns.
    These are keys built by concatenating strings like:
        "land_units_onscreen_name_" .. unitKey
        "mct_idrinth_"..key.."_options_"..vkey.."_text"
    """
    found_keys = set()

    # Known dynamic prefixes used in Lua code
    dynamic_prefixes = [
        "land_units_onscreen_name_",
        "land_units_concealed_name_",
        "effect_bundles_localised_title_",
        "effect_bundles_localised_description_",
        "character_trait_levels_onscreen_name_",
        "building_culture_variants_name_",
        "building_culture_variants_description_",
        "ancillaries_onscreen_name_",
        "special_ability_groups_onscreen_name_",
        # MCT dynamic patterns
        "mct_idrinth_",
    ]

    for lua_file in script_path.rglob("*.lua"):
        try:
            with open(lua_file, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()

                # Check for each dynamic prefix in the Lua content
                for prefix in dynamic_prefixes:
                    if prefix in content:
                        # Mark all translation keys with this prefix as potentially used
                        for key in all_translation_keys:
                            if key.startswith(prefix):
                                found_keys.add(key)
        except IOError:
            continue

    return found_keys


def scan_db_for_direct_references(db_path: Path, all_translation_keys: Set[str]) -> Set[str]:
    """
    Scan database TSV files for direct translation key references.
    Some columns directly contain translation keys.
    """
    found_keys = set()

    # Columns that contain direct translation key references
    key_columns = [
        "historical_description_text",
        "short_description_text",
        "localised_name",
        "localised_description",
        "localised_title",
    ]

    for table_dir in db_path.iterdir():
        if not table_dir.is_dir():
            continue

        tsv_file = table_dir / "idrinth.tsv"
        if not tsv_file.exists():
            continue

        with open(tsv_file, "r", encoding="utf-8") as f:
            header = None
            col_indices = []

            for line_num, line in enumerate(f, 1):
                parts = line.strip().split("\t")

                if line_num == 1:
                    header = parts
                    # Find columns that might contain direct key references
                    for i, col in enumerate(header):
                        if col in key_columns:
                            col_indices.append(i)
                    continue

                if line.startswith("#"):
                    continue

                # Check each key column for direct references
                for idx in col_indices:
                    if len(parts) > idx and parts[idx]:
                        value = parts[idx]
                        if value in all_translation_keys:
                            found_keys.add(value)

    return found_keys


def scan_twui_for_translation_keys(ui_path: Path, all_translation_keys: Set[str]) -> Set[str]:
    """
    Scan TWUI XML files for translation key references.
    These files use patterns like:
        - {{tr:key_name}} for tooltips
        - Loc(&quot;key_name&quot;) or Loc("key_name") in context functions
    """
    found_keys = set()

    # Pattern for {{tr:key_name}}
    tr_pattern = re.compile(r'\{\{tr:([^}]+)\}\}')
    # Pattern for Loc(&quot;key_name&quot;) - HTML-encoded quotes
    loc_html_pattern = re.compile(r'Loc\(&quot;([^&]+)&quot;\)')
    # Pattern for Loc("key_name") - regular quotes (in case any exist)
    loc_pattern = re.compile(r'Loc\(["\']([^"\']+)["\']\)')

    for twui_file in ui_path.rglob("*.twui.xml"):
        try:
            with open(twui_file, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()

                # Find {{tr:key}} patterns
                for match in tr_pattern.findall(content):
                    if match in all_translation_keys:
                        found_keys.add(match)

                # Find Loc(&quot;key&quot;) patterns (HTML-encoded)
                for match in loc_html_pattern.findall(content):
                    if match in all_translation_keys:
                        found_keys.add(match)

                # Find Loc("key") patterns (regular quotes)
                for match in loc_pattern.findall(content):
                    if match in all_translation_keys:
                        found_keys.add(match)
        except IOError:
            continue

    return found_keys


def main() -> int:
    """Main entry point."""
    project_root = get_project_root()
    idrinth_path = project_root / "idrinth"

    text_db_path = idrinth_path / "text" / "db"
    db_path = idrinth_path / "db"
    script_path = idrinth_path / "script"
    ui_path = idrinth_path / "ui"

    if not text_db_path.exists():
        print(f"Error: Translation directory not found: {text_db_path}", file=sys.stderr)
        return 1

    if not db_path.exists():
        print(f"Error: Database directory not found: {db_path}", file=sys.stderr)
        return 1

    all_translation_keys = read_translation_keys(text_db_path)
    table_keys = read_db_keys(db_path)
    composite_keys = read_composite_db_keys(db_path)
    expected_from_db = generate_expected_translation_keys(table_keys, composite_keys)
    lua_direct_refs = scan_lua_for_translation_keys(script_path, all_translation_keys)
    lua_dynamic_refs = scan_lua_for_dynamic_keys(script_path, all_translation_keys)
    lua_refs = lua_direct_refs | lua_dynamic_refs
    db_direct_refs = scan_db_for_direct_references(db_path, all_translation_keys)
    column_refs = read_column_referenced_keys(db_path)
    twui_refs = scan_twui_for_translation_keys(ui_path, all_translation_keys)

    # Combine all used keys
    used_keys = expected_from_db | lua_refs | db_direct_refs | column_refs | twui_refs

    # Special prefixes are always considered used (MCT, UI components, etc.)
    for key in all_translation_keys:
        for prefix in SPECIAL_PREFIXES:
            if key.startswith(prefix):
                used_keys.add(key)
                break

    # Find unused keys
    unused_keys = all_translation_keys - used_keys

    if unused_keys:
        print(f"\nFound {len(unused_keys)} unused translation keys:")
        print("-" * 60)

        # Group by prefix for better readability
        grouped: Dict[str, List[str]] = {}
        for key in sorted(unused_keys):
            # Extract prefix (everything before the last underscore-separated identifier)
            parts = key.split("_")
            if len(parts) >= 3:
                prefix = "_".join(parts[:2])
            else:
                prefix = "other"

            if prefix not in grouped:
                grouped[prefix] = []
            grouped[prefix].append(key)

        for prefix in sorted(grouped.keys()):
            print(f"\n{prefix}:")
            for key in grouped[prefix]:
                print(f"  - {key}")

        print("\n" + "-" * 60)
        print(f"Total unused: {len(unused_keys)}")
        return 1
    else:
        print("\nNo unused translation keys found!")
        return 0


if __name__ == "__main__":
    sys.exit(main())
