local getIdrinthFromFaction = function(faction)
    local idrinthChampion = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth.Constants.HeroType, Idrinth.Constants.BaseType .. Idrinth.Constants.HeroType);
    if idrinthChampion then
        return idrinthChampion;
    end;
    local idrinthGeneral = cm:get_most_recently_created_character_of_type(faction:name(), Idrinth.Constants.LordType, Idrinth.Constants.BaseType .. Idrinth.Constants.LordType);
    if idrinthGeneral then
        return idrinthGeneral;
    end;
    return nil;
end;
local cqi = nil;

access = {};
access.get = function()
    if cqi then
        idrinth = get_character_by_cqi(cqi);
        if idrinth then
            return idrinth, idrinth:faction(), idrinth:faction():culture();
        end;
        cgi = nil;
    end;
    for _, culture in pairs(Idrinth.cultures()) do
        local factions = cm:get_factions_by_culture(culture);
        if factions then
            for _, faction in pairs(factions) do
                local idrinth = getIdrinthFromFaction(faction)
                if idrinth then
                    cqi = idrinth:cqi();
                    return idrinth, faction, culture;
                end;
            end;
        end;
    end;
    return nil, nil, nil;
end;
access.spawned = function()
    if cqi then
        return true;
    end;
    local character = access.get();
    return character or false;
end;
return access;