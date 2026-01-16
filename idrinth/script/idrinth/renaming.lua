local enableRenaming = true;

Idrinth.Events.onMctChange(function()
    enableRenaming = Idrinth.Mct.get("names");
end);
Idrinth.Events.addListener(
    "UnitCreated",
    function(context)
        if not enableRenaming then
            return false;
        end;
        if not Idrinth.Access.spawned() then
            return false;
        end;
        local unitKey = context:unit():unit_key();
        local isChapel = Idrinth.Unittypes.isChapelUnit(unitKey);
        local isNotVarghulf = not Idrinth.Unittypes.isVarghulf(unitKey);
        local isNotHero = not Idrinth.Unittypes.isHero(unitKey);
        return isChapel and isNotVarghulf and isNotHero;
    end,
    function(context)
        local length = #Idrinth.Names;
        local name = Idrinth.Names[cm:random_number(length)];
        local finalName;
        local unitKey = context:unit():unit_key();
        if Idrinth.Unittypes.isPriest(unitKey) and Idrinth.Unittypes.isVampiric(unitKey) then
            finalName = name.." Thalui";
        elseif Idrinth.Unittypes.isSingleEntity(unitKey) then
            finalName = name;
        elseif string.ends_with(name, "s") then
            finalName = name .. "' " .. common.get_localised_string("land_units_onscreen_name_" .. unitKey);
        else
            finalName = name .. "'s " .. common.get_localised_string("land_units_onscreen_name_" .. unitKey);
        end;
        cm:change_custom_unit_name(context:unit(), finalName);
        if context:unit():has_unit_commander() then
            cm:change_character_custom_name(
                context:unit():unit_commander(),
                finalName,
                "",
                "",
                ""
            );
        end;
    end
);
