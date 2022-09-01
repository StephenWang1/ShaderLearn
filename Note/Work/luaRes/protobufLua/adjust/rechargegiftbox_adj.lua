--[[本文件为工具自动生成,禁止手动修改]]
local rechargegiftboxV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable rechargegiftboxV2.RechargeGiftTimes
---@type rechargegiftboxV2.RechargeGiftTimes
rechargegiftboxV2_adj.metatable_RechargeGiftTimes = {
    _ClassName = "rechargegiftboxV2.RechargeGiftTimes",
}
rechargegiftboxV2_adj.metatable_RechargeGiftTimes.__index = rechargegiftboxV2_adj.metatable_RechargeGiftTimes
--endregion

---@param tbl rechargegiftboxV2.RechargeGiftTimes 待调整的table数据
function rechargegiftboxV2_adj.AdjustRechargeGiftTimes(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_RechargeGiftTimes)
    if tbl.totalBuyTimes == nil then
        tbl.totalBuyTimesSpecified = false
        tbl.totalBuyTimes = 0
    else
        tbl.totalBuyTimesSpecified = true
    end
    if tbl.todayBuyTimes == nil then
        tbl.todayBuyTimesSpecified = false
        tbl.todayBuyTimes = 0
    else
        tbl.todayBuyTimesSpecified = true
    end
    if tbl.rebateRewardGet == nil then
        tbl.rebateRewardGetSpecified = false
        tbl.rebateRewardGet = false
    else
        tbl.rebateRewardGetSpecified = true
    end
    if tbl.resetOpenServerDay == nil then
        tbl.resetOpenServerDaySpecified = false
        tbl.resetOpenServerDay = false
    else
        tbl.resetOpenServerDaySpecified = true
    end
end

--region metatable rechargegiftboxV2.RechargeGiftBoxInfo
---@type rechargegiftboxV2.RechargeGiftBoxInfo
rechargegiftboxV2_adj.metatable_RechargeGiftBoxInfo = {
    _ClassName = "rechargegiftboxV2.RechargeGiftBoxInfo",
}
rechargegiftboxV2_adj.metatable_RechargeGiftBoxInfo.__index = rechargegiftboxV2_adj.metatable_RechargeGiftBoxInfo
--endregion

