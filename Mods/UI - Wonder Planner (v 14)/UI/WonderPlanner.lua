print("This is the 'UI - Wonder Planner' mod script.")

include("IconSupport")
include("InstanceManager")
include("InfoTooltipInclude")

local g_PlannerIM = InstanceManager:new("WonderPlanner", "Wonder", Controls.PlannerStack)
local g_BuiltIM = InstanceManager:new("WonderPlanner", "Wonder", Controls.BuiltStack)

local g_SortTable = {}
local g_ActiveSort = "needed"
local g_ReverseSort = false

local g_Civs = {}
local g_Wonders = {init=false}
local g_EraLimit = -1

local sDestroyed = Locale.ConvertTextKey("TXT_KEY_WONDERPLANNER_DESTROYED")


function OnSort(sort)
  if (sort == g_ActiveSort) then
    g_ReverseSort = not g_ReverseSort
  else
    g_ReverseSort = false
    g_ActiveSort = sort
  end

  Controls.PlannerStack:SortChildren(SortByValue)
  Controls.BuiltStack:SortChildren(SortByValue)
end
Controls.SortPlannerName:RegisterCallback(Mouse.eLClick, function() OnSort("name") end)
Controls.SortPlannerTech:RegisterCallback(Mouse.eLClick, function() OnSort("tech") end)
Controls.SortPlannerTechsNeeded:RegisterCallback(Mouse.eLClick, function() OnSort("needed") end)
Controls.SortPlannerHappy:RegisterCallback(Mouse.eLClick, function() OnSort("happy") end)
Controls.SortPlannerFreeUnit:RegisterCallback(Mouse.eLClick, function() OnSort("freeunit") end)
Controls.SortPlannerFaith:RegisterCallback(Mouse.eLClick, function() OnSort("faith") end)
Controls.SortPlannerCulture:RegisterCallback(Mouse.eLClick, function() OnSort("culture") end)
Controls.SortPlannerScience:RegisterCallback(Mouse.eLClick, function() OnSort("science") end)
Controls.SortPlannerExpansion:RegisterCallback(Mouse.eLClick, function() OnSort("expansion") end)
Controls.SortPlannerFood:RegisterCallback(Mouse.eLClick, function() OnSort("food") end)
Controls.SortPlannerGold:RegisterCallback(Mouse.eLClick, function() OnSort("gold") end)
Controls.SortPlannerDefense:RegisterCallback(Mouse.eLClick, function() OnSort("defense") end)
Controls.SortPlannerOffense:RegisterCallback(Mouse.eLClick, function() OnSort("offense") end)
Controls.SortPlannerGreatPeople:RegisterCallback(Mouse.eLClick, function() OnSort("greatpeople") end)
Controls.SortPlannerEspionage:RegisterCallback(Mouse.eLClick, function() OnSort("espionage") end)
Controls.SortPlannerTourism:RegisterCallback(Mouse.eLClick, function() OnSort("tourism") end)
Controls.SortBuiltName:RegisterCallback(Mouse.eLClick, function() OnSort("name") end)
Controls.SortBuiltCity:RegisterCallback(Mouse.eLClick, function() OnSort("city") end)
Controls.SortBuiltHappy:RegisterCallback(Mouse.eLClick, function() OnSort("happy") end)
Controls.SortBuiltFreeUnit:RegisterCallback(Mouse.eLClick, function() OnSort("freeunit") end)
Controls.SortBuiltFaith:RegisterCallback(Mouse.eLClick, function() OnSort("faith") end)
Controls.SortBuiltCulture:RegisterCallback(Mouse.eLClick, function() OnSort("culture") end)
Controls.SortBuiltScience:RegisterCallback(Mouse.eLClick, function() OnSort("science") end)
Controls.SortBuiltExpansion:RegisterCallback(Mouse.eLClick, function() OnSort("expansion") end)
Controls.SortBuiltFood:RegisterCallback(Mouse.eLClick, function() OnSort("food") end)
Controls.SortBuiltGold:RegisterCallback(Mouse.eLClick, function() OnSort("gold") end)
Controls.SortBuiltDefense:RegisterCallback(Mouse.eLClick, function() OnSort("defense") end)
Controls.SortBuiltOffense:RegisterCallback(Mouse.eLClick, function() OnSort("offsense") end)
Controls.SortBuiltGreatPeople:RegisterCallback(Mouse.eLClick, function() OnSort("greatpeople") end)
Controls.SortBuiltEspionage:RegisterCallback(Mouse.eLClick, function() OnSort("espionage") end)
Controls.SortBuiltTourism:RegisterCallback(Mouse.eLClick, function() OnSort("tourism") end)

