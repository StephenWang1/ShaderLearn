--[[本文件为工具自动生成,禁止手动修改]]
local activityV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable activityV2.ActivityInfo
---@type activityV2.ActivityInfo
activityV2_adj.metatable_ActivityInfo = {
    _ClassName = "activityV2.ActivityInfo",
}
activityV2_adj.metatable_ActivityInfo.__index = activityV2_adj.metatable_ActivityInfo
--endregion

---@param tbl activityV2.ActivityInfo 待调整的table数据
function activityV2_adj.AdjustActivityInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityInfo)
    if tbl.goalInfo == nil then
        tbl.goalInfo = {}
    else
        if activityV2_adj.AdjustGoalInfo ~= nil then
            for i = 1, #tbl.goalInfo do
                activityV2_adj.AdjustGoalInfo(tbl.goalInfo[i])
            end
        end
    end
end

--region metatable activityV2.GoalInfo
---@type activityV2.GoalInfo
activityV2_adj.metatable_GoalInfo = {
    _ClassName = "activityV2.GoalInfo",
}
activityV2_adj.metatable_GoalInfo.__index = activityV2_adj.metatable_GoalInfo
--endregion

---@param tbl activityV2.GoalInfo 待调整的table数据
function activityV2_adj.AdjustGoalInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_GoalInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.goalType == nil then
        tbl.goalTypeSpecified = false
        tbl.goalType = 0
    else
        tbl.goalTypeSpecified = true
    end
    if tbl.goal == nil then
        tbl.goalSpecified = false
        tbl.goal = 0
    else
        tbl.goalSpecified = true
    end
    if tbl.rewardState == nil then
        tbl.rewardStateSpecified = false
        tbl.rewardState = 0
    else
        tbl.rewardStateSpecified = true
    end
    if tbl.leftCount == nil then
        tbl.leftCountSpecified = false
        tbl.leftCount = 0
    else
        tbl.leftCountSpecified = true
    end
    if tbl.now == nil then
        tbl.nowSpecified = false
        tbl.now = 0
    else
        tbl.nowSpecified = true
    end
    if tbl.total == nil then
        tbl.totalSpecified = false
        tbl.total = 0
    else
        tbl.totalSpecified = true
    end
end

--region metatable activityV2.ResOpenPanel
---@type activityV2.ResOpenPanel
activityV2_adj.metatable_ResOpenPanel = {
    _ClassName = "activityV2.ResOpenPanel",
}
activityV2_adj.metatable_ResOpenPanel.__index = activityV2_adj.metatable_ResOpenPanel
--endregion

---@param tbl activityV2.ResOpenPanel 待调整的table数据
function activityV2_adj.AdjustResOpenPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResOpenPanel)
    if tbl.activityType == nil then
        tbl.activityTypeSpecified = false
        tbl.activityType = 0
    else
        tbl.activityTypeSpecified = true
    end
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if activityV2_adj.AdjustActivityListInfo ~= nil then
                activityV2_adj.AdjustActivityListInfo(tbl.info)
            end
        end
    end
end

--region metatable activityV2.ActivityListInfo
---@type activityV2.ActivityListInfo
activityV2_adj.metatable_ActivityListInfo = {
    _ClassName = "activityV2.ActivityListInfo",
}
activityV2_adj.metatable_ActivityListInfo.__index = activityV2_adj.metatable_ActivityListInfo
--endregion

---@param tbl activityV2.ActivityListInfo 待调整的table数据
function activityV2_adj.AdjustActivityListInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityListInfo)
    if tbl.activityDataInfo == nil then
        tbl.activityDataInfo = {}
    else
        if activityV2_adj.AdjustActivityDataInfo ~= nil then
            for i = 1, #tbl.activityDataInfo do
                activityV2_adj.AdjustActivityDataInfo(tbl.activityDataInfo[i])
            end
        end
    end
    if tbl.registerNum == nil then
        tbl.registerNumSpecified = false
        tbl.registerNum = 0
    else
        tbl.registerNumSpecified = true
    end
end

--region metatable activityV2.ActivityDataInfo
---@type activityV2.ActivityDataInfo
activityV2_adj.metatable_ActivityDataInfo = {
    _ClassName = "activityV2.ActivityDataInfo",
}
activityV2_adj.metatable_ActivityDataInfo.__index = activityV2_adj.metatable_ActivityDataInfo
--endregion

---@param tbl activityV2.ActivityDataInfo 待调整的table数据
function activityV2_adj.AdjustActivityDataInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityDataInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.leftCount == nil then
        tbl.leftCountSpecified = false
        tbl.leftCount = 0
    else
        tbl.leftCountSpecified = true
    end
    if tbl.roleGoalInfo == nil then
        tbl.roleGoalInfoSpecified = false
        tbl.roleGoalInfo = nil
    else
        if tbl.roleGoalInfoSpecified == nil then 
            tbl.roleGoalInfoSpecified = true
            if activityV2_adj.AdjustRoleActivityInfo ~= nil then
                activityV2_adj.AdjustRoleActivityInfo(tbl.roleGoalInfo)
            end
        end
    end
    if tbl.serverGoalInfo == nil then
        tbl.serverGoalInfoSpecified = false
        tbl.serverGoalInfo = nil
    else
        if tbl.serverGoalInfoSpecified == nil then 
            tbl.serverGoalInfoSpecified = true
            if activityV2_adj.AdjustServerActivityInfo ~= nil then
                activityV2_adj.AdjustServerActivityInfo(tbl.serverGoalInfo)
            end
        end
    end
    if tbl.dataType == nil then
        tbl.dataTypeSpecified = false
        tbl.dataType = 0
    else
        tbl.dataTypeSpecified = true
    end
end

--region metatable activityV2.RoleGoalInfo
---@type activityV2.RoleGoalInfo
activityV2_adj.metatable_RoleGoalInfo = {
    _ClassName = "activityV2.RoleGoalInfo",
}
activityV2_adj.metatable_RoleGoalInfo.__index = activityV2_adj.metatable_RoleGoalInfo
--endregion

---@param tbl activityV2.RoleGoalInfo 待调整的table数据
function activityV2_adj.AdjustRoleGoalInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_RoleGoalInfo)
    if tbl.goalId == nil then
        tbl.goalIdSpecified = false
        tbl.goalId = 0
    else
        tbl.goalIdSpecified = true
    end
    if tbl.ok == nil then
        tbl.okSpecified = false
        tbl.ok = false
    else
        tbl.okSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable activityV2.RoleActivityInfo
---@type activityV2.RoleActivityInfo
activityV2_adj.metatable_RoleActivityInfo = {
    _ClassName = "activityV2.RoleActivityInfo",
}
activityV2_adj.metatable_RoleActivityInfo.__index = activityV2_adj.metatable_RoleActivityInfo
--endregion

---@param tbl activityV2.RoleActivityInfo 待调整的table数据
function activityV2_adj.AdjustRoleActivityInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_RoleActivityInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.rewardState == nil then
        tbl.rewardStateSpecified = false
        tbl.rewardState = 0
    else
        tbl.rewardStateSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.roleGoalInfos == nil then
        tbl.roleGoalInfos = {}
    else
        if activityV2_adj.AdjustRoleGoalInfo ~= nil then
            for i = 1, #tbl.roleGoalInfos do
                activityV2_adj.AdjustRoleGoalInfo(tbl.roleGoalInfos[i])
            end
        end
    end
end

--region metatable activityV2.ServerGoalInfo
---@type activityV2.ServerGoalInfo
activityV2_adj.metatable_ServerGoalInfo = {
    _ClassName = "activityV2.ServerGoalInfo",
}
activityV2_adj.metatable_ServerGoalInfo.__index = activityV2_adj.metatable_ServerGoalInfo
--endregion

---@param tbl activityV2.ServerGoalInfo 待调整的table数据
function activityV2_adj.AdjustServerGoalInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ServerGoalInfo)
    if tbl.goalId == nil then
        tbl.goalIdSpecified = false
        tbl.goalId = 0
    else
        tbl.goalIdSpecified = true
    end
    if tbl.ok == nil then
        tbl.okSpecified = false
        tbl.ok = false
    else
        tbl.okSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.no == nil then
        tbl.noSpecified = false
        tbl.no = 0
    else
        tbl.noSpecified = true
    end
    if tbl.finishRoleId == nil then
        tbl.finishRoleIdSpecified = false
        tbl.finishRoleId = 0
    else
        tbl.finishRoleIdSpecified = true
    end
    if tbl.finishName == nil then
        tbl.finishNameSpecified = false
        tbl.finishName = ""
    else
        tbl.finishNameSpecified = true
    end
    if tbl.award == nil then
        tbl.awardSpecified = false
        tbl.award = false
    else
        tbl.awardSpecified = true
    end
    if tbl.finishSex == nil then
        tbl.finishSexSpecified = false
        tbl.finishSex = 0
    else
        tbl.finishSexSpecified = true
    end
    if tbl.finishCarrer == nil then
        tbl.finishCarrerSpecified = false
        tbl.finishCarrer = 0
    else
        tbl.finishCarrerSpecified = true
    end
end

--region metatable activityV2.ServerActivityInfo
---@type activityV2.ServerActivityInfo
activityV2_adj.metatable_ServerActivityInfo = {
    _ClassName = "activityV2.ServerActivityInfo",
}
activityV2_adj.metatable_ServerActivityInfo.__index = activityV2_adj.metatable_ServerActivityInfo
--endregion

---@param tbl activityV2.ServerActivityInfo 待调整的table数据
function activityV2_adj.AdjustServerActivityInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ServerActivityInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.rewardState == nil then
        tbl.rewardStateSpecified = false
        tbl.rewardState = 0
    else
        tbl.rewardStateSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.serverGoalInfos == nil then
        tbl.serverGoalInfos = {}
    else
        if activityV2_adj.AdjustServerGoalInfo ~= nil then
            for i = 1, #tbl.serverGoalInfos do
                activityV2_adj.AdjustServerGoalInfo(tbl.serverGoalInfos[i])
            end
        end
    end
    if tbl.roleCanRewardGoalId == nil then
        tbl.roleCanRewardGoalId = {}
    end
end

--region metatable activityV2.RankInfo
---@type activityV2.RankInfo
activityV2_adj.metatable_RankInfo = {
    _ClassName = "activityV2.RankInfo",
}
activityV2_adj.metatable_RankInfo.__index = activityV2_adj.metatable_RankInfo
--endregion

---@param tbl activityV2.RankInfo 待调整的table数据
function activityV2_adj.AdjustRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_RankInfo)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = 0
    else
        tbl.rankSpecified = true
    end
    if tbl.roleName == nil then
        tbl.roleNameSpecified = false
        tbl.roleName = ""
    else
        tbl.roleNameSpecified = true
    end
    if tbl.rein == nil then
        tbl.reinSpecified = false
        tbl.rein = 0
    else
        tbl.reinSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
    if tbl.award == nil then
        tbl.awardSpecified = false
        tbl.award = 0
    else
        tbl.awardSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable activityV2.RoleSimpleInfo
---@type activityV2.RoleSimpleInfo
activityV2_adj.metatable_RoleSimpleInfo = {
    _ClassName = "activityV2.RoleSimpleInfo",
}
activityV2_adj.metatable_RoleSimpleInfo.__index = activityV2_adj.metatable_RoleSimpleInfo
--endregion

---@param tbl activityV2.RoleSimpleInfo 待调整的table数据
function activityV2_adj.AdjustRoleSimpleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_RoleSimpleInfo)
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.cloth == nil then
        tbl.clothSpecified = false
        tbl.cloth = 0
    else
        tbl.clothSpecified = true
    end
    if tbl.weapon == nil then
        tbl.weaponSpecified = false
        tbl.weapon = 0
    else
        tbl.weaponSpecified = true
    end
    if tbl.wing == nil then
        tbl.wingSpecified = false
        tbl.wing = 0
    else
        tbl.wingSpecified = true
    end
    if tbl.fashionCloth == nil then
        tbl.fashionClothSpecified = false
        tbl.fashionCloth = 0
    else
        tbl.fashionClothSpecified = true
    end
    if tbl.fashionWing == nil then
        tbl.fashionWingSpecified = false
        tbl.fashionWing = 0
    else
        tbl.fashionWingSpecified = true
    end
    if tbl.fashionWeapon == nil then
        tbl.fashionWeaponSpecified = false
        tbl.fashionWeapon = 0
    else
        tbl.fashionWeaponSpecified = true
    end
end

--region metatable activityV2.ActivityRankInfo
---@type activityV2.ActivityRankInfo
activityV2_adj.metatable_ActivityRankInfo = {
    _ClassName = "activityV2.ActivityRankInfo",
}
activityV2_adj.metatable_ActivityRankInfo.__index = activityV2_adj.metatable_ActivityRankInfo
--endregion

