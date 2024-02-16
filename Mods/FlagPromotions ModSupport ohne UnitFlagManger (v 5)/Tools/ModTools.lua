-- ModTools.lua
-- Author: Thalassicus
-- DateCreated: 2/6/2011 5:17:42 AM
--------------------------------------------------------------

if Game == nil then
	--print("WARN  Game is nil")
	return
end

--include("SaveUtils.lua")
MY_MOD_NAME = "Communitas"

--print("Init ModTools.lua")
--MapModData.Cep_ = {}
saveDB = Modding.OpenSaveData()

Cep = {}
for row in GameInfo.Cep() do
	Cep[row.Type] = row.Value
end






include("MT_Enums.lua")

--include("MT_ErrorHandler.lua")
--include("MT_LuaLogger.lua")
--include("MT_LoadSave.lua")
include("MT_Utils.lua")

include("MT_Unit.lua")


--local log = Events.LuaLogger:New()
--log:SetLevel("WARN")



if UI:IsLoadedGame() then
	--log:Warn("%-10s seconds loading EverAtWarWithHuman", Game.Round(os.clock() - startClockTime, 8))
end