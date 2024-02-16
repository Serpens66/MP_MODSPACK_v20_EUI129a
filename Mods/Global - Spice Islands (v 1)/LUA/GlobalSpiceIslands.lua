print("This is the 'Global - Spice Islands' mod script")

include("MapmakerUtilities")
include("PlotIterators")

function OnAreaCanHaveAnyResource(iPlayer, iArea)
  -- We need at least 10 tiles in the area for the placement algorithm to stand a chance of working
  return (Map.GetArea(iArea):GetNumTiles() >= 10)
end
GameEvents.AreaCanHaveAnyResource.Add(OnAreaCanHaveAnyResource)

function OnPlaceResource(iPlayer, iResource, iCount, iPlotX, iPlotY)
  local pPlot = Map.GetPlot(iPlotX, iPlotY)
  local pOwningCity = pPlot:GetPlotCity()
  
  -- Try to place one resource in ring1, one in ring2, etc until out of resources or passed ring 5
  -- Any resources that can't be placed in ring N, should be placed in ring N+1
  -- If a resource is placed in ring 1, add an appropriate improvement
  
  local iRing = 1
  local iToPlace = 1
  local iPlaced = 0
  
  while (iPlaced < iCount and iRing <= 5) do
    local plots = GetPossiblePlots(pPlot, iRing, iResource)

    local iPlot = 1
	while (iPlot <= #plots and iToPlace > 0) do
	  PlaceResourceAtPlot(plots[iPlot], iResource, 1, (iRing == 1), pOwningCity)
	  iToPlace = iToPlace - 1
	  iPlaced = iPlaced + 1
	end
  
    iToPlace = iToPlace + 1
    iRing = iRing + 1
  end
  
  if (iPlaced < iCount) then
    print(string.format("Unable to place %i of %s around (%i, %i) - placing them under the city", (iCount-iPlaced), GameInfo.Resources[iResource].Type, iPlotX, iPlotY))
	PlaceResourceAtPlot(pPlot, iResource, iCount-iPlaced, false, pOwningCity)
  end
end
GameEvents.PlaceResource.Add(OnPlaceResource)

function GetPossiblePlots(pPlot, iRing, iResource)
  local plots = {}
  
  -- As we shuffle the plots before returning them, it doesn't matter where we start
  for pEdgePlot in PlotRingIterator(pPlot, iRing) do
    if (pEdgePlot:GetArea() == pPlot:GetArea() and pEdgePlot:CanHaveResource(iResource, false, true)) then
	  table.insert(plots, pEdgePlot)
	end
  end
  
  return GetShuffledCopyOfTable(plots)
end

function PlaceResourceAtPlot(pPlot, iResource, iCount, bImprove, pOwningCity)
  pPlot:SetResourceType(-1, 0)
  pPlot:SetResourceType(iResource, iCount)
  
  if (bImprove) then
    local iImprovement = GetImprovementForResource(iResource)
	if (iImprovement ~= -1) then
	  iFeature = pPlot:GetFeatureType()
	  pPlot:SetFeatureType(-1)
      pPlot:SetImprovementType(iImprovement)

	  if (pOwningCity ~= nil and iFeature == GameInfoTypes.FEATURE_FOREST) then
	    local iBonusProduction = pPlot:GetFeatureProduction(GameInfoTypes.BUILD_REMOVE_FOREST, pPlot:GetOwner()) / 2
	    print(string.format("Chopped down a forest, need to give the city a production boost of %i"), iBonusProduction)
		pOwningCity:SetFeatureProduction(pOwningCity:GetFeatureProduction() + iBonusProduction)
	  end
	end
  end
end

function GetImprovementForResource(iResource)
  for row in GameInfo.Improvement_ResourceTypes{ResourceType = GameInfo.Resources[iResource].Type} do
    return GameInfoTypes[row.ImprovementType]
  end

  return -1
end
