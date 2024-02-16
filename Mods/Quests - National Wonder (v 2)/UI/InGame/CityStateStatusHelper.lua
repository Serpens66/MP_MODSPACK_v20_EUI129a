print("This is the modded CityStateStatusHelper from 'Quests - Circumnavigate'")

------------------------------------------------------
-- CityStateStatusHelper.lua
-- Author: Anton Strenger
--
-- Consolidation of code associated with displaying
-- the friendship status of a player with a city-state
------------------------------------------------------

include( "IconSupport" );

------------------------------------------------------
-- Global Constants
------------------------------------------------------
local kPosInfRange = math.abs( GameDefines["FRIENDSHIP_THRESHOLD_ALLIES"] - GameDefines["FRIENDSHIP_THRESHOLD_NEUTRAL"] );
local kNegInfRange = math.abs( GameDefines["MINOR_FRIENDSHIP_AT_WAR"] - GameDefines["FRIENDSHIP_THRESHOLD_NEUTRAL"] );
local kPosBarRange = 81;
local kNegBarRange = 81;
local kBarIconAtlas = "CITY_STATE_INFLUENCE_METER_ICON_ATLAS";
local kBarIconNeutralIndex = 4;

-- The order of precedence in which the quest icons and tooltip points are displayed
-- is now stored in the Quests database table
ktQuestsDisplayOrder = {}
for row in DB.Query("SELECT ID FROM Quests WHERE Enabled=1 ORDER BY Priority ASC") do
	table.insert(ktQuestsDisplayOrder, row.ID)
end

------------------------------------------------------

-- Helper function to get the icon associated with a quest
function GetQuestIcon(iMajor, iMinor, iQuest, iData1, iData2)
    local icon = GameInfo.Quests[iQuest].Icon
 
    if (icon) then
        if (string.len(icon) > 0 and string.sub(icon, 1, 1) == "[") then
            return icon
        end
 
        local status, ret = pcall(function () return loadstring("return " .. icon .. "(...)")(iMajor, iMinor, iQuest, iData1, iData2) end)
        if (status) then
            return ret
        end
    end
    
    return "[ICON_TEAM_1]"
end

-- Helper function to get the tooltip associated with a quest
function GetQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2)
	local tip = GameInfo.Quests[iQuest].Tooltip

	if (tip) then
		if (string.sub(tip, 1, 8) == "TXT_KEY_") then
			if (iData1 and iData1 >= 0 and iData1 < GameDefines.MAX_CIV_PLAYERS and Players[iData1]:IsEverAlive()) then
				return Locale.Lookup(tip, Players[iData1]:GetCivilizationShortDescriptionKey())
			else
				return Locale.Lookup(tip)
			end
		end

        local status, ret = pcall(function () return loadstring("return " .. tip .. "(...)")(iMajor, iMinor, iQuest, iData1, iData2) end)
        if (status) then
            return ret
		else
			return "*** QUEST TOOLTIP FUNCTION ERROR ***"
        end
	end
	
	return "*** UNDEFINED QUEST TOOLTIP ***"
end

------------------------------------------------------

-- Helper functions to get icons and tooltips for specific quests, these functions are referenced from the Quests database table - DO NOT RENAME!!!
function GetResourceQuestIcon(iMajor, iMinor, iQuest, iData1, iData2) return GameInfo.Resources[iData1].IconString; end
function GetResourceQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2) return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_CONNECT_RESOURCE_FORMAL", GameInfo.Resources[iData1].Description); end

function GetReligionQuestIcon(iMajor, iMinor, iQuest, iData1, iData2) return GameInfo.Religions[iData1].IconString; end
function GetReligionQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2) return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_SPREAD_RELIGION_FORMAL", Game.GetReligionName(iData1)); end

function GetFindPlayerQuestIcon(iMajor, iMinor, iQuest, iData1, iData2) return Players[iData1]:IsMinorCiv() and "[ICON_CITY_STATE]" or "[ICON_CAPITAL]"; end
function GetGreatPersonQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2) return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_GREAT_PERSON_FORMAL", GameInfo.Units[iData1].Description); end
function GetWonderQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2) return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_CONSTRUCT_WONDER_FORMAL", GameInfo.Buildings[iData1].Description); end
function GetKillCSQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2) return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_KILL_CITY_STATE_FORMAL", Players[iData1]:GetNameKey()); end

function GetContestCultureQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2)
	local pMinor = Players[iMinor]
	local iMajorScore = pMinor:GetMinorCivContestValueForPlayer(iMajor, iQuest)
	if (pMinor:IsMinorCivContestLeader(iMajor, iQuest)) then
		return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_CONTEST_CULTURE_WINNING_FORMAL", iMajorScore)
	else
		local iLeaderScore = pMinor:GetMinorCivContestValueForLeader(iQuest)
		return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_CONTEST_CULTURE_LOSING_FORMAL", iLeaderScore, iMajorScore)
	end
end

function GetContestFaithQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2)
	local pMinor = Players[iMinor]
	local iMajorScore = pMinor:GetMinorCivContestValueForPlayer(iMajor, iQuest)
	if (pMinor:IsMinorCivContestLeader(iMajor, iQuest)) then
		return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_CONTEST_FAITH_WINNING_FORMAL", iMajorScore)
	else
		local iLeaderScore = pMinor:GetMinorCivContestValueForLeader(iQuest)
		return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_CONTEST_FAITH_LOSING_FORMAL", iLeaderScore, iMajorScore)
	end
end

function GetContestTechsQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2)
	local pMinor = Players[iMinor]
	local iMajorScore = pMinor:GetMinorCivContestValueForPlayer(iMajor, iQuest)
	if (pMinor:IsMinorCivContestLeader(iMajor, iQuest)) then
		return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_CONTEST_TECHS_WINNING_FORMAL", iMajorScore)
	else
		local iLeaderScore = pMinor:GetMinorCivContestValueForLeader(iQuest)
		return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_CONTEST_TECHS_LOSING_FORMAL", iLeaderScore, iMajorScore)
	end
end

-- Include any mod specific functions to get icons and tooltips
include("CityStateQuests_Helpers_%w+.lua", true);

------------------------------------------------------

function GetCityStateStatusRow(iMajor, iMinor)
	local pMajor = Players[iMajor];
	local pMinor = Players[iMinor];
	
	if (pMajor == nil or pMinor == nil) then
		print("Lua error - invalid player index");
	end
	
	local iMajorTeam = pMajor:GetTeam();
	local iMinorTeam = pMinor:GetTeam();
	local pMajorTeam = Teams[iMajorTeam];
	local pMinorTeam = Teams[iMinorTeam];
	
	local iInf = pMinor:GetMinorCivFriendshipWithMajor(iMajor);
	local bWar = pMajorTeam:IsAtWar(iMinorTeam);
	local bCanBully = pMinor:CanMajorBullyGold(iMajor);
	local bAllies = pMinor:IsAllies(iMajor);
	
	-- War
	if (bWar) then
		return GameInfo.MinorCivTraits_Status["MINOR_FRIENDSHIP_STATUS_WAR"];
	end
	
	-- Negative INF
	if (iInf < GameDefines["FRIENDSHIP_THRESHOLD_NEUTRAL"]) then
		-- Able to bully?
		if (bCanBully) then
			return GameInfo.MinorCivTraits_Status["MINOR_FRIENDSHIP_STATUS_AFRAID"];
		else
			return GameInfo.MinorCivTraits_Status["MINOR_FRIENDSHIP_STATUS_ANGRY"];
		end
	-- Neutral
	elseif (iInf < GameDefines["FRIENDSHIP_THRESHOLD_FRIENDS"]) then
		return GameInfo.MinorCivTraits_Status["MINOR_FRIENDSHIP_STATUS_NEUTRAL"];
	-- Friends
	elseif (iInf < GameDefines["FRIENDSHIP_THRESHOLD_ALLIES"]) then
		return GameInfo.MinorCivTraits_Status["MINOR_FRIENDSHIP_STATUS_FRIENDS"];
	-- Friends, but high enough INF to be a potential ally
	elseif (not bAllies) then
		return GameInfo.MinorCivTraits_Status["MINOR_FRIENDSHIP_STATUS_FRIENDS"];
	-- Allies
	else
		return GameInfo.MinorCivTraits_Status["MINOR_FRIENDSHIP_STATUS_ALLIES"];
	end
end

function GetCityStateStatusType(iMajor, iMinor)
	local row = GetCityStateStatusRow(iMajor, iMinor);
	return row.Type;
end

