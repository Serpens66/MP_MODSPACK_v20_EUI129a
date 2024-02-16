--
-- This file MUST follow the naming pattern of "CityStateQuests_Helpers_{something}.lua"
--

function GetNationalWonderQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2)
  return Locale.Lookup("TXT_KEY_MINOR_CIV_QUEST_NATIONAL_WONDER_FORMAL", GameInfo.Buildings[Players[iMajor]:GetSpecificBuildingType(GameInfo.BuildingClasses[iData1].Type)].Description)
end
