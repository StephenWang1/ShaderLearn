--[[本文件为工具自动生成,禁止手动修改]]
local rechargeV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable rechargeV2.DayPayInfo
---@type rechargeV2.DayPayInfo
rechargeV2_adj.metatable_DayPayInfo = {
    _ClassName = "rechargeV2.DayPayInfo",
}
rechargeV2_adj.metatable_DayPayInfo.__index = rechargeV2_adj.metatable_DayPayInfo
--endregion

---@param tbl rechargeV2.DayPayInfo 待调整的table数据
function rechargeV2_adj.AdjustDayPayInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_DayPayInfo)
    if tbl.sequence == nil then
        tbl.sequenceSpecified = false
        tbl.sequence = 0
    else
        tbl.sequenceSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable rechargeV2.FistRewardInfo
---@type rechargeV2.FistRewardInfo
rechargeV2_adj.metatable_FistRewardInfo = {
    _ClassName = "rechargeV2.FistRewardInfo",
}
rechargeV2_adj.metatable_FistRewardInfo.__index = rechargeV2_adj.metatable_FistRewardInfo
--endregion

---@param tbl rechargeV2.FistRewardInfo 待调整的table数据
function rechargeV2_adj.AdjustFistRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_FistRewardInfo)
    if tbl.rechargeId == nil then
        tbl.rechargeIdSpecified = false
        tbl.rechargeId = 0
    else
        tbl.rechargeIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable rechargeV2.ThroughRechargeInfo
---@type rechargeV2.ThroughRechargeInfo
rechargeV2_adj.metatable_ThroughRechargeInfo = {
    _ClassName = "rechargeV2.ThroughRechargeInfo",
}
rechargeV2_adj.metatable_ThroughRechargeInfo.__index = rechargeV2_adj.metatable_ThroughRechargeInfo
--endregion

---@param tbl rechargeV2.ThroughRechargeInfo 待调整的table数据
function rechargeV2_adj.AdjustThroughRechargeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ThroughRechargeInfo)
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable rechargeV2.ResSendRechargeInfo
---@type rechargeV2.ResSendRechargeInfo
rechargeV2_adj.metatable_ResSendRechargeInfo = {
    _ClassName = "rechargeV2.ResSendRechargeInfo",
}
rechargeV2_adj.metatable_ResSendRechargeInfo.__index = rechargeV2_adj.metatable_ResSendRechargeInfo
--endregion

---@param tbl rechargeV2.ResSendRechargeInfo 待调整的table数据
function rechargeV2_adj.AdjustResSendRechargeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResSendRechargeInfo)
    if tbl.monthRechargeCount == nil then
        tbl.monthRechargeCountSpecified = false
        tbl.monthRechargeCount = 0
    else
        tbl.monthRechargeCountSpecified = true
    end
    if tbl.firstRechargeGetLevel == nil then
        tbl.firstRechargeGetLevelSpecified = false
        tbl.firstRechargeGetLevel = 0
    else
        tbl.firstRechargeGetLevelSpecified = true
    end
    if tbl.firstRechargeLastGetTime == nil then
        tbl.firstRechargeLastGetTimeSpecified = false
        tbl.firstRechargeLastGetTime = 0
    else
        tbl.firstRechargeLastGetTimeSpecified = true
    end
    if tbl.totalBonusRechargeCount == nil then
        tbl.totalBonusRechargeCountSpecified = false
        tbl.totalBonusRechargeCount = 0
    else
        tbl.totalBonusRechargeCountSpecified = true
    end
end

--region metatable rechargeV2.ReqFirstRechargeReward
---@type rechargeV2.ReqFirstRechargeReward
rechargeV2_adj.metatable_ReqFirstRechargeReward = {
    _ClassName = "rechargeV2.ReqFirstRechargeReward",
}
rechargeV2_adj.metatable_ReqFirstRechargeReward.__index = rechargeV2_adj.metatable_ReqFirstRechargeReward
--endregion

---@param tbl rechargeV2.ReqFirstRechargeReward 待调整的table数据
function rechargeV2_adj.AdjustReqFirstRechargeReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqFirstRechargeReward)
end

