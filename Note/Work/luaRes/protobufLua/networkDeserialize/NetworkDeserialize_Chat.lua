--[[本文件为工具自动生成,禁止手动修改]]
--chat.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---聊天结果
---msgID: 6004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResChatMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 6004 chatV2.ResChat 聊天结果")
        return nil
    end
    local res = protobufMgr.Deserialize("chatV2.ResChat", buffer)
    if protoAdjust.chat_adj ~= nil and protoAdjust.chat_adj.AdjustResChat ~= nil then
        protoAdjust.chat_adj.AdjustResChat(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 6004
    protobufMgr.mMsgDeserializedTblCache = res
end

---公告消息
---msgID: 6008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAnnounceMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 6008 chatV2.ResAnnounce 公告消息")
        return nil
    end
    local res = protobufMgr.Deserialize("chatV2.ResAnnounce", buffer)
    if protoAdjust.chat_adj ~= nil and protoAdjust.chat_adj.AdjustResAnnounce ~= nil then
        protoAdjust.chat_adj.AdjustResAnnounce(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 6008
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回塔罗神庙公告历史记录
---msgID: 6014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResHuntAnnounceMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 6014 chatV2.ResHuntAnnounceHistory 返回塔罗神庙公告历史记录")
        return nil
    end
    local res = protobufMgr.Deserialize("chatV2.ResHuntAnnounceHistory", buffer)
    if protoAdjust.chat_adj ~= nil and protoAdjust.chat_adj.AdjustResHuntAnnounceHistory ~= nil then
        protoAdjust.chat_adj.AdjustResHuntAnnounceHistory(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 6014
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回塔罗神庙公告更新
---msgID: 6015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResHuntAnnounceUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 6015 chatV2.ResHuntAnnounceUpdate 返回塔罗神庙公告更新")
        return nil
    end
    local res = protobufMgr.Deserialize("chatV2.ResHuntAnnounceUpdate", buffer)
    if protoAdjust.chat_adj ~= nil and protoAdjust.chat_adj.AdjustResHuntAnnounceUpdate ~= nil then
        protoAdjust.chat_adj.AdjustResHuntAnnounceUpdate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 6015
    protobufMgr.mMsgDeserializedTblCache = res
end