function UpdateCityStateStatusBar(iMajor, iMinor, posBarCtrl, negBarCtrl, barMarkerCtrl)
	local pMajor = Players[iMajor];
	local pMinor = Players[iMinor];
	
	if (pMajor == nil or pMinor == nil) then
		print("Lua error - invalid player index");
	end
	
	local info = GetCityStateStatusRow(iMajor, iMinor);
	local iInf = pMinor:GetMinorCivFriendshipWithMajor(iMajor);
	
	if (info.PositiveStatusMeter ~= nil) then
		local percentFull = math.abs(iInf) / kPosInfRange;
		local xOffset = math.min(percentFull * kPosBarRange, kPosBarRange);
		barMarkerCtrl:SetOffsetX(xOffset);
		posBarCtrl:SetTexture(info.PositiveStatusMeter);
		posBarCtrl:SetPercent(percentFull);
		posBarCtrl:SetHide(false);
	else
		posBarCtrl:SetHide(true);
	end
	
	if (info.NegativeStatusMeter ~= nil) then
		local percentFull = math.abs(iInf) / kNegInfRange;
		local xOffset = -1 * math.min(percentFull * kNegBarRange, kNegBarRange);
		barMarkerCtrl:SetOffsetX(xOffset);
		negBarCtrl:SetTexture(info.NegativeStatusMeter);
		negBarCtrl:SetPercent(percentFull);
		negBarCtrl:SetHide(false);
	else
		negBarCtrl:SetHide(true);
	end
	
	-- Bubble icon for meter
	local size = barMarkerCtrl:GetSize().x;
	-- Special case when INF = 0
	if (iInf == 0) then
		IconHookup(kBarIconNeutralIndex, size, kBarIconAtlas, barMarkerCtrl);
	elseif (info.StatusMeterIconAtlasIndex ~= nil) then
		IconHookup(info.StatusMeterIconAtlasIndex, size, kBarIconAtlas, barMarkerCtrl);
	end
end

function UpdateCityStateStatusIconBG(iMajor, iMinor, iconBGCtrl)
	local info = GetCityStateStatusRow(iMajor, iMinor);
	
	if (info.StatusIcon ~= nil) then
		iconBGCtrl:SetTexture(info.StatusIcon);
	end
end

function UpdateCityStateStatusUI(iMajor, iMinor, posBarCtrl, negBarCtrl, barMarkerCtrl, iconBGCtrl)
	UpdateCityStateStatusBar(iMajor, iMinor, posBarCtrl, negBarCtrl, barMarkerCtrl);
	UpdateCityStateStatusIconBG(iMajor, iMinor, iconBGCtrl);
end

function GetCityStateStatusText(iMajor, iMinor)
	local pMajor = Players[iMajor];
	local pMinor = Players[iMinor];
	
	if (pMajor == nil or pMinor == nil) then
		print("Lua error - invalid player index");
	end
	
	local iMajorTeam = pMajor:GetTeam();
	local iMinorTeam = pMinor:GetTeam();
	local pMajorTeam = Teams[iMajorTeam];
	local pMinorTeam = Teams[iMinorTeam];
	
	local bWar = pMajorTeam:IsAtWar(iMinorTeam);
	local bCanBully = pMinor:CanMajorBullyGold(iMajor);
	
	-- Status
	local strStatusText = "";
	
	if (pMinor:IsAllies(iMajor)) then		-- Allies
		strStatusText = Locale.ConvertTextKey("TXT_KEY_ALLIES");
		strStatusText = "[COLOR_POSITIVE_TEXT]" .. strStatusText .. "[ENDCOLOR]";
		
	elseif (pMinor:IsFriends(iMajor)) then		-- Friends
		strStatusText = Locale.ConvertTextKey("TXT_KEY_FRIENDS");
		strStatusText = "[COLOR_POSITIVE_TEXT]" .. strStatusText .. "[ENDCOLOR]";
		
	elseif (pMinor:IsMinorPermanentWar(iActiveTeam)) then		-- Permanent War
		strStatusText = Locale.ConvertTextKey("TXT_KEY_PERMANENT_WAR");
		strStatusText = "[COLOR_NEGATIVE_TEXT]" .. strStatusText .. "[ENDCOLOR]";
		
	elseif (pMinor:IsPeaceBlocked(iActiveTeam)) then		-- Peace blocked by being at war with ally
		strStatusText = Locale.ConvertTextKey("TXT_KEY_PEACE_BLOCKED");
		strStatusText = "[COLOR_NEGATIVE_TEXT]" .. strStatusText .. "[ENDCOLOR]";
		
	elseif (bWar) then		-- War
		strStatusText = Locale.ConvertTextKey("TXT_KEY_WAR");
		strStatusText = "[COLOR_NEGATIVE_TEXT]" .. strStatusText .. "[ENDCOLOR]";
		
	elseif (pMinor:GetMinorCivFriendshipWithMajor(iMajor) < GameDefines["FRIENDSHIP_THRESHOLD_NEUTRAL"]) then
		-- Afraid
		if (bCanBully) then
			strStatusText = Locale.ConvertTextKey("TXT_KEY_AFRAID");
		-- Angry
		else
			strStatusText = Locale.ConvertTextKey("TXT_KEY_ANGRY");
		end
		strStatusText = "[COLOR_NEGATIVE_TEXT]" .. strStatusText .. "[ENDCOLOR]";
		
	else		-- Neutral
		strStatusText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_PERSONALITY_NEUTRAL");
		strStatusText = "[COLOR_POSITIVE_TEXT]" .. strStatusText .. "[ENDCOLOR]";
	end
	
	return strStatusText;
