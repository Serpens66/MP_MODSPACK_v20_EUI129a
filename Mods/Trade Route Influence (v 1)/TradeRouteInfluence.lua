print("This is the TradeRouteInfluence mod script.")

-- needs the GrantPolicy command from whowards DLL and BUGFIX_DUMMY_POLICIES enabled
-- give every player a dummy policy that changes trade routes influence and city state gold

-- is called at game start and every load
-- function OnSequenceGameInitComplete()
    for iCivPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
        local pCivPlayer = Players[iCivPlayer]
        if pCivPlayer~=nil and pCivPlayer.GrantPolicy and pCivPlayer:IsEverAlive() and pCivPlayer:IsAlive() then
            local pTrait = GameInfo.Policies["TRAIT_MOD_TRADEROUTE_INFLUENCE"]
            if pTrait~=nil then
                pCivPlayer:GrantPolicy(pTrait.ID) -- does nothing, if they already have this policy
            end
        end
    end
-- end
-- Events.SequenceGameInitComplete.Add( OnSequenceGameInitComplete );


