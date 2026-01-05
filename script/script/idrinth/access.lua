local getIdrinthFromFaction = function(faction)
    local idrinthChampion = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth.Constants.HeroType, Idrinth.Constants.HeroSubtype);
    if idrinthChampion then
        return idrinthChampion;
    end;
    local idrinthGeneral = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth.Constants.LordType, Idrinth.Constants.LordSubtype);
    if idrinthGeneral then
        return idrinthGeneral;
    end;
    return nil;
end;
local cqi = nil;

access = {};
access.get = function(requiredFaction)
    if cqi then
        idrinth = cm:get_character_by_cqi(cqi);
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
                    local idrinth = getIdrinthFromFaction(faction)
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
access.spawned = function()
    if cqi and cm:get_character_by_cqi(cqi) then
        return true;
    end;
    local character = access.get();
    return character or false;
end;
return access;