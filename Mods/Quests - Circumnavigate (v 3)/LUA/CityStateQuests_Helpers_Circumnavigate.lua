--
-- This file MUST follow the naming pattern of "CityStateQuests_Helpers_{something}.lua"
--

function GetCircumnavigateQuestIcon(iMajor, iMinor, iQuest, iData1, iData2)
  return "[ICON_TRADE]"
end

function GetCircumnavigateQuestTooltip(iMajor, iMinor, iQuest, iData1, iData2)
  return Locale.Lookup("TXT_KEY_MINOR_CIV_QUEST_CIRCUMNAVIGATE_FORMAL")
end
