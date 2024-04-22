
DynView.AvailableView = ""
for k, _ in pairs(DynView.NametoView) do
    DynView.AvailableView = DynView.AvailableView .. k .. ", "
end


DynView.HelpMessage = [[
    
DynView Addon Help
Commands:

/dynview help: Display this help page.
/dynview enable: Activate the addon.
/dynview enable <view>: Activate a specific view trigger.
/dynview disable: Deactivate the addon.
/dynview disable <view>: Deactivate a specific view trigger.
/dynview set <view>: Set the current point of view for a specified view trigger.
/dynview set <view>: Set the current point of view for a specified view trigger.
/dynview reset <view>: Reset to the default point of view for a specified view trigger.
/dynview state: show the view trigger state.

View Triggers:

'normal' : Default view trigger.
Views will revert to this when their exit conditions are met.

'indoor' : Triggers when entering an indoor area.
Exit condition: leaving the area or entering a non-indoor zone.
Exiting this view switches to Normal view (unless Normal trigger is disabled).

'combat' : Activates during combat.
Exit condition: leaving combat.
Exiting this view switches to Normal view (unless Normal trigger is disabled),
unless indoors, then it switches to Indoor view (unless Indoor trigger is disabled).

'melee' : Activates when performing a melee attack.
Exit condition: ceasing melee attacks.
Exiting this view switches to Combat view (unless Combat trigger is disabled).

]]

local function boolToText(boolean)
    if boolean then
        return "enabled";
    end
    return "disabled";  
end

DynView.CommandActions = {
    help = function() DynView.notify(DynView.HelpMessage) end,
    enable = function(viewArg)
        if (viewArg[1] == "") then
            DynView.EnableAddon();
        else
            DynViewConf[viewArg[1]] = true;
            DynView.notify("view " .. viewArg[1] .. " trigger is enabled");
        end
    end,
    disable = function(viewArg)
        if (viewArg[1] == "") then
            DynView.DisableAddon();
        else
            DynViewConf[viewArg[1]] = false;
            DynView.notify("view " .. viewArg[1] .. " trigger is disabled");
        end
    end,
    set = function(viewArg)
        SaveView(viewArg[2]);
        DynView.notify(viewArg[1] .. " view set.");
    end,
    reset = function(viewArg)
        ResetView(viewArg[2]);
        DynView.notify(viewArg[1] .. " view reset to default.");
    end,
    state = function ()
        local text = "";
        for k,v in pairs(DynViewConf) do
            if k ~= "IsEnabled" and k ~= "IsIndoor" then
                text = text .. "the view: " .. k .. "is " .. boolToText(v) .. "\n";
            end
        end
        notify(text);
    end,
}

SLASH_DYNVIEW1 = "/dynview"
SlashCmdList["DYNVIEW"] = function(command)
    local _, _, cmd, viewName = string.find(command, "%s?(%w+)%s?(.*)");
    local viewArg = {viewName, DynView.GetView(viewName)};
    local action = DynView.CommandActions[cmd];
    if action == nil then
        DynView.notify(
            "invalid command, please type /dynview help for show help");
        return;
    elseif viewArg[1] ~= "" and viewArg[2] == nil then
        DynView.notify("invalid argument: unkown view" .. viewArg[1]);
        return;
    end
    action(viewArg);
end