end

function GetCityStateStatusToolTip(iMajor, iMinor, bFullInfo)
	local pMajor = Players[iMajor];
	local pMinor = Players[iMinor];
	
	if (pMajor == nil or pMinor == nil) then
		print("Lua error - invalid player index");
	end
	
	local iMajorTeam = pMajor:GetTeam();
	local iMinorTeam = pMinor:GetTeam();
	local pMajorTeam = Teams[iMajorTeam];
	local pMinorTeam = Teams[iMinorTeam];
	
	local bWar = pMajorTeam:IsAtWar(iMinorTeam);
	local bCanBully = pMinor:CanMajorBullyGold(iMajor);
	
	local strShortDescKey = pMinor:GetCivilizationShortDescriptionKey();
	local iInfluence = pMinor:GetMinorCivFriendshipWithMajor(iMajor);
	local iInfluenceChangeThisTurn = pMinor:GetFriendshipChangePerTurnTimes100(iMajor) / 100;
	local iInfluenceAnchor = pMinor:GetMinorCivFriendshipAnchorWithMajor(iMajor);
	
	local strStatusTT = "";
	
	-- Status and Influence
	if (pMinor:IsAllies(iMajor)) then		-- Allies
		strStatusTT = Locale.ConvertTextKey("TXT_KEY_DIPLO_STATUS_TT", Locale.ConvertTextKey(strShortDescKey), Locale.ConvertTextKey("TXT_KEY_ALLIES"),
										  iInfluence, 
										  GameDefines["FRIENDSHIP_THRESHOLD_MAX"] - GameDefines["FRIENDSHIP_THRESHOLD_ALLIES"]); 
		
		local strTempTT = Locale.ConvertTextKey("TXT_KEY_ALLIES_CSTATE_TT", strShortDescKey);
		
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]" .. strTempTT;
		
	elseif (pMinor:IsFriends(iMajor)) then		-- Friends
		strStatusTT = Locale.ConvertTextKey("TXT_KEY_DIPLO_STATUS_TT", Locale.ConvertTextKey(strShortDescKey), Locale.ConvertTextKey("TXT_KEY_FRIENDS"),
										    iInfluence,
										    GameDefines["FRIENDSHIP_THRESHOLD_ALLIES"] - GameDefines["FRIENDSHIP_THRESHOLD_FRIENDS"]);
		
		local strTempTT = Locale.ConvertTextKey("TXT_KEY_FRIENDS_CSTATE_TT", strShortDescKey);
		
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]" .. strTempTT;
		
	elseif (pMinor:IsMinorPermanentWar(iActiveTeam)) then		-- Permanent War
		strStatusTT = Locale.ConvertTextKey("TXT_KEY_DIPLO_STATUS_TT", Locale.ConvertTextKey(strShortDescKey), Locale.ConvertTextKey("TXT_KEY_ANGRY"),
										    iInfluence, GameDefines["MINOR_FRIENDSHIP_AT_WAR"]);
										    
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_PERMANENT_WAR_CSTATE_TT", strShortDescKey);
		
	elseif (pMinor:IsPeaceBlocked(iActiveTeam)) then		-- Peace blocked by being at war with ally
		strStatusTT = Locale.ConvertTextKey("TXT_KEY_DIPLO_STATUS_TT", Locale.ConvertTextKey(strShortDescKey), Locale.ConvertTextKey("TXT_KEY_ANGRY"),
										    iInfluence, GameDefines["MINOR_FRIENDSHIP_AT_WAR"]);
										    
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_PEACE_BLOCKED_CSTATE_TT", strShortDescKey);
		
	elseif (bWar) then		-- War
		strStatusTT = Locale.ConvertTextKey("TXT_KEY_DIPLO_STATUS_TT", Locale.ConvertTextKey(strShortDescKey), Locale.ConvertTextKey("TXT_KEY_ANGRY"),
										    iInfluence, GameDefines["MINOR_FRIENDSHIP_AT_WAR"]);
										    
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]" ..Locale.ConvertTextKey("TXT_KEY_WAR_CSTATE_TT", strShortDescKey);
		
	elseif (iInfluence < GameDefines["FRIENDSHIP_THRESHOLD_NEUTRAL"]) then
		-- Afraid
		if (bCanBully) then
			strStatusTT = Locale.ConvertTextKey("TXT_KEY_DIPLO_STATUS_TT", Locale.ConvertTextKey(strShortDescKey), Locale.ConvertTextKey("TXT_KEY_AFRAID"),
										    iInfluence, GameDefines["MINOR_FRIENDSHIP_AT_WAR"]);
		-- Angry
		else
			strStatusTT = Locale.ConvertTextKey("TXT_KEY_DIPLO_STATUS_TT", Locale.ConvertTextKey(strShortDescKey), Locale.ConvertTextKey("TXT_KEY_ANGRY"),
										    iInfluence, GameDefines["MINOR_FRIENDSHIP_AT_WAR"]);
		end
										    
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_ANGRY_CSTATE_TT", strShortDescKey);
		
	else		-- Neutral
		strStatusTT = Locale.ConvertTextKey("TXT_KEY_DIPLO_STATUS_TT", Locale.ConvertTextKey(strShortDescKey), Locale.ConvertTextKey("TXT_KEY_CITY_STATE_PERSONALITY_NEUTRAL"),
										    iInfluence - GameDefines["FRIENDSHIP_THRESHOLD_NEUTRAL"], 
											GameDefines["FRIENDSHIP_THRESHOLD_FRIENDS"] - GameDefines["FRIENDSHIP_THRESHOLD_NEUTRAL"]);
										    
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_NEUTRAL_CSTATE_TT", strShortDescKey);
	end
	
	-- Influence change
	if (iInfluence ~= iInfluenceAnchor) then
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
		strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_INFLUENCE_RATE", iInfluenceChangeThisTurn, iInfluenceAnchor);
	end
	
	-- Bullying
	if (bCanBully) then
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
		strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_CAN_BULLY");
	else
		strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
		strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_CANNOT_BULLY");
	end
	
	if (bFullInfo) then
		-- Open Borders
		if (pMinor:IsPlayerHasOpenBorders(iMajor)) then
		
			strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
		
			if (pMinor:IsPlayerHasOpenBordersAutomatically(iMajor)) then
				strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_OPEN_BORDERS_TRAIT");
			else
				strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_OPEN_BORDERS_FRIENDS");
			end
		end
		
		-- Friendship bonuses
		local iCultureBonus = pMinor:GetMinorCivCurrentCultureBonus(iMajor);
		if (iCultureBonus ~= 0) then
			strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
			strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_CULTURE_BONUS", iCultureBonus);
		end
		
		local iCapitalFoodBonus = pMinor:GetCurrentCapitalFoodBonus(iMajor) / 100;
		local iOtherCityFoodBonus = pMinor:GetCurrentOtherCityFoodBonus(iMajor) / 100;
		if (iCapitalFoodBonus ~= 0 or iOtherCityFoodBonus ~= 0) then
			strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
			strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_FOOD_BONUS", iCapitalFoodBonus, iOtherCityFoodBonus);
		end
		
		local iCurrentSpawnEstimate = pMinor:GetCurrentSpawnEstimate(iMajor);
		if (iCurrentSpawnEstimate ~= 0) then
			strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
			strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_MILITARY_BONUS", iCurrentSpawnEstimate);
		end
		
		local iScienceBonus = pMinor:GetCurrentScienceFriendshipBonusTimes100(iMajor);
		if (iScienceBonus ~= 0) then
			strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
			strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_SCIENCE_BONUS", iScienceBonus / 100);
		end
		
		local iHappinessBonus = pMinor:GetMinorCivCurrentHappinessBonus(iMajor);
		if (iHappinessBonus ~= 0) then
			strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
			strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_HAPPINESS_BONUS", iHappinessBonus);
		end
		
		local iFaithBonus = pMinor:GetMinorCivCurrentFaithBonus(iMajor);
		if (iFaithBonus ~= 0) then
			strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
			strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_FAITH_BONUS", iFaithBonus);
		end
		
		-- Resources
		local strExportedResourceText = "";
		
		local iAmount;
		
		for pResource in GameInfo.Resources() do
			iResourceLoop = pResource.ID;
			
			iAmount = pMinor:GetResourceExport(iResourceLoop);
			
			if (iAmount > 0) then
				
				local pResource = GameInfo.Resources[iResourceLoop];
				
				if (Game.GetResourceUsageType(iResourceLoop) ~= ResourceUsageTypes.RESOURCEUSAGE_BONUS) then
					strExportedResourceText = strExportedResourceText .. pResource.IconString .. " [COLOR_POSITIVE_TEXT]" .. Locale.ConvertTextKey(pResource.Description) .. " (" .. iAmount .. ") [ENDCOLOR]";
				end
			end
		end
		
		if (strExportedResourceText ~= "") then
			if (pMinor:IsAllies(iMajor)) then
				strStatusTT = strStatusTT .. "[NEWLINE][NEWLINE]";
				strStatusTT = strStatusTT .. Locale.ConvertTextKey("TXT_KEY_CSTATE_RESOURCES_RECEIVED", strExportedResourceText);
			end
		end
	end
	
	return strStatusTT;
