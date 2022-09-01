--[[本文件为工具自动生成,禁止手动修改]]
local officialV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData officialV2.DailyTaskInfo lua中的数据结构
---@return officialV2.DailyTaskInfo C#中的数据结构
function officialV2.DailyTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.officialV2.DailyTaskInfo()
    if decodedData.id ~= nil and decodedData.idSpecified ~= false then
        data.id = decodedData.id
    end
    if decodedData.completedNum ~= nil and decodedData.completedNumSpecified ~= false then
        data.completedNum = decodedData.completedNum
    end
    if decodedData.hasDrawCount ~= nil and decodedData.hasDrawCountSpecified ~= false then
        data.hasDrawCount = decodedData.hasDrawCount
    end
    if decodedData.status ~= nil and decodedData.statusSpecified ~= false then
        data.status = decodedData.status
    end
    return data
end

---@param decodedData officialV2.ResOfficialInfo lua中的数据结构
---@return officialV2.ResOfficialInfo C#中的数据结构
function officialV2.ResOfficialInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.officialV2.ResOfficialInfo()
    if decodedData.uid ~= nil and decodedData.uidSpecified ~= false then
        data.uid = decodedData.uid
    end
    if decodedData.power ~= nil and decodedData.powerSpecified ~= false then
        data.power = decodedData.power
    end
    if decodedData.attr ~= nil and decodedData.attrSpecified ~= false then
        data.attr = decodedData.attr
    end
    if decodedData.dailyRewardDrawList ~= nil and decodedData.dailyRewardDrawListSpecified ~= false then
        for i = 1, #decodedData.dailyRewardDrawList do
            data.dailyRewardDrawList:Add(decodedData.dailyRewardDrawList[i])
        end
    end
    if decodedData.dailyTaskInfoList ~= nil and decodedData.dailyTaskInfoListSpecified ~= false then
        for i = 1, #decodedData.dailyTaskInfoList do
            data.dailyTaskInfoList:Add(officialV2.DailyTaskInfo(decodedData.dailyTaskInfoList[i]))
        end
    end
    return data
end

---@param decodedData officialV2.ResOfficialUp lua中的数据结构
---@return officialV2.ResOfficialUp C#中的数据结构
function officialV2.ResOfficialUp(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.officialV2.ResOfficialUp()
    if decodedData.officialGrade ~= nil and decodedData.officialGradeSpecified ~= false then
        data.officialGrade = decodedData.officialGrade
    end
    if decodedData.officialPoint ~= nil and decodedData.officialPointSpecified ~= false then
        data.officialPoint = decodedData.officialPoint
    end
    return data
end

---@param decodedData officialV2.ReqDrawDailyActiveReward lua中的数据结构
---@return officialV2.ReqDrawDailyActiveReward C#中的数据结构
function officialV2.ReqDrawDailyActiveReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.officialV2.ReqDrawDailyActiveReward()
    if decodedData.rewardId ~= nil and decodedData.rewardIdSpecified ~= false then
        data.rewardId = decodedData.rewardId
    end
    return data
end

---@param decodedData officialV2.ResDrawDailyActiveReward lua中的数据结构
---@return officialV2.ResDrawDailyActiveReward C#中的数据结构
function officialV2.ResDrawDailyActiveReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.officialV2.ResDrawDailyActiveReward()
    if decodedData.rewardDrawList ~= nil and decodedData.rewardDrawListSpecified ~= false then
        for i = 1, #decodedData.rewardDrawList do
            data.rewardDrawList:Add(decodedData.rewardDrawList[i])
        end
    end
    return data
end

---@param decodedData officialV2.ReqDrawDailyTaskReward lua中的数据结构
---@return officialV2.ReqDrawDailyTaskReward C#中的数据结构
function officialV2.ReqDrawDailyTaskReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.officialV2.ReqDrawDailyTaskReward()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    return data
end

--[[officialV2.ResOfficialInfoV2 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[officialV2.ReqOfficialEmperorTokenActivateV2 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return officialV2