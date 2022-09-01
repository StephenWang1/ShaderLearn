---前往地图并开启自动战斗
---@class LuaAsyncOperation_GoMapAndAutoFight:LuaAsyncOperationBase
local LuaAsyncOperation_GoMapAndAutoFight = {}

setmetatable(LuaAsyncOperation_GoMapAndAutoFight, luaclass.LuaAsyncOperationBase)

function LuaAsyncOperation_GoMapAndAutoFight:TryStartOperation(parameter)
    if(parameter==nil)then
        return false
    end
   local isact =  networkRequest.ReqDeliverByConfig(parameter)
    return isact
end

function LuaAsyncOperation_GoMapAndAutoFight:OnMainPlayerPositionSuddenlyChanged(positionChangeReason, x, y, isChangeMap)
    self:TryDoFollowingOperation()
end

function LuaAsyncOperation_GoMapAndAutoFight:TryDoFollowingOperation()
    if(not self:GetIsOn())then
        return
    end
    CS.CSAutoFightMgr.Instance:Toggle(true)
    self:Stop()
end

return LuaAsyncOperation_GoMapAndAutoFight