-- Lua Script1
-- Author: OrgadEyal
-- DateCreated: 7/18/2014 7:00:02 AM
--------------------------------------------------------------

function IsPioneerOrColonist(iPlayer, iCityX, iCityY)

	local pPlayer = Players[iPlayer];
	if (pPlayer == nil) then return; end

	local pPlot = Map.GetPlot(iCityX, iCityY);
	if (pPlot == nil) then return; end

	local iNumUnits = pPlot:GetNumUnits();
	local pUnit
	
	--Checks if the unit who found the city is a Pioneer or a conquistador.
	for i = 0, iNumUnits do
        if (pPlot:GetUnit(i) == nil) then return; end
		pUnit = pPlot:GetUnit(i):GetUnitType();
		if (pUnit == GameInfoTypes["UNIT_PIONEER"]) or (pUnit == GameInfoTypes["UNIT_SPANISH_CONQUISTADOR"]) or (pUnit == GameInfoTypes["UNIT_COLONIST"]) then
			local pCity = pPlot:GetPlotCity();
			if (pCity == nil) then return; end
			--Add the first level of upgrades to the city
			SmallCityBuff(pPlayer, pCity);

			if (pUnit == GameInfoTypes["UNIT_COLONIST"]) then
				BigCityBuff(pPlayer, pCity); end
			--A free worker to start improving the city
			pPlayer:InitUnit (1, pPlot:GetX(), pPlot:GetY());

			--Add half the food required for the next citizen if the player has a policy.
			if (pPlayer:HasPolicy(GameInfo.Policies["POLICY_COLLECTIVE_RULE"].ID)) then
				local iTurnsToGrowth = pCity:GetFoodTurnsLeft();
				local iFoodPerTurn = pCity:FoodDifferenceTimes100() / 90;
				local halfFood = iFoodPerTurn * iTurnsToGrowth / 2;
				pCity:SetFood(halfFood); end
			break
		end
	end
end


function SmallCityBuff(pPlayer, pCity)
	--Adds territory to the newly found city
	AddTerritory(pPlayer:GetID(), pCity, 2); -- 3
	--Adds pop.
	pCity:ChangePopulation(2, true); --3
	--Adds buildings
	EarlyGameBuildings(pCity);
	end


	function BigCityBuff(pPlayer, pCity)
	--Adds territory to the newly found city
	AddTerritory(pPlayer:GetID(), pCity, 2);
	--Adds pop.
	pCity:ChangePopulation(2, true);
	--Adds buildings
	MidGameBuildings(pCity);
	end


function AddTerritory(lordOfTheLand, pCity, freePlots)
local pCityID = pCity:GetID();
	for i = 1, freePlots do
		local plot = pCity:GetNextBuyablePlot();
		plot:SetOwner(lordOfTheLand, pCityID);
		end
	 end

	 --]]

function EarlyGameBuildings(pCity)
	AddBuilding(pCity, GameInfoTypes["BUILDING_GRANARY"]);
	AddBuilding(pCity, GameInfoTypes["BUILDING_MONUMENT"]);
	-- AddBuilding(pCity, GameInfoTypes["BUILDING_LIBRARY"]);
	-- AddBuilding(pCity, GameInfoTypes["BUILDING_WATERMILL"]);
	AddBuilding(pCity, GameInfoTypes["BUILDING_COLOSSEUM"]);
	-- AddBuilding(pCity, GameInfoTypes["BUILDING_LIGHTHOUSE"]);
end
	
function MidGameBuildings(pCity)
	AddBuilding(pCity, GameInfoTypes["BUILDING_MARKET"]);
	AddBuilding(pCity, GameInfoTypes["BUILDING_WORKSHOP"]);
	-- AddBuilding(pCity, GameInfoTypes["BUILDING_UNIVERSITY"]);
	AddBuilding(pCity, GameInfoTypes["BUILDING_AQUEDUCT"]);
	-- AddBuilding(pCity, GameInfoTypes["BUILDING_HARBOR"]);
end



-- Adds the building to the city, if able
function AddBuilding (pCity, tBuilding)
	if (pCity == nil) then return; end
	if (tBuilding == nil) then return; end

	local pPlayer = pCity:GetOwner();
	--local pOwner = Players[pPlayer];
	if (pPlayer ~= nil) then
		if (pCity:CanConstruct(tBuilding)) then -- Still check base game rules such as tech and resource requirements
			if (not pCity:IsHasBuilding(tBuilding)) then
				pCity:SetNumRealBuilding(tBuilding, 1);
			end
		end
	end
end

GameEvents.PlayerCityFounded.Add( IsPioneerOrColonist );