end

function GetAllyText(iActivePlayer, iMinor)
	local sText = "";
	
	local pActivePlayer = Players[iActivePlayer];
	local pMinor = Players[iMinor];
	if (pActivePlayer ~= nil and pMinor ~= nil) then
		local iAlly = pMinor:GetAlly();
		-- Has an ally
		if (iAlly ~= nil and iAlly ~= -1) then
			-- Not us
			if (iAlly ~= iActivePlayer) then
				-- Someone we know
				if (Teams[pActivePlayer:GetTeam()]:IsHasMet(Players[iAlly]:GetTeam())) then
					sText = "[COLOR_POSITIVE_TEXT]" .. Locale.ConvertTextKey(Players[iAlly]:GetCivilizationShortDescriptionKey()) .. "[ENDCOLOR]";
				-- Someone we haven't met
				else
					sText = "?";
				end
			-- Us
			else
				sText = "[COLOR_POSITIVE_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_YOU") .. "[ENDCOLOR]";
			end
		-- No ally
		else
			sText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_NOBODY");
		end
	end
	
	return sText;
end

function GetAllyToolTip(iActivePlayer, iMinor)
	local sToolTip = "";
	
	local pActivePlayer = Players[iActivePlayer];
	local pMinor = Players[iMinor];
	if (pActivePlayer ~= nil and pMinor ~= nil) then
		local iActivePlayerInf = pMinor:GetMinorCivFriendshipWithMajor(iActivePlayer);
		local iAlly = pMinor:GetAlly();
		-- Has an ally
		if (iAlly ~= nil and iAlly ~= -1) then
			local iAllyInf = pMinor:GetMinorCivFriendshipWithMajor(iAlly);
			-- Not us
			if (iAlly ~= iActivePlayer) then
				-- Someone we know
				if (Teams[pActivePlayer:GetTeam()]:IsHasMet(Players[iAlly]:GetTeam())) then
					local iInfUntilAllied = iAllyInf - iActivePlayerInf + 1; -- needs to pass up the current ally, not just match
					sToolTip = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_ALLY_TT", Players[iAlly]:GetCivilizationShortDescriptionKey(), iInfUntilAllied);
				-- Someone we haven't met
				else
					local iInfUntilAllied = iAllyInf - iActivePlayerInf + 1; -- needs to pass up the current ally, not just match
					sToolTip = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_ALLY_UNKNOWN_TT", iInfUntilAllied);
				end
			-- Us
			else
				sToolTip = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_ALLY_ACTIVE_PLAYER_TT");
			end
		-- No ally
		else
			local iInfUntilAllied = GameDefines["FRIENDSHIP_THRESHOLD_ALLIES"] - iActivePlayerInf;
			sToolTip = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_ALLY_NOBODY_TT", iInfUntilAllied);
		end
	end
	
	return sToolTip;