---@param tbl rechargegiftboxV2.RechargeGiftBoxInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustRechargeGiftBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_RechargeGiftBoxInfo)
    if tbl.onlineGiftBoxInfo == nil then
        tbl.onlineGiftBoxInfoSpecified = false
        tbl.onlineGiftBoxInfo = nil
    else
        if tbl.onlineGiftBoxInfoSpecified == nil then 
            tbl.onlineGiftBoxInfoSpecified = true
            if rechargegiftboxV2_adj.AdjustOnlineGiftBoxInfo ~= nil then
                rechargegiftboxV2_adj.AdjustOnlineGiftBoxInfo(tbl.onlineGiftBoxInfo)
            end
        end
    end
    if tbl.totalRechargeGiftBoxInfo == nil then
        tbl.totalRechargeGiftBoxInfoSpecified = false
        tbl.totalRechargeGiftBoxInfo = nil
    else
        if tbl.totalRechargeGiftBoxInfoSpecified == nil then 
            tbl.totalRechargeGiftBoxInfoSpecified = true
            if rechargegiftboxV2_adj.AdjustTotalRechargeGiftBoxInfo ~= nil then
                rechargegiftboxV2_adj.AdjustTotalRechargeGiftBoxInfo(tbl.totalRechargeGiftBoxInfo)
            end
        end
    end
    if tbl.shareGiftBoxInfo == nil then
        tbl.shareGiftBoxInfoSpecified = false
        tbl.shareGiftBoxInfo = nil
    else
        if tbl.shareGiftBoxInfoSpecified == nil then 
            tbl.shareGiftBoxInfoSpecified = true
            if rechargegiftboxV2_adj.AdjustShareGiftBoxInfo ~= nil then
                rechargegiftboxV2_adj.AdjustShareGiftBoxInfo(tbl.shareGiftBoxInfo)
            end
        end
    end
    if tbl.buyTimes == nil then
        tbl.buyTimes = {}
    else
        if rechargegiftboxV2_adj.AdjustRechargeGiftTimes ~= nil then
            for i = 1, #tbl.buyTimes do
                rechargegiftboxV2_adj.AdjustRechargeGiftTimes(tbl.buyTimes[i])
            end
        end
    end
    if tbl.totalRechargeDiamondCount == nil then
        tbl.totalRechargeDiamondCountSpecified = false
        tbl.totalRechargeDiamondCount = 0
    else
        tbl.totalRechargeDiamondCountSpecified = true
    end
    if tbl.continuousGiftBoxInfo == nil then
        tbl.continuousGiftBoxInfoSpecified = false
        tbl.continuousGiftBoxInfo = nil
    else
        if tbl.continuousGiftBoxInfoSpecified == nil then 
            tbl.continuousGiftBoxInfoSpecified = true
            if rechargegiftboxV2_adj.AdjustContinuousGiftBoxInfo ~= nil then
                rechargegiftboxV2_adj.AdjustContinuousGiftBoxInfo(tbl.continuousGiftBoxInfo)
            end
        end
    end
    if tbl.dailyRechargeGiftBoxInfo == nil then
        tbl.dailyRechargeGiftBoxInfoSpecified = false
        tbl.dailyRechargeGiftBoxInfo = nil
    else
        if tbl.dailyRechargeGiftBoxInfoSpecified == nil then 
            tbl.dailyRechargeGiftBoxInfoSpecified = true
            if rechargegiftboxV2_adj.AdjustDailyRechargeGiftBoxInfo ~= nil then
                rechargegiftboxV2_adj.AdjustDailyRechargeGiftBoxInfo(tbl.dailyRechargeGiftBoxInfo)
            end
        end
    end
end

--region metatable rechargegiftboxV2.OnlineGiftBoxInfo
---@type rechargegiftboxV2.OnlineGiftBoxInfo
rechargegiftboxV2_adj.metatable_OnlineGiftBoxInfo = {
    _ClassName = "rechargegiftboxV2.OnlineGiftBoxInfo",
}
rechargegiftboxV2_adj.metatable_OnlineGiftBoxInfo.__index = rechargegiftboxV2_adj.metatable_OnlineGiftBoxInfo
--endregion

---@param tbl rechargegiftboxV2.OnlineGiftBoxInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustOnlineGiftBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_OnlineGiftBoxInfo)
    if tbl.rewardInfo == nil then
        tbl.rewardInfo = {}
    else
        if rechargegiftboxV2_adj.AdjustOnlineGiftBoxRewardInfo ~= nil then
            for i = 1, #tbl.rewardInfo do
                rechargegiftboxV2_adj.AdjustOnlineGiftBoxRewardInfo(tbl.rewardInfo[i])
            end
        end
    end
    if tbl.onlineTime == nil then
        tbl.onlineTimeSpecified = false
        tbl.onlineTime = 0
    else
        tbl.onlineTimeSpecified = true
    end
end

--region metatable rechargegiftboxV2.OnlineGiftBoxRewardInfo
---@type rechargegiftboxV2.OnlineGiftBoxRewardInfo
rechargegiftboxV2_adj.metatable_OnlineGiftBoxRewardInfo = {
    _ClassName = "rechargegiftboxV2.OnlineGiftBoxRewardInfo",
}
rechargegiftboxV2_adj.metatable_OnlineGiftBoxRewardInfo.__index = rechargegiftboxV2_adj.metatable_OnlineGiftBoxRewardInfo
--endregion

---@param tbl rechargegiftboxV2.OnlineGiftBoxRewardInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustOnlineGiftBoxRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_OnlineGiftBoxRewardInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.receive == nil then
        tbl.receiveSpecified = false
        tbl.receive = 0
    else
        tbl.receiveSpecified = true
    end
