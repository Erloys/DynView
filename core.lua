if not DynView then
    DynView = {}
end

DynView.AddonName = "DynView"
DynView.WelcomeMessage =
[[Loaded. (if u client version is older than 1.12.1 u need to reload once after logging|reload for the addon to work)]]

DynView.NametoView = {
    normal = 2, -- default view 1
    indoor = 1, -- default view 2
    combat = 3,
    melee = 4
}
DynView.ViewtoName = {};
for k, v in pairs(DynView.NametoView) do
    DynView.ViewtoName[v] = k;
end

function DynView.log(msg)
    --DEFAULT_CHAT_FRAME:AddMessage(DynView.AddonName .. " : " .. msg, 1, 1, 0.5);
end

function DynView.notify(message)
    DEFAULT_CHAT_FRAME:AddMessage(DynView.AddonName .. ": " .. message);
end

function DynView.GetDefaultConf()
    local DefaultConf = {};
    for k, _ in pairs(DynView.NametoView) do
        DefaultConf[k] = false;
    end
    DefaultConf.IsIndoor = false;
    DefaultConf.IsAddonEnabled = true;
    return DefaultConf;
end

function DynView.GetView(viewName)
    return DynView.NametoView[viewName];
end

function DynView.EnableAddon()
    if (DynViewConf.IsAddonEnabled) then
        DynView.notify("Already enabled.");
        return;
    end
    DynViewConf.IsAddonEnabled = true;
    DynView.notify("enabled");
end

function DynView.DisableAddon()
    if (not DynViewConf.IsAddonEnabled) then
        DynView.notify("Already disabled.");
        return;
    end
    DynViewConf.IsAddonEnabled = false;
    DynView.notify("disabled");
end

function DynView.IsEnabled(view)
    return DynViewConf[view];
end

function DynView.EnterView(view)
    local viewName = DynView.ViewtoName[view];
    if (not DynView.IsEnabled(viewName)) then
        DynView.log("skip view " .. viewName .. " cause disabled");
        return;
    end
    DynView.log("enter " .. viewName .. " view");
    SetView(view);
end


function DynView.EnterDefaultViewByLocation()
    if DynViewConf.IsIndoor and DynView.IsEnabled(DynView.NametoView.indoor) then
        DynView.EnterView(DynView.NametoView.indoor);
        return;
    end
    DynView.EnterView(DynView.NametoView.normal)
end

function DynView.ExitView(view, cond)
    if cond and DynView.IsEnabled(view) then
        DynView.EnterView(view);
        return;
    end
    DynView.EnterDefaultViewByLocation();
end

DynView.notify(DynView.WelcomeMessage);
