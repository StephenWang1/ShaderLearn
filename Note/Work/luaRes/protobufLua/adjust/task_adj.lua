--[[本文件为工具自动生成,禁止手动修改]]
local taskV2_adj = {}

local adjustTable = protobufMgr.AdjustTable

--region metatable taskV2.TaskDataInfo
---@type taskV2.TaskDataInfo
taskV2_adj.metatable_TaskDataInfo = {
    _ClassName = "taskV2.TaskDataInfo",
}
taskV2_adj.metatable_TaskDataInfo.__index = taskV2_adj.metatable_TaskDataInfo
--endregion

---@param tbl taskV2.TaskDataInfo 待调整的table数据
function taskV2_adj.AdjustTaskDataInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_TaskDataInfo)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.goalInfo == nil then
        tbl.goalInfo = {}
    else
        if taskV2_adj.AdjustTaskGoalInfo ~= nil then
            for i = 1, #tbl.goalInfo do
                taskV2_adj.AdjustTaskGoalInfo(tbl.goalInfo[i])
            end
        end
    end
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
    if tbl.daily == nil then
        tbl.dailySpecified = false
        tbl.daily = 0
    else
        tbl.dailySpecified = true
    end
    if tbl.submitTime == nil then
        tbl.submitTimeSpecified = false
        tbl.submitTime = 0
    else
        tbl.submitTimeSpecified = true
    end
    if tbl.acceptTime == nil then
        tbl.acceptTimeSpecified = false
        tbl.acceptTime = 0
    else
        tbl.acceptTimeSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
end

--region metatable taskV2.TaskGoalInfo
---@type taskV2.TaskGoalInfo
taskV2_adj.metatable_TaskGoalInfo = {
    _ClassName = "taskV2.TaskGoalInfo",
}
taskV2_adj.metatable_TaskGoalInfo.__index = taskV2_adj.metatable_TaskGoalInfo
--endregion

---@param tbl taskV2.TaskGoalInfo 待调整的table数据
function taskV2_adj.AdjustTaskGoalInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_TaskGoalInfo)
    if tbl.goalId == nil then
        tbl.goalIdSpecified = false
        tbl.goalId = 0
    else
        tbl.goalIdSpecified = true
    end
    if tbl.curCount == nil then
        tbl.curCountSpecified = false
        tbl.curCount = 0
    else
        tbl.curCountSpecified = true
    end
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
    if tbl.param == nil then
        tbl.paramSpecified = false
        tbl.param = 0
    else
        tbl.paramSpecified = true
    end
    if tbl.taskTips == nil then
        tbl.taskTipsSpecified = false
        tbl.taskTips = 0
    else
        tbl.taskTipsSpecified = true
    end
    if tbl.items == nil then
        tbl.items = {}
    else
        if taskV2_adj.AdjustTaskItems ~= nil then
            for i = 1, #tbl.items do
                taskV2_adj.AdjustTaskItems(tbl.items[i])
            end
        end
    end
end

--region metatable taskV2.TaskItems
---@type taskV2.TaskItems
taskV2_adj.metatable_TaskItems = {
    _ClassName = "taskV2.TaskItems",
}
taskV2_adj.metatable_TaskItems.__index = taskV2_adj.metatable_TaskItems
--endregion

---@param tbl taskV2.TaskItems 待调整的table数据
function taskV2_adj.AdjustTaskItems(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_TaskItems)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
    if tbl.maxCount == nil then
        tbl.maxCountSpecified = false
        tbl.maxCount = 0
    else
        tbl.maxCountSpecified = true
    end
    if tbl.groupId == nil then
        tbl.groupIdSpecified = false
        tbl.groupId = 0
    else
        tbl.groupIdSpecified = true
    end
end

--region metatable taskV2.OtherTaskDataInfo
---@type taskV2.OtherTaskDataInfo
taskV2_adj.metatable_OtherTaskDataInfo = {
    _ClassName = "taskV2.OtherTaskDataInfo",
}
taskV2_adj.metatable_OtherTaskDataInfo.__index = taskV2_adj.metatable_OtherTaskDataInfo
--endregion

---@param tbl taskV2.OtherTaskDataInfo 待调整的table数据
function taskV2_adj.AdjustOtherTaskDataInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_OtherTaskDataInfo)
end

--region metatable taskV2.ResTaskProcess
---@type taskV2.ResTaskProcess
taskV2_adj.metatable_ResTaskProcess = {
    _ClassName = "taskV2.ResTaskProcess",
}
taskV2_adj.metatable_ResTaskProcess.__index = taskV2_adj.metatable_ResTaskProcess
--endregion

