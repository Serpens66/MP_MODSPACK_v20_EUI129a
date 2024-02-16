print("This is the 'Policy - Reveal Capitals' mod script.")

local iPolicyBranchPatronage = GameInfoTypes.POLICY_BRANCH_PATRONAGE
local iPolicyBranchCommerce = GameInfoTypes.POLICY_BRANCH_COMMERCE
local iPolicyBranchExploration = GameInfoTypes.POLICY_BRANCH_EXPLORATION

function policyBranchListener(iPlayerId, iPolicyBranchTypeId) 
  pPlayer = Players[iPlayerId]

  if (pPlayer:IsHuman()) then
    if (iPolicyBranchTypeId == iPolicyBranchPatronage) then
      for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1 do
        local pCsPlayer = Players[i]
        if pCsPlayer:IsEverAlive() then
          showCell(pPlayer, pCsPlayer:GetStartingPlot())
        end
      end
    elseif (iPolicyBranchTypeId == iPolicyBranchCommerce or iPolicyBranchTypeId == iPolicyBranchExploration) then
      for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
        local pCivPlayer = Players[i]
        if pCivPlayer:IsEverAlive() then
          showCell(pPlayer, pCivPlayer:GetStartingPlot())
        end
      end
    end
  end
end

GameEvents.PlayerAdoptPolicyBranch.Add(policyBranchListener)


--
-- Helper methods
--
function showPlot(iTeam, pPlot)
  pPlot:SetRevealed(iTeam, true)
  pPlot:UpdateFog()
end

function showCell(pPlayer, pPlot)
  directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST, DirectionTypes.DIRECTION_SOUTHEAST,
                DirectionTypes.DIRECTION_SOUTHWEST, DirectionTypes.DIRECTION_WEST, DirectionTypes.DIRECTION_NORTHWEST}

  local iTeam = pPlayer:GetTeam()

  -- Reveal the central plot
  showPlot(iTeam, pPlot)

  -- Reveal the surrounding plots
  for loop, direction in ipairs(directions) do
    showPlot(iTeam, Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction))
  end
end
