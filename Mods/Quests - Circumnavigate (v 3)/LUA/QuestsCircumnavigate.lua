print("This is the 'Quests - Circumnavigate' mod script.")

local iThisQuest = GameInfoTypes.MINOR_CIV_QUEST_CIRCUMNAVIGATE
local iEraMinimum = GameInfoTypes.ERA_MEDIEVAL

--
-- House-keeping of who circumnavigated first
--

local modDB = Modding.OpenSaveData()
local iPlayerCircumnavigating = modDB.GetValue("MINOR_CIV_QUEST_CIRCUMNAVIGATE_PLAYER") or -1

-- added by serp to prevent getting the quest on maps you can not circumnavigate
-- code "taken" from CvGame::circumnavigationAvailable() from dll
function circumnavigationAvailable()
    
    if iPlayerCircumnavigating ~= -1 then
		return false
    end
    if not Map.IsWrapX() and not Map.IsWrapY() then
		return false
	end
	if (Map.GetLandPlots() > ((Map.GetNumPlots() * 2) / 3)) then
		return false
	end
        
    return true
end

function OnCircumnavigatedGlobe(iTeam)
	-- We get the team that circumnavigated the globe, so we'll give the win to the team leader
	-- As an example this is acceptable, a production mod may want to give the win to all team members,
	-- or track the current player and just give it to them
	iPlayerCircumnavigating = Players[Teams[iTeam]:GetLeaderID()]:GetID()
	-- print(string.format("Player %i has circumnavigated!", iPlayerCircumnavigating))
	
	modDB.SetValue("MINOR_CIV_QUEST_CIRCUMNAVIGATE_PLAYER", iPlayerCircumnavigating)
	
	GameEvents.CircumnavigatedGlobe.Remove(OnCircumnavigatedGlobe)
end
if (iPlayerCircumnavigating == -1) then
	GameEvents.CircumnavigatedGlobe.Add(OnCircumnavigatedGlobe)
end


--
-- Quest event handlers (in the approximate order they will occur)
--

function OnQuestIsAvailable(iPlayer, iCS, iQuest, bNewQuest, iData1, iData2)
	if (iQuest == iThisQuest) then
		-- If the map has already been circumnavigated, this quest is no longer available. serp: also check if the map itself can be circumvented
		if circumnavigationAvailable() then --(iPlayerCircumnavigating == -1) then
			-- print(string.format("QuestIsAvailable(%i, %i, %i, %s, %i, %i)", iPlayer, iCS, iQuest, (bNewQuest and "true" or "false"), iData1, iData2))
			if (bNewQuest) then
				-- This is a new quest
			else
				-- Joining an existing quest
			end
		
			-- Only let the player join in if they are in (or past) the appropriate era
			-- We could do something more complex here like checking for the ability to cross oceans (but that assumes a map with at least some water)
			-- or we could check the width of the map being greater than a certain value and WrapX being true
			return Players[iPlayer]:GetCurrentEra() >= iEraMinimum
		end
	end
	
	return false
end

function OnQuestStart(iPlayer, iCS, iQuest, bNewQuest, iStartTurn, iData1, iData2)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestStart(%i, %i, %i, %s, %i, %i, %i)", iPlayer, iCS, iQuest, (bNewQuest and "true" or "false"), iStartTurn, iData1, iData2))
		
		if (not Players[iPlayer]:IsHuman()) then
			-- Direct the AI to attempt to circumnavigate by activating the strategy to recon at sea
			Players[iPlayer]:ActivateEconomicStrategy(GameInfoTypes.ECONOMICAISTRATEGY_NEED_RECON_SEA)
		end
	end
end

function OnQuestGetData(iPlayer, iCS, iQuest, bData1)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestGetData(%i, %i, %i, %s)", iPlayer, iCS, iQuest, (bData1 and "true" or "false")))
		-- We don't need to store any data for this quest
	end
	
	return 0
end

function OnQuestContestValue(iPlayer, iCS, iQuest)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestContestValue(%i, %i, %i)", iPlayer, iCS, iQuest))
		-- Not needed, see "Quests - Tourism Contest" for an example
	end
	
	return 0
end

