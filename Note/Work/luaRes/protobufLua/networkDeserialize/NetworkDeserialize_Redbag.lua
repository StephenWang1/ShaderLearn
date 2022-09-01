--[[本文件为工具自动生成,禁止手动修改]]
--redbag.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---红包信息
---msgID: 109002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRedBagInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 109002 redbagV2.RedBagInfo 红包信息")
        return nil
    end
    local res = protobufMgr.Deserialize("redbagV2.RedBagInfo", buffer)
    if protoAdjust.redbag_adj ~= nil and protoAdjust.redbag_adj.AdjustRedBagInfo ~= nil then
        protoAdjust.redbag_adj.AdjustRedBagInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 109002
    protobufMgr.mMsgDeserializedTblCache = res
end

---第一次红包信息
---msgID: 109006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFirstRedBagMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 109006 redbagV2.RedBagInfo 第一次红包信息")
        return nil
    end
    local res = protobufMgr.Deserialize("redbagV2.RedBagInfo", buffer)
    if protoAdjust.redbag_adj ~= nil and protoAdjust.redbag_adj.AdjustRedBagInfo ~= nil then
        protoAdjust.redbag_adj.AdjustRedBagInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 109006
    protobufMgr.mMsgDeserializedTblCache = res
end

