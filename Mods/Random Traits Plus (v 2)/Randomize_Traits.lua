-- Leader_Traits
-- Author: Serp
-- distributes the traits(policies) randomly to current leaders
--=======================================================================================================================
-- CORE FUNCTIONS
--=======================================================================================================================
local num_traits = 2 -- the amount of traits every leader should get


local traits = {"POLICY_AGGRESSIVE_X", "POLICY_CHARISMATIC_X", "POLICY_CREATIVE_X", "POLICY_DIPLOMATIC_X", 
                "POLICY_WIDE_X", "POLICY_TALL_X","POLICY_FINANCIAL_X", "POLICY_IMPERIALISTIC_X", "POLICY_INDUSTRIOUS_X", 
                "POLICY_INVENTIVE_X", "POLICY_MERCANTILE_X", "POLICY_PHILOSOPHICAL_X", "POLICY_PROTECTIVE_X",
                "POLICY_SEAFARING_X", "POLICY_SPIRITUAL_X", "POLICY_EXPLORER_X"}
local trait_icons = {["POLICY_AGGRESSIVE_X"]="[ICON_WAR]", ["POLICY_CHARISMATIC_X"]="[ICON_HAPPINESS_1]", ["POLICY_CREATIVE_X"]="[ICON_CULTURE]", ["POLICY_DIPLOMATIC_X"]="[ICON_INFLUENCE]", 
                    ["POLICY_WIDE_X"]="[ICON_CONNECTED]",["POLICY_TALL_X"]="[ICON_CITIZEN]", ["POLICY_FINANCIAL_X"]="[ICON_GOLD]", ["POLICY_IMPERIALISTIC_X"]="[ICON_CITY_STATE]", ["POLICY_INDUSTRIOUS_X"]="[ICON_PRODUCTION]", 
                    ["POLICY_INVENTIVE_X"]="[ICON_RESEARCH]", ["POLICY_MERCANTILE_X"]="[ICON_INTERNATIONAL_TRADE]", ["POLICY_PHILOSOPHICAL_X"]="[ICON_GREAT_PEOPLE]", ["POLICY_PROTECTIVE_X"]="[ICON_STRENGTH]",
                    ["POLICY_SEAFARING_X"]="[ICON_GREAT_ADMIRAL]", ["POLICY_SPIRITUAL_X"]="[ICON_PEACE]", ["POLICY_EXPLORER_X"]="[ICON_GREAT_EXPLORER]"}

function Distribute_Random_Traits()
    -- print("Distribute_Random_Traits")
    local done = false
    for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
        local pPlayer = Players[iPlayer]
        if pPlayer~=nil and pPlayer.GrantPolicy==nil then
            print("ERROR RandomTraitsPlus: You are missing a mod dll with the dummy policy fix from whoward?! No GrantPolicy function")
        else
            if pPlayer~=nil and pPlayer:IsEverAlive() then
                local traitsassigned = 0
                local failsafe = 0
                while traitsassigned<num_traits and failsafe<num_traits*25 do -- 50 tries should be enough
                    failsafe = failsafe + 1
                    local randchoice = Game.Rand(#traits,"RandomCivIV_Trait") + 1
                    local straitchoice = traits[randchoice]
                    local iTrait = GameInfoTypes[straitchoice]
                    local assigned = false
                    if iTrait~=nil then
                        if straitchoice~="POLICY_WIDE_X" or not pPlayer:MayNotAnnex() then -- dont give venice this trait, cause it would be a punishment
                            assigned = pPlayer:GrantPolicy(iTrait, true)
                            if assigned then
                                traitsassigned = traitsassigned + 1
                                done = true -- traits were assigned to at least one player, so we consider this a success I guess
                                
                                -- ###############
                                -- give free units
                                -- ###############
                                -- unfortunately in xml freeunits does not work, cause dll code checks for captial.
                                -- and the GameEvents.PlayerAdoptPolicy does not trigger for GrantPolicy obviously...
                                if straitchoice == "POLICY_EXPLORER_X" then
                                    local pCity = pPlayer:GetCapitalCity()
                                    local pPlot = pCity and pCity:Plot() or pPlayer:GetStartingPlot()
                                    if pPlot~=nil then
                                        local sUnitType = GetCivSpecificUnit(pPlayer, "UNITCLASS_SCOUT") -- free scout or upgrade of it
                                        local sUpgradeUnitType = GetUpgradeUnit(pPlayer, sUnitType)
                                        while (sUpgradeUnitType ~= nil) do
                                          sUnitType = sUpgradeUnitType
                                          sUpgradeUnitType = GetUpgradeUnit(pPlayer, sUnitType)
                                        end

                                        local pUnit = pPlayer:InitUnit(GameInfoTypes[sUnitType], pPlot:GetX(), pPlot:GetY(), UNITAI_DEFENSE)
                                        pUnit:JumpToNearestValidPlot()
                                        pUnit:ChangeExperience(10) -- starts with 10 XP
                                        if (pCity ~= nil) then
                                          pUnit:ChangeExperience(pCity:GetProductionExperience(pUnit:GetUnitType()))

                                          if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_HEROIC_EPIC)) then
                                            pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_MORALE, true)
                                          end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    print("giving " .. pPlayer:GetName() .. " " .. straitchoice .. ", success:"..tostring(assigned))
                end
            end
        end
    end
    return done