---@param tbl activityV2.ActivityRankInfo 待调整的table数据
function activityV2_adj.AdjustActivityRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityRankInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.firstRoleBean == nil then
        tbl.firstRoleBeanSpecified = false
        tbl.firstRoleBean = nil
    else
        if tbl.firstRoleBeanSpecified == nil then 
            tbl.firstRoleBeanSpecified = true
            if activityV2_adj.AdjustRoleSimpleInfo ~= nil then
                activityV2_adj.AdjustRoleSimpleInfo(tbl.firstRoleBean)
            end
        end
    end
    if tbl.secondRoleBean == nil then
        tbl.secondRoleBeanSpecified = false
        tbl.secondRoleBean = nil
    else
        if tbl.secondRoleBeanSpecified == nil then 
            tbl.secondRoleBeanSpecified = true
            if activityV2_adj.AdjustRoleSimpleInfo ~= nil then
                activityV2_adj.AdjustRoleSimpleInfo(tbl.secondRoleBean)
            end
        end
    end
    if tbl.thirdRoleBean == nil then
        tbl.thirdRoleBeanSpecified = false
        tbl.thirdRoleBean = nil
    else
        if tbl.thirdRoleBeanSpecified == nil then 
            tbl.thirdRoleBeanSpecified = true
            if activityV2_adj.AdjustRoleSimpleInfo ~= nil then
                activityV2_adj.AdjustRoleSimpleInfo(tbl.thirdRoleBean)
            end
        end
    end
    if tbl.rankInfoList == nil then
        tbl.rankInfoList = {}
    else
        if activityV2_adj.AdjustRoleSimpleInfo ~= nil then
            for i = 1, #tbl.rankInfoList do
                activityV2_adj.AdjustRoleSimpleInfo(tbl.rankInfoList[i])
            end
        end
    end
end

--region metatable activityV2.FirstKillInfo
---@type activityV2.FirstKillInfo
activityV2_adj.metatable_FirstKillInfo = {
    _ClassName = "activityV2.FirstKillInfo",
}
activityV2_adj.metatable_FirstKillInfo.__index = activityV2_adj.metatable_FirstKillInfo
--endregion

---@param tbl activityV2.FirstKillInfo 待调整的table数据
function activityV2_adj.AdjustFirstKillInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_FirstKillInfo)
    if tbl.instanceId == nil then
        tbl.instanceIdSpecified = false
        tbl.instanceId = 0
    else
        tbl.instanceIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable activityV2.FirstKillRewardInfo
---@type activityV2.FirstKillRewardInfo
activityV2_adj.metatable_FirstKillRewardInfo = {
    _ClassName = "activityV2.FirstKillRewardInfo",
}
activityV2_adj.metatable_FirstKillRewardInfo.__index = activityV2_adj.metatable_FirstKillRewardInfo
--endregion

---@param tbl activityV2.FirstKillRewardInfo 待调整的table数据
function activityV2_adj.AdjustFirstKillRewardInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_FirstKillRewardInfo)
    if tbl.KillInfos == nil then
        tbl.KillInfos = {}
    else
        if activityV2_adj.AdjustFirstKillInfo ~= nil then
            for i = 1, #tbl.KillInfos do
                activityV2_adj.AdjustFirstKillInfo(tbl.KillInfos[i])
            end
        end
    end
    if tbl.reward == nil then
        tbl.rewardSpecified = false
        tbl.reward = 0
    else
        tbl.rewardSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable activityV2.limitTimeTaskInfo
---@type activityV2.limitTimeTaskInfo
activityV2_adj.metatable_limitTimeTaskInfo = {
    _ClassName = "activityV2.limitTimeTaskInfo",
}
activityV2_adj.metatable_limitTimeTaskInfo.__index = activityV2_adj.metatable_limitTimeTaskInfo
--endregion

---@param tbl activityV2.limitTimeTaskInfo 待调整的table数据
function activityV2_adj.AdjustlimitTimeTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_limitTimeTaskInfo)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
    if tbl.taskValue == nil then
        tbl.taskValueSpecified = false
        tbl.taskValue = 0
    else
        tbl.taskValueSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable activityV2.DayInfoOfHappySevenDay
---@type activityV2.DayInfoOfHappySevenDay
activityV2_adj.metatable_DayInfoOfHappySevenDay = {
    _ClassName = "activityV2.DayInfoOfHappySevenDay",
}
activityV2_adj.metatable_DayInfoOfHappySevenDay.__index = activityV2_adj.metatable_DayInfoOfHappySevenDay
--endregion

---@param tbl activityV2.DayInfoOfHappySevenDay 待调整的table数据
function activityV2_adj.AdjustDayInfoOfHappySevenDay(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_DayInfoOfHappySevenDay)
    if tbl.day == nil then
        tbl.daySpecified = false
        tbl.day = 0
    else
        tbl.daySpecified = true
    end
    if tbl.groupInfo == nil then
        tbl.groupInfo = {}
    else
        if activityV2_adj.AdjustGroupInfoOfDay ~= nil then
            for i = 1, #tbl.groupInfo do
                activityV2_adj.AdjustGroupInfoOfDay(tbl.groupInfo[i])
            end
        end
    end
end

--region metatable activityV2.GroupInfoOfDay
---@type activityV2.GroupInfoOfDay
activityV2_adj.metatable_GroupInfoOfDay = {
    _ClassName = "activityV2.GroupInfoOfDay",
}
activityV2_adj.metatable_GroupInfoOfDay.__index = activityV2_adj.metatable_GroupInfoOfDay
--endregion

---@param tbl activityV2.GroupInfoOfDay 待调整的table数据
function activityV2_adj.AdjustGroupInfoOfDay(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_GroupInfoOfDay)
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.indexInfo == nil then
        tbl.indexInfo = {}
    else
        if activityV2_adj.AdjustIndexInfoOfDay ~= nil then
            for i = 1, #tbl.indexInfo do
                activityV2_adj.AdjustIndexInfoOfDay(tbl.indexInfo[i])
            end
        end
    end
end

--region metatable activityV2.IndexInfoOfDay
---@type activityV2.IndexInfoOfDay
activityV2_adj.metatable_IndexInfoOfDay = {
    _ClassName = "activityV2.IndexInfoOfDay",
}
activityV2_adj.metatable_IndexInfoOfDay.__index = activityV2_adj.metatable_IndexInfoOfDay
--endregion

---@param tbl activityV2.IndexInfoOfDay 待调整的table数据
function activityV2_adj.AdjustIndexInfoOfDay(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_IndexInfoOfDay)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.day == nil then
        tbl.daySpecified = false
        tbl.day = 0
    else
        tbl.daySpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.goal == nil then
        tbl.goalSpecified = false
        tbl.goal = 0
    else
        tbl.goalSpecified = true
    end
    if tbl.completeCount == nil then
        tbl.completeCountSpecified = false
        tbl.completeCount = 0
    else
        tbl.completeCountSpecified = true
    end
    if tbl.total == nil then
        tbl.totalSpecified = false
        tbl.total = 0
    else
        tbl.totalSpecified = true
    end
    if tbl.rewardState == nil then
        tbl.rewardStateSpecified = false
        tbl.rewardState = 0
    else
        tbl.rewardStateSpecified = true
    end
end

--region metatable activityV2.ActivityTimeInfo
---@type activityV2.ActivityTimeInfo
activityV2_adj.metatable_ActivityTimeInfo = {
    _ClassName = "activityV2.ActivityTimeInfo",
}
activityV2_adj.metatable_ActivityTimeInfo.__index = activityV2_adj.metatable_ActivityTimeInfo
--endregion

---@param tbl activityV2.ActivityTimeInfo 待调整的table数据
function activityV2_adj.AdjustActivityTimeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityTimeInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.beginTime == nil then
        tbl.beginTimeSpecified = false
        tbl.beginTime = 0
    else
        tbl.beginTimeSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
end

--region metatable activityV2.RaffleItem
---@type activityV2.RaffleItem
activityV2_adj.metatable_RaffleItem = {
    _ClassName = "activityV2.RaffleItem",
}
activityV2_adj.metatable_RaffleItem.__index = activityV2_adj.metatable_RaffleItem
--endregion

---@param tbl activityV2.RaffleItem 待调整的table数据
function activityV2_adj.AdjustRaffleItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_RaffleItem)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable activityV2.CrazyHappyInfo
---@type activityV2.CrazyHappyInfo
activityV2_adj.metatable_CrazyHappyInfo = {
    _ClassName = "activityV2.CrazyHappyInfo",
}
activityV2_adj.metatable_CrazyHappyInfo.__index = activityV2_adj.metatable_CrazyHappyInfo
--endregion

---@param tbl activityV2.CrazyHappyInfo 待调整的table数据
function activityV2_adj.AdjustCrazyHappyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_CrazyHappyInfo)
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.status == nil then
        tbl.statusSpecified = false
        tbl.status = 0
    else
        tbl.statusSpecified = true
    end
    if tbl.curCount == nil then
        tbl.curCountSpecified = false
        tbl.curCount = 0
    else
        tbl.curCountSpecified = true
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
end

--region metatable activityV2.ShouHuLimitBuyInfo
---@type activityV2.ShouHuLimitBuyInfo
activityV2_adj.metatable_ShouHuLimitBuyInfo = {
    _ClassName = "activityV2.ShouHuLimitBuyInfo",
}
activityV2_adj.metatable_ShouHuLimitBuyInfo.__index = activityV2_adj.metatable_ShouHuLimitBuyInfo
--endregion

---@param tbl activityV2.ShouHuLimitBuyInfo 待调整的table数据
function activityV2_adj.AdjustShouHuLimitBuyInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ShouHuLimitBuyInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.lifeCount == nil then
        tbl.lifeCountSpecified = false
        tbl.lifeCount = 0
    else
        tbl.lifeCountSpecified = true
    end
    if tbl.leftCount == nil then
        tbl.leftCountSpecified = false
        tbl.leftCount = 0
    else
        tbl.leftCountSpecified = true
    end
end

--region metatable activityV2.GrowTrailActivityInfo
---@type activityV2.GrowTrailActivityInfo
activityV2_adj.metatable_GrowTrailActivityInfo = {
    _ClassName = "activityV2.GrowTrailActivityInfo",
}
activityV2_adj.metatable_GrowTrailActivityInfo.__index = activityV2_adj.metatable_GrowTrailActivityInfo
--endregion

---@param tbl activityV2.GrowTrailActivityInfo 待调整的table数据
function activityV2_adj.AdjustGrowTrailActivityInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_GrowTrailActivityInfo)
    if tbl.dayNo == nil then
        tbl.dayNoSpecified = false
        tbl.dayNo = 0
    else
        tbl.dayNoSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.curCount == nil then
        tbl.curCountSpecified = false
        tbl.curCount = 0
    else
        tbl.curCountSpecified = true
    end
    if tbl.rewardState == nil then
        tbl.rewardStateSpecified = false
        tbl.rewardState = 0
    else
        tbl.rewardStateSpecified = true
    end
end

--region metatable activityV2.GrowTrailFinalInfo
---@type activityV2.GrowTrailFinalInfo
activityV2_adj.metatable_GrowTrailFinalInfo = {
    _ClassName = "activityV2.GrowTrailFinalInfo",
}
activityV2_adj.metatable_GrowTrailFinalInfo.__index = activityV2_adj.metatable_GrowTrailFinalInfo
--endregion

---@param tbl activityV2.GrowTrailFinalInfo 待调整的table数据
function activityV2_adj.AdjustGrowTrailFinalInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_GrowTrailFinalInfo)
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.rewardState == nil then
        tbl.rewardStateSpecified = false
        tbl.rewardState = 0
    else
        tbl.rewardStateSpecified = true
    end
end

--region metatable activityV2.ReqGetActivityReward
---@type activityV2.ReqGetActivityReward
activityV2_adj.metatable_ReqGetActivityReward = {
    _ClassName = "activityV2.ReqGetActivityReward",
}
activityV2_adj.metatable_ReqGetActivityReward.__index = activityV2_adj.metatable_ReqGetActivityReward
--endregion

---@param tbl activityV2.ReqGetActivityReward 待调整的table数据
function activityV2_adj.AdjustReqGetActivityReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqGetActivityReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.goal == nil then
        tbl.goalSpecified = false
        tbl.goal = 0
    else
        tbl.goalSpecified = true
    end
    if tbl.multi == nil then
        tbl.multiSpecified = false
        tbl.multi = 0
    else
        tbl.multiSpecified = true
    end
    if tbl.data64 == nil then
        tbl.data64Specified = false
        tbl.data64 = 0
    else
        tbl.data64Specified = true
    end
end