---@param tbl taskV2.ResTaskProcess 待调整的table数据
function taskV2_adj.AdjustResTaskProcess(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResTaskProcess)
end

--region metatable taskV2.SubmitTaskRequest
---@type taskV2.SubmitTaskRequest
taskV2_adj.metatable_SubmitTaskRequest = {
    _ClassName = "taskV2.SubmitTaskRequest",
}
taskV2_adj.metatable_SubmitTaskRequest.__index = taskV2_adj.metatable_SubmitTaskRequest
--endregion

---@param tbl taskV2.SubmitTaskRequest 待调整的table数据
function taskV2_adj.AdjustSubmitTaskRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_SubmitTaskRequest)
    if tbl.taskValue == nil then
        tbl.taskValueSpecified = false
        tbl.taskValue = 0
    else
        tbl.taskValueSpecified = true
    end
    if tbl.monsterTask == nil then
        tbl.monsterTaskSpecified = false
        tbl.monsterTask = 0
    else
        tbl.monsterTaskSpecified = true
    end
end

--region metatable taskV2.ResTaskData
---@type taskV2.ResTaskData
taskV2_adj.metatable_ResTaskData = {
    _ClassName = "taskV2.ResTaskData",
}
taskV2_adj.metatable_ResTaskData.__index = taskV2_adj.metatable_ResTaskData
--endregion

---@param tbl taskV2.ResTaskData 待调整的table数据
function taskV2_adj.AdjustResTaskData(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResTaskData)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if taskV2_adj.AdjustTaskDataInfo ~= nil then
                taskV2_adj.AdjustTaskDataInfo(tbl.info)
            end
        end
    end
    if tbl.otherInfo == nil then
        tbl.otherInfo = {}
    else
        if taskV2_adj.AdjustOtherTaskDataInfo ~= nil then
            for i = 1, #tbl.otherInfo do
                taskV2_adj.AdjustOtherTaskDataInfo(tbl.otherInfo[i])
            end
        end
    end
end

--region metatable taskV2.ResOtherTaskState
---@type taskV2.ResOtherTaskState
taskV2_adj.metatable_ResOtherTaskState = {
    _ClassName = "taskV2.ResOtherTaskState",
}
taskV2_adj.metatable_ResOtherTaskState.__index = taskV2_adj.metatable_ResOtherTaskState
--endregion

---@param tbl taskV2.ResOtherTaskState 待调整的table数据
function taskV2_adj.AdjustResOtherTaskState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResOtherTaskState)
    if tbl.info == nil then
        tbl.info = {}
    else
        if taskV2_adj.AdjustOtherTaskStateInfo ~= nil then
            for i = 1, #tbl.info do
                taskV2_adj.AdjustOtherTaskStateInfo(tbl.info[i])
            end
        end
    end
end

--region metatable taskV2.OtherTaskStateInfo
---@type taskV2.OtherTaskStateInfo
taskV2_adj.metatable_OtherTaskStateInfo = {
    _ClassName = "taskV2.OtherTaskStateInfo",
}
taskV2_adj.metatable_OtherTaskStateInfo.__index = taskV2_adj.metatable_OtherTaskStateInfo
--endregion

---@param tbl taskV2.OtherTaskStateInfo 待调整的table数据
function taskV2_adj.AdjustOtherTaskStateInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_OtherTaskStateInfo)
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable taskV2.OpenPanelInfoRequest
---@type taskV2.OpenPanelInfoRequest
taskV2_adj.metatable_OpenPanelInfoRequest = {
    _ClassName = "taskV2.OpenPanelInfoRequest",
}
taskV2_adj.metatable_OpenPanelInfoRequest.__index = taskV2_adj.metatable_OpenPanelInfoRequest
--endregion

---@param tbl taskV2.OpenPanelInfoRequest 待调整的table数据
function taskV2_adj.AdjustOpenPanelInfoRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_OpenPanelInfoRequest)
end

--region metatable taskV2.AcceptTaskRequest
---@type taskV2.AcceptTaskRequest
taskV2_adj.metatable_AcceptTaskRequest = {
    _ClassName = "taskV2.AcceptTaskRequest",
}
taskV2_adj.metatable_AcceptTaskRequest.__index = taskV2_adj.metatable_AcceptTaskRequest
--endregion

