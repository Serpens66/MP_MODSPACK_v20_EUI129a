print("This is the 'Goody Hut Bonus' mod script for Explorer_X policy")

-- this scripts gives additional goody hut bonuses if the player has the POLICY_EXPLORER_X

include("FLuaVector")

local iPolicy = GameInfoTypes.POLICY_EXPLORER_X 

local SpeedGold = (GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent / 100)
local SpeedCulture = (GameInfo.GameSpeeds[Game.GetGameSpeedType()].CulturePercent / 100)
local SpeedFaith = (GameInfo.GameSpeeds[Game.GetGameSpeedType()].FaithPercent / 100)
local SpeedGoldenAge = (GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldenAgePercent / 100)

-- needs my custom or whowards dll, with goody events enabled in CustomModOptions


local boni = {"CityTile","Productionboost","Foodboost","Culture","GoldBig","Faith","GoldAge","GoldSmall","GoldSmall","XP","XP","XP"}
-- local boni = {"Productionboost"} -- testing

function OnGoodyHutReceivedBonus(iPlayer, iUnit, eGoody, iX, iY)
    local pPlayer = Players[iPlayer];
    local pUnit = pPlayer:GetUnitByID(iUnit)
    if pPlayer~=nil and pUnit~=nil and pPlayer:HasPolicy(iPolicy) then
        local X,Y = iX or -1,iY or -1
        local bonus = boni[Map.Rand(#boni, "Random extra goodybonus")+1] -- pick a random bonus
        local descr, title = "Should be "..bonus.." if not there was a problem in script, maybe missing city?",Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_TITLE")
        print("ExplorerGoodyBonus: ",bonus)
        if bonus=="CityTile" or bonus=="Productionboost" or bonus=="Foodboost" then
            local playercities = {}
            for pcity in pPlayer:Cities() do
                if pcity~=nil then    
                    table.insert(playercities,pcity)
                end
            end
            if #playercities~=0 then -- if no city, no bonus
                local pCity = playercities[Map.Rand(#playercities, "Random City for goodybonus")+1] -- pick a random city of this player
                if pCity~=nil then    
                    local pCityID = pCity:GetID();
                    local sCityName = pCity:GetName()
                    if bonus=="CityTile" then
                        local plot = pCity:GetNextBuyablePlot();
                        if plot~=nil then
                            X,Y = plot:GetX(), plot:GetY()
                            local cost = pCity:GetBuyPlotCost(X,Y);
                            pPlayer:ChangeGold(cost) -- we give him the tile for free
                            Network.SendCityBuyPlot(pCityID, X,Y) -- buy plot
                            Network.SendUpdateCityCitizens( pCityID ) -- update citizens. guess to make them work this tile if better
                            local target_hex = ToHexFromGrid(Vector2(X,Y))
                            Events.GameplayFX(target_hex.x, target_hex.y, -1) -- light the plot
                            descr = Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_CITYTILE",sCityName)
                        end
                    elseif bonus=="Productionboost" then
                        -- print(pCity:GetCurrentProductionDifference())
                        local currentperturn = math.max(pCity:GetCurrentProductionDifference(),2) * (Map.Rand(3, "Random Prod goody")+1)
                        pCity:ChangeProduction(currentperturn)
                        X,Y = pCity:GetX(), pCity:GetY()
                        descr = Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_PRODBOOST",currentperturn,sCityName)
                    elseif bonus=="Foodboost" then
                        local currentperturn = math.max(pCity:FoodDifference(),2) * (Map.Rand(3, "Random Food goody")+1)
                        pCity:ChangeFood(currentperturn)
                        X,Y = pCity:GetX(), pCity:GetY()
                        descr = Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_FOODBOOST",currentperturn,sCityName)
                    end
                end
            end
        elseif bonus == "XP" then
            local XP = Map.Rand(5, "Random XP goody")+1 -- 1-5
            pUnit:ChangeExperience(XP)
            descr = Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_XP",XP)
        else
            local eratype = pPlayer:GetCurrentEra()+1
            if bonus == "Culture" then
                local amount = 5 + Map.Rand(8, "Random Culture goody")
                amount = math.ceil(amount * eratype * SpeedCulture) -- aufrunden
                pPlayer:ChangeJONSCulture(amount)
                descr = Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_CULTURE",amount)
            elseif bonus=="GoldBig" or bonus=="GoldSmall" then
                local amount = bonus=="GoldBig" and 30 or bonus=="GoldSmall" and 5
                amount = amount + Map.Rand(10, "Random Gold goody")
                amount = math.ceil(amount * eratype * SpeedGold) -- aufrunden
                pPlayer:ChangeGold(amount)
                descr = Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_GOLD",amount)
            elseif bonus == "GoldAge" then
                local amount = 5 + Map.Rand(11, "Random GoldAge goody")
                amount = math.ceil(amount * eratype * SpeedGoldenAge) -- aufrunden
                pPlayer:ChangeGoldenAgeProgressMeter(amount)
                descr = Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_GOLDAGE",amount)
            elseif bonus == "Faith" then
                local amount = 5 + Map.Rand(11, "Random Faith goody")
                amount = math.ceil(amount * eratype * SpeedFaith) -- aufrunden
                pPlayer:ChangeFaith(amount)
                descr = Locale.ConvertTextKey("TXT_KEY_EXPLORERGOODY_FAITH",amount)
            end
        
        end
        pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title ,X,Y)
        pPlayer:AddMessage(descr) -- from whowards DLL
    end
end

-- I added to my dll "GoodyHutReceivedBonus" event, so we will use this one instead now (only works if this event is included in dll (eg commnuity patch), otherwise use the code below (at least supported from whowards dll)
function OnGoodyHutCanNotReceive(iPlayer, iUnit, iGoody, bPick)
    if iGoody==1 then -- is called for every possible goody type (to test if receive is allowed)
        OnGoodyHutReceivedBonus(iPlayer, iUnit, eGoody)
    end
    return false
end

if GameEvents.GoodyHutReceivedBonus~=nil then -- only my or CP dll (but CP dll has no dummy policies)
    GameEvents.GoodyHutReceivedBonus.Add(OnGoodyHutReceivedBonus)
elseif GameEvents.GoodyHutCanNotReceive~=nil then -- my and whowrads dll, in case the GoodyHutReceivedBonus event does not exist
    GameEvents.GoodyHutCanNotReceive.Add(OnGoodyHutCanNotReceive)
else
    print("ERROR, no required event is available")
end

--- ###################################
--- give free scout unit (in xml it only works if we already have a captial.. and GameEvents.PlayerAdoptPolicy also does not work with GrantPolicy)
--- so we give free units in Randomize_Traits.lua now
--- ###################################
