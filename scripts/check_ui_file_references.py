#!/usr/bin/env python3
"""
Check that all UI files in ui/idrinth are referenced by Lua scripts.

This script detects TWUI XML files that are defined but never referenced
in any Lua script, which may indicate orphaned or unused UI components.

Exit codes:
    0 - All UI files are referenced
    1 - Unreferenced UI files detected
"""

import re
import sys
from pathlib import Path
from typing import Set, Dict, List


# Known dynamic prefixes used in Lua code that get concatenated with variables
# Format: (prefix, list of known suffixes that complete the pattern)
DYNAMIC_PATTERNS: Dict[str, List[str]] = {
    "idrinth_pooled_resource_": ["asuryan", "khaine", "kurnous"],
    "idrinth_button_upgrade_": ["asuryan", "khaine", "kurnous", "size"],
}


def get_project_root() -> Path:
    """Get the project root directory."""
    script_dir = Path(__file__).resolve().parent
    return script_dir.parent


def get_ui_files(ui_path: Path) -> Set[str]:
    """
    Get all UI file names (without extension) from the ui/idrinth directory.

    Returns:
        Set of UI file base names (e.g., "idrinth_button_upgrade_asuryan")
    """
    ui_files = set()

    if not ui_path.exists():
        return ui_files

    for xml_file in ui_path.glob("*.twui.xml"):
        # Remove the .twui.xml extension to get the base name
        base_name = xml_file.name.replace(".twui.xml", "")
        ui_files.add(base_name)

    return ui_files


def extract_string_literals(content: str) -> Set[str]:
    """
    Extract all string literals from Lua code that could be UI file references.

    Looks for patterns like:
        - "idrinth_something"
        - 'idrinth_something'
    """
    literals = set()

    # Match string literals containing "idrinth_"
    patterns = [
        r'"(idrinth_[^"]+)"',
        r"'(idrinth_[^']+)'",
    ]

    for pattern in patterns:
        matches = re.findall(pattern, content)
        literals.update(matches)

    return literals


def extract_createorfind_references(content: str) -> Set[str]:
    """
    Extract UI file references from Idrinth.Ui.createOrFind calls.

    The function signature is:
        createOrFind(name, parent, overwriteAutoFile)

    Where either 'name' (if no overwriteAutoFile) or 'overwriteAutoFile'
    is used as the XML filename.
    """
    references = set()

    # Pattern for createOrFind with 3 arguments (name, parent, overwriteAutoFile)
    # The third argument is the actual file used
    pattern_3_args = re.compile(
        r'createOrFind\s*\(\s*'
        r'["\']([^"\']+)["\']'  # First arg (name)
        r'\s*,\s*[^,]+'  # Second arg (parent)
        r'\s*,\s*["\']([^"\']+)["\']'  # Third arg (overwriteAutoFile)
        r'\s*\)'
    )

    # Pattern for createOrFind with 2 arguments (name, parent)
    # The first argument is used as the file
    pattern_2_args = re.compile(
        r'createOrFind\s*\(\s*'
        r'["\']([^"\']+)["\']'  # First arg (name) - this is the file
        r'\s*,\s*[^,)]+\s*\)'  # Second arg only
    )

    # Pattern for createOrFind with variable references (constants)
    # e.g., createOrFind(PATHS_PANEL, tabPanels)
    pattern_var = re.compile(
        r'createOrFind\s*\(\s*([A-Z_][A-Z0-9_]*)'  # Variable name
        r'\s*,\s*[^,)]+\s*\)'  # Second arg only
    )

    # Find 3-argument calls (overwriteAutoFile is the file)
    for match in pattern_3_args.finditer(content):
        references.add(match.group(2))

    # Find 2-argument calls (name is the file)
    for match in pattern_2_args.finditer(content):
        references.add(match.group(1))

    return references


