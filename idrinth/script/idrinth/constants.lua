--- @module Idrinth.Constants
--- Configuration constants for the Idrinth mod.
--- Contains character types, unit prefixes, god names, culture keys, panel names, and dilemma keys.
--- @return table Constants table with BaseType, HeroType, LordType, UnitPrefix, Gods, Cultures, Panels, etc.

local BaseType = "idrinth_hev_high_elf_vampires_idrinth";
local HeroType = "champion";
local LordType = "general";
local UnitPrefix = "idrinth_hev_high_elf_vampires_";
local ChapelPrefix = UnitPrefix .. "chapel_";

-- God names
local Gods = {
    Asuryan = "asuryan",
    Kurnous = "kurnous",
    Khaine = "khaine",
};
local GodList = { Gods.Asuryan, Gods.Kurnous, Gods.Khaine };

-- Culture keys
local Cultures = {
    HighElves = "wh2_main_hef_high_elves",
    WoodElves = "wh_dlc05_wef_wood_elves",
    Empire = "wh_main_emp_empire",
    Kislev = "wh3_main_ksl_kislev",
    VampireCounts = "wh_main_vmp_vampire_counts",
    Nagash = "mixer_nag_nagash",
    DarkElves = "wh2_main_def_dark_elves",
    VampireCoast = "wh2_dlc11_cst_vampire_coast",
    Bretonnia = "wh_main_brt_bretonnia",
    Cathay = "wh3_main_cth_cathay",
};

-- Panel names
local Panels = {
    CharacterDetails = "character_details_panel",
    Units = "units_panel",
    Settlement = "settlement_panel",
    HudCampaign = "hud_campaign",
};

-- MCT
local MctModKey = "idrinth";

-- Dilemma keys
local UnlockDilemma = "idrinth_unlock_choice";

return {
    BaseType = BaseType,
    HeroType = HeroType,
    LordType = LordType,
    HeroSubtype = BaseType .. HeroType,
    LordSubtype = BaseType .. LordType,
    UnitPrefix = UnitPrefix,
    ChapelPrefix = ChapelPrefix,
    Gods = Gods,
    GodList = GodList,
    Cultures = Cultures,
    Panels = Panels,
    MctModKey = MctModKey,
    UnlockDilemma = UnlockDilemma,
};