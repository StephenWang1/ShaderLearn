--[[本文件为工具自动生成,禁止手动修改]]
--task.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回任务进度消息
---msgID: 102001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTaskProcessMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102001 taskV2.ResTaskProcess 返回任务进度消息")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResTaskProcess", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResTaskProcess ~= nil then
        protoAdjust.task_adj.AdjustResTaskProcess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102001
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回任务列表
---msgID: 102003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllTaskListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102003 taskV2.ResTaskData 返回任务列表")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResTaskData", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResTaskData ~= nil then
        protoAdjust.task_adj.AdjustResTaskData(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102003
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回支线任务状态
---msgID: 102004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOtherTaskStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102004 taskV2.ResOtherTaskState 返回支线任务状态")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResOtherTaskState", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResOtherTaskState ~= nil then
        protoAdjust.task_adj.AdjustResOtherTaskState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102004
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回循环任务面板
---msgID: 102008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRecycleTaskInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102008 taskV2.ResRecycleTaskInfo 返回循环任务面板")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResRecycleTaskInfo", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResRecycleTaskInfo ~= nil then
        protoAdjust.task_adj.AdjustResRecycleTaskInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102008
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回雇佣兵任务面板信息
---msgID: 102011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMercenaryTaskInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102011 taskV2.ResMercenaryTaskInfo 返回雇佣兵任务面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResMercenaryTaskInfo", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResMercenaryTaskInfo ~= nil then
        protoAdjust.task_adj.AdjustResMercenaryTaskInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102011
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回日常任务面板信息
---msgID: 102012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDailyTaskInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102012 taskV2.ResDailyTaskInfo 返回日常任务面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResDailyTaskInfo", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResDailyTaskInfo ~= nil then
        protoAdjust.task_adj.AdjustResDailyTaskInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102012
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回主线任务面板
---msgID: 102014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMainTaskInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102014 taskV2.ResMainTaskInfo 返回主线任务面板")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResMainTaskInfo", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResMainTaskInfo ~= nil then
        protoAdjust.task_adj.AdjustResMainTaskInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102014
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回日常材料列表
---msgID: 102016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMaterialListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102016 taskV2.ResMaterialList 返回日常材料列表")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResMaterialList", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResMaterialList ~= nil then
        protoAdjust.task_adj.AdjustResMaterialList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102016
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回支线任务信息
---msgID: 102018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMainOtherTaskInfoPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102018 taskV2.ResMainOtherTaskInfoPanel 返回支线任务信息")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResMainOtherTaskInfoPanel", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResMainOtherTaskInfoPanel ~= nil then
        protoAdjust.task_adj.AdjustResMainOtherTaskInfoPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102018
    protobufMgr.mMsgDeserializedTblCache = res
end

---攻略
---msgID: 102020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTaskStrategyMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102020 taskV2.ResTaskStrategy 攻略")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResTaskStrategy", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResTaskStrategy ~= nil then
        protoAdjust.task_adj.AdjustResTaskStrategy(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102020
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回精英任务
---msgID: 102021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEliteTaskInfoPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102021 taskV2.ResEliteTaskInfoPanel 返回精英任务")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResEliteTaskInfoPanel", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResEliteTaskInfoPanel ~= nil then
        protoAdjust.task_adj.AdjustResEliteTaskInfoPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102021
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回任务设置
---msgID: 102023
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTaskSettingMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102023 taskV2.TaskSetting 返回任务设置")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.TaskSetting", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustTaskSetting ~= nil then
        protoAdjust.task_adj.AdjustTaskSetting(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102023
    protobufMgr.mMsgDeserializedTblCache = res
end

---精英任务购买价格回复
---msgID: 102026
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEliteBuyPriceMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102026 taskV2.ResEliteBuyPrice 精英任务购买价格回复")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResEliteBuyPrice", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResEliteBuyPrice ~= nil then
        protoAdjust.task_adj.AdjustResEliteBuyPrice(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102026
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回Boss任务
---msgID: 102027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBossTaskInfoPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102027 taskV2.ResBossTaskInfoPanel 返回Boss任务")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResBossTaskInfoPanel", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResBossTaskInfoPanel ~= nil then
        protoAdjust.task_adj.AdjustResBossTaskInfoPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102027
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回怪物悬赏任务
---msgID: 102028
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMonsterRewardTaskInfoPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102028 taskV2.ResMonsterRewardTaskInfoPanel 返回怪物悬赏任务")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResMonsterRewardTaskInfoPanel", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResMonsterRewardTaskInfoPanel ~= nil then
        protoAdjust.task_adj.AdjustResMonsterRewardTaskInfoPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102028
    protobufMgr.mMsgDeserializedTblCache = res
end

---任务奖励提示
---msgID: 102029
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTheTaskHasRewardedMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102029 taskV2.TheTaskHasRewarded 任务奖励提示")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.TheTaskHasRewarded", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustTheTaskHasRewarded ~= nil then
        protoAdjust.task_adj.AdjustTheTaskHasRewarded(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102029
    protobufMgr.mMsgDeserializedTblCache = res
end

---现有全部
---msgID: 102030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMonsterTaskAllCompleteMessageReceived(msgID, buffer)
end

---全部日常任务信息
---msgID: 102033
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllNewDailyTaskInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102033 taskV2.ResAllNewDailyTaskInfo 全部日常任务信息")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.ResAllNewDailyTaskInfo", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustResAllNewDailyTaskInfo ~= nil then
        protoAdjust.task_adj.AdjustResAllNewDailyTaskInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102033
    protobufMgr.mMsgDeserializedTblCache = res
end

---灵魂任务信息
---msgID: 102036
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSoulTaskStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 102036 taskV2.SoulTaskInfo 灵魂任务信息")
        return nil
    end
    local res = protobufMgr.Deserialize("taskV2.SoulTaskInfo", buffer)
    if protoAdjust.task_adj ~= nil and protoAdjust.task_adj.AdjustSoulTaskInfo ~= nil then
        protoAdjust.task_adj.AdjustSoulTaskInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 102036
    protobufMgr.mMsgDeserializedTblCache = res
end

