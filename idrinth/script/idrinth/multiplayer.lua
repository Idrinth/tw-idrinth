--- @module Idrinth.mayConfigure
--- Multiplayer configuration check module.
--- Determines whether the local player has permission to configure mod settings.
--- In single player, always returns true. In multiplayer, only the host can configure.
--- @return function mayConfigure function that returns true if configuration is allowed.

local isHost = false;

cm:add_pre_first_tick_callback(
    function()
        isHost = common.get_context_value("CcoFrontendRoot", "", "CampaignLobbyContext.IsLocalPlayerHost");
    end
);

--- Checks if the current player may configure mod settings.
--- @return boolean True if single player or if multiplayer host, false otherwise.
local mayConfigure = function()
    return false == cm:is_multiplayer() or isHost;
end;

return mayConfigure;