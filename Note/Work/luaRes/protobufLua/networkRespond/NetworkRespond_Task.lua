--[[本文件为工具自动生成,禁止手动修改]]
--task.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回任务进度消息
---msgID: 102001
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResTaskProcess C#数据结构
function networkRespond.OnResTaskProcessMessageReceived(msgID)
    ---@type taskV2.ResTaskProcess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102001 taskV2.ResTaskProcess 返回任务进度消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResTaskProcess ~= nil then
        csData = protobufMgr.DecodeTable.task.ResTaskProcess(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回任务列表
---msgID: 102003
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResTaskData C#数据结构
function networkRespond.OnResAllTaskListMessageReceived(msgID)
    ---@type taskV2.ResTaskData
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102003 taskV2.ResTaskData 返回任务列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResTaskData ~= nil then
        csData = protobufMgr.DecodeTable.task.ResTaskData(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回支线任务状态
---msgID: 102004
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResOtherTaskState C#数据结构
function networkRespond.OnResOtherTaskStateMessageReceived(msgID)
    ---@type taskV2.ResOtherTaskState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102004 taskV2.ResOtherTaskState 返回支线任务状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResOtherTaskState ~= nil then
        csData = protobufMgr.DecodeTable.task.ResOtherTaskState(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回循环任务面板
---msgID: 102008
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResRecycleTaskInfo C#数据结构
function networkRespond.OnResRecycleTaskInfoMessageReceived(msgID)
    ---@type taskV2.ResRecycleTaskInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102008 taskV2.ResRecycleTaskInfo 返回循环任务面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResRecycleTaskInfo ~= nil then
        csData = protobufMgr.DecodeTable.task.ResRecycleTaskInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回雇佣兵任务面板信息
---msgID: 102011
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResMercenaryTaskInfo C#数据结构
function networkRespond.OnResMercenaryTaskInfoMessageReceived(msgID)
    ---@type taskV2.ResMercenaryTaskInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102011 taskV2.ResMercenaryTaskInfo 返回雇佣兵任务面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResMercenaryTaskInfo ~= nil then
        csData = protobufMgr.DecodeTable.task.ResMercenaryTaskInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回日常任务面板信息
---msgID: 102012
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResDailyTaskInfo C#数据结构
function networkRespond.OnResDailyTaskInfoMessageReceived(msgID)
    ---@type taskV2.ResDailyTaskInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102012 taskV2.ResDailyTaskInfo 返回日常任务面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResDailyTaskInfo ~= nil then
        csData = protobufMgr.DecodeTable.task.ResDailyTaskInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回主线任务面板
---msgID: 102014
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResMainTaskInfo C#数据结构
function networkRespond.OnResMainTaskInfoMessageReceived(msgID)
    ---@type taskV2.ResMainTaskInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102014 taskV2.ResMainTaskInfo 返回主线任务面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResMainTaskInfo ~= nil then
        csData = protobufMgr.DecodeTable.task.ResMainTaskInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回日常材料列表
---msgID: 102016
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResMaterialList C#数据结构
function networkRespond.OnResMaterialListMessageReceived(msgID)
    ---@type taskV2.ResMaterialList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102016 taskV2.ResMaterialList 返回日常材料列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResMaterialListMessage", 102016, "ResMaterialList", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回支线任务信息
---msgID: 102018
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResMainOtherTaskInfoPanel C#数据结构
function networkRespond.OnResMainOtherTaskInfoPanelMessageReceived(msgID)
    ---@type taskV2.ResMainOtherTaskInfoPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102018 taskV2.ResMainOtherTaskInfoPanel 返回支线任务信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResMainOtherTaskInfoPanel ~= nil then
        csData = protobufMgr.DecodeTable.task.ResMainOtherTaskInfoPanel(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---攻略
---msgID: 102020
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResTaskStrategy C#数据结构
function networkRespond.OnResTaskStrategyMessageReceived(msgID)
    ---@type taskV2.ResTaskStrategy
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102020 taskV2.ResTaskStrategy 攻略")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTaskStrategyMessage", 102020, "ResTaskStrategy", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回精英任务
---msgID: 102021
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResEliteTaskInfoPanel C#数据结构
function networkRespond.OnResEliteTaskInfoPanelMessageReceived(msgID)
    ---@type taskV2.ResEliteTaskInfoPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102021 taskV2.ResEliteTaskInfoPanel 返回精英任务")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResEliteTaskInfoPanel ~= nil then
        csData = protobufMgr.DecodeTable.task.ResEliteTaskInfoPanel(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回任务设置
---msgID: 102023
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.TaskSetting C#数据结构
function networkRespond.OnResTaskSettingMessageReceived(msgID)
    ---@type taskV2.TaskSetting
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102023 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102023 taskV2.TaskSetting 返回任务设置")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.TaskSetting ~= nil then
        csData = protobufMgr.DecodeTable.task.TaskSetting(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---精英任务购买价格回复
---msgID: 102026
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResEliteBuyPrice C#数据结构
function networkRespond.OnResEliteBuyPriceMessageReceived(msgID)
    ---@type taskV2.ResEliteBuyPrice
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102026 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102026 taskV2.ResEliteBuyPrice 精英任务购买价格回复")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResEliteBuyPrice ~= nil then
        csData = protobufMgr.DecodeTable.task.ResEliteBuyPrice(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回Boss任务
---msgID: 102027
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResBossTaskInfoPanel C#数据结构
function networkRespond.OnResBossTaskInfoPanelMessageReceived(msgID)
    ---@type taskV2.ResBossTaskInfoPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102027 taskV2.ResBossTaskInfoPanel 返回Boss任务")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResBossTaskInfoPanel ~= nil then
        csData = protobufMgr.DecodeTable.task.ResBossTaskInfoPanel(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回怪物悬赏任务
---msgID: 102028
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResMonsterRewardTaskInfoPanel C#数据结构
function networkRespond.OnResMonsterRewardTaskInfoPanelMessageReceived(msgID)
    ---@type taskV2.ResMonsterRewardTaskInfoPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102028 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102028 taskV2.ResMonsterRewardTaskInfoPanel 返回怪物悬赏任务")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.ResMonsterRewardTaskInfoPanel ~= nil then
        csData = protobufMgr.DecodeTable.task.ResMonsterRewardTaskInfoPanel(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---任务奖励提示
---msgID: 102029
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.TheTaskHasRewarded C#数据结构
function networkRespond.OnResTheTaskHasRewardedMessageReceived(msgID)
    ---@type taskV2.TheTaskHasRewarded
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102029 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102029 taskV2.TheTaskHasRewarded 任务奖励提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.task ~= nil and  protobufMgr.DecodeTable.task.TheTaskHasRewarded ~= nil then
        csData = protobufMgr.DecodeTable.task.TheTaskHasRewarded(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---现有全部
---msgID: 102030
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResMonsterTaskAllCompleteMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---全部日常任务信息
---msgID: 102033
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.ResAllNewDailyTaskInfo C#数据结构
function networkRespond.OnResAllNewDailyTaskInfoMessageReceived(msgID)
    ---@type taskV2.ResAllNewDailyTaskInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102033 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102033 taskV2.ResAllNewDailyTaskInfo 全部日常任务信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAllNewDailyTaskInfoMessage", 102033, "ResAllNewDailyTaskInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---灵魂任务信息
---msgID: 102036
---@param msgID LuaEnumNetDef 消息ID
---@return taskV2.SoulTaskInfo C#数据结构
function networkRespond.OnResSoulTaskStateMessageReceived(msgID)
    ---@type taskV2.SoulTaskInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 102036 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 102036 taskV2.SoulTaskInfo 灵魂任务信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSoulTaskStateMessage", 102036, "SoulTaskInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

