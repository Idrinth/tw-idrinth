local isHost = false;

cm:add_pre_first_tick_callback(
    function()
        isHost = common.get_context_value("CcoFrontendRoot", "", "CampaignLobbyContext.IsLocalPlayerHost");
    end
);

local mayConfigure = function()
    return false == cm:is_multiplayer() or isHost;
end;

return mayConfigure;