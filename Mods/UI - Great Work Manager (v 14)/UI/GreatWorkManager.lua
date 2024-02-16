print("This is the 'UI - Great Work Manager' mod script.")

include("IconSupport")
include("InstanceManager")

local bIsRegistered = false

local gCivIM = InstanceManager:new("CivilizationInstance", "CivilizationRoot", Controls.CivilizationsStack)
local gCityIM = InstanceManager:new("CityInstance", "CityRoot", Controls.CitiesStack)
local gPlaceIM = InstanceManager:new("PlaceWorkInstance", "PlaceWorkRoot", Controls.PlaceWorksStack)
local gMySwapIM = InstanceManager:new("MySwapWorkInstance", "SwapWorkRoot", Controls.MySwapWorksStack)
local gTheirSwapIM = InstanceManager:new("TheirSwapWorkInstance", "SwapWorkRoot", Controls.TheirSwapWorksStack)

local gTabArtifact      = GameInfo.GreatWorkClasses.GREAT_WORK_ARTIFACT.ID
local gTabArt           = GameInfo.GreatWorkClasses.GREAT_WORK_ART.ID
local gTabArtifactOrArt = 100
local gTabLiterature    = GameInfo.GreatWorkClasses.GREAT_WORK_LITERATURE.ID
local gTabMusic         = GameInfo.GreatWorkClasses.GREAT_WORK_MUSIC.ID

local gTabSelected = gTabArtifact

local gSortTable = {}
local gActiveSort = "status"
local gReverseSort = false

local gWorksBuildings = {}
local gWorksLocations = {}
local gSelectedWorks = nil

local yieldColours = {
  NO_YIELD         = {x=0.5,  y=0.5,  z=0.5,  w=1},
  YIELD_FOOD       = {x=0.99, y=0.58, z=0.16, w=1},
  YIELD_PRODUCTION = {x=0.44, y=0.56, z=0.74, w=1},
  YIELD_GOLD       = {x=1,    y=0.94, z=0.08, w=1},
  YIELD_SCIENCE    = {x=0,    y=1,    z=1,    w=1},
  YIELD_CULTURE    = {x=1,    y=0,    z=1,    w=1},
  YIELD_FAITH      = {x=1,    y=1,    z=1,    w=1}
}

--------------------
--------------------

function OnSort(sort)
  if (sort == gActiveSort) then
    gReverseSort = not gReverseSort
  else
    gReverseSort = not (sort == "name" or sort == "status" or sort == "buildTurns")
    gActiveSort = sort
  end

  Controls.CitiesStack:SortChildren(SortByValue)
end
Controls.CityHeader:RegisterCallback(Mouse.eLClick, function() OnSort("name") end)
Controls.CityTypeHeader:RegisterCallback(Mouse.eLClick, function() OnSort("status") end)
Controls.CityCultureHeader:RegisterCallback(Mouse.eLClick, function() OnSort("culture") end)
Controls.CityTourismHeader:RegisterCallback(Mouse.eLClick, function() OnSort("tourism") end)

function SortByValue(a, b)
  local entryA = gSortTable[tostring(a)]
  local entryB = gSortTable[tostring(b)]

  if (entryA == nil or entryB == nil) then
    return tostring(a) < tostring(b)
  end

  local valueA = entryA[gActiveSort]
  local valueB = entryB[gActiveSort]

  if (valueA == valueB) then
    valueA = entryA.name
    valueB = entryB.name
  elseif (gReverseSort) then
    valueA = entryB[gActiveSort]
    valueB = entryA[gActiveSort]
  end

  if (valueA == nil or valueB == nil) then
    return tostring(a) < tostring(b)
  end

  return valueA < valueB
end

--------------------
--------------------
function IsTabArtifact(tab)
  return (tab == gTabArtifact)
end

function IsTabArt(tab)
  return (tab == gTabArt)
end

function IsTabArtifactOrArt(tab)
  return (tab == gTabArtifactOrArt)
end

function IsTabLiterature(tab)
  return (tab == gTabLiterature)
end

function IsTabMusic(tab)
  return (tab == gTabMusic)
end

function UpdateDisplay(tab)
  gTabSelected = tab or gTabSelected
  tab = gTabSelected

  Controls.TabButtonArtifactHighlight:SetHide(not IsTabArtifact(tab))
  Controls.TabButtonArtHighlight:SetHide(not IsTabArt(tab))
  Controls.TabButtonArtifactOrArtHighlight:SetHide(not IsTabArtifactOrArt(tab))
  Controls.TabButtonLiteratureHighlight:SetHide(not IsTabLiterature(tab))
  Controls.TabButtonMusicHighlight:SetHide(not IsTabMusic(tab))

  ClearSelection()

  local pPlayer = Players[Game.GetActivePlayer()]
  UpdateCivilizations(tab, pPlayer)
  UpdateCities(tab, pPlayer)
end
Events.SerialEventCityInfoDirty.Add(UpdateDisplay)

