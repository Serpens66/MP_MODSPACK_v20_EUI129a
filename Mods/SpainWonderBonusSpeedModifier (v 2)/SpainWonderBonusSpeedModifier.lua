print("This is the 'SpainWonderBonusSpeedModifier' lua code")
-- in dll the default behaviour: every spain team member increases the total gold reward by the usual amount. but then this amount is split evenly to all team members, even if they are not spain. 

local NaturalWonderFirstFinderGold = 500    -- the standard gold amount spain gets
local NaturalWonderSubsequentFinderGold = 100
-- based on these relative values, the total gold reward is splittet.
-- the total gold reward is calculated by how many spains are in the team, each additional spain player reduces the added amount.
local sharetable = {["SpainFinder"]=0.9,["SpainTeammate"]=0.5,["OtherTeammate"]=0.2,["TeammateFinder"]=0.5}
local GoldDifficulty = {["HANDICAP_AI_DEFAULT"]=1.5,["HANDICAP_SETTLER"]=1.3,["HANDICAP_CHIEFTAIN"]=1.2,["HANDICAP_WARLORD"]=1.1,["HANDICAP_PRINCE"]=1,["HANDICAP_KING"]=0.95,["HANDICAP_EMPEROR"]=0.9,["HANDICAP_IMMORTAL"]=0.85,["HANDICAP_DEITY"]=0.7}


local Goldspeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent / 100 -- gamespeed modifier, at standard game speed 1, at slow games 2
local SpainCiv = GameInfoTypes["CIVILIZATION_SPAIN"]

function GiveGoldBonus(Goldamount, pReceiver, pFinder, iX, iY, bFirst)
    pReceiver:ChangeGold(pReceiver:GetGold()+Goldamount);
    local sTextt = (bFirst and Locale.ConvertTextKey("TXT_KEY_POP_NATURAL_WONDER_FIRST_FOUND_GOLD", Goldamount)) or Locale.ConvertTextKey("TXT_KEY_POP_NATURAL_WONDER_SUBSEQUENT_FOUND_GOLD", Goldamount)
    print(string.format("%s found wonder, %s receives Gold, first: %s , Goldamount %i, X/Y: %i/%i",pFinder:GetName(),pReceiver:GetName(),tostring(bFirst),Goldamount,iX,iY))
    local sTitlee = Locale.ConvertTextKey("TXT_KEY_POP_NATURAL_WONDER_FOUND")  -- send notification, cause the normal game notification won't include the gold bonus
    pReceiver:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sTextt, sTitlee, iX, iY)
end

function OnNaturalWonderDiscovered(iTeam, iFeature, iX, iY, bFirst, iPlayer, iUnit)
	-- print(string.format("%i hat gefunden, iFeature: %i, iTeam: %i, iUnit: %i, X/Y: %i/%i",iPlayer,iFeature,iTeam,iUnit,iX,iY))
    local pFinder = Players[iPlayer]
    if pFinder~=nil then
        local totalgoldamount = 0; -- gets increased for every spain player in the team
        local TeamPlayers = {[sharetable["SpainFinder"]]={},[sharetable["SpainTeammate"]]={},[sharetable["OtherTeammate"]]={},[sharetable["TeammateFinder"]]={}}
        local totalrelative_share = 0
        for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do -- more than one player could be spain, so now loop through all players, find out if they are spain and in the same team like founder
            local pCivPlayer = Players[i]
            local iCivTeam = pCivPlayer:GetTeam()
            local spaincount = 0
            if pCivPlayer:IsEverAlive() and iCivTeam==iTeam then
                if (pCivPlayer:GetCivilizationType() == SpainCiv) then
                    spaincount = spaincount + 1
                    local Difficulty = GameInfo.HandicapInfos[pCivPlayer:GetHandicapType()].Type -- eg HANDICAP_EMPEROR
                    local difficultymodifier = GoldDifficulty[Difficulty]
                    if difficultymodifier==nil then
                        difficultymodifier = 1
                    end
                    totalgoldamount = totalgoldamount + ((((bFirst and NaturalWonderFirstFinderGold) or NaturalWonderSubsequentFinderGold) * Goldspeed * difficultymodifier) / spaincount) -- the added amount gets less for every additional spain player
                    if i==iPlayer then -- the finder is spain
                        table.insert(TeamPlayers[sharetable["SpainFinder"]],pCivPlayer)
                        totalrelative_share = totalrelative_share + sharetable["SpainFinder"]
                    else
                        table.insert(TeamPlayers[sharetable["SpainTeammate"]],pCivPlayer)
                        totalrelative_share = totalrelative_share + sharetable["SpainTeammate"]
                    end
                else
                    if i==iPlayer then -- the finder is spain
                        table.insert(TeamPlayers[sharetable["TeammateFinder"]],pCivPlayer)
                        totalrelative_share = totalrelative_share + sharetable["TeammateFinder"]
                    else
                        table.insert(TeamPlayers[sharetable["OtherTeammate"]],pCivPlayer)
                        totalrelative_share = totalrelative_share + sharetable["OtherTeammate"]
                    end
                end
            end
        end
        local Goldamount = 0;
        for relative_share, theplayers in pairs(TeamPlayers) do
            for i,player in ipairs(theplayers) do
                Goldamount = math.ceil(totalgoldamount * (relative_share/totalrelative_share))
                if Goldamount > 0 then
                    GiveGoldBonus(Goldamount, player, pFinder, iX, iY, bFirst)
                end
            end
        end
    end
    