--region metatable rechargeV2.ResFirstRechargeInfo
---@type rechargeV2.ResFirstRechargeInfo
rechargeV2_adj.metatable_ResFirstRechargeInfo = {
    _ClassName = "rechargeV2.ResFirstRechargeInfo",
}
rechargeV2_adj.metatable_ResFirstRechargeInfo.__index = rechargeV2_adj.metatable_ResFirstRechargeInfo
--endregion

---@param tbl rechargeV2.ResFirstRechargeInfo 待调整的table数据
function rechargeV2_adj.AdjustResFirstRechargeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResFirstRechargeInfo)
    if tbl.rewardInfos == nil then
        tbl.rewardInfos = {}
    else
        if rechargeV2_adj.AdjustFistRewardInfo ~= nil then
            for i = 1, #tbl.rewardInfos do
                rechargeV2_adj.AdjustFistRewardInfo(tbl.rewardInfos[i])
            end
        end
    end
end

--region metatable rechargeV2.ReqGetDayRechargeReward
---@type rechargeV2.ReqGetDayRechargeReward
rechargeV2_adj.metatable_ReqGetDayRechargeReward = {
    _ClassName = "rechargeV2.ReqGetDayRechargeReward",
}
rechargeV2_adj.metatable_ReqGetDayRechargeReward.__index = rechargeV2_adj.metatable_ReqGetDayRechargeReward
--endregion

---@param tbl rechargeV2.ReqGetDayRechargeReward 待调整的table数据
function rechargeV2_adj.AdjustReqGetDayRechargeReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqGetDayRechargeReward)
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
end

--region metatable rechargeV2.ResDayRechargeInfo
---@type rechargeV2.ResDayRechargeInfo
rechargeV2_adj.metatable_ResDayRechargeInfo = {
    _ClassName = "rechargeV2.ResDayRechargeInfo",
}
rechargeV2_adj.metatable_ResDayRechargeInfo.__index = rechargeV2_adj.metatable_ResDayRechargeInfo
--endregion

---@param tbl rechargeV2.ResDayRechargeInfo 待调整的table数据
function rechargeV2_adj.AdjustResDayRechargeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResDayRechargeInfo)
    if tbl.infos == nil then
        tbl.infos = {}
    else
        if rechargeV2_adj.AdjustDayPayInfo ~= nil then
            for i = 1, #tbl.infos do
                rechargeV2_adj.AdjustDayPayInfo(tbl.infos[i])
            end
        end
    end
    if tbl.dayTotalRecharge == nil then
        tbl.dayTotalRechargeSpecified = false
        tbl.dayTotalRecharge = 0
    else
        tbl.dayTotalRechargeSpecified = true
    end
    if tbl.lifeTotalRecharge == nil then
        tbl.lifeTotalRechargeSpecified = false
        tbl.lifeTotalRecharge = 0
    else
        tbl.lifeTotalRechargeSpecified = true
    end
end

--region metatable rechargeV2.ResSendRechargeSurprise
---@type rechargeV2.ResSendRechargeSurprise
rechargeV2_adj.metatable_ResSendRechargeSurprise = {
    _ClassName = "rechargeV2.ResSendRechargeSurprise",
}
rechargeV2_adj.metatable_ResSendRechargeSurprise.__index = rechargeV2_adj.metatable_ResSendRechargeSurprise
--endregion

---@param tbl rechargeV2.ResSendRechargeSurprise 待调整的table数据
function rechargeV2_adj.AdjustResSendRechargeSurprise(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResSendRechargeSurprise)
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.autoPopup == nil then
        tbl.autoPopupSpecified = false
        tbl.autoPopup = 0
    else
        tbl.autoPopupSpecified = true
    end
end

--region metatable rechargeV2.ReqGetThroughRechargeReward
---@type rechargeV2.ReqGetThroughRechargeReward
rechargeV2_adj.metatable_ReqGetThroughRechargeReward = {
    _ClassName = "rechargeV2.ReqGetThroughRechargeReward",
}
rechargeV2_adj.metatable_ReqGetThroughRechargeReward.__index = rechargeV2_adj.metatable_ReqGetThroughRechargeReward
--endregion

---@param tbl rechargeV2.ReqGetThroughRechargeReward 待调整的table数据
function rechargeV2_adj.AdjustReqGetThroughRechargeReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqGetThroughRechargeReward)
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
end