function UpdateCivilizations(tab, pPlayer)
  gCivIM:ResetInstances()

  local locations = GetGreatWorkLocations(tab, pPlayer)
  local works = GetGreatWorksByCivByEra(tab, pPlayer)
  local swaps = GetSwapsiesByCivByEra(tab, pPlayer)

  local tabs = {}
  if (IsTabArtifactOrArt(tab)) then
    tabs[gTabArtifact] = GetGreatWorksByCivByEra(gTabArtifact, pPlayer)
    tabs[gTabArt] = GetGreatWorksByCivByEra(gTabArt, pPlayer)
  else
    tabs[tab] = works
  end
  
  -- All civs, including the barbarians
  for iCiv=0, GameDefines.MAX_CIV_PLAYERS, 1 do
    local pCiv = Players[iCiv]

    if (pCiv:IsEverAlive() and (works[iCiv] or swaps[iCiv])) then
      local controlTable = gCivIM:GetInstance()

      if (controlTable.ErasIM == nil) then
        controlTable.ErasIM = InstanceManager:new("EraInstance", "EraRoot", controlTable.ErasStack)
      else
        controlTable.ErasIM:ResetInstances()
      end

      CivIconHookup(iCiv, 32, controlTable.CivSymbol, controlTable.CivIconBG, controlTable.CivIconShadow, false, true)
      controlTable.Civ:LocalizeAndSetText(pCiv:GetCivilizationAdjectiveKey())

      for iEra=0, 7, 1 do
        local eraTable = controlTable.ErasIM:GetInstance()

        eraTable.EraButton:SetHide(true)
        eraTable.DigButton:SetHide(true)
        eraTable.DigButton:ClearCallback(Mouse.eLClick)
        eraTable.DigBG:SetHide(true)
        eraTable.ArtButton:SetHide(true)
        eraTable.ArtButton:ClearCallback(Mouse.eLClick)
        eraTable.ArtBG:SetHide(true)
        eraTable.LitButton:SetHide(true)
        eraTable.MusButton:SetHide(true)
        eraTable.SwapButton:SetHide(true)

        if (works[iCiv] and works[iCiv][iEra]) then
          eraTable.EraButton:SetHide(false)

          for activeTab, activeWorks in pairs(tabs) do
            if (activeWorks[iCiv] and activeWorks[iCiv][iEra]) then
              local bAllBonuses = true

              local sTip = ""
              local sPrefix = ""
              for _,iWork in ipairs(activeWorks[iCiv][iEra]) do
                local iBonus = Game.GetGreatWorkCurrentThemingBonus(iWork)
                bAllBonuses = bAllBonuses and (iBonus > 0)

                if (iBonus > 0) then
                  sTip = sTip .. sPrefix .. "[ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_WORK_BONUS", Game.GetGreatWorkName(iWork), iBonus, (locations[iWork] or ""))
                else
                  sTip = sTip .. sPrefix .. "[ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_WORK", Game.GetGreatWorkName(iWork), iBonus, (locations[iWork] or ""))
                end
                sPrefix = "[NEWLINE]"
              end

              local sText = #activeWorks[iCiv][iEra]
              if (bAllBonuses) then
                sText = "[COLOR_POSITIVE_TEXT]" .. sText .. "[ENDCOLOR]"
              end

              sTip = sTip .. "[NEWLINE][NEWLINE]" .. Locale.Lookup("TXT_KEY_GW_MANAGER_SELECT_TT")

              if (IsTabArtifact(activeTab)) then
                eraTable.DigButton:SetHide(false)
                eraTable.DigBG:SetHide(false)
                eraTable.DigCount:SetText(sText)
                eraTable.DigCount:SetToolTipString(sTip)
                eraTable.DigButton:RegisterCallback(Mouse.eLClick, function () OnSelectEra(activeTab, iEra, iCiv) end)

                if (IsTabArtifactOrArt(tab)) then
                  eraTable.ArtButton:SetHide(false)
                end
              elseif (IsTabArt(activeTab)) then
                eraTable.ArtButton:SetHide(false)
                eraTable.ArtBG:SetHide(false)
                eraTable.ArtCount:SetText(sText)
                eraTable.ArtCount:SetToolTipString(sTip)
                eraTable.ArtButton:RegisterCallback(Mouse.eLClick, function () OnSelectEra(activeTab, iEra, iCiv) end)

                if (IsTabArtifactOrArt(tab)) then
                  eraTable.DigButton:SetHide(false)
                end
              elseif (IsTabLiterature(activeTab)) then
                eraTable.LitButton:SetHide(false)
                eraTable.LitCount:SetText(sText)
                eraTable.LitCount:SetToolTipString(sTip)
                eraTable.LitButton:RegisterCallback(Mouse.eLClick, function () OnSelectEra(activeTab, iEra, iCiv) end)
              elseif (IsTabMusic(activeTab)) then
                eraTable.MusButton:SetHide(false)
                eraTable.MusCount:SetText(sText)
                eraTable.MusCount:SetToolTipString(sTip)
                eraTable.MusButton:RegisterCallback(Mouse.eLClick, function () OnSelectEra(activeTab, iEra, iCiv) end)
              end
            end
          end
        end

        eraTable.CountStack:CalculateSize()
        eraTable.CountStack:ReprocessAnchoring()

        if (swaps[iCiv] and swaps[iCiv][iEra]) then
          local sTip = ""
          local sPrefix = ""
          for _,iSwap in ipairs(swaps[iCiv][iEra]) do
            sTip = sTip .. sPrefix .. "[ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_SWAP", Game.GetGreatWorkName(iSwap), Players[Game.GetGreatWorkController(iSwap)]:GetCivilizationShortDescriptionKey())
            sPrefix = "[NEWLINE]"
          end

          eraTable.Swap:SetText("[COLOR_YELLOW]" .. #swaps[iCiv][iEra] .. "[ENDCOLOR]")
          eraTable.SwapButton:SetToolTipCallback(function() ShowSwap(sTip) end)

          eraTable.SwapButton:SetHide(false)
          eraTable.SwapButton:SetVoid1(iCiv)
          eraTable.SwapButton:SetVoid2(iEra)
          eraTable.SwapButton:RegisterCallback(Mouse.eLClick, OnSelectSwap)
        end
      end
    end
  end

  Controls.CivilizationsStack:CalculateSize()
  Controls.CivilizationsStack:ReprocessAnchoring()
  Controls.CivilizationsScroll:CalculateInternalSize()
end

function UpdateCities(tab, pPlayer)
  gSortTable = {}
  gCityIM:ResetInstances()

  for pCity in pPlayer:Cities() do
    local buildings = GetWorksBuildings(tab, pCity)

    if (#buildings > 0) then
      local controlTable = gCityIM:GetInstance()
      local sort = {name=pCity:GetName()}
      gSortTable[tostring(controlTable.CityRoot)] = sort

      if (controlTable.BuildingsIM == nil) then
        controlTable.BuildingsIM = InstanceManager:new("BuildingInstance", "BuildingRoot", controlTable.BuildingsStack)
      else
        controlTable.BuildingsIM:ResetInstances()
      end

      controlTable.City:SetText(pCity:GetName())
      local sStatus = ""
      if (pCity:IsRazing()) then
        sStatus = "[ICON_RAZING]"
        sort.status = 6
      elseif (pCity:IsResistance()) then
        sStatus = "[ICON_RESISTANCE]"
        sort.status = 5
      elseif (pCity:IsPuppet()) then
        sStatus = "[ICON_PUPPET]"
        sort.status = 4
      elseif (pCity:IsOccupied() and not pCity:IsNoOccupiedUnhappiness()) then
        sStatus = "[ICON_OCCUPIED]"
        sort.status = 3
      elseif (pCity:IsCapital()) then
        sStatus = "[ICON_CAPITAL]"
        sort.status = 1
      else
        sort.status = 2
      end
      controlTable.CityStatus:SetText(sStatus)

      local iCultureModifier = GetCultureModifier(pCity)
      sort.culture = iCultureModifier
      if (iCultureModifier > 0) then
          controlTable.CityCulture:SetHide(false)
          controlTable.CityCulture:SetText(string.format("[COLOR:255:0:255:255]+%i%%[ENDCOLOR]", iCultureModifier))
      elseif (iCultureModifier < 0) then
          controlTable.CityCulture:SetHide(false)
          controlTable.CityCulture:SetText(string.format("[COLOR:255:0:0:255]%i%%[ENDCOLOR]", iCultureModifier))
      else
          controlTable.CityCulture:SetHide(true)
      end

      local iTourismModifier = GetTourismModifier(pCity)
      sort.tourism = iTourismModifier
      if (iTourismModifier > 0) then
          controlTable.CityTourism:SetHide(false)
          controlTable.CityTourism:SetText(string.format("[COLOR:255:235:0:255]+%i%%[ENDCOLOR]", iTourismModifier))
      elseif (iTourismModifier < 0) then
          controlTable.CityTourism:SetHide(false)
          controlTable.CityTourism:SetText(string.format("[COLOR:255:0:0:255]%i%%[ENDCOLOR]", iTourismModifier))
      else
          controlTable.CityTourism:SetHide(true)
      end

      for _,iBuilding in ipairs(buildings) do
        local pBuilding = GameInfo.Buildings[iBuilding]
        local buildingTable = controlTable.BuildingsIM:GetInstance()

        IconHookup(pBuilding.PortraitIndex, 45, pBuilding.IconAtlas, buildingTable.BuildingIcon)

        local iAvailableSlots = pBuilding.GreatWorkCount
        local iFilledSlots = 0

        for iSlot = 0, iAvailableSlots-1, 1 do
          local iWork = pCity:GetBuildingGreatWork(GameInfoTypes[pBuilding.BuildingClass], iSlot)

          if (iWork ~= -1) then
            iFilledSlots = iFilledSlots + 1
          end
        end

        local slotColour = yieldColours['YIELD_CULTURE']
        local bYieldTypes = (Game.IsCustomModOption and Game.IsCustomModOption("GLOBAL_GREATWORK_YIELDTYPES"))
		if (bYieldTypes) then
          slotColour = yieldColours[pBuilding.GreatWorkYieldType or 'YIELD_CULTURE'] or yieldColours['NO_YIELD']
		end
        slotColour.w = 0.25
        buildingTable.SlotBarHolder:SetColor(slotColour)
        slotColour.w = 1
        buildingTable.SlotBar:SetFGColor(slotColour)
        buildingTable.SlotBar:SetPercent(iFilledSlots/iAvailableSlots)

        if (pBuilding.GreatWorkCount > 1 and pBuilding.ThemingBonusHelp) then
          buildingTable.BuildingBonus:SetHide(false)
          buildingTable.BuildingBonus:SetToolTipString(Locale.Lookup(pBuilding.ThemingBonusHelp))

          local iBonus = pCity:GetThemingBonus(GameInfoTypes[pBuilding.BuildingClass])
          if (iBonus > 0) then
            buildingTable.BuildingBonus:SetText(string.format("+%i", iBonus))
          else
            buildingTable.BuildingBonus:SetText(string.format("[COLOR_WARNING_TEXT]+%i[ENDCOLOR]", iBonus))
          end

          buildingTable.BuildingBonus:SetVoids(pCity:GetID(), iBuilding)
          buildingTable.BuildingBonus:RegisterCallback(Mouse.eLClick, OnSelectOrPlace)
        else
          buildingTable.BuildingBonus:SetHide(true)
        end

        buildingTable.BuildingButton:SetVoids(pCity:GetID(), iBuilding)
        buildingTable.BuildingButton:RegisterCallback(Mouse.eLClick, OnSelectOrPlace)
        buildingTable.BuildingButton:SetToolTipCallback(ShowPlacement)
      end

      controlTable.BuildingsStack:CalculateSize()
      controlTable.BuildingsStack:ReprocessAnchoring()
    end
  end

  Controls.CitiesStack:SortChildren(SortByValue)
  Controls.CitiesStack:CalculateSize()
  Controls.CitiesStack:ReprocessAnchoring()
  Controls.CitiesScroll:CalculateInternalSize()
end

function IsSelectedType(tab, iWork)
  local iType = GameInfo.GreatWorkClasses[Game.GetGreatWorkClass(iWork)].ID

  if (tab == gTabArtifactOrArt) then
    return (iType == gTabArtifact or iType == gTabArt)
  end

  return (iType == tab)
end

function GetGreatWorks(tab, pPlayer)
  if (tab == gTabArtifactOrArt) then
    local works = pPlayer:GetGreatWorks(gTabArtifact)

    for _,iWork in ipairs(pPlayer:GetGreatWorks(gTabArt)) do
      table.insert(works, iWork)
    end

    return works
  end

  return pPlayer:GetGreatWorks(tab)
end

function GetGreatWorksByCivByEra(tab, pPlayer)
  local works = {}

  for _,work in ipairs(GetGreatWorks(tab, pPlayer)) do
    local iCiv = work.Creator
    local iEra = work.Era

    if (works[iCiv] == nil) then
      works[iCiv] = {}
    end

    if (works[iCiv][iEra] == nil) then
      works[iCiv][iEra] = {}
    end

    table.insert(works[iCiv][iEra], work.Index)
  end

  return works
end

function GetSwapsiesByCivByEra(tab, pPlayer)
  -- print(string.format("GetSwapsiesByCivByEra(%d, %d)", tab, pPlayer:GetID()))
  local works = {}

  for _,work in ipairs(pPlayer:GetOthersGreatWorks()) do
    local iCiv = -1
    local iEra, iIndex

    if (IsTabLiterature(tab)) then
      iCiv = work.WritingCreator
      iEra = work.WritingEra
      iIndex = work.WritingIndex
    elseif (IsTabMusic(tab)) then
      iCiv = work.MusicCreator
      iEra = work.MusicEra
      iIndex = work.MusicIndex
    elseif (IsTabArt(tab)) then
      iCiv = work.ArtCreator
      iEra = work.ArtEra
      iIndex = work.ArtIndex
    elseif (IsTabArtifact(tab)) then
      iCiv = work.ArtifactCreator
      iEra = work.ArtifactEra
      iIndex = work.ArtifactIndex
--    else
--      if (work.ArtifactCreator ~= -1) then
--        iCiv = work.ArtifactCreator
--        iEra = work.ArtifactEra
--        iIndex = work.ArtifactIndex
--      else
--        iCiv = work.ArtCreator
--        iEra = work.ArtEra
--        iIndex = work.ArtIndex
--      end
    end

    if (iCiv ~= -1) then
      if (works[iCiv] == nil) then
        works[iCiv] = {}
      end

      if (works[iCiv][iEra] == nil) then
        works[iCiv][iEra] = {}
      end

      -- print(string.format("  adding work %i for civ %i in era %i", iIndex, iCiv, iEra))
      table.insert(works[iCiv][iEra], iIndex)
    end
  end

  return works
end

function GetGreatWorkLocations(tab, pPlayer)
  local locations = {}
  gWorksLocations = {}

  for pCity in pPlayer:Cities() do
    local buildings = GetWorksBuildings(tab, pCity)

    for _,iBuilding in ipairs(buildings) do
      local pBuilding = GameInfo.Buildings[iBuilding]

      for iSlot = 0, pBuilding.GreatWorkCount-1, 1 do
        local iBuildingClass = GameInfoTypes[pBuilding.BuildingClass]
        local iWork = pCity:GetBuildingGreatWork(iBuildingClass, iSlot)

        if (iWork ~= -1) then
          locations[iWork] = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_IN_LOCATION", pBuilding.Description, pCity:GetName())

          gWorksLocations[iWork] = {City=pCity:GetID(), Building=iBuilding, BuildingClass=iBuildingClass, Slot=iSlot}
        end
      end
    end
  end

  return locations
end

function GetGreatWorkLocation(iWork)
  return gWorksLocations[iWork].City, gWorksLocations[iWork].BuildingClass, gWorksLocations[iWork].Building, gWorksLocations[iWork].Slot
end

function GetCultureModifier(pCity)
  if (pCity:IsRazing() or pCity:IsResistance()) then
    return -100
  end

  local iModifier = 100 + pCity:GetCultureRateModifier()

  if (pCity:GetNumWorldWonders() > 0) then
    iModifier = iModifier * (100 + Players[pCity:GetOwner()]:GetCultureWonderMultiplier())
  else
    iModifier = iModifier * 100
  end

  if (pCity:IsPuppet()) then
    iModifier = iModifier * (100 + GameDefines.PUPPET_CULTURE_MODIFIER)
  else
    iModifier = iModifier * 100
  end

  return math.floor(iModifier / 10000 - 100)
end

function GetTourismModifier(pCity)
  if (pCity:IsRazing() or pCity:IsResistance()) then
    return -100
  end

  if (pCity.GetTourismRateModifier) then
    return pCity:GetTourismRateModifier()
  end

  return 0
end

function GetWorksBuildings(tab, pCity)
  local buildings = {}

  for _,iBuilding in ipairs(gWorksBuildings[tab]) do
    if (pCity:IsHasBuilding(iBuilding)) then
      table.insert(buildings, iBuilding)
    end
  end

  return buildings
end

function CacheWorksBuildings()
  gWorksBuildings[gTabArtifact] = {}
  gWorksBuildings[gTabArt] = {}
  gWorksBuildings[gTabArtifactOrArt] = {}
  gWorksBuildings[gTabLiterature] = {}
  gWorksBuildings[gTabMusic] = {}

  for pBuilding in GameInfo.Buildings() do
    if (pBuilding.GreatWorkCount > 0) then
      if (pBuilding.GreatWorkSlotType == "GREAT_WORK_SLOT_LITERATURE") then
        table.insert(gWorksBuildings[gTabLiterature], pBuilding.ID)
      elseif (pBuilding.GreatWorkSlotType == "GREAT_WORK_SLOT_MUSIC") then
        table.insert(gWorksBuildings[gTabMusic], pBuilding.ID)
      else
        table.insert(gWorksBuildings[gTabArtifact], pBuilding.ID)
        table.insert(gWorksBuildings[gTabArt], pBuilding.ID)
        table.insert(gWorksBuildings[gTabArtifactOrArt], pBuilding.ID)
      end
    end
  end
end

--------------------
--------------------

function InputHandler(uiMsg, wParam, lParam)
  -- Only process keyboard events if the pop-up window is visible
  if (Controls.GwManager:IsHidden() == false) then
    if (uiMsg == KeyEvents.KeyDown) then
      if (wParam == Keys.VK_ESCAPE) then
        OnClose()
        return true
      end
    end
  end
end
ContextPtr:SetInputHandler(InputHandler)

function OnTourismRightClick()
  CivIconHookup(Game.GetActivePlayer(), 64, Controls.CivIcon, Controls.CivIconBG, Controls.CivIconShadow, false, true)
  CivIconHookup(Game.GetActivePlayer(), 64, Controls.SwapCivIcon, Controls.SwapCivIconBG, Controls.SwapCivIconShadow, false, true)
  UpdateDisplay()

  Controls.GwManager:SetHide(false)
end
LuaEvents.GreatWorkmanagerDisplay.Add(OnTourismRightClick)

function OnClose()
  Controls.GwManager:SetHide(true)
end
Controls.CloseButton:RegisterCallback(Mouse.eLClick, OnClose)

function OnTabButtonArtifact()
  UpdateDisplay(gTabArtifact)
end
Controls.TabButtonArtifact:RegisterCallback(Mouse.eLClick, OnTabButtonArtifact)

function OnTabButtonArt()
  UpdateDisplay(gTabArt)
end
Controls.TabButtonArt:RegisterCallback(Mouse.eLClick, OnTabButtonArt)

function OnTabButtonArtifactOrArt()
  UpdateDisplay(gTabArtifactOrArt)
end
Controls.TabButtonArtifactOrArt:RegisterCallback(Mouse.eLClick, OnTabButtonArtifactOrArt)

function OnTabButtonLiterature()
  UpdateDisplay(gTabLiterature)
end
Controls.TabButtonLiterature:RegisterCallback(Mouse.eLClick, OnTabButtonLiterature)

function OnTabButtonMusic()
  UpdateDisplay(gTabMusic)
end
Controls.TabButtonMusic:RegisterCallback(Mouse.eLClick, OnTabButtonMusic)

function OnSelectEra(tab, iEra, iCiv)
  Select(tab, nil, iEra, iCiv, nil, nil)
end

function OnSelectWork(iWork)
  Select(nil, iWork, nil, nil, nil, nil)
end

function OnSelectOrPlace(iCity, iBuilding)
  if (gSelectedWorks == nil) then
    Select(nil, nil, nil, nil, iCity, iBuilding)
  else
    Place(iCity, iBuilding)
  end
end

function OnSelectSwap(iCiv, iEra)
  if (gSelectedWorks) then
    local pPlayer = Players[Game.GetActivePlayer()]
    
    local theirSwaps = GetSwapsiesByCivByEra(gTabSelected, pPlayer)[iCiv][iEra]
    local mySwaps = {}
    for iWork,_ in pairs(gSelectedWorks) do
      table.insert(mySwaps, iWork)
    end

--    if (#mySwaps > 1 or #theirSwaps > 1) then
      PromptForSwap(pPlayer, mySwaps, theirSwaps)
--    else
--      DoSwap(mySwaps[1], theirSwaps[1])
--    end
  
  end
end

function DoSwap(iMySwap, iTheirSwap, bForceThem)
  local iGwClass = Game.GetGreatWorkClass(iMySwap)
  
  if (iGwClass == Game.GetGreatWorkClass(iTheirSwap)) then
    local iMe = Game.GetGreatWorkController(iMySwap)
    local iThem = Game.GetGreatWorkController(iTheirSwap)

    if (iMe ~= iThem) then
      if (bForceThem) then
        Network.SendSetSwappableGreatWork(iThem, iGwClass, iTheirSwap)
      end

      Network.SendSetSwappableGreatWork(iMe, iGwClass, iMySwap)
      Network.SendSwapGreatWorks(iMe, iMySwap, iThem, iTheirSwap)
    end
  end
  
  ClearSelection()
end

--------------------
--------------------

local tipControlTable = {}
TTManager:GetTypeControlTable("TooltipTypeTopPanel", tipControlTable)
function ShowSelection()
  local sText = Locale.Lookup("TXT_KEY_GW_MANAGER_WORKSCART")

  if (gSelectedWorks) then
    for iWork,_ in pairs(gSelectedWorks) do
      sText = sText .. "[NEWLINE][ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_FILLED", Game.GetGreatWorkName(iWork), Game.GetGreatWorkEraShort(iWork), Players[Game.GetGreatWorkCreator(iWork)]:GetCivilizationAdjectiveKey())
    end

    tipControlTable.TooltipLabel:SetText(sText .. "[NEWLINE][NEWLINE]" .. Locale.Lookup("TXT_KEY_GW_MANAGER_WORKSCART_TT"))
  else
    tipControlTable.TooltipLabel:SetText(Locale.Lookup("TXT_KEY_GW_MANAGER_WORKSCART_EMPTY"))
  end
  
  tipControlTable.TopPanelMouseover:SetHide(false)
  tipControlTable.TopPanelMouseover:DoAutoSize()
end
Controls.WorksCart:SetToolTipCallback(ShowSelection)

function ShowPlacement(control)
  local iCity = control:GetVoid1()
  local iBuilding = control:GetVoid2()

  local pCity = Players[Game.GetActivePlayer()]:GetCityByID(iCity)
  local pBuilding = GameInfo.Buildings[iBuilding]

  local sBuildingTip = Locale.ConvertTextKey(pBuilding.Description)

  for iSlot = 0, pBuilding.GreatWorkCount-1, 1 do
    local iWork = pCity:GetBuildingGreatWork(GameInfoTypes[pBuilding.BuildingClass], iSlot)

    if (iWork ~= -1) then
      if (IsSelectedType(gTabSelected, iWork)) then
        sBuildingTip = sBuildingTip .. "[NEWLINE][ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_FILLED", Game.GetGreatWorkName(iWork), Game.GetGreatWorkEraShort(iWork), Players[Game.GetGreatWorkCreator(iWork)]:GetCivilizationAdjectiveKey())
      else
        sBuildingTip = sBuildingTip .. "[NEWLINE][ICON_BULLET][COLOR_GREY]" .. Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_FILLED", Game.GetGreatWorkName(iWork), Game.GetGreatWorkEraShort(iWork), Players[Game.GetGreatWorkCreator(iWork)]:GetCivilizationAdjectiveKey()) .. "[ENDCOLOR]"
      end
    else
      sBuildingTip = sBuildingTip .. "[NEWLINE][ICON_BULLET]" .. Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_EMPTY")
    end
  end

  if (gSelectedWorks == nil) then
    tipControlTable.TooltipLabel:SetText(sBuildingTip .. "[NEWLINE][NEWLINE]" .. Locale.Lookup("TXT_KEY_GW_MANAGER_SELECT_BUILDING_TT"))
  else
    tipControlTable.TooltipLabel:SetText(sBuildingTip .. "[NEWLINE][NEWLINE]" .. Locale.Lookup("TXT_KEY_GW_MANAGER_PLACE_TT"))
  end

  tipControlTable.TopPanelMouseover:SetHide(false)
  tipControlTable.TopPanelMouseover:DoAutoSize()
end

function ShowSwap(sSwapTip)
  if (gSelectedWorks) then
    tipControlTable.TooltipLabel:SetText(sSwapTip .. "[NEWLINE][NEWLINE]" .. Locale.Lookup("TXT_KEY_GW_MANAGER_SELECT_SWAP_TT"))
  else
    tipControlTable.TooltipLabel:SetText(sSwapTip)
  end

  tipControlTable.TopPanelMouseover:SetHide(false)
  tipControlTable.TopPanelMouseover:DoAutoSize()
end

--------------------
--------------------

function ClearSelection()
  gSelectedWorks = nil
end
Controls.WorksCart:RegisterCallback(Mouse.eLClick, ClearSelection)

function AppendSelection(works)
  if (#works > 0) then
    gSelectedWorks = gSelectedWorks or {}

    for _,iWork in ipairs(works) do
      gSelectedWorks[iWork] = true
    end
  end
end

-- Selection controls
--   Click to select works (clears any selected, only selects +0 bonus), shift-click to append works
--   Control-Click to select all works (clears any selected), control-shift-click to append works
--   Click/Shift-click to select/append swaps
function Select(tab, iWork, iEra, iCiv, iCity, iBuilding)
  -- tab is only valid/needed for iEra/iCiv
  local works = {}
  local bAllWorks = UIManager:GetControl()

  if (not UIManager:GetShift()) then
    ClearSelection()
  end

  if (iEra) then
    -- Select all the active player's works of the current type from iEra by iCiv
    for _,work in ipairs(GetGreatWorks(tab, Players[Game.GetActivePlayer()])) do
      if (iEra == work.Era and iCiv == work.Creator) then
        if (bAllWorks or Game.GetGreatWorkCurrentThemingBonus(work.Index) == 0) then
          table.insert(works, work.Index)
        end
      end
    end
  elseif (iCity) then
    -- Select all the active player's works REGARDLESS of the current type from iBuilding in iCity
    local pCity = Players[Game.GetActivePlayer()]:GetCityByID(iCity)
    local pBuilding = GameInfo.Buildings[iBuilding]

    for iSlot = 0, pBuilding.GreatWorkCount-1, 1 do
      local iWork = pCity:GetBuildingGreatWork(GameInfoTypes[pBuilding.BuildingClass], iSlot)

      if (iWork ~= -1) then
        if (bAllWorks or Game.GetGreatWorkCurrentThemingBonus(iWork) == 0) then
          table.insert(works, iWork)
        end
      end
    end
  elseif (iWork) then
    -- Select the specific work
    table.insert(works, iWork)
  end

  AppendSelection(works)
end

-- Placement controls
--   Click building to place selected works into empty slots
--   Control-click to place into all slots
function Place(iCity, iBuilding)
  local iPlayer = Game.GetActivePlayer()
  local pCity = Players[iPlayer]:GetCityByID(iCity)
  local pBuilding = GameInfo.Buildings[iBuilding]
  local iBuildingClass = GameInfoTypes[pBuilding.BuildingClass]

  local selectedWorks = {}
  local iSelectedWorks = 0
  local iEmptySlots = 0
  local iFilledSlots = 0

  local bAllWorks = UIManager:GetControl()

  -- Take a copy of gSelectedWorks, counting how many works are selected
  for iWork,_ in pairs(gSelectedWorks) do
    selectedWorks[iWork] = false
    iSelectedWorks = iSelectedWorks + 1
  end

  -- Loop all the slots in the selected building
  for iSlot = 0, pBuilding.GreatWorkCount-1, 1 do
    local iWork = pCity:GetBuildingGreatWork(iBuildingClass, iSlot)

    -- Count empty and swappable slots, note works selected and already in the building
    if (iWork == -1) then
      iEmptySlots = iEmptySlots + 1
    else
      if (selectedWorks[iWork] ~= nil) then
        if (bAllWorks) then
          selectedWorks[iWork] = true
        else
          selectedWorks[iWork] = nil
        end
      end

      iFilledSlots = iFilledSlots + 1
    end
  end

  local iTargetSlots = iEmptySlots + (bAllWorks and iFilledSlots or 0)
  if (iSelectedWorks > iTargetSlots) then
    if (iTargetSlots > 0) then
      PromptForPlace(iPlayer, iCity, iBuilding, iTargetSlots, selectedWorks)
    else
      print("Ignoring place into a building with no available slots - user probably meant Control-Click!")
    end
  else
    -- Just select everything
    for iWork,_ in pairs(selectedWorks) do
      selectedWorks[iWork] = true
    end

    DoPlace(iPlayer, iCity, iBuilding, selectedWorks)
  end
end

function DoPlace(iPlayer, iCity, iBuilding, selectedWorks)
  local pPlayer = Players[iPlayer]
  local pCity = pPlayer:GetCityByID(iCity)
  local pBuilding = GameInfo.Buildings[iBuilding]
  local iBuildingClass = GameInfoTypes[pBuilding.BuildingClass]

  -- Find all the empty and swappable slots in the building
  local emptySlots = {}
  local swappableSlots = {}
  for iSlot = 0, pBuilding.GreatWorkCount-1, 1 do
    local iWork = pCity:GetBuildingGreatWork(iBuildingClass, iSlot)

    if (iWork == -1) then
      table.insert(emptySlots, iSlot)
    elseif (not selectedWorks[iWork]) then
      table.insert(swappableSlots, iSlot)
    else
      -- No need to move this work as it's already here
      selectedWorks[iWork] = false
    end
  end

  -- Move the selected works into the empty slots first
  local iEmptySlot = 1
  local iSwappableSlot = 1
  for iWork,_ in pairs(selectedWorks) do
    if (selectedWorks[iWork]) then
      local iFromCity, iFromBuildingClass, _, iFromSlot = GetGreatWorkLocation(iWork)
      local iToSlot = -1

      if (iEmptySlot <= #emptySlots) then
        iToSlot = emptySlots[iEmptySlot]
        iEmptySlot = iEmptySlot + 1
      elseif (iSwappableSlot <= #swappableSlots) then
        iToSlot = swappableSlots[iSwappableSlot]
        iSwappableSlot = iSwappableSlot + 1
      end

      if (iToSlot ~= -1) then
        -- print(string.format("Exchange %i at %s[%s[%i]] with %s[%s[%i]]", iWork, Players[iPlayer]:GetCityByID(iFromCity):GetName(), GameInfo.BuildingClasses[iFromBuildingClass].Type, iFromSlot, pCity:GetName(), pBuilding.Type, iToSlot))
        Network.SendMoveGreatWorks(iPlayer, iFromCity, iFromBuildingClass, iFromSlot, iCity, iBuildingClass, iToSlot)
      else
        print("How the heck did we get here!")
      end
    end
  end

  -- Finally refresh the display
  -- done via SerialEventCityInfoDirty - UpdateDisplay()
end

--------------------
--------------------

function PromptForPlace(iPlayer, iCity, iBuilding, iTargetSlots, selectedWorks)
  local pPlayer = Players[iPlayer]
  local pCity = pPlayer:GetCityByID(iCity)
  local pBuilding = GameInfo.Buildings[iBuilding]

  IconHookup(pBuilding.PortraitIndex, 64, pBuilding.IconAtlas, Controls.PlaceIcon)

  function OnDialogOk()
    Controls.GwPlaceDialog:SetHide(true)

    DoPlace(iPlayer, iCity, iBuilding, selectedWorks)
  end
  Controls.PlaceOkButton:RegisterCallback(Mouse.eLClick, OnDialogOk)

  function OnDialogCancel()
    Controls.GwPlaceDialog:SetHide(true)
  end
  Controls.PlaceCancelButton:RegisterCallback(Mouse.eLClick, OnDialogCancel)

  function UpdateOkButton()
    local iSelected = 0
    for _, bSelected in pairs(selectedWorks) do
      if (bSelected) then
        iSelected = iSelected + 1
      end
    end

    Controls.PlaceOkButton:SetDisabled(iSelected > iTargetSlots)
  end

  Controls.PlaceHeader:SetText(Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_LOCATION", pBuilding.Description, pCity:GetName()))
  if (pBuilding.ThemingBonusHelp) then
    Controls.PlaceBonus:SetHide(false)
    Controls.PlaceBonus:SetText(Locale.Lookup(pBuilding.ThemingBonusHelp))
  else
    Controls.PlaceBonus:SetHide(true)
  end
  Controls.PlaceSelect:SetText(Locale.ConvertTextKey("TXT_KEY_GW_DIALOG_SELECT_PLACE", iTargetSlots))

  gPlaceIM:ResetInstances()
  for iWork, bSelected in pairs(selectedWorks) do
    local controlTable = gPlaceIM:GetInstance()
    local sWorkName = Locale.Lookup(Game.GetGreatWorkName(iWork))
    local sWorkEra = Game.GetGreatWorkEraShort(iWork)
    local sWorkCiv = Players[Game.GetGreatWorkCreator(iWork)]:GetCivilizationAdjectiveKey()
    local sWorkDesc = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_FILLED", sWorkName, sWorkEra, sWorkCiv)

    local iFromCity, _, iFromBuilding, _ = GetGreatWorkLocation(iWork)
    local sWorkBuilding = GameInfo.Buildings[iFromBuilding].Description
    local sWorkCity = pPlayer:GetCityByID(iFromCity):GetName()
    local sWorkLocation = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_IN_LOCATION", sWorkBuilding, sWorkCity)

    local iBonus = Game.GetGreatWorkCurrentThemingBonus(iWork)
    if (iBonus > 0) then
      sWorkDesc = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_WORK_BONUS", sWorkDesc, iBonus, sWorkLocation)
    else
      sWorkDesc = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_WORK", sWorkDesc, iBonus, sWorkLocation)
    end

    controlTable.PlaceWorkOption:GetTextButton():SetText(sWorkDesc)
    controlTable.PlaceWorkOption:SetToolTipString(sWorkDesc) -- because the text can be truncated
    controlTable.PlaceWorkOption:RegisterCheckHandler(function (bChecked) selectedWorks[iWork] = bChecked; UpdateOkButton() end)
    controlTable.PlaceWorkOption:SetCheck(bSelected)
  end

  Controls.PlaceWorksStack:CalculateSize()
  Controls.PlaceWorksStack:ReprocessAnchoring()
  Controls.PlaceWorksScroll:CalculateInternalSize()

  UpdateOkButton(selectedWorks)

  Controls.GwPlaceDialog:SetHide(false)
end

function PromptForSwap(pPlayer, mySwaps, theirSwaps)
  local iMySwap = -1
  local iTheirSwap = -1

  function OnDialogOk()
    Controls.GwSwapDialog:SetHide(true)
    
    DoSwap(iMySwap, iTheirSwap)
  end
  Controls.SwapOkButton:RegisterCallback(Mouse.eLClick, OnDialogOk)

  function OnDialogCancel()
    Controls.GwSwapDialog:SetHide(true)
  end
  Controls.SwapCancelButton:RegisterCallback(Mouse.eLClick, OnDialogCancel)

  gMySwapIM:ResetInstances()
  gTheirSwapIM:ResetInstances()

  for _, iWork in ipairs(mySwaps) do
    local controlTable = gMySwapIM:GetInstance()
    local sWorkName = Locale.Lookup(Game.GetGreatWorkName(iWork))
    local sWorkEra = Game.GetGreatWorkEraShort(iWork)
    local sWorkCiv = Players[Game.GetGreatWorkCreator(iWork)]:GetCivilizationAdjectiveKey()
    local sWorkDesc = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_FILLED", sWorkName, sWorkEra, sWorkCiv)

    local iFromCity, _, iFromBuilding, _ = GetGreatWorkLocation(iWork)
    local sWorkBuilding = GameInfo.Buildings[iFromBuilding].Description
    local sWorkCity = pPlayer:GetCityByID(iFromCity):GetName()
    local sWorkLocation = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_IN_LOCATION", sWorkBuilding, sWorkCity)

    local iBonus = Game.GetGreatWorkCurrentThemingBonus(iWork)
    if (iBonus > 0) then
      sWorkDesc = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_WORK_BONUS", sWorkDesc, iBonus, sWorkLocation)
    else
      sWorkDesc = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_WORK", sWorkDesc, iBonus, sWorkLocation)
    end

    controlTable.SwapWorkOption:GetTextButton():SetText(sWorkDesc)
    controlTable.SwapWorkOption:SetToolTipString(sWorkDesc) -- because the text can be truncated
    controlTable.SwapWorkOption:RegisterCallback(Mouse.eLClick, function () iMySwap = iWork; end)
    
    if (iMySwap == -1) then
      controlTable.SwapWorkOption:SetCheck(true)
      iMySwap = iWork
    end
  end

  Controls.MySwapWorksStack:CalculateSize()
  Controls.MySwapWorksStack:ReprocessAnchoring()
  Controls.MySwapWorksScroll:CalculateInternalSize()

  for _, iWork in ipairs(theirSwaps) do
    local controlTable = gTheirSwapIM:GetInstance()
    local sWorkName = Locale.Lookup(Game.GetGreatWorkName(iWork))
    local sWorkEra = Game.GetGreatWorkEraShort(iWork)
    local sWorkCiv = Players[Game.GetGreatWorkCreator(iWork)]:GetCivilizationAdjectiveKey()
    local sWorkDesc = Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_SWAP", Game.GetGreatWorkName(iWork), Players[Game.GetGreatWorkController(iWork)]:GetCivilizationShortDescriptionKey())

    controlTable.SwapWorkOption:GetTextButton():SetText(sWorkDesc)
    controlTable.SwapWorkOption:SetToolTipString(sWorkDesc) -- because the text can be truncated
    controlTable.SwapWorkOption:RegisterCallback(Mouse.eLClick, function () iMySwap = iWork; end)
    
    if (iTheirSwap == -1) then
      controlTable.SwapWorkOption:SetCheck(true)
      iTheirSwap = iWork
    end
  end

  Controls.TheirSwapWorksStack:CalculateSize()
  Controls.TheirSwapWorksStack:ReprocessAnchoring()
  Controls.TheirSwapWorksScroll:CalculateInternalSize()

  Controls.GwSwapDialog:SetHide(false)
end

--------------------
--------------------

function SetActivePlayer(iPlayer, iPrevPlayer)
  if (not bIsRegistered) then
    -- This doesn't want to play nicely at load time!
    local control = ContextPtr:LookUpControl("/InGame/TopPanel/TourismString")
    
    if (control) then
      control:RegisterCallback(Mouse.eRClick, OnTourismRightClick)
      bIsRegistered = true
      Events.GameplaySetActivePlayer.Remove(SetActivePlayer)
    else
      print("/InGame/TopPanel/TourismString is nil!")
    end
  end
end
Events.GameplaySetActivePlayer.Add(SetActivePlayer)

--------------------
--------------------

function Initialise()
  Events.SerialEventGameDataDirty.Add(UpdatePanels)

  SetActivePlayer(0)

  CacheWorksBuildings()

  OnClose()
  ContextPtr:SetHide(false)
end

Initialise()

--------------------
--------------------

function OnAdditionalInformationDropdownGatherEntries(additionalEntries)
  table.insert(additionalEntries, {text=Locale.ConvertTextKey("TXT_KEY_GW_MANAGER_DIPLO_CORNER_HOOK"), call=OnTourismRightClick, art="EUI_DC45_GreatWorkManager.dds"})
end
LuaEvents.AdditionalInformationDropdownGatherEntries.Add(OnAdditionalInformationDropdownGatherEntries)
LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()