end

--region metatable rechargegiftboxV2.TotalRechargeGiftBoxInfo
---@type rechargegiftboxV2.TotalRechargeGiftBoxInfo
rechargegiftboxV2_adj.metatable_TotalRechargeGiftBoxInfo = {
    _ClassName = "rechargegiftboxV2.TotalRechargeGiftBoxInfo",
}
rechargegiftboxV2_adj.metatable_TotalRechargeGiftBoxInfo.__index = rechargegiftboxV2_adj.metatable_TotalRechargeGiftBoxInfo
--endregion

---@param tbl rechargegiftboxV2.TotalRechargeGiftBoxInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustTotalRechargeGiftBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_TotalRechargeGiftBoxInfo)
    if tbl.TotalRechargeDataInfo == nil then
        tbl.TotalRechargeDataInfo = {}
    else
        if rechargegiftboxV2_adj.AdjustTotalRechargeDataInfo ~= nil then
            for i = 1, #tbl.TotalRechargeDataInfo do
                rechargegiftboxV2_adj.AdjustTotalRechargeDataInfo(tbl.TotalRechargeDataInfo[i])
            end
        end
    end
end

--region metatable rechargegiftboxV2.TotalRechargeDataInfo
---@type rechargegiftboxV2.TotalRechargeDataInfo
rechargegiftboxV2_adj.metatable_TotalRechargeDataInfo = {
    _ClassName = "rechargegiftboxV2.TotalRechargeDataInfo",
}
rechargegiftboxV2_adj.metatable_TotalRechargeDataInfo.__index = rechargegiftboxV2_adj.metatable_TotalRechargeDataInfo
--endregion

---@param tbl rechargegiftboxV2.TotalRechargeDataInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustTotalRechargeDataInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_TotalRechargeDataInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable rechargegiftboxV2.RewardId
---@type rechargegiftboxV2.RewardId
rechargegiftboxV2_adj.metatable_RewardId = {
    _ClassName = "rechargegiftboxV2.RewardId",
}
rechargegiftboxV2_adj.metatable_RewardId.__index = rechargegiftboxV2_adj.metatable_RewardId
--endregion

---@param tbl rechargegiftboxV2.RewardId 待调整的table数据
function rechargegiftboxV2_adj.AdjustRewardId(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_RewardId)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable rechargegiftboxV2.ShareGiftBoxInfo
---@type rechargegiftboxV2.ShareGiftBoxInfo
rechargegiftboxV2_adj.metatable_ShareGiftBoxInfo = {
    _ClassName = "rechargegiftboxV2.ShareGiftBoxInfo",
}
rechargegiftboxV2_adj.metatable_ShareGiftBoxInfo.__index = rechargegiftboxV2_adj.metatable_ShareGiftBoxInfo
--endregion

---@param tbl rechargegiftboxV2.ShareGiftBoxInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustShareGiftBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_ShareGiftBoxInfo)
    if tbl.rewardInfo == nil then
        tbl.rewardInfoSpecified = false
        tbl.rewardInfo = nil
    else
        if tbl.rewardInfoSpecified == nil then 
            tbl.rewardInfoSpecified = true
            if rechargegiftboxV2_adj.AdjustShareGiftBoxRewardInfo ~= nil then
                rechargegiftboxV2_adj.AdjustShareGiftBoxRewardInfo(tbl.rewardInfo)
            end
        end
    end
    if tbl.shareTime == nil then
        tbl.shareTimeSpecified = false
        tbl.shareTime = 0
    else
        tbl.shareTimeSpecified = true
    end
end