end

-- reflect the assigned traits in leader names
function UpdateLeaderNames() -- of course this will display wrong icons, if we have the same leader more than once! but I guess tere is no solution for it, so simply dont play with the same leader twice
    -- print("UpdateLeaderNames")
    local localelanguage = "Language_" ..Locale.GetCurrentLanguage().Type;
    local You = Locale.ConvertTextKey("TXT_KEY_YOU")
    local PopUpTitle = Locale.ConvertTextKey("TXT_KEY_LEADER_TRAITS_TITLE_YOU")
    You = string.gsub(You, "%[.-%]", "") -- remove anything with [] to make sure old icons are not there anymore (happens eg. when restarting a game)
    PopUpTitle = string.gsub(PopUpTitle, "%[.-%]", "")
    local tquery = {}
    local iActivePlayer = Game.GetActivePlayer()
    for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
        local pPlayer = Players[iPlayer]
        if pPlayer~=nil and pPlayer:IsEverAlive() then
            local icons = ""
            for traitpolicy, icon in pairs(trait_icons) do
                local pPoliciy = GameInfo.Policies[traitpolicy]
                if pPoliciy~=nil and pPlayer:HasPolicy(pPoliciy.ID) then
                    icons = icons .. icon
                end
            end
            if icons~="" then
                local leaderinfo = GameInfo.Leaders[pPlayer:GetLeaderType()]
                local leadertype = leaderinfo.Type
                local leadername = Locale.ConvertTextKey(leaderinfo.Description)
                
                leadername = string.gsub(leadername, "%[.-%]", "") -- remove anything with [] to make sure old icons are not there anymore (happens eg. when restarting a game)
                
                table.insert(tquery,"UPDATE "..localelanguage.." SET Text = '".. leadername..icons .."' WHERE Tag = 'TXT_KEY_"..leadertype.."'")
                if iPlayer==iActivePlayer then -- not sure if the "you" txt key also should be updated... 
                    table.insert(tquery,"UPDATE "..localelanguage.." SET Text = '".. You..icons .."' WHERE Tag = 'TXT_KEY_YOU'")
                    table.insert(tquery,"UPDATE "..localelanguage.." SET Text = '".. PopUpTitle..icons .."' WHERE Tag = 'TXT_KEY_LEADER_TRAITS_TITLE_YOU'")
                end
            end
        end
    end
    for i, iQuery in pairs(tquery) do
        print ("Changing Leadernames: " .. i .. "/" .. #tquery .. " :" .. tostring(iQuery) );
        for result in DB.Query(iQuery) do
        end
    end
    Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
end


--
-- Helper methods
--
function GetUpgradeUnit(pPlayer, sUnitType)
  -- local sNewUnitClass = GameInfo.Units[sUnitType].GoodyHutUpgradeUnitClass -- dont use goodyhut upgrade, because this can be different (archer for scout, instead of adventurer)
  for row in GameInfo.Unit_ClassUpgrades{UnitType = sUnitType} do	
    local sNewUnitClass = row.UnitClassType
    if (sNewUnitClass ~= nil) then
        local sUpgradeUnitType = GetCivSpecificUnit(pPlayer, sNewUnitClass)
        if (sUpgradeUnitType ~= nil and Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes[GameInfo.Units[sUpgradeUnitType].PrereqTech])) then
            return sUpgradeUnitType
        end
    end
  end

  return nil
end

function GetCivSpecificUnit(pPlayer, sUnitClass)
  local sUnitType = nil
  local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type

  for pOverride in GameInfo.Civilization_UnitClassOverrides{CivilizationType = sCivType, UnitClassType = sUnitClass} do
    sUnitType = pOverride.UnitType
    break
  end

  if (sUnitType == nil) then
    sUnitType = GameInfo.UnitClasses[sUnitClass].DefaultUnit
  end

  return sUnitType
end


local g_SaveData = Modding.OpenSaveData();
-- function OnSequenceGameInitComplete()
	-- print("OnSequenceGameInitComplete")
    -- Events.SequenceGameInitComplete.Remove(OnSequenceGameInitComplete); -- only call this once
    local bInit = g_SaveData.GetValue("CivIVRandomTraits_Distributed");
    if not bInit then
        g_SaveData.SetValue("CivIVRandomTraits_Distributed", Distribute_Random_Traits());
    end
    UpdateLeaderNames() -- update the leader names. this has to be done after every game load, so we dont check bInit for it.
-- end

-- Events.SequenceGameInitComplete.Add( OnSequenceGameInitComplete );