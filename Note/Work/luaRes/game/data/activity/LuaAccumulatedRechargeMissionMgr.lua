---@class LuaAccumulatedRechargeMissionMgr:luaobject 累充计划任务数据
local LuaAccumulatedRechargeMissionMgr = {}

---获取活动字典<期数，活动信息>
---@return table<number,rechargeV2.ResCumChargeInfo>
function LuaAccumulatedRechargeMissionMgr:GetMissionDic()
    if self.mMissionDic == nil then
        self.mMissionDic = {}
    end
    return self.mMissionDic
end

---根据期数获得累充计划信息
---@return table<number,rechargeV2.ResCumChargeInfo>|nil
function LuaAccumulatedRechargeMissionMgr:GetMissionInfoByPeriod(num)
    return self:GetMissionDic()[num]
end

---设置所有期数的累充计划
---@param data rechargeV2.ResCumRechargeData
function LuaAccumulatedRechargeMissionMgr:SetAllMissionInfo(data)
    self.mMissionDic = {}
    if data.info == nil then
        return
    end
    for i = 1, #data.info do
        self:SetMissionInfoByPeriod(data.info[i])
    end
    if #data.info >= 1 then
        self.mCurrentState = data.info[1].rechargePhase
    end
    luaEventManager.DoCallback(LuaCEvent.RefreshRechargeBookMark)
end

---根据期数设置累充计划
---@param info rechargeV2.ResCumChargeInfo
function LuaAccumulatedRechargeMissionMgr:SetMissionInfoByPeriod(info)
    self:GetMissionDic()[info.rechargePhase] = info
end

---@return number 当前期数
function LuaAccumulatedRechargeMissionMgr:GetCurPeriod()
    if self.mCurrentState then
        return self.mCurrentState
    end
    return 1
end
--region 领取红点

---获取累充的领取状态
---@return number
function LuaAccumulatedRechargeMissionMgr:GetRewardState()
    if self.state == nil then
        self.state = 0
    end
    return self.state
end

---设置累充的领取状态
---@param state number 0为无 1为有
function LuaAccumulatedRechargeMissionMgr:SetRewardState(state)
    if self.state == state then
        return
    end
    self.state = state
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.AccumulatedRecharge)
    --luaEventManager.DoCallback(LuaCEvent.RefreshRechargeBookMark)
    luaEventManager.DoCallback(LuaCEvent.AccumulatedRechargeRedPointChange)
end

function LuaAccumulatedRechargeMissionMgr:IsShowRedPoint()
    return self.state == 1
end
--endregion

--region 活动开启

---获取累充的开启
---@return number
function LuaAccumulatedRechargeMissionMgr:GetOpenState()
    if self.openState == nil then
        self.openState = 0
    end
    return self.openState
end

---设置累充的领取状态
---@param state number 0为无 1为有
function LuaAccumulatedRechargeMissionMgr:SetOpenState(state)
    if self.openState == state then
        return
    end
    self.openState = state
    if state == 1 then
        ---请求累计充值活动数据
        networkRequest.ReqCumRechargeData()
    end
end
--endregion

---根据期数判断活动是否开启
function LuaAccumulatedRechargeMissionMgr:IsOpenActivityByPeriod(period)
    return true
end

---根据期数判断活动是否有效
---@return boolean
function LuaAccumulatedRechargeMissionMgr:IsShowBookMarkByPeriod(period)
    ---是否开启活动
    local isOpenActivity = self:GetOpenState() == 1
    ---是否有此期的合法活动
    local isHasActivityByPeriod = self:CheckMeetMissionByPeriod(period)
    return isOpenActivity and isHasActivityByPeriod
end

---判断有无合法的活动
---@return boolean
function LuaAccumulatedRechargeMissionMgr:CheckMeetMissionByPeriod(period)
    if self:GetMissionInfoByPeriod(period) == nil or self:GetMissionInfoByPeriod(period).rewards == nil then
        return false
    end
    return #self:GetMissionInfoByPeriod(period).rewards > 0
end

---连充红点判断
---@return boolean
function LuaAccumulatedRechargeMissionMgr:CheckRedPoint(bool)
    if bool ~= nil then
        self.bool = bool
        return
    end
    local condition = self:GetLuaTable()
    if self.bool == nil and condition == true then
        return true
    elseif self.bool == true and condition == true then
        return true
    else
        return false
    end
end

function LuaAccumulatedRechargeMissionMgr:GetLuaTable()
    local isOpen = false
    local noticeId = clientTableManager.cfg_noticeManager:TryGetValue(88)
    if noticeId then
        isOpen = Utility.IsNoticeOpenSystem(noticeId)
    end
    return isOpen
end

return LuaAccumulatedRechargeMissionMgr