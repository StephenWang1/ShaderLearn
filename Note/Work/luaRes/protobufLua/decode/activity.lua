--[[本文件为工具自动生成,禁止手动修改]]
local activityV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData activityV2.ActivityInfo lua中的数据结构
---@return activityV2.ActivityInfo C#中的数据结构
function activityV2.ActivityInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityInfo()
    if decodedData.goalInfo ~= nil and decodedData.goalInfoSpecified ~= false then
        for i = 1, #decodedData.goalInfo do
            data.goalInfo:Add(activityV2.GoalInfo(decodedData.goalInfo[i]))
        end
    end
    return data
end

---@param decodedData activityV2.GoalInfo lua中的数据结构
---@return activityV2.GoalInfo C#中的数据结构
function activityV2.GoalInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.GoalInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.goalType ~= nil and decodedData.goalTypeSpecified ~= false then
        data.goalType = decodedData.goalType
    end
    if decodedData.goal ~= nil and decodedData.goalSpecified ~= false then
        data.goal = decodedData.goal
    end
    if decodedData.rewardState ~= nil and decodedData.rewardStateSpecified ~= false then
        data.rewardState = decodedData.rewardState
    end
    if decodedData.leftCount ~= nil and decodedData.leftCountSpecified ~= false then
        data.leftCount = decodedData.leftCount
    end
    if decodedData.now ~= nil and decodedData.nowSpecified ~= false then
        data.now = decodedData.now
    end
    if decodedData.total ~= nil and decodedData.totalSpecified ~= false then
        data.total = decodedData.total
    end
    return data
end

---@param decodedData activityV2.ResOpenPanel lua中的数据结构
---@return activityV2.ResOpenPanel C#中的数据结构
function activityV2.ResOpenPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResOpenPanel()
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        data.activityType = decodedData.activityType
    end
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = activityV2.ActivityListInfo(decodedData.info)
    end
    return data
end

---@param decodedData activityV2.ActivityListInfo lua中的数据结构
---@return activityV2.ActivityListInfo C#中的数据结构
function activityV2.ActivityListInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityListInfo()
    if decodedData.activityDataInfo ~= nil and decodedData.activityDataInfoSpecified ~= false then
        for i = 1, #decodedData.activityDataInfo do
            data.activityDataInfo:Add(activityV2.ActivityDataInfo(decodedData.activityDataInfo[i]))
        end
    end
    if decodedData.registerNum ~= nil and decodedData.registerNumSpecified ~= false then
        data.registerNum = decodedData.registerNum
    end
    return data
end

---@param decodedData activityV2.ActivityDataInfo lua中的数据结构
---@return activityV2.ActivityDataInfo C#中的数据结构
function activityV2.ActivityDataInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityDataInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.leftCount ~= nil and decodedData.leftCountSpecified ~= false then
        data.leftCount = decodedData.leftCount
    end
    if decodedData.roleGoalInfo ~= nil and decodedData.roleGoalInfoSpecified ~= false then
        data.roleGoalInfo = activityV2.RoleActivityInfo(decodedData.roleGoalInfo)
    end
    if decodedData.serverGoalInfo ~= nil and decodedData.serverGoalInfoSpecified ~= false then
        data.serverGoalInfo = activityV2.ServerActivityInfo(decodedData.serverGoalInfo)
    end
    if decodedData.dataType ~= nil and decodedData.dataTypeSpecified ~= false then
        data.dataType = decodedData.dataType
    end
    return data
end

