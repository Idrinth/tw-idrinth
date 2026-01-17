--- @module Idrinth.Access
--- Character access and lookup module.
--- Provides functions to find and check for the Idrinth character across factions.
--- Caches the character CQI for efficient repeated lookups.
--- @return table Module with get and spawned functions.

--- Searches a faction for an Idrinth character (hero or lord).
--- @param faction userdata The faction object to search within.
--- @return userdata|nil The Idrinth character if found, nil otherwise.
local getIdrinthFromFaction = function(faction)
    local idrinthChampion = cm:get_most_recently_created_character_of_type(
        faction:name(), Idrinth.Constants.HeroType, Idrinth.Constants.HeroSubtype
    );
    if idrinthChampion then
        return idrinthChampion;
    end;
    local idrinthGeneral = cm:get_most_recently_created_character_of_type(
        faction:name(), Idrinth.Constants.LordType, Idrinth.Constants.LordSubtype
    );
    if idrinthGeneral then
        return idrinthGeneral;
    end;
    return nil;
end;
local cqi = nil;

local access = {};

--- Gets the Idrinth character, optionally filtering by faction.
--- @param requiredFaction userdata|nil If provided, only returns Idrinth if in this faction.
--- @return userdata|nil character The Idrinth character or nil.
--- @return userdata|nil faction The faction Idrinth belongs to or nil.
--- @return string|nil culture The culture key of the faction or nil.
access.get = function(requiredFaction)
    if cqi then
        local idrinth = cm:get_character_by_cqi(cqi);
        if idrinth then
            if requiredFaction and idrinth:faction() ~= requiredFaction then
                return nil, nil, nil;
            end;
            return idrinth, idrinth:faction(), idrinth:faction():culture();
        end;
        cqi = nil;
    end;
    if requiredFaction and not Idrinth.Cultures.isAllowed(requiredFaction:culture()) then
        return nil, nil, nil;
    end;
    for _, culture in pairs(Idrinth.Cultures.get()) do
        local factions = cm:get_factions_by_culture(culture);
        if factions then
            for _, faction in pairs(factions) do
                if not requiredFaction or faction == requiredFaction then
                    local idrinth = getIdrinthFromFaction(faction);
                    if idrinth then
                        cqi = idrinth:cqi();
                        return idrinth, faction, culture;
                    end;
                end;
            end;
        end;
    end;
    cqi = nil;
    return nil, nil, nil;
end;
--- Checks if Idrinth has been spawned in any allowed faction.
--- @return boolean True if Idrinth exists, false otherwise.
access.spawned = function()
    local character = access.get();
    return character ~= nil;
end;
return access;