---@param tbl taskV2.AcceptTaskRequest 待调整的table数据
function taskV2_adj.AdjustAcceptTaskRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_AcceptTaskRequest)
    if tbl.npcId == nil then
        tbl.npcIdSpecified = false
        tbl.npcId = 0
    else
        tbl.npcIdSpecified = true
    end
end

--region metatable taskV2.CompleteTaskQuicklyRequest
---@type taskV2.CompleteTaskQuicklyRequest
taskV2_adj.metatable_CompleteTaskQuicklyRequest = {
    _ClassName = "taskV2.CompleteTaskQuicklyRequest",
}
taskV2_adj.metatable_CompleteTaskQuicklyRequest.__index = taskV2_adj.metatable_CompleteTaskQuicklyRequest
--endregion

---@param tbl taskV2.CompleteTaskQuicklyRequest 待调整的table数据
function taskV2_adj.AdjustCompleteTaskQuicklyRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_CompleteTaskQuicklyRequest)
end

--region metatable taskV2.ResRecycleTaskInfo
---@type taskV2.ResRecycleTaskInfo
taskV2_adj.metatable_ResRecycleTaskInfo = {
    _ClassName = "taskV2.ResRecycleTaskInfo",
}
taskV2_adj.metatable_ResRecycleTaskInfo.__index = taskV2_adj.metatable_ResRecycleTaskInfo
--endregion

---@param tbl taskV2.ResRecycleTaskInfo 待调整的table数据
function taskV2_adj.AdjustResRecycleTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResRecycleTaskInfo)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if taskV2_adj.AdjustTaskDataInfo ~= nil then
                taskV2_adj.AdjustTaskDataInfo(tbl.info)
            end
        end
    end
    if tbl.acceptCount == nil then
        tbl.acceptCountSpecified = false
        tbl.acceptCount = 0
    else
        tbl.acceptCountSpecified = true
    end
end

--region metatable taskV2.ResMercenaryTaskInfo
---@type taskV2.ResMercenaryTaskInfo
taskV2_adj.metatable_ResMercenaryTaskInfo = {
    _ClassName = "taskV2.ResMercenaryTaskInfo",
}
taskV2_adj.metatable_ResMercenaryTaskInfo.__index = taskV2_adj.metatable_ResMercenaryTaskInfo
--endregion

---@param tbl taskV2.ResMercenaryTaskInfo 待调整的table数据
function taskV2_adj.AdjustResMercenaryTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResMercenaryTaskInfo)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if taskV2_adj.AdjustTaskDataInfo ~= nil then
                taskV2_adj.AdjustTaskDataInfo(tbl.info)
            end
        end
    end
    if tbl.buyTimes == nil then
        tbl.buyTimesSpecified = false
        tbl.buyTimes = 0
    else
        tbl.buyTimesSpecified = true
    end
    if tbl.accepCount == nil then
        tbl.accepCountSpecified = false
        tbl.accepCount = 0
    else
        tbl.accepCountSpecified = true
    end
end

--region metatable taskV2.AutoFinishTaskRequest
---@type taskV2.AutoFinishTaskRequest
taskV2_adj.metatable_AutoFinishTaskRequest = {
    _ClassName = "taskV2.AutoFinishTaskRequest",
}
taskV2_adj.metatable_AutoFinishTaskRequest.__index = taskV2_adj.metatable_AutoFinishTaskRequest
--endregion

---@param tbl taskV2.AutoFinishTaskRequest 待调整的table数据
function taskV2_adj.AdjustAutoFinishTaskRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_AutoFinishTaskRequest)
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

--region metatable taskV2.BuyMercenaryTaskTimesRequest
---@type taskV2.BuyMercenaryTaskTimesRequest
taskV2_adj.metatable_BuyMercenaryTaskTimesRequest = {
    _ClassName = "taskV2.BuyMercenaryTaskTimesRequest",
}
taskV2_adj.metatable_BuyMercenaryTaskTimesRequest.__index = taskV2_adj.metatable_BuyMercenaryTaskTimesRequest
--endregion

---@param tbl taskV2.BuyMercenaryTaskTimesRequest 待调整的table数据
function taskV2_adj.AdjustBuyMercenaryTaskTimesRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_BuyMercenaryTaskTimesRequest)
    if tbl.times == nil then
        tbl.timesSpecified = false
        tbl.times = 0
    else
        tbl.timesSpecified = true
    end
end

