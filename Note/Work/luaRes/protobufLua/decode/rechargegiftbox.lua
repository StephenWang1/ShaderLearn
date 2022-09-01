--[[本文件为工具自动生成,禁止手动修改]]
local rechargegiftboxV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData rechargegiftboxV2.RechargeGiftTimes lua中的数据结构
---@return rechargegiftboxV2.RechargeGiftTimes C#中的数据结构
function rechargegiftboxV2.RechargeGiftTimes(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.RechargeGiftTimes()
    data.id = decodedData.id
    if decodedData.totalBuyTimes ~= nil and decodedData.totalBuyTimesSpecified ~= false then
        data.totalBuyTimes = decodedData.totalBuyTimes
    end
    if decodedData.todayBuyTimes ~= nil and decodedData.todayBuyTimesSpecified ~= false then
        data.todayBuyTimes = decodedData.todayBuyTimes
    end
    if decodedData.rebateRewardGet ~= nil and decodedData.rebateRewardGetSpecified ~= false then
        data.rebateRewardGet = decodedData.rebateRewardGet
    end
    if decodedData.resetOpenServerDay ~= nil and decodedData.resetOpenServerDaySpecified ~= false then
        data.resetOpenServerDay = decodedData.resetOpenServerDay
    end
    return data
end

---@param decodedData rechargegiftboxV2.RechargeGiftBoxInfo lua中的数据结构
---@return rechargegiftboxV2.RechargeGiftBoxInfo C#中的数据结构
function rechargegiftboxV2.RechargeGiftBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.RechargeGiftBoxInfo()
    if decodedData.onlineGiftBoxInfo ~= nil and decodedData.onlineGiftBoxInfoSpecified ~= false then
        data.onlineGiftBoxInfo = rechargegiftboxV2.OnlineGiftBoxInfo(decodedData.onlineGiftBoxInfo)
    end
    if decodedData.totalRechargeGiftBoxInfo ~= nil and decodedData.totalRechargeGiftBoxInfoSpecified ~= false then
        data.totalRechargeGiftBoxInfo = rechargegiftboxV2.TotalRechargeGiftBoxInfo(decodedData.totalRechargeGiftBoxInfo)
    end
    if decodedData.shareGiftBoxInfo ~= nil and decodedData.shareGiftBoxInfoSpecified ~= false then
        data.shareGiftBoxInfo = rechargegiftboxV2.ShareGiftBoxInfo(decodedData.shareGiftBoxInfo)
    end
    if decodedData.buyTimes ~= nil and decodedData.buyTimesSpecified ~= false then
        for i = 1, #decodedData.buyTimes do
            data.buyTimes:Add(rechargegiftboxV2.RechargeGiftTimes(decodedData.buyTimes[i]))
        end
    end
    if decodedData.totalRechargeDiamondCount ~= nil and decodedData.totalRechargeDiamondCountSpecified ~= false then
        data.totalRechargeDiamondCount = decodedData.totalRechargeDiamondCount
    end
    if decodedData.continuousGiftBoxInfo ~= nil and decodedData.continuousGiftBoxInfoSpecified ~= false then
        data.continuousGiftBoxInfo = rechargegiftboxV2.ContinuousGiftBoxInfo(decodedData.continuousGiftBoxInfo)
    end
    if decodedData.dailyRechargeGiftBoxInfo ~= nil and decodedData.dailyRechargeGiftBoxInfoSpecified ~= false then
        data.dailyRechargeGiftBoxInfo = rechargegiftboxV2.DailyRechargeGiftBoxInfo(decodedData.dailyRechargeGiftBoxInfo)
    end
    return data
end

---@param decodedData rechargegiftboxV2.OnlineGiftBoxInfo lua中的数据结构
---@return rechargegiftboxV2.OnlineGiftBoxInfo C#中的数据结构
function rechargegiftboxV2.OnlineGiftBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.OnlineGiftBoxInfo()
    if decodedData.rewardInfo ~= nil and decodedData.rewardInfoSpecified ~= false then
        for i = 1, #decodedData.rewardInfo do
            data.rewardInfo:Add(rechargegiftboxV2.OnlineGiftBoxRewardInfo(decodedData.rewardInfo[i]))
        end
    end
    if decodedData.onlineTime ~= nil and decodedData.onlineTimeSpecified ~= false then
        data.onlineTime = decodedData.onlineTime
    end
    return data
end

---@param decodedData rechargegiftboxV2.OnlineGiftBoxRewardInfo lua中的数据结构
---@return rechargegiftboxV2.OnlineGiftBoxRewardInfo C#中的数据结构
function rechargegiftboxV2.OnlineGiftBoxRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.OnlineGiftBoxRewardInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.receive ~= nil and decodedData.receiveSpecified ~= false then
        data.receive = decodedData.receive
    end
    return data
end

---@param decodedData rechargegiftboxV2.TotalRechargeGiftBoxInfo lua中的数据结构
---@return rechargegiftboxV2.TotalRechargeGiftBoxInfo C#中的数据结构
function rechargegiftboxV2.TotalRechargeGiftBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.TotalRechargeGiftBoxInfo()
    if decodedData.TotalRechargeDataInfo ~= nil and decodedData.TotalRechargeDataInfoSpecified ~= false then
        for i = 1, #decodedData.TotalRechargeDataInfo do
            data.TotalRechargeDataInfo:Add(rechargegiftboxV2.TotalRechargeDataInfo(decodedData.TotalRechargeDataInfo[i]))
        end
    end
    return data
end

---@param decodedData rechargegiftboxV2.TotalRechargeDataInfo lua中的数据结构
---@return rechargegiftboxV2.TotalRechargeDataInfo C#中的数据结构
function rechargegiftboxV2.TotalRechargeDataInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.TotalRechargeDataInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData rechargegiftboxV2.RewardId lua中的数据结构
---@return rechargegiftboxV2.RewardId C#中的数据结构
function rechargegiftboxV2.RewardId(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.RewardId()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData rechargegiftboxV2.ShareGiftBoxInfo lua中的数据结构
---@return rechargegiftboxV2.ShareGiftBoxInfo C#中的数据结构
function rechargegiftboxV2.ShareGiftBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.ShareGiftBoxInfo()
    if decodedData.rewardInfo ~= nil and decodedData.rewardInfoSpecified ~= false then
        data.rewardInfo = rechargegiftboxV2.ShareGiftBoxRewardInfo(decodedData.rewardInfo)
    end
    if decodedData.shareTime ~= nil and decodedData.shareTimeSpecified ~= false then
        data.shareTime = decodedData.shareTime
    end
    return data
end

---@param decodedData rechargegiftboxV2.ShareGiftBoxRewardInfo lua中的数据结构
---@return rechargegiftboxV2.ShareGiftBoxRewardInfo C#中的数据结构
function rechargegiftboxV2.ShareGiftBoxRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.ShareGiftBoxRewardInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.receive ~= nil and decodedData.receiveSpecified ~= false then
        data.receive = decodedData.receive
    end
    return data
end

---@param decodedData rechargegiftboxV2.ContinuousGiftBoxInfo lua中的数据结构
---@return rechargegiftboxV2.ContinuousGiftBoxInfo C#中的数据结构
function rechargegiftboxV2.ContinuousGiftBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.ContinuousGiftBoxInfo()
    if decodedData.rewardInfo ~= nil and decodedData.rewardInfoSpecified ~= false then
        for i = 1, #decodedData.rewardInfo do
            data.rewardInfo:Add(rechargegiftboxV2.ContinuousGiftBoxRewardInfo(decodedData.rewardInfo[i]))
        end
    end
    if decodedData.nowGroup ~= nil and decodedData.nowGroupSpecified ~= false then
        data.nowGroup = decodedData.nowGroup
    end
    if decodedData.lastCompleteCfgId ~= nil and decodedData.lastCompleteCfgIdSpecified ~= false then
        data.lastCompleteCfgId = decodedData.lastCompleteCfgId
    end
    if decodedData.lastCompleteTime ~= nil and decodedData.lastCompleteTimeSpecified ~= false then
        data.lastCompleteTime = decodedData.lastCompleteTime
    end
    if decodedData.totalDay ~= nil and decodedData.totalDaySpecified ~= false then
        data.totalDay = decodedData.totalDay
    end
    return data
end

---@param decodedData rechargegiftboxV2.ContinuousGiftBoxRewardInfo lua中的数据结构
---@return rechargegiftboxV2.ContinuousGiftBoxRewardInfo C#中的数据结构
function rechargegiftboxV2.ContinuousGiftBoxRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.ContinuousGiftBoxRewardInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.receive ~= nil and decodedData.receiveSpecified ~= false then
        data.receive = decodedData.receive
    end
    return data
end

---@param decodedData rechargegiftboxV2.DailyRechargeGiftBoxInfo lua中的数据结构
---@return rechargegiftboxV2.DailyRechargeGiftBoxInfo C#中的数据结构
function rechargegiftboxV2.DailyRechargeGiftBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.DailyRechargeGiftBoxInfo()
    if decodedData.rewardInfo ~= nil and decodedData.rewardInfoSpecified ~= false then
        for i = 1, #decodedData.rewardInfo do
            data.rewardInfo:Add(rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo(decodedData.rewardInfo[i]))
        end
    end
    return data
end

---@param decodedData rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo lua中的数据结构
---@return rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo C#中的数据结构
function rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.status ~= nil and decodedData.statusSpecified ~= false then
        data.status = decodedData.status
    end
    if decodedData.remainRecharge ~= nil and decodedData.remainRechargeSpecified ~= false then
        data.remainRecharge = decodedData.remainRecharge
    end
    return data
end

---@param decodedData rechargegiftboxV2.CycleGiftBox lua中的数据结构
---@return rechargegiftboxV2.CycleGiftBox C#中的数据结构
function rechargegiftboxV2.CycleGiftBox(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.CycleGiftBox()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.refreshType ~= nil and decodedData.refreshTypeSpecified ~= false then
        data.refreshType = decodedData.refreshType
    end
    return data
end

---@param decodedData rechargegiftboxV2.ResRoleCycleGiftBoxInfo lua中的数据结构
---@return rechargegiftboxV2.ResRoleCycleGiftBoxInfo C#中的数据结构
function rechargegiftboxV2.ResRoleCycleGiftBoxInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.rechargegiftboxV2.ResRoleCycleGiftBoxInfo()
    if decodedData.giftBoxInfo ~= nil and decodedData.giftBoxInfoSpecified ~= false then
        for i = 1, #decodedData.giftBoxInfo do
            data.giftBoxInfo:Add(rechargegiftboxV2.CycleGiftBox(decodedData.giftBoxInfo[i]))
        end
    end
    if decodedData.nextRefreshTime ~= nil and decodedData.nextRefreshTimeSpecified ~= false then
        data.nextRefreshTime = decodedData.nextRefreshTime
    end
    if decodedData.lastBuyGroup ~= nil and decodedData.lastBuyGroupSpecified ~= false then
        data.lastBuyGroup = decodedData.lastBuyGroup
    end
    return data
end

return rechargegiftboxV2