--region metatable activityV2.ResGetActivityReward
---@type activityV2.ResGetActivityReward
activityV2_adj.metatable_ResGetActivityReward = {
    _ClassName = "activityV2.ResGetActivityReward",
}
activityV2_adj.metatable_ResGetActivityReward.__index = activityV2_adj.metatable_ResGetActivityReward
--endregion

---@param tbl activityV2.ResGetActivityReward 待调整的table数据
function activityV2_adj.AdjustResGetActivityReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResGetActivityReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.goal == nil then
        tbl.goalSpecified = false
        tbl.goal = 0
    else
        tbl.goalSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.leftCount == nil then
        tbl.leftCountSpecified = false
        tbl.leftCount = 0
    else
        tbl.leftCountSpecified = true
    end
end

--region metatable activityV2.ReqOpenPanel
---@type activityV2.ReqOpenPanel
activityV2_adj.metatable_ReqOpenPanel = {
    _ClassName = "activityV2.ReqOpenPanel",
}
activityV2_adj.metatable_ReqOpenPanel.__index = activityV2_adj.metatable_ReqOpenPanel
--endregion

---@param tbl activityV2.ReqOpenPanel 待调整的table数据
function activityV2_adj.AdjustReqOpenPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqOpenPanel)
    if tbl.activityType == nil then
        tbl.activityTypeSpecified = false
        tbl.activityType = 0
    else
        tbl.activityTypeSpecified = true
    end
end

--region metatable activityV2.ResRankActivity
---@type activityV2.ResRankActivity
activityV2_adj.metatable_ResRankActivity = {
    _ClassName = "activityV2.ResRankActivity",
}
activityV2_adj.metatable_ResRankActivity.__index = activityV2_adj.metatable_ResRankActivity
--endregion

---@param tbl activityV2.ResRankActivity 待调整的table数据
function activityV2_adj.AdjustResRankActivity(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResRankActivity)
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
    if tbl.rankInfoList == nil then
        tbl.rankInfoList = {}
    else
        if activityV2_adj.AdjustActivityRankInfo ~= nil then
            for i = 1, #tbl.rankInfoList do
                activityV2_adj.AdjustActivityRankInfo(tbl.rankInfoList[i])
            end
        end
    end
end

--region metatable activityV2.ResWeekTotalRechargeNum
---@type activityV2.ResWeekTotalRechargeNum
activityV2_adj.metatable_ResWeekTotalRechargeNum = {
    _ClassName = "activityV2.ResWeekTotalRechargeNum",
}
activityV2_adj.metatable_ResWeekTotalRechargeNum.__index = activityV2_adj.metatable_ResWeekTotalRechargeNum
--endregion

---@param tbl activityV2.ResWeekTotalRechargeNum 待调整的table数据
function activityV2_adj.AdjustResWeekTotalRechargeNum(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResWeekTotalRechargeNum)
    if tbl.totalNum == nil then
        tbl.totalNumSpecified = false
        tbl.totalNum = 0
    else
        tbl.totalNumSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResExtraReward
---@type activityV2.ResExtraReward
activityV2_adj.metatable_ResExtraReward = {
    _ClassName = "activityV2.ResExtraReward",
}
activityV2_adj.metatable_ResExtraReward.__index = activityV2_adj.metatable_ResExtraReward
--endregion

---@param tbl activityV2.ResExtraReward 待调整的table数据
function activityV2_adj.AdjustResExtraReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResExtraReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.time == nil then
        tbl.timeSpecified = false
        tbl.time = 0
    else
        tbl.timeSpecified = true
    end
    if tbl.goalType == nil then
        tbl.goalTypeSpecified = false
        tbl.goalType = 0
    else
        tbl.goalTypeSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable activityV2.ReqGetExtraReward
---@type activityV2.ReqGetExtraReward
activityV2_adj.metatable_ReqGetExtraReward = {
    _ClassName = "activityV2.ReqGetExtraReward",
}
activityV2_adj.metatable_ReqGetExtraReward.__index = activityV2_adj.metatable_ReqGetExtraReward
--endregion

---@param tbl activityV2.ReqGetExtraReward 待调整的table数据
function activityV2_adj.AdjustReqGetExtraReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqGetExtraReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.goalType == nil then
        tbl.goalTypeSpecified = false
        tbl.goalType = 0
    else
        tbl.goalTypeSpecified = true
    end
end

--region metatable activityV2.ReqOpenLianZhi
---@type activityV2.ReqOpenLianZhi
activityV2_adj.metatable_ReqOpenLianZhi = {
    _ClassName = "activityV2.ReqOpenLianZhi",
}
activityV2_adj.metatable_ReqOpenLianZhi.__index = activityV2_adj.metatable_ReqOpenLianZhi
--endregion

---@param tbl activityV2.ReqOpenLianZhi 待调整的table数据
function activityV2_adj.AdjustReqOpenLianZhi(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqOpenLianZhi)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResOpenLianZhi
---@type activityV2.ResOpenLianZhi
activityV2_adj.metatable_ResOpenLianZhi = {
    _ClassName = "activityV2.ResOpenLianZhi",
}
activityV2_adj.metatable_ResOpenLianZhi.__index = activityV2_adj.metatable_ResOpenLianZhi
--endregion

---@param tbl activityV2.ResOpenLianZhi 待调整的table数据
function activityV2_adj.AdjustResOpenLianZhi(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResOpenLianZhi)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.times == nil then
        tbl.timesSpecified = false
        tbl.times = 0
    else
        tbl.timesSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.completedList == nil then
        tbl.completedList = {}
    end
end

--region metatable activityV2.ReqLianZhi
---@type activityV2.ReqLianZhi
activityV2_adj.metatable_ReqLianZhi = {
    _ClassName = "activityV2.ReqLianZhi",
}
activityV2_adj.metatable_ReqLianZhi.__index = activityV2_adj.metatable_ReqLianZhi
--endregion

---@param tbl activityV2.ReqLianZhi 待调整的table数据
function activityV2_adj.AdjustReqLianZhi(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqLianZhi)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.times == nil then
        tbl.timesSpecified = false
        tbl.times = 0
    else
        tbl.timesSpecified = true
    end
end

--region metatable activityV2.ResActivityDataChange
---@type activityV2.ResActivityDataChange
activityV2_adj.metatable_ResActivityDataChange = {
    _ClassName = "activityV2.ResActivityDataChange",
}
activityV2_adj.metatable_ResActivityDataChange.__index = activityV2_adj.metatable_ResActivityDataChange
--endregion

---@param tbl activityV2.ResActivityDataChange 待调整的table数据
function activityV2_adj.AdjustResActivityDataChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResActivityDataChange)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.goal == nil then
        tbl.goalSpecified = false
        tbl.goal = 0
    else
        tbl.goalSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.now == nil then
        tbl.nowSpecified = false
        tbl.now = 0
    else
        tbl.nowSpecified = true
    end
    if tbl.total == nil then
        tbl.totalSpecified = false
        tbl.total = 0
    else
        tbl.totalSpecified = true
    end
end

--region metatable activityV2.ResLeijiRechargeDays
---@type activityV2.ResLeijiRechargeDays
activityV2_adj.metatable_ResLeijiRechargeDays = {
    _ClassName = "activityV2.ResLeijiRechargeDays",
}
activityV2_adj.metatable_ResLeijiRechargeDays.__index = activityV2_adj.metatable_ResLeijiRechargeDays
--endregion

---@param tbl activityV2.ResLeijiRechargeDays 待调整的table数据
function activityV2_adj.AdjustResLeijiRechargeDays(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResLeijiRechargeDays)
    if tbl.days == nil then
        tbl.daysSpecified = false
        tbl.days = 0
    else
        tbl.daysSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResSendActivityBossInfo
---@type activityV2.ResSendActivityBossInfo
activityV2_adj.metatable_ResSendActivityBossInfo = {
    _ClassName = "activityV2.ResSendActivityBossInfo",
}
activityV2_adj.metatable_ResSendActivityBossInfo.__index = activityV2_adj.metatable_ResSendActivityBossInfo
--endregion

---@param tbl activityV2.ResSendActivityBossInfo 待调整的table数据
function activityV2_adj.AdjustResSendActivityBossInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSendActivityBossInfo)
    if tbl.remainNum == nil then
        tbl.remainNumSpecified = false
        tbl.remainNum = 0
    else
        tbl.remainNumSpecified = true
    end
    if tbl.hasBuyNum == nil then
        tbl.hasBuyNumSpecified = false
        tbl.hasBuyNum = 0
    else
        tbl.hasBuyNumSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResActivityConfigChange
---@type activityV2.ResActivityConfigChange
activityV2_adj.metatable_ResActivityConfigChange = {
    _ClassName = "activityV2.ResActivityConfigChange",
}
activityV2_adj.metatable_ResActivityConfigChange.__index = activityV2_adj.metatable_ResActivityConfigChange
--endregion

---@param tbl activityV2.ResActivityConfigChange 待调整的table数据
function activityV2_adj.AdjustResActivityConfigChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResActivityConfigChange)
    if tbl.changedActivityList == nil then
        tbl.changedActivityList = {}
    end
    if tbl.changedGoalList == nil then
        tbl.changedGoalList = {}
    end
end

--region metatable activityV2.ResLuckTreasure
---@type activityV2.ResLuckTreasure
activityV2_adj.metatable_ResLuckTreasure = {
    _ClassName = "activityV2.ResLuckTreasure",
}
activityV2_adj.metatable_ResLuckTreasure.__index = activityV2_adj.metatable_ResLuckTreasure
--endregion

---@param tbl activityV2.ResLuckTreasure 待调整的table数据
function activityV2_adj.AdjustResLuckTreasure(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResLuckTreasure)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.day == nil then
        tbl.daySpecified = false
        tbl.day = 0
    else
        tbl.daySpecified = true
    end
    if tbl.openState == nil then
        tbl.openStateSpecified = false
        tbl.openState = 0
    else
        tbl.openStateSpecified = true
    end
    if tbl.luckyName == nil then
        tbl.luckyNameSpecified = false
        tbl.luckyName = ""
    else
        tbl.luckyNameSpecified = true
    end
    if tbl.luckyNum == nil then
        tbl.luckyNumSpecified = false
        tbl.luckyNum = 0
    else
        tbl.luckyNumSpecified = true
    end
    if tbl.luckNumberList == nil then
        tbl.luckNumberList = {}
    end
end

--region metatable activityV2.ResHuntGiftNum
---@type activityV2.ResHuntGiftNum
activityV2_adj.metatable_ResHuntGiftNum = {
    _ClassName = "activityV2.ResHuntGiftNum",
}
activityV2_adj.metatable_ResHuntGiftNum.__index = activityV2_adj.metatable_ResHuntGiftNum
--endregion

---@param tbl activityV2.ResHuntGiftNum 待调整的table数据
function activityV2_adj.AdjustResHuntGiftNum(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResHuntGiftNum)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable activityV2.ResSpendInfo
---@type activityV2.ResSpendInfo
activityV2_adj.metatable_ResSpendInfo = {
    _ClassName = "activityV2.ResSpendInfo",
}
activityV2_adj.metatable_ResSpendInfo.__index = activityV2_adj.metatable_ResSpendInfo
--endregion

---@param tbl activityV2.ResSpendInfo 待调整的table数据
function activityV2_adj.AdjustResSpendInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSpendInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable activityV2.ResSendTotalLoginDay
---@type activityV2.ResSendTotalLoginDay
activityV2_adj.metatable_ResSendTotalLoginDay = {
    _ClassName = "activityV2.ResSendTotalLoginDay",
}
activityV2_adj.metatable_ResSendTotalLoginDay.__index = activityV2_adj.metatable_ResSendTotalLoginDay
--endregion

---@param tbl activityV2.ResSendTotalLoginDay 待调整的table数据
function activityV2_adj.AdjustResSendTotalLoginDay(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSendTotalLoginDay)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable activityV2.ResSendBossScore
---@type activityV2.ResSendBossScore
activityV2_adj.metatable_ResSendBossScore = {
    _ClassName = "activityV2.ResSendBossScore",
}
activityV2_adj.metatable_ResSendBossScore.__index = activityV2_adj.metatable_ResSendBossScore
--endregion

---@param tbl activityV2.ResSendBossScore 待调整的table数据
function activityV2_adj.AdjustResSendBossScore(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSendBossScore)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.num == nil then
        tbl.numSpecified = false
        tbl.num = 0
    else
        tbl.numSpecified = true
    end
end

--region metatable activityV2.ResSendFirstKillBoss
---@type activityV2.ResSendFirstKillBoss
activityV2_adj.metatable_ResSendFirstKillBoss = {
    _ClassName = "activityV2.ResSendFirstKillBoss",
}
activityV2_adj.metatable_ResSendFirstKillBoss.__index = activityV2_adj.metatable_ResSendFirstKillBoss
--endregion

