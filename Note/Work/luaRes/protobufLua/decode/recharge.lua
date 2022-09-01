--[[本文件为工具自动生成,禁止手动修改]]
local rechargeV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData rechargeV2.DayPayInfo lua中的数据结构
---@return rechargeV2.DayPayInfo C#中的数据结构
function rechargeV2.DayPayInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.DayPayInfo()
    if decodedData.sequence ~= nil and decodedData.sequenceSpecified ~= false then
        data.sequence = decodedData.sequence
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData rechargeV2.FistRewardInfo lua中的数据结构
---@return rechargeV2.FistRewardInfo C#中的数据结构
function rechargeV2.FistRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.FistRewardInfo()
    if decodedData.rechargeId ~= nil and decodedData.rechargeIdSpecified ~= false then
        data.rechargeId = decodedData.rechargeId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData rechargeV2.ThroughRechargeInfo lua中的数据结构
---@return rechargeV2.ThroughRechargeInfo C#中的数据结构
function rechargeV2.ThroughRechargeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ThroughRechargeInfo()
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData rechargeV2.ResSendRechargeInfo lua中的数据结构
---@return rechargeV2.ResSendRechargeInfo C#中的数据结构
function rechargeV2.ResSendRechargeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResSendRechargeInfo()
    data.totalRechargeRewardTaken = decodedData.totalRechargeRewardTaken
    data.dailyRechargeCount = decodedData.dailyRechargeCount
    data.dailyRechargeRewardTakenCount = decodedData.dailyRechargeRewardTakenCount
    data.totalRechargeCount = decodedData.totalRechargeCount
    if decodedData.monthRechargeCount ~= nil and decodedData.monthRechargeCountSpecified ~= false then
        data.monthRechargeCount = decodedData.monthRechargeCount
    end
    if decodedData.firstRechargeGetLevel ~= nil and decodedData.firstRechargeGetLevelSpecified ~= false then
        data.firstRechargeGetLevel = decodedData.firstRechargeGetLevel
    end
    if decodedData.firstRechargeLastGetTime ~= nil and decodedData.firstRechargeLastGetTimeSpecified ~= false then
        data.firstRechargeLastGetTime = decodedData.firstRechargeLastGetTime
    end
    if decodedData.totalBonusRechargeCount ~= nil and decodedData.totalBonusRechargeCountSpecified ~= false then
        data.totalBonusRechargeCount = decodedData.totalBonusRechargeCount
    end
    data.firstRechargeReward = decodedData.firstRechargeReward
    data.firstRechargeRmb = decodedData.firstRechargeRmb
    return data
end

---@param decodedData rechargeV2.ReqFirstRechargeReward lua中的数据结构
---@return rechargeV2.ReqFirstRechargeReward C#中的数据结构
function rechargeV2.ReqFirstRechargeReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqFirstRechargeReward()
    data.index = decodedData.index
    return data
end

---@param decodedData rechargeV2.ResFirstRechargeInfo lua中的数据结构
---@return rechargeV2.ResFirstRechargeInfo C#中的数据结构
function rechargeV2.ResFirstRechargeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResFirstRechargeInfo()
    if decodedData.rewardInfos ~= nil and decodedData.rewardInfosSpecified ~= false then
        for i = 1, #decodedData.rewardInfos do
            data.rewardInfos:Add(rechargeV2.FistRewardInfo(decodedData.rewardInfos[i]))
        end
    end
    return data
end

---@param decodedData rechargeV2.ReqGetDayRechargeReward lua中的数据结构
---@return rechargeV2.ReqGetDayRechargeReward C#中的数据结构
function rechargeV2.ReqGetDayRechargeReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqGetDayRechargeReward()
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    return data
end

---@param decodedData rechargeV2.ResDayRechargeInfo lua中的数据结构
---@return rechargeV2.ResDayRechargeInfo C#中的数据结构
function rechargeV2.ResDayRechargeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResDayRechargeInfo()
    if decodedData.infos ~= nil and decodedData.infosSpecified ~= false then
        for i = 1, #decodedData.infos do
            data.infos:Add(rechargeV2.DayPayInfo(decodedData.infos[i]))
        end
    end
    if decodedData.dayTotalRecharge ~= nil and decodedData.dayTotalRechargeSpecified ~= false then
        data.dayTotalRecharge = decodedData.dayTotalRecharge
    end
    if decodedData.lifeTotalRecharge ~= nil and decodedData.lifeTotalRechargeSpecified ~= false then
        data.lifeTotalRecharge = decodedData.lifeTotalRecharge
    end
    return data