def extract_constant_definitions(content: str) -> Dict[str, str]:
    """
    Extract local constant definitions that might hold UI file names.

    Looks for patterns like:
        local PATHS_PANEL = "idrinth_character_details_panel_idrinths_paths"
    """
    constants = {}

    # Match local constant = "value" or local constant = 'value'
    pattern = re.compile(
        r'local\s+([A-Z_][A-Z0-9_]*)\s*=\s*["\']([^"\']+)["\']'
    )

    for match in pattern.finditer(content):
        const_name = match.group(1)
        const_value = match.group(2)
        if const_value.startswith("idrinth_"):
            constants[const_name] = const_value

    return constants


def resolve_variable_references(content: str, constants: Dict[str, str]) -> Set[str]:
    """
    Resolve variable references in createOrFind calls to their actual values.
    """
    references = set()

    # Pattern for createOrFind with variable in first position
    pattern = re.compile(
        r'createOrFind\s*\(\s*([A-Z_][A-Z0-9_]*)'
    )

    for match in pattern.finditer(content):
        var_name = match.group(1)
        if var_name in constants:
            references.add(constants[var_name])

    return references


def expand_dynamic_patterns() -> Set[str]:
    """
    Expand known dynamic patterns to their full file names.

    For patterns like "idrinth_pooled_resource_" .. variable,
    expand to all known values (asuryan, khaine, kurnous).
    """
    expanded = set()

    for prefix, suffixes in DYNAMIC_PATTERNS.items():
        for suffix in suffixes:
            expanded.add(prefix + suffix)

    return expanded


def scan_lua_files(script_path: Path) -> Set[str]:
    """
    Scan all Lua files for UI file references.

    Returns:
        Set of UI file names that are referenced
    """
    all_references = set()
    all_constants: Dict[str, str] = {}

    # First pass: collect all constants
    for lua_file in script_path.rglob("*.lua"):
        try:
            with open(lua_file, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()
                constants = extract_constant_definitions(content)
                all_constants.update(constants)
        except IOError:
            continue

    # Second pass: extract references
    for lua_file in script_path.rglob("*.lua"):
        try:
            with open(lua_file, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()

                # Extract direct string literals
                literals = extract_string_literals(content)
                all_references.update(literals)

                # Extract createOrFind references
                createorfind_refs = extract_createorfind_references(content)
                all_references.update(createorfind_refs)

                # Resolve variable references
                var_refs = resolve_variable_references(content, all_constants)
                all_references.update(var_refs)
        except IOError:
            continue

    # Add constant values directly
    all_references.update(all_constants.values())

    # Add expanded dynamic patterns
    all_references.update(expand_dynamic_patterns())

    return all_references


def main() -> int:
    """Main entry point."""
    project_root = get_project_root()
    idrinth_path = project_root / "idrinth"

    ui_path = idrinth_path / "ui" / "idrinth"
    script_path = idrinth_path / "script"

    if not ui_path.exists():
        print(f"Error: UI directory not found: {ui_path}", file=sys.stderr)
        return 1

    if not script_path.exists():
        print(f"Error: Script directory not found: {script_path}", file=sys.stderr)
        return 1

    # Get all UI files
    ui_files = get_ui_files(ui_path)
    print(f"Found {len(ui_files)} UI files in {ui_path}")

    # Scan Lua files for references
    referenced_files = scan_lua_files(script_path)
    print(f"Found {len(referenced_files)} potential UI references in Lua scripts")

    # Find unreferenced UI files
    unreferenced = ui_files - referenced_files

    if unreferenced:
        print(f"\nFound {len(unreferenced)} unreferenced UI files:")
        print("-" * 60)

        for ui_file in sorted(unreferenced):
            print(f"  - {ui_file}.twui.xml")

        print("\n" + "-" * 60)
        print("These files exist in ui/idrinth/ but are not referenced by any Lua script.")
        print("Either add references in Lua code or remove the unused files.")
        return 1
    else:
        print("\nAll UI files are referenced by Lua scripts!")
        return 0


if __name__ == "__main__":
    sys.exit(main())
