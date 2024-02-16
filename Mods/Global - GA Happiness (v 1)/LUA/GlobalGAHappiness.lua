print("This is the 'Global - GA Happiness' mod script.")

function OnPlayerDoTurn(iPlayer)
  local pPlayer = Players[iPlayer]
  
  if (pPlayer:IsGoldenAge()) then
    pPlayer:ChangeGoldenAgeProgressMeter(pPlayer:GetExcessHappiness())
  end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurn) 

