--[[本文件为工具自动生成,禁止手动修改]]
local taskV2 = {}

local decodeTable = protobufMgr.DecodeTable

---@param decodedData taskV2.TaskDataInfo lua中的数据结构
---@return taskV2.TaskDataInfo C#中的数据结构
function taskV2.TaskDataInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.TaskDataInfo()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    if decodedData.state ~= nil and decodedData.stateSpecified ~= false then
        data.state = decodedData.state
    end
    if decodedData.goalInfo ~= nil and decodedData.goalInfoSpecified ~= false then
        for i = 1, #decodedData.goalInfo do
            data.goalInfo:Add(taskV2.TaskGoalInfo(decodedData.goalInfo[i]))
        end
    end
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    if decodedData.daily ~= nil and decodedData.dailySpecified ~= false then
        data.daily = decodedData.daily
    end
    if decodedData.submitTime ~= nil and decodedData.submitTimeSpecified ~= false then
        data.submitTime = decodedData.submitTime
    end
    if decodedData.acceptTime ~= nil and decodedData.acceptTimeSpecified ~= false then
        data.acceptTime = decodedData.acceptTime
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    return data
end

---@param decodedData taskV2.TaskGoalInfo lua中的数据结构
---@return taskV2.TaskGoalInfo C#中的数据结构
function taskV2.TaskGoalInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.TaskGoalInfo()
    if decodedData.goalId ~= nil and decodedData.goalIdSpecified ~= false then
        data.goalId = decodedData.goalId
    end
    if decodedData.curCount ~= nil and decodedData.curCountSpecified ~= false then
        data.curCount = decodedData.curCount
    end
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    if decodedData.param ~= nil and decodedData.paramSpecified ~= false then
        data.param = decodedData.param
    end
    if decodedData.taskTips ~= nil and decodedData.taskTipsSpecified ~= false then
        data.taskTips = decodedData.taskTips
    end
    if decodedData.items ~= nil and decodedData.itemsSpecified ~= false then
        for i = 1, #decodedData.items do
            data.items:Add(taskV2.TaskItems(decodedData.items[i]))
        end
    end
    return data
end

