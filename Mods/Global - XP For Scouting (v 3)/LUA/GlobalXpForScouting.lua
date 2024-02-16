print("This is the 'Global - XP For Scouting' mod script.")

--[[
  This is an example, it could just as easily be used to give culture from revealed tiles
  or faith from religious units in foreign lands, or gold from resources, or xp for ships from ice, or ...
]]--

-- How many scouting XPs in a real XP
local iScoutingXpDivisor = 5

-- Scouting XP awarded for being the first to reveal a tile
local iScoutingXpForTile = 1

-- Scouting XP awarded for being the first to reveal a Natural Wonder
local iScoutingXpForNW = iScoutingXpDivisor * 5

-- How many scouting XPs we have to accumulate before real XPs are awarded, this should be a multiple of iScoutingXpDivisor
local iScoutingXpAccumulated = iScoutingXpDivisor * 1

-- XP limit for scouting
local iScoutingXpLimit = 30


--
-- Nothing below this line should need changing
--

local iXpForScoutingPromotion = GameInfoTypes.PROMOTION_XP_FOR_SCOUTING
local iXpForScoutingPromotion_2 = GameInfoTypes.PROMOTION_XP_FOR_SCOUTING_II
local iXpForScoutingPromotion_3 = GameInfoTypes.PROMOTION_XP_FOR_SCOUTING_III
local iXpForScoutingPromotion_4 = GameInfoTypes.PROMOTION_XP_FOR_SCOUTING_IV
local iXpForScoutingPromotion_5 = GameInfoTypes.PROMOTION_XP_FOR_SCOUTING_V
local iMaxMajor = GameDefines.MAX_MAJOR_CIVS-1


--
-- Scouting XP cache helpers
--

-- local modDB = Modding.OpenSaveData() -- using database causes a small lag everytime a recon discovers a tile first... we use databse only to not loose scoutingXP when loading a savegame... so without it we only loose up to 3/4 XP when loading. is ok
local cachedScoutingXp = {}
local updateneeded = 0

function GetKey(iPlayer, iUnit)
	return string.format("SCOUTING_XP_%i_%i", iPlayer, iUnit)
end

function GetScoutingXp(iPlayer, iUnit)
	if (cachedScoutingXp[iPlayer] == nil) then
		cachedScoutingXp[iPlayer] = {}
	end
	
	if (cachedScoutingXp[iPlayer][iUnit] == nil) then
        -- if Players[iPlayer]:IsHuman() then
            -- print("database get")
        -- end
		cachedScoutingXp[iPlayer][iUnit] = 0-- (modDB.GetValue(GetKey(iPlayer, iUnit)) or 0) -- don't use databse to prevent lags
	end
	
	return cachedScoutingXp[iPlayer][iUnit]
end

function SetScoutingXp(iPlayer, iUnit, iXp, bCommit)
	cachedScoutingXp[iPlayer][iUnit] = iXp
	
	if (bCommit and updateneeded==1) then
		-- Calls to modDB are expensive,
		-- so we save them all up to the movement onto the tile
		-- as opposed to when every tile is revealed
        -- if Players[iPlayer]:IsHuman() then
            -- print(string.format("database set %i",iXp))
        -- end
		-- modDB.SetValue(GetKey(iPlayer, iUnit), iXp) -- dont save, to prevent lags
        updateneeded = 0
	end
end

function ChangeScoutingXp(iPlayer, iUnit, iXp)
    -- if Players[iPlayer]:IsHuman() then
        -- print("changescouting")
    -- end
    updateneeded = 1
	SetScoutingXp(iPlayer, iUnit, GetScoutingXp(iPlayer, iUnit) + iXp, false)
end

