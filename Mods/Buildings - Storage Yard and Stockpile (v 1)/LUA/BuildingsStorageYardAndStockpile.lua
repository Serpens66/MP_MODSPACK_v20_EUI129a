print("This is the 'Buildings - Storage yard and Stockpile' mod script.")

local iStorageYard = GameInfoTypes.BUILDING_STORAGEYARD
local iStockpile   = GameInfoTypes.PROCESS_STOCKPILE

function OnCityCanConstruct(iPlayer, iCity, iBuilding) 
  if (iBuilding == iStorageYard) then
    local pPlayer = Players[iPlayer]

	if (not pPlayer:IsHuman()) then
	  return false
	end
  end

  return true
end
GameEvents.CityCanConstruct.Add(OnCityCanConstruct) 

function OnCityCanMaintain(iPlayer, iCity, iProcess) 
  if (iProcess == iStockpile) then
    local pPlayer = Players[iPlayer]

	if (not pPlayer:IsHuman()) then
	  return false
	end

    local pCity = pPlayer:GetCityByID(iCity)

	-- This city can only stockpile if it has a storage yard and it's not already full
    if (pCity:GetNumBuilding(iStorageYard) > 0) then
	  if (pCity:GetOverflowProduction() > pPlayer:GetMaxStockpile()) then
	    return false
	  end
	else
	  return false
	end
  end

  return true
end
GameEvents.CityCanMaintain.Add(OnCityCanMaintain) 
