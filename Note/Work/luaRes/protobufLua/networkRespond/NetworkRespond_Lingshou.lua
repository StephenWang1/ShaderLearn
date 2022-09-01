--[[本文件为工具自动生成,禁止手动修改]]
--lingshou.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---请求灵兽任务面板
---msgID: 48018
---@param msgID LuaEnumNetDef 消息ID
---@return lingshouV2.ResLingShouTaskPanel C#数据结构
function networkRespond.OnResLingShouTaskPanelMessageReceived(msgID)
    ---@type lingshouV2.ResLingShouTaskPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 48018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 48018 lingshouV2.ResLingShouTaskPanel 请求灵兽任务面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLingShouTaskPanelMessage", 48018, "ResLingShouTaskPanel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---更新灵兽任务信息
---msgID: 48019
---@param msgID LuaEnumNetDef 消息ID
---@return lingshouV2.ResLingShouTaskInfo C#数据结构
function networkRespond.OnResLingShouTaskInfoMessageReceived(msgID)
    ---@type lingshouV2.ResLingShouTaskInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 48019 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 48019 lingshouV2.ResLingShouTaskInfo 更新灵兽任务信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLingShouTaskInfoMessage", 48019, "ResLingShouTaskInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---更新灵兽章节信息
---msgID: 48020
---@param msgID LuaEnumNetDef 消息ID
---@return lingshouV2.ResLinshouSectionInfo C#数据结构
function networkRespond.OnResLinshouSectionInfoMessageReceived(msgID)
    ---@type lingshouV2.ResLinshouSectionInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 48020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 48020 lingshouV2.ResLinshouSectionInfo 更新灵兽章节信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLinshouSectionInfoMessage", 48020, "ResLinshouSectionInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---解锁灵兽
---msgID: 48025
---@param msgID LuaEnumNetDef 消息ID
---@return lingshouV2.UnlockSecEffect C#数据结构
function networkRespond.OnResUnlockEffectMessageReceived(msgID)
    ---@type lingshouV2.UnlockSecEffect
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 48025 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 48025 lingshouV2.UnlockSecEffect 解锁灵兽")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUnlockEffectMessage", 48025, "UnlockSecEffect", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

