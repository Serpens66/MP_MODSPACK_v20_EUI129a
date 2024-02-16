--=======================================================================================================================
--=======================================================================================================================
-- changed versin of Serp multiplayer modpack, disabled name changes. changed chance of general, and they do not spawn before in era 0
--=======================================================================================================================
--=======================================================================================================================

local settings_BarbarianGenerals = 1
local settings_BarbarianPromos = 1
local settings_BarbarianNames = 0
local GeneralSpawnChancePerBarbSpawn = 40 -- everytime a barbarian unit spawns, the chance is 1/value for a general to spawn in that camp.



local iBarb = GameDefines.BARBARIAN_PLAYER

local SpeedGold = (GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent / 100)
local SpeedCulture = (GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent / 100)

local iGeneralType = GameInfoTypes["UNIT_BARBARIAN_GENERAL"]
local iOldEra = 0

function Leugi_GetAvrgEra()
	-- print("Leugi_GetAvrgEra")
    local pEras = {}
	for _, pPlayer in pairs(Players) do
		if (pPlayer:IsAlive()) then
			local currentEra = pPlayer:GetCurrentEra()
			table.insert(pEras, currentEra)
		end
	end
	n = 0
	a = 0
	for _, i in pairs (pEras) do
		n = n + 1
		a = a + i
	end
	if a == 0 then
		eraID = 0
	else
		eraID = math.floor(a/n)
	end
	--print ("Current Average Era:" .. eraID)
	return eraID
end

function Leugi_CheckEra(era)
    -- print("Leugi_CheckEra")
    eraID = Leugi_GetAvrgEra()
	if eraID ~= iOldEra then
		iOldEra = eraID
        if settings_BarbarianNames == 1 then
			Leugi_BarbNameChange(eraID)
		end
		if settings_BarbarianPromos == 1 then
			local pBarb = Players[iBarb]
            if eraID>1 and  pBarb~=nil and pBarb:IsBarbarian() then
                for pUnit in pBarb:Units() do
                    if (pUnit:GetID() ~= iGeneralType and pUnit:GetUnitType() ~= iGeneralType) then -- the general gets no additional promotions (changed by Serp) 
                        Leugi_BarbPromoChange(eraID,pUnit)
                    end
                end
            end
		end
        -- print("Av. Era changed. You should receive a notification barbarians updated. Eranumber: "..eraID)

        if eraID>1 and settings_BarbarianNames == 0 and settings_BarbarianPromos == 1 then
            if eraID==2 then
                title =  Locale.ConvertTextKey("TXT_KEY_UPGRADE_BRIGAND_TITLE"); 
                descr =  Locale.ConvertTextKey("TXT_KEY_PROMOTION_BRIGAND_HELP");
            elseif eraID==3 then
                title =  Locale.ConvertTextKey("TXT_KEY_UPGRADE_PIRATE_TITLE");
                descr =  Locale.ConvertTextKey("TXT_KEY_PROMOTION_PIRATE_HELP");
            elseif eraID==4 or eraID==5 then
                title =  Locale.ConvertTextKey("TXT_KEY_UPGRADE_REBEL_TITLE");
                descr =  Locale.ConvertTextKey("TXT_KEY_PROMOTION_REBEL_HELP");
            else -- 6/7
                title =  Locale.ConvertTextKey("TXT_KEY_UPGRADE_TERRORISTS_TITLE");
                descr =  Locale.ConvertTextKey("TXT_KEY_PROMOTION_TERRORIST_HELP");
            end
            for playernumber = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do   -- send a notification to every human player
                local pPlayer = Players[playernumber]
                if pPlayer~=nil and pPlayer:IsHuman() then
                    pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1) -- NOTIFICATION_BARBARIAN will crash the game with invalid plot and wont show if there is no camp
                end
            end
        end
	end
end