function UpdateScoutingXp(iPlayer, iUnit)
	local iScoutingXp = GetScoutingXp(iPlayer, iUnit)
	
	if (iScoutingXp >= iScoutingXpAccumulated) then
		local pUnit = Players[iPlayer]:GetUnitByID(iUnit)
		local iRealXp = math.floor(iScoutingXp / iScoutingXpDivisor)
        local limitaddtion = 0
        
        if pUnit:IsHasPromotion(iXpForScoutingPromotion) then -- dont change it for 1
		elseif pUnit:IsHasPromotion(iXpForScoutingPromotion_2) then
            limitaddtion = 20
        elseif pUnit:IsHasPromotion(iXpForScoutingPromotion_3) then
            limitaddtion = 40
        elseif pUnit:IsHasPromotion(iXpForScoutingPromotion_4) then
            limitaddtion = 60
        elseif pUnit:IsHasPromotion(iXpForScoutingPromotion_5) then
            limitaddtion = 70
        end
        
		pUnit:ChangeExperience(math.max(0, math.min(iRealXp, (iScoutingXpLimit + limitaddtion) - pUnit:GetExperience())))
		
		if (pUnit:GetExperience() >= iScoutingXpLimit + limitaddtion) then
			pUnit:SetHasPromotion(iXpForScoutingPromotion, false)
            pUnit:SetHasPromotion(iXpForScoutingPromotion_2, false)
            pUnit:SetHasPromotion(iXpForScoutingPromotion_3, false)
            pUnit:SetHasPromotion(iXpForScoutingPromotion_4, false)
            pUnit:SetHasPromotion(iXpForScoutingPromotion_5, false)
			iScoutingXp = 0
		else
			iScoutingXp = iScoutingXp - (iRealXp * iScoutingXpDivisor)
		end
        updateneeded = 1
	end
    SetScoutingXp(iPlayer, iUnit, iScoutingXp, true)
end

function OnUnitSetXY(iPlayer, iUnit, iX, iY)
	if (iPlayer >= 0 and iPlayer <= iMaxMajor) then
        local pUnit = Players[iPlayer]:GetUnitByID(iUnit)
		if (pUnit:IsHasPromotion(iXpForScoutingPromotion)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_2)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_3)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_4)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_5)) then
			UpdateScoutingXp(iPlayer, iUnit)
		end
	end
end
GameEvents.UnitSetXY.Add(OnUnitSetXY)

function OnUnitPrekill(iPlayer, iUnit, _, _, _, bDelay, _)
	if (not bDelay and GetScoutingXp(iPlayer, iUnit) ~= 0) then
        updateneeded = 1
		SetScoutingXp(iPlayer, iUnit, 0, true)
	end
end
GameEvents.UnitPrekill.Add(OnUnitPrekill)


--
-- Tile reveal event handlers
--

function OnTileRevealed(iPlotX, iPlotY, iTeam, iFromTeam, bFirst, iPlayer, iUnit)
    if (bFirst and iPlayer >= 0 and iPlayer <= iMaxMajor) then
        -- if Players[iPlayer]:IsHuman() then
            -- print("tile revealed")
        -- end
        local pUnit = Players[iPlayer]:GetUnitByID(iUnit)
		if pUnit~=nil and ((pUnit:IsHasPromotion(iXpForScoutingPromotion)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_2)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_3)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_4)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_5))) then
			local pPlot = Map.GetPlot(iPlotX, iPlotY)
			
			-- Only land or lakes, but not NWs (as they are handled below)
			if (((not pPlot:IsWater()) or pPlot:IsLake()) and (not pPlot:IsNaturalWonder())) then
				ChangeScoutingXp(iPlayer, iUnit, iScoutingXpForTile)
			end
		end
	end
end
GameEvents.TileRevealed.Add(OnTileRevealed)

function OnNaturalWonderDiscovered(iTeam, iFeature, iX, iY, bFirst, iPlayer, iUnit)
	if (bFirst and iPlayer >= 0 and iPlayer <= iMaxMajor) then
		local pUnit = Players[iPlayer]:GetUnitByID(iUnit)
		if pUnit~=nil and ((pUnit:IsHasPromotion(iXpForScoutingPromotion)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_2)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_3)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_4)) or (pUnit:IsHasPromotion(iXpForScoutingPromotion_5))) then
			ChangeScoutingXp(iPlayer, iUnit, iScoutingXpForNW)
		end
	end
end
GameEvents.NaturalWonderDiscovered.Add(OnNaturalWonderDiscovered)