--region metatable taskV2.ResDailyTaskInfo
---@type taskV2.ResDailyTaskInfo
taskV2_adj.metatable_ResDailyTaskInfo = {
    _ClassName = "taskV2.ResDailyTaskInfo",
}
taskV2_adj.metatable_ResDailyTaskInfo.__index = taskV2_adj.metatable_ResDailyTaskInfo
--endregion

---@param tbl taskV2.ResDailyTaskInfo 待调整的table数据
function taskV2_adj.AdjustResDailyTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResDailyTaskInfo)
    if tbl.info == nil then
        tbl.info = {}
    else
        if taskV2_adj.AdjustDailyTaskInfo ~= nil then
            for i = 1, #tbl.info do
                taskV2_adj.AdjustDailyTaskInfo(tbl.info[i])
            end
        end
    end
end

--region metatable taskV2.DailyTaskInfo
---@type taskV2.DailyTaskInfo
taskV2_adj.metatable_DailyTaskInfo = {
    _ClassName = "taskV2.DailyTaskInfo",
}
taskV2_adj.metatable_DailyTaskInfo.__index = taskV2_adj.metatable_DailyTaskInfo
--endregion

---@param tbl taskV2.DailyTaskInfo 待调整的table数据
function taskV2_adj.AdjustDailyTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_DailyTaskInfo)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if taskV2_adj.AdjustTaskDataInfo ~= nil then
                taskV2_adj.AdjustTaskDataInfo(tbl.info)
            end
        end
    end
    if tbl.histroy == nil then
        tbl.histroy = {}
    else
        if taskV2_adj.AdjustTaskDataInfo ~= nil then
            for i = 1, #tbl.histroy do
                taskV2_adj.AdjustTaskDataInfo(tbl.histroy[i])
            end
        end
    end
    if tbl.freeCount == nil then
        tbl.freeCountSpecified = false
        tbl.freeCount = 0
    else
        tbl.freeCountSpecified = true
    end
end

--region metatable taskV2.BuyDailyTaskTimesRequest
---@type taskV2.BuyDailyTaskTimesRequest
taskV2_adj.metatable_BuyDailyTaskTimesRequest = {
    _ClassName = "taskV2.BuyDailyTaskTimesRequest",
}
taskV2_adj.metatable_BuyDailyTaskTimesRequest.__index = taskV2_adj.metatable_BuyDailyTaskTimesRequest
--endregion

---@param tbl taskV2.BuyDailyTaskTimesRequest 待调整的table数据
function taskV2_adj.AdjustBuyDailyTaskTimesRequest(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_BuyDailyTaskTimesRequest)
    if tbl.times == nil then
        tbl.timesSpecified = false
        tbl.times = 0
    else
        tbl.timesSpecified = true
    end
end

--region metatable taskV2.ResMainTaskInfo
---@type taskV2.ResMainTaskInfo
taskV2_adj.metatable_ResMainTaskInfo = {
    _ClassName = "taskV2.ResMainTaskInfo",
}
taskV2_adj.metatable_ResMainTaskInfo.__index = taskV2_adj.metatable_ResMainTaskInfo
--endregion

---@param tbl taskV2.ResMainTaskInfo 待调整的table数据
function taskV2_adj.AdjustResMainTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResMainTaskInfo)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if taskV2_adj.AdjustTaskDataInfo ~= nil then
                taskV2_adj.AdjustTaskDataInfo(tbl.info)
            end
        end
    end
end

--region metatable taskV2.ReqMaterialList
---@type taskV2.ReqMaterialList
taskV2_adj.metatable_ReqMaterialList = {
    _ClassName = "taskV2.ReqMaterialList",
}
taskV2_adj.metatable_ReqMaterialList.__index = taskV2_adj.metatable_ReqMaterialList
--endregion

---@param tbl taskV2.ReqMaterialList 待调整的table数据
function taskV2_adj.AdjustReqMaterialList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ReqMaterialList)
    if tbl.profession == nil then
        tbl.professionSpecified = false
        tbl.profession = 0
    else
        tbl.professionSpecified = true
    end
end

--region metatable taskV2.ResMaterialList
---@type taskV2.ResMaterialList
taskV2_adj.metatable_ResMaterialList = {
    _ClassName = "taskV2.ResMaterialList",
}
taskV2_adj.metatable_ResMaterialList.__index = taskV2_adj.metatable_ResMaterialList
--endregion

