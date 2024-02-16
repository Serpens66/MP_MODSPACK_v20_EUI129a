-- Author: Wes and Serp
--------------------------------------------------------------
print("UI RandomTraitsPlus")

ContextPtr:SetHide(true)

function OnOK()
ContextPtr:SetHide(true)
end
Controls.OK:RegisterCallback(Mouse.eLClick, OnOK)

function OnDiploCornerPopup()
ContextPtr:SetHide(false)
end

function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
  table.insert(additionalEntries, {
    text=Locale.ConvertTextKey("TXT_KEY_LEADER_TRAITS_TITLE"), 
    call=OnDiploCornerPopup
  })
end

function InputHandler( uiMsg, wParam, lParam )
    ----------------------------------------------------------------        
    -- Key Down Processing
    ----------------------------------------------------------------        
    if uiMsg == KeyEvents.KeyDown then
        if (wParam == Keys.VK_RETURN or wParam == Keys.VK_ESCAPE) then
			OnOK()
			return true;
        end
    end
end
ContextPtr:SetInputHandler( InputHandler );

-- added by Serp
-- we will also show the leaders that have this trait in the tooltip
-- we use (and change) the tooltip, because UI text formatting seems to be a pain and a tooltip is automatically adjusted to length.
local traits = {["Aggressive"]="POLICY_AGGRESSIVE_X", ["Charismatic"]="POLICY_CHARISMATIC_X", ["Creative"]="POLICY_CREATIVE_X", ["Diplomatic"]="POLICY_DIPLOMATIC_X", 
                ["Wide"]="POLICY_WIDE_X", ["Tall"]="POLICY_TALL_X", ["Financial"]="POLICY_FINANCIAL_X", ["Imperialistic"]="POLICY_IMPERIALISTIC_X", ["Industrious"]="POLICY_INDUSTRIOUS_X", 
                ["Inventive"]="POLICY_INVENTIVE_X", ["Mercantile"]="POLICY_MERCANTILE_X", ["Philosophical"]="POLICY_PHILOSOPHICAL_X", ["Protective"]="POLICY_PROTECTIVE_X",
                ["Seafaring"]="POLICY_SEAFARING_X", ["Spiritual"]="POLICY_SPIRITUAL_X", ["Explorer"]="POLICY_EXPLORER_X"}

-- borrowed from EUI tooltip library
local function GetLeaderName( player )
	-- You
	if player:GetID() == Game.GetActivePlayer() then
		return Locale.ConvertTextKey("TXT_KEY_YOU")
	-- Not met
	elseif not Teams[Game.GetActiveTeam()]:IsHasMet(player:GetTeam()) then
		return Locale.ConvertTextKey("TXT_KEY_UNMET_PLAYER")
	-- Human
	elseif player:IsHuman() then -- Game.IsGameMultiPlayer()
		local n = player:GetNickName()
		if n and n ~= "" then
			return player:GetNickName()
		end
	end
	local n = PreGame.GetLeaderName(player:GetID())
	if n and n ~= "" then
		return Locale.ConvertTextKey( n )
	else
		return Locale.ConvertTextKey( (GameInfo.Leaders[ player:GetLeaderType() ] or {}).Description )
	end
end

function OnUIInfosUpdate()
  if (not ContextPtr:IsHidden()) then
    local iActivePlayer = Game.GetActivePlayer()
    -- print("OnInfosUpdate "..tostring(iActivePlayer))
    local pActivePlayer = Players[iActivePlayer]
    if pActivePlayer~=nil and pActivePlayer:IsEverAlive() then
        local leaderstrings = {}
        for traitpanel,traitpolicy in pairs(traits) do
            leaderstrings[traitpanel] = ""
        end
        for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
            local pPlayer = Players[iPlayer]
            if pPlayer~=nil and pPlayer:IsEverAlive() then
                for traitpanel,traitpolicy in pairs(traits) do
                    local pPoliciy = GameInfo.Policies[traitpolicy]
                    if pPoliciy~=nil and pPlayer:HasPolicy(pPoliciy.ID) then
                        local leadername = GetLeaderName(pPlayer)
                        leaderstrings[traitpanel] = leaderstrings[traitpanel] .. leadername .. ", "
                    end
                end
            end
        end
        for traitpanel, leadernames in pairs(leaderstrings) do
            leadernames = leadernames:sub(1, -3) -- remove the last ", "
            Controls[traitpanel]:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_".. string.upper(traitpanel).."_TRAIT_HELP") .. Locale.ConvertTextKey("TXT_KEY_LEADERS_WITH_THIS_TRAIT",leadernames))
            if leadernames~="" then
                Controls[traitpanel]:SetString(Locale.ConvertTextKey("TXT_KEY_".. string.upper(traitpanel).."_TRAIT").."*") -- mark it with * if any leader has this trait
            else
                Controls[traitpanel]:SetString(Locale.ConvertTextKey("TXT_KEY_".. string.upper(traitpanel).."_TRAIT")) -- remove *
            end
        end
    end
  end
end
function ShowHideHandler(bIsHide, bInitState)
  if (not bInitState and not bIsHide) then
    OnUIInfosUpdate()
  end
end
ContextPtr:SetShowHideHandler(ShowHideHandler)


LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()