end

function GetActiveQuestText(iMajor, iMinor)
	local iMajor = iMajor;
	local pMinor = Players[iMinor];
	
	local sIconText = "";
	local iNumQuests = 0;
	
	if (pMinor == nil) then
		return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_NONE");
	end
	
	for i, eType in ipairs(ktQuestsDisplayOrder) do
		if (pMinor:IsMinorCivDisplayedQuestForPlayer(iMajor, eType)) then
			
			iNumQuests = iNumQuests + 1;
			
			-- This data is not pertinent for all quest types, but grab it here for readability
			local iQuestData1 = pMinor:GetQuestData1(iMajor, eType);
			local iQuestData2 = pMinor:GetQuestData2(iMajor, eType);
			
			sIconText = sIconText .. GetQuestIcon(iMajor, iMinor, eType, iQuestData1, iQuestData2)
		end
	end
	
	-- Threatening Barbarians event
	if (pMinor:IsThreateningBarbariansEventActiveForPlayer(iMajor)) then
		iNumQuests = iNumQuests + 1;
		sIconText = sIconText .. "[ICON_RAZING]";
	end
	
	-- Proxy War event
	if (pMinor:IsProxyWarActiveForMajor(iMajor)) then
		iNumQuests = iNumQuests + 1;
		sIconText = sIconText .. "[ICON_RESISTANCE]";
	end
	
	if (iNumQuests <= 0) then
		sIconText = Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_NONE");
	end
	
	return sIconText;