function OnQuestSendNotification(iPlayer, iCS, iQuest, iStartTurn, iEndTurn, iData1, iData2, bStart, bFinish, sNames)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestSendNotification(%i, %i, %i, %i, %i, %i, %i, %s, %s, %s)", iPlayer, iCS, iQuest, iStartTurn, iEndTurn, iData1, iData2, (bStart and "true" or "false"), (bFinish and "true" or "false"), sNames))
		if (bStart) then
			-- Notify the player the quest has started
			-- If both StartMessage and StartSummary are present in the quest definition, this will never occur
			
			-- While we could handle this with simple TXT_KEYs, we'll manually send the notification here as an example
			local sMinor = Players[iCS]:GetName()
			local sMessage, sSummary
			if (Map.IsWrapX()) then
				-- Map wraps, so we'll ask for circumnavigation
				sMessage = "TXT_KEY_MINOR_CIV_QUEST_CIRCUMNAVIGATE_START"
				sSummary = "TXT_KEY_MINOR_CIV_QUEST_CIRCUMNAVIGATE_START_S"
			else
				-- Map is a single continent, so we'll ask the player to cross it
				-- To implement this, needs MUCH more work
				sMessage = "TXT_KEY_MINOR_CIV_QUEST_TRANSCONTINENT_START"
				sSummary = "TXT_KEY_MINOR_CIV_QUEST_TRANSCONTINENT_START_S"
			end

			Players[iPlayer]:AddQuestNotification(iCS, Locale.ConvertTextKey(sMessage, sMinor), Locale.ConvertTextKey(sSummary, sMinor), -1, -1, true)
		elseif (bFinish) then
			-- Influence boost has already been handled via the Friendship entry in the quest definition
			
			-- Notify the player the quest has finished
			-- If both FinishMessage and FinishSummary are present in the quest definition, this will never occur
			
			-- Our messages are simple enough to handle with TXT_KEYs
		else
			-- Notify the player the quest has been cancelled
			-- If both CancelMessage and CancelSummary are present in the quest definition, this will never occur

			-- Our messages are simple enough to handle with TXT_KEYs
		end
		
		-- Quest is complete, so remove the handlers at the end of the turn
		if (bFinish and bNeedsRemoving) then
			GameEvents.PlayerDoTurn.Add(OnRemoveHandlers)
			bNeedsRemoving = false
		end
	end
end

function OnQuestIsCompleted(iPlayer, iCS, iQuest, bLastTurn)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestIsCompleted(%i, %i, %i, %s)", iPlayer, iCS, iQuest, (bLastTurn and "true" or "false")))
		-- Have we completed the quest by being the first player to circumnavigate the map?
		return (iPlayer == iPlayerCircumnavigating)
	end
	
	return false
end

function OnQuestIsExpired(iPlayer, iCS, iQuest)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestIsExpired(%i, %i, %i)", iPlayer, iCS, iQuest))
		-- Did someone beat us to it?
		return (iPlayerCircumnavigating ~= -1 and iPlayerCircumnavigating ~= iPlayer)
	end
	
	return false
end

function OnQuestIsRevoked(iPlayer, iCS, iQuest)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestIsRevoked(%i, %i, %i)", iPlayer, iCS, iQuest))
		-- We only revoke if iPlayer bullied iCS and that's handled by the RevokeOnBully entry in the quest definition
	end
	
	return false
end


local bNeedsRemoving = false

function OnRemoveHandlers(iPlayer)
	-- We remove the handlers on the Barbarian's turn, ie AFTER ALL the majors and minors have had a chance to report the outcome
	if (iPlayer == GameDefines.BARBARIAN_PLAYER) then
		GameEvents.QuestIsAvailable.Remove(OnQuestIsAvailable)
		GameEvents.QuestStart.Remove(OnQuestStart)
		GameEvents.QuestSendNotification.Remove(OnQuestSendNotification)
		GameEvents.QuestIsCompleted.Remove(OnQuestIsCompleted)
		GameEvents.QuestIsExpired.Remove(OnQuestIsExpired)
		bNeedsRemoving = false
		
		GameEvents.PlayerDoTurn.Remove(OnRemoveHandlers)
	end
end

-- Only install the handlers if the quest hasn't already been completed
if (iPlayerCircumnavigating == -1) then
	GameEvents.QuestIsAvailable.Add(OnQuestIsAvailable)
	GameEvents.QuestStart.Add(OnQuestStart)
	-- GameEvents.QuestGetData.Add(OnQuestGetData)
	-- GameEvents.QuestContestValue.Add(OnQuestContestValue)
	GameEvents.QuestSendNotification.Add(OnQuestSendNotification)
	GameEvents.QuestIsCompleted.Add(OnQuestIsCompleted)
	GameEvents.QuestIsExpired.Add(OnQuestIsExpired)
	-- GameEvents.QuestIsRevoked.Add(OnQuestIsRevoked)

	bNeedsRemoving = true
end