--region metatable rechargeV2.ResSendThroughRecharge
---@type rechargeV2.ResSendThroughRecharge
rechargeV2_adj.metatable_ResSendThroughRecharge = {
    _ClassName = "rechargeV2.ResSendThroughRecharge",
}
rechargeV2_adj.metatable_ResSendThroughRecharge.__index = rechargeV2_adj.metatable_ResSendThroughRecharge
--endregion

---@param tbl rechargeV2.ResSendThroughRecharge 待调整的table数据
function rechargeV2_adj.AdjustResSendThroughRecharge(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResSendThroughRecharge)
    if tbl.throughInfo == nil then
        tbl.throughInfo = {}
    else
        if rechargeV2_adj.AdjustThroughRechargeInfo ~= nil then
            for i = 1, #tbl.throughInfo do
                rechargeV2_adj.AdjustThroughRechargeInfo(tbl.throughInfo[i])
            end
        end
    end
end

--region metatable rechargeV2.ReqGetBackRechargeReward
---@type rechargeV2.ReqGetBackRechargeReward
rechargeV2_adj.metatable_ReqGetBackRechargeReward = {
    _ClassName = "rechargeV2.ReqGetBackRechargeReward",
}
rechargeV2_adj.metatable_ReqGetBackRechargeReward.__index = rechargeV2_adj.metatable_ReqGetBackRechargeReward
--endregion

---@param tbl rechargeV2.ReqGetBackRechargeReward 待调整的table数据
function rechargeV2_adj.AdjustReqGetBackRechargeReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqGetBackRechargeReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable rechargeV2.ResBackRechargeInfo
---@type rechargeV2.ResBackRechargeInfo
rechargeV2_adj.metatable_ResBackRechargeInfo = {
    _ClassName = "rechargeV2.ResBackRechargeInfo",
}
rechargeV2_adj.metatable_ResBackRechargeInfo.__index = rechargeV2_adj.metatable_ResBackRechargeInfo
--endregion

---@param tbl rechargeV2.ResBackRechargeInfo 待调整的table数据
function rechargeV2_adj.AdjustResBackRechargeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResBackRechargeInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable rechargeV2.ReqRechargeEntrance
---@type rechargeV2.ReqRechargeEntrance
rechargeV2_adj.metatable_ReqRechargeEntrance = {
    _ClassName = "rechargeV2.ReqRechargeEntrance",
}
rechargeV2_adj.metatable_ReqRechargeEntrance.__index = rechargeV2_adj.metatable_ReqRechargeEntrance
--endregion

---@param tbl rechargeV2.ReqRechargeEntrance 待调整的table数据
function rechargeV2_adj.AdjustReqRechargeEntrance(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqRechargeEntrance)
end

--region metatable rechargeV2.ResLimitGiftBox
---@type rechargeV2.ResLimitGiftBox
rechargeV2_adj.metatable_ResLimitGiftBox = {
    _ClassName = "rechargeV2.ResLimitGiftBox",
}
rechargeV2_adj.metatable_ResLimitGiftBox.__index = rechargeV2_adj.metatable_ResLimitGiftBox
--endregion

---@param tbl rechargeV2.ResLimitGiftBox 待调整的table数据
function rechargeV2_adj.AdjustResLimitGiftBox(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResLimitGiftBox)
    if tbl.id == nil then
        tbl.id = {}
    end
    if tbl.isRemind == nil then
        tbl.isRemindSpecified = false
        tbl.isRemind = 0
    else
        tbl.isRemindSpecified = true
    end
end

--region metatable rechargeV2.ResCompleteFirstChargeTime
---@type rechargeV2.ResCompleteFirstChargeTime
rechargeV2_adj.metatable_ResCompleteFirstChargeTime = {
    _ClassName = "rechargeV2.ResCompleteFirstChargeTime",
}
rechargeV2_adj.metatable_ResCompleteFirstChargeTime.__index = rechargeV2_adj.metatable_ResCompleteFirstChargeTime
--endregion

