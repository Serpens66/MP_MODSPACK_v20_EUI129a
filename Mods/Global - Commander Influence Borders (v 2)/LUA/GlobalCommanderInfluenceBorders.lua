print("This is the 'Global - Commander Influence Borders' mod script.")

local iGreatGeneral = GameInfoTypes.UNIT_GREAT_GENERAL
local iGreatAdmiral = GameInfoTypes.UNIT_GREAT_ADMIRAL

local iCommanderRange = GameDefines.GREAT_GENERAL_RANGE

local bInfluenceBorders = false

function ClearInfluenceBorders()
  if (bInfluenceBorders) then
    Events.ClearHexHighlightStyle("FireRangeBorder")
    bInfluenceBorders = false
  end
end

function ShowInfluenceBorder(pUnit, bWater)
  local pPlot = pUnit:GetPlot()
  local x = pPlot:GetX()
  local y = pPlot:GetY()
  local range = pUnit.GetAuraRange and pUnit:GetAuraRange() or iCommanderRange

  for dx = -range, range do
    for dy = -range, range do
      local pInfPlot = Map.PlotXYWithRangeCheck(x, y, dx, dy, range)
      if (pInfPlot ~= nil) then
	      if (pInfPlot:IsCity() or pInfPlot:IsWater() == bWater) then
		      Events.SerialEventHexHighlight(ToHexFromGrid({x=pInfPlot:GetX(), y=pInfPlot:GetY()}), true, {x=1, y=0, z=1, w=1}, "FireRangeBorder")
		    end
      end
    end
  end

  bInfluenceBorders = true
end

function ShowInfluenceBorders(pPlayer, iUnitType, bWater)
  ClearInfluenceBorders()
  
  for pUnit in pPlayer:Units() do
	  if (pUnit:GetUnitType() == iUnitType) then
      ShowInfluenceBorder(pUnit, bWater)
    end
  end
end

function OnUnitSelectionChange(iPlayer, iUnit, iHexX, iHexY, _, bSelected)
  if (bSelected) then
    local pPlayer = Players[iPlayer]
    local pUnit = pPlayer:GetUnitByID(iUnit)
	
	if (pUnit ~= nil) then
  	  if (pUnit:GetUnitType() == iGreatGeneral) then
	    ShowInfluenceBorders(pPlayer, iGreatGeneral, false)
	  elseif (pUnit:GetUnitType() == iGreatAdmiral) then
	    ShowInfluenceBorders(pPlayer, iGreatAdmiral, true)
	  end
	end
  else
    ClearInfluenceBorders()
  end
end
Events.UnitSelectionChanged.Add(OnUnitSelectionChange)

function OnUnitSelectionCleared()
  ClearInfluenceBorders()
end
Events.UnitSelectionCleared.Add(OnUnitSelectionCleared)

function OnUnitDestroyed(iPlayer, iUnit)
  ClearInfluenceBorders()
end
Events.SerialEventUnitDestroyed.Add(OnUnitDestroyed)
