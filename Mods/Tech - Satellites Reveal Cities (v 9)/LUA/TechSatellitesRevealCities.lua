print("This is the 'Tech - Satellites Reveal Cities' mod script.")

local iKeyholeId = GameInfoTypes.PROJECT_KEYHOLE_PROJECT

function revealCities(iPlayer)
  if iPlayer then
    local pPlayer = Players[iPlayer]
    if pPlayer then
      -- local iTeam = Game.GetActiveTeam() -- screw you :D
      local iTeam = pPlayer:GetTeam()
      local pTeam = Teams[iTeam]

      if (citiesVisible(pTeam)) then
        local iKeyhole = pTeam:GetProjectCount(iKeyholeId)
        for iCivPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do -- looping over civs and their cities is more efficient than looping over the whole map to find cities.
            local pCivPlayer = Players[iCivPlayer]
            if pCivPlayer~=nil and iCivPlayer~=iPlayer and pCivPlayer:IsEverAlive() and pCivPlayer:IsAlive() then
                local iCivTeam = pCivPlayer:GetTeam()
                local pCivTeam = Teams[iCivTeam]
                if iCivTeam~=iTeam then
                    for pCity in pCivPlayer:Cities() do
                        local pPlot = pCity:Plot()
                        if (iKeyhole > 0) then
                            revealCell(iTeam, pPlot)
                        else
                            revealPlot(iTeam, pPlot)
                        end
                    end
                end
            end
        end
        --[[
        for iPlotLoop = 0, Map.GetNumPlots()-1, 1 do
          local pPlot = Map.GetPlotByIndex(iPlotLoop)
          if (pPlot:IsCity()) then
            local pCity = pPlot:GetPlotCity()
            if (pCity:GetTeam() ~= iTeam) then
              if (iKeyhole > 0) then
                revealCell(iTeam, pPlot)
              else
                revealPlot(iTeam, pPlot)
              end
            end
          end
        end--]]
      end
    end
  end
end

function citiesVisible(pTeam)
  -- Could just do tech = GameInfo.Technologies["TECH_SATELLITES"]
  -- but that would exclude any alternative techs that may reveal the map
  for tech in GameInfo.Technologies() do
    if (tech.MapVisible and pTeam:IsHasTech(tech.ID)) then
      -- print("cities are visible")
      return true
    end
  end

  return false
end


function revealCell(iTeam, pPlot)
  directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST, DirectionTypes.DIRECTION_SOUTHEAST,
                DirectionTypes.DIRECTION_SOUTHWEST, DirectionTypes.DIRECTION_WEST, DirectionTypes.DIRECTION_NORTHWEST}

  -- Reveal the central plot
  revealPlot(iTeam, pPlot)

  -- Reveal the surrounding plots
  for loop, direction in ipairs(directions) do
    revealPlot(iTeam, Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction))
  end
end

function revealPlot(iTeam, pPlot)
  -- Don't reveal natural wonders more than once
  if pPlot~=nil and (pPlot:GetFeatureType() == -1 or not GameInfo.Features[pPlot:GetFeatureType()].NaturalWonder) then
    -- Following lines copied from the Live Tuner Map tab script
    if (pPlot:GetVisibilityCount(iTeam) > 0) then
      pPlot:ChangeVisibilityCount(iTeam, -1, -1, true)
    end

    pPlot:SetRevealed(iTeam, false)

    pPlot:ChangeVisibilityCount(iTeam, 1, -1, true)
    pPlot:SetRevealed(iTeam, true)
  end
end

function onActivePlayerTurnStart(iPlayer)
  revealCities(iPlayer)
end
-- Events.ActivePlayerTurnStart.Add(onActivePlayerTurnStart)  -- to not cause desync, we never should use "ActivePlayer" in any way (except in UI of course)! 
GameEvents.PlayerDoTurn.Add(onActivePlayerTurnStart)

