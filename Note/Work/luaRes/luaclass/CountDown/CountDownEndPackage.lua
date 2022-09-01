---@class CountDownEndPackage:luaobject 倒计时结束包
local CountDownEndPackage = {}

--region 数据
---@type table 服务器元数据
CountDownEndPackage.ServerTblData = nil
---@type number 结束时间
CountDownEndPackage.EndTime = nil
---@type number timeClock表id
CountDownEndPackage.TimeClockId = nil
---@type TABLE.cfg_time_clock
CountDownEndPackage.TimeClockTbl = nil
---@type boolean 解析状态
CountDownEndPackage.AnalysisState = nil
---@type LuaEnumCountDownEndType 倒计时数据来源
CountDownEndPackage.DataSource = nil
---@type number 提示倒计时时间
CountDownEndPackage.HintCountDownTime = nil
--endregion

--region 数据刷新
---解析服务器踢人消息
---@param countDownType LuaEnumCountDownEndType
---@param tblData activitiesV2.ResKickOutTime lua table类型消息数据
function CountDownEndPackage:AnalysisKickOutTime(countDownType,tblData)
    self.AnalysisState = false
    if tblData == nil or tblData.moduleType == nil or type(tblData.endTime) ~= 'number' then
        return
    end
    self.countDownType = countDownType
    self.ServerTblData = tblData
    self.EndTime = tblData.endTime * 1000
    self.TimeClockId = tblData.moduleType
    self.TimeClockTbl = clientTableManager.cfg_time_clockManager:TryGetValue(self.TimeClockId)
    if self.TimeClockTbl == nil then
        return
    end
    self.HintCountDownTime = self.EndTime - self.TimeClockTbl:GetTime() * 1000
    self.AnalysisState = true
end
--endregion

--region 查询
---是否需要推送提示倒计时
---@return boolean 是否需要推送提示倒计时
function CountDownEndPackage:CanPushHintCountDown()
    if self.pushHintState ~= true and self:GetHintCountDownRemainTime() <= 0 then
        return true
    end
    return false
end

---是否是过时的倒计时包
---@return boolean 是否是过时的倒计时包
function CountDownEndPackage:IsObsoletePackage()
    local remainTime = self:GetRemainTime()
    if remainTime <= 0 then
        return true
    end
    return false
end
--endregion

--region 获取
---获取提示倒计时剩余时间
---@return number
function CountDownEndPackage:GetHintCountDownRemainTime()
    local nowTime = CS.CSServerTime.Instance.TotalMillisecond
    return self.HintCountDownTime - nowTime
end

---获取剩余时间
---@return number 剩余时间时间戳
function CountDownEndPackage:GetRemainTime()
    local nowTime = CS.CSServerTime.Instance.TotalMillisecond
    if self.EndTime <= nowTime then
        return 0
    end
    return self.EndTime - nowTime
end

---获取剩余时间（剩余几秒）
---@return number 剩余时间秒
function CountDownEndPackage:GetRemainTimeSecond()
    local remainTimeSecond = self:GetRemainTime()
    return Utility.GetMaxIntPart(remainTimeSecond / 1000)
end
--endregion

--region 设置
---设置推送提示状态
---@param state boolean
function CountDownEndPackage:SetPushHintState(state)
    self.pushHintState = state
end
--endregion

return CountDownEndPackage