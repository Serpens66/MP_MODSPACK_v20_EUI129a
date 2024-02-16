print(" StratBuildingMalus lua") 
        
-- save a table with all buildings that require a ressource to be build
local resbuildings = {}
for tResources in GameInfo.Resources() do
	local iResourceLoop = tResources.ID;
    for tBuildings in GameInfo.Buildings() do
        local iBuildingLoop = tBuildings.ID;
        -- local iBuildingClass = tBuildings.BuildingClass;
        local numreq = Game.GetNumResourceRequiredForBuilding(iBuildingLoop,iResourceLoop)
        if numreq~=nil and numreq>0 then
            if resbuildings[iResourceLoop]==nil then
                resbuildings[iResourceLoop] = {}
            end
            resbuildings[iResourceLoop][iBuildingLoop] = numreq
        end
    end
end
        
function StartTurn(iPlayer)
	local pPlayer = Players[iPlayer]
    if pPlayer and pPlayer:IsAlive() and not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() then -- we dont care about city states..
        for iResource, tBuildingnumreq in pairs(resbuildings) do
            local numres = pPlayer:GetNumResourceAvailable(iResource,true) -- include import
            if numres<0 then -- only then there might be building missing the ress
                for pCity in pPlayer:Cities() do
                    for iBuilding, numreq in pairs(tBuildingnumreq) do
                        if pCity:IsHasBuilding(iBuilding) then
                            pCity:SetNumRealBuilding(iBuilding,0) -- will destroy the building
                            local prodneededfornew = pPlayer:GetBuildingProductionNeeded(iBuilding)
                            pCity:SetBuildingProduction(iBuilding,prodneededfornew) -- but you can rebuild it in 1 turn with no cost (but of course have to spend the ressource again)
                            if pPlayer:IsHuman() then
                                local strTitle = Locale.Lookup("TXT_KEY_STRATBUILD_TITLE");
                                local BuildingDescr = Locale.Lookup(GameInfo.Buildings[iBuilding].Description)
                                local ResourceDescr = Locale.Lookup(GameInfo.Resources[iResource].Description)
                                local strDescription = Locale.Lookup("TXT_KEY_STRATBUILD_DESCR", BuildingDescr, pCity:GetName(), ResourceDescr);
                                pPlayer:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE, strDescription, strTitle, pCity:GetX(), pCity:GetY(),iResource) -- a notification on the right
                            end
                            numres = numres + numreq -- will get >= 0 , which will make loop break
                            if numres>=0 then
                                break
                            end
                        end
                    end
                    if numres>=0 then
                        break
                    end
                end
            end
        end
    end
end
GameEvents.PlayerDoTurn.Add(StartTurn)
