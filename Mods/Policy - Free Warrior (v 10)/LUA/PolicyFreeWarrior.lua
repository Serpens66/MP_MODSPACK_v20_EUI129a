print("This is the 'Policy - Free Warrior' mod script.")

local iPolicyBranchHonor = GameInfo.PolicyBranchTypes["POLICY_BRANCH_HONOR"].ID
local iPolicyDiscipline = GameInfo.Policies["POLICY_DISCIPLINE"].ID

-- function policyBranchListener(iPlayerId, iPolicyBranchTypeId) 
  -- local pPlayer = Players[iPlayerId]

  -- if (iPolicyBranchTypeId == iPolicyBranchHonor) then
    -- local pCity = pPlayer:GetCapitalCity()
	-- local pPlot = pCity and pCity:Plot() or pPlayer:GetStartingPlot()

    -- local sUnitType = GetCivSpecificUnit(pPlayer, "UNITCLASS_WARRIOR")
    -- local sUpgradeUnitType = GetUpgradeUnit(pPlayer, sUnitType)
    -- while (sUpgradeUnitType ~= nil) do
      -- sUnitType = sUpgradeUnitType
      -- sUpgradeUnitType = GetUpgradeUnit(pPlayer, sUnitType)
    -- end

    -- local pUnit = pPlayer:InitUnit(GameInfoTypes[sUnitType], pPlot:GetX(), pPlot:GetY(), UNITAI_DEFENSE)
    -- pUnit:JumpToNearestValidPlot()

	-- if (pCity ~= nil) then
      -- pUnit:SetExperience(pCity:GetProductionExperience(pUnit:GetUnitType()))

      -- if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_HEROIC_EPIC)) then
        -- pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_MORALE, true)
      -- end
    -- end
  -- end
-- end
-- GameEvents.PlayerAdoptPolicyBranch.Add(policyBranchListener)

function policyListener(iPlayerId, iPolicyTypeId) 
  local pPlayer = Players[iPlayerId]

  if (iPolicyTypeId == iPolicyDiscipline) then
    local pCity = pPlayer:GetCapitalCity()
	local pPlot = pCity and pCity:Plot() or pPlayer:GetStartingPlot()
    if pPlot~=nil then
        local sUnitType = GetCivSpecificUnit(pPlayer, "UNITCLASS_WARRIOR")
        local sUpgradeUnitType = GetUpgradeUnit(pPlayer, sUnitType)
        while (sUpgradeUnitType ~= nil) do
          sUnitType = sUpgradeUnitType
          sUpgradeUnitType = GetUpgradeUnit(pPlayer, sUnitType)
        end

        local pUnit = pPlayer:InitUnit(GameInfoTypes[sUnitType], pPlot:GetX(), pPlot:GetY(), UNITAI_DEFENSE)
        pUnit:JumpToNearestValidPlot()

        if (pCity ~= nil) then
          pUnit:SetExperience(pCity:GetProductionExperience(pUnit:GetUnitType()))

          if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_HEROIC_EPIC)) then
            pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_MORALE, true)
          end
        end
    end
  end
end
GameEvents.PlayerAdoptPolicy.Add(policyListener)

--
-- Helper methods
--
function GetUpgradeUnit(pPlayer, sUnitType)
  local sNewUnitClass = GameInfo.Units[sUnitType].GoodyHutUpgradeUnitClass

  if (sNewUnitClass ~= nil) then
    local sUpgradeUnitType = GetCivSpecificUnit(pPlayer, sNewUnitClass)

    if (sUpgradeUnitType ~= nil and Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes[GameInfo.Units[sUpgradeUnitType].PrereqTech])) then
      return sUpgradeUnitType
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
