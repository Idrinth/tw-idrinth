local ui = {};

ui.nowAndThen = function(callback)
    callback();
    cm:real_callback(callback, 100);
    cm:callback(callback, 1);
    cm:callback(callback, 2);
end;
ui.findElementWithin = function(...)
    parent = cm:get_ui_root();
    for _, key in pairs(...) do
        if is_uicomponent(key) then
            parent = key;
        else
            local element = find_uicomponent(
                parent,
                key
            );
            if not element or element == parent then
                return nil;
            end;
            parent = element;
        end;
    end;
    return parent;
end;

return ui;