end

-- old code
-- function GiveGoldBonus(iX, iY, bFirst, pPlayer, spainPlayer, multi)
    -- local multiplier = multi or 1
    -- local goldplayer = (spainPlayer and spainPlayer) or pPlayer -- remember that more than one civ could be spain...
    -- local Goldamount = (bFirst and NaturalWonderFirstFinderGold*Goldspeed) or NaturalWonderSubsequentFinderGold*Goldspeed
    -- Goldamount = math.ceil(Goldamount*multiplier)-- if the founder is a teammate, don't give the full amount of Gold to spain.
    -- goldplayer:ChangeGold(goldplayer:GetGold()+Goldamount);
    -- local sTextt = (bFirst and Locale.ConvertTextKey("TXT_KEY_POP_NATURAL_WONDER_FIRST_FOUND_GOLD", Goldamount)) or Locale.ConvertTextKey("TXT_KEY_POP_NATURAL_WONDER_SUBSEQUENT_FOUND_GOLD", Goldamount)
    -- print(string.format("%s found wonder, %s receives Gold, first: %s , Goldamount %i, X/Y: %i/%i",pPlayer:GetName(),goldplayer:GetName(),tostring(bFirst),Goldamount,iX,iY))
    -- local sTitlee = Locale.ConvertTextKey("TXT_KEY_POP_NATURAL_WONDER_FOUND")  -- send notification, cause the normal game notification won't include the gold bonus
    -- goldplayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sTextt, sTitlee, iX, iY)
-- end
-- function OnNaturalWonderDiscovered(iTeam, iFeature, iX, iY, bFirst, iPlayer, iUnit)
	-- local pPlayer = Players[iPlayer]
    -- if pPlayer~=nil then
        -- if (pPlayer:GetCivilizationType() == SpainCiv) then -- if it is spain
            -- GiveGoldBonus(iX, iY, bFirst, pPlayer, nil)
        -- end 
        -- for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do -- more than one player could be spain, so now loop through all players, find out if they are spain and in the same team like founder
            -- local pCivPlayer = Players[i]
            -- local iCivTeam = pCivPlayer:GetTeam()
            -- if i~=iPlayer and pCivPlayer:IsEverAlive() and iCivTeam==iTeam and (pCivPlayer:GetCivilizationType() == SpainCiv) then -- go through every civ that is not the finder
                -- GiveGoldBonus(iX, iY, bFirst, pPlayer, pCivPlayer, 0.45) -- give teammate spain some gold
                -- GiveGoldBonus(iX, iY, bFirst, pPlayer, nil, 0.35) -- but also give the founder some gold, if spain is in its team
            -- end
        -- end
    -- end
    
-- end
GameEvents.NaturalWonderDiscovered.Add(OnNaturalWonderDiscovered)