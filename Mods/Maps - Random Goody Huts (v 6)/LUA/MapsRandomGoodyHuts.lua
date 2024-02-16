print("This is the 'Maps - Random Goody Huts' mod script.")

include("MapGenerator")

function clearGoodyHuts()
  print("Clearing goody huts")
  local iGoody = GameInfo.Improvements["IMPROVEMENT_GOODY_HUT"].ID

  for iPlot = 0, Map.GetNumPlots()-1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)

    if (pPlot:GetImprovementType() == iGoody) then
      pPlot:SetImprovementType(-1)
    end
  end
end

function randomiseGoodyHuts()
  print("Randomising goody huts")
  -- Use the MapGenerator.AddGoodies() method
  AddGoodies()
end

function Randomise()
  clearGoodyHuts()
  randomiseGoodyHuts()
end

function IsInitialised()
  local savedData = Modding.OpenSaveData()
  local sKey = "166f91ed-2546-45ee-a03a-d63b9a75132b_Initialised";

  local bInitialised = (savedData.GetValue(sKey) ~= nil)

  if (not bInitialised) then
    savedData.SetValue(sKey, 1)
  end

  return bInitialised
end

function IsNotInitialised()
  return not IsInitialised()
end


-- This gets called after the map has been generated and the units placed by the core code
-- but *before* the load screen dialog (the one with the partial map in the background)
-- has been displayed - effectively it's an OnGameStart() event!
if (IsNotInitialised()) then Randomise() end
