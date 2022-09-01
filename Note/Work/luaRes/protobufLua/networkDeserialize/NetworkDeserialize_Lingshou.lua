--[[本文件为工具自动生成,禁止手动修改]]
--lingshou.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---请求灵兽任务面板
---msgID: 48018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLingShouTaskPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 48018 lingshouV2.ResLingShouTaskPanel 请求灵兽任务面板")
        return nil
    end
    local res = protobufMgr.Deserialize("lingshouV2.ResLingShouTaskPanel", buffer)
    if protoAdjust.lingshou_adj ~= nil and protoAdjust.lingshou_adj.AdjustResLingShouTaskPanel ~= nil then
        protoAdjust.lingshou_adj.AdjustResLingShouTaskPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 48018
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新灵兽任务信息
---msgID: 48019
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLingShouTaskInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 48019 lingshouV2.ResLingShouTaskInfo 更新灵兽任务信息")
        return nil
    end
    local res = protobufMgr.Deserialize("lingshouV2.ResLingShouTaskInfo", buffer)
    if protoAdjust.lingshou_adj ~= nil and protoAdjust.lingshou_adj.AdjustResLingShouTaskInfo ~= nil then
        protoAdjust.lingshou_adj.AdjustResLingShouTaskInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 48019
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新灵兽章节信息
---msgID: 48020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLinshouSectionInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 48020 lingshouV2.ResLinshouSectionInfo 更新灵兽章节信息")
        return nil
    end
    local res = protobufMgr.Deserialize("lingshouV2.ResLinshouSectionInfo", buffer)
    if protoAdjust.lingshou_adj ~= nil and protoAdjust.lingshou_adj.AdjustResLinshouSectionInfo ~= nil then
        protoAdjust.lingshou_adj.AdjustResLinshouSectionInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 48020
    protobufMgr.mMsgDeserializedTblCache = res
end

---解锁灵兽
---msgID: 48025
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnlockEffectMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 48025 lingshouV2.UnlockSecEffect 解锁灵兽")
        return nil
    end
    local res = protobufMgr.Deserialize("lingshouV2.UnlockSecEffect", buffer)
    if protoAdjust.lingshou_adj ~= nil and protoAdjust.lingshou_adj.AdjustUnlockSecEffect ~= nil then
        protoAdjust.lingshou_adj.AdjustUnlockSecEffect(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 48025
    protobufMgr.mMsgDeserializedTblCache = res
end

