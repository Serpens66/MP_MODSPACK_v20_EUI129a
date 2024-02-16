--
-- This file MUST follow the naming pattern of "CityStateQuests_Helpers_{something}.lua"
--

function GetTourismContestQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2)
  local pMinor = Players[iMinor]
  local iMajorScore = pMinor:GetMinorCivContestValueForPlayer(iMajor, iQuest)
  
  if (pMinor:IsMinorCivContestLeader(iMajor, iQuest)) then
    return Locale.Lookup("TXT_KEY_MINOR_CIV_QUEST_TOURISM_CONTEST_WINNING_FORMAL", iMajorScore)
  else
    local iLeaderScore = pMinor:GetMinorCivContestValueForLeader(iQuest)
	
    return Locale.Lookup("TXT_KEY_MINOR_CIV_QUEST_TOURISM_CONTEST_LOSING_FORMAL", iLeaderScore, iMajorScore)
  end
end
