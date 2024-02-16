-- fixed a small bug by changing the if function to "or" instead of "and" and disabled the "LookAt" -- Serp 17.5.2015
print("This is the 'UI - Destination' mod script.")

include("FLuaVector")

local pathBorderStyle = "MovementRangeBorder"

local bClearPath = false

function OnUnitSelectionChange(iPlayerID, iUnitID, i, j, k, isSelected)
  if (isSelected) then
    local pUnit = Players[iPlayerID]:GetUnitByID(iUnitID)
    local pMissionPlot = pUnit:LastMissionPlot()
    --print("Unit X: "..pUnit:GetX() .. " Y: "..pUnit:GetY())
    --print("Mission X: "..pMissionPlot:GetX() .. " Y: "..pMissionPlot:GetY())
    local target_hex = ToHexFromGrid(Vector2(pMissionPlot:GetX(), pMissionPlot:GetY()))
    if (pUnit:GetX() ~= pMissionPlot:GetX() or pUnit:GetY() ~= pMissionPlot:GetY()) then
      Events.GameplayFX(target_hex.x, target_hex.y, -1) -- light the plot, from "showmoveto mod"
      Events.SerialEventHexHighlight(target_hex, true, nil, pathBorderStyle)
      bClearPath = true
      
      
      --UI.LookAt(pMissionPlot, 0)

      -- UI.SetInterfaceMode(InterfaceModeTypes.INTERFACEMODE_MOVE_TO)
    end
  end
end
Events.UnitSelectionChanged.Add(OnUnitSelectionChange)

function OnUnitSelectionCleared()
  if (bClearPath) then
    Events.ClearHexHighlightStyle(pathBorderStyle)
    bClearPath = false
  end
end
Events.UnitSelectionCleared.Add(OnUnitSelectionCleared)