end

function GetGreatPersonQuestIconText(iUnitType)
	sIconText = "[ICON_GREAT_PEOPLE]";
	
	if (GameInfo.Units["UNIT_ENGINEER"] ~= nil and GameInfo.Units["UNIT_ENGINEER"].ID == iUnitType) then
		sIconText = "[ICON_GREAT_ENGINEER]";
	elseif (GameInfo.Units["UNIT_GREAT_GENERAL"] ~= nil and GameInfo.Units["UNIT_GREAT_GENERAL"].ID == iUnitType) then
		sIconText = "[ICON_GREAT_GENERAL]";
	elseif (GameInfo.Units["UNIT_SCIENTIST"] ~= nil and GameInfo.Units["UNIT_SCIENTIST"].ID == iUnitType) then
		sIconText = "[ICON_GREAT_SCIENTIST]";
	elseif (GameInfo.Units["UNIT_MERCHANT"] ~= nil and GameInfo.Units["UNIT_MERCHANT"].ID == iUnitType) then
		sIconText = "[ICON_GREAT_MERCHANT]";
	elseif (GameInfo.Units["UNIT_ARTIST"] ~= nil and GameInfo.Units["UNIT_ARTIST"].ID == iUnitType) then
		sIconText = "[ICON_GREAT_ARTIST]";
	elseif (GameInfo.Units["UNIT_MUSICIAN"] ~= nil and GameInfo.Units["UNIT_MUSICIAN"].ID == iUnitType) then
		sIconText = "[ICON_GREAT_MUSICIAN]";
	elseif (GameInfo.Units["UNIT_WRITER"] ~= nil and GameInfo.Units["UNIT_WRITER"].ID == iUnitType) then
		sIconText = "[ICON_GREAT_WRITER]";
	elseif (GameInfo.Units["UNIT_GREAT_ADMIRAL"] ~= nil and GameInfo.Units["UNIT_GREAT_ADMIRAL"].ID == iUnitType) then
		sIconText = "[ICON_GREAT_ADMIRAL]";
	elseif (GameInfo.Units["UNIT_PROPHET"] ~= nil and GameInfo.Units["UNIT_PROPHET"].ID == iUnitType) then
		sIconText = "[ICON_PROPHET]";
	end
	
	return sIconText;
end