end

---@param decodedData rechargeV2.ResSendRechargeSurprise lua中的数据结构
---@return rechargeV2.ResSendRechargeSurprise C#中的数据结构
function rechargeV2.ResSendRechargeSurprise(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResSendRechargeSurprise()
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.autoPopup ~= nil and decodedData.autoPopupSpecified ~= false then
        data.autoPopup = decodedData.autoPopup
    end
    return data
end

---@param decodedData rechargeV2.ReqGetThroughRechargeReward lua中的数据结构
---@return rechargeV2.ReqGetThroughRechargeReward C#中的数据结构
function rechargeV2.ReqGetThroughRechargeReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqGetThroughRechargeReward()
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    return data
end

---@param decodedData rechargeV2.ResSendThroughRecharge lua中的数据结构
---@return rechargeV2.ResSendThroughRecharge C#中的数据结构
function rechargeV2.ResSendThroughRecharge(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResSendThroughRecharge()
    if decodedData.throughInfo ~= nil and decodedData.throughInfoSpecified ~= false then
        for i = 1, #decodedData.throughInfo do
            data.throughInfo:Add(rechargeV2.ThroughRechargeInfo(decodedData.throughInfo[i]))
        end
    end
    return data
end

---@param decodedData rechargeV2.ReqGetBackRechargeReward lua中的数据结构
---@return rechargeV2.ReqGetBackRechargeReward C#中的数据结构
function rechargeV2.ReqGetBackRechargeReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqGetBackRechargeReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData rechargeV2.ResBackRechargeInfo lua中的数据结构
---@return rechargeV2.ResBackRechargeInfo C#中的数据结构
function rechargeV2.ResBackRechargeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResBackRechargeInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData rechargeV2.ReqRechargeEntrance lua中的数据结构
---@return rechargeV2.ReqRechargeEntrance C#中的数据结构
function rechargeV2.ReqRechargeEntrance(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqRechargeEntrance()
    data.entrance = decodedData.entrance
    return data
end

---@param decodedData rechargeV2.ResLimitGiftBox lua中的数据结构
---@return rechargeV2.ResLimitGiftBox C#中的数据结构
function rechargeV2.ResLimitGiftBox(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResLimitGiftBox()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        for i = 1, #decodedData.id do
            data.id:Add(decodedData.id[i])
        end
    end
    if decodedData.isRemind ~= nil and decodedData.isRemindSpecified ~= false then
        data.isRemind = decodedData.isRemind
    end
    return data
end

---@param decodedData rechargeV2.ResCompleteFirstChargeTime lua中的数据结构
---@return rechargeV2.ResCompleteFirstChargeTime C#中的数据结构
function rechargeV2.ResCompleteFirstChargeTime(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResCompleteFirstChargeTime()
    if decodedData.firstRechargeTime ~= nil and decodedData.firstRechargeTimeSpecified ~= false then
        data.firstRechargeTime = decodedData.firstRechargeTime
    end
    if decodedData.clickRedPointTime ~= nil and decodedData.clickRedPointTimeSpecified ~= false then
        data.clickRedPointTime = decodedData.clickRedPointTime
    end
    return data
end

---@param decodedData rechargeV2.ReqGetInvestPlanRequest lua中的数据结构
---@return rechargeV2.ReqGetInvestPlanRequest C#中的数据结构
function rechargeV2.ReqGetInvestPlanRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqGetInvestPlanRequest()
    if decodedData.investPhase ~= nil and decodedData.investPhaseSpecified ~= false then
        data.investPhase = decodedData.investPhase
    end
    return data
end

---@param decodedData rechargeV2.ReqBuyInvestPlanRequest lua中的数据结构
---@return rechargeV2.ReqBuyInvestPlanRequest C#中的数据结构
function rechargeV2.ReqBuyInvestPlanRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqBuyInvestPlanRequest()
    if decodedData.investPhase ~= nil and decodedData.investPhaseSpecified ~= false then
        data.investPhase = decodedData.investPhase
    end
    return data
end

---@param decodedData rechargeV2.ReqReceiveInvestRequest lua中的数据结构
---@return rechargeV2.ReqReceiveInvestRequest C#中的数据结构
function rechargeV2.ReqReceiveInvestRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqReceiveInvestRequest()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData rechargeV2.Reward lua中的数据结构
---@return rechargeV2.Reward C#中的数据结构
function rechargeV2.Reward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.Reward()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData rechargeV2.RewardState lua中的数据结构
---@return rechargeV2.RewardState C#中的数据结构
function rechargeV2.RewardState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.RewardState()
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData rechargeV2.ResInvestPlanInfo lua中的数据结构
---@return rechargeV2.ResInvestPlanInfo C#中的数据结构
function rechargeV2.ResInvestPlanInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResInvestPlanInfo()
    data.investPhase = decodedData.investPhase
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(rechargeV2.Reward(decodedData.rewards[i]))
        end
    end
    if decodedData.isPurchased ~= nil and decodedData.isPurchasedSpecified ~= false then
        data.isPurchased = decodedData.isPurchased
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData rechargeV2.ResInvestPlanData lua中的数据结构
---@return rechargeV2.ResInvestPlanData C#中的数据结构
function rechargeV2.ResInvestPlanData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResInvestPlanData()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(rechargeV2.ResInvestPlanInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData rechargeV2.FirstRechargeGive lua中的数据结构
---@return rechargeV2.FirstRechargeGive C#中的数据结构
function rechargeV2.FirstRechargeGive(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.FirstRechargeGive()
    if decodedData.recivedId ~= nil and decodedData.recivedIdSpecified ~= false then
        for i = 1, #decodedData.recivedId do
            data.recivedId:Add(decodedData.recivedId[i])
        end
    end
    return data
end

---@param decodedData rechargeV2.ReqGetCumRechargeRequest lua中的数据结构
---@return rechargeV2.ReqGetCumRechargeRequest C#中的数据结构
function rechargeV2.ReqGetCumRechargeRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqGetCumRechargeRequest()
    if decodedData.rechargePhase ~= nil and decodedData.rechargePhaseSpecified ~= false then
        data.rechargePhase = decodedData.rechargePhase
    end
    return data
end

---@param decodedData rechargeV2.ReqReceiveCumRechargeRequest lua中的数据结构
---@return rechargeV2.ReqReceiveCumRechargeRequest C#中的数据结构
function rechargeV2.ReqReceiveCumRechargeRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqReceiveCumRechargeRequest()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData rechargeV2.ResCumChargeInfo lua中的数据结构
---@return rechargeV2.ResCumChargeInfo C#中的数据结构
function rechargeV2.ResCumChargeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResCumChargeInfo()
    data.rechargePhase = decodedData.rechargePhase
    data.amount = decodedData.amount
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(rechargeV2.Reward(decodedData.rewards[i]))
        end
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData rechargeV2.ResCumRechargeData lua中的数据结构
---@return rechargeV2.ResCumRechargeData C#中的数据结构
function rechargeV2.ResCumRechargeData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResCumRechargeData()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(rechargeV2.ResCumChargeInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData rechargeV2.CumChargeOpen lua中的数据结构
---@return rechargeV2.CumChargeOpen C#中的数据结构
function rechargeV2.CumChargeOpen(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.CumChargeOpen()
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData rechargeV2.ResFashionInvestInfo lua中的数据结构
---@return rechargeV2.ResFashionInvestInfo C#中的数据结构
function rechargeV2.ResFashionInvestInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResFashionInvestInfo()
    if decodedData.invest ~= nil and decodedData.investSpecified ~= false then
        for i = 1, #decodedData.invest do
            data.invest:Add(rechargeV2.ResFashionInvest(decodedData.invest[i]))
        end
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData rechargeV2.ResFashionInvest lua中的数据结构
---@return rechargeV2.ResFashionInvest C#中的数据结构
function rechargeV2.ResFashionInvest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ResFashionInvest()
    data.type = decodedData.type
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(rechargeV2.Reward(decodedData.rewards[i]))
        end
    end
    if decodedData.isOpen ~= nil and decodedData.isOpenSpecified ~= false then
        data.isOpen = decodedData.isOpen
    end
    return data
end

---@param decodedData rechargeV2.ReqActiveFashionInvest lua中的数据结构
---@return rechargeV2.ReqActiveFashionInvest C#中的数据结构
function rechargeV2.ReqActiveFashionInvest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqActiveFashionInvest()
    if decodedData.investType ~= nil and decodedData.investTypeSpecified ~= false then
        data.investType = decodedData.investType
    end
    return data
end

---@param decodedData rechargeV2.ReqReceiveFashionInvest lua中的数据结构
---@return rechargeV2.ReqReceiveFashionInvest C#中的数据结构
function rechargeV2.ReqReceiveFashionInvest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargeV2.ReqReceiveFashionInvest()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

return rechargeV2