--[[
function Leugi_BarbarianGGandHeal(iPlayer)
	print ("Barb GG/Heal/Promo func")
    local pPlayer = Players[iPlayer];
    if (pPlayer~=nil and pPlayer:IsBarbarian() and pPlayer:IsAlive()) then
        if (iOldEra>0) then -- generals do not spawn before the first era
            for pUnit in pPlayer:Units() do
                if (pUnit:GetID() ~= iGeneralType and pUnit:GetUnitType() ~= iGeneralType) then
                    -- Leugi_BarbPromoChange(iOldEra,pUnit) -- give new units the promotions, is done via BarbariansSpawnedUnit now. this will only fire for regular spawned barbs, so none created by lua or so. I think this is okay
                    if settings_BarbarianGenerals==1 then
                        -- if pUnit:IsStackedGreatGeneral() then
                            -- pUnit:ChangeDamage(-20); -- too easy to exploit, because it may mean endless XP farming (until cap)
                        -- end
                        local pPlot = pUnit:GetPlot();
                        if pPlot~=nil and pPlot:HasBarbarianCamp() and not ( pPlot:GetNumUnits() > 1 ) then
                            local rand = Map.Rand(2, "Random Possibility of General")
                            if rand == 1 then
                                print ("A BarbArian General was Born!")
                                local unit = pPlayer:InitUnit (iGeneralType, pPlot:GetX(), pPlot:GetY());
                                -- unit:JumpToNearestValidPlot() -- for some reason this will him put out of the camp. so we dont call it, since the camp plot should be valid
                            end
                        end
                    end
                end
            end
        end
    end    
end
]]--


function GrantGeneralGold(iPlayer, iPlKilled, eUnitType)
    -- print("UnitKilled")
    if (eUnitType == iGeneralType) then
        -- print("General killed by ",iPlayer)
        local pPlayer = Players[iPlayer];
        if (pPlayer~=nil and pPlayer:IsEverAlive()) then
            local eratype = pPlayer:GetCurrentEra() or 1;
            culturebonus = math.ceil(50 * eratype * SpeedCulture) -- aufrunden
            goldbonus = math.ceil(70 * eratype * SpeedGold)
            pPlayer:ChangeJONSCulture(culturebonus);
            pPlayer:ChangeGold (goldbonus);
            if (pPlayer:IsHuman()) then
                -- disabled the name changes in txtkeys! so no adj and camp
                local alert = Locale.ConvertTextKey("TXT_KEY_BARB_CAMP_GENERAL_CLEARED", goldbonus, culturebonus)
                local title = Locale.ConvertTextKey("TXT_KEY_BARB_CAMP_GENERAL_CLEARED_TITLE")
                -- pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, alert, title,-1,-1) -- without jump to plot
                pPlayer:AddMessage(alert) -- floating message is enough
            end
        end
    end
end


--=======================================================================================================================
--=======================================================================================================================
-- Barbarian Promotion Change
--=======================================================================================================================
--=======================================================================================================================
local BrigandPromo = GameInfoTypes.PROMOTION_BRIGAND;
local PiratePromo = GameInfoTypes.PROMOTION_PIRATE;
local RebelPromo = GameInfoTypes.PROMOTION_REBEL;
local TerroristPromo = GameInfoTypes.PROMOTION_TERRORIST;



function Leugi_BarbPromoChange(eraID,pUnit)
    if eraID == 2 then
        if (pUnit:IsHasPromotion(BrigandPromo)==false or pUnit:IsHasPromotion(UnFriendlyPromo)==true) then
            pUnit:SetHasPromotion(BrigandPromo,true);
            pUnit:SetHasPromotion(UnFriendlyPromo,false);
            --print ("Brigand Promotions")
        end
    elseif eraID == 3 then
        if (pUnit:IsHasPromotion(PiratePromo)==false or pUnit:IsHasPromotion(BrigandPromo)==true) then
            --print ("Pirate Promotions")
            pUnit:SetHasPromotion(PiratePromo,true);
            pUnit:SetHasPromotion(BrigandPromo,false);
        end
    elseif eraID == 4 or eraID == 5 then
        if (pUnit:IsHasPromotion(RebelPromo)==false or pUnit:IsHasPromotion(BrigandPromo)==true or pUnit:IsHasPromotion(PiratePromo)==true) then
            --print ("Rebel Promotions")
            pUnit:SetHasPromotion(RebelPromo,true);
            pUnit:SetHasPromotion(BrigandPromo,false);
            pUnit:SetHasPromotion(PiratePromo,false);
        end
    elseif eraID >= 6 then
        if (pUnit:IsHasPromotion(TerroristPromo)==false or pUnit:IsHasPromotion(BrigandPromo)==true or pUnit:IsHasPromotion(PiratePromo)==true or pUnit:IsHasPromotion(RebelPromo)==true) then
            --print ("Terrorist Promotions")
            pUnit:SetHasPromotion(TerroristPromo,true);
            pUnit:SetHasPromotion(BrigandPromo,false);
            pUnit:SetHasPromotion(PiratePromo,false);
            pUnit:SetHasPromotion(RebelPromo,false);
        end
    end