---@param tbl activityV2.ResSendFirstKillBoss 待调整的table数据
function activityV2_adj.AdjustResSendFirstKillBoss(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSendFirstKillBoss)
    if tbl.rewardInfos == nil then
        tbl.rewardInfos = {}
    else
        if activityV2_adj.AdjustFirstKillRewardInfo ~= nil then
            for i = 1, #tbl.rewardInfos do
                activityV2_adj.AdjustFirstKillRewardInfo(tbl.rewardInfos[i])
            end
        end
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ReqGetFirstKillBossReward
---@type activityV2.ReqGetFirstKillBossReward
activityV2_adj.metatable_ReqGetFirstKillBossReward = {
    _ClassName = "activityV2.ReqGetFirstKillBossReward",
}
activityV2_adj.metatable_ReqGetFirstKillBossReward.__index = activityV2_adj.metatable_ReqGetFirstKillBossReward
--endregion

---@param tbl activityV2.ReqGetFirstKillBossReward 待调整的table数据
function activityV2_adj.AdjustReqGetFirstKillBossReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqGetFirstKillBossReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.cfgId == nil then
        tbl.cfgIdSpecified = false
        tbl.cfgId = 0
    else
        tbl.cfgIdSpecified = true
    end
end

--region metatable activityV2.ResTimeLimitTaskAll
---@type activityV2.ResTimeLimitTaskAll
activityV2_adj.metatable_ResTimeLimitTaskAll = {
    _ClassName = "activityV2.ResTimeLimitTaskAll",
}
activityV2_adj.metatable_ResTimeLimitTaskAll.__index = activityV2_adj.metatable_ResTimeLimitTaskAll
--endregion

---@param tbl activityV2.ResTimeLimitTaskAll 待调整的table数据
function activityV2_adj.AdjustResTimeLimitTaskAll(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResTimeLimitTaskAll)
    if tbl.taskList == nil then
        tbl.taskList = {}
    else
        if activityV2_adj.AdjustlimitTimeTaskInfo ~= nil then
            for i = 1, #tbl.taskList do
                activityV2_adj.AdjustlimitTimeTaskInfo(tbl.taskList[i])
            end
        end
    end
end

--region metatable activityV2.ResUpdateTimeLimitTaskProgress
---@type activityV2.ResUpdateTimeLimitTaskProgress
activityV2_adj.metatable_ResUpdateTimeLimitTaskProgress = {
    _ClassName = "activityV2.ResUpdateTimeLimitTaskProgress",
}
activityV2_adj.metatable_ResUpdateTimeLimitTaskProgress.__index = activityV2_adj.metatable_ResUpdateTimeLimitTaskProgress
--endregion

---@param tbl activityV2.ResUpdateTimeLimitTaskProgress 待调整的table数据
function activityV2_adj.AdjustResUpdateTimeLimitTaskProgress(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResUpdateTimeLimitTaskProgress)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable activityV2.ReqDrawTimeLimitTaskReward
---@type activityV2.ReqDrawTimeLimitTaskReward
activityV2_adj.metatable_ReqDrawTimeLimitTaskReward = {
    _ClassName = "activityV2.ReqDrawTimeLimitTaskReward",
}
activityV2_adj.metatable_ReqDrawTimeLimitTaskReward.__index = activityV2_adj.metatable_ReqDrawTimeLimitTaskReward
--endregion

---@param tbl activityV2.ReqDrawTimeLimitTaskReward 待调整的table数据
function activityV2_adj.AdjustReqDrawTimeLimitTaskReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqDrawTimeLimitTaskReward)
    if tbl.rate == nil then
        tbl.rateSpecified = false
        tbl.rate = 0
    else
        tbl.rateSpecified = true
    end
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable activityV2.ResDrawTimeLimitTaskReward
---@type activityV2.ResDrawTimeLimitTaskReward
activityV2_adj.metatable_ResDrawTimeLimitTaskReward = {
    _ClassName = "activityV2.ResDrawTimeLimitTaskReward",
}
activityV2_adj.metatable_ResDrawTimeLimitTaskReward.__index = activityV2_adj.metatable_ResDrawTimeLimitTaskReward
--endregion

---@param tbl activityV2.ResDrawTimeLimitTaskReward 待调整的table数据
function activityV2_adj.AdjustResDrawTimeLimitTaskReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResDrawTimeLimitTaskReward)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable activityV2.ReqRoleActivityRankInfo
---@type activityV2.ReqRoleActivityRankInfo
activityV2_adj.metatable_ReqRoleActivityRankInfo = {
    _ClassName = "activityV2.ReqRoleActivityRankInfo",
}
activityV2_adj.metatable_ReqRoleActivityRankInfo.__index = activityV2_adj.metatable_ReqRoleActivityRankInfo
--endregion

---@param tbl activityV2.ReqRoleActivityRankInfo 待调整的table数据
function activityV2_adj.AdjustReqRoleActivityRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqRoleActivityRankInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResRoleActivityRankInfo
---@type activityV2.ResRoleActivityRankInfo
activityV2_adj.metatable_ResRoleActivityRankInfo = {
    _ClassName = "activityV2.ResRoleActivityRankInfo",
}
activityV2_adj.metatable_ResRoleActivityRankInfo.__index = activityV2_adj.metatable_ResRoleActivityRankInfo
--endregion

---@param tbl activityV2.ResRoleActivityRankInfo 待调整的table数据
function activityV2_adj.AdjustResRoleActivityRankInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResRoleActivityRankInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.rankParam == nil then
        tbl.rankParamSpecified = false
        tbl.rankParam = 0
    else
        tbl.rankParamSpecified = true
    end
end

--region metatable activityV2.ResSendLuckyWheelInfo
---@type activityV2.ResSendLuckyWheelInfo
activityV2_adj.metatable_ResSendLuckyWheelInfo = {
    _ClassName = "activityV2.ResSendLuckyWheelInfo",
}
activityV2_adj.metatable_ResSendLuckyWheelInfo.__index = activityV2_adj.metatable_ResSendLuckyWheelInfo
--endregion

---@param tbl activityV2.ResSendLuckyWheelInfo 待调整的table数据
function activityV2_adj.AdjustResSendLuckyWheelInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSendLuckyWheelInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.wheelNum == nil then
        tbl.wheelNumSpecified = false
        tbl.wheelNum = 0
    else
        tbl.wheelNumSpecified = true
    end
    if tbl.totalNum == nil then
        tbl.totalNumSpecified = false
        tbl.totalNum = 0
    else
        tbl.totalNumSpecified = true
    end
end

--region metatable activityV2.ReqStartLuckyWheel
---@type activityV2.ReqStartLuckyWheel
activityV2_adj.metatable_ReqStartLuckyWheel = {
    _ClassName = "activityV2.ReqStartLuckyWheel",
}
activityV2_adj.metatable_ReqStartLuckyWheel.__index = activityV2_adj.metatable_ReqStartLuckyWheel
--endregion

---@param tbl activityV2.ReqStartLuckyWheel 待调整的table数据
function activityV2_adj.AdjustReqStartLuckyWheel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqStartLuckyWheel)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResSendLuckyWheelResult
---@type activityV2.ResSendLuckyWheelResult
activityV2_adj.metatable_ResSendLuckyWheelResult = {
    _ClassName = "activityV2.ResSendLuckyWheelResult",
}
activityV2_adj.metatable_ResSendLuckyWheelResult.__index = activityV2_adj.metatable_ResSendLuckyWheelResult
--endregion

---@param tbl activityV2.ResSendLuckyWheelResult 待调整的table数据
function activityV2_adj.AdjustResSendLuckyWheelResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSendLuckyWheelResult)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable activityV2.ReqGetLuckyWheelReward
---@type activityV2.ReqGetLuckyWheelReward
activityV2_adj.metatable_ReqGetLuckyWheelReward = {
    _ClassName = "activityV2.ReqGetLuckyWheelReward",
}
activityV2_adj.metatable_ReqGetLuckyWheelReward.__index = activityV2_adj.metatable_ReqGetLuckyWheelReward
--endregion

---@param tbl activityV2.ReqGetLuckyWheelReward 待调整的table数据
function activityV2_adj.AdjustReqGetLuckyWheelReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqGetLuckyWheelReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResHappySevenDayActivityInfo
---@type activityV2.ResHappySevenDayActivityInfo
activityV2_adj.metatable_ResHappySevenDayActivityInfo = {
    _ClassName = "activityV2.ResHappySevenDayActivityInfo",
}
activityV2_adj.metatable_ResHappySevenDayActivityInfo.__index = activityV2_adj.metatable_ResHappySevenDayActivityInfo
--endregion

---@param tbl activityV2.ResHappySevenDayActivityInfo 待调整的table数据
function activityV2_adj.AdjustResHappySevenDayActivityInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResHappySevenDayActivityInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.dayInfoList == nil then
        tbl.dayInfoList = {}
    else
        if activityV2_adj.AdjustDayInfoOfHappySevenDay ~= nil then
            for i = 1, #tbl.dayInfoList do
                activityV2_adj.AdjustDayInfoOfHappySevenDay(tbl.dayInfoList[i])
            end
        end
    end
end

--region metatable activityV2.ReqDrawHappySevenDayActivityReward
---@type activityV2.ReqDrawHappySevenDayActivityReward
activityV2_adj.metatable_ReqDrawHappySevenDayActivityReward = {
    _ClassName = "activityV2.ReqDrawHappySevenDayActivityReward",
}
activityV2_adj.metatable_ReqDrawHappySevenDayActivityReward.__index = activityV2_adj.metatable_ReqDrawHappySevenDayActivityReward
--endregion

---@param tbl activityV2.ReqDrawHappySevenDayActivityReward 待调整的table数据
function activityV2_adj.AdjustReqDrawHappySevenDayActivityReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqDrawHappySevenDayActivityReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.day == nil then
        tbl.daySpecified = false
        tbl.day = 0
    else
        tbl.daySpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable activityV2.ResHappySevenDayActivityDataChange
---@type activityV2.ResHappySevenDayActivityDataChange
activityV2_adj.metatable_ResHappySevenDayActivityDataChange = {
    _ClassName = "activityV2.ResHappySevenDayActivityDataChange",
}
activityV2_adj.metatable_ResHappySevenDayActivityDataChange.__index = activityV2_adj.metatable_ResHappySevenDayActivityDataChange
--endregion

---@param tbl activityV2.ResHappySevenDayActivityDataChange 待调整的table数据
function activityV2_adj.AdjustResHappySevenDayActivityDataChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResHappySevenDayActivityDataChange)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.day == nil then
        tbl.daySpecified = false
        tbl.day = 0
    else
        tbl.daySpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.completeCount == nil then
        tbl.completeCountSpecified = false
        tbl.completeCount = 0
    else
        tbl.completeCountSpecified = true
    end
    if tbl.total == nil then
        tbl.totalSpecified = false
        tbl.total = 0
    else
        tbl.totalSpecified = true
    end
    if tbl.rewardState == nil then
        tbl.rewardStateSpecified = false
        tbl.rewardState = 0
    else
        tbl.rewardStateSpecified = true
    end
end

--region metatable activityV2.ResOpenConditionActivity
---@type activityV2.ResOpenConditionActivity
activityV2_adj.metatable_ResOpenConditionActivity = {
    _ClassName = "activityV2.ResOpenConditionActivity",
}
activityV2_adj.metatable_ResOpenConditionActivity.__index = activityV2_adj.metatable_ResOpenConditionActivity
--endregion

---@param tbl activityV2.ResOpenConditionActivity 待调整的table数据
function activityV2_adj.AdjustResOpenConditionActivity(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResOpenConditionActivity)
    if tbl.activityList == nil then
        tbl.activityList = {}
    else
        if activityV2_adj.AdjustActivityTimeInfo ~= nil then
            for i = 1, #tbl.activityList do
                activityV2_adj.AdjustActivityTimeInfo(tbl.activityList[i])
            end
        end
    end
end

--region metatable activityV2.ReqRaffle
---@type activityV2.ReqRaffle
activityV2_adj.metatable_ReqRaffle = {
    _ClassName = "activityV2.ReqRaffle",
}
activityV2_adj.metatable_ReqRaffle.__index = activityV2_adj.metatable_ReqRaffle
--endregion

---@param tbl activityV2.ReqRaffle 待调整的table数据
function activityV2_adj.AdjustReqRaffle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqRaffle)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.costType == nil then
        tbl.costTypeSpecified = false
        tbl.costType = 0
    else
        tbl.costTypeSpecified = true
    end
end

--region metatable activityV2.ResRaffleResult
---@type activityV2.ResRaffleResult
activityV2_adj.metatable_ResRaffleResult = {
    _ClassName = "activityV2.ResRaffleResult",
}
activityV2_adj.metatable_ResRaffleResult.__index = activityV2_adj.metatable_ResRaffleResult
--endregion

