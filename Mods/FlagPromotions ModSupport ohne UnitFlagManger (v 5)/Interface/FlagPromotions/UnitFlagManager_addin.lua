-- UnitFlagManager_addin
-- Authors: Thalassicus, Erendir, Xienwolf, tothink
-- DateCreated: 1/23/2011 12:37:36 AM
--------------------------------------------------------------

include("ModTools.lua")
--local log = Events.LuaLogger:New()
--log:SetLevel("DEBUG")
--log:Info("Loading UnitFlagManager_addin.lua A")

--local ModID			= ModID --"44311931-9c7a-4f55-b465-7dc8d814e24d"
--local ModVersion		= ModVersion --Modding.GetActivatedModVersion(modID) or 1
--local ModUserData		= ModUserData --Modding.OpenUserData(modID, modVersion)
--local ignorePromotion	= assert(ignorePromotion, 'ModUserData.lua is not properly loaded')
local OFFSET_NORMAL		= Vector2(0,-28)
local OFFSET_STACK_1	= Vector2(0,0)
local OFFSET_STACK_2	= Vector2(0,-12)

-- Imported globals
local g_MasterList = g_MasterList
local g_UnitFlagClass = g_UnitFlagClass

g_UnitFlagClass.UpdatePromotionsOffset = g_UnitFlagClass.UpdatePromotionsOffset or function( self ) end

-- Shared locals
local bHideAllUnitIcons = false
local bDisplayAllFlagPromotions = true


function AddButton(control, tooltip, texture)
	local button = {}
	texture = texture or "Promotions128.dds"
	ContextPtr:BuildInstanceForControl("PromotionButtonInstance", button, control)
	
	if tooltip then
		tooltip = tostring(tooltip)
		if string.find(tooltip, "TXT_KEY") then
			button.Button:LocalizeAndSetToolTip(tooltip)
		else
			button.Button:SetToolTipString(tooltip)
		end
	else
		button.Button:SetToolTipString("")
	end
	return button
end


LuaEvents.ToggleHideUnitIcon.Add(
	function()
		bHideAllUnitIcons = not bHideAllUnitIcons	-- Modified by Erendir
	end)
	
g_UnitFlagClass.UpdateVisibility = function ( self )
	self.m_IsUnitIconDisplayed = self.m_IsCurrentlyVisible and not self.m_IsInvisible
    self.m_Instance.Anchor:SetHide(not self.m_IsUnitIconDisplayed)
	if InStrategicView() then
		self.m_IsUnitIconDisplayed = self.m_IsUnitIconDisplayed and g_GarrisonedUnitFlagsInStrategicView and self.m_IsGarrisoned
	else
		self.m_IsUnitIconDisplayed = self.m_IsUnitIconDisplayed and (self.m_IsGarrisoned or not bHideAllUnitIcons)
		if self.m_Escort then
			self.m_Escort.m_Instance.Anchor:SetHide(not self.m_IsUnitIconDisplayed)
		end
        if self.m_CargoControls ~= nil and self.m_IsUnitIconDisplayed then
        	self:UpdateCargo()
    	end
	end
    self.m_Instance.FlagShadow:SetHide(not self.m_IsUnitIconDisplayed)
	if (not bDisplayAllFlagPromotions) and self.m_Promotion then
		self:SetHideAllPromotions(true)
	end
	self:UpdatePromotions()
	--self:UpdatePromotionsOffset()
end


g_UnitFlagClass.IsFlagDisplayed = function( self )
	return self.m_IsUnitIconDisplayed
end

--log:Info("Loading UnitFlagManager_addin.lua B")

-- Options
local iPromotionsStackMax = 9