function SortByValue(a, b)
  local entryA = g_SortTable[tostring(a)]
  local entryB = g_SortTable[tostring(b)]

  if (entryA == nil or entryB == nil) then
    return tostring(a) < tostring(b)
  end

  local valueA = entryA[g_ActiveSort]
  local valueB = entryB[g_ActiveSort]

  if (g_ReverseSort) then
    valueA = entryB[g_ActiveSort]
    valueB = entryA[g_ActiveSort]
  end

  if (valueA == valueB) then
    if (entryA.needed ~= nil) then
      valueA = entryA.needed
      valueB = entryB.needed
    else
      valueA = entryA.name
      valueB = entryB.name
    end
  end

  if (valueA == nil or valueB == nil) then
    return tostring(a) < tostring(b)
  end

  return valueA < valueB
end

function UpdateData(iPlayer)
  local pPlayer = Players[iPlayer]
  CivIconHookup(iPlayer, 64, Controls.Icon, Controls.CivIconBG, Controls.CivIconShadow, false, true)
  
  local playerTechs = GetTechs(iPlayer)
  
  g_PlannerIM:ResetInstances()
  g_BuiltIM:ResetInstances()
  g_SortTable = {}

  for iWonder, wonder in pairs(UpdateWonders(g_Wonders)) do
    if (wonder.iTech ~= -1) then
      AddWonder(iPlayer, playerTechs, iWonder, wonder)
    end
  end

  Controls.PlannerStack:SortChildren(SortByValue)
  Controls.PlannerStack:CalculateSize()
  Controls.PlannerScrollPanel:CalculateInternalSize()

  Controls.BuiltStack:SortChildren(SortByValue)
  Controls.BuiltStack:CalculateSize()
  Controls.BuiltScrollPanel:CalculateInternalSize()
end