--region metatable rechargegiftboxV2.ShareGiftBoxRewardInfo
---@type rechargegiftboxV2.ShareGiftBoxRewardInfo
rechargegiftboxV2_adj.metatable_ShareGiftBoxRewardInfo = {
    _ClassName = "rechargegiftboxV2.ShareGiftBoxRewardInfo",
}
rechargegiftboxV2_adj.metatable_ShareGiftBoxRewardInfo.__index = rechargegiftboxV2_adj.metatable_ShareGiftBoxRewardInfo
--endregion

---@param tbl rechargegiftboxV2.ShareGiftBoxRewardInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustShareGiftBoxRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_ShareGiftBoxRewardInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.receive == nil then
        tbl.receiveSpecified = false
        tbl.receive = 0
    else
        tbl.receiveSpecified = true
    end
end

--region metatable rechargegiftboxV2.ContinuousGiftBoxInfo
---@type rechargegiftboxV2.ContinuousGiftBoxInfo
rechargegiftboxV2_adj.metatable_ContinuousGiftBoxInfo = {
    _ClassName = "rechargegiftboxV2.ContinuousGiftBoxInfo",
}
rechargegiftboxV2_adj.metatable_ContinuousGiftBoxInfo.__index = rechargegiftboxV2_adj.metatable_ContinuousGiftBoxInfo
--endregion

---@param tbl rechargegiftboxV2.ContinuousGiftBoxInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustContinuousGiftBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_ContinuousGiftBoxInfo)
    if tbl.rewardInfo == nil then
        tbl.rewardInfo = {}
    else
        if rechargegiftboxV2_adj.AdjustContinuousGiftBoxRewardInfo ~= nil then
            for i = 1, #tbl.rewardInfo do
                rechargegiftboxV2_adj.AdjustContinuousGiftBoxRewardInfo(tbl.rewardInfo[i])
            end
        end
    end
    if tbl.nowGroup == nil then
        tbl.nowGroupSpecified = false
        tbl.nowGroup = 0
    else
        tbl.nowGroupSpecified = true
    end
    if tbl.lastCompleteCfgId == nil then
        tbl.lastCompleteCfgIdSpecified = false
        tbl.lastCompleteCfgId = 0
    else
        tbl.lastCompleteCfgIdSpecified = true
    end
    if tbl.lastCompleteTime == nil then
        tbl.lastCompleteTimeSpecified = false
        tbl.lastCompleteTime = 0
    else
        tbl.lastCompleteTimeSpecified = true
    end
    if tbl.totalDay == nil then
        tbl.totalDaySpecified = false
        tbl.totalDay = 0
    else
        tbl.totalDaySpecified = true
    end
end

--region metatable rechargegiftboxV2.ContinuousGiftBoxRewardInfo
---@type rechargegiftboxV2.ContinuousGiftBoxRewardInfo
rechargegiftboxV2_adj.metatable_ContinuousGiftBoxRewardInfo = {
    _ClassName = "rechargegiftboxV2.ContinuousGiftBoxRewardInfo",
}
rechargegiftboxV2_adj.metatable_ContinuousGiftBoxRewardInfo.__index = rechargegiftboxV2_adj.metatable_ContinuousGiftBoxRewardInfo
--endregion

---@param tbl rechargegiftboxV2.ContinuousGiftBoxRewardInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustContinuousGiftBoxRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_ContinuousGiftBoxRewardInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.receive == nil then
        tbl.receiveSpecified = false
        tbl.receive = 0
    else
        tbl.receiveSpecified = true
    end
end

--region metatable rechargegiftboxV2.DailyRechargeGiftBoxInfo
---@type rechargegiftboxV2.DailyRechargeGiftBoxInfo
rechargegiftboxV2_adj.metatable_DailyRechargeGiftBoxInfo = {
    _ClassName = "rechargegiftboxV2.DailyRechargeGiftBoxInfo",
}
rechargegiftboxV2_adj.metatable_DailyRechargeGiftBoxInfo.__index = rechargegiftboxV2_adj.metatable_DailyRechargeGiftBoxInfo
--endregion