--[[
local unitPromotions, PromotionIDfromType = {}, {}
local PromotionIDlist = {}
for promo in GameInfo.UnitPromotions() do
	unitPromotions[#unitPromotions+1] = {Type=promo.Type, ID = promo.ID}
	PromotionIDfromType[promo.Type]=promo.ID -- map types to IDs
	PromotionIDlist[promo.ID]=true
end

local isPromotionwithlevels = {}
for _, promo in pairs(unitPromotions) do
	local promoType = promo.Type
	local name, suffix = string.match(promoType,'(.+)_([^_]+)$')
	if not string.find(suffix,'%D') then
		local id = promo.ID
		suffix = tonumber(suffix)
		isPromotionwithlevels[id]={Pclass=name, suffix=suffix} -- map id's to Promotion class and place in that class
	
		local t = isPromotionwithlevels[name] or {}
		t[suffix]=id  -- add id to the class list (referenced by number)
		isPromotionwithlevels[name] = t
	end
end
--]]

--[[
Currently a hardcoded 9 promo slots are available in 2 horizontal stacks of fixed size.
Ideally, the display would have horizontal and vertical stacks of adjustable size.
--]]

--log:Info("Loading UnitFlagManager_addin.lua C")

------------------------------------------------------------------
------------------------------------------------------------------
function g_UnitFlagClass.UpdatePromotions( self, promoType )
	local player = Players[self.m_PlayerID]
	local unit = player:GetUnitByID(self.m_UnitID)
	if not (unit and bDisplayAllFlagPromotions) then
		return
	end
	
	local iconPositionID	= 1
	local newPromotionID	= promoType and GameInfo.UnitPromotions[promoType].ID	
	local promos			= {}	
    local navalPromos       = {}			
    local navalPromo = false   
	for promo in GameInfo.UnitPromotions{IsVisibleAboveFlag = 1} do
		local promoID = promo.ID

			
		if unit:IsHasPromotion(promoID) or newPromotionID == promoID then
         
		 local showPromo = true

-----------------------------------------------------------------------------------------------------------------------		 
				for k,v in pairs(navalGroup) do 
					
						if promoID == v then

						

							showPromo = false
						    navalPromo = true
							table.insert(navalPromos, promoID)
							break
							else

							 showPromo = true
	

								if promo.RankList then
									-- hide promotion if the unit has a higher rank of that promotion (eg. hide Drill 1 if we have Drill 2)
										
									for nextPromo in GameInfo.UnitPromotions{RankList = promo.RankList, RankNumber = promo.RankNumber + 1} do
										if unit:IsHasPromotion(nextPromo.ID) or newPromotionID == nextPromo.ID then
											showPromo = false
											break
										end					
									end
								end				
					   end
				end			 
	    	

			
			if showPromo then
				table.insert(promos, promoID)
			end
		end		
	end						

  if navalPromo then
     -- print ("----------------------------Naval Promo found, sorting and merging tabels can start----------------------------------")
      table.sort(navalPromos)
	  local navalCount = #navalPromos  
	  --print (string.format("-------------%s navalCount in navalPromos Tabel--------------------", navalCount))
      local highNaval = navalPromos[navalCount] 
     -- print (string.format("------------%s highNaval höchste Naval Promo ID in table, ready to insert------------", highNaval))
      table.insert (promos,1, highNaval)
  end

  
	table.sort(promos, function(a, b)
		return GameInfo.UnitPromotions[a].OrderPriority > GameInfo.UnitPromotions[b].OrderPriority
	end)
	
	for iconPositionID = 1, iPromotionsStackMax do
		local button = self.m_Instance['Promotion'..iconPositionID]
		if promos[iconPositionID] then
			self:AddPromotionIcon(promos[iconPositionID], iconPositionID)
			button:SetHide(false)
		else
			button:SetHide(true)
		end
	end
	
	self.m_Instance.EarnedPromotionStack1:CalculateSize()
	self.m_Instance.EarnedPromotionStack1:ReprocessAnchoring()
	
	self.m_Instance.EarnedPromotionStack2:CalculateSize()
	self.m_Instance.EarnedPromotionStack2:ReprocessAnchoring()
end

function g_UnitFlagClass.AddPromotionIcon(self, promoID, iconPositionID)
	local button = self.m_Instance['Promotion'..iconPositionID]
	local promo = GameInfo.UnitPromotions[promoID]
	local player = Players[self.m_PlayerID]
	local unit = player:GetUnitByID(self.m_UnitID)
	IconHookup( promo.PortraitIndex, 16, promo.IconAtlas, button )
	
	local hoverText = ""
	if promo.SimpleHelpText then
		hoverText = Locale.ConvertTextKey(promo.Help)
	else
		hoverText = string.format("[COLOR_YELLOW]%s[ENDCOLOR][NEWLINE]%s",
			Locale.ConvertTextKey(promo.Description),
			Locale.ConvertTextKey(promo.Help)
		)
	end	
	
	
	
	
			if promo.RankList and promo.RankNumber > 69 then
		
																	--print ("------------ if navalpromo helptext function-------")
																	--print (string.format("-------------%s promo--------------------",promo.ID))

			for everyPromo in GameInfo.UnitPromotions{RankList = promo.RankList} do	
																	--print (string.format("-------------%s everyPromo.ID--------------------", everyPromo.ID))

				if unit:IsHasPromotion(everyPromo.ID) then
					
					if everyPromo.ID ~= promo.ID then
					
						   if everyPromo.SimpleHelpText then
																--	print("---------if simpleHelpText---------------")
								hoverText = string.format("%s[NEWLINE]%s",
									hoverText,
									Locale.ConvertTextKey(everyPromo.Help)
								)
							else
																--	print("---------else if simpleHelpText--------------")
								hoverText = string.format("%s[NEWLINE][COLOR_YELLOW]%s[ENDCOLOR][NEWLINE]%s",
									hoverText,
									Locale.ConvertTextKey(everyPromo.Description),
									Locale.ConvertTextKey(everyPromo.Help)
								)
							end	
					end
				end
			end
		end	
	
	
	
	
	
	if promo.RankList and promo.RankNumber < 70 then
		-- add earlier rank promotions to the tooltip (eg add Drill 1 if we have Drill 2)
		local rankNum = promo.RankNumber - 1
		while rankNum > 0 do
			for nextPromo in GameInfo.UnitPromotions{RankList = promo.RankList, RankNumber = rankNum} do
				if nextPromo.SimpleHelpText then
					hoverText = string.format("%s[NEWLINE]%s",
						hoverText,
						Locale.ConvertTextKey(nextPromo.Help)
					)
				else
					hoverText = string.format("%s[NEWLINE][COLOR_YELLOW]%s[ENDCOLOR][NEWLINE]%s",
						hoverText,
						Locale.ConvertTextKey(nextPromo.Description),
						Locale.ConvertTextKey(nextPromo.Help)
					)
				end
			end
			rankNum = rankNum - 1
		end
	end	
	
	
	button:SetToolTipString(hoverText)
end

--[[
g_UnitFlagClass.UpdatePromotions = function( self, promoType )
	local player = Players[self.m_PlayerID]
	local unit = player:GetUnitByID(self.m_UnitID)
	if not (unit and bDisplayAllFlagPromotions and self.m_Promotions) then
		return
	end
	
	--log:Debug("UpdatePromotions %15s %15s %15s", player:GetName(), GameInfo.Units[unit:GetUnitType()].Type, promoType)
	
	local iconPositionID	= 1
	local best_id			= {}
	local checked			= {}
	local newPromotionID	= promoType and GameInfo.UnitPromotions[promoType].ID
	if newPromotionID then
		--log:Debug("New  %15s %15s %s", Players[unit:GetOwner()]:GetName(), unit:GetName(), promoType)
	end
	for k,v in ipairs(self.m_Promotions) do
		v.IsVisible = false
	end
	for promo in GameInfo.UnitPromotions() do
		local promoID = promo.ID
		if not (ignorePromotion[promoID] or checked[promoID]) then
			self.m_Promotions[iconPositionID].IsVisible = true
			if not best_id[promoID] then
				----log:Trace("  Check         :: "..promo.Type)
				-- handle promotions with levels
				local Plvl = isPromotionwithlevels[promoID]
				if Plvl then -- is it one of them?
					----log:Trace("        Leveled :: "..promo.Type)
					local t_Pclass = isPromotionwithlevels[ Plvl.Pclass ] -- get the whole list
					-- find best promo
					local i = #t_Pclass
					local levelID = t_Pclass[i]
					while levelID and not (unit:IsHasPromotion(levelID) or newPromotionID == levelID) do
						checked[levelID]=true
						i=i-1
						levelID = t_Pclass[i]
					end
					if levelID then
						best_id[levelID]=i
					end
					self.m_Promotions[iconPositionID].IsVisible = (levelID==promoID)
					
					-- mark lower promotions also as checked
					i=i-1 levelID = t_Pclass[i] -- skip current, best one
					while levelID do
						checked[levelID] = true
						i = i - 1
						levelID = t_Pclass[i]
					end -- mark
				else
					----log:Trace("            Not :: "..promo.Type)
					self.m_Promotions[iconPositionID].IsVisible = unit:IsHasPromotion(promoID) or newPromotionID == promoID
				end
			end
			if self.m_Promotions[iconPositionID].IsVisible then
				if self.m_Promotions[iconPositionID].ID ~= promoID then
					--log:Trace("self.m_Instance['Promotion'.."..iconPositionID.."]:SetHide( false ) :: IconAtlas="..promo.IconAtlas.."  PortraitIndex="..promo.PortraitIndex)
					self.m_Promotions[iconPositionID].ID = promoID
					IconHookup( promo.PortraitIndex, 16, promo.IconAtlas, self.m_Instance['Promotion'..iconPositionID] )
					
					-- Tooltip
					local hoverText = ""
					if promo.SimpleHelpText then
						hoverText = Locale.ConvertTextKey(promo.Help)
					else
						hoverText = string.format("[COLOR_YELLOW]%s[ENDCOLOR][NEWLINE]%s",
							Locale.ConvertTextKey(promo.Description),
							Locale.ConvertTextKey(promo.Help)
						)
					end
					local best_pos = best_id[promoID]
					if best_pos and best_pos>1 then
						local t_Pclass = isPromotionwithlevels[ isPromotionwithlevels[promoID].Pclass ]
						-- local i = #t_Pclass
						-- local id = t_Pclass[i]
						-- while id and not (unit:IsHasPromotion(id) or (promoType and unit:IsHasPromotion(GameInfo.UnitPromotions[promoType].ID))) do checked[id]=true i=i-1 id = t_Pclass[i] end
					
						local ids = tostring(t_Pclass[1])
						for i = 2,best_pos-1 do
							ids = ids ..','.. t_Pclass[i]
						end
							-- hoverText = hoverText..'[COLOR_YELLOW]'..i..'[ENDCOLOR]'..'[NEWLINE]'
						ids = '('..ids..')'
						local sql = string.format("select Description, Help from UnitPromotions where ID in "..ids)
						for res in DB.Query(sql) do
							hoverText = hoverText..'[NEWLINE][COLOR_YELLOW]'..Locale.ConvertTextKey(res.Description)..'[ENDCOLOR]'..'[NEWLINE]'..Locale.ConvertTextKey(res.Help)
						end
					end
					self.m_Instance['Promotion'..iconPositionID]:SetToolTipString(hoverText)
				end
				
				iconPositionID = iconPositionID + 1
				if iconPositionID > iPromotionsStackMax then
					break -- stop the for cycle
				end
			end
		end
	end --for
	
	for k,v in ipairs(self.m_Promotions) do
		self.m_Instance['Promotion'..k]:SetHide(not v.IsVisible)
		if v.IsVisible then
			if GameInfo.UnitPromotions[v.ID] then
				--log:Debug("SHOW "..Players[unit:GetOwner()]:GetName().." "..unit:GetName().." "..GameInfo.UnitPromotions[v.ID].Type)
			else
				--log:Debug("SHOW "..Players[unit:GetOwner()]:GetName().." "..unit:GetName().." INVALID PROMOTION ID: "..v.ID)
			end
		else
			----log:Trace("hide "..Players[unit:GetOwner()]:GetName().." "..unit:GetName().." "..k)			
		end		
	end
	
	self.m_Instance.EarnedPromotionStack1:CalculateSize()
	self.m_Instance.EarnedPromotionStack1:ReprocessAnchoring()
	
	self.m_Instance.EarnedPromotionStack2:CalculateSize()
	self.m_Instance.EarnedPromotionStack2:ReprocessAnchoring()
end
--]]

--log:Info("Loading UnitFlagManager_addin.lua D")

function OnNewUnitRefresh( playerID, unitID, hexVec, unitType, cultureType, civID, primaryColor, secondaryColor, unitFlagIndex, fogState, selected, military, notInvisible )
	if playerID==nil then
        print("OnNewUnitRefresh playerID is nil")
        return
    end
    if unitID==nil then
        print("OnNewUnitRefresh unitID is nil")
        return
    end
    local flag = g_MasterList[playerID][unitID]
	if flag then
		flag:UpdatePromotions()
	else
		--log:Warn( string.format( "Flag not found for OnNewUnitRefresh: Player[%i] Unit[%i]", playerID, unitID ) )
	end
end
Events.SerialEventUnitCreated.Add( OnNewUnitRefresh )

--log:Info("Loading UnitFlagManager_addin.lua E")


g_UnitFlagClass.SetHideAllPromotions = function (self, isHidden)
	if isHidden then
		for k,v in ipairs(self.m_Promotions) do
			self.m_Instance['Promotion'..k]:SetHide(isHidden)
			v.IsVisible = false
		end
	end
end

--log:Info("Loading UnitFlagManager_addin.lua F")

--[[
local OldInitialize = g_UnitFlagClass.Initialize

g_UnitFlagClass.Initialize = function( o, playerID, unitID, fogState, invisible )
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	--log:Debug("Init %s %s", player:GetName(), unit:GetName())
	OldInitialize( o, playerID, unitID, fogState, invisible )
	
	o.m_IsUnitIconDisplayed = true
	o.m_Promotions = {} -- will store the list of displayed promotions
	for i = 1, iPromotionsStackMax do
		o.m_Promotions[i] = {}
	end
	--o:UpdatePromotions()
end
--]]

--log:Info("Loading UnitFlagManager_addin.lua G")

--[[
local OldUpdateFlagOffset = g_UnitFlagClass.UpdateFlagOffset

g_UnitFlagClass.UpdateFlagOffset = function( self )
	OldUpdateFlagOffset(self)
	self:UpdatePromotions()
	--self:UpdatePromotionsOffset()
end
--]]

g_UnitFlagClass.UpdatePromotionsOffset = function( self )
	local pUnit = Players[ self.m_PlayerID ]:GetUnitByID( self.m_UnitID )
	if pUnit == nil then
		return
	end	
	
	local plot = pUnit:GetPlot()
	
	if plot == nil then
		return
	end
	
	local offset = Vector2( 0, 0 )
	
	if pUnit:IsGarrisoned() then
		if( Game.GetActiveTeam() == Players[ self.m_PlayerID ]:GetTeam() ) then
			offset = VecAdd( offset, GarrisonOffset)
		else
			offset = VecAdd( offset, GarrisonOtherOffset)
		end
	elseif plot:IsCity() then
		offset = VecAdd( offset, CityNonGarrisonOffset)
	end
	
	
	if( self.m_CarrierFlag ~= nil ) then
		offset = VecAdd( offset, EscortOffset )
		self.m_CarrierFlag:UpdateFlagOffset( EscortOtherOffset )
            
	elseif self.m_Escort and not pUnit:IsGarrisoned() then
		if not self.m_IsCivilian and self.m_Escort.m_IsCivilian then
            offset = VecAdd( offset, EscortOffset )
		elseif self.m_IsCivilian and not self.m_Escort.m_IsCivilian then
            offset = VecAdd( offset, EscortOtherOffset )
		elseif self.m_UnitID < self.m_Escort.m_UnitID then
            offset = VecAdd( offset, EscortOffset )
		else
            offset = VecAdd( offset, EscortOtherOffset )
        end
    end
	
	if self.m_IsUnitIconDisplayed and not InStrategicView() then
		offset = VecAdd( offset, OFFSET_NORMAL)
	end
	
	-- set the ui offset
	self.m_Instance.EarnedPromotionStack1:SetOffset( VecAdd(offset, OFFSET_STACK_1) )
	self.m_Instance.EarnedPromotionStack2:SetOffset( VecAdd(offset, OFFSET_STACK_2) )
end



--log:Info("Loading UnitFlagManager_addin.lua H")

-- Independent Events

function OnPromotionEvent(unit, promoType)
	--log:Debug( "%15s %15s ActiveUnitRefreshFlag", unit, promoType )

	if not unit then
		return
	end
	local unitID	= unit:GetID() or -1
	local playerID	= unit:GetOwner()
	local player	= Players[ playerID ]
	if not player or not player:IsAlive() or unit:IsDead() then
		return
	end

	--log:Debug( "%s %s ActiveUnitRefreshFlag", unit:GetName(), player:GetName() )
	
	local flag = g_MasterList[playerID][unitID]
	if flag then
		flag:UpdatePromotions(promoType)
	else
		--log:Fatal( "Flag not found for PromotionEvent: Player[%i] Unit[%i]", playerID, unitID )
	end
end

LuaEvents.PromotionEarned.Add(OnPromotionEvent)
LuaEvents.UnitUpgraded.Add(OnPromotionEvent)
	
function RefreshUnitFlagPromotionsGlobally()
	for playerID,unitList in pairs(g_MasterList) do
		for unitID,flag in pairs(unitList) do
			if flag and flag:IsFlagDisplayed() then
				flag:UpdateVisibility()
			end
		end
	end
end

Events.ActivePlayerTurnStart.Add( RefreshUnitFlagPromotionsGlobally )

LuaEvents.ToggleDisplayFlagPromotions.Add(
	function(bIsChecked)
		bDisplayAllFlagPromotions = bIsChecked
		RefreshUnitFlagPromotionsGlobally()
	end)

LuaEvents.UpdateIgnoredFlagPromotions.Add( 
	function()
		--log:Info("OnUpdateIgnoredFlagPromotions"..tostring(bDisplayAllFlagPromotions))
		updateIgnoredPromotions()
		RefreshUnitFlagPromotionsGlobally()
	end)

---------------------------------------
-- End FlagPromotions v.2 by Erendir
---------------------------------------


--log:Info("Loading UnitFlagManager_addin.lua I")