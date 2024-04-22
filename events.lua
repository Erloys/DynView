DynView.events = {
    "PLAYER_ENTER_COMBAT", -- THIS EVENT FOR CHECK IF ENTER IN MELEE
    "PLAYER_LEAVE_COMBAT",
    "PLAYER_REGEN_DISABLED", -- THIS EVENT FOR CHECK ENTER IN COMBAT
    "PLAYER_REGEN_ENABLED", "PLAYER_LOGIN", "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS", "ADDON_LOADED"
}

DynView.EventFrame = CreateFrame("Frame")
for _, event in ipairs(DynView.events) do DynView.EventFrame:RegisterEvent(event) end

DynView.EventActions = {
    -- MELEE
    ["PLAYER_ENTER_COMBAT"] = function()
        DynView.EnterView(DynView.NametoView.melee);
    end,
    ["PLAYER_LEAVE_COMBAT"] = function()
        DynView.ExitView(DynView.NametoView.combat, DynView.IsInBattle);
    end,
    -- COMBAT
    ["PLAYER_REGEN_DISABLED"] = function()
        DynView.IsInBattle = true;
        DynView.EnterView(DynView.NametoView.combat);
    end,
    ["PLAYER_REGEN_ENABLED"] = function()
        DynView.IsInBattle = false;
        DynView.EnterDefaultViewByLocation();
    end,
    ["PLAYER_LOGIN"] = function()
        DynView.EnterDefaultViewByLocation();
    end,
    -- OUTDOOR
    ["ZONE_CHANGED"] = function()
        if DynView.IsInBattle then
            return;
        end
        DynView.EnterView(DynView.NametoView.normal);
        DynViewConf.IsIndoor = false;
    end,
    -- INDOOR
    ["ZONE_CHANGED_INDOORS"] = function()
        if DynView.IsInBattle then
            return;
        end
        DynView.EnterView(DynView.NametoView.indoor);
        DynViewConf.IsIndoor = true;
    end,
    ["ADDON_LOADED"] = function()
        if arg1 ~= DynView.AddonName then
            return;
        end
        if DynViewConf == nil then
            DynViewConf = DynView.GetDefaultConf();
        end
    end
}

DynView.EventFrame:SetScript("OnEvent", function()
    -- if DynViewConf is nil it mean addon not loaded.
    --so the event "ADDON_LOADED" can pass the guard condition.
    if (DynViewConf ~= nil and not DynViewConf.IsAddonEnabled) then
        DynView.log("skip event " .. event .. " cause addon disabled"); 
        return;
    end
    DynView.log("process event: " .. event);
    local action = DynView.EventActions[event];
    if action then action(); end
end)