function GetActiveQuestToolTip(iMajor, iMinor)
	local iMajor = Game.GetActivePlayer();
	local pMinor = Players[iMinor];
	
	local sToolTipText = "";
	local iNumQuests = 0;
	
	if (pMinor == nil) then
		return Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_NONE_FORMAL");
	end
	
	for i, eType in ipairs(ktQuestsDisplayOrder) do
		if (pMinor:IsMinorCivDisplayedQuestForPlayer(iMajor, eType)) then
		
			iNumQuests = iNumQuests + 1;
			if (sToolTipText ~= "") then
				sToolTipText = sToolTipText .. "[NEWLINE]"
			end
			sToolTipText = sToolTipText .. "[ICON_BULLET]";
			
			-- This data is not pertinent for all quest types, but grab it here for readability
			local iQuestData1 = pMinor:GetQuestData1(iMajor, eType);
			local iQuestData2 = pMinor:GetQuestData2(iMajor, eType);
			local iTurnsRemaining = pMinor:GetQuestTurnsRemaining(iMajor, eType, Game.GetGameTurn() - 1); -- add 1 since began on CS's turn (1 before), and avoids "0 turns remaining"
			
			sToolTipText = sToolTipText .. GetQuestTooltip(iMajor, iMinor, eType, iQuestData1, iQuestData2)
			
			if (iTurnsRemaining >= 0) then
				sToolTipText = sToolTipText .. " " .. Locale.Lookup( "TXT_KEY_CITY_STATE_QUEST_TURNS_REMAINING_FORMAL", iTurnsRemaining );
			end
		end
	end
	
	-- Threatening Barbarians event
	if (pMinor:IsThreateningBarbariansEventActiveForPlayer(iMajor)) then
		iNumQuests = iNumQuests + 1;
		if (sToolTipText ~= "") then
			sToolTipText = sToolTipText .. "[NEWLINE]";
		end
		sToolTipText = sToolTipText .. "[ICON_BULLET]";
		sToolTipText = sToolTipText .. Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_INVADING_BARBS_FORMAL");
	end
	
	-- Proxy War event
	if (pMinor:IsProxyWarActiveForMajor(iMajor)) then
		iNumQuests = iNumQuests + 1;
		if (sToolTipText ~= "") then
			sToolTipText = sToolTipText .. "[NEWLINE]";
		end
		sToolTipText = sToolTipText .. "[ICON_BULLET]";	
		sToolTipText = sToolTipText .. Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_GIFT_UNIT_FORMAL");
	end
	
	if (iNumQuests <= 0) then
		sToolTipText = Locale.Lookup("TXT_KEY_CITY_STATE_QUEST_NONE_FORMAL");
	end
	
	return sToolTipText;
end

function GetCityStateTraitText(iMinor)
	local strTraitText = "";
	local pMinor = Players[iMinor];
	if (pMinor ~= nil) then
		local iTrait = pMinor:GetMinorCivTrait();
		if (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_CULTURED) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_CULTURED_ADJECTIVE");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MILITARISTIC) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MILITARISTIC_ADJECTIVE");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MARITIME) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MARITIME_ADJECTIVE");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MERCANTILE) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MERCANTILE_ADJECTIVE");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_RELIGIOUS) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_RELIGIOUS_ADJECTIVE");
		end
	end
	
	return strTraitText;
end

function GetCityStateTraitToolTip(iMinor)
	local strTraitTT = "";
	local pMinor = Players[iMinor];
	if (pMinor ~= nil) then
		local iTrait = pMinor:GetMinorCivTrait();
		if (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_CULTURED) then
			strTraitTT = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_CULTURED_TT");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MILITARISTIC) then
			strTraitTT = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MILITARISTIC_NO_UU_TT");
			if (pMinor:IsMinorCivHasUniqueUnit()) then
				local eUniqueUnit = pMinor:GetMinorCivUniqueUnit();
				if (GameInfo.Units[eUniqueUnit] ~= nil) then
					local ePrereqTech = GameInfo.Units[eUniqueUnit].PrereqTech;
					if (ePrereqTech == nil) then
						-- If no prereq then just make it Agriculture, but make sure that Agriculture is in our database. Otherwise, show the fallback tooltip.
						if (GameInfo.Technologies["TECH_AGRICULTURE"] ~= nil) then
							ePrereqTech = GameInfo.Technologies["TECH_AGRICULTURE"].ID;
						end
					end
					
					if (ePrereqTech ~= nil) then
						if (GameInfo.Technologies[ePrereqTech] ~= nil) then
							strTraitTT = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MILITARISTIC_TT", GameInfo.Units[eUniqueUnit].Description, GameInfo.Technologies[ePrereqTech].Description);
						end
					end
				else
					print("Scripting error - City-State's unique unit not found!");
				end
			end
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MARITIME) then
			strTraitTT = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MARITIME_TT");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MERCANTILE) then
			strTraitTT = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MERCANTILE_TT");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_RELIGIOUS) then
			strTraitTT = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_RELIGIOUS_TT");
		end
	end
	
	return strTraitTT;
end