---@param tbl taskV2.ResMaterialList 待调整的table数据
function taskV2_adj.AdjustResMaterialList(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResMaterialList)
    if tbl.profession == nil then
        tbl.professionSpecified = false
        tbl.profession = 0
    else
        tbl.professionSpecified = true
    end
    if tbl.info == nil then
        tbl.info = {}
    else
        if taskV2_adj.AdjustMaterialInfo ~= nil then
            for i = 1, #tbl.info do
                taskV2_adj.AdjustMaterialInfo(tbl.info[i])
            end
        end
    end
end

--region metatable taskV2.MaterialInfo
---@type taskV2.MaterialInfo
taskV2_adj.metatable_MaterialInfo = {
    _ClassName = "taskV2.MaterialInfo",
}
taskV2_adj.metatable_MaterialInfo.__index = taskV2_adj.metatable_MaterialInfo
--endregion

---@param tbl taskV2.MaterialInfo 待调整的table数据
function taskV2_adj.AdjustMaterialInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_MaterialInfo)
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
    if tbl.hasCount == nil then
        tbl.hasCountSpecified = false
        tbl.hasCount = 0
    else
        tbl.hasCountSpecified = true
    end
    if tbl.price == nil then
        tbl.priceSpecified = false
        tbl.price = 0
    else
        tbl.priceSpecified = true
    end
    if tbl.storeId == nil then
        tbl.storeIdSpecified = false
        tbl.storeId = 0
    else
        tbl.storeIdSpecified = true
    end
end

--region metatable taskV2.ReqBuyMaterial
---@type taskV2.ReqBuyMaterial
taskV2_adj.metatable_ReqBuyMaterial = {
    _ClassName = "taskV2.ReqBuyMaterial",
}
taskV2_adj.metatable_ReqBuyMaterial.__index = taskV2_adj.metatable_ReqBuyMaterial
--endregion

---@param tbl taskV2.ReqBuyMaterial 待调整的table数据
function taskV2_adj.AdjustReqBuyMaterial(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ReqBuyMaterial)
    if tbl.buyOrSell == nil then
        tbl.buyOrSellSpecified = false
        tbl.buyOrSell = 0
    else
        tbl.buyOrSellSpecified = true
    end
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
    if tbl.profession == nil then
        tbl.professionSpecified = false
        tbl.profession = 0
    else
        tbl.professionSpecified = true
    end
end

--region metatable taskV2.ResMainOtherTaskInfoPanel
---@type taskV2.ResMainOtherTaskInfoPanel
taskV2_adj.metatable_ResMainOtherTaskInfoPanel = {
    _ClassName = "taskV2.ResMainOtherTaskInfoPanel",
}
taskV2_adj.metatable_ResMainOtherTaskInfoPanel.__index = taskV2_adj.metatable_ResMainOtherTaskInfoPanel
--endregion

---@param tbl taskV2.ResMainOtherTaskInfoPanel 待调整的table数据
function taskV2_adj.AdjustResMainOtherTaskInfoPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResMainOtherTaskInfoPanel)
    if tbl.info == nil then
        tbl.info = {}
    else
        if taskV2_adj.AdjustTaskDataInfo ~= nil then
            for i = 1, #tbl.info do
                taskV2_adj.AdjustTaskDataInfo(tbl.info[i])
            end
        end
    end
end

--region metatable taskV2.ReqSubmitDailyItem
---@type taskV2.ReqSubmitDailyItem
taskV2_adj.metatable_ReqSubmitDailyItem = {
    _ClassName = "taskV2.ReqSubmitDailyItem",
}
taskV2_adj.metatable_ReqSubmitDailyItem.__index = taskV2_adj.metatable_ReqSubmitDailyItem
--endregion

---@param tbl taskV2.ReqSubmitDailyItem 待调整的table数据
function taskV2_adj.AdjustReqSubmitDailyItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ReqSubmitDailyItem)
end

--region metatable taskV2.ResSubmitDailyItem
---@type taskV2.ResSubmitDailyItem
taskV2_adj.metatable_ResSubmitDailyItem = {
    _ClassName = "taskV2.ResSubmitDailyItem",
}
taskV2_adj.metatable_ResSubmitDailyItem.__index = taskV2_adj.metatable_ResSubmitDailyItem
--endregion

---@param tbl taskV2.ResSubmitDailyItem 待调整的table数据
function taskV2_adj.AdjustResSubmitDailyItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResSubmitDailyItem)
end

