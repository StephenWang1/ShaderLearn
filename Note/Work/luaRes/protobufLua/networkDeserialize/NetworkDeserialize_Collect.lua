--[[本文件为工具自动生成,禁止手动修改]]
--collect.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---藏品上架响应
---msgID: 111102
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPutCollectionItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111102 collect.PutCollectionItemMsg 藏品上架响应")
        return nil
    end
    local res = protobufMgr.Deserialize("collect.PutCollectionItemMsg", buffer)
    if protoAdjust.collect_adj ~= nil and protoAdjust.collect_adj.AdjustPutCollectionItemMsg ~= nil then
        protoAdjust.collect_adj.AdjustPutCollectionItemMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111102
    protobufMgr.mMsgDeserializedTblCache = res
end

---藏品下架响应
---msgID: 111104
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRemoveCollectionItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111104 collect.RemoveCollectionItemMsg 藏品下架响应")
        return nil
    end
    local res = protobufMgr.Deserialize("collect.RemoveCollectionItemMsg", buffer)
    if protoAdjust.collect_adj ~= nil and protoAdjust.collect_adj.AdjustRemoveCollectionItemMsg ~= nil then
        protoAdjust.collect_adj.AdjustRemoveCollectionItemMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111104
    protobufMgr.mMsgDeserializedTblCache = res
end

---藏品交换位置响应
---msgID: 111106
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSwapCollectionItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111106 collect.CabinetInfo 藏品交换位置响应")
        return nil
    end
    local res = protobufMgr.Deserialize("collect.CabinetInfo", buffer)
    if protoAdjust.collect_adj ~= nil and protoAdjust.collect_adj.AdjustCabinetInfo ~= nil then
        protoAdjust.collect_adj.AdjustCabinetInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111106
    protobufMgr.mMsgDeserializedTblCache = res
end

---藏品回收响应
---msgID: 111108
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCallbackCollectionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111108 collect.CallbackCollectionMsg 藏品回收响应")
        return nil
    end
    local res = protobufMgr.Deserialize("collect.CallbackCollectionMsg", buffer)
    if protoAdjust.collect_adj ~= nil and protoAdjust.collect_adj.AdjustCallbackCollectionMsg ~= nil then
        protoAdjust.collect_adj.AdjustCallbackCollectionMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111108
    protobufMgr.mMsgDeserializedTblCache = res
end

---收藏柜信息
---msgID: 111109
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCabinetMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 111109 collect.CabinetInfo 收藏柜信息")
        return nil
    end
    local res = protobufMgr.Deserialize("collect.CabinetInfo", buffer)
    if protoAdjust.collect_adj ~= nil and protoAdjust.collect_adj.AdjustCabinetInfo ~= nil then
        protoAdjust.collect_adj.AdjustCabinetInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 111109
    protobufMgr.mMsgDeserializedTblCache = res
end

