print("This is the Unique Policy Building mod script.")

-- do the one time influence boost from chancery here in lua, to make sure it is only given once per city, even if building was removed and rebuild. 

local iChancery = GameInfoTypes["BUILDING_TCS_CHANCERY"];
local boost = 1.5 -- 50% boost of current
-- print(iChancery)

local g_SaveData = Modding.OpenSaveData();

function OnBuildingFinished(iPlayer, iCity, iBuilding, bGold, bFaith)
    if iBuilding==iChancery then
        local pPlayer = Players[iPlayer]
        if pPlayer~=nil and pPlayer:IsAlive() and not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() and not g_SaveData.GetValue("ChanceryBoost"..tostring(iPlayer).."_"..tostring(iCity)) then
            for iMinor = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1, 1 do
                local pMinor = Players[iMinor]
                if pMinor~=nil and pMinor:IsMinorCiv() and not pMinor:IsBarbarian() then
                    -- local current = pMinor:GetMinorCivFriendshipWithMajor(iPlayer)
                    -- local change = math.max(current * boost,30) -- at least a boost of 30 influence
                    local change = 15 -- percentage is too overpowered
                    pMinor:ChangeMinorCivFriendshipWithMajor(iPlayer,change)
                    g_SaveData.SetValue("ChanceryBoost"..tostring(iPlayer).."_"..tostring(iCity), true); -- remember that also for savegame loading
                end
            end
        end
    end
end
GameEvents.CityConstructed.Add(OnBuildingFinished)