---@param decodedData taskV2.TaskItems lua中的数据结构
---@return taskV2.TaskItems C#中的数据结构
function taskV2.TaskItems(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.TaskItems()
    data.item = decodedData.item
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.maxCount ~= nil and decodedData.maxCountSpecified ~= false then
        data.maxCount = decodedData.maxCount
    end
    if decodedData.groupId ~= nil and decodedData.groupIdSpecified ~= false then
        data.groupId = decodedData.groupId
    end
    return data
end

---@param decodedData taskV2.OtherTaskDataInfo lua中的数据结构
---@return taskV2.OtherTaskDataInfo C#中的数据结构
function taskV2.OtherTaskDataInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.OtherTaskDataInfo()
    data.taskType = decodedData.taskType
    data.info = taskV2.TaskDataInfo(decodedData.info)
    return data
end

---@param decodedData taskV2.ResTaskProcess lua中的数据结构
---@return taskV2.ResTaskProcess C#中的数据结构
function taskV2.ResTaskProcess(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResTaskProcess()
    data.info = taskV2.TaskDataInfo(decodedData.info)
    return data
end

---@param decodedData taskV2.SubmitTaskRequest lua中的数据结构
---@return taskV2.SubmitTaskRequest C#中的数据结构
function taskV2.SubmitTaskRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.SubmitTaskRequest()
    data.taskId = decodedData.taskId
    if decodedData.taskValue ~= nil and decodedData.taskValueSpecified ~= false then
        data.taskValue = decodedData.taskValue
    end
    --C#的taskV2.SubmitTaskRequest类中没有找到monsterTask字段,不填充数据
    return data
end

---@param decodedData taskV2.ResTaskData lua中的数据结构
---@return taskV2.ResTaskData C#中的数据结构
function taskV2.ResTaskData(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResTaskData()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = taskV2.TaskDataInfo(decodedData.info)
    end
    if decodedData.otherInfo ~= nil and decodedData.otherInfoSpecified ~= false then
        for i = 1, #decodedData.otherInfo do
            data.otherInfo:Add(taskV2.OtherTaskDataInfo(decodedData.otherInfo[i]))
        end
    end
    return data
end

---@param decodedData taskV2.ResOtherTaskState lua中的数据结构
---@return taskV2.ResOtherTaskState C#中的数据结构
function taskV2.ResOtherTaskState(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResOtherTaskState()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(taskV2.OtherTaskStateInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData taskV2.OtherTaskStateInfo lua中的数据结构
---@return taskV2.OtherTaskStateInfo C#中的数据结构
function taskV2.OtherTaskStateInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.OtherTaskStateInfo()
    data.taskId = decodedData.taskId
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData taskV2.OpenPanelInfoRequest lua中的数据结构
---@return taskV2.OpenPanelInfoRequest C#中的数据结构
function taskV2.OpenPanelInfoRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.OpenPanelInfoRequest()
    data.type = decodedData.type
    return data
end

---@param decodedData taskV2.AcceptTaskRequest lua中的数据结构
---@return taskV2.AcceptTaskRequest C#中的数据结构
function taskV2.AcceptTaskRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.AcceptTaskRequest()
    data.taskId = decodedData.taskId
    if decodedData.npcId ~= nil and decodedData.npcIdSpecified ~= false then
        data.npcId = decodedData.npcId
    end
    return data
end

---@param decodedData taskV2.CompleteTaskQuicklyRequest lua中的数据结构
---@return taskV2.CompleteTaskQuicklyRequest C#中的数据结构
function taskV2.CompleteTaskQuicklyRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.CompleteTaskQuicklyRequest()
    data.taskId = decodedData.taskId
    return data
end

---@param decodedData taskV2.ResRecycleTaskInfo lua中的数据结构
---@return taskV2.ResRecycleTaskInfo C#中的数据结构
function taskV2.ResRecycleTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResRecycleTaskInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = taskV2.TaskDataInfo(decodedData.info)
    end
    if decodedData.acceptCount ~= nil and decodedData.acceptCountSpecified ~= false then
        data.acceptCount = decodedData.acceptCount
    end
    return data
end

---@param decodedData taskV2.ResMercenaryTaskInfo lua中的数据结构
---@return taskV2.ResMercenaryTaskInfo C#中的数据结构
function taskV2.ResMercenaryTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResMercenaryTaskInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = taskV2.TaskDataInfo(decodedData.info)
    end
    if decodedData.buyTimes ~= nil and decodedData.buyTimesSpecified ~= false then
        data.buyTimes = decodedData.buyTimes
    end
    if decodedData.accepCount ~= nil and decodedData.accepCountSpecified ~= false then
        data.accepCount = decodedData.accepCount
    end
    return data
end

---@param decodedData taskV2.AutoFinishTaskRequest lua中的数据结构
---@return taskV2.AutoFinishTaskRequest C#中的数据结构
function taskV2.AutoFinishTaskRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.AutoFinishTaskRequest()
    if decodedData.taskId ~= nil and decodedData.taskIdSpecified ~= false then
        data.taskId = decodedData.taskId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData taskV2.BuyMercenaryTaskTimesRequest lua中的数据结构
---@return taskV2.BuyMercenaryTaskTimesRequest C#中的数据结构
function taskV2.BuyMercenaryTaskTimesRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.BuyMercenaryTaskTimesRequest()
    if decodedData.times ~= nil and decodedData.timesSpecified ~= false then
        data.times = decodedData.times
    end
    return data
end

---@param decodedData taskV2.ResDailyTaskInfo lua中的数据结构
---@return taskV2.ResDailyTaskInfo C#中的数据结构
function taskV2.ResDailyTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResDailyTaskInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(taskV2.DailyTaskInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData taskV2.DailyTaskInfo lua中的数据结构
---@return taskV2.DailyTaskInfo C#中的数据结构
function taskV2.DailyTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.DailyTaskInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = taskV2.TaskDataInfo(decodedData.info)
    end
    data.accepCount = decodedData.accepCount
    data.type = decodedData.type
    data.buyCount = decodedData.buyCount
    if decodedData.histroy ~= nil and decodedData.histroySpecified ~= false then
        for i = 1, #decodedData.histroy do
            data.histroy:Add(taskV2.TaskDataInfo(decodedData.histroy[i]))
        end
    end
    if decodedData.freeCount ~= nil and decodedData.freeCountSpecified ~= false then
        data.freeCount = decodedData.freeCount
    end
    return data
end

---@param decodedData taskV2.BuyDailyTaskTimesRequest lua中的数据结构
---@return taskV2.BuyDailyTaskTimesRequest C#中的数据结构
function taskV2.BuyDailyTaskTimesRequest(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.BuyDailyTaskTimesRequest()
    data.type = decodedData.type
    if decodedData.times ~= nil and decodedData.timesSpecified ~= false then
        data.times = decodedData.times
    end
    return data
end

---@param decodedData taskV2.ResMainTaskInfo lua中的数据结构
---@return taskV2.ResMainTaskInfo C#中的数据结构
function taskV2.ResMainTaskInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResMainTaskInfo()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = taskV2.TaskDataInfo(decodedData.info)
    end
    return data
end

---@param decodedData taskV2.ReqMaterialList lua中的数据结构
---@return taskV2.ReqMaterialList C#中的数据结构
function taskV2.ReqMaterialList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ReqMaterialList()
    if decodedData.profession ~= nil and decodedData.professionSpecified ~= false then
        data.profession = decodedData.profession
    end
    return data
end

---@param decodedData taskV2.ResMaterialList lua中的数据结构
---@return taskV2.ResMaterialList C#中的数据结构
function taskV2.ResMaterialList(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResMaterialList()
    if decodedData.profession ~= nil and decodedData.professionSpecified ~= false then
        data.profession = decodedData.profession
    end
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(taskV2.MaterialInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData taskV2.MaterialInfo lua中的数据结构
---@return taskV2.MaterialInfo C#中的数据结构
function taskV2.MaterialInfo(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.MaterialInfo()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.hasCount ~= nil and decodedData.hasCountSpecified ~= false then
        data.hasCount = decodedData.hasCount
    end
    if decodedData.price ~= nil and decodedData.priceSpecified ~= false then
        data.price = decodedData.price
    end
    if decodedData.storeId ~= nil and decodedData.storeIdSpecified ~= false then
        data.storeId = decodedData.storeId
    end
    return data
end

---@param decodedData taskV2.ReqBuyMaterial lua中的数据结构
---@return taskV2.ReqBuyMaterial C#中的数据结构
function taskV2.ReqBuyMaterial(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ReqBuyMaterial()
    if decodedData.buyOrSell ~= nil and decodedData.buyOrSellSpecified ~= false then
        data.buyOrSell = decodedData.buyOrSell
    end
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    if decodedData.profession ~= nil and decodedData.professionSpecified ~= false then
        data.profession = decodedData.profession
    end
    return data
end

---@param decodedData taskV2.ResMainOtherTaskInfoPanel lua中的数据结构
---@return taskV2.ResMainOtherTaskInfoPanel C#中的数据结构
function taskV2.ResMainOtherTaskInfoPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResMainOtherTaskInfoPanel()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(taskV2.TaskDataInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData taskV2.ReqSubmitDailyItem lua中的数据结构
---@return taskV2.ReqSubmitDailyItem C#中的数据结构
function taskV2.ReqSubmitDailyItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ReqSubmitDailyItem()
    data.type = decodedData.type
    return data
end

---@param decodedData taskV2.ResSubmitDailyItem lua中的数据结构
---@return taskV2.ResSubmitDailyItem C#中的数据结构
function taskV2.ResSubmitDailyItem(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResSubmitDailyItem()
    data.bool = decodedData.bool
    return data
end

---@param decodedData taskV2.ResTaskStrategy lua中的数据结构
---@return taskV2.ResTaskStrategy C#中的数据结构
function taskV2.ResTaskStrategy(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResTaskStrategy()
    data.task = decodedData.task
    return data
end

---@param decodedData taskV2.ResEliteTaskInfoPanel lua中的数据结构
---@return taskV2.ResEliteTaskInfoPanel C#中的数据结构
function taskV2.ResEliteTaskInfoPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResEliteTaskInfoPanel()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = taskV2.TaskDataInfo(decodedData.info)
    end
    if decodedData.canBuy ~= nil and decodedData.canBuySpecified ~= false then
        data.canBuy = decodedData.canBuy
    end
    if decodedData.accepCount ~= nil and decodedData.accepCountSpecified ~= false then
        data.accepCount = decodedData.accepCount
    end
    if decodedData.histroy ~= nil and decodedData.histroySpecified ~= false then
        for i = 1, #decodedData.histroy do
            data.histroy:Add(taskV2.TaskDataInfo(decodedData.histroy[i]))
        end
    end
    if decodedData.buyCount ~= nil and decodedData.buyCountSpecified ~= false then
        data.buyCount = decodedData.buyCount
    end
    if decodedData.canBuyCount ~= nil and decodedData.canBuyCountSpecified ~= false then
        data.canBuyCount = decodedData.canBuyCount
    end
    return data
end

---@param decodedData taskV2.TaskSetting lua中的数据结构
---@return taskV2.TaskSetting C#中的数据结构
function taskV2.TaskSetting(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.TaskSetting()
    if decodedData.tips ~= nil and decodedData.tipsSpecified ~= false then
        for i = 1, #decodedData.tips do
            data.tips:Add(decodedData.tips[i])
        end
    end
    return data
end

---@param decodedData taskV2.ResEliteBuyPrice lua中的数据结构
---@return taskV2.ResEliteBuyPrice C#中的数据结构
function taskV2.ResEliteBuyPrice(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResEliteBuyPrice()
    if decodedData.itemid ~= nil and decodedData.itemidSpecified ~= false then
        data.itemid = decodedData.itemid
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData taskV2.ResBossTaskInfoPanel lua中的数据结构
---@return taskV2.ResBossTaskInfoPanel C#中的数据结构
function taskV2.ResBossTaskInfoPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResBossTaskInfoPanel()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        data.info = taskV2.TaskDataInfo(decodedData.info)
    end
    if decodedData.accepCount ~= nil and decodedData.accepCountSpecified ~= false then
        data.accepCount = decodedData.accepCount
    end
    if decodedData.histroy ~= nil and decodedData.histroySpecified ~= false then
        for i = 1, #decodedData.histroy do
            data.histroy:Add(taskV2.TaskDataInfo(decodedData.histroy[i]))
        end
    end
    return data
end

---@param decodedData taskV2.ResMonsterRewardTaskInfoPanel lua中的数据结构
---@return taskV2.ResMonsterRewardTaskInfoPanel C#中的数据结构
function taskV2.ResMonsterRewardTaskInfoPanel(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.ResMonsterRewardTaskInfoPanel()
    if decodedData.info ~= nil and decodedData.infoSpecified ~= false then
        for i = 1, #decodedData.info do
            data.info:Add(taskV2.TaskDataInfo(decodedData.info[i]))
        end
    end
    return data
end

---@param decodedData taskV2.TaskReward lua中的数据结构
---@return taskV2.TaskReward C#中的数据结构
function taskV2.TaskReward(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.TaskReward()
    if decodedData.itemId ~= nil and decodedData.itemIdSpecified ~= false then
        data.itemId = decodedData.itemId
    end
    if decodedData.count ~= nil and decodedData.countSpecified ~= false then
        data.count = decodedData.count
    end
    return data
end

---@param decodedData taskV2.TheTaskHasRewarded lua中的数据结构
---@return taskV2.TheTaskHasRewarded C#中的数据结构
function taskV2.TheTaskHasRewarded(decodedData)
    if (decodedData == nil) then
        return nil
    end
    local data = CS.taskV2.TheTaskHasRewarded()
    if decodedData.reward ~= nil and decodedData.rewardSpecified ~= false then
        for i = 1, #decodedData.reward do
            data.reward:Add(taskV2.TaskReward(decodedData.reward[i]))
        end
    end
    if decodedData.per ~= nil and decodedData.perSpecified ~= false then
        data.per = decodedData.per
    end
    if decodedData.group ~= nil and decodedData.groupSpecified ~= false then
        data.group = decodedData.group
    end
    return data
end

--[[taskV2.ReqAccepNewDailyTask 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[taskV2.ReqSubmitNewDailyTask 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[taskV2.ResAllNewDailyTaskInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[taskV2.NewDailyTaskState 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[taskV2.SubmitSoulTaskItem 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[taskV2.SoulTaskInfo 未在C#中找到对应的类型,不生成对应的lua转换代码]]

--[[taskV2.SoulTaskState 未在C#中找到对应的类型,不生成对应的lua转换代码]]

return taskV2