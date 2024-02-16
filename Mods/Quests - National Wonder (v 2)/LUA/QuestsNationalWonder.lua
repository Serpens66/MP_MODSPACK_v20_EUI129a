print("This is the 'Quests - National Wonder' mod script.")

local iThisQuest = GameInfoTypes.MINOR_CIV_QUEST_NATIONAL_WONDER
local iEraMinimum = GameInfoTypes.ERA_MEDIEVAL

--
-- House-keeping of who has built what national wonders
--

-- Find all the national wonder building classes
local nationalWonderClasses = {}
for row in DB.Query("SELECT ID, Type FROM BuildingClasses WHERE MaxPlayerInstances=1") do
	nationalWonderClasses[row.Type] = row.ID
end

-- Find all the national wonders already constructed by players
local playerNationalWonders = {}
for iPlayer = 0, GameDefines.MAX_CIV_PLAYERS-1, 1 do
	playerNationalWonders[iPlayer] = {}
	
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsAlive()) then
		for nwClass, nwID in pairs(nationalWonderClasses) do
			playerNationalWonders[iPlayer][nwClass] = (pPlayer:GetBuildingClassCount(nwID) > 0)
		end
	end
end

-- Watch for new national wonders being built
function OnCityConstructed(iPlayer, iCity, iBuilding)
	local class = GameInfo.Buildings[iBuilding].BuildingClass
	
	if (nationalWonderClasses[class]) then
		playerNationalWonders[iPlayer][class] = true
	end
end
GameEvents.CityConstructed.Add(OnCityConstructed)


--
-- Quest event handlers (in the approximate order they will occur)
--

function OnQuestIsAvailable(iPlayer, iCS, iQuest, bNewQuest, iData1, iData2)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestIsAvailable(%i, %i, %i, %s, %i, %i)", iPlayer, iCS, iQuest, (bNewQuest and "true" or "false"), iData1, iData2))

		-- Only let the player join in if they haven't bullied the City State recently
		if (not Players[iCS]:IsRecentlyBulliedByMajor(iPlayer)) then
			-- Only let the player join in if they are in (or past) the appropriate era
			if (Players[iPlayer]:GetCurrentEra() >= iEraMinimum) then
				for _, bConstructed in pairs(playerNationalWonders[iPlayer]) do
					-- We don't care what it is, just that there is something left.  In a real mod this would be much more selective
					if (not bConstructed) then
						return true
					end
				end
			end
		end
	end
	
	return false
end
GameEvents.QuestIsAvailable.Add(OnQuestIsAvailable)

function OnQuestGetData(iPlayer, iCS, iQuest, bData1)
	if (iQuest == iThisQuest and bData1) then
		-- print(string.format("QuestGetData(%i, %i, %i, %s)", iPlayer, iCS, iQuest, (bData1 and "true" or "false")))
		local nwAvailable = {}

		-- Find all the unbuilt national wonders
		for nwClass, bConstructed in pairs(playerNationalWonders[iPlayer]) do
			if (not bConstructed) then
				table.insert(nwAvailable, nwClass)
			end
		end

		-- Pick one at random
		return nationalWonderClasses[nwAvailable[Game.Rand(#nwAvailable, "National Wonder for quest")+1]]
	end
	
	return 0
end
GameEvents.QuestGetData.Add(OnQuestGetData)

function OnQuestSendNotification(iPlayer, iCS, iQuest, iStartTurn, iEndTurn, iData1, iData2, bStart, bFinish, sNames)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestSendNotification(%i, %i, %i, %i, %i, %i, %i, %s, %s, %s)", iPlayer, iCS, iQuest, iStartTurn, iEndTurn, iData1, iData2, (bStart and "true" or "false"), (bFinish and "true" or "false"), sNames))
		local sMinor = Players[iCS]:GetName()
		local sBuilding = GameInfo.Buildings[Players[iPlayer]:GetSpecificBuildingType(GameInfo.BuildingClasses[iData1].Type)].Description

		if (bStart) then
			-- Notify the player the quest has started
			local sMessage = Locale.ConvertTextKey("TXT_KEY_MINOR_CIV_QUEST_NATIONAL_WONDER_START", sMinor, sBuilding)
			local sSummary = Locale.ConvertTextKey("TXT_KEY_MINOR_CIV_QUEST_NATIONAL_WONDER_START_S", sMinor, sBuilding)

			Players[iPlayer]:AddQuestNotification(iCS, sMessage, sSummary, -1, -1, true)
		elseif (bFinish) then
			-- Influence boost has already been handled via the Friendship entry in the quest definition
			
			-- Notify the player the quest has finished
			local sMessage = Locale.ConvertTextKey("TXT_KEY_MINOR_CIV_QUEST_NATIONAL_WONDER_FINISH", sMinor, sBuilding, GameInfo.Quests[iQuest].Friendship)
			local sSummary = Locale.ConvertTextKey("TXT_KEY_MINOR_CIV_QUEST_NATIONAL_WONDER_FINISH_S", sMinor, sBuilding)

			Players[iPlayer]:AddQuestNotification(iCS, sMessage, sSummary, -1, -1, false)
		end
	end
end
GameEvents.QuestSendNotification.Add(OnQuestSendNotification)

function OnQuestIsCompleted(iPlayer, iCS, iQuest, bLastTurn)
	if (iQuest == iThisQuest) then
		-- print(string.format("QuestIsCompleted(%i, %i, %i, %s)", iPlayer, iCS, iQuest, (bLastTurn and "true" or "false")))
		-- Have we built the national wonder yet?
		return (Players[iPlayer]:GetBuildingClassCount(Players[iCS]:GetQuestData1(iPlayer, iQuest)) > 0)
	end
	
	return false
end
GameEvents.QuestIsCompleted.Add(OnQuestIsCompleted)