---@param tbl activityV2.ResRaffleResult 待调整的table数据
function activityV2_adj.AdjustResRaffleResult(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResRaffleResult)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
    if tbl.raffleItemList == nil then
        tbl.raffleItemList = {}
    else
        if activityV2_adj.AdjustRaffleItem ~= nil then
            for i = 1, #tbl.raffleItemList do
                activityV2_adj.AdjustRaffleItem(tbl.raffleItemList[i])
            end
        end
    end
end

--region metatable activityV2.ResActivityBossState
---@type activityV2.ResActivityBossState
activityV2_adj.metatable_ResActivityBossState = {
    _ClassName = "activityV2.ResActivityBossState",
}
activityV2_adj.metatable_ResActivityBossState.__index = activityV2_adj.metatable_ResActivityBossState
--endregion

---@param tbl activityV2.ResActivityBossState 待调整的table数据
function activityV2_adj.AdjustResActivityBossState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResActivityBossState)
    if tbl.duplicateId == nil then
        tbl.duplicateIdSpecified = false
        tbl.duplicateId = 0
    else
        tbl.duplicateIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

--region metatable activityV2.ResCombineSbkUnion
---@type activityV2.ResCombineSbkUnion
activityV2_adj.metatable_ResCombineSbkUnion = {
    _ClassName = "activityV2.ResCombineSbkUnion",
}
activityV2_adj.metatable_ResCombineSbkUnion.__index = activityV2_adj.metatable_ResCombineSbkUnion
--endregion

---@param tbl activityV2.ResCombineSbkUnion 待调整的table数据
function activityV2_adj.AdjustResCombineSbkUnion(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResCombineSbkUnion)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.unionNameList == nil then
        tbl.unionNameList = {}
    end
end

--region metatable activityV2.ResSoulStoneCost
---@type activityV2.ResSoulStoneCost
activityV2_adj.metatable_ResSoulStoneCost = {
    _ClassName = "activityV2.ResSoulStoneCost",
}
activityV2_adj.metatable_ResSoulStoneCost.__index = activityV2_adj.metatable_ResSoulStoneCost
--endregion

---@param tbl activityV2.ResSoulStoneCost 待调整的table数据
function activityV2_adj.AdjustResSoulStoneCost(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSoulStoneCost)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.costNum == nil then
        tbl.costNumSpecified = false
        tbl.costNum = 0
    else
        tbl.costNumSpecified = true
    end
end

--region metatable activityV2.ResCrazyHappy
---@type activityV2.ResCrazyHappy
activityV2_adj.metatable_ResCrazyHappy = {
    _ClassName = "activityV2.ResCrazyHappy",
}
activityV2_adj.metatable_ResCrazyHappy.__index = activityV2_adj.metatable_ResCrazyHappy
--endregion

---@param tbl activityV2.ResCrazyHappy 待调整的table数据
function activityV2_adj.AdjustResCrazyHappy(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResCrazyHappy)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.crazyHappyInfo == nil then
        tbl.crazyHappyInfo = {}
    else
        if activityV2_adj.AdjustCrazyHappyInfo ~= nil then
            for i = 1, #tbl.crazyHappyInfo do
                activityV2_adj.AdjustCrazyHappyInfo(tbl.crazyHappyInfo[i])
            end
        end
    end
    if tbl.crazyHappyValue == nil then
        tbl.crazyHappyValueSpecified = false
        tbl.crazyHappyValue = 0
    else
        tbl.crazyHappyValueSpecified = true
    end
    if tbl.hasDrawIndexList == nil then
        tbl.hasDrawIndexList = {}
    end
end

--region metatable activityV2.ReqDrawCrazyHappyReward
---@type activityV2.ReqDrawCrazyHappyReward
activityV2_adj.metatable_ReqDrawCrazyHappyReward = {
    _ClassName = "activityV2.ReqDrawCrazyHappyReward",
}
activityV2_adj.metatable_ReqDrawCrazyHappyReward.__index = activityV2_adj.metatable_ReqDrawCrazyHappyReward
--endregion

---@param tbl activityV2.ReqDrawCrazyHappyReward 待调整的table数据
function activityV2_adj.AdjustReqDrawCrazyHappyReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqDrawCrazyHappyReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable activityV2.ResCrazyHappyChangeInfo
---@type activityV2.ResCrazyHappyChangeInfo
activityV2_adj.metatable_ResCrazyHappyChangeInfo = {
    _ClassName = "activityV2.ResCrazyHappyChangeInfo",
}
activityV2_adj.metatable_ResCrazyHappyChangeInfo.__index = activityV2_adj.metatable_ResCrazyHappyChangeInfo
--endregion

---@param tbl activityV2.ResCrazyHappyChangeInfo 待调整的table数据
function activityV2_adj.AdjustResCrazyHappyChangeInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResCrazyHappyChangeInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.crazyHappyInfo == nil then
        tbl.crazyHappyInfo = {}
    else
        if activityV2_adj.AdjustCrazyHappyInfo ~= nil then
            for i = 1, #tbl.crazyHappyInfo do
                activityV2_adj.AdjustCrazyHappyInfo(tbl.crazyHappyInfo[i])
            end
        end
    end
    if tbl.crazyHappyValue == nil then
        tbl.crazyHappyValueSpecified = false
        tbl.crazyHappyValue = 0
    else
        tbl.crazyHappyValueSpecified = true
    end
end

--region metatable activityV2.ResCrazyHappyReward
---@type activityV2.ResCrazyHappyReward
activityV2_adj.metatable_ResCrazyHappyReward = {
    _ClassName = "activityV2.ResCrazyHappyReward",
}
activityV2_adj.metatable_ResCrazyHappyReward.__index = activityV2_adj.metatable_ResCrazyHappyReward
--endregion

---@param tbl activityV2.ResCrazyHappyReward 待调整的table数据
function activityV2_adj.AdjustResCrazyHappyReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResCrazyHappyReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.hasDrawIndexList == nil then
        tbl.hasDrawIndexList = {}
    end
end

--region metatable activityV2.ResLimitBuyCount
---@type activityV2.ResLimitBuyCount
activityV2_adj.metatable_ResLimitBuyCount = {
    _ClassName = "activityV2.ResLimitBuyCount",
}
activityV2_adj.metatable_ResLimitBuyCount.__index = activityV2_adj.metatable_ResLimitBuyCount
--endregion

---@param tbl activityV2.ResLimitBuyCount 待调整的table数据
function activityV2_adj.AdjustResLimitBuyCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResLimitBuyCount)
    if tbl.ShouHuLimitBuyInfoList == nil then
        tbl.ShouHuLimitBuyInfoList = {}
    else
        if activityV2_adj.AdjustShouHuLimitBuyInfo ~= nil then
            for i = 1, #tbl.ShouHuLimitBuyInfoList do
                activityV2_adj.AdjustShouHuLimitBuyInfo(tbl.ShouHuLimitBuyInfoList[i])
            end
        end
    end
end

--region metatable activityV2.ResMysticStorePoint
---@type activityV2.ResMysticStorePoint
activityV2_adj.metatable_ResMysticStorePoint = {
    _ClassName = "activityV2.ResMysticStorePoint",
}
activityV2_adj.metatable_ResMysticStorePoint.__index = activityV2_adj.metatable_ResMysticStorePoint
--endregion

---@param tbl activityV2.ResMysticStorePoint 待调整的table数据
function activityV2_adj.AdjustResMysticStorePoint(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResMysticStorePoint)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.point == nil then
        tbl.pointSpecified = false
        tbl.point = 0
    else
        tbl.pointSpecified = true
    end
end

--region metatable activityV2.ResRaffCount
---@type activityV2.ResRaffCount
activityV2_adj.metatable_ResRaffCount = {
    _ClassName = "activityV2.ResRaffCount",
}
activityV2_adj.metatable_ResRaffCount.__index = activityV2_adj.metatable_ResRaffCount
--endregion

---@param tbl activityV2.ResRaffCount 待调整的table数据
function activityV2_adj.AdjustResRaffCount(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResRaffCount)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.totalCount == nil then
        tbl.totalCountSpecified = false
        tbl.totalCount = 0
    else
        tbl.totalCountSpecified = true
    end
end

--region metatable activityV2.ResInvestPlan
---@type activityV2.ResInvestPlan
activityV2_adj.metatable_ResInvestPlan = {
    _ClassName = "activityV2.ResInvestPlan",
}
activityV2_adj.metatable_ResInvestPlan.__index = activityV2_adj.metatable_ResInvestPlan
--endregion

---@param tbl activityV2.ResInvestPlan 待调整的table数据
function activityV2_adj.AdjustResInvestPlan(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResInvestPlan)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.beginTime == nil then
        tbl.beginTimeSpecified = false
        tbl.beginTime = 0
    else
        tbl.beginTimeSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.hasAttend == nil then
        tbl.hasAttendSpecified = false
        tbl.hasAttend = false
    else
        tbl.hasAttendSpecified = true
    end
    if tbl.hasDrawList == nil then
        tbl.hasDrawList = {}
    end
end

--region metatable activityV2.ReqDrawInvestPlanReward
---@type activityV2.ReqDrawInvestPlanReward
activityV2_adj.metatable_ReqDrawInvestPlanReward = {
    _ClassName = "activityV2.ReqDrawInvestPlanReward",
}
activityV2_adj.metatable_ReqDrawInvestPlanReward.__index = activityV2_adj.metatable_ReqDrawInvestPlanReward
--endregion

---@param tbl activityV2.ReqDrawInvestPlanReward 待调整的table数据
function activityV2_adj.AdjustReqDrawInvestPlanReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqDrawInvestPlanReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.dayNo == nil then
        tbl.dayNoSpecified = false
        tbl.dayNo = 0
    else
        tbl.dayNoSpecified = true
    end
end

--region metatable activityV2.ReqCrazyRaffle
---@type activityV2.ReqCrazyRaffle
activityV2_adj.metatable_ReqCrazyRaffle = {
    _ClassName = "activityV2.ReqCrazyRaffle",
}
activityV2_adj.metatable_ReqCrazyRaffle.__index = activityV2_adj.metatable_ReqCrazyRaffle
--endregion

---@param tbl activityV2.ReqCrazyRaffle 待调整的table数据
function activityV2_adj.AdjustReqCrazyRaffle(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqCrazyRaffle)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResCrazyRaffleInfo
---@type activityV2.ResCrazyRaffleInfo
activityV2_adj.metatable_ResCrazyRaffleInfo = {
    _ClassName = "activityV2.ResCrazyRaffleInfo",
}
activityV2_adj.metatable_ResCrazyRaffleInfo.__index = activityV2_adj.metatable_ResCrazyRaffleInfo
--endregion

---@param tbl activityV2.ResCrazyRaffleInfo 待调整的table数据
function activityV2_adj.AdjustResCrazyRaffleInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResCrazyRaffleInfo)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.hasIndexList == nil then
        tbl.hasIndexList = {}
    end
end

--region metatable activityV2.ResGrowTrailInfo
---@type activityV2.ResGrowTrailInfo
activityV2_adj.metatable_ResGrowTrailInfo = {
    _ClassName = "activityV2.ResGrowTrailInfo",
}
activityV2_adj.metatable_ResGrowTrailInfo.__index = activityV2_adj.metatable_ResGrowTrailInfo
--endregion

---@param tbl activityV2.ResGrowTrailInfo 待调整的table数据
function activityV2_adj.AdjustResGrowTrailInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResGrowTrailInfo)
    if tbl.growTrailDailyInfos == nil then
        tbl.growTrailDailyInfos = {}
    else
        if activityV2_adj.AdjustGrowTrailActivityInfo ~= nil then
            for i = 1, #tbl.growTrailDailyInfos do
                activityV2_adj.AdjustGrowTrailActivityInfo(tbl.growTrailDailyInfos[i])
            end
        end
    end
    if tbl.growTrailFinalInfos == nil then
        tbl.growTrailFinalInfos = {}
    else
        if activityV2_adj.AdjustGrowTrailFinalInfo ~= nil then
            for i = 1, #tbl.growTrailFinalInfos do
                activityV2_adj.AdjustGrowTrailFinalInfo(tbl.growTrailFinalInfos[i])
            end
        end
    end
    if tbl.completeCount == nil then
        tbl.completeCountSpecified = false
        tbl.completeCount = 0
    else
        tbl.completeCountSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ResGrowTrailDataChange
---@type activityV2.ResGrowTrailDataChange
activityV2_adj.metatable_ResGrowTrailDataChange = {
    _ClassName = "activityV2.ResGrowTrailDataChange",
}
activityV2_adj.metatable_ResGrowTrailDataChange.__index = activityV2_adj.metatable_ResGrowTrailDataChange
--endregion