---@param tbl rechargegiftboxV2.DailyRechargeGiftBoxInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustDailyRechargeGiftBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_DailyRechargeGiftBoxInfo)
    if tbl.rewardInfo == nil then
        tbl.rewardInfo = {}
    else
        if rechargegiftboxV2_adj.AdjustDailyRechargeGiftBoxRewardInfo ~= nil then
            for i = 1, #tbl.rewardInfo do
                rechargegiftboxV2_adj.AdjustDailyRechargeGiftBoxRewardInfo(tbl.rewardInfo[i])
            end
        end
    end
end

--region metatable rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo
---@type rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo
rechargegiftboxV2_adj.metatable_DailyRechargeGiftBoxRewardInfo = {
    _ClassName = "rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo",
}
rechargegiftboxV2_adj.metatable_DailyRechargeGiftBoxRewardInfo.__index = rechargegiftboxV2_adj.metatable_DailyRechargeGiftBoxRewardInfo
--endregion

---@param tbl rechargegiftboxV2.DailyRechargeGiftBoxRewardInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustDailyRechargeGiftBoxRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_DailyRechargeGiftBoxRewardInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.status == nil then
        tbl.statusSpecified = false
        tbl.status = 0
    else
        tbl.statusSpecified = true
    end
    if tbl.remainRecharge == nil then
        tbl.remainRechargeSpecified = false
        tbl.remainRecharge = 0
    else
        tbl.remainRechargeSpecified = true
    end
end

--region metatable rechargegiftboxV2.CycleGiftBox
---@type rechargegiftboxV2.CycleGiftBox
rechargegiftboxV2_adj.metatable_CycleGiftBox = {
    _ClassName = "rechargegiftboxV2.CycleGiftBox",
}
rechargegiftboxV2_adj.metatable_CycleGiftBox.__index = rechargegiftboxV2_adj.metatable_CycleGiftBox
--endregion

---@param tbl rechargegiftboxV2.CycleGiftBox 待调整的table数据
function rechargegiftboxV2_adj.AdjustCycleGiftBox(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_CycleGiftBox)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.refreshType == nil then
        tbl.refreshTypeSpecified = false
        tbl.refreshType = 0
    else
        tbl.refreshTypeSpecified = true
    end
end

--region metatable rechargegiftboxV2.ResRoleCycleGiftBoxInfo
---@type rechargegiftboxV2.ResRoleCycleGiftBoxInfo
rechargegiftboxV2_adj.metatable_ResRoleCycleGiftBoxInfo = {
    _ClassName = "rechargegiftboxV2.ResRoleCycleGiftBoxInfo",
}
rechargegiftboxV2_adj.metatable_ResRoleCycleGiftBoxInfo.__index = rechargegiftboxV2_adj.metatable_ResRoleCycleGiftBoxInfo
--endregion

---@param tbl rechargegiftboxV2.ResRoleCycleGiftBoxInfo 待调整的table数据
function rechargegiftboxV2_adj.AdjustResRoleCycleGiftBoxInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, rechargegiftboxV2_adj.metatable_ResRoleCycleGiftBoxInfo)
    if tbl.giftBoxInfo == nil then
        tbl.giftBoxInfo = {}
    else
        if rechargegiftboxV2_adj.AdjustCycleGiftBox ~= nil then
            for i = 1, #tbl.giftBoxInfo do
                rechargegiftboxV2_adj.AdjustCycleGiftBox(tbl.giftBoxInfo[i])
            end
        end
    end
    if tbl.nextRefreshTime == nil then
        tbl.nextRefreshTimeSpecified = false
        tbl.nextRefreshTime = 0
    else
        tbl.nextRefreshTimeSpecified = true
    end
    if tbl.lastBuyGroup == nil then
        tbl.lastBuyGroupSpecified = false
        tbl.lastBuyGroup = 0
    else
        tbl.lastBuyGroupSpecified = true
    end
end

return rechargegiftboxV2_adj