---@param tbl rechargeV2.ResCompleteFirstChargeTime 待调整的table数据
function rechargeV2_adj.AdjustResCompleteFirstChargeTime(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResCompleteFirstChargeTime)
    if tbl.firstRechargeTime == nil then
        tbl.firstRechargeTimeSpecified = false
        tbl.firstRechargeTime = 0
    else
        tbl.firstRechargeTimeSpecified = true
    end
    if tbl.clickRedPointTime == nil then
        tbl.clickRedPointTimeSpecified = false
        tbl.clickRedPointTime = 0
    else
        tbl.clickRedPointTimeSpecified = true
    end
end

--region metatable rechargeV2.ReqGetInvestPlanRequest
---@type rechargeV2.ReqGetInvestPlanRequest
rechargeV2_adj.metatable_ReqGetInvestPlanRequest = {
    _ClassName = "rechargeV2.ReqGetInvestPlanRequest",
}
rechargeV2_adj.metatable_ReqGetInvestPlanRequest.__index = rechargeV2_adj.metatable_ReqGetInvestPlanRequest
--endregion

---@param tbl rechargeV2.ReqGetInvestPlanRequest 待调整的table数据
function rechargeV2_adj.AdjustReqGetInvestPlanRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqGetInvestPlanRequest)
    if tbl.investPhase == nil then
        tbl.investPhaseSpecified = false
        tbl.investPhase = 0
    else
        tbl.investPhaseSpecified = true
    end
end

--region metatable rechargeV2.ReqBuyInvestPlanRequest
---@type rechargeV2.ReqBuyInvestPlanRequest
rechargeV2_adj.metatable_ReqBuyInvestPlanRequest = {
    _ClassName = "rechargeV2.ReqBuyInvestPlanRequest",
}
rechargeV2_adj.metatable_ReqBuyInvestPlanRequest.__index = rechargeV2_adj.metatable_ReqBuyInvestPlanRequest
--endregion

---@param tbl rechargeV2.ReqBuyInvestPlanRequest 待调整的table数据
function rechargeV2_adj.AdjustReqBuyInvestPlanRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqBuyInvestPlanRequest)
    if tbl.investPhase == nil then
        tbl.investPhaseSpecified = false
        tbl.investPhase = 0
    else
        tbl.investPhaseSpecified = true
    end
end

--region metatable rechargeV2.ReqReceiveInvestRequest
---@type rechargeV2.ReqReceiveInvestRequest
rechargeV2_adj.metatable_ReqReceiveInvestRequest = {
    _ClassName = "rechargeV2.ReqReceiveInvestRequest",
}
rechargeV2_adj.metatable_ReqReceiveInvestRequest.__index = rechargeV2_adj.metatable_ReqReceiveInvestRequest
--endregion

---@param tbl rechargeV2.ReqReceiveInvestRequest 待调整的table数据
function rechargeV2_adj.AdjustReqReceiveInvestRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqReceiveInvestRequest)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable rechargeV2.Reward
---@type rechargeV2.Reward
rechargeV2_adj.metatable_Reward = {
    _ClassName = "rechargeV2.Reward",
}
rechargeV2_adj.metatable_Reward.__index = rechargeV2_adj.metatable_Reward
--endregion

---@param tbl rechargeV2.Reward 待调整的table数据
function rechargeV2_adj.AdjustReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_Reward)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable rechargeV2.RewardState
---@type rechargeV2.RewardState
rechargeV2_adj.metatable_RewardState = {
    _ClassName = "rechargeV2.RewardState",
}
rechargeV2_adj.metatable_RewardState.__index = rechargeV2_adj.metatable_RewardState
--endregion

---@param tbl rechargeV2.RewardState 待调整的table数据
function rechargeV2_adj.AdjustRewardState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_RewardState)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable rechargeV2.ResInvestPlanInfo
---@type rechargeV2.ResInvestPlanInfo
rechargeV2_adj.metatable_ResInvestPlanInfo = {
    _ClassName = "rechargeV2.ResInvestPlanInfo",
}
rechargeV2_adj.metatable_ResInvestPlanInfo.__index = rechargeV2_adj.metatable_ResInvestPlanInfo
--endregion

---@param tbl rechargeV2.ResInvestPlanInfo 待调整的table数据
function rechargeV2_adj.AdjustResInvestPlanInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResInvestPlanInfo)
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if rechargeV2_adj.AdjustReward ~= nil then
            for i = 1, #tbl.rewards do
                rechargeV2_adj.AdjustReward(tbl.rewards[i])
            end
        end
    end
    if tbl.isPurchased == nil then
        tbl.isPurchasedSpecified = false
        tbl.isPurchased = 0
    else
        tbl.isPurchasedSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable rechargeV2.ResInvestPlanData