end

--=======================================================================================================================
--=======================================================================================================================
-- Barbarian Name Change
--=======================================================================================================================
--=======================================================================================================================

function Leugi_BarbNameChange(eraID)
	-- print("Checking Leugi_BarbNameChange Era")
	if eraID>1 then
        adj = nil
        camp = nil
        if eraID == 2 then
            oldname = "Barbarians"
            adj = "Brigand";
            camp = "Encampment";
            --print ("Brigand days!")
        elseif eraID == 3 then
            oldname = "Brigands"
            adj = "Pirate";
            camp = "Encampment";
            --print ("Pirate days!")
        elseif eraID == 4 or eraID == 5 then
            oldname = "Pirates"
            adj = "Rebel";
            camp = "Base";
            --print ("Rebel days!")
        elseif eraID >= 6 then
            oldname = "Rebels"
            adj = "Terrorist";
            camp = "Base";
            --print ("Terrorist days!")
        end
        --print ("Barbarian precheck")
        if adj ~= nil then
            Leugi_BarbChangeStringsLow(adj, camp)
        end
    end
end


function Leugi_BarbChangeStringsLow(adj, camp)
    print("Changing Barbarian Strings (LOW)")
	-- Civname (Simply plural version of adjetive)
	plural = adj .. "s"
	name = "The " .. plural
	-- Plunder stuff
	plunder0 = "Filthy " .. plural .. "plundered the trade route you established between {1_CityName} and {2_CityName}.";
	plunder1 = plural .. " plundered the trade route {1_PlayerName} established between {2_CityName} and {3_CityName}";
	-- Encampment cleared
	clear0 = "You have dispersed a villainous " .. camp .. " and recovered {1_NumGold} [ICON_GOLD] Gold from it!";
	-- Civilian captured
	capture0 = "A civilian was captured by " .. plural
	capture1 = "{TXT_KEY_GRAMMAR_UPPER_A_AN &lt;&lt; {@1_UnitName}} was captured by " .. plural .. "! They will take it to their nearest " .. camp .. ". If you wish to recover your unit you will have to track it down!";
	-- Discovered
	discover = "A " .. camp .. " has been discovered! It will create " .. adj .. " units until dispersed!"
	discover2 = camp .. " discovered";
	-----------------
	-- Update Table
	-----------------
	local tquery = {"UPDATE Language_en_US SET Text = '".. adj .."' WHERE Tag = 'TXT_KEY_CIV_BARBARIAN_ADJECTIVE'",
			"UPDATE Language_en_US SET Text = '".. name .."' WHERE Tag = 'TXT_KEY_CIV_BARBARIAN_SHORT_DESC'",
			"UPDATE Language_en_US SET Text = '".. camp .."' WHERE Tag = 'TXT_KEY_IMPROVEMENT_ENCAMPMENT'",
			"UPDATE Language_en_US SET Text = '".. plunder0 .."' WHERE Tag = 'TXT_KEY_NOTIFICATION_TRADE_UNIT_PLUNDERED_TRADER_BARBARIAN'",
			"UPDATE Language_en_US SET Text = '".. discover .."' WHERE Tag = 'TXT_KEY_NOTIFICATION_FOUND_BARB_CAMP'",
			"UPDATE Language_en_US SET Text = '".. clear0 .."' WHERE Tag = 'TXT_KEY_MISC_DESTROYED_BARBARIAN_CAMP'" ,
			"UPDATE Language_en_US SET Text = '".. capture0 .."' WHERE Tag = 'TXT_KEY_UNIT_CAPTURED_BARBS'",
			"UPDATE Language_en_US SET Text = '".. capture1 .."' WHERE Tag = 'TXT_KEY_UNIT_CAPTURED_BARBS_DETAILED'",
			"UPDATE Language_en_US SET Text = '".. discover2 .."' WHERE Tag = 'TXT_KEY_NOTIFICATION_SUMMARY_FOUND_BARB_CAMP'"
			}
	for i, iQuery in pairs(tquery) do
		print ("Changing Barbarian Texts: " .. i .. "/" .. #tquery );
		for result in DB.Query(iQuery) do
		end
	end
	Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
	-- Hope
	-- UpdateBarbs()
	--
end


-- Methods for finding plots
-- whowards functions http://forums.civfanatics.com/showthread.php?t=474634
function PlotRingIterator(pPlot, r)
  local hex = ToHexFromGrid({x=pPlot:GetX(), y=pPlot:GetY()})
  local x, y = hex.x, hex.y
  local function north(x, y, r, i) return {x=x-r+i, y=y+r} end
  local function northeast(x, y, r, i) return {x=x+i, y=y+r-i} end
  local function southeast(x, y, r, i) return {x=x+r, y=y-i} end
  local function south(x, y, r, i) return {x=x+r-i, y=y-r} end
  local function southwest(x, y, r, i) return {x=x-i, y=y-r+i} end
  local function northwest(x, y, r, i) return {x=x-r, y=y+i} end
  local sides = {north, northeast, southeast, south, southwest, northwest}
  -- This coroutine walks the edges of the hex centered on pPlot at radius r
  local next = coroutine.create(function ()
    for _, side in ipairs(sides) do
      for i=0, r-1, 1 do
        coroutine.yield(side(x, y, r, i))
      end
    end
    return nil
  end)
  -- This function returns the next edge plot in the sequence, ignoring those that fall off the edges of the map
  return function ()
    local pEdgePlot = nil
    local _, hex = coroutine.resume(next)
    while (hex ~= nil and pEdgePlot == nil) do
      pEdgePlot = Map.GetPlot(ToGridFromHex(hex.x, hex.y))
      if (pEdgePlot == nil) then _, hex = coroutine.resume(next) end
    end
    return pEdgePlot
  end
end

-- Events -------------
-----------------------

function TrySpawnGeneral(pPlot)
    if pPlot~=nil and iOldEra>=1 and pPlot:HasBarbarianCamp() then -- just to be sure
        local numunits = pPlot:GetNumUnits()
        hasgeneral = false
        for iLoopUnits = 0, numunits - 1, 1 do
            local pLoopUnit = pPlot:GetUnit(iLoopUnits);
            if pLoopUnit~=nil and pLoopUnit:GetOwner() == iBarb then
                if pLoopUnit:GetUnitType() == iGeneralType or pLoopUnit:GetID() == iGeneralType then
                    hasgeneral = true
                end
            end
        end
        if hasgeneral==false then
            local rand = Map.Rand(GeneralSpawnChancePerBarbSpawn, "Random Possibility of General")
            if rand == 1 then
                -- print ("A BarbArian General was Born!")
                local pBarb = Players[iBarb]
                if pBarb~=nil and pBarb:IsBarbarian() then
                    local pGeneral = pBarb:InitUnit(iGeneralType, pPlot:GetX(), pPlot:GetY())
                end
                -- pGeneral:JumpToNearestValidPlot() -- for some reason this will put him out of the camp. so we dont call it, since the camp plot should be valid
            --else
                --print ("aww, no general")
            end
        end
    end
end

function DoPlotStuff(pPlot) -- only used without my custom dll, cause there is no other way to find the unit or camp plot most of the time
    if pPlot~=nil then
        -- print("BarbariansSpawnedUnit test edgeplot ",pPlot:GetX(), pPlot:GetY())
        local numunits = pPlot:GetNumUnits()
        local hasgeneral = false
        for iLoopUnits = 0, numunits - 1, 1 do
            local pUnit = pPlot:GetUnit(iLoopUnits);
            if pUnit~=nil and pUnit:GetOwner() == iBarb then
                if pUnit:GetUnitType() == iGeneralType or pUnit:GetID() == iGeneralType then
                    hasgeneral = true
                else
                    Leugi_BarbPromoChange(iOldEra,pUnit)
                end
            end
        end   
        if not hasgeneral and pPlot:HasBarbarianCamp() then -- everytime a unit spawns, there is also a chance for spawning a general, this way it also scales with raging barbarians
            -- print("camp with no general")
            local rand = Map.Rand(GeneralSpawnChancePerBarbSpawn, "Random Possibility of General")
            if rand == 1 then
                -- print ("A BarbArian General was Born!")
                local pBarb = Players[iBarb]
                if pBarb~=nil and pBarb:IsBarbarian() then
                    local pGeneral = pBarb:InitUnit(iGeneralType, pPlot:GetX(), pPlot:GetY())
                end
                -- pGeneral:JumpToNearestValidPlot() -- for some reason this will put him out of the camp. so we dont call it, since the camp plot should be valid
            --else
                --print ("aww, no general")
            end
        end
    end
end

GameEvents.BarbariansSpawnedUnit.Add(function(iPlotX, iPlotY, iUnitType, iUnit, CampX, CampY)
    -- print("BarbariansSpawnedUnit ",iPlotX,iPlotY,iUnitType) 
    if iOldEra>=1 then -- neither promos nor generals are active in first age
        if iUnit~=nil and CampX~=nil then -- only with my custom dll, I added the unit ID and camp plot. This way we dont have to check every single plot in 3 rang...
            local pBarb = Players[iBarb]
            if pBarb~=nil then
                local pUnit = pBarb:GetUnitByID(iUnit)
                local PlotCamp = Map.GetPlot(CampX, CampY)
                if pUnit~=nil then
                    Leugi_BarbPromoChange(iOldEra,pUnit)
                else
                    print("error: BarbariansSpawnedUnit but found no barb unit with ID ",iUnit)
                end
                TrySpawnGeneral(PlotCamp)
            end
        else -- dirty search for the unit, because often neither the camp nor the plot is where the unit spawns
            local pPlot = Map.GetPlot(iPlotX, iPlotY)
            if pPlot~=nil then
                DoPlotStuff(pPlot)
                for pEdgePlot in PlotRingIterator(pPlot, 1) do -- unfotunately pPlot is often neither the camp nor the plot where the unit spawns, but up to 3 tiles apart.
                    DoPlotStuff(pEdgePlot)
                end
                for pEdgePlot in PlotRingIterator(pPlot, 2) do -- unfotunately pPlot is often neither the camp nor the plot where the unit spawns, but up to 3 tiles apart.
                    DoPlotStuff(pEdgePlot)
                end
                for pEdgePlot in PlotRingIterator(pPlot, 3) do -- unfotunately pPlot is often neither the camp nor the plot where the unit spawns, but up to 3 tiles apart.
                    DoPlotStuff(pEdgePlot)
                end
            end
        end
    end
end)

-- GameEvents.PlayerDoneTurn.Add(Leugi_BarbarianGGandHeal)
-- GameEvents.PlayerDoTurn.Add(Leugi_BarbarianGGandHeal) -- heal is removed, promochange and general spawn is now done in BarbariansSpawnedUnit
GameEvents.UnitKilledInCombat.Add(GrantGeneralGold)

if settings_BarbarianNames == 1 or settings_BarbarianPromos == 1 then
    Leugi_CheckEra() -- do this bbefore anything else, so iOldEra is updated
end

if settings_BarbarianNames == 1 or settings_BarbarianPromos == 1 then
	print ("Barbarian Inmersion Era Changes Active")
	Events.SerialEventEraChanged.Add(Leugi_CheckEra)
end
