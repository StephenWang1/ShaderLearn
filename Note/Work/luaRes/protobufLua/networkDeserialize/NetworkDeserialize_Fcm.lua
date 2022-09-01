--[[本文件为工具自动生成,禁止手动修改]]
--fcm.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---认证状态
---msgID: 34001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAuthorityStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 34001 fcmV2.ResAuthorityState 认证状态")
        return nil
    end
    local res = protobufMgr.Deserialize("fcmV2.ResAuthorityState", buffer)
    if protoAdjust.fcm_adj ~= nil and protoAdjust.fcm_adj.AdjustResAuthorityState ~= nil then
        protoAdjust.fcm_adj.AdjustResAuthorityState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 34001
    protobufMgr.mMsgDeserializedTblCache = res
end

---防沉迷状态 1-5对应小时
---msgID: 34003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFcmStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 34003 fcmV2.ResFcmState 防沉迷状态 1-5对应小时")
        return nil
    end
    local res = protobufMgr.Deserialize("fcmV2.ResFcmState", buffer)
    if protoAdjust.fcm_adj ~= nil and protoAdjust.fcm_adj.AdjustResFcmState ~= nil then
        protoAdjust.fcm_adj.AdjustResFcmState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 34003
    protobufMgr.mMsgDeserializedTblCache = res
end

