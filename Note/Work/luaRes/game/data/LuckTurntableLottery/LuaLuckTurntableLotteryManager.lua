---@class LuaLuckTurntableLotteryManager:luaobject
local LuaLuckTurntableLotteryManager = {}

---@return activityV2.LuckTurntableInfo
function LuaLuckTurntableLotteryManager:GetLuckTurntableLotteryData()
    return self.mLuckTurntableLotteryData
end

---@return activityV2.LuckTurntableInfo
function LuaLuckTurntableLotteryManager:SetLuckTurntableLotteryData(data)
    self.mLuckTurntableLotteryData = data
end

---获取活动期间已经充值的金额
---@return number
function LuaLuckTurntableLotteryManager:GetLuckTurnRechargeRmb()
    if (self.mLuckTurntableLotteryData ~= nil) then
        return self.mLuckTurntableLotteryData.rechargeRmb
    end
    return 0
end

---获取活动期间已抽奖次数
---@return number
function LuaLuckTurntableLotteryManager:GetLuckTurnLotteryNum()
    if (self.mLuckTurntableLotteryData ~= nil) then
        return self.mLuckTurntableLotteryData.lotteryTimes
    end
    return 0
end

---已获取了奖励的格子
---@return table<number,number>
function LuaLuckTurntableLotteryManager:GetLuckTurnLotteryObtains()
    if (self.mLuckTurntableLotteryData ~= nil) then
        return self.mLuckTurntableLotteryData.obtains
    end
    return {}
end

---活动截止时间
---@return number
function LuaLuckTurntableLotteryManager:GetLuckTurnLotteryEndTime()
    if (self.mLuckTurntableLotteryData ~= nil) then
        return self.mLuckTurntableLotteryData.leftTime
    end
    return {}
end

function LuaLuckTurntableLotteryManager:GetNextLotteryIndex()
    if (self.mLuckTurntableLotteryData ~= nil) then
        return self.mLuckTurntableLotteryData.rewardIndex
    end
    return 0
end
return LuaLuckTurntableLotteryManager