---@param tbl activityV2.ResGrowTrailDataChange 待调整的table数据
function activityV2_adj.AdjustResGrowTrailDataChange(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResGrowTrailDataChange)
    if tbl.growTrailDataInfo == nil then
        tbl.growTrailDataInfoSpecified = false
        tbl.growTrailDataInfo = nil
    else
        if tbl.growTrailDataInfoSpecified == nil then 
            tbl.growTrailDataInfoSpecified = true
            if activityV2_adj.AdjustGrowTrailActivityInfo ~= nil then
                activityV2_adj.AdjustGrowTrailActivityInfo(tbl.growTrailDataInfo)
            end
        end
    end
    if tbl.completeCount == nil then
        tbl.completeCountSpecified = false
        tbl.completeCount = 0
    else
        tbl.completeCountSpecified = true
    end
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
end

--region metatable activityV2.ReqDrawGrowTrailReward
---@type activityV2.ReqDrawGrowTrailReward
activityV2_adj.metatable_ReqDrawGrowTrailReward = {
    _ClassName = "activityV2.ReqDrawGrowTrailReward",
}
activityV2_adj.metatable_ReqDrawGrowTrailReward.__index = activityV2_adj.metatable_ReqDrawGrowTrailReward
--endregion

---@param tbl activityV2.ReqDrawGrowTrailReward 待调整的table数据
function activityV2_adj.AdjustReqDrawGrowTrailReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqDrawGrowTrailReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.dayNo == nil then
        tbl.dayNoSpecified = false
        tbl.dayNo = 0
    else
        tbl.dayNoSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable activityV2.ReqDrawGrowTrailFinalReward
---@type activityV2.ReqDrawGrowTrailFinalReward
activityV2_adj.metatable_ReqDrawGrowTrailFinalReward = {
    _ClassName = "activityV2.ReqDrawGrowTrailFinalReward",
}
activityV2_adj.metatable_ReqDrawGrowTrailFinalReward.__index = activityV2_adj.metatable_ReqDrawGrowTrailFinalReward
--endregion

---@param tbl activityV2.ReqDrawGrowTrailFinalReward 待调整的table数据
function activityV2_adj.AdjustReqDrawGrowTrailFinalReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqDrawGrowTrailFinalReward)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable activityV2.ResGrowTrailFinalRewardDrawSuccess
---@type activityV2.ResGrowTrailFinalRewardDrawSuccess
activityV2_adj.metatable_ResGrowTrailFinalRewardDrawSuccess = {
    _ClassName = "activityV2.ResGrowTrailFinalRewardDrawSuccess",
}
activityV2_adj.metatable_ResGrowTrailFinalRewardDrawSuccess.__index = activityV2_adj.metatable_ResGrowTrailFinalRewardDrawSuccess
--endregion

---@param tbl activityV2.ResGrowTrailFinalRewardDrawSuccess 待调整的table数据
function activityV2_adj.AdjustResGrowTrailFinalRewardDrawSuccess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResGrowTrailFinalRewardDrawSuccess)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.index == nil then
        tbl.indexSpecified = false
        tbl.index = 0
    else
        tbl.indexSpecified = true
    end
end

--region metatable activityV2.ReqSetChoseTurntable
---@type activityV2.ReqSetChoseTurntable
activityV2_adj.metatable_ReqSetChoseTurntable = {
    _ClassName = "activityV2.ReqSetChoseTurntable",
}
activityV2_adj.metatable_ReqSetChoseTurntable.__index = activityV2_adj.metatable_ReqSetChoseTurntable
--endregion

---@param tbl activityV2.ReqSetChoseTurntable 待调整的table数据
function activityV2_adj.AdjustReqSetChoseTurntable(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqSetChoseTurntable)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.cfgIdList == nil then
        tbl.cfgIdList = {}
    end
end

--region metatable activityV2.ResChoseTurntable
---@type activityV2.ResChoseTurntable
activityV2_adj.metatable_ResChoseTurntable = {
    _ClassName = "activityV2.ResChoseTurntable",
}
activityV2_adj.metatable_ResChoseTurntable.__index = activityV2_adj.metatable_ResChoseTurntable
--endregion

---@param tbl activityV2.ResChoseTurntable 待调整的table数据
function activityV2_adj.AdjustResChoseTurntable(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResChoseTurntable)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.cfgIdList == nil then
        tbl.cfgIdList = {}
    end
end

--region metatable activityV2.BuyLimitedOfferRequest
---@type activityV2.BuyLimitedOfferRequest
activityV2_adj.metatable_BuyLimitedOfferRequest = {
    _ClassName = "activityV2.BuyLimitedOfferRequest",
}
activityV2_adj.metatable_BuyLimitedOfferRequest.__index = activityV2_adj.metatable_BuyLimitedOfferRequest
--endregion

---@param tbl activityV2.BuyLimitedOfferRequest 待调整的table数据
function activityV2_adj.AdjustBuyLimitedOfferRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_BuyLimitedOfferRequest)
end

--region metatable activityV2.ResSaleGiftInfo
---@type activityV2.ResSaleGiftInfo
activityV2_adj.metatable_ResSaleGiftInfo = {
    _ClassName = "activityV2.ResSaleGiftInfo",
}
activityV2_adj.metatable_ResSaleGiftInfo.__index = activityV2_adj.metatable_ResSaleGiftInfo
--endregion

---@param tbl activityV2.ResSaleGiftInfo 待调整的table数据
function activityV2_adj.AdjustResSaleGiftInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResSaleGiftInfo)
    if tbl.info == nil then
        tbl.info = {}
    else
        if activityV2_adj.AdjustBuyLimitInfo ~= nil then
            for i = 1, #tbl.info do
                activityV2_adj.AdjustBuyLimitInfo(tbl.info[i])
            end
        end
    end
end

--region metatable activityV2.BuyLimitInfo
---@type activityV2.BuyLimitInfo
activityV2_adj.metatable_BuyLimitInfo = {
    _ClassName = "activityV2.BuyLimitInfo",
}
activityV2_adj.metatable_BuyLimitInfo.__index = activityV2_adj.metatable_BuyLimitInfo
--endregion

---@param tbl activityV2.BuyLimitInfo 待调整的table数据
function activityV2_adj.AdjustBuyLimitInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_BuyLimitInfo)
    if tbl.isGetReward == nil then
        tbl.isGetRewardSpecified = false
        tbl.isGetReward = false
    else
        tbl.isGetRewardSpecified = true
    end
end

--region metatable activityV2.ActivityOpenTable
---@type activityV2.ActivityOpenTable
activityV2_adj.metatable_ActivityOpenTable = {
    _ClassName = "activityV2.ActivityOpenTable",
}
activityV2_adj.metatable_ActivityOpenTable.__index = activityV2_adj.metatable_ActivityOpenTable
--endregion

---@param tbl activityV2.ActivityOpenTable 待调整的table数据
function activityV2_adj.AdjustActivityOpenTable(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityOpenTable)
    if tbl.activityId == nil then
        tbl.activityId = {}
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
end

--region metatable activityV2.ActivityOpenMsgRequest
---@type activityV2.ActivityOpenMsgRequest
activityV2_adj.metatable_ActivityOpenMsgRequest = {
    _ClassName = "activityV2.ActivityOpenMsgRequest",
}
activityV2_adj.metatable_ActivityOpenMsgRequest.__index = activityV2_adj.metatable_ActivityOpenMsgRequest
--endregion

---@param tbl activityV2.ActivityOpenMsgRequest 待调整的table数据
function activityV2_adj.AdjustActivityOpenMsgRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityOpenMsgRequest)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
end

--region metatable activityV2.ResActivityMonsterRankScoreList
---@type activityV2.ResActivityMonsterRankScoreList
activityV2_adj.metatable_ResActivityMonsterRankScoreList = {
    _ClassName = "activityV2.ResActivityMonsterRankScoreList",
}
activityV2_adj.metatable_ResActivityMonsterRankScoreList.__index = activityV2_adj.metatable_ResActivityMonsterRankScoreList
--endregion

---@param tbl activityV2.ResActivityMonsterRankScoreList 待调整的table数据
function activityV2_adj.AdjustResActivityMonsterRankScoreList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResActivityMonsterRankScoreList)
    if tbl.info == nil then
        tbl.info = {}
    else
        if activityV2_adj.AdjustRankInfo ~= nil then
            for i = 1, #tbl.info do
                activityV2_adj.AdjustRankInfo(tbl.info[i])
            end
        end
    end
end

--region metatable activityV2.ResActivityMonsterAttackTimesInfo
---@type activityV2.ResActivityMonsterAttackTimesInfo
activityV2_adj.metatable_ResActivityMonsterAttackTimesInfo = {
    _ClassName = "activityV2.ResActivityMonsterAttackTimesInfo",
}
activityV2_adj.metatable_ResActivityMonsterAttackTimesInfo.__index = activityV2_adj.metatable_ResActivityMonsterAttackTimesInfo
--endregion

---@param tbl activityV2.ResActivityMonsterAttackTimesInfo 待调整的table数据
function activityV2_adj.AdjustResActivityMonsterAttackTimesInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResActivityMonsterAttackTimesInfo)
    if tbl.subTime == nil then
        tbl.subTimeSpecified = false
        tbl.subTime = 0
    else
        tbl.subTimeSpecified = true
    end
    if tbl.waveId == nil then
        tbl.waveId = {}
    end
end

--region metatable activityV2.ResActivityMonsterStage
---@type activityV2.ResActivityMonsterStage
activityV2_adj.metatable_ResActivityMonsterStage = {
    _ClassName = "activityV2.ResActivityMonsterStage",
}
activityV2_adj.metatable_ResActivityMonsterStage.__index = activityV2_adj.metatable_ResActivityMonsterStage
--endregion

---@param tbl activityV2.ResActivityMonsterStage 待调整的table数据
function activityV2_adj.AdjustResActivityMonsterStage(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResActivityMonsterStage)
end

--region metatable activityV2.ResActivityMonsterKillBossRank
---@type activityV2.ResActivityMonsterKillBossRank
activityV2_adj.metatable_ResActivityMonsterKillBossRank = {
    _ClassName = "activityV2.ResActivityMonsterKillBossRank",
}
activityV2_adj.metatable_ResActivityMonsterKillBossRank.__index = activityV2_adj.metatable_ResActivityMonsterKillBossRank
--endregion

---@param tbl activityV2.ResActivityMonsterKillBossRank 待调整的table数据
function activityV2_adj.AdjustResActivityMonsterKillBossRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResActivityMonsterKillBossRank)
    if tbl.info == nil then
        tbl.info = {}
    else
        if activityV2_adj.AdjustRankInfo ~= nil then
            for i = 1, #tbl.info do
                activityV2_adj.AdjustRankInfo(tbl.info[i])
            end
        end
    end
end

--region metatable activityV2.ReqGatherActivityMonsterBox
---@type activityV2.ReqGatherActivityMonsterBox
activityV2_adj.metatable_ReqGatherActivityMonsterBox = {
    _ClassName = "activityV2.ReqGatherActivityMonsterBox",
}
activityV2_adj.metatable_ReqGatherActivityMonsterBox.__index = activityV2_adj.metatable_ReqGatherActivityMonsterBox
--endregion

---@param tbl activityV2.ReqGatherActivityMonsterBox 待调整的table数据
function activityV2_adj.AdjustReqGatherActivityMonsterBox(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqGatherActivityMonsterBox)
end

--region metatable activityV2.ResDefendKingActivityInfo
---@type activityV2.ResDefendKingActivityInfo
activityV2_adj.metatable_ResDefendKingActivityInfo = {
    _ClassName = "activityV2.ResDefendKingActivityInfo",
}
activityV2_adj.metatable_ResDefendKingActivityInfo.__index = activityV2_adj.metatable_ResDefendKingActivityInfo
--endregion

---@param tbl activityV2.ResDefendKingActivityInfo 待调整的table数据
function activityV2_adj.AdjustResDefendKingActivityInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResDefendKingActivityInfo)
    if tbl.list == nil then
        tbl.list = {}
    else
        if activityV2_adj.AdjustDefendUnionInfo ~= nil then
            for i = 1, #tbl.list do
                activityV2_adj.AdjustDefendUnionInfo(tbl.list[i])
            end
        end
    end
    if tbl.myScore == nil then
        tbl.myScoreSpecified = false
        tbl.myScore = 0
    else
        tbl.myScoreSpecified = true
    end
    if tbl.spyScore == nil then
        tbl.spyScoreSpecified = false
        tbl.spyScore = 0
    else
        tbl.spyScoreSpecified = true
    end
    if tbl.endTime == nil then
        tbl.endTimeSpecified = false
        tbl.endTime = 0
    else
        tbl.endTimeSpecified = true
    end
    if tbl.kingHpPer == nil then
        tbl.kingHpPerSpecified = false
        tbl.kingHpPer = 0
    else
        tbl.kingHpPerSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
