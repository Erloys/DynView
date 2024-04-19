-- u can set any number between 1 and 5 for view
-- ingame u can save view by binding a key the setview(number) keybind
-- the saved view is keep between sessions.
--
--
-- the view out of combat
local NormalView = 2;

-- the view in combat
local CombatView = 4;

local function log(msg)
    -- DEFAULT_CHAT_FRAME:AddMessage("DYNVIEW: " .. msg, 1, 1, 0.5);
end

function EnterCombatView()
    log("enter combat view");
    SetView(CombatView);
end

function EnterNormalView()
    log("enter normal view");
    SetView(NormalView);
end

local DynView_frame = CreateFrame("Frame");

DynView_frame:RegisterEvent("PLAYER_LEAVE_COMBAT");
DynView_frame:RegisterEvent("PLAYER_ENTER_COMBAT");
DynView_frame:RegisterEvent("PLAYER_LOGIN");

DynView_frame:SetScript("OnEvent", function()
    if (event == "PLAYER_ENTER_COMBAT") then
        EnterCombatView();
    elseif (event == "PLAYER_LEAVE_COMBAT" or event == "PLAYER_LOGIN") then
        EnterNormalView();
    end
end)
