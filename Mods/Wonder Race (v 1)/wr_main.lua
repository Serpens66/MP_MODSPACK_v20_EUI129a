print('***[ Wonder Race Loaded ]***')
local gWonderTable = {}

function tablecontains(t, element)
    if t == nil then return false end
    for _, value in pairs(t) do
        if value == element then
          return true
        end
    end
    return false
end

-- serps simplified code to only find out if someone else is currently building a wonder or not. 
-- no advanced information like who or how much turns or winning or loosing.
-- notification is sent every turn there is a wonder race

local function DoTurn( iPlayer )
    local pPlayer = Players[iPlayer]
    if pPlayer~=nil and not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() then
        gWonderTable[iPlayer] = {}
        for pCity in pPlayer:Cities() do
            if pCity~=nil then
                local building = pCity:GetProductionBuilding()
                local buildingInfo = GameInfo.Buildings[building]
                if buildingInfo then
                    local buildingClassInfo = GameInfo.BuildingClasses[buildingInfo.BuildingClass]
                    if buildingClassInfo.MaxGlobalInstances == 1 then	-- If construction project is a wonder
                        local wondername = Locale.ConvertTextKey(buildingInfo.Description)
                        table.insert(gWonderTable[iPlayer],wondername)
                        if pPlayer:IsHuman() then -- check if we should display a notification
                            local isarace = false
                            for iOtherPlayer,wonderlist in pairs(gWonderTable) do
                                if iPlayer~=iOtherPlayer then
                                    if tablecontains(wonderlist,wondername) then
                                        isarace = true
                                        break -- this is enough information, no need to know if more are building the same wonder
                                    end
                                end
                            end
                            if isarace then
                                local msg = Locale.ConvertTextKey("TXT_KEY_WONDER_RACE")
                                local tip = Locale.ConvertTextKey("TXT_KEY_WONDER_RACE_TIP", wondername)
                                pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_BEATEN, tip, msg, pCity:GetX(), pCity:GetY(), building)--, iPlayer) 
                            end
                        end
                    end
                end
            end
        end
    end
end

GameEvents.PlayerDoTurn.Add( DoTurn );