---@type rechargeV2.ResInvestPlanData
rechargeV2_adj.metatable_ResInvestPlanData = {
    _ClassName = "rechargeV2.ResInvestPlanData",
}
rechargeV2_adj.metatable_ResInvestPlanData.__index = rechargeV2_adj.metatable_ResInvestPlanData
--endregion

---@param tbl rechargeV2.ResInvestPlanData 待调整的table数据
function rechargeV2_adj.AdjustResInvestPlanData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResInvestPlanData)
    if tbl.info == nil then
        tbl.info = {}
    else
        if rechargeV2_adj.AdjustResInvestPlanInfo ~= nil then
            for i = 1, #tbl.info do
                rechargeV2_adj.AdjustResInvestPlanInfo(tbl.info[i])
            end
        end
    end
end

--region metatable rechargeV2.FirstRechargeGive
---@type rechargeV2.FirstRechargeGive
rechargeV2_adj.metatable_FirstRechargeGive = {
    _ClassName = "rechargeV2.FirstRechargeGive",
}
rechargeV2_adj.metatable_FirstRechargeGive.__index = rechargeV2_adj.metatable_FirstRechargeGive
--endregion

---@param tbl rechargeV2.FirstRechargeGive 待调整的table数据
function rechargeV2_adj.AdjustFirstRechargeGive(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_FirstRechargeGive)
    if tbl.recivedId == nil then
        tbl.recivedId = {}
    end
end

--region metatable rechargeV2.ReqGetCumRechargeRequest
---@type rechargeV2.ReqGetCumRechargeRequest
rechargeV2_adj.metatable_ReqGetCumRechargeRequest = {
    _ClassName = "rechargeV2.ReqGetCumRechargeRequest",
}
rechargeV2_adj.metatable_ReqGetCumRechargeRequest.__index = rechargeV2_adj.metatable_ReqGetCumRechargeRequest
--endregion

---@param tbl rechargeV2.ReqGetCumRechargeRequest 待调整的table数据
function rechargeV2_adj.AdjustReqGetCumRechargeRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqGetCumRechargeRequest)
    if tbl.rechargePhase == nil then
        tbl.rechargePhaseSpecified = false
        tbl.rechargePhase = 0
    else
        tbl.rechargePhaseSpecified = true
    end
end

--region metatable rechargeV2.ReqReceiveCumRechargeRequest
---@type rechargeV2.ReqReceiveCumRechargeRequest
rechargeV2_adj.metatable_ReqReceiveCumRechargeRequest = {
    _ClassName = "rechargeV2.ReqReceiveCumRechargeRequest",
}
rechargeV2_adj.metatable_ReqReceiveCumRechargeRequest.__index = rechargeV2_adj.metatable_ReqReceiveCumRechargeRequest
--endregion

---@param tbl rechargeV2.ReqReceiveCumRechargeRequest 待调整的table数据
function rechargeV2_adj.AdjustReqReceiveCumRechargeRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqReceiveCumRechargeRequest)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable rechargeV2.ResCumChargeInfo
---@type rechargeV2.ResCumChargeInfo
rechargeV2_adj.metatable_ResCumChargeInfo = {
    _ClassName = "rechargeV2.ResCumChargeInfo",
}
rechargeV2_adj.metatable_ResCumChargeInfo.__index = rechargeV2_adj.metatable_ResCumChargeInfo
--endregion

---@param tbl rechargeV2.ResCumChargeInfo 待调整的table数据
function rechargeV2_adj.AdjustResCumChargeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResCumChargeInfo)
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if rechargeV2_adj.AdjustReward ~= nil then
            for i = 1, #tbl.rewards do
                rechargeV2_adj.AdjustReward(tbl.rewards[i])
            end
        end
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable rechargeV2.ResCumRechargeData
---@type rechargeV2.ResCumRechargeData
rechargeV2_adj.metatable_ResCumRechargeData = {
    _ClassName = "rechargeV2.ResCumRechargeData",
}
rechargeV2_adj.metatable_ResCumRechargeData.__index = rechargeV2_adj.metatable_ResCumRechargeData
--endregion