function AddWonder(iPlayer, playerTechs, iWonder, wonder)
  local instance = (wonder.iPlayer == -1) and g_PlannerIM:GetInstance() or g_BuiltIM:GetInstance()
  wonder.instance = instance

  local sort = {}
  g_SortTable[tostring(instance.Wonder)] = sort

  local pWonder = g_Wonders[iWonder]

  if (IconHookup(pWonder.PortraitIndex, 45, pWonder.IconAtlas, instance.Icon)) then
    instance.Icon:SetHide(false)
    instance.Icon:SetToolTipString(wonder.sName)
  else
    instance.Icon:SetHide(true)
  end

  sort.name = wonder.sName
  instance.Name:SetText(sort.name)
  instance.Name:SetToolTipString(wonder.sToolTip)

  if (wonder.iPlayer == -1) then
    instance.TechsNeeded:SetHide(false)

	local pTech = GameInfo.Technologies[pWonder.PrereqTech]
    if (IconHookup(pTech.PortraitIndex, 45, pTech.IconAtlas, instance.TechIcon)) then
      instance.TechIcon:SetHide(false)
      instance.TechIcon:SetToolTipString(wonder.sTech)
    else
      instance.TechIcon:SetHide(true)
    end

    sort.tech = wonder.sTech
    instance.Tech:SetText(sort.tech)
    instance.Tech:SetToolTipString(wonder.sEra)

    sort.needed = GetNeededTechs(playerTechs, pWonder)

	local bLocked, sReason = IsLocked(pWonder, iPlayer)
	if (bLocked) then
      instance.TechsNeeded:SetText("[ICON_LOCKED]")
      instance.TechsNeeded:SetToolTipString(sReason)
	else
      instance.TechsNeeded:SetText(sort.needed)
      instance.TechsNeeded:SetToolTipString(nil)
	end

    instance.Wonder:SetHide(wonder.iEra > g_EraLimit)
  else
    instance.TechsNeeded:SetHide(true)

      local pCiv = g_Civs[wonder.iPlayer]
      instance.TechIcon:SetToolTipString(wonder.sPlayer)
      instance.TechIcon:SetHide(IconHookup(pCiv.PortraitIndex, 45, pCiv.IconAtlas, instance.TechIcon) == false)

	if (wonder.iPlayer ~= GameDefines.MAX_PLAYERS) then
      sort.city = wonder.sPlayer .. ":" .. wonder.sCity
      instance.Tech:SetText(wonder.sCity)
      instance.Tech:SetToolTipString(wonder.sPlayer)
	else
	  -- The barbarians have it (ie it's been destroyed)
      sort.city = "destroyed:" .. iWonder
      instance.Tech:SetText(sDestroyed)
      instance.Tech:SetToolTipString(sDestroyed)
	end

    instance.Wonder:SetHide(false)
  end

  sort.happy = pWonder.isHappy
  instance.IsHappy:SetHide(sort.happy == 0)
  sort.freeunit = pWonder.isFreeUnit
  instance.IsFreeUnit:SetHide(sort.freeunit == 0)
  sort.defense = pWonder.isDefense
  instance.IsDefense:SetHide(sort.defense == 0)
  sort.offense = pWonder.isOffense
  instance.IsOffense:SetHide(sort.offense == 0)
  sort.expansion = pWonder.isExpansion
  instance.IsExpansion:SetHide(sort.expansion == 0)
  sort.greatpeople = pWonder.isGreatPeople
  instance.IsGreatPeople:SetHide(sort.greatpeople == 0)
  sort.food = pWonder.isFood
  instance.IsFood:SetHide(sort.food == 0)
  sort.gold = pWonder.isGold
  instance.IsGold:SetHide(sort.gold == 0)
  sort.science = pWonder.isScience
  instance.IsScience:SetHide(sort.science == 0)
  sort.culture = pWonder.isCulture
  instance.IsCulture:SetHide(sort.culture == 0)
  sort.faith = pWonder.isFaith
  instance.IsFaith:SetHide(sort.faith == 0)
  sort.espionage = pWonder.isEspionage
  instance.IsEspionage:SetHide(sort.espionage == 0)
  sort.tourism = pWonder.isTourism
  instance.IsTourism:SetHide(sort.tourism == 0)
end

function GetCivs()
  for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local pPlayer = Players[iPlayer]
	if (pPlayer:IsEverAlive()) then
	  local pCiv = GameInfo.Civilizations[pPlayer:GetCivilizationType()]
      g_Civs[iPlayer] = {
	    IconAtlas     = pCiv.IconAtlas,
	    PortraitIndex = pCiv.PortraitIndex
	  }
	end
  end

  local pCiv = GameInfo.Civilizations["CIVILIZATION_BARBARIAN"]
  g_Civs[GameDefines.MAX_PLAYERS] = {
    IconAtlas     = pCiv.IconAtlas,
	PortraitIndex = pCiv.PortraitIndex
  }
end

function GetWonders(wonders)
  print("GetWonders() enter")
  for pWonder in GameInfo.Buildings() do
    if (IsWonder(pWonder)) then
      local iWonder = pWonder.ID
      wonders[iWonder] = {
        iWonder  = iWonder, 
        iClass   = GameInfoTypes[pWonder.BuildingClass], 
        sName    = Locale.ConvertTextKey(pWonder.Description),
        sToolTip = GetHelpTextForBuilding(iWonder, true, false, true),
        iTech    = GetTech(pWonder), 
        sTech    = Locale.ConvertTextKey(GameInfo.Technologies[pWonder.PrereqTech].Description),
        iEra     = GameInfoTypes[GameInfo.Technologies[pWonder.PrereqTech].Era],
        sEra     = Locale.ConvertTextKey(GameInfo.Eras[GameInfo.Technologies[pWonder.PrereqTech].Era].Description),

		prereqTechs = GetPrereqTechs(pWonder.PrereqTech),

		IconAtlas     = pWonder.IconAtlas,
		PortraitIndex = pWonder.PortraitIndex,
		PrereqTech    = pWonder.PrereqTech,

	    BuildingClass = GameInfoTypes[pWonder.BuildingClass],
        PolicyBranch  = pWonder.PolicyBranchType and GameInfoTypes[pWonder.PolicyBranchType],

        -- We use -1 for true and 0 for false as it makes sorting easier
		isHappy       = (IsHappy(pWonder) and -1 or 0),
		isFreeUnit    = (IsFreeUnit(pWonder) and -1 or 0),
		isDefense     = (IsDefense(pWonder) and -1 or 0),
		isOffense     = (IsOffense(pWonder) and -1 or 0),
		isExpansion   = (IsExpansion(pWonder) and -1 or 0),
		isGreatpeople = (IsGreatPeople(pWonder) and -1 or 0),
		isFood        = (IsFood(pWonder) and -1 or 0),
		isGold        = (IsGold(pWonder) and -1 or 0),
		isScience     = (IsScience(pWonder) and -1 or 0),
		isCulture     = (IsCulture(pWonder) and -1 or 0),
		isFaith       = (IsFaith(pWonder) and -1 or 0),
		isEspionage   = (IsEspionage(pWonder) and -1 or 0),
		isTourism     = (IsTourism(pWonder) and -1 or 0),

		iPlayer = -1
      }
    end
  end
  print("GetWonders() exit")
end

function UpdateWonders(wonders)
  print("UpdateWonders() enter")
  if (wonders.init == false) then
    wonders.init = nil
    GetWonders(wonders)
  else
    for iWonder, wonder in pairs(wonders) do
      wonder.iPlayer = -1
    end
  end

  for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
    local pPlayer = Players[iPlayer]

    if (pPlayer:IsAlive()) then
      local sPlayer = pPlayer:GetName()

      for pCity in pPlayer:Cities() do
        if (pCity:GetNumWorldWonders() > 0) then
          for iWonder, wonder in pairs(wonders) do
            if (pCity:IsHasBuilding(iWonder)) then
              wonder.iPlayer = iPlayer
              wonder.sPlayer = sPlayer
              wonder.iCity = pCity:GetID()
              wonder.sCity = pCity:GetName()
            end
          end
        end	
      end
    end
  end

  for iWonder, wonder in pairs(wonders) do
    if (wonder.iPlayer == -1 and Game.IsBuildingClassMaxedOut(wonder.iClass)) then
      -- The wonder has been destroyed, give it to the barbarians!
      wonder.iPlayer = GameDefines.MAX_PLAYERS
	  wonder.sPlayer = sDestroyed
    end
  end

  print("UpdateWonders() exit")
  return wonders
end


function IsWonder(pBuilding)
  if (GameInfo.BuildingClasses[pBuilding.BuildingClass].MaxGlobalInstances == 1) then
    for row in GameInfo.LeagueProjectRewards{Building=pBuilding.Type} do
      return false
	end

    return true
  end

  return false
end

function IsHappy(pBuilding)
  for row in GameInfo.Building_BuildingClassHappiness{BuildingType=pBuilding.Type} do
    if (row.Happiness > 0) then
      return true
    end
  end

  return (pBuilding.Happiness ~= 0 or pBuilding.UnmoddedHappiness ~= 0 or pBuilding.UnhappinessModifier ~= 0 or pBuilding.HappinessPerXPolicies ~= 0 or pBuilding.HappinessPerCity ~= 0)
end

function IsFreeUnit(pBuilding)
  for row in GameInfo.Building_FreeUnits{BuildingType=pBuilding.Type} do
    if (row.NumUnits > 0) then
      return true
    end
  end

  return false
end

function IsDefense(pBuilding)
  return (pBuilding.BorderObstacle == true or pBuilding.GlobalDefenseMod ~= 0 or pBuilding.Defense ~= 0 or pBuilding.UnitUpgradeCostMod ~= 0 or (pBuilding.ExtraCityHitPoints ~= nil and pBuilding.ExtraCityHitPoints ~= 0))
end

function IsOffense(pBuilding)
  return (pBuilding.FreePromotion ~= nil or pBuilding.TrainedFreePromotion ~= nil or IsCombatBonus(pBuilding))
end

function IsCulture(pBuilding)
  return (pBuilding.GlobalCultureRateModifier ~= 0 or pBuilding.CultureRateModifier ~= 0 or pBuilding.FreePolicies ~= 0 or pBuilding.PolicyCostModifier ~= 0 or IsYield(pBuilding, "YIELD_CULTURE", 1))
end

function IsFaith(pBuilding)
  return (IsYield(pBuilding, "YIELD_FAITH") or pBuilding.ExtraMissionarySpreads ~= 0)
end

function IsFood(pBuilding)
  return (IsYield(pBuilding, "YIELD_FOOD"))
end

function IsGold(pBuilding)
  return ((pBuilding.CityConnectionTradeRouteModifier ~= 0) or ((pBuilding.TradeRouteRecipientBonus ~= 0 or pBuilding.NumTradeRouteBonus ~= 0)) or pBuilding.GreatPersonExpendGold ~= 0 or pBuilding.GoldenAgeModifier ~= 0 or pBuilding.GoldenAge == true or IsYield(pBuilding, "YIELD_GOLD") or IsHurry(pBuilding, "HURRY_GOLD"))
end

function IsScience(pBuilding)
  return (pBuilding.FreeTechs ~= 0 or (pBuilding.GlobalSpaceProductionModifier ~= nil and pBuilding.GlobalSpaceProductionModifier ~= 0) or pBuilding.MedianTechPercentChange ~= 0)
end

function IsExpansion(pBuilding)
  return (pBuilding.WorkerSpeedModifier ~= 0 or pBuilding.GlobalPlotCultureCostModifier ~= 0 or pBuilding.GlobalPlotBuyCostModifier ~= 0 or pBuilding.GlobalPopulationChange ~= 0)
end

function IsGreatPeople(pBuilding)
  return (pBuilding.FreeGreatPeople ~= 0 or pBuilding.GlobalGreatPeopleRateModifier ~= 0 or pBuilding.GreatPeopleRateChange > 1)
end

function IsEspionage(pBuilding)
  return (pBuilding.Espionage == true or pBuilding.AffectSpiesNow == true or pBuilding.SpyRankChange == true or pBuilding.InstantSpyRankChange == true)
end

function IsTourism(pBuilding)
  return (pBuilding.GreatWorkCount ~= 0 or pBuilding.TechEnhancedTourism ~= 0)
end

function IsYield(pBuilding, sYieldType, iLimit)
  iLimit = iLimit or 0
  local iLimitPercent = iLimit * 10

  for row in GameInfo.Building_YieldChanges{BuildingType=pBuilding.Type, YieldType=sYieldType} do
    if (row.Yield > iLimit) then return true end
  end

  for row in GameInfo.Building_YieldModifiers{BuildingType=pBuilding.Type, YieldType=sYieldType} do
    if (row.Yield > iLimitPercent) then return true end
  end

  for row in GameInfo.Building_BuildingClassYieldChanges{BuildingType=pBuilding.Type, YieldType=sYieldType} do
    if (row.YieldChange > 0) then return true end
  end

  for row in GameInfo.Building_GlobalYieldModifiers{BuildingType=pBuilding.Type, YieldType=sYieldType} do
    if (row.Yield > iLimit) then return true end
  end

  for row in GameInfo.Building_TechEnhancedYieldChanges{BuildingType=pBuilding.Type, YieldType=sYieldType} do
    if (row.Yield > iLimit) then return true end
  end

  for row in GameInfo.Building_SpecialistYieldChanges{BuildingType=pBuilding.Type, YieldType=sYieldType} do
    if (row.Yield > iLimit) then return true end
  end

  return false
end

function IsHurry(pBuilding, sHurryType, iLimitPercent)
  iLimit = iLimit or -5

  for row in GameInfo.Building_HurryModifiers{BuildingType=pBuilding.Type, HurryType=sHurryType} do
    if (row.HurryCostModifier < iLimitPercent) then return true end
  end

  return false
end

function IsCombatBonus(pBuilding, iLimit)
  iLimit = iLimit or 0

  for row in GameInfo.Building_UnitCombatProductionModifiers{BuildingType=pBuilding.Type} do
    if (row.Modifier > iLimit) then return true end
  end

  for row in GameInfo.Building_UnitCombatFreeExperiences{BuildingType=pBuilding.Type} do
    if (row.Experience > iLimit) then return true end
  end

  return false
end

function IsLocked(pBuilding, iPlayer)
  local bLocked = false
  local sReason = nil

  if (Game.GetBuildingClassCreatedCount(pBuilding.BuildingClass) > 0) then
    bLocked = true
    sReason = Locale.ConvertTextKey("TXT_KEY_WONDERPLANNER_LOCKED_DESTROYED")
  else
    if (pBuilding.PolicyBranch) then
      if (not Players[iPlayer]:IsPolicyBranchUnlocked(pBuilding.PolicyBranch)) then
        bLocked = true
        sReason = Locale.ConvertTextKey("TXT_KEY_WONDERPLANNER_LOCKED_MISSING_POLICY", GameInfo.PolicyBranchTypes[pBuilding.PolicyBranch].Description)
	  end
	end
  end

  return bLocked, sReason
end


function GetTech(pBuilding)
  local iMaxStartEra = (pBuilding.MaxStartEra == nil) and #GameInfo.Eras or GameInfoTypes[pBuilding.MaxStartEra]

  return (PreGame.GetEra() > iMaxStartEra) and -1 or GameInfoTypes[pBuilding.PrereqTech]
end

function GetPrereqTechs(sTech, techs)
  if (techs == nil) then
    techs = {}
	techs[sTech] = 1

	GetPrereqTechs(sTech, techs)
  else
    for row in GameInfo.Technology_PrereqTechs{TechType=sTech} do
      techs[row.PrereqTech] = 1

      GetPrereqTechs(row.PrereqTech, techs)
    end
  end
  
  return techs
end

function GetTechs(iPlayer)
  local techs = {}
  local pTeam = Teams[Players[iPlayer]:GetTeam()]

  for pTech in GameInfo.Technologies() do
    if (pTeam:IsHasTech(pTech.ID)) then
      techs[pTech.ID] = 1
      techs[pTech.Type] = 1
    end
  end

  return techs
end

function GetNeededTechs(playerTechs, pWonder)
  local neededTechs = 0

  for sTech, _ in pairs(pWonder.prereqTechs) do
    if (playerTechs[sTech] ~= 1) then
	  neededTechs = neededTechs + 1
    end
  end

  return neededTechs
end


function OnEraSelected(iEra)
  if (g_EraLimit ~= iEra) then
    g_EraLimit = iEra

    Controls.EraMenu:GetButton():LocalizeAndSetText(GameInfo.Eras[g_EraLimit].Description)

    for iWonder, wonder in pairs(g_Wonders) do
      if (wonder.iPlayer == -1) then
        wonder.instance.Wonder:SetHide(wonder.iEra > g_EraLimit)
      end
    end

    Controls.PlannerStack:CalculateSize()
    Controls.PlannerScrollPanel:CalculateInternalSize()
  end
end

function UpdateEraList(iPlayer)
  local pPlayer = Players[iPlayer]
  local iTeam = pPlayer:GetTeam()

  Controls.EraMenu:ClearEntries()

	for iEra = pPlayer:GetCurrentEra(), #GameInfo.Eras-1, 1 do
    local pEra = GameInfo.Eras[iEra]
   	local era = {}
    Controls.EraMenu:BuildEntry("InstanceOne", era)
	
    era.Button:SetVoid1(iEra)
    era.Button:SetText(Locale.ConvertTextKey(pEra.Description))
  end

  Controls.EraMenu:GetButton():LocalizeAndSetText(GameInfo.Eras[g_EraLimit].Description)

  Controls.EraMenu:CalculateInternals()
  Controls.EraMenu:RegisterSelectionCallback(OnEraSelected)
end


function OnClose()
  ContextPtr:SetHide(true)
end
Controls.CloseButton:RegisterCallback(Mouse.eLClick, OnClose)

function InputHandler(uiMsg, wParam, lParam)
  if (uiMsg == KeyEvents.KeyDown) then
    if (wParam == Keys.VK_ESCAPE) then
      OnClose()
      return true
    end
  end
end
ContextPtr:SetInputHandler(InputHandler)

function OnWondersUpdate()
  if (not ContextPtr:IsHidden()) then
    local iPlayer = Game.GetActivePlayer()

    if (g_EraLimit == -1) then
      g_EraLimit = math.min(#GameInfo.Eras-1, Players[iPlayer]:GetCurrentEra()+2)
    end

    UpdateEraList(iPlayer)
    UpdateData(iPlayer)
  end
end
LuaEvents.WonderPlannerDisplay.Add(function() ContextPtr:SetHide(false) end)

function ShowHideHandler(bIsHide, bInitState)
  if (not bInitState and not bIsHide) then
    OnWondersUpdate()
  end
end
ContextPtr:SetShowHideHandler(ShowHideHandler)


function OnShowPlanner()
  Controls.PlannerPanel:SetHide(false)
  Controls.BuiltPanel:SetHide(true)

  Controls.PlannerHighlight:SetHide(false)
  Controls.BuiltHighlight:SetHide(true)
  
  Controls.EraLimit:SetHide(false)
end
Controls.PlannerButton:RegisterCallback(Mouse.eLClick, OnShowPlanner)

function OnShowBuilt()
  Controls.BuiltPanel:SetHide(false)
  Controls.PlannerPanel:SetHide(true)

  Controls.BuiltHighlight:SetHide(false)
  Controls.PlannerHighlight:SetHide(true)
  
  Controls.EraLimit:SetHide(true)
end
Controls.BuiltButton:RegisterCallback(Mouse.eLClick, OnShowBuilt)

GetCivs();
OnShowPlanner()
ContextPtr:SetHide(true)


--
-- DiploCorner addin methods
--
function OnDiploCornerPopup()
  ContextPtr:SetHide(false)
end

function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
  table.insert(additionalEntries, {text=Locale.ConvertTextKey("TXT_KEY_WONDERPLANNER_DIPLO_CORNER_HOOK"), call=OnDiploCornerPopup, art="EUI_DC45_WonderPlanner.dds"})
end
LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()