---@param decodedData activityV2.RoleGoalInfo lua中的数据结构
---@return activityV2.RoleGoalInfo C#中的数据结构
function activityV2.RoleGoalInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.RoleGoalInfo()
    if decodedData.goalId ~= nil and decodedData.goalIdSpecified ~= false then
        data.goalId = decodedData.goalId
    end
    if decodedData.ok ~= nil and decodedData.okSpecified ~= false then
        data.ok = decodedData.ok
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData activityV2.RoleActivityInfo lua中的数据结构
---@return activityV2.RoleActivityInfo C#中的数据结构
function activityV2.RoleActivityInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.RoleActivityInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.rewardState ~= nil and decodedData.rewardStateSpecified ~= false then
        data.rewardState = decodedData.rewardState
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.roleGoalInfos ~= nil and decodedData.roleGoalInfosSpecified ~= false then
        for i = 1, #decodedData.roleGoalInfos do
            data.roleGoalInfos:Add(activityV2.RoleGoalInfo(decodedData.roleGoalInfos[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ServerGoalInfo lua中的数据结构
---@return activityV2.ServerGoalInfo C#中的数据结构
function activityV2.ServerGoalInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ServerGoalInfo()
    if decodedData.goalId ~= nil and decodedData.goalIdSpecified ~= false then
        data.goalId = decodedData.goalId
    end
    if decodedData.ok ~= nil and decodedData.okSpecified ~= false then
        data.ok = decodedData.ok
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.no ~= nil and decodedData.noSpecified ~= false then
        data.no = decodedData.no
    end
    if decodedData.finishRoleId ~= nil and decodedData.finishRoleIdSpecified ~= false then
        data.finishRoleId = decodedData.finishRoleId
    end
    if decodedData.finishName ~= nil and decodedData.finishNameSpecified ~= false then
        data.finishName = decodedData.finishName
    end
    if decodedData.award ~= nil and decodedData.awardSpecified ~= false then
        data.award = decodedData.award
    end
    if decodedData.finishSex ~= nil and decodedData.finishSexSpecified ~= false then
        data.finishSex = decodedData.finishSex
    end
    if decodedData.finishCarrer ~= nil and decodedData.finishCarrerSpecified ~= false then
        data.finishCarrer = decodedData.finishCarrer
    end
    return data
end

---@param decodedData activityV2.ServerActivityInfo lua中的数据结构
---@return activityV2.ServerActivityInfo C#中的数据结构
function activityV2.ServerActivityInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ServerActivityInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.rewardState ~= nil and decodedData.rewardStateSpecified ~= false then
        data.rewardState = decodedData.rewardState
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.serverGoalInfos ~= nil and decodedData.serverGoalInfosSpecified ~= false then
        for i = 1, #decodedData.serverGoalInfos do
            data.serverGoalInfos:Add(activityV2.ServerGoalInfo(decodedData.serverGoalInfos[i]))
        end
    end
    if decodedData.roleCanRewardGoalId ~= nil and decodedData.roleCanRewardGoalIdSpecified ~= false then
        for i = 1, #decodedData.roleCanRewardGoalId do
            data.roleCanRewardGoalId:Add(decodedData.roleCanRewardGoalId[i])
        end
    end
    return data
end

---@param decodedData activityV2.RankInfo lua中的数据结构
---@return activityV2.RankInfo C#中的数据结构
function activityV2.RankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.RankInfo()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = decodedData.rank
    end
    if decodedData.roleName ~= nil and decodedData.roleNameSpecified ~= false then
        data.roleName = decodedData.roleName
    end
    if decodedData.rein ~= nil and decodedData.reinSpecified ~= false then
        data.rein = decodedData.rein
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.award ~= nil and decodedData.awardSpecified ~= false then
        data.award = decodedData.award
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData activityV2.RoleSimpleInfo lua中的数据结构
---@return activityV2.RoleSimpleInfo C#中的数据结构
function activityV2.RoleSimpleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.RoleSimpleInfo()
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.cloth ~= nil and decodedData.clothSpecified ~= false then
        data.cloth = decodedData.cloth
    end
    if decodedData.weapon ~= nil and decodedData.weaponSpecified ~= false then
        data.weapon = decodedData.weapon
    end
    if decodedData.wing ~= nil and decodedData.wingSpecified ~= false then
        data.wing = decodedData.wing
    end
    if decodedData.fashionCloth ~= nil and decodedData.fashionClothSpecified ~= false then
        data.fashionCloth = decodedData.fashionCloth
    end
    if decodedData.fashionWing ~= nil and decodedData.fashionWingSpecified ~= false then
        data.fashionWing = decodedData.fashionWing
    end
    if decodedData.fashionWeapon ~= nil and decodedData.fashionWeaponSpecified ~= false then
        data.fashionWeapon = decodedData.fashionWeapon
    end
    return data
end

---@param decodedData activityV2.ActivityRankInfo lua中的数据结构
---@return activityV2.ActivityRankInfo C#中的数据结构
function activityV2.ActivityRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityRankInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.firstRoleBean ~= nil and decodedData.firstRoleBeanSpecified ~= false then
        data.firstRoleBean = activityV2.RoleSimpleInfo(decodedData.firstRoleBean)
    end
    if decodedData.secondRoleBean ~= nil and decodedData.secondRoleBeanSpecified ~= false then
        data.secondRoleBean = activityV2.RoleSimpleInfo(decodedData.secondRoleBean)
    end
    if decodedData.thirdRoleBean ~= nil and decodedData.thirdRoleBeanSpecified ~= false then
        data.thirdRoleBean = activityV2.RoleSimpleInfo(decodedData.thirdRoleBean)
    end
    if decodedData.rankInfoList ~= nil and decodedData.rankInfoListSpecified ~= false then
        for i = 1, #decodedData.rankInfoList do
            data.rankInfoList:Add(activityV2.RoleSimpleInfo(decodedData.rankInfoList[i]))
        end
    end
    return data
end

---@param decodedData activityV2.FirstKillInfo lua中的数据结构
---@return activityV2.FirstKillInfo C#中的数据结构
function activityV2.FirstKillInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.FirstKillInfo()
    if decodedData.instanceId ~= nil and decodedData.instanceIdSpecified ~= false then
        data.instanceId = decodedData.instanceId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData activityV2.FirstKillRewardInfo lua中的数据结构
---@return activityV2.FirstKillRewardInfo C#中的数据结构
function activityV2.FirstKillRewardInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.FirstKillRewardInfo()
    if decodedData.KillInfos ~= nil and decodedData.KillInfosSpecified ~= false then
        for i = 1, #decodedData.KillInfos do
            data.KillInfos:Add(activityV2.FirstKillInfo(decodedData.KillInfos[i]))
        end
    end
    if decodedData.reward ~= nil and decodedData.rewardSpecified ~= false then
        data.reward = decodedData.reward
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData activityV2.limitTimeTaskInfo lua中的数据结构
---@return activityV2.limitTimeTaskInfo C#中的数据结构
function activityV2.limitTimeTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.limitTimeTaskInfo()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    if decodedData.taskValue ~= nil and decodedData.taskValueSpecified ~= false then
        data.taskValue = decodedData.taskValue
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData activityV2.DayInfoOfHappySevenDay lua中的数据结构
---@return activityV2.DayInfoOfHappySevenDay C#中的数据结构
function activityV2.DayInfoOfHappySevenDay(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.DayInfoOfHappySevenDay()
    if decodedData.day ~= nil and decodedData.daySpecified ~= false then
        data.day = decodedData.day
    end
    if decodedData.groupInfo ~= nil and decodedData.groupInfoSpecified ~= false then
        for i = 1, #decodedData.groupInfo do
            data.groupInfo:Add(activityV2.GroupInfoOfDay(decodedData.groupInfo[i]))
        end
    end
    return data
end

---@param decodedData activityV2.GroupInfoOfDay lua中的数据结构
---@return activityV2.GroupInfoOfDay C#中的数据结构
function activityV2.GroupInfoOfDay(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.GroupInfoOfDay()
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.indexInfo ~= nil and decodedData.indexInfoSpecified ~= false then
        for i = 1, #decodedData.indexInfo do
            data.indexInfo:Add(activityV2.IndexInfoOfDay(decodedData.indexInfo[i]))
        end
    end
    return data
end

---@param decodedData activityV2.IndexInfoOfDay lua中的数据结构
---@return activityV2.IndexInfoOfDay C#中的数据结构
function activityV2.IndexInfoOfDay(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.IndexInfoOfDay()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.day ~= nil and decodedData.daySpecified ~= false then
        data.day = decodedData.day
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.goal ~= nil and decodedData.goalSpecified ~= false then
        data.goal = decodedData.goal
    end
    if decodedData.completeCount ~= nil and decodedData.completeCountSpecified ~= false then
        data.completeCount = decodedData.completeCount
    end
    if decodedData.total ~= nil and decodedData.totalSpecified ~= false then
        data.total = decodedData.total
    end
    if decodedData.rewardState ~= nil and decodedData.rewardStateSpecified ~= false then
        data.rewardState = decodedData.rewardState
    end
    return data
end

---@param decodedData activityV2.ActivityTimeInfo lua中的数据结构
---@return activityV2.ActivityTimeInfo C#中的数据结构
function activityV2.ActivityTimeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityTimeInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.beginTime ~= nil and decodedData.beginTimeSpecified ~= false then
        data.beginTime = decodedData.beginTime
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    return data
end

---@param decodedData activityV2.RaffleItem lua中的数据结构
---@return activityV2.RaffleItem C#中的数据结构
function activityV2.RaffleItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.RaffleItem()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData activityV2.CrazyHappyInfo lua中的数据结构
---@return activityV2.CrazyHappyInfo C#中的数据结构
function activityV2.CrazyHappyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.CrazyHappyInfo()
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.status ~= nil and decodedData.statusSpecified ~= false then
        data.status = decodedData.status
    end
    if decodedData.curCount ~= nil and decodedData.curCountSpecified ~= false then
        data.curCount = decodedData.curCount
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    return data
end

---@param decodedData activityV2.ShouHuLimitBuyInfo lua中的数据结构
---@return activityV2.ShouHuLimitBuyInfo C#中的数据结构
function activityV2.ShouHuLimitBuyInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ShouHuLimitBuyInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.lifeCount ~= nil and decodedData.lifeCountSpecified ~= false then
        data.lifeCount = decodedData.lifeCount
    end
    if decodedData.leftCount ~= nil and decodedData.leftCountSpecified ~= false then
        data.leftCount = decodedData.leftCount
    end
    return data
end

---@param decodedData activityV2.GrowTrailActivityInfo lua中的数据结构
---@return activityV2.GrowTrailActivityInfo C#中的数据结构
function activityV2.GrowTrailActivityInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.GrowTrailActivityInfo()
    if decodedData.dayNo ~= nil and decodedData.dayNoSpecified ~= false then
        data.dayNo = decodedData.dayNo
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.curCount ~= nil and decodedData.curCountSpecified ~= false then
        data.curCount = decodedData.curCount
    end
    if decodedData.rewardState ~= nil and decodedData.rewardStateSpecified ~= false then
        data.rewardState = decodedData.rewardState
    end
    return data
end

---@param decodedData activityV2.GrowTrailFinalInfo lua中的数据结构
---@return activityV2.GrowTrailFinalInfo C#中的数据结构
function activityV2.GrowTrailFinalInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.GrowTrailFinalInfo()
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.rewardState ~= nil and decodedData.rewardStateSpecified ~= false then
        data.rewardState = decodedData.rewardState
    end
    return data
end

---@param decodedData activityV2.ReqGetActivityReward lua中的数据结构
---@return activityV2.ReqGetActivityReward C#中的数据结构
function activityV2.ReqGetActivityReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqGetActivityReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.goal ~= nil and decodedData.goalSpecified ~= false then
        data.goal = decodedData.goal
    end
    if decodedData.multi ~= nil and decodedData.multiSpecified ~= false then
        data.multi = decodedData.multi
    end
    if decodedData.data64 ~= nil and decodedData.data64Specified ~= false then
        data.data64 = decodedData.data64
    end
    return data
end

---@param decodedData activityV2.ResGetActivityReward lua中的数据结构
---@return activityV2.ResGetActivityReward C#中的数据结构
function activityV2.ResGetActivityReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResGetActivityReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.goal ~= nil and decodedData.goalSpecified ~= false then
        data.goal = decodedData.goal
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.leftCount ~= nil and decodedData.leftCountSpecified ~= false then
        data.leftCount = decodedData.leftCount
    end
    return data
end

---@param decodedData activityV2.ReqOpenPanel lua中的数据结构
---@return activityV2.ReqOpenPanel C#中的数据结构
function activityV2.ReqOpenPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqOpenPanel()
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        data.activityType = decodedData.activityType
    end
    return data
end

---@param decodedData activityV2.ResRankActivity lua中的数据结构
---@return activityV2.ResRankActivity C#中的数据结构
function activityV2.ResRankActivity(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResRankActivity()
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    if decodedData.rankInfoList ~= nil and decodedData.rankInfoListSpecified ~= false then
        for i = 1, #decodedData.rankInfoList do
            data.rankInfoList:Add(activityV2.ActivityRankInfo(decodedData.rankInfoList[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ResWeekTotalRechargeNum lua中的数据结构
---@return activityV2.ResWeekTotalRechargeNum C#中的数据结构
function activityV2.ResWeekTotalRechargeNum(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResWeekTotalRechargeNum()
    if decodedData.totalNum ~= nil and decodedData.totalNumSpecified ~= false then
        data.totalNum = decodedData.totalNum
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResExtraReward lua中的数据结构
---@return activityV2.ResExtraReward C#中的数据结构
function activityV2.ResExtraReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResExtraReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        data.time = decodedData.time
    end
    if decodedData.goalType ~= nil and decodedData.goalTypeSpecified ~= false then
        data.goalType = decodedData.goalType
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData activityV2.ReqGetExtraReward lua中的数据结构
---@return activityV2.ReqGetExtraReward C#中的数据结构
function activityV2.ReqGetExtraReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqGetExtraReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.goalType ~= nil and decodedData.goalTypeSpecified ~= false then
        data.goalType = decodedData.goalType
    end
    return data
end

---@param decodedData activityV2.ReqOpenLianZhi lua中的数据结构
---@return activityV2.ReqOpenLianZhi C#中的数据结构
function activityV2.ReqOpenLianZhi(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqOpenLianZhi()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResOpenLianZhi lua中的数据结构
---@return activityV2.ResOpenLianZhi C#中的数据结构
function activityV2.ResOpenLianZhi(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResOpenLianZhi()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.times ~= nil and decodedData.timesSpecified ~= false then
        data.times = decodedData.times
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.completedList ~= nil and decodedData.completedListSpecified ~= false then
        for i = 1, #decodedData.completedList do
            data.completedList:Add(decodedData.completedList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ReqLianZhi lua中的数据结构
---@return activityV2.ReqLianZhi C#中的数据结构
function activityV2.ReqLianZhi(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqLianZhi()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.times ~= nil and decodedData.timesSpecified ~= false then
        data.times = decodedData.times
    end
    return data
end

---@param decodedData activityV2.ResActivityDataChange lua中的数据结构
---@return activityV2.ResActivityDataChange C#中的数据结构
function activityV2.ResActivityDataChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResActivityDataChange()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.goal ~= nil and decodedData.goalSpecified ~= false then
        data.goal = decodedData.goal
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.now ~= nil and decodedData.nowSpecified ~= false then
        data.now = decodedData.now
    end
    if decodedData.total ~= nil and decodedData.totalSpecified ~= false then
        data.total = decodedData.total
    end
    return data
end

---@param decodedData activityV2.ResLeijiRechargeDays lua中的数据结构
---@return activityV2.ResLeijiRechargeDays C#中的数据结构
function activityV2.ResLeijiRechargeDays(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResLeijiRechargeDays()
    if decodedData.days ~= nil and decodedData.daysSpecified ~= false then
        data.days = decodedData.days
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResSendActivityBossInfo lua中的数据结构
---@return activityV2.ResSendActivityBossInfo C#中的数据结构
function activityV2.ResSendActivityBossInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSendActivityBossInfo()
    if decodedData.remainNum ~= nil and decodedData.remainNumSpecified ~= false then
        data.remainNum = decodedData.remainNum
    end
    if decodedData.hasBuyNum ~= nil and decodedData.hasBuyNumSpecified ~= false then
        data.hasBuyNum = decodedData.hasBuyNum
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResActivityConfigChange lua中的数据结构
---@return activityV2.ResActivityConfigChange C#中的数据结构
function activityV2.ResActivityConfigChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResActivityConfigChange()
    if decodedData.changedActivityList ~= nil and decodedData.changedActivityListSpecified ~= false then
        for i = 1, #decodedData.changedActivityList do
            data.changedActivityList:Add(decodedData.changedActivityList[i])
        end
    end
    if decodedData.changedGoalList ~= nil and decodedData.changedGoalListSpecified ~= false then
        for i = 1, #decodedData.changedGoalList do
            data.changedGoalList:Add(decodedData.changedGoalList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ResLuckTreasure lua中的数据结构
---@return activityV2.ResLuckTreasure C#中的数据结构
function activityV2.ResLuckTreasure(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResLuckTreasure()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.day ~= nil and decodedData.daySpecified ~= false then
        data.day = decodedData.day
    end
    if decodedData.openState ~= nil and decodedData.openStateSpecified ~= false then
        data.openState = decodedData.openState
    end
    if decodedData.luckyName ~= nil and decodedData.luckyNameSpecified ~= false then
        data.luckyName = decodedData.luckyName
    end
    if decodedData.luckyNum ~= nil and decodedData.luckyNumSpecified ~= false then
        data.luckyNum = decodedData.luckyNum
    end
    if decodedData.luckNumberList ~= nil and decodedData.luckNumberListSpecified ~= false then
        for i = 1, #decodedData.luckNumberList do
            data.luckNumberList:Add(decodedData.luckNumberList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ResHuntGiftNum lua中的数据结构
---@return activityV2.ResHuntGiftNum C#中的数据结构
function activityV2.ResHuntGiftNum(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResHuntGiftNum()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData activityV2.ResSpendInfo lua中的数据结构
---@return activityV2.ResSpendInfo C#中的数据结构
function activityV2.ResSpendInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSpendInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData activityV2.ResSendTotalLoginDay lua中的数据结构
---@return activityV2.ResSendTotalLoginDay C#中的数据结构
function activityV2.ResSendTotalLoginDay(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSendTotalLoginDay()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData activityV2.ResSendBossScore lua中的数据结构
---@return activityV2.ResSendBossScore C#中的数据结构
function activityV2.ResSendBossScore(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSendBossScore()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.num ~= nil and decodedData.numSpecified ~= false then
        data.num = decodedData.num
    end
    return data
end

---@param decodedData activityV2.ResSendFirstKillBoss lua中的数据结构
---@return activityV2.ResSendFirstKillBoss C#中的数据结构
function activityV2.ResSendFirstKillBoss(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSendFirstKillBoss()
    if decodedData.rewardInfos ~= nil and decodedData.rewardInfosSpecified ~= false then
        for i = 1, #decodedData.rewardInfos do
            data.rewardInfos:Add(activityV2.FirstKillRewardInfo(decodedData.rewardInfos[i]))
        end
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ReqGetFirstKillBossReward lua中的数据结构
---@return activityV2.ReqGetFirstKillBossReward C#中的数据结构
function activityV2.ReqGetFirstKillBossReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqGetFirstKillBossReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.cfgId ~= nil and decodedData.cfgIdSpecified ~= false then
        data.cfgId = decodedData.cfgId
    end
    return data
end

---@param decodedData activityV2.ResTimeLimitTaskAll lua中的数据结构
---@return activityV2.ResTimeLimitTaskAll C#中的数据结构
function activityV2.ResTimeLimitTaskAll(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResTimeLimitTaskAll()
    if decodedData.taskList ~= nil and decodedData.taskListSpecified ~= false then
        for i = 1, #decodedData.taskList do
            data.taskList:Add(activityV2.limitTimeTaskInfo(decodedData.taskList[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ResUpdateTimeLimitTaskProgress lua中的数据结构
---@return activityV2.ResUpdateTimeLimitTaskProgress C#中的数据结构
function activityV2.ResUpdateTimeLimitTaskProgress(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResUpdateTimeLimitTaskProgress()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData activityV2.ReqDrawTimeLimitTaskReward lua中的数据结构
---@return activityV2.ReqDrawTimeLimitTaskReward C#中的数据结构
function activityV2.ReqDrawTimeLimitTaskReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqDrawTimeLimitTaskReward()
    if decodedData.rate ~= nil and decodedData.rateSpecified ~= false then
        data.rate = decodedData.rate
    end
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    return data
end

---@param decodedData activityV2.ResDrawTimeLimitTaskReward lua中的数据结构
---@return activityV2.ResDrawTimeLimitTaskReward C#中的数据结构
function activityV2.ResDrawTimeLimitTaskReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResDrawTimeLimitTaskReward()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    return data
end

---@param decodedData activityV2.ReqRoleActivityRankInfo lua中的数据结构
---@return activityV2.ReqRoleActivityRankInfo C#中的数据结构
function activityV2.ReqRoleActivityRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqRoleActivityRankInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResRoleActivityRankInfo lua中的数据结构
---@return activityV2.ResRoleActivityRankInfo C#中的数据结构
function activityV2.ResRoleActivityRankInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResRoleActivityRankInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.rankParam ~= nil and decodedData.rankParamSpecified ~= false then
        data.rankParam = decodedData.rankParam
    end
    return data
end

---@param decodedData activityV2.ResSendLuckyWheelInfo lua中的数据结构
---@return activityV2.ResSendLuckyWheelInfo C#中的数据结构
function activityV2.ResSendLuckyWheelInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSendLuckyWheelInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.wheelNum ~= nil and decodedData.wheelNumSpecified ~= false then
        data.wheelNum = decodedData.wheelNum
    end
    if decodedData.totalNum ~= nil and decodedData.totalNumSpecified ~= false then
        data.totalNum = decodedData.totalNum
    end
    return data
end

---@param decodedData activityV2.ReqStartLuckyWheel lua中的数据结构
---@return activityV2.ReqStartLuckyWheel C#中的数据结构
function activityV2.ReqStartLuckyWheel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqStartLuckyWheel()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResSendLuckyWheelResult lua中的数据结构
---@return activityV2.ResSendLuckyWheelResult C#中的数据结构
function activityV2.ResSendLuckyWheelResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSendLuckyWheelResult()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData activityV2.ReqGetLuckyWheelReward lua中的数据结构
---@return activityV2.ReqGetLuckyWheelReward C#中的数据结构
function activityV2.ReqGetLuckyWheelReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqGetLuckyWheelReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResHappySevenDayActivityInfo lua中的数据结构
---@return activityV2.ResHappySevenDayActivityInfo C#中的数据结构
function activityV2.ResHappySevenDayActivityInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResHappySevenDayActivityInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.dayInfoList ~= nil and decodedData.dayInfoListSpecified ~= false then
        for i = 1, #decodedData.dayInfoList do
            data.dayInfoList:Add(activityV2.DayInfoOfHappySevenDay(decodedData.dayInfoList[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ReqDrawHappySevenDayActivityReward lua中的数据结构
---@return activityV2.ReqDrawHappySevenDayActivityReward C#中的数据结构
function activityV2.ReqDrawHappySevenDayActivityReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqDrawHappySevenDayActivityReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.day ~= nil and decodedData.daySpecified ~= false then
        data.day = decodedData.day
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData activityV2.ResHappySevenDayActivityDataChange lua中的数据结构
---@return activityV2.ResHappySevenDayActivityDataChange C#中的数据结构
function activityV2.ResHappySevenDayActivityDataChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResHappySevenDayActivityDataChange()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.day ~= nil and decodedData.daySpecified ~= false then
        data.day = decodedData.day
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.completeCount ~= nil and decodedData.completeCountSpecified ~= false then
        data.completeCount = decodedData.completeCount
    end
    if decodedData.total ~= nil and decodedData.totalSpecified ~= false then
        data.total = decodedData.total
    end
    if decodedData.rewardState ~= nil and decodedData.rewardStateSpecified ~= false then
        data.rewardState = decodedData.rewardState
    end
    return data
end

---@param decodedData activityV2.ResOpenConditionActivity lua中的数据结构
---@return activityV2.ResOpenConditionActivity C#中的数据结构
function activityV2.ResOpenConditionActivity(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResOpenConditionActivity()
    if decodedData.activityList ~= nil and decodedData.activityListSpecified ~= false then
        for i = 1, #decodedData.activityList do
            data.activityList:Add(activityV2.ActivityTimeInfo(decodedData.activityList[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ReqRaffle lua中的数据结构
---@return activityV2.ReqRaffle C#中的数据结构
function activityV2.ReqRaffle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqRaffle()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.costType ~= nil and decodedData.costTypeSpecified ~= false then
        data.costType = decodedData.costType
    end
    return data
end

---@param decodedData activityV2.ResRaffleResult lua中的数据结构
---@return activityV2.ResRaffleResult C#中的数据结构
function activityV2.ResRaffleResult(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResRaffleResult()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    if decodedData.raffleItemList ~= nil and decodedData.raffleItemListSpecified ~= false then
        for i = 1, #decodedData.raffleItemList do
            data.raffleItemList:Add(activityV2.RaffleItem(decodedData.raffleItemList[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ResActivityBossState lua中的数据结构
---@return activityV2.ResActivityBossState C#中的数据结构
function activityV2.ResActivityBossState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResActivityBossState()
    if decodedData.duplicateId ~= nil and decodedData.duplicateIdSpecified ~= false then
        data.duplicateId = decodedData.duplicateId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    return data
end

---@param decodedData activityV2.ResCombineSbkUnion lua中的数据结构
---@return activityV2.ResCombineSbkUnion C#中的数据结构
function activityV2.ResCombineSbkUnion(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResCombineSbkUnion()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.unionNameList ~= nil and decodedData.unionNameListSpecified ~= false then
        for i = 1, #decodedData.unionNameList do
            data.unionNameList:Add(decodedData.unionNameList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ResSoulStoneCost lua中的数据结构
---@return activityV2.ResSoulStoneCost C#中的数据结构
function activityV2.ResSoulStoneCost(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSoulStoneCost()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.costNum ~= nil and decodedData.costNumSpecified ~= false then
        data.costNum = decodedData.costNum
    end
    return data
end

---@param decodedData activityV2.ResCrazyHappy lua中的数据结构
---@return activityV2.ResCrazyHappy C#中的数据结构
function activityV2.ResCrazyHappy(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResCrazyHappy()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.crazyHappyInfo ~= nil and decodedData.crazyHappyInfoSpecified ~= false then
        for i = 1, #decodedData.crazyHappyInfo do
            data.crazyHappyInfo:Add(activityV2.CrazyHappyInfo(decodedData.crazyHappyInfo[i]))
        end
    end
    if decodedData.crazyHappyValue ~= nil and decodedData.crazyHappyValueSpecified ~= false then
        data.crazyHappyValue = decodedData.crazyHappyValue
    end
    if decodedData.hasDrawIndexList ~= nil and decodedData.hasDrawIndexListSpecified ~= false then
        for i = 1, #decodedData.hasDrawIndexList do
            data.hasDrawIndexList:Add(decodedData.hasDrawIndexList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ReqDrawCrazyHappyReward lua中的数据结构
---@return activityV2.ReqDrawCrazyHappyReward C#中的数据结构
function activityV2.ReqDrawCrazyHappyReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqDrawCrazyHappyReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData activityV2.ResCrazyHappyChangeInfo lua中的数据结构
---@return activityV2.ResCrazyHappyChangeInfo C#中的数据结构
function activityV2.ResCrazyHappyChangeInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResCrazyHappyChangeInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.crazyHappyInfo ~= nil and decodedData.crazyHappyInfoSpecified ~= false then
        for i = 1, #decodedData.crazyHappyInfo do
            data.crazyHappyInfo:Add(activityV2.CrazyHappyInfo(decodedData.crazyHappyInfo[i]))
        end
    end
    if decodedData.crazyHappyValue ~= nil and decodedData.crazyHappyValueSpecified ~= false then
        data.crazyHappyValue = decodedData.crazyHappyValue
    end
    return data
end

---@param decodedData activityV2.ResCrazyHappyReward lua中的数据结构
---@return activityV2.ResCrazyHappyReward C#中的数据结构
function activityV2.ResCrazyHappyReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResCrazyHappyReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.hasDrawIndexList ~= nil and decodedData.hasDrawIndexListSpecified ~= false then
        for i = 1, #decodedData.hasDrawIndexList do
            data.hasDrawIndexList:Add(decodedData.hasDrawIndexList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ResLimitBuyCount lua中的数据结构
---@return activityV2.ResLimitBuyCount C#中的数据结构
function activityV2.ResLimitBuyCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResLimitBuyCount()
    if decodedData.ShouHuLimitBuyInfoList ~= nil and decodedData.ShouHuLimitBuyInfoListSpecified ~= false then
        for i = 1, #decodedData.ShouHuLimitBuyInfoList do
            data.ShouHuLimitBuyInfoList:Add(activityV2.ShouHuLimitBuyInfo(decodedData.ShouHuLimitBuyInfoList[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ResMysticStorePoint lua中的数据结构
---@return activityV2.ResMysticStorePoint C#中的数据结构
function activityV2.ResMysticStorePoint(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResMysticStorePoint()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.point ~= nil and decodedData.pointSpecified ~= false then
        data.point = decodedData.point
    end
    return data
end

---@param decodedData activityV2.ResRaffCount lua中的数据结构
---@return activityV2.ResRaffCount C#中的数据结构
function activityV2.ResRaffCount(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResRaffCount()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.totalCount ~= nil and decodedData.totalCountSpecified ~= false then
        data.totalCount = decodedData.totalCount
    end
    return data
end

---@param decodedData activityV2.ResInvestPlan lua中的数据结构
---@return activityV2.ResInvestPlan C#中的数据结构
function activityV2.ResInvestPlan(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResInvestPlan()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.beginTime ~= nil and decodedData.beginTimeSpecified ~= false then
        data.beginTime = decodedData.beginTime
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.hasAttend ~= nil and decodedData.hasAttendSpecified ~= false then
        data.hasAttend = decodedData.hasAttend
    end
    if decodedData.hasDrawList ~= nil and decodedData.hasDrawListSpecified ~= false then
        for i = 1, #decodedData.hasDrawList do
            data.hasDrawList:Add(decodedData.hasDrawList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ReqDrawInvestPlanReward lua中的数据结构
---@return activityV2.ReqDrawInvestPlanReward C#中的数据结构
function activityV2.ReqDrawInvestPlanReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqDrawInvestPlanReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.dayNo ~= nil and decodedData.dayNoSpecified ~= false then
        data.dayNo = decodedData.dayNo
    end
    return data
end

---@param decodedData activityV2.ReqCrazyRaffle lua中的数据结构
---@return activityV2.ReqCrazyRaffle C#中的数据结构
function activityV2.ReqCrazyRaffle(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqCrazyRaffle()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResCrazyRaffleInfo lua中的数据结构
---@return activityV2.ResCrazyRaffleInfo C#中的数据结构
function activityV2.ResCrazyRaffleInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResCrazyRaffleInfo()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.hasIndexList ~= nil and decodedData.hasIndexListSpecified ~= false then
        for i = 1, #decodedData.hasIndexList do
            data.hasIndexList:Add(decodedData.hasIndexList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ResGrowTrailInfo lua中的数据结构
---@return activityV2.ResGrowTrailInfo C#中的数据结构
function activityV2.ResGrowTrailInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResGrowTrailInfo()
    if decodedData.growTrailDailyInfos ~= nil and decodedData.growTrailDailyInfosSpecified ~= false then
        for i = 1, #decodedData.growTrailDailyInfos do
            data.growTrailDailyInfos:Add(activityV2.GrowTrailActivityInfo(decodedData.growTrailDailyInfos[i]))
        end
    end
    if decodedData.growTrailFinalInfos ~= nil and decodedData.growTrailFinalInfosSpecified ~= false then
        for i = 1, #decodedData.growTrailFinalInfos do
            data.growTrailFinalInfos:Add(activityV2.GrowTrailFinalInfo(decodedData.growTrailFinalInfos[i]))
        end
    end
    if decodedData.completeCount ~= nil and decodedData.completeCountSpecified ~= false then
        data.completeCount = decodedData.completeCount
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ResGrowTrailDataChange lua中的数据结构
---@return activityV2.ResGrowTrailDataChange C#中的数据结构
function activityV2.ResGrowTrailDataChange(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResGrowTrailDataChange()
    if decodedData.growTrailDataInfo ~= nil and decodedData.growTrailDataInfoSpecified ~= false then
        data.growTrailDataInfo = activityV2.GrowTrailActivityInfo(decodedData.growTrailDataInfo)
    end
    if decodedData.completeCount ~= nil and decodedData.completeCountSpecified ~= false then
        data.completeCount = decodedData.completeCount
    end
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    return data
end

---@param decodedData activityV2.ReqDrawGrowTrailReward lua中的数据结构
---@return activityV2.ReqDrawGrowTrailReward C#中的数据结构
function activityV2.ReqDrawGrowTrailReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqDrawGrowTrailReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.dayNo ~= nil and decodedData.dayNoSpecified ~= false then
        data.dayNo = decodedData.dayNo
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData activityV2.ReqDrawGrowTrailFinalReward lua中的数据结构
---@return activityV2.ReqDrawGrowTrailFinalReward C#中的数据结构
function activityV2.ReqDrawGrowTrailFinalReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqDrawGrowTrailFinalReward()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData activityV2.ResGrowTrailFinalRewardDrawSuccess lua中的数据结构
---@return activityV2.ResGrowTrailFinalRewardDrawSuccess C#中的数据结构
function activityV2.ResGrowTrailFinalRewardDrawSuccess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResGrowTrailFinalRewardDrawSuccess()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.index ~= nil and decodedData.indexSpecified ~= false then
        data.index = decodedData.index
    end
    return data
end

---@param decodedData activityV2.ReqSetChoseTurntable lua中的数据结构
---@return activityV2.ReqSetChoseTurntable C#中的数据结构
function activityV2.ReqSetChoseTurntable(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqSetChoseTurntable()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.cfgIdList ~= nil and decodedData.cfgIdListSpecified ~= false then
        for i = 1, #decodedData.cfgIdList do
            data.cfgIdList:Add(decodedData.cfgIdList[i])
        end
    end
    return data
end

---@param decodedData activityV2.ResChoseTurntable lua中的数据结构
---@return activityV2.ResChoseTurntable C#中的数据结构
function activityV2.ResChoseTurntable(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResChoseTurntable()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.cfgIdList ~= nil and decodedData.cfgIdListSpecified ~= false then
        for i = 1, #decodedData.cfgIdList do
            data.cfgIdList:Add(decodedData.cfgIdList[i])
        end
    end
    return data
end

---@param decodedData activityV2.BuyLimitedOfferRequest lua中的数据结构
---@return activityV2.BuyLimitedOfferRequest C#中的数据结构
function activityV2.BuyLimitedOfferRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.BuyLimitedOfferRequest()
    data.activityId = decodedData.activityId
    return data
end

---@param decodedData activityV2.ResSaleGiftInfo lua中的数据结构
---@return activityV2.ResSaleGiftInfo C#中的数据结构
function activityV2.ResSaleGiftInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResSaleGiftInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(activityV2.BuyLimitInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData activityV2.BuyLimitInfo lua中的数据结构
---@return activityV2.BuyLimitInfo C#中的数据结构
function activityV2.BuyLimitInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.BuyLimitInfo()
    data.activityId = decodedData.activityId
    if decodedData.isGetReward ~= nil and decodedData.isGetRewardSpecified ~= false then
        data.isGetReward = decodedData.isGetReward
    end
    return data
end

---@param decodedData activityV2.ActivityOpenTable lua中的数据结构
---@return activityV2.ActivityOpenTable C#中的数据结构
function activityV2.ActivityOpenTable(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityOpenTable()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        for i = 1, #decodedData.activityId do
            data.activityId:Add(decodedData.activityId[i])
        end
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    return data
end

---@param decodedData activityV2.ActivityOpenMsgRequest lua中的数据结构
---@return activityV2.ActivityOpenMsgRequest C#中的数据结构
function activityV2.ActivityOpenMsgRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityOpenMsgRequest()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    return data
end

---@param decodedData activityV2.ResActivityMonsterRankScoreList lua中的数据结构
---@return activityV2.ResActivityMonsterRankScoreList C#中的数据结构
function activityV2.ResActivityMonsterRankScoreList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResActivityMonsterRankScoreList()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(activityV2.RankInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ResActivityMonsterAttackTimesInfo lua中的数据结构
---@return activityV2.ResActivityMonsterAttackTimesInfo C#中的数据结构
function activityV2.ResActivityMonsterAttackTimesInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResActivityMonsterAttackTimesInfo()
    data.curTimes = decodedData.curTimes
    if decodedData.subTime ~= nil and decodedData.subTimeSpecified ~= false then
        data.subTime = decodedData.subTime
    end
    if decodedData.waveId ~= nil and decodedData.waveIdSpecified ~= false then
        for i = 1, #decodedData.waveId do
            data.waveId:Add(decodedData.waveId[i])
        end
    end
    return data
end

---@param decodedData activityV2.ResActivityMonsterStage lua中的数据结构
---@return activityV2.ResActivityMonsterStage C#中的数据结构
function activityV2.ResActivityMonsterStage(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResActivityMonsterStage()
    data.stage = decodedData.stage
    return data
end

---@param decodedData activityV2.ResActivityMonsterKillBossRank lua中的数据结构
---@return activityV2.ResActivityMonsterKillBossRank C#中的数据结构
function activityV2.ResActivityMonsterKillBossRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResActivityMonsterKillBossRank()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(activityV2.RankInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ReqGatherActivityMonsterBox lua中的数据结构
---@return activityV2.ReqGatherActivityMonsterBox C#中的数据结构
function activityV2.ReqGatherActivityMonsterBox(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqGatherActivityMonsterBox()
    data.box = decodedData.box
    return data
end

---@param decodedData activityV2.ResDefendKingActivityInfo lua中的数据结构
---@return activityV2.ResDefendKingActivityInfo C#中的数据结构
function activityV2.ResDefendKingActivityInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResDefendKingActivityInfo()
    if decodedData.list ~= nil and decodedData.listSpecified ~= false then
        for i = 1, #decodedData.list do
            data.list:Add(activityV2.DefendUnionInfo(decodedData.list[i]))
        end
    end
    if decodedData.myScore ~= nil and decodedData.myScoreSpecified ~= false then
        data.myScore = decodedData.myScore
    end
    if decodedData.spyScore ~= nil and decodedData.spyScoreSpecified ~= false then
        data.spyScore = decodedData.spyScore
    end
    if decodedData.endTime ~= nil and decodedData.endTimeSpecified ~= false then
        data.endTime = decodedData.endTime
    end
    if decodedData.kingHpPer ~= nil and decodedData.kingHpPerSpecified ~= false then
        data.kingHpPer = decodedData.kingHpPer
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    return data
end

---@param decodedData activityV2.DefendUnionInfo lua中的数据结构
---@return activityV2.DefendUnionInfo C#中的数据结构
function activityV2.DefendUnionInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.DefendUnionInfo()
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.unionScore ~= nil and decodedData.unionScoreSpecified ~= false then
        data.unionScore = decodedData.unionScore
    end
    if decodedData.totalScore ~= nil and decodedData.totalScoreSpecified ~= false then
        data.totalScore = decodedData.totalScore
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    return data
end

---@param decodedData activityV2.ResDefendUpdateScore lua中的数据结构
---@return activityV2.ResDefendUpdateScore C#中的数据结构
function activityV2.ResDefendUpdateScore(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResDefendUpdateScore()
    if decodedData.type ~= nil and decodedData.typeSpecified ~= false then
        data.type = decodedData.type
    end
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    if decodedData.kingId ~= nil and decodedData.kingIdSpecified ~= false then
        data.kingId = decodedData.kingId
    end
    return data
end

---@param decodedData activityV2.DefendRank lua中的数据结构
---@return activityV2.DefendRank C#中的数据结构
function activityV2.DefendRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.DefendRank()
    if decodedData.selfInfos ~= nil and decodedData.selfInfosSpecified ~= false then
        for i = 1, #decodedData.selfInfos do
            data.selfInfos:Add(activityV2.DefendRankPlayerInfo(decodedData.selfInfos[i]))
        end
    end
    if decodedData.otherInfos ~= nil and decodedData.otherInfosSpecified ~= false then
        for i = 1, #decodedData.otherInfos do
            data.otherInfos:Add(activityV2.DefendRankPlayerInfo(decodedData.otherInfos[i]))
        end
    end
    if decodedData.common ~= nil and decodedData.commonSpecified ~= false then
        data.common = activityV2.DefendRankCommon(decodedData.common)
    end
    return data
end

---@param decodedData activityV2.DefendRankPlayerInfo lua中的数据结构
---@return activityV2.DefendRankPlayerInfo C#中的数据结构
function activityV2.DefendRankPlayerInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.DefendRankPlayerInfo()
    if decodedData.rid ~= nil and decodedData.ridSpecified ~= false then
        data.rid = decodedData.rid
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.career ~= nil and decodedData.careerSpecified ~= false then
        data.career = decodedData.career
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.level ~= nil and decodedData.levelSpecified ~= false then
        data.level = decodedData.level
    end
    if decodedData.killSmall ~= nil and decodedData.killSmallSpecified ~= false then
        data.killSmall = decodedData.killSmall
    end
    if decodedData.killBig ~= nil and decodedData.killBigSpecified ~= false then
        data.killBig = decodedData.killBig
    end
    if decodedData.killNum ~= nil and decodedData.killNumSpecified ~= false then
        data.killNum = decodedData.killNum
    end
    if decodedData.diedNum ~= nil and decodedData.diedNumSpecified ~= false then
        data.diedNum = decodedData.diedNum
    end
    if decodedData.grade ~= nil and decodedData.gradeSpecified ~= false then
        data.grade = decodedData.grade
    end
    if decodedData.unionId ~= nil and decodedData.unionIdSpecified ~= false then
        data.unionId = decodedData.unionId
    end
    if decodedData.unionName ~= nil and decodedData.unionNameSpecified ~= false then
        data.unionName = decodedData.unionName
    end
    if decodedData.titleType ~= nil and decodedData.titleTypeSpecified ~= false then
        data.titleType = decodedData.titleType
    end
    if decodedData.like ~= nil and decodedData.likeSpecified ~= false then
        for i = 1, #decodedData.like do
            data.like:Add(decodedData.like[i])
        end
    end
    return data
end

---@param decodedData activityV2.DefendRankCommon lua中的数据结构
---@return activityV2.DefendRankCommon C#中的数据结构
function activityV2.DefendRankCommon(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.DefendRankCommon()
    if decodedData.totalKillSmall ~= nil and decodedData.totalKillSmallSpecified ~= false then
        data.totalKillSmall = decodedData.totalKillSmall
    end
    if decodedData.totalKillBig ~= nil and decodedData.totalKillBigSpecified ~= false then
        data.totalKillBig = decodedData.totalKillBig
    end
    if decodedData.totalKill ~= nil and decodedData.totalKillSpecified ~= false then
        data.totalKill = decodedData.totalKill
    end
    if decodedData.totalDied ~= nil and decodedData.totalDiedSpecified ~= false then
        data.totalDied = decodedData.totalDied
    end
    if decodedData.rankSmall ~= nil and decodedData.rankSmallSpecified ~= false then
        data.rankSmall = decodedData.rankSmall
    end
    if decodedData.rankBig ~= nil and decodedData.rankBigSpecified ~= false then
        data.rankBig = decodedData.rankBig
    end
    if decodedData.rankKill ~= nil and decodedData.rankKillSpecified ~= false then
        data.rankKill = decodedData.rankKill
    end
    if decodedData.rankDied ~= nil and decodedData.rankDiedSpecified ~= false then
        data.rankDied = decodedData.rankDied
    end
    if decodedData.rankGrade ~= nil and decodedData.rankGradeSpecified ~= false then
        data.rankGrade = decodedData.rankGrade
    end
    if decodedData.kingDied ~= nil and decodedData.kingDiedSpecified ~= false then
        data.kingDied = decodedData.kingDied
    end
    if decodedData.lastFirstUnionName ~= nil and decodedData.lastFirstUnionNameSpecified ~= false then
        data.lastFirstUnionName = decodedData.lastFirstUnionName
    end
    return data
end

---@param decodedData activityV2.ResDefendOver lua中的数据结构
---@return activityV2.ResDefendOver C#中的数据结构
function activityV2.ResDefendOver(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResDefendOver()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = activityV2.DefendRank(decodedData.rank)
    end
    if decodedData.showTime ~= nil and decodedData.showTimeSpecified ~= false then
        data.showTime = decodedData.showTime
    end
    return data
end

---@param decodedData activityV2.ResDefendLastRank lua中的数据结构
---@return activityV2.ResDefendLastRank C#中的数据结构
function activityV2.ResDefendLastRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResDefendLastRank()
    if decodedData.rank ~= nil and decodedData.rankSpecified ~= false then
        data.rank = activityV2.DefendRank(decodedData.rank)
    end
    return data
end

---@param decodedData activityV2.ResDailyActivityStatusChanged lua中的数据结构
---@return activityV2.ResDailyActivityStatusChanged C#中的数据结构
function activityV2.ResDailyActivityStatusChanged(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResDailyActivityStatusChanged()
    data.activityId = decodedData.activityId
    data.status = decodedData.status
    if decodedData.zeroTime ~= nil and decodedData.zeroTimeSpecified ~= false then
        data.zeroTime = decodedData.zeroTime
    end
    return data
end

---@param decodedData activityV2.ResAllActivityCommonStatus lua中的数据结构
---@return activityV2.ResAllActivityCommonStatus C#中的数据结构
function activityV2.ResAllActivityCommonStatus(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResAllActivityCommonStatus()
    if decodedData.statusList ~= nil and decodedData.statusListSpecified ~= false then
        for i = 1, #decodedData.statusList do
            data.statusList:Add(activityV2.ActivityCommonStatus(decodedData.statusList[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ActivityCommonStatus lua中的数据结构
---@return activityV2.ActivityCommonStatus C#中的数据结构
function activityV2.ActivityCommonStatus(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityCommonStatus()
    if decodedData.activityId ~= nil and decodedData.activityIdSpecified ~= false then
        data.activityId = decodedData.activityId
    end
    if decodedData.status ~= nil and decodedData.statusSpecified ~= false then
        data.status = decodedData.status
    end
    return data
end

---@param decodedData activityV2.BossScoreRewards lua中的数据结构
---@return activityV2.BossScoreRewards C#中的数据结构
function activityV2.BossScoreRewards(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.BossScoreRewards()
    data.id = decodedData.id
    data.state = decodedData.state
    if decodedData.killCount ~= nil and decodedData.killCountSpecified ~= false then
        data.killCount = decodedData.killCount
    end
    return data
end

---@param decodedData activityV2.BossScoreRes lua中的数据结构
---@return activityV2.BossScoreRes C#中的数据结构
function activityV2.BossScoreRes(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.BossScoreRes()
    if decodedData.score ~= nil and decodedData.scoreSpecified ~= false then
        data.score = decodedData.score
    end
    if decodedData.day ~= nil and decodedData.daySpecified ~= false then
        data.day = decodedData.day
    end
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(activityV2.BossScoreRewards(decodedData.rewards[i]))
        end
    end
    if decodedData.isCard ~= nil and decodedData.isCardSpecified ~= false then
        data.isCard = decodedData.isCard
    end
    return data
end

---@param decodedData activityV2.GetBossScoreReward lua中的数据结构
---@return activityV2.GetBossScoreReward C#中的数据结构
function activityV2.GetBossScoreReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.GetBossScoreReward()
    data.id = decodedData.id
    return data
end

---@param decodedData activityV2.TheActivityHasRewarded lua中的数据结构
---@return activityV2.TheActivityHasRewarded C#中的数据结构
function activityV2.TheActivityHasRewarded(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.TheActivityHasRewarded()
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(activityV2.ActivityRewards(decodedData.rewards[i]))
        end
    end
    if decodedData.fromModule ~= nil and decodedData.fromModuleSpecified ~= false then
        data.fromModule = decodedData.fromModule
    end
    if decodedData.success ~= nil and decodedData.successSpecified ~= false then
        data.success = decodedData.success
    end
    return data
end

---@param decodedData activityV2.ActivityRewards lua中的数据结构
---@return activityV2.ActivityRewards C#中的数据结构
function activityV2.ActivityRewards(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ActivityRewards()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData activityV2.ServerRoleReward lua中的数据结构
---@return activityV2.ServerRoleReward C#中的数据结构
function activityV2.ServerRoleReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ServerRoleReward()
    if decodedData.randomRewards ~= nil and decodedData.randomRewardsSpecified ~= false then
        for i = 1, #decodedData.randomRewards do
            data.randomRewards:Add(activityV2.ItemCountInfo(decodedData.randomRewards[i]))
        end
    end
    if decodedData.rewardHistorys ~= nil and decodedData.rewardHistorysSpecified ~= false then
        for i = 1, #decodedData.rewardHistorys do
            data.rewardHistorys:Add(activityV2.ServerRoleRed(decodedData.rewardHistorys[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ServerRoleFinish lua中的数据结构
---@return activityV2.ServerRoleFinish C#中的数据结构
function activityV2.ServerRoleFinish(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ServerRoleFinish()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.sex ~= nil and decodedData.sexSpecified ~= false then
        data.sex = decodedData.sex
    end
    if decodedData.carrer ~= nil and decodedData.carrerSpecified ~= false then
        data.carrer = decodedData.carrer
    end
    return data
end

---@param decodedData activityV2.ServerRoleRed lua中的数据结构
---@return activityV2.ServerRoleRed C#中的数据结构
function activityV2.ServerRoleRed(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ServerRoleRed()
    if decodedData.roleId ~= nil and decodedData.roleIdSpecified ~= false then
        data.roleId = decodedData.roleId
    end
    if decodedData.name ~= nil and decodedData.nameSpecified ~= false then
        data.name = decodedData.name
    end
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(activityV2.ItemCountInfo(decodedData.rewards[i]))
        end
    end
    return data
end

---@param decodedData activityV2.ItemCountInfo lua中的数据结构
---@return activityV2.ItemCountInfo C#中的数据结构
function activityV2.ItemCountInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ItemCountInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData activityV2.ResDefendRankList lua中的数据结构
---@return activityV2.ResDefendRankList C#中的数据结构
function activityV2.ResDefendRankList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResDefendRankList()
    if decodedData.time ~= nil and decodedData.timeSpecified ~= false then
        for i = 1, #decodedData.time do
            data.time:Add(decodedData.time[i])
        end
    end
    return data
end

---@param decodedData activityV2.ReqDefendLastRank lua中的数据结构
---@return activityV2.ReqDefendLastRank C#中的数据结构
function activityV2.ReqDefendLastRank(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqDefendLastRank()
    data.time = decodedData.time
    return data
end

---@param decodedData activityV2.ResTodayClosedActivities lua中的数据结构
---@return activityV2.ResTodayClosedActivities C#中的数据结构
function activityV2.ResTodayClosedActivities(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResTodayClosedActivities()
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        for i = 1, #decodedData.activityType do
            data.activityType:Add(decodedData.activityType[i])
        end
    end
    return data
end

---@param decodedData activityV2.ResBlackIronCost lua中的数据结构
---@return activityV2.ResBlackIronCost C#中的数据结构
function activityV2.ResBlackIronCost(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResBlackIronCost()
    if decodedData.blackIronCost ~= nil and decodedData.blackIronCostSpecified ~= false then
        data.blackIronCost = decodedData.blackIronCost
    end
    return data
end

---@param decodedData activityV2.ResTodayOpenActivities lua中的数据结构
---@return activityV2.ResTodayOpenActivities C#中的数据结构
function activityV2.ResTodayOpenActivities(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResTodayOpenActivities()
    if decodedData.activityType ~= nil and decodedData.activityTypeSpecified ~= false then
        for i = 1, #decodedData.activityType do
            data.activityType:Add(decodedData.activityType[i])
        end
    end
    return data
end

---@param decodedData activityV2.ReqReceiveGift lua中的数据结构
---@return activityV2.ReqReceiveGift C#中的数据结构
function activityV2.ReqReceiveGift(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ReqReceiveGift()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    return data
end

---@param decodedData activityV2.ResReceivedGiftState lua中的数据结构
---@return activityV2.ResReceivedGiftState C#中的数据结构
function activityV2.ResReceivedGiftState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.ResReceivedGiftState()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        for i = 1, #decodedData.id do
            data.id:Add(decodedData.id[i])
        end
    end
    return data
end

---@param decodedData activityV2.LuckTurntableInfo lua中的数据结构
---@return activityV2.LuckTurntableInfo C#中的数据结构
function activityV2.LuckTurntableInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.LuckTurntableInfo()
    if decodedData.rechargeRmb ~= nil and decodedData.rechargeRmbSpecified ~= false then
        data.rechargeRmb = decodedData.rechargeRmb
    end
    if decodedData.lotteryTimes ~= nil and decodedData.lotteryTimesSpecified ~= false then
        data.lotteryTimes = decodedData.lotteryTimes
    end
    if decodedData.obtains ~= nil and decodedData.obtainsSpecified ~= false then
        for i = 1, #decodedData.obtains do
            data.obtains:Add(decodedData.obtains[i])
        end
    end
    data.leftTime = decodedData.leftTime
    --C#的activityV2.LuckTurntableInfo类中没有找到rewardIndex字段,不填充数据
    return data
end

---@param decodedData activityV2.LotteryReward lua中的数据结构
---@return activityV2.LotteryReward C#中的数据结构
function activityV2.LotteryReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.activityV2.LotteryReward()
    if decodedData.rewards ~= nil and decodedData.rewardsSpecified ~= false then
        for i = 1, #decodedData.rewards do
            data.rewards:Add(activityV2.ItemCountInfo(decodedData.rewards[i]))
        end
    end
    return data
end

return activityV2