---@param tbl rechargeV2.ResCumRechargeData 待调整的table数据
function rechargeV2_adj.AdjustResCumRechargeData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResCumRechargeData)
    if tbl.info == nil then
        tbl.info = {}
    else
        if rechargeV2_adj.AdjustResCumChargeInfo ~= nil then
            for i = 1, #tbl.info do
                rechargeV2_adj.AdjustResCumChargeInfo(tbl.info[i])
            end
        end
    end
end

--region metatable rechargeV2.CumChargeOpen
---@type rechargeV2.CumChargeOpen
rechargeV2_adj.metatable_CumChargeOpen = {
    _ClassName = "rechargeV2.CumChargeOpen",
}
rechargeV2_adj.metatable_CumChargeOpen.__index = rechargeV2_adj.metatable_CumChargeOpen
--endregion

---@param tbl rechargeV2.CumChargeOpen 待调整的table数据
function rechargeV2_adj.AdjustCumChargeOpen(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_CumChargeOpen)
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable rechargeV2.ResFashionInvestInfo
---@type rechargeV2.ResFashionInvestInfo
rechargeV2_adj.metatable_ResFashionInvestInfo = {
    _ClassName = "rechargeV2.ResFashionInvestInfo",
}
rechargeV2_adj.metatable_ResFashionInvestInfo.__index = rechargeV2_adj.metatable_ResFashionInvestInfo
--endregion

---@param tbl rechargeV2.ResFashionInvestInfo 待调整的table数据
function rechargeV2_adj.AdjustResFashionInvestInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResFashionInvestInfo)
    if tbl.invest == nil then
        tbl.invest = {}
    else
        if rechargeV2_adj.AdjustResFashionInvest ~= nil then
            for i = 1, #tbl.invest do
                rechargeV2_adj.AdjustResFashionInvest(tbl.invest[i])
            end
        end
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable rechargeV2.ResFashionInvest
---@type rechargeV2.ResFashionInvest
rechargeV2_adj.metatable_ResFashionInvest = {
    _ClassName = "rechargeV2.ResFashionInvest",
}
rechargeV2_adj.metatable_ResFashionInvest.__index = rechargeV2_adj.metatable_ResFashionInvest
--endregion

---@param tbl rechargeV2.ResFashionInvest 待调整的table数据
function rechargeV2_adj.AdjustResFashionInvest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ResFashionInvest)
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if rechargeV2_adj.AdjustReward ~= nil then
            for i = 1, #tbl.rewards do
                rechargeV2_adj.AdjustReward(tbl.rewards[i])
            end
        end
    end
    if tbl.isOpen == nil then
        tbl.isOpenSpecified = false
        tbl.isOpen = 0
    else
        tbl.isOpenSpecified = true
    end
end

--region metatable rechargeV2.ReqActiveFashionInvest
---@type rechargeV2.ReqActiveFashionInvest
rechargeV2_adj.metatable_ReqActiveFashionInvest = {
    _ClassName = "rechargeV2.ReqActiveFashionInvest",
}
rechargeV2_adj.metatable_ReqActiveFashionInvest.__index = rechargeV2_adj.metatable_ReqActiveFashionInvest
--endregion

---@param tbl rechargeV2.ReqActiveFashionInvest 待调整的table数据
function rechargeV2_adj.AdjustReqActiveFashionInvest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqActiveFashionInvest)
    if tbl.investType == nil then
        tbl.investTypeSpecified = false
        tbl.investType = 0
    else
        tbl.investTypeSpecified = true
    end
end

--region metatable rechargeV2.ReqReceiveFashionInvest
---@type rechargeV2.ReqReceiveFashionInvest
rechargeV2_adj.metatable_ReqReceiveFashionInvest = {
    _ClassName = "rechargeV2.ReqReceiveFashionInvest",
}
rechargeV2_adj.metatable_ReqReceiveFashionInvest.__index = rechargeV2_adj.metatable_ReqReceiveFashionInvest
--endregion

---@param tbl rechargeV2.ReqReceiveFashionInvest 待调整的table数据
function rechargeV2_adj.AdjustReqReceiveFashionInvest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargeV2_adj.metatable_ReqReceiveFashionInvest)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

return rechargeV2_adj