end

--region metatable activityV2.DefendUnionInfo
---@type activityV2.DefendUnionInfo
activityV2_adj.metatable_DefendUnionInfo = {
    _ClassName = "activityV2.DefendUnionInfo",
}
activityV2_adj.metatable_DefendUnionInfo.__index = activityV2_adj.metatable_DefendUnionInfo
--endregion

---@param tbl activityV2.DefendUnionInfo 待调整的table数据
function activityV2_adj.AdjustDefendUnionInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_DefendUnionInfo)
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.unionScore == nil then
        tbl.unionScoreSpecified = false
        tbl.unionScore = 0
    else
        tbl.unionScoreSpecified = true
    end
    if tbl.totalScore == nil then
        tbl.totalScoreSpecified = false
        tbl.totalScore = 0
    else
        tbl.totalScoreSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
end

--region metatable activityV2.ResDefendUpdateScore
---@type activityV2.ResDefendUpdateScore
activityV2_adj.metatable_ResDefendUpdateScore = {
    _ClassName = "activityV2.ResDefendUpdateScore",
}
activityV2_adj.metatable_ResDefendUpdateScore.__index = activityV2_adj.metatable_ResDefendUpdateScore
--endregion

---@param tbl activityV2.ResDefendUpdateScore 待调整的table数据
function activityV2_adj.AdjustResDefendUpdateScore(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResDefendUpdateScore)
    if tbl.type == nil then
        tbl.typeSpecified = false
        tbl.type = 0
    else
        tbl.typeSpecified = true
    end
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
    if tbl.kingId == nil then
        tbl.kingIdSpecified = false
        tbl.kingId = 0
    else
        tbl.kingIdSpecified = true
    end
end

--region metatable activityV2.DefendRank
---@type activityV2.DefendRank
activityV2_adj.metatable_DefendRank = {
    _ClassName = "activityV2.DefendRank",
}
activityV2_adj.metatable_DefendRank.__index = activityV2_adj.metatable_DefendRank
--endregion

---@param tbl activityV2.DefendRank 待调整的table数据
function activityV2_adj.AdjustDefendRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_DefendRank)
    if tbl.selfInfos == nil then
        tbl.selfInfos = {}
    else
        if activityV2_adj.AdjustDefendRankPlayerInfo ~= nil then
            for i = 1, #tbl.selfInfos do
                activityV2_adj.AdjustDefendRankPlayerInfo(tbl.selfInfos[i])
            end
        end
    end
    if tbl.otherInfos == nil then
        tbl.otherInfos = {}
    else
        if activityV2_adj.AdjustDefendRankPlayerInfo ~= nil then
            for i = 1, #tbl.otherInfos do
                activityV2_adj.AdjustDefendRankPlayerInfo(tbl.otherInfos[i])
            end
        end
    end
    if tbl.common == nil then
        tbl.commonSpecified = false
        tbl.common = nil
    else
        if tbl.commonSpecified == nil then 
            tbl.commonSpecified = true
            if activityV2_adj.AdjustDefendRankCommon ~= nil then
                activityV2_adj.AdjustDefendRankCommon(tbl.common)
            end
        end
    end
end

--region metatable activityV2.DefendRankPlayerInfo
---@type activityV2.DefendRankPlayerInfo
activityV2_adj.metatable_DefendRankPlayerInfo = {
    _ClassName = "activityV2.DefendRankPlayerInfo",
}
activityV2_adj.metatable_DefendRankPlayerInfo.__index = activityV2_adj.metatable_DefendRankPlayerInfo
--endregion

---@param tbl activityV2.DefendRankPlayerInfo 待调整的table数据
function activityV2_adj.AdjustDefendRankPlayerInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_DefendRankPlayerInfo)
    if tbl.rid == nil then
        tbl.ridSpecified = false
        tbl.rid = 0
    else
        tbl.ridSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.career == nil then
        tbl.careerSpecified = false
        tbl.career = 0
    else
        tbl.careerSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.level == nil then
        tbl.levelSpecified = false
        tbl.level = 0
    else
        tbl.levelSpecified = true
    end
    if tbl.killSmall == nil then
        tbl.killSmallSpecified = false
        tbl.killSmall = 0
    else
        tbl.killSmallSpecified = true
    end
    if tbl.killBig == nil then
        tbl.killBigSpecified = false
        tbl.killBig = 0
    else
        tbl.killBigSpecified = true
    end
    if tbl.killNum == nil then
        tbl.killNumSpecified = false
        tbl.killNum = 0
    else
        tbl.killNumSpecified = true
    end
    if tbl.diedNum == nil then
        tbl.diedNumSpecified = false
        tbl.diedNum = 0
    else
        tbl.diedNumSpecified = true
    end
    if tbl.grade == nil then
        tbl.gradeSpecified = false
        tbl.grade = 0
    else
        tbl.gradeSpecified = true
    end
    if tbl.unionId == nil then
        tbl.unionIdSpecified = false
        tbl.unionId = 0
    else
        tbl.unionIdSpecified = true
    end
    if tbl.unionName == nil then
        tbl.unionNameSpecified = false
        tbl.unionName = ""
    else
        tbl.unionNameSpecified = true
    end
    if tbl.titleType == nil then
        tbl.titleTypeSpecified = false
        tbl.titleType = 0
    else
        tbl.titleTypeSpecified = true
    end
    if tbl.like == nil then
        tbl.like = {}
    end
end

--region metatable activityV2.DefendRankCommon
---@type activityV2.DefendRankCommon
activityV2_adj.metatable_DefendRankCommon = {
    _ClassName = "activityV2.DefendRankCommon",
}
activityV2_adj.metatable_DefendRankCommon.__index = activityV2_adj.metatable_DefendRankCommon
--endregion

---@param tbl activityV2.DefendRankCommon 待调整的table数据
function activityV2_adj.AdjustDefendRankCommon(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_DefendRankCommon)
    if tbl.totalKillSmall == nil then
        tbl.totalKillSmallSpecified = false
        tbl.totalKillSmall = 0
    else
        tbl.totalKillSmallSpecified = true
    end
    if tbl.totalKillBig == nil then
        tbl.totalKillBigSpecified = false
        tbl.totalKillBig = 0
    else
        tbl.totalKillBigSpecified = true
    end
    if tbl.totalKill == nil then
        tbl.totalKillSpecified = false
        tbl.totalKill = 0
    else
        tbl.totalKillSpecified = true
    end
    if tbl.totalDied == nil then
        tbl.totalDiedSpecified = false
        tbl.totalDied = 0
    else
        tbl.totalDiedSpecified = true
    end
    if tbl.rankSmall == nil then
        tbl.rankSmallSpecified = false
        tbl.rankSmall = 0
    else
        tbl.rankSmallSpecified = true
    end
    if tbl.rankBig == nil then
        tbl.rankBigSpecified = false
        tbl.rankBig = 0
    else
        tbl.rankBigSpecified = true
    end
    if tbl.rankKill == nil then
        tbl.rankKillSpecified = false
        tbl.rankKill = 0
    else
        tbl.rankKillSpecified = true
    end
    if tbl.rankDied == nil then
        tbl.rankDiedSpecified = false
        tbl.rankDied = 0
    else
        tbl.rankDiedSpecified = true
    end
    if tbl.rankGrade == nil then
        tbl.rankGradeSpecified = false
        tbl.rankGrade = 0
    else
        tbl.rankGradeSpecified = true
    end
    if tbl.kingDied == nil then
        tbl.kingDiedSpecified = false
        tbl.kingDied = 0
    else
        tbl.kingDiedSpecified = true
    end
    if tbl.lastFirstUnionName == nil then
        tbl.lastFirstUnionNameSpecified = false
        tbl.lastFirstUnionName = ""
    else
        tbl.lastFirstUnionNameSpecified = true
    end
end

--region metatable activityV2.ResDefendOver
---@type activityV2.ResDefendOver
activityV2_adj.metatable_ResDefendOver = {
    _ClassName = "activityV2.ResDefendOver",
}
activityV2_adj.metatable_ResDefendOver.__index = activityV2_adj.metatable_ResDefendOver
--endregion

---@param tbl activityV2.ResDefendOver 待调整的table数据
function activityV2_adj.AdjustResDefendOver(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResDefendOver)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = nil
    else
        if tbl.rankSpecified == nil then 
            tbl.rankSpecified = true
            if activityV2_adj.AdjustDefendRank ~= nil then
                activityV2_adj.AdjustDefendRank(tbl.rank)
            end
        end
    end
    if tbl.showTime == nil then
        tbl.showTimeSpecified = false
        tbl.showTime = 0
    else
        tbl.showTimeSpecified = true
    end
end

--region metatable activityV2.ResDefendLastRank
---@type activityV2.ResDefendLastRank
activityV2_adj.metatable_ResDefendLastRank = {
    _ClassName = "activityV2.ResDefendLastRank",
}
activityV2_adj.metatable_ResDefendLastRank.__index = activityV2_adj.metatable_ResDefendLastRank
--endregion

---@param tbl activityV2.ResDefendLastRank 待调整的table数据
function activityV2_adj.AdjustResDefendLastRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResDefendLastRank)
    if tbl.rank == nil then
        tbl.rankSpecified = false
        tbl.rank = nil
    else
        if tbl.rankSpecified == nil then 
            tbl.rankSpecified = true
            if activityV2_adj.AdjustDefendRank ~= nil then
                activityV2_adj.AdjustDefendRank(tbl.rank)
            end
        end
    end
end

--region metatable activityV2.ResDailyActivityStatusChanged
---@type activityV2.ResDailyActivityStatusChanged
activityV2_adj.metatable_ResDailyActivityStatusChanged = {
    _ClassName = "activityV2.ResDailyActivityStatusChanged",
}
activityV2_adj.metatable_ResDailyActivityStatusChanged.__index = activityV2_adj.metatable_ResDailyActivityStatusChanged
--endregion

---@param tbl activityV2.ResDailyActivityStatusChanged 待调整的table数据
function activityV2_adj.AdjustResDailyActivityStatusChanged(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResDailyActivityStatusChanged)
    if tbl.zeroTime == nil then
        tbl.zeroTimeSpecified = false
        tbl.zeroTime = 0
    else
        tbl.zeroTimeSpecified = true
    end
end

--region metatable activityV2.ResAllActivityCommonStatus
---@type activityV2.ResAllActivityCommonStatus
activityV2_adj.metatable_ResAllActivityCommonStatus = {
    _ClassName = "activityV2.ResAllActivityCommonStatus",
}
activityV2_adj.metatable_ResAllActivityCommonStatus.__index = activityV2_adj.metatable_ResAllActivityCommonStatus
--endregion

---@param tbl activityV2.ResAllActivityCommonStatus 待调整的table数据
function activityV2_adj.AdjustResAllActivityCommonStatus(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResAllActivityCommonStatus)
    if tbl.statusList == nil then
        tbl.statusList = {}
    else
        if activityV2_adj.AdjustActivityCommonStatus ~= nil then
            for i = 1, #tbl.statusList do
                activityV2_adj.AdjustActivityCommonStatus(tbl.statusList[i])
            end
        end
    end
end

--region metatable activityV2.ActivityCommonStatus
---@type activityV2.ActivityCommonStatus
activityV2_adj.metatable_ActivityCommonStatus = {
    _ClassName = "activityV2.ActivityCommonStatus",
}
activityV2_adj.metatable_ActivityCommonStatus.__index = activityV2_adj.metatable_ActivityCommonStatus
--endregion

---@param tbl activityV2.ActivityCommonStatus 待调整的table数据
function activityV2_adj.AdjustActivityCommonStatus(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityCommonStatus)
    if tbl.activityId == nil then
        tbl.activityIdSpecified = false
        tbl.activityId = 0
    else
        tbl.activityIdSpecified = true
    end
    if tbl.status == nil then
        tbl.statusSpecified = false
        tbl.status = 0
    else
        tbl.statusSpecified = true
    end
end

--region metatable activityV2.BossScoreRewards
---@type activityV2.BossScoreRewards
activityV2_adj.metatable_BossScoreRewards = {
    _ClassName = "activityV2.BossScoreRewards",
}
activityV2_adj.metatable_BossScoreRewards.__index = activityV2_adj.metatable_BossScoreRewards
--endregion

---@param tbl activityV2.BossScoreRewards 待调整的table数据
function activityV2_adj.AdjustBossScoreRewards(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_BossScoreRewards)
    if tbl.killCount == nil then
        tbl.killCountSpecified = false
        tbl.killCount = 0
    else
        tbl.killCountSpecified = true
    end