--region metatable taskV2.ResTaskStrategy
---@type taskV2.ResTaskStrategy
taskV2_adj.metatable_ResTaskStrategy = {
    _ClassName = "taskV2.ResTaskStrategy",
}
taskV2_adj.metatable_ResTaskStrategy.__index = taskV2_adj.metatable_ResTaskStrategy
--endregion

---@param tbl taskV2.ResTaskStrategy 待调整的table数据
function taskV2_adj.AdjustResTaskStrategy(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResTaskStrategy)
end

--region metatable taskV2.ResEliteTaskInfoPanel
---@type taskV2.ResEliteTaskInfoPanel
taskV2_adj.metatable_ResEliteTaskInfoPanel = {
    _ClassName = "taskV2.ResEliteTaskInfoPanel",
}
taskV2_adj.metatable_ResEliteTaskInfoPanel.__index = taskV2_adj.metatable_ResEliteTaskInfoPanel
--endregion

---@param tbl taskV2.ResEliteTaskInfoPanel 待调整的table数据
function taskV2_adj.AdjustResEliteTaskInfoPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResEliteTaskInfoPanel)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if taskV2_adj.AdjustTaskDataInfo ~= nil then
                taskV2_adj.AdjustTaskDataInfo(tbl.info)
            end
        end
    end
    if tbl.canBuy == nil then
        tbl.canBuySpecified = false
        tbl.canBuy = false
    else
        tbl.canBuySpecified = true
    end
    if tbl.accepCount == nil then
        tbl.accepCountSpecified = false
        tbl.accepCount = 0
    else
        tbl.accepCountSpecified = true
    end
    if tbl.histroy == nil then
        tbl.histroy = {}
    else
        if taskV2_adj.AdjustTaskDataInfo ~= nil then
            for i = 1, #tbl.histroy do
                taskV2_adj.AdjustTaskDataInfo(tbl.histroy[i])
            end
        end
    end
    if tbl.buyCount == nil then
        tbl.buyCountSpecified = false
        tbl.buyCount = 0
    else
        tbl.buyCountSpecified = true
    end
    if tbl.canBuyCount == nil then
        tbl.canBuyCountSpecified = false
        tbl.canBuyCount = 0
    else
        tbl.canBuyCountSpecified = true
    end
end

--region metatable taskV2.TaskSetting
---@type taskV2.TaskSetting
taskV2_adj.metatable_TaskSetting = {
    _ClassName = "taskV2.TaskSetting",
}
taskV2_adj.metatable_TaskSetting.__index = taskV2_adj.metatable_TaskSetting
--endregion

---@param tbl taskV2.TaskSetting 待调整的table数据
function taskV2_adj.AdjustTaskSetting(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_TaskSetting)
    if tbl.tips == nil then
        tbl.tips = {}
    end
end

--region metatable taskV2.ResEliteBuyPrice
---@type taskV2.ResEliteBuyPrice
taskV2_adj.metatable_ResEliteBuyPrice = {
    _ClassName = "taskV2.ResEliteBuyPrice",
}
taskV2_adj.metatable_ResEliteBuyPrice.__index = taskV2_adj.metatable_ResEliteBuyPrice
--endregion

---@param tbl taskV2.ResEliteBuyPrice 待调整的table数据
function taskV2_adj.AdjustResEliteBuyPrice(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResEliteBuyPrice)
    if tbl.itemid == nil then
        tbl.itemidSpecified = false
        tbl.itemid = 0
    else
        tbl.itemidSpecified = true
    end
    if tbl.count == nil then
        tbl.countSpecified = false
        tbl.count = 0
    else
        tbl.countSpecified = true
    end
end

--region metatable taskV2.ResBossTaskInfoPanel
---@type taskV2.ResBossTaskInfoPanel
taskV2_adj.metatable_ResBossTaskInfoPanel = {
    _ClassName = "taskV2.ResBossTaskInfoPanel",
}
taskV2_adj.metatable_ResBossTaskInfoPanel.__index = taskV2_adj.metatable_ResBossTaskInfoPanel
--endregion

---@param tbl taskV2.ResBossTaskInfoPanel 待调整的table数据
function taskV2_adj.AdjustResBossTaskInfoPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResBossTaskInfoPanel)
    if tbl.info == nil then
        tbl.infoSpecified = false
        tbl.info = nil
    else
        if tbl.infoSpecified == nil then 
            tbl.infoSpecified = true
            if taskV2_adj.AdjustTaskDataInfo ~= nil then
                taskV2_adj.AdjustTaskDataInfo(tbl.info)
            end
        end
    end
    if tbl.accepCount == nil then
        tbl.accepCountSpecified = false
        tbl.accepCount = 0
    else
        tbl.accepCountSpecified = true
    end
    if tbl.histroy == nil then
        tbl.histroy = {}
    else
        if taskV2_adj.AdjustTaskDataInfo ~= nil then
            for i = 1, #tbl.histroy do
                taskV2_adj.AdjustTaskDataInfo(tbl.histroy[i])
            end
        end
    end
