if not DynView then
    DynView = {}
end

DynView.AddonName = "DynView"
DynView.WelcomeMessage = [[Loaded. (if u client version is older than 1.12.1 u need to reload once after logging|reload for the addon to work)]]

DynView.Views = {
    indoor = 1, 
    normal = 2, -- default view
    combat = 3,
    melee = 4
}

function DynView.log(msg)
    --DEFAULT_CHAT_FRAME:AddMessage(DynView.AddonName .. " : " .. msg, 1, 1, 0.5);
end

function DynView.notify(message)
    DEFAULT_CHAT_FRAME:AddMessage(DynView.AddonName .. ": " .. message);
end

function DynView.EnterView(view)
    if( not DynViewConf[view]) then
        DynView.log("skip view " .. view .. " cause disabled");
        return;
    end
    DynView.log("enter " .. view .. " view");
    SetView(view);
end

DynView.notify(DynView.WelcomeMessage);
