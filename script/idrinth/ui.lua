local ui = {};

ui.nowAndThen = function(callback)
    callback();
    cm:real_callback(callback, 100);
    cm:callback(callback, 1);
    cm:callback(callback, 2);
end;
ui.findElementWithin = function(...)
    local parent = core:get_ui_root();
    if not parent then
        return nil;
    end;
    local argsTable = {...};
    for _, key in pairs(argsTable) do
        if is_uicomponent(key) then
            parent = key;
        elseif is_integer(key) or is_string(key) then
            local child = parent:Find(key);
            if not child then
                return nil;
            end;
            local component = UIComponent(child);
            if not component or component == parent then
                return nil;
            end;
            parent = component;
        else
            return nil;
        end;
    end;
    return parent;
end;
ui.createOrFind = function(name, parent, overwriteAutoFile)
    if not overwriteAutoFile then
        overwriteAutoFile = name;
    end;
    local element = core:get_or_create_component(
        name,
        "ui/idrinth/"..overwriteAutoFile..".twui.xml",
        parent
    );
    if not element then
        Idrinth.log("Failed to create element "..name.."@"..overwriteAutoFile, "ui");
    end;
    return element;
end;

return ui;