print("This is the ResetInfluence script.")

-- reset influence from every civ and half the influence gain, if a city state embargo resolution was passed

local iCityState_Embargo = GameInfoTypes["RESOLUTION_ALL_CITY_STATES_EMBARGO"];
local iReduceinfluence_policy = GameInfoTypes["POLICY_LESS_INFLUENCE_X"];

function OnResolutionResult(iResolution, iChoice, bEnact, bPassed) -- the resolutiion, our own decision?, if it was enacted or repealed, if it passed.
    if iResolution==iCityState_Embargo and bPassed then
        if bEnact then
            for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
                local pPlayer = Players[iPlayer]
                if pPlayer~=nil and pPlayer:IsAlive() and not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() then
                    for iMinor = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1, 1 do
                        local pMinor = Players[iMinor]
                        if pMinor~=nil and pMinor:IsMinorCiv() and not pMinor:IsBarbarian() then
                            local current = pMinor:GetMinorCivFriendshipWithMajor(iPlayer)
                            local change = (-1) * current -- set it to 0 for everyone, regarldess if previously positive or negative and regardless of stable value
                            pMinor:ChangeMinorCivFriendshipWithMajor(iPlayer,change)
                        end
                    end
                    if pPlayer.GrantPolicy~=nil then -- needs whowards dll dummy policies
                        pPlayer:GrantPolicy(iReduceinfluence_policy)
                    end
                end
            end
        else -- was removed, restore influence gain (but not the previous total influence)
            for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
                local pPlayer = Players[iPlayer]
                if pPlayer~=nil and pPlayer:IsAlive() and not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() and pPlayer.RevokePolicy~=nil then
                    pPlayer:RevokePolicy(iReduceinfluence_policy)
                end
            end
        end
    end
end
GameEvents.ResolutionResult.Add(OnResolutionResult)

-- testing
-- OnResolutionResult(iCityState_Embargo,1,true,true)

