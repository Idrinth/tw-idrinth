# Claude Guidelines for tw-idrinth

This file contains instructions for Claude when working on this Total War: Warhammer III mod project.

## Project Overview

Idrinth is a Total War: Warhammer III mod featuring "Idrinth Thalui," a unique character (a fallen High Elf Loremaster turned vampire). Key systems include Divine Favor, Chapels, Narrative Dilemmas, Divine Artifacts, and multi-faction recruitment.

## Repository Structure

- `idrinth/` - Main mod pack
  - `db/` - Database tables (TSV format)
  - `script/` - Lua scripts (core logic)
  - `text/` - English localization (source)
  - `ui/` - User interface files (XML/TWUI)
- `idrinth-{lang}/` - Language packs (de, es, fr, ru, pl, pt, it, cs, tr, no-upkeep)

## Code Conventions

### Lua Style

- Use `snake_case` for functions and variables
- Use `local` for private functions, return a table for public API
- Use `Idrinth.log(message, category)` for debug output
- Add inline comments for complex game mechanics
- Follow the `Idrinth.*` namespace for all module code

### Event Listener Pattern

```lua
core:add_listener(
    "unique_listener_id",
    "EventType",
    function(context)
        return true;  -- Filter condition
    end,
    function(context)
        -- Callback logic
    end,
    true  -- Run once flag
);
```

### Module Structure

```lua
local function private_helper()
    -- implementation
end

local module = {};

function module.public_function()
    private_helper();
end

return module;
```

### Delayed Execution

```lua
cm:callback(function()
    -- Delayed logic
end, 0.5);  -- Delay in seconds
```

## Database Tables (TSV)

- Edit TSV files directly
- Maintain column headers exactly as they appear
- Use tabs as separators (not spaces)
- Located in `idrinth/db/`

## Documentation Sync Requirement

When updating documentation, you MUST update BOTH files in the same commit:
- `README.md` - GitHub documentation (Markdown)
- `readme.steam` - Steam Workshop description (BBCode)

**Steam Size Limit**: `readme.steam` files must be at or below **8000 bytes** (~8000 ASCII chars or ~4000 UTF-8 chars).

## Localization

- English source: `idrinth/text/db/`
- Translations: `idrinth-{lang}/text/db/`
- File format: TSV with `key`, `text`, `tooltip` columns
- Keep keys identical to English source

## Commit Messages

- Use present tense: "Add feature" not "Added feature"
- Be descriptive but concise
- Reference issues if applicable: "Fix #123"

## CI Checks

All these checks must pass:

1. **Lua Linting** (luacheck, selene) - Code quality for Lua files
2. **Translation Validation** (check-unused) - Detects unused translation keys

## Testing

No automated tests. To test:
1. Package the mod using RPFM
2. Load in Total War: Warhammer III
3. Start a new campaign or load a save

Debug logging via MCT options in-game. Logs: `idrinth.YYMMDDHHMMM.log`

## Adding New Lua Modules

1. Create the file in `idrinth/script/idrinth/`
2. Load it in `idrinth/script/campaign/mod/idrinth.lua`
