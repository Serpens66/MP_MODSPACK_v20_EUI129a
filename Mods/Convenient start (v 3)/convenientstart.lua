
local g_MeetAtStart = "Human" -- "None", "Human","Everyone" -> will make every civ of that kind meet all other civs of that kind at game start (so you can then make a declaration of friendship) without revealing their start position. 


function RemoveSuperSettlers(iPlayer)
	local turn = Game.GetElapsedGameTurns()
	if (turn == 1) then
		local pPlayer = Players[iPlayer]
		for unit in pPlayer:Units() do
			if (unit:GetUnitType() == GameInfoTypes["UNIT_SUPERSETTLER"]) then
				pSettler = pPlayer:InitUnit(GameInfoTypes["UNIT_SETTLER"], unit:GetX(), unit:GetY(), GameInfoTypes["UNITAI_SETTLE"], unit:GetFacingDirection())
                pSettler:SetEmbarked(unit:IsEmbarked())
				unit:Kill(false, -1)
			end
		end
	else
		if (turn > 1) then
			GameEvents.PlayerDoTurn.Remove(RemoveSuperSettlers)
		end
	end
end
GameEvents.PlayerDoTurn.Add(RemoveSuperSettlers)


function MeetEveryone(iTeam,pTeam)
    if g_MeetAtStart~=nil and g_MeetAtStart~="None" then
        if pTeam~=nil and ( g_MeetAtStart=="Everyone" or (g_MeetAtStart=="Human" and pTeam:IsHuman())) then
            for iCivTeam = 0, GameDefines.MAX_CIV_TEAMS - 1 do
                if iTeam~=iCivTeam then
                    local pCivTeam = Teams[iCivTeam]
                    if pCivTeam~=nil and pCivTeam:IsAlive() and pCivTeam:IsEverAlive() and not pCivTeam:IsMinorCiv() and not pCivTeam:IsBarbarian() and ( g_MeetAtStart=="Everyone" or (g_MeetAtStart=="Human" and pCivTeam:IsHuman())) then
                        if not pTeam:IsHasMet(iCivTeam) then
                            pTeam:Meet(iCivTeam)
                        end
                    end
                end
            end
        end
    end
end

function OnModLoaded()-- is called at game start and every load
    for iTeam = 0, GameDefines.MAX_CIV_TEAMS - 1 do
        local pTeam = Teams[iTeam]
        if pTeam~=nil and pTeam:IsAlive() and pTeam:IsEverAlive() and not pTeam:IsMinorCiv() and not pTeam:IsBarbarian() then
            MeetEveryone(iTeam,pTeam) -- to meet at start others
        end
    end
end
OnModLoaded()