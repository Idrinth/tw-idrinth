Idrinth = {};

-- Base methods and data
Idrinth.mayConfigure = cm:load_global_script("script/idrinth/multiplayer");
Idrinth.Constants = cm:load_global_script("script/idrinth/constants");
Idrinth.Version = cm:load_global_script("script/idrinth/version");
Idrinth.Names = cm:load_global_script("script/idrinth/names");
Idrinth.factions = cm:load_global_script("script/idrinth/factions");
Idrinth.log = cm:load_global_script("script/idrinth/logging");
Idrinth.Access = cm:load_global_script("script/idrinth/access");
Idrinth.cultures = cm:load_global_script("script/idrinth/cultures");
Idrinth.Statistics = cm:load_global_script("script/idrinth/statistics");
Idrinth.Ui = cm:load_global_script("script/idrinth/ui");

-- Event Listeners for specific topics
cm:load_global_script("script/idrinth/settlementui");
cm:load_global_script("script/idrinth/unlocks");
cm:load_global_script("script/idrinth/resources");
cm:load_global_script("script/idrinth/story");
cm:load_global_script("script/idrinth/chapels");
cm:load_global_script("script/idrinth/interventions");
cm:load_global_script("script/idrinth/army");
cm:load_global_script("script/idrinth/pointsofinterest");
cm:load_global_script("script/idrinth/renaming");
cm:load_global_script("script/idrinth/statistics");
cm:load_global_script("script/idrinth/traits");
cm:load_global_script("script/idrinth/heroactions");
cm:load_global_script("script/idrinth/recruitingui");
cm:load_global_script("script/idrinth/characterpanel");
cm:load_global_script("script/idrinth/persistence");
cm:load_global_script("script/idrinth/items");