--[[本文件为工具自动生成,禁止手动修改]]
local welfareV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable welfareV2.ResSignInfo
---@type welfareV2.ResSignInfo
welfareV2_adj.metatable_ResSignInfo = {
    _ClassName = "welfareV2.ResSignInfo",
}
welfareV2_adj.metatable_ResSignInfo.__index = welfareV2_adj.metatable_ResSignInfo
--endregion

---@param tbl welfareV2.ResSignInfo 待调整的table数据
function welfareV2_adj.AdjustResSignInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_ResSignInfo)
end

--region metatable welfareV2.ReqCdkeyReward
---@type welfareV2.ReqCdkeyReward
welfareV2_adj.metatable_ReqCdkeyReward = {
    _ClassName = "welfareV2.ReqCdkeyReward",
}
welfareV2_adj.metatable_ReqCdkeyReward.__index = welfareV2_adj.metatable_ReqCdkeyReward
--endregion

---@param tbl welfareV2.ReqCdkeyReward 待调整的table数据
function welfareV2_adj.AdjustReqCdkeyReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_ReqCdkeyReward)
    if tbl.cdkey == nil then
        tbl.cdkeySpecified = false
        tbl.cdkey = ""
    else
        tbl.cdkeySpecified = true
    end
end

--region metatable welfareV2.ResCdkeyReward
---@type welfareV2.ResCdkeyReward
welfareV2_adj.metatable_ResCdkeyReward = {
    _ClassName = "welfareV2.ResCdkeyReward",
}
welfareV2_adj.metatable_ResCdkeyReward.__index = welfareV2_adj.metatable_ResCdkeyReward
--endregion

---@param tbl welfareV2.ResCdkeyReward 待调整的table数据
function welfareV2_adj.AdjustResCdkeyReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_ResCdkeyReward)
    if tbl.result == nil then
        tbl.resultSpecified = false
        tbl.result = 0
    else
        tbl.resultSpecified = true
    end
end

--region metatable welfareV2.ReqDrawSummaryDayReward
---@type welfareV2.ReqDrawSummaryDayReward
welfareV2_adj.metatable_ReqDrawSummaryDayReward = {
    _ClassName = "welfareV2.ReqDrawSummaryDayReward",
}
welfareV2_adj.metatable_ReqDrawSummaryDayReward.__index = welfareV2_adj.metatable_ReqDrawSummaryDayReward
--endregion

---@param tbl welfareV2.ReqDrawSummaryDayReward 待调整的table数据
function welfareV2_adj.AdjustReqDrawSummaryDayReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_ReqDrawSummaryDayReward)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable welfareV2.ResSevenDaysInfo
---@type welfareV2.ResSevenDaysInfo
welfareV2_adj.metatable_ResSevenDaysInfo = {
    _ClassName = "welfareV2.ResSevenDaysInfo",
}
welfareV2_adj.metatable_ResSevenDaysInfo.__index = welfareV2_adj.metatable_ResSevenDaysInfo
--endregion

---@param tbl welfareV2.ResSevenDaysInfo 待调整的table数据
function welfareV2_adj.AdjustResSevenDaysInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_ResSevenDaysInfo)
    if tbl.loginDay == nil then
        tbl.loginDaySpecified = false
        tbl.loginDay = 0
    else
        tbl.loginDaySpecified = true
    end
    if tbl.sevenDay == nil then
        tbl.sevenDay = {}
    end
end

--region metatable welfareV2.ReqDrawSevenDays
---@type welfareV2.ReqDrawSevenDays
welfareV2_adj.metatable_ReqDrawSevenDays = {
    _ClassName = "welfareV2.ReqDrawSevenDays",
}
welfareV2_adj.metatable_ReqDrawSevenDays.__index = welfareV2_adj.metatable_ReqDrawSevenDays
--endregion

---@param tbl welfareV2.ReqDrawSevenDays 待调整的table数据
function welfareV2_adj.AdjustReqDrawSevenDays(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_ReqDrawSevenDays)
end

--region metatable welfareV2.OnlineRewardMsg
---@type welfareV2.OnlineRewardMsg
welfareV2_adj.metatable_OnlineRewardMsg = {
    _ClassName = "welfareV2.OnlineRewardMsg",
}
welfareV2_adj.metatable_OnlineRewardMsg.__index = welfareV2_adj.metatable_OnlineRewardMsg
--endregion

---@param tbl welfareV2.OnlineRewardMsg 待调整的table数据
function welfareV2_adj.AdjustOnlineRewardMsg(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_OnlineRewardMsg)
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.reward == nil then
        tbl.reward = {}
    end
    if tbl.lastLiquan == nil then
        tbl.lastLiquanSpecified = false
        tbl.lastLiquan = 0
    else
        tbl.lastLiquanSpecified = true
    end
    if tbl.theWeekLiquan == nil then
        tbl.theWeekLiquanSpecified = false
        tbl.theWeekLiquan = 0
    else
        tbl.theWeekLiquanSpecified = true
    end
    if tbl.isDraw == nil then
        tbl.isDrawSpecified = false
        tbl.isDraw = false
    else
        tbl.isDrawSpecified = true
    end
end

--region metatable welfareV2.OnlineRewardRequest
---@type welfareV2.OnlineRewardRequest
welfareV2_adj.metatable_OnlineRewardRequest = {
    _ClassName = "welfareV2.OnlineRewardRequest",
}
welfareV2_adj.metatable_OnlineRewardRequest.__index = welfareV2_adj.metatable_OnlineRewardRequest
--endregion

---@param tbl welfareV2.OnlineRewardRequest 待调整的table数据
function welfareV2_adj.AdjustOnlineRewardRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_OnlineRewardRequest)
    if tbl.index == nil then
        tbl.index = {}
    end
end

--region metatable welfareV2.GetRewardHall
---@type welfareV2.GetRewardHall
welfareV2_adj.metatable_GetRewardHall = {
    _ClassName = "welfareV2.GetRewardHall",
}
welfareV2_adj.metatable_GetRewardHall.__index = welfareV2_adj.metatable_GetRewardHall
--endregion

---@param tbl welfareV2.GetRewardHall 待调整的table数据
function welfareV2_adj.AdjustGetRewardHall(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_GetRewardHall)
end

--region metatable welfareV2.RewardHall
---@type welfareV2.RewardHall
welfareV2_adj.metatable_RewardHall = {
    _ClassName = "welfareV2.RewardHall",
}
welfareV2_adj.metatable_RewardHall.__index = welfareV2_adj.metatable_RewardHall
--endregion

---@param tbl welfareV2.RewardHall 待调整的table数据
function welfareV2_adj.AdjustRewardHall(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_RewardHall)
    if tbl.rewardHallInfo == nil then
        tbl.rewardHallInfo = {}
    else
        if welfareV2_adj.AdjustRewardHallInfo ~= nil then
            for i = 1, #tbl.rewardHallInfo do
                welfareV2_adj.AdjustRewardHallInfo(tbl.rewardHallInfo[i])
            end
        end
    end
end

--region metatable welfareV2.RewardHallInfo
---@type welfareV2.RewardHallInfo
welfareV2_adj.metatable_RewardHallInfo = {
    _ClassName = "welfareV2.RewardHallInfo",
}
welfareV2_adj.metatable_RewardHallInfo.__index = welfareV2_adj.metatable_RewardHallInfo
--endregion

---@param tbl welfareV2.RewardHallInfo 待调整的table数据
function welfareV2_adj.AdjustRewardHallInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_RewardHallInfo)
    if tbl.activityType == nil then
        tbl.activityTypeSpecified = false
        tbl.activityType = 0
    else
        tbl.activityTypeSpecified = true
    end
    if tbl.order == nil then
        tbl.orderSpecified = false
        tbl.order = 0
    else
        tbl.orderSpecified = true
    end
end

--region metatable welfareV2.TimingRewardRequest
---@type welfareV2.TimingRewardRequest
welfareV2_adj.metatable_TimingRewardRequest = {
    _ClassName = "welfareV2.TimingRewardRequest",
}
welfareV2_adj.metatable_TimingRewardRequest.__index = welfareV2_adj.metatable_TimingRewardRequest
--endregion

---@param tbl welfareV2.TimingRewardRequest 待调整的table数据
function welfareV2_adj.AdjustTimingRewardRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_TimingRewardRequest)
    if tbl.timingRewardType == nil then
        tbl.timingRewardTypeSpecified = false
        tbl.timingRewardType = 0
    else
        tbl.timingRewardTypeSpecified = true
    end
    if tbl.index == nil then
        tbl.index = {}
    end
end

--region metatable welfareV2.TimingReward
---@type welfareV2.TimingReward
welfareV2_adj.metatable_TimingReward = {
    _ClassName = "welfareV2.TimingReward",
}
welfareV2_adj.metatable_TimingReward.__index = welfareV2_adj.metatable_TimingReward
--endregion

---@param tbl welfareV2.TimingReward 待调整的table数据
function welfareV2_adj.AdjustTimingReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_TimingReward)
    if tbl.Dayreward == nil then
        tbl.Dayreward = {}
    end
    if tbl.isCanDrawDay == nil then
        tbl.isCanDrawDaySpecified = false
        tbl.isCanDrawDay = false
    else
        tbl.isCanDrawDaySpecified = true
    end
    if tbl.Weekreward == nil then
        tbl.Weekreward = {}
    end
    if tbl.isCanDrawWeek == nil then
        tbl.isCanDrawWeekSpecified = false
        tbl.isCanDrawWeek = false
    else
        tbl.isCanDrawWeekSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
end

--region metatable welfareV2.TimmngRewardInfo
---@type welfareV2.TimmngRewardInfo
welfareV2_adj.metatable_TimmngRewardInfo = {
    _ClassName = "welfareV2.TimmngRewardInfo",
}
welfareV2_adj.metatable_TimmngRewardInfo.__index = welfareV2_adj.metatable_TimmngRewardInfo
--endregion

---@param tbl welfareV2.TimmngRewardInfo 待调整的table数据
function welfareV2_adj.AdjustTimmngRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_TimmngRewardInfo)
end

--region metatable welfareV2.GetLevelPacks
---@type welfareV2.GetLevelPacks
welfareV2_adj.metatable_GetLevelPacks = {
    _ClassName = "welfareV2.GetLevelPacks",
}
welfareV2_adj.metatable_GetLevelPacks.__index = welfareV2_adj.metatable_GetLevelPacks
--endregion

---@param tbl welfareV2.GetLevelPacks 待调整的table数据
function welfareV2_adj.AdjustGetLevelPacks(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_GetLevelPacks)
end

--region metatable welfareV2.LevelPacksInfo
---@type welfareV2.LevelPacksInfo
welfareV2_adj.metatable_LevelPacksInfo = {
    _ClassName = "welfareV2.LevelPacksInfo",
}
welfareV2_adj.metatable_LevelPacksInfo.__index = welfareV2_adj.metatable_LevelPacksInfo
--endregion

---@param tbl welfareV2.LevelPacksInfo 待调整的table数据
function welfareV2_adj.AdjustLevelPacksInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_LevelPacksInfo)
    if tbl.LevelPacks == nil then
        tbl.LevelPacksSpecified = false
        tbl.LevelPacks = 0
    else
        tbl.LevelPacksSpecified = true
    end
    if tbl.isDraw == nil then
        tbl.isDrawSpecified = false
        tbl.isDraw = false
    else
        tbl.isDrawSpecified = true
    end
end

--region metatable welfareV2.GetLevelPacksInfo
---@type welfareV2.GetLevelPacksInfo
welfareV2_adj.metatable_GetLevelPacksInfo = {
    _ClassName = "welfareV2.GetLevelPacksInfo",
}
welfareV2_adj.metatable_GetLevelPacksInfo.__index = welfareV2_adj.metatable_GetLevelPacksInfo
--endregion

---@param tbl welfareV2.GetLevelPacksInfo 待调整的table数据
function welfareV2_adj.AdjustGetLevelPacksInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_GetLevelPacksInfo)
end

--region metatable welfareV2.GetServantGrid
---@type welfareV2.GetServantGrid
welfareV2_adj.metatable_GetServantGrid = {
    _ClassName = "welfareV2.GetServantGrid",
}
welfareV2_adj.metatable_GetServantGrid.__index = welfareV2_adj.metatable_GetServantGrid
--endregion

---@param tbl welfareV2.GetServantGrid 待调整的table数据
function welfareV2_adj.AdjustGetServantGrid(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, welfareV2_adj.metatable_GetServantGrid)
end

return welfareV2_adj