end

--region metatable taskV2.ResMonsterRewardTaskInfoPanel
---@type taskV2.ResMonsterRewardTaskInfoPanel
taskV2_adj.metatable_ResMonsterRewardTaskInfoPanel = {
    _ClassName = "taskV2.ResMonsterRewardTaskInfoPanel",
}
taskV2_adj.metatable_ResMonsterRewardTaskInfoPanel.__index = taskV2_adj.metatable_ResMonsterRewardTaskInfoPanel
--endregion

---@param tbl taskV2.ResMonsterRewardTaskInfoPanel 待调整的table数据
function taskV2_adj.AdjustResMonsterRewardTaskInfoPanel(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResMonsterRewardTaskInfoPanel)
    if tbl.info == nil then
        tbl.info = {}
    else
        if taskV2_adj.AdjustTaskDataInfo ~= nil then
            for i = 1, #tbl.info do
                taskV2_adj.AdjustTaskDataInfo(tbl.info[i])
            end
        end
    end
end

--region metatable taskV2.TaskReward
---@type taskV2.TaskReward
taskV2_adj.metatable_TaskReward = {
    _ClassName = "taskV2.TaskReward",
}
taskV2_adj.metatable_TaskReward.__index = taskV2_adj.metatable_TaskReward
--endregion

---@param tbl taskV2.TaskReward 待调整的table数据
function taskV2_adj.AdjustTaskReward(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_TaskReward)
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

--region metatable taskV2.TheTaskHasRewarded
---@type taskV2.TheTaskHasRewarded
taskV2_adj.metatable_TheTaskHasRewarded = {
    _ClassName = "taskV2.TheTaskHasRewarded",
}
taskV2_adj.metatable_TheTaskHasRewarded.__index = taskV2_adj.metatable_TheTaskHasRewarded
--endregion

---@param tbl taskV2.TheTaskHasRewarded 待调整的table数据
function taskV2_adj.AdjustTheTaskHasRewarded(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_TheTaskHasRewarded)
    if tbl.reward == nil then
        tbl.reward = {}
    else
        if taskV2_adj.AdjustTaskReward ~= nil then
            for i = 1, #tbl.reward do
                taskV2_adj.AdjustTaskReward(tbl.reward[i])
            end
        end
    end
    if tbl.per == nil then
        tbl.perSpecified = false
        tbl.per = 0
    else
        tbl.perSpecified = true
    end
    if tbl.group == nil then
        tbl.groupSpecified = false
        tbl.group = 0
    else
        tbl.groupSpecified = true
    end
end

--region metatable taskV2.ReqAccepNewDailyTask
---@type taskV2.ReqAccepNewDailyTask
taskV2_adj.metatable_ReqAccepNewDailyTask = {
    _ClassName = "taskV2.ReqAccepNewDailyTask",
}
taskV2_adj.metatable_ReqAccepNewDailyTask.__index = taskV2_adj.metatable_ReqAccepNewDailyTask
--endregion

---@param tbl taskV2.ReqAccepNewDailyTask 待调整的table数据
function taskV2_adj.AdjustReqAccepNewDailyTask(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ReqAccepNewDailyTask)
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
end

--region metatable taskV2.ReqSubmitNewDailyTask
---@type taskV2.ReqSubmitNewDailyTask
taskV2_adj.metatable_ReqSubmitNewDailyTask = {
    _ClassName = "taskV2.ReqSubmitNewDailyTask",
}
taskV2_adj.metatable_ReqSubmitNewDailyTask.__index = taskV2_adj.metatable_ReqSubmitNewDailyTask
--endregion

---@param tbl taskV2.ReqSubmitNewDailyTask 待调整的table数据
function taskV2_adj.AdjustReqSubmitNewDailyTask(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ReqSubmitNewDailyTask)
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.double == nil then
        tbl.doubleSpecified = false
        tbl.double = false
    else
        tbl.doubleSpecified = true
    end
end

