--[[本文件为工具自动生成,禁止手动修改]]
--count.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回数量的列表
---msgID: 21001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCountDataMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 21001 countV2.ResCountData 返回数量的列表")
        return nil
    end
    local res = protobufMgr.Deserialize("countV2.ResCountData", buffer)
    if protoAdjust.count_adj ~= nil and protoAdjust.count_adj.AdjustResCountData ~= nil then
        protoAdjust.count_adj.AdjustResCountData(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 21001
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回数量变化的消息
---msgID: 21002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCountChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 21002 countV2.ResCountChange 返回数量变化的消息")
        return nil
    end
    local res = protobufMgr.Deserialize("countV2.ResCountChange", buffer)
    if protoAdjust.count_adj ~= nil and protoAdjust.count_adj.AdjustResCountChange ~= nil then
        protoAdjust.count_adj.AdjustResCountChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 21002
    protobufMgr.mMsgDeserializedTblCache = res
end

---道具共享使用上限(已使用次数)
---msgID: 21004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCountShareUsedLimitMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 21004 countV2.ResCountShareUsed 道具共享使用上限(已使用次数)")
        return nil
    end
    local res = protobufMgr.Deserialize("countV2.ResCountShareUsed", buffer)
    if protoAdjust.count_adj ~= nil and protoAdjust.count_adj.AdjustResCountShareUsed ~= nil then
        protoAdjust.count_adj.AdjustResCountShareUsed(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 21004
    protobufMgr.mMsgDeserializedTblCache = res
end

