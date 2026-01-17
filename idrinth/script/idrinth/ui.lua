local ui = {};
local todo = {};
local todoProcessingStarted = false;
local addTodo = function(time, callback)
    todo[#todo + 1] = {
        callback = callback,
        time = time,
    };
end;
local processTodos = function()
    Idrinth.log("processing "..(#todo).." todos", "ui");
    if #todo == 0 then
        return;
    end;
    local now = os.time();
    local fired = {};
    for pos = #todo, 1, -1 do
        local callback = todo[pos];
        if now >= callback.time then
            table.remove(todo, pos);
            if not fired[callback.callback] then
                Idrinth.log("calling todo", "ui");
                fired[callback.callback] = true;
                callback.callback();
            end;
        end;
    end;
end;

ui.nowAndThen = function(callback)
    if todoProcessingStarted == false then
        todoProcessingStarted = true;
        cm:repeat_real_callback(processTodos, 157);
    end;
    addTodo(os.time(), callback);
    addTodo(os.time() + 1, callback);
    addTodo(os.time() + 2, callback);
end;
ui.findElementWithin = function(...)
    if not core:is_ui_created() then
        return nil;
    end;
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
ui.forEachChild = function(parent, callback)
    for i = 1, parent:ChildCount() do
        local child = UIComponent(parent:Find(i));
        if callback(child, i) == false then
            break;
        end;
    end;
end;

--- Finds the first child matching a predicate.
--- @param parent userdata The parent UI component
--- @param predicate function A function(child, index) that returns true for a match
--- @return userdata|nil The first matching UIComponent child, or nil if none found
--- @return number|nil The 1-based index of the match, or nil if none found
ui.findChildWhere = function(parent, predicate)
    for i = 1, parent:ChildCount() do
        local child = UIComponent(parent:Find(i));
        if predicate(child, i) then
            return child, i;
        end;
    end;
    return nil, nil;
end;

--- Returns a table of all children matching a predicate.
--- @param parent userdata The parent UI component
--- @param predicate function A function(child, index) that returns true for a match
--- @return table An array of matching UIComponent children
ui.filterChildren = function(parent, predicate)
    local result = {};
    for i = 1, parent:ChildCount() do
        local child = UIComponent(parent:Find(i));
        if predicate(child, i) then
            result[#result + 1] = child;
        end;
    end;
    return result;
end;

--- Counts children matching a predicate.
--- @param parent userdata The parent UI component
--- @param predicate function A function(child, index) that returns true for a match
--- @return number The count of matching children
ui.countChildrenWhere = function(parent, predicate)
    local count = 0;
    for i = 1, parent:ChildCount() do
        local child = UIComponent(parent:Find(i));
        if predicate(child, i) then
            count = count + 1;
        end;
    end;
    return count;
end;

ui.createOrFind = function(name, parent, overwriteAutoFile)
    if not overwriteAutoFile then
        overwriteAutoFile = name;
    end;
    if not parent then
        parent = core:get_ui_root();
    end;
    if not parent then
        return;
    end;
    Idrinth.log("Creating element "..name.."@"..overwriteAutoFile, "ui");
    local element = core:get_or_create_component(
        name,
        "ui/idrinth/"..overwriteAutoFile..".twui.xml",
        parent
    );
    if not element then
        Idrinth.log("Failed to create element "..name.."@"..overwriteAutoFile, "ui");
    end;
    Idrinth.log("Created element "..name.."@"..overwriteAutoFile, "ui");
    return element;
end;

return ui;