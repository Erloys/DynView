DynView.AvailableView = ""
for k, _ in pairs(DynView.Views) do
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
/set <view>: Set the current point of view for a specified view trigger.
/reset <view>: Reset to the default point of view for a specified view trigger.

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

SLASH_DYNVIEW1 = "/dynview"
SlashCmdList["DYNVIEW"] = function(command)
    local _, _, cmd, viewName = string.find(command, "%s?(%w+)%s?(.*)")
    local view = DynView.Views[viewName]

    local actions = {
        help = function() DynView.notify(DynView.HelpMessage) end,
        enable = function()
            if (viewName ~= nil) then
                if (nil == view) then
                    notify("Invalid command argument");
                    return;
                end
                DynViewConf[view] = true;
                DynView.notify("view " .. view .. " trigger is enabled");
                return;
            elseif DynView.DynViewState then
                DynView.notify("already enabled");
                return;
            end
            DynView.DynViewState = true
            DynView.notify("enabled, type '/dynview disable' to disable it.")
        end,
        disable = function()
            if (viewName ~= nil) then
                if (nil == view) then
                    notify("invalid command argument");
                    return;
                end
                DynViewConf[view] = false;
                DynView.notify("view" .. view .. "trigger is disabled");
                return;
            elseif not DynView.DynViewState then
                DynView.notify("already off");
                return;
            end
            DynView.DynViewState = false
            DynView.notify("disabled, type '/dynview enable' to enable it.")
        end,
        set = function()
            if view then
                SaveView(view)
                DynView.notify(viewName .. " view set.")
            else
                DynView.notify("error invalid argument: " .. viewName)
            end
        end,
        reset = function()
            if view then
                ResetView(view)
                DynView.notify(viewName .. " view reset to default.")
            else
                DynView.notify("error invalid argument: " .. viewName)
            end
        end
    }

    local action = actions[cmd]
    if action then
        action()
    else
        DynView.notify(
            "invalid command, please type /dynview help for show help")
    end
end
