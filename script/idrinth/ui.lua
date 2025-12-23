local ui = {};

ui.nowAndThen = function(callback)
    callback();
    cm:callback(callback, 1);
end;

return ui;