--region metatable taskV2.ResAllNewDailyTaskInfo
---@type taskV2.ResAllNewDailyTaskInfo
taskV2_adj.metatable_ResAllNewDailyTaskInfo = {
    _ClassName = "taskV2.ResAllNewDailyTaskInfo",
}
taskV2_adj.metatable_ResAllNewDailyTaskInfo.__index = taskV2_adj.metatable_ResAllNewDailyTaskInfo
--endregion

---@param tbl taskV2.ResAllNewDailyTaskInfo 待调整的table数据
function taskV2_adj.AdjustResAllNewDailyTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_ResAllNewDailyTaskInfo)
    if tbl.tadayCount == nil then
        tbl.tadayCountSpecified = false
        tbl.tadayCount = 0
    else
        tbl.tadayCountSpecified = true
    end
    if tbl.state == nil then
        tbl.state = {}
    else
        if taskV2_adj.AdjustNewDailyTaskState ~= nil then
            for i = 1, #tbl.state do
                taskV2_adj.AdjustNewDailyTaskState(tbl.state[i])
            end
        end
    end
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable taskV2.NewDailyTaskState
---@type taskV2.NewDailyTaskState
taskV2_adj.metatable_NewDailyTaskState = {
    _ClassName = "taskV2.NewDailyTaskState",
}
taskV2_adj.metatable_NewDailyTaskState.__index = taskV2_adj.metatable_NewDailyTaskState
--endregion

---@param tbl taskV2.NewDailyTaskState 待调整的table数据
function taskV2_adj.AdjustNewDailyTaskState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_NewDailyTaskState)
    if tbl.monsterId == nil then
        tbl.monsterIdSpecified = false
        tbl.monsterId = 0
    else
        tbl.monsterIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
    if tbl.bossId == nil then
        tbl.bossIdSpecified = false
        tbl.bossId = 0
    else
        tbl.bossIdSpecified = true
    end
    if tbl.curKillCount == nil then
        tbl.curKillCountSpecified = false
        tbl.curKillCount = 0
    else
        tbl.curKillCountSpecified = true
    end
end

--region metatable taskV2.SubmitSoulTaskItem
---@type taskV2.SubmitSoulTaskItem
taskV2_adj.metatable_SubmitSoulTaskItem = {
    _ClassName = "taskV2.SubmitSoulTaskItem",
}
taskV2_adj.metatable_SubmitSoulTaskItem.__index = taskV2_adj.metatable_SubmitSoulTaskItem
--endregion

---@param tbl taskV2.SubmitSoulTaskItem 待调整的table数据
function taskV2_adj.AdjustSubmitSoulTaskItem(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_SubmitSoulTaskItem)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
end

--region metatable taskV2.SoulTaskInfo
---@type taskV2.SoulTaskInfo
taskV2_adj.metatable_SoulTaskInfo = {
    _ClassName = "taskV2.SoulTaskInfo",
}
taskV2_adj.metatable_SoulTaskInfo.__index = taskV2_adj.metatable_SoulTaskInfo
--endregion

---@param tbl taskV2.SoulTaskInfo 待调整的table数据
function taskV2_adj.AdjustSoulTaskInfo(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_SoulTaskInfo)
    if tbl.completeCount == nil then
        tbl.completeCountSpecified = false
        tbl.completeCount = 0
    else
        tbl.completeCountSpecified = true
    end
    if tbl.state == nil then
        tbl.state = {}
    else
        if taskV2_adj.AdjustSoulTaskState ~= nil then
            for i = 1, #tbl.state do
                taskV2_adj.AdjustSoulTaskState(tbl.state[i])
            end
        end
    end
end

--region metatable taskV2.SoulTaskState
---@type taskV2.SoulTaskState
taskV2_adj.metatable_SoulTaskState = {
    _ClassName = "taskV2.SoulTaskState",
}
taskV2_adj.metatable_SoulTaskState.__index = taskV2_adj.metatable_SoulTaskState
--endregion

---@param tbl taskV2.SoulTaskState 待调整的table数据
function taskV2_adj.AdjustSoulTaskState(tbl)
    if (tbl == nil) then
        return
    end
    setmetatable(tbl, taskV2_adj.metatable_SoulTaskState)
    if tbl.taskId == nil then
        tbl.taskIdSpecified = false
        tbl.taskId = 0
    else
        tbl.taskIdSpecified = true
    end
    if tbl.state == nil then
        tbl.stateSpecified = false
        tbl.state = 0
    else
        tbl.stateSpecified = true
    end
end

return taskV2_adj