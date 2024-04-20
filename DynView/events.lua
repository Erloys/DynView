local events = {
    "PLAYER_ENTER_COMBAT", "PLAYER_LEAVE_COMBAT", "PLAYER_REGEN_DISABLED",
    "PLAYER_REGEN_ENABLED", "PLAYER_LOGIN", "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS", "ADDON_LOADED"
}

DynView.EventFrame = CreateFrame("Frame")
for _, event in ipairs(events) do DynView.EventFrame:RegisterEvent(event) end

DynView.eventActions = {
    ["PLAYER_ENTER_COMBAT"] = function()
        DynView.EnterView(DynView.Views.melee)
    end,
    ["PLAYER_LEAVE_COMBAT"] = function()
        DynView.EnterView(DynView.Views.combat)
    end,
    ["PLAYER_REGEN_DISABLED"] = function()
        DynView.IsInBattle = true
        DynView.EnterView(DynView.Views.combat)
    end,
    ["PLAYER_REGEN_ENABLED"] = function()
        DynView.IsInBattle = false
        DynView.EnterView(DynView.Views.normal)
    end,
    ["PLAYER_LOGIN"] = function()
        if DynViewConf.IsIndoor then
            DynView.EnterView(DynView.Views.indoor);
            return; 
        end
        DynView.EnterView(DynView.Views.normal) end,
    ["ZONE_CHANGED"] = function()
        if not DynView.IsInBattle then
            DynView.EnterView(DynView.Views.normal);
            DynViewConf.IsIndoor = false;
        end
    end,
    ["ZONE_CHANGED_INDOORS"] = function()
        if not DynView.IsInBattle then
            DynView.EnterView(DynView.Views.indoor);
            DynViewConf.IsIndoor = true;
        end
    end,
    ["ADDON_LOADED"] = function()
        if arg1 == DynView.AddonName then
            if DynViewState == nil then DynViewState = true; end
            if DynViewConf == nil then
                DynViewConf = {};
                for k, _ in pairs(DynView.Views) do
                    DynViewConf[k] = false;
                end
                DynViewConf.IsIndoor = false;
            end
        end
    end
}

DynView.EventFrame:SetScript("OnEvent", function()
    if (DynViewState ~= nil and not DynViewState) then return; end
    DynView.log("process event: " .. event);
    local action = DynView.eventActions[event];
    if action then action(); end
end)
