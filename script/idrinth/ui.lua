local ui = {};

ui.nowAndThen = function(callback)
    callback();
    cm:real_callback(callback, 100);
    cm:callback(callback, 1);
    cm:callback(callback, 2);
end;

return ui;