end

--region metatable activityV2.BossScoreRes
---@type activityV2.BossScoreRes
activityV2_adj.metatable_BossScoreRes = {
    _ClassName = "activityV2.BossScoreRes",
}
activityV2_adj.metatable_BossScoreRes.__index = activityV2_adj.metatable_BossScoreRes
--endregion

---@param tbl activityV2.BossScoreRes 待调整的table数据
function activityV2_adj.AdjustBossScoreRes(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_BossScoreRes)
    if tbl.score == nil then
        tbl.scoreSpecified = false
        tbl.score = 0
    else
        tbl.scoreSpecified = true
    end
    if tbl.day == nil then
        tbl.daySpecified = false
        tbl.day = 0
    else
        tbl.daySpecified = true
    end
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if activityV2_adj.AdjustBossScoreRewards ~= nil then
            for i = 1, #tbl.rewards do
                activityV2_adj.AdjustBossScoreRewards(tbl.rewards[i])
            end
        end
    end
    if tbl.isCard == nil then
        tbl.isCardSpecified = false
        tbl.isCard = false
    else
        tbl.isCardSpecified = true
    end
end

--region metatable activityV2.GetBossScoreReward
---@type activityV2.GetBossScoreReward
activityV2_adj.metatable_GetBossScoreReward = {
    _ClassName = "activityV2.GetBossScoreReward",
}
activityV2_adj.metatable_GetBossScoreReward.__index = activityV2_adj.metatable_GetBossScoreReward
--endregion

---@param tbl activityV2.GetBossScoreReward 待调整的table数据
function activityV2_adj.AdjustGetBossScoreReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_GetBossScoreReward)
end

--region metatable activityV2.TheActivityHasRewarded
---@type activityV2.TheActivityHasRewarded
activityV2_adj.metatable_TheActivityHasRewarded = {
    _ClassName = "activityV2.TheActivityHasRewarded",
}
activityV2_adj.metatable_TheActivityHasRewarded.__index = activityV2_adj.metatable_TheActivityHasRewarded
--endregion

---@param tbl activityV2.TheActivityHasRewarded 待调整的table数据
function activityV2_adj.AdjustTheActivityHasRewarded(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_TheActivityHasRewarded)
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if activityV2_adj.AdjustActivityRewards ~= nil then
            for i = 1, #tbl.rewards do
                activityV2_adj.AdjustActivityRewards(tbl.rewards[i])
            end
        end
    end
    if tbl.fromModule == nil then
        tbl.fromModuleSpecified = false
        tbl.fromModule = 0
    else
        tbl.fromModuleSpecified = true
    end
    if tbl.success == nil then
        tbl.successSpecified = false
        tbl.success = false
    else
        tbl.successSpecified = true
    end
end

--region metatable activityV2.ActivityRewards
---@type activityV2.ActivityRewards
activityV2_adj.metatable_ActivityRewards = {
    _ClassName = "activityV2.ActivityRewards",
}
activityV2_adj.metatable_ActivityRewards.__index = activityV2_adj.metatable_ActivityRewards
--endregion

---@param tbl activityV2.ActivityRewards 待调整的table数据
function activityV2_adj.AdjustActivityRewards(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ActivityRewards)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable activityV2.ServerRoleReward
---@type activityV2.ServerRoleReward
activityV2_adj.metatable_ServerRoleReward = {
    _ClassName = "activityV2.ServerRoleReward",
}
activityV2_adj.metatable_ServerRoleReward.__index = activityV2_adj.metatable_ServerRoleReward
--endregion

---@param tbl activityV2.ServerRoleReward 待调整的table数据
function activityV2_adj.AdjustServerRoleReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ServerRoleReward)
    if tbl.randomRewards == nil then
        tbl.randomRewards = {}
    else
        if activityV2_adj.AdjustItemCountInfo ~= nil then
            for i = 1, #tbl.randomRewards do
                activityV2_adj.AdjustItemCountInfo(tbl.randomRewards[i])
            end
        end
    end
    if tbl.rewardHistorys == nil then
        tbl.rewardHistorys = {}
    else
        if activityV2_adj.AdjustServerRoleRed ~= nil then
            for i = 1, #tbl.rewardHistorys do
                activityV2_adj.AdjustServerRoleRed(tbl.rewardHistorys[i])
            end
        end
    end
end

--region metatable activityV2.ServerRoleFinish
---@type activityV2.ServerRoleFinish
activityV2_adj.metatable_ServerRoleFinish = {
    _ClassName = "activityV2.ServerRoleFinish",
}
activityV2_adj.metatable_ServerRoleFinish.__index = activityV2_adj.metatable_ServerRoleFinish
--endregion

---@param tbl activityV2.ServerRoleFinish 待调整的table数据
function activityV2_adj.AdjustServerRoleFinish(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ServerRoleFinish)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.sex == nil then
        tbl.sexSpecified = false
        tbl.sex = 0
    else
        tbl.sexSpecified = true
    end
    if tbl.carrer == nil then
        tbl.carrerSpecified = false
        tbl.carrer = 0
    else
        tbl.carrerSpecified = true
    end
end

--region metatable activityV2.ServerRoleRed
---@type activityV2.ServerRoleRed
activityV2_adj.metatable_ServerRoleRed = {
    _ClassName = "activityV2.ServerRoleRed",
}
activityV2_adj.metatable_ServerRoleRed.__index = activityV2_adj.metatable_ServerRoleRed
--endregion

---@param tbl activityV2.ServerRoleRed 待调整的table数据
function activityV2_adj.AdjustServerRoleRed(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ServerRoleRed)
    if tbl.roleId == nil then
        tbl.roleIdSpecified = false
        tbl.roleId = 0
    else
        tbl.roleIdSpecified = true
    end
    if tbl.name == nil then
        tbl.nameSpecified = false
        tbl.name = ""
    else
        tbl.nameSpecified = true
    end
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if activityV2_adj.AdjustItemCountInfo ~= nil then
            for i = 1, #tbl.rewards do
                activityV2_adj.AdjustItemCountInfo(tbl.rewards[i])
            end
        end
    end
end

--region metatable activityV2.ItemCountInfo
---@type activityV2.ItemCountInfo
activityV2_adj.metatable_ItemCountInfo = {
    _ClassName = "activityV2.ItemCountInfo",
}
activityV2_adj.metatable_ItemCountInfo.__index = activityV2_adj.metatable_ItemCountInfo
--endregion

---@param tbl activityV2.ItemCountInfo 待调整的table数据
function activityV2_adj.AdjustItemCountInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ItemCountInfo)
    if tbl.itemId == nil then
        tbl.itemIdSpecified = false
        tbl.itemId = 0
    else
        tbl.itemIdSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable activityV2.ResDefendRankList
---@type activityV2.ResDefendRankList
activityV2_adj.metatable_ResDefendRankList = {
    _ClassName = "activityV2.ResDefendRankList",
}
activityV2_adj.metatable_ResDefendRankList.__index = activityV2_adj.metatable_ResDefendRankList
--endregion

---@param tbl activityV2.ResDefendRankList 待调整的table数据
function activityV2_adj.AdjustResDefendRankList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResDefendRankList)
    if tbl.time == nil then
        tbl.time = {}
    end
end

--region metatable activityV2.ReqDefendLastRank
---@type activityV2.ReqDefendLastRank
activityV2_adj.metatable_ReqDefendLastRank = {
    _ClassName = "activityV2.ReqDefendLastRank",
}
activityV2_adj.metatable_ReqDefendLastRank.__index = activityV2_adj.metatable_ReqDefendLastRank
--endregion

---@param tbl activityV2.ReqDefendLastRank 待调整的table数据
function activityV2_adj.AdjustReqDefendLastRank(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqDefendLastRank)
end

--region metatable activityV2.ResTodayClosedActivities
---@type activityV2.ResTodayClosedActivities
activityV2_adj.metatable_ResTodayClosedActivities = {
    _ClassName = "activityV2.ResTodayClosedActivities",
}
activityV2_adj.metatable_ResTodayClosedActivities.__index = activityV2_adj.metatable_ResTodayClosedActivities
--endregion

---@param tbl activityV2.ResTodayClosedActivities 待调整的table数据
function activityV2_adj.AdjustResTodayClosedActivities(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResTodayClosedActivities)
    if tbl.activityType == nil then
        tbl.activityType = {}
    end
end

--region metatable activityV2.ResBlackIronCost
---@type activityV2.ResBlackIronCost
activityV2_adj.metatable_ResBlackIronCost = {
    _ClassName = "activityV2.ResBlackIronCost",
}
activityV2_adj.metatable_ResBlackIronCost.__index = activityV2_adj.metatable_ResBlackIronCost
--endregion

---@param tbl activityV2.ResBlackIronCost 待调整的table数据
function activityV2_adj.AdjustResBlackIronCost(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResBlackIronCost)
    if tbl.blackIronCost == nil then
        tbl.blackIronCostSpecified = false
        tbl.blackIronCost = 0
    else
        tbl.blackIronCostSpecified = true
    end
end

--region metatable activityV2.ResTodayOpenActivities
---@type activityV2.ResTodayOpenActivities
activityV2_adj.metatable_ResTodayOpenActivities = {
    _ClassName = "activityV2.ResTodayOpenActivities",
}
activityV2_adj.metatable_ResTodayOpenActivities.__index = activityV2_adj.metatable_ResTodayOpenActivities
--endregion

---@param tbl activityV2.ResTodayOpenActivities 待调整的table数据
function activityV2_adj.AdjustResTodayOpenActivities(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResTodayOpenActivities)
    if tbl.activityType == nil then
        tbl.activityType = {}
    end
end

--region metatable activityV2.ReqReceiveGift
---@type activityV2.ReqReceiveGift
activityV2_adj.metatable_ReqReceiveGift = {
    _ClassName = "activityV2.ReqReceiveGift",
}
activityV2_adj.metatable_ReqReceiveGift.__index = activityV2_adj.metatable_ReqReceiveGift
--endregion

---@param tbl activityV2.ReqReceiveGift 待调整的table数据
function activityV2_adj.AdjustReqReceiveGift(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ReqReceiveGift)
    if tbl.id == nil then
        tbl.idSpecified = false
        tbl.id = 0
    else
        tbl.idSpecified = true
    end
end

--region metatable activityV2.ResReceivedGiftState
---@type activityV2.ResReceivedGiftState
activityV2_adj.metatable_ResReceivedGiftState = {
    _ClassName = "activityV2.ResReceivedGiftState",
}
activityV2_adj.metatable_ResReceivedGiftState.__index = activityV2_adj.metatable_ResReceivedGiftState
--endregion

---@param tbl activityV2.ResReceivedGiftState 待调整的table数据
function activityV2_adj.AdjustResReceivedGiftState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_ResReceivedGiftState)
    if tbl.id == nil then
        tbl.id = {}
    end
end

--region metatable activityV2.LuckTurntableInfo
---@type activityV2.LuckTurntableInfo
activityV2_adj.metatable_LuckTurntableInfo = {
    _ClassName = "activityV2.LuckTurntableInfo",
}
activityV2_adj.metatable_LuckTurntableInfo.__index = activityV2_adj.metatable_LuckTurntableInfo
--endregion

---@param tbl activityV2.LuckTurntableInfo 待调整的table数据
function activityV2_adj.AdjustLuckTurntableInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_LuckTurntableInfo)
    if tbl.rechargeRmb == nil then
        tbl.rechargeRmbSpecified = false
        tbl.rechargeRmb = 0
    else
        tbl.rechargeRmbSpecified = true
    end
    if tbl.lotteryTimes == nil then
        tbl.lotteryTimesSpecified = false
        tbl.lotteryTimes = 0
    else
        tbl.lotteryTimesSpecified = true
    end
    if tbl.obtains == nil then
        tbl.obtains = {}
    end
    if tbl.rewardIndex == nil then
        tbl.rewardIndexSpecified = false
        tbl.rewardIndex = 0
    else
        tbl.rewardIndexSpecified = true
    end
end

--region metatable activityV2.LotteryReward
---@type activityV2.LotteryReward
activityV2_adj.metatable_LotteryReward = {
    _ClassName = "activityV2.LotteryReward",
}
activityV2_adj.metatable_LotteryReward.__index = activityV2_adj.metatable_LotteryReward
--endregion

---@param tbl activityV2.LotteryReward 待调整的table数据
function activityV2_adj.AdjustLotteryReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, activityV2_adj.metatable_LotteryReward)
    if tbl.rewards == nil then
        tbl.rewards = {}
    else
        if activityV2_adj.AdjustItemCountInfo ~= nil then
            for i = 1, #tbl.rewards do
                activityV2_adj.AdjustItemCountInfo(tbl.rewards[i])
            end
        end
    end
end

return activityV2_adj