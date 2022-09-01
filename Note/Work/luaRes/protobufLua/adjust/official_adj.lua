--[[本文件为工具自动生成,禁止手动修改]]
local officialV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable officialV2.DailyTaskInfo
---@type officialV2.DailyTaskInfo
officialV2_adj.metatable_DailyTaskInfo = {
    _ClassName = "officialV2.DailyTaskInfo",
}
officialV2_adj.metatable_DailyTaskInfo.__index = officialV2_adj.metatable_DailyTaskInfo
--endregion

---@param tbl officialV2.DailyTaskInfo 待调整的table数据
function officialV2_adj.AdjustDailyTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, officialV2_adj.metatable_DailyTaskInfo)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
    if tbl.completedNum == nil then
        tbl.completedNumSpecified = false
        tbl.completedNum = 0
    else
        tbl.completedNumSpecified = true
    end
    if tbl.hasDrawCount == nil then
        tbl.hasDrawCountSpecified = false
        tbl.hasDrawCount = 0
    else
        tbl.hasDrawCountSpecified = true
    end
    if tbl.status == nil then
        tbl.statusSpecified = false
        tbl.status = 0
    else
        tbl.statusSpecified = true
    end
end

--region metatable officialV2.ResOfficialInfo
---@type officialV2.ResOfficialInfo
officialV2_adj.metatable_ResOfficialInfo = {
    _ClassName = "officialV2.ResOfficialInfo",
}
officialV2_adj.metatable_ResOfficialInfo.__index = officialV2_adj.metatable_ResOfficialInfo
--endregion

---@param tbl officialV2.ResOfficialInfo 待调整的table数据
function officialV2_adj.AdjustResOfficialInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, officialV2_adj.metatable_ResOfficialInfo)
    if tbl.uid == nil then
        tbl.uidSpecified = false
        tbl.uid = 0
    else
        tbl.uidSpecified = true
    end
    if tbl.power == nil then
        tbl.powerSpecified = false
        tbl.power = 0
    else
        tbl.powerSpecified = true
    end
    if tbl.attr == nil then
        tbl.attrSpecified = false
        tbl.attr = 0
    else
        tbl.attrSpecified = true
    end
    if tbl.dailyRewardDrawList == nil then
        tbl.dailyRewardDrawList = {}
    end
    if tbl.dailyTaskInfoList == nil then
        tbl.dailyTaskInfoList = {}
    else
        if officialV2_adj.AdjustDailyTaskInfo ~= nil then
            for i = 1, #tbl.dailyTaskInfoList do
                officialV2_adj.AdjustDailyTaskInfo(tbl.dailyTaskInfoList[i])
            end
        end
    end
end

--region metatable officialV2.ResOfficialUp
---@type officialV2.ResOfficialUp
officialV2_adj.metatable_ResOfficialUp = {
    _ClassName = "officialV2.ResOfficialUp",
}
officialV2_adj.metatable_ResOfficialUp.__index = officialV2_adj.metatable_ResOfficialUp
--endregion

---@param tbl officialV2.ResOfficialUp 待调整的table数据
function officialV2_adj.AdjustResOfficialUp(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, officialV2_adj.metatable_ResOfficialUp)
    if tbl.officialGrade == nil then
        tbl.officialGradeSpecified = false
        tbl.officialGrade = 0
    else
        tbl.officialGradeSpecified = true
    end
    if tbl.officialPoint == nil then
        tbl.officialPointSpecified = false
        tbl.officialPoint = 0
    else
        tbl.officialPointSpecified = true
    end
end

--region metatable officialV2.ReqDrawDailyActiveReward
---@type officialV2.ReqDrawDailyActiveReward
officialV2_adj.metatable_ReqDrawDailyActiveReward = {
    _ClassName = "officialV2.ReqDrawDailyActiveReward",
}
officialV2_adj.metatable_ReqDrawDailyActiveReward.__index = officialV2_adj.metatable_ReqDrawDailyActiveReward
--endregion

---@param tbl officialV2.ReqDrawDailyActiveReward 待调整的table数据
function officialV2_adj.AdjustReqDrawDailyActiveReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, officialV2_adj.metatable_ReqDrawDailyActiveReward)
    if tbl.rewardId == nil then
        tbl.rewardIdSpecified = false
        tbl.rewardId = 0
    else
        tbl.rewardIdSpecified = true
    end
end

--region metatable officialV2.ResDrawDailyActiveReward
---@type officialV2.ResDrawDailyActiveReward
officialV2_adj.metatable_ResDrawDailyActiveReward = {
    _ClassName = "officialV2.ResDrawDailyActiveReward",
}
officialV2_adj.metatable_ResDrawDailyActiveReward.__index = officialV2_adj.metatable_ResDrawDailyActiveReward
--endregion

---@param tbl officialV2.ResDrawDailyActiveReward 待调整的table数据
function officialV2_adj.AdjustResDrawDailyActiveReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, officialV2_adj.metatable_ResDrawDailyActiveReward)
    if tbl.rewardDrawList == nil then
        tbl.rewardDrawList = {}
    end
end

--region metatable officialV2.ReqDrawDailyTaskReward
---@type officialV2.ReqDrawDailyTaskReward
officialV2_adj.metatable_ReqDrawDailyTaskReward = {
    _ClassName = "officialV2.ReqDrawDailyTaskReward",
}
officialV2_adj.metatable_ReqDrawDailyTaskReward.__index = officialV2_adj.metatable_ReqDrawDailyTaskReward
--endregion

---@param tbl officialV2.ReqDrawDailyTaskReward 待调整的table数据
function officialV2_adj.AdjustReqDrawDailyTaskReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, officialV2_adj.metatable_ReqDrawDailyTaskReward)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable officialV2.ResOfficialInfoV2
---@type officialV2.ResOfficialInfoV2
officialV2_adj.metatable_ResOfficialInfoV2 = {
    _ClassName = "officialV2.ResOfficialInfoV2",
}
officialV2_adj.metatable_ResOfficialInfoV2.__index = officialV2_adj.metatable_ResOfficialInfoV2
--endregion

---@param tbl officialV2.ResOfficialInfoV2 待调整的table数据
function officialV2_adj.AdjustResOfficialInfoV2(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, officialV2_adj.metatable_ResOfficialInfoV2)
end

--region metatable officialV2.ReqOfficialEmperorTokenActivateV2
---@type officialV2.ReqOfficialEmperorTokenActivateV2
officialV2_adj.metatable_ReqOfficialEmperorTokenActivateV2 = {
    _ClassName = "officialV2.ReqOfficialEmperorTokenActivateV2",
}
officialV2_adj.metatable_ReqOfficialEmperorTokenActivateV2.__index = officialV2_adj.metatable_ReqOfficialEmperorTokenActivateV2
--endregion

---@param tbl officialV2.ReqOfficialEmperorTokenActivateV2 待调整的table数据
function officialV2_adj.AdjustReqOfficialEmperorTokenActivateV2(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, officialV2_adj.metatable_ReqOfficialEmperorTokenActivateV2)
end

return officialV2_adj