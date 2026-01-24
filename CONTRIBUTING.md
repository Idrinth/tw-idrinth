# Contributing to Idrinth: Total War Warhammer III Mod

Thank you for your interest in contributing to Idrinth! This guide explains the repository structure and how to contribute effectively.

## Table of Contents

- [Project Overview](#project-overview)
- [Repository Structure](#repository-structure)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Making Changes](#making-changes)
- [Code Conventions](#code-conventions)
- [Localization](#localization)
- [Submitting Changes](#submitting-changes)
- [CI Checks](#ci-checks)

## Project Overview

Idrinth is a Total War: Warhammer III mod featuring "Idrinth Thalui," a unique character - a fallen High Elf Loremaster turned vampire. The mod includes:

- **Divine Favor System**: Balance allegiance between three Elven deities (Khaine, Asuryan, Kurnous)
- **Chapel System**: Build faction-specific chapels affecting gameplay
- **Narrative Dilemmas**: Story-driven decision points
- **Divine Artifact Sets**: Collectible god-aligned items
- **Unique Recruitment**: Recruitability by multiple factions

## Repository Structure

```
tw-idrinth/
├── idrinth/               # Main mod pack content
│   ├── db/                # Game database tables (TSV format)
│   ├── script/            # Lua scripts for mod logic
│   │   ├── idrinth/       # Core mod modules
│   │   ├── campaign/mod/  # Campaign initialization
│   │   └── mct/settings/  # Mod Configuration Tool options
│   ├── text/              # English localization (source)
│   │   └── db/            # English strings
│   ├── ui/                # User interface files (XML)
│   │   └── idrinth/       # Mod-specific UI components
│   ├── variantmeshes/     # 3D mesh variants
│   ├── dependencies_manager_v2.rpfm_reserved  # RPFM dependency config
│   ├── notes.rpfm_reserved.md                 # RPFM project notes
│   └── settings.rpfm_reserved.json            # RPFM project settings
├── idrinth-de/            # German language pack
│   └── text/db/           # German translations
├── idrinth-es/            # Spanish language pack
│   └── text/db/           # Spanish translations
├── idrinth-fr/            # French language pack
│   └── text/db/           # French translations
└── idrinth-ru/            # Russian language pack
    └── text/db/           # Russian translations
```

### Directory Details

#### `idrinth/db/` - Database Tables

Contains 180+ database tables in TSV (Tab-Separated Values) format. These define game mechanics:

- `agent_culture_details_tables/` - Agent/hero configurations
- `building_chains_tables/` - Building upgrade paths
- `character_traits_tables/` - Character trait definitions
- `factions_tables/` - Faction configurations
- `land_units_tables/` - Unit statistics
- `unit_abilities_tables/` - Unit ability definitions

Each table folder contains TSV files that map directly to Total War's database schema.

#### `idrinth/script/` - Lua Scripts

The mod's core logic written in Lua (~3,900 lines across 25 modules):

| Module | Purpose |
|--------|---------|
| `access.lua` | Character lookup utilities |
| `army.lua` | Unit upgrades and WAAAGH system |
| `chapels.lua` | Chapel building mechanics |
| `characterpanel.lua` | Character UI customizations |
| `constants.lua` | Configuration constants |
| `cultures.lua` | Culture-specific logic |
| `factions.lua` | Faction configuration |
| `heroactions.lua` | Hero action implementations |
| `interventions.lua` | Divine intervention system |
| `items.lua` | Artifact/item management |
| `logging.lua` | Debug logging system |
| `multiplayer.lua` | Multiplayer support checks |
| `names.lua` | Unit/building naming |
| `persistence.lua` | Save/load system |
| `pointsofinterest.lua` | Points of interest mechanics |
| `recruitingui.lua` | Recruitment UI updates |
| `renaming.lua` | Entity renaming utilities |
| `resources.lua` | Divine favor resource system |
| `settlementui.lua` | Settlement UI customization |
| `statistics.lua` | Statistics tracking |
| `story.lua` | Dilemma/narrative system |
| `traits.lua` | Trait system and devotion |
| `ui.lua` | UI utility functions |
| `unlocks.lua` | Feature unlock system |
| `version.lua` | Version tracking |

#### `idrinth/text/` and `idrinth-{lang}/text/` - Localization

Localization strings in TSV format organized by language pack:

- `idrinth/text/db/` - English source strings (primary)
- `idrinth-de/text/db/` - German translations
- `idrinth-es/text/db/` - Spanish translations
- `idrinth-fr/text/db/` - French translations
- `idrinth-ru/text/db/` - Russian translations

Each `.loc.tsv` file contains key-value pairs for UI text. Language packs are separated into their own directories to allow independent distribution.

#### `README.md` and `readme.steam` Files - Documentation

Each mod pack directory contains two documentation files that should be kept in sync:

- `README.md` - GitHub repository documentation (Markdown format)
- `readme.steam` - Steam Workshop description (Steam BBCode format)

**Main mod documentation:**
- `idrinth/README.md` - Main mod GitHub description
- `idrinth/readme.steam` - Main mod Steam Workshop description

**Language pack documentation:**
- `idrinth-de/README.md` and `readme.steam` - German language pack
- `idrinth-es/README.md` and `readme.steam` - Spanish language pack
- `idrinth-fr/README.md` and `readme.steam` - French language pack
- `idrinth-ru/README.md` and `readme.steam` - Russian language pack

**Important**: When updating documentation content, you must update **both** `README.md` and `readme.steam` in the same pull request to keep them synchronized. The content should be equivalent, just formatted differently for each platform.

**Important Size Limit**: All `readme.steam` files must be at or below **8000 bytes**. This equals approximately 8000 ASCII characters or 4000 UTF-8 characters (since many UTF-8 characters use 2 bytes). This is a Steam Workshop limitation.

#### `idrinth/ui/` - User Interface

XML-based UI definitions using Total War's TWUI format:

- `battle ui/` - Battle-related UI elements
- `campaign ui/` - Campaign interface elements
- `idrinth/` - Mod-specific UI components (buttons, panels, resources)
- `portraits/` - Character portrait images
- `skins/` - Unit cosmetics
- `units/` - Unit-specific UI elements

## Technology Stack

| Technology | Usage |
|------------|-------|
| **Lua** | Primary scripting language for game logic |
| **XML (TWUI)** | UI definitions in Total War's format |
| **TSV** | Database tables and localization |
| **RPFM** | Mod development/packaging tool |
| **MCT** | In-game mod configuration framework |
| **Git** | Version control |

## Getting Started

### Prerequisites

1. **Total War: Warhammer III** - Required for testing
2. **RPFM** - [Download here](https://github.com/Frodo45127/rpfm) for mod packaging
3. **Text Editor** - Any editor supporting Lua syntax highlighting
4. **Git** - For version control

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Idrinth/tw-idrinth.git
   cd tw-idrinth
   ```

2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. Open the project in RPFM for testing or use a text editor for direct edits

### Testing Changes

There is no automated build process. To test changes:

1. Package the mod using RPFM
2. Load the mod in Total War: Warhammer III
3. Start a new campaign or load a save to test functionality

**Debug Logging**: Enable verbose logging via MCT options in-game. Logs are written to `idrinth.YYMMDDHHMMM.log`.

## Making Changes

### Database Tables (idrinth/db/)

- Edit TSV files directly with a spreadsheet program or text editor
- Maintain column headers exactly as they appear
- Use tabs as separators (not spaces)
- Reference Total War's schema documentation for field meanings

### Lua Scripts (idrinth/script/)

- Follow the existing event-driven architecture
- Use the `Idrinth.*` namespace for all module code
- Add new modules by:
  1. Creating the file in `idrinth/script/idrinth/`
  2. Loading it in `idrinth/script/campaign/mod/idrinth.lua`

### UI Components (idrinth/ui/)

- Use Total War's TWUI XML format
- Place mod-specific components in `idrinth/ui/idrinth/`
- Reference existing files for structure examples

### Localization (idrinth/text/ and idrinth-{lang}/text/)

See the [Localization](#localization) section below.

## Code Conventions

### Lua Style

- **Naming**: `snake_case` for functions and variables
- **Scope**: Use `local` for private functions, return a table for public API
- **Logging**: Use `Idrinth.log(message, category)` for debug output
- **Comments**: Add inline comments for complex game mechanics

### Event Listeners

Use the standard listener pattern:

```lua
core:add_listener(
    "unique_listener_id",
    "EventType",
    function(context)
        -- Filter condition
        return true;
    end,
    function(context)
        -- Callback logic
    end,
    true -- Run once flag
);
```

### Module Structure

```lua
-- Private functions
local function private_helper()
    -- implementation
end

-- Public API
local module = {};

function module.public_function()
    private_helper();
end

return module;
```

### Callbacks

Use `cm:callback()` for delayed execution:

```lua
cm:callback(function()
    -- Delayed logic
end, 0.5); -- Delay in seconds
```

## Localization

### Adding Translations

1. Create/edit files in the appropriate language pack directory:
   - German: `idrinth-de/text/db/`
   - Spanish: `idrinth-es/text/db/`
   - French: `idrinth-fr/text/db/`
   - Russian: `idrinth-ru/text/db/`

2. Mirror the structure of English source files in `idrinth/text/db/`

3. Use the same keys as the English source

### File Format

Localization files use TSV format:

```
key	text	tooltip
idrinth_trait_name	Translated Name	false
idrinth_trait_desc	Translated Description	true
```

### Language Code Mapping (TW:WH3 Convention)

The project uses Total War: Warhammer III's standard language codes in file names:

| Code | Language |
|------|----------|
| (none) | English (default) |
| `br` | Brazilian Portuguese |
| `cn` | Simplified Chinese |
| `cz` | Czech |
| `de` | German |
| `es` | Spanish |
| `fr` | French |
| `it` | Italian |
| `kr` | Korean |
| `pl` | Polish |
| `ru` | Russian |
| `tr` | Turkish |
| `zh` | Traditional Chinese |

File naming example: `idrinth_traits__.loc.tsv` (English), `idrinth_traits__de.loc.tsv` (German)

### Adding a New Language

1. Create a new directory: `idrinth-XX/text/db/` (where XX is the language code from the table above)
2. Copy the structure from `idrinth/text/db/`
3. Translate all strings while keeping keys identical

## Submitting Changes

### Pull Request Process

1. Ensure your code follows the conventions above
2. Test changes in-game
3. If updating documentation, ensure both `README.md` and `readme.steam` are updated in the same PR
4. Commit with clear, descriptive messages:
   ```bash
   git commit -m "Add new chapel building for Khaine"
   ```

5. Push your branch:
   ```bash
   git push -u origin feature/your-feature-name
   ```

6. Open a Pull Request with:
   - Clear description of changes
   - Testing steps performed
   - Screenshots if UI changes are involved

### Commit Message Guidelines

- Use present tense: "Add feature" not "Added feature"
- Be descriptive but concise
- Reference issues if applicable: "Fix #123"

### Version Numbering

The project uses semantic versioning (MAJOR.MINOR.PATCH):
- **MAJOR**: Breaking changes or major feature additions
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes and minor improvements

## CI Checks

Pull requests are automatically validated by GitHub Actions. All checks must pass before merging.

### Lua Linting (runs when Lua files change)

Two linters analyze Lua code quality:

- **luacheck**: Detects undefined globals, unused variables, and common coding issues
- **selene**: Static analyzer that catches additional Lua code problems

### Translation Validation

- **check-unused**: Scans for translation keys defined in `text/db/` that are not referenced anywhere in the codebase, helping keep localization files clean

### Fixing CI Failures

If a CI check fails on your PR:

1. Click "Details" on the failed check to see the error output
2. For Lua linting errors, fix the reported issues in your code
3. For unused translation errors, remove the unused keys or add proper references
4. Commit and push the fixes to update your PR

## Community

- **Discord**: [https://discord.gg/idrinth](https://discord.gg/idrinth)
- **Issues**: Report bugs or request features via GitHub Issues

## Questions?

If you have questions about contributing, feel free to:
- Open a GitHub Issue
- Ask in the Discord community
- Review existing code for patterns and examples

Thank you for contributing to Idrinth!
