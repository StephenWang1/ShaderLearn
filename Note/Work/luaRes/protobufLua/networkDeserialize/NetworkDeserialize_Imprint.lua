--[[本文件为工具自动生成,禁止手动修改]]
--imprint.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回印记信息
---msgID: 120002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResImprintInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 120002 imprintV2.ResImprintInfo 返回印记信息")
        return nil
    end
    local res = protobufMgr.Deserialize("imprintV2.ResImprintInfo", buffer)
    if protoAdjust.imprint_adj ~= nil and protoAdjust.imprint_adj.AdjustResImprintInfo ~= nil then
        protoAdjust.imprint_adj.AdjustResImprintInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 120002
    protobufMgr.mMsgDeserializedTblCache = res
end

---镶嵌成功返回
---msgID: 120005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPutOnImprintMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 120005 imprintV2.ResPutOnImprint 镶嵌成功返回")
        return nil
    end
    local res = protobufMgr.Deserialize("imprintV2.ResPutOnImprint", buffer)
    if protoAdjust.imprint_adj ~= nil and protoAdjust.imprint_adj.AdjustResPutOnImprint ~= nil then
        protoAdjust.imprint_adj.AdjustResPutOnImprint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 120005
    protobufMgr.mMsgDeserializedTblCache = res
end

---取下成功返回
---msgID: 120006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTakeOffImprintMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 120006 imprintV2.ResTakeOffImprint 取下成功返回")
        return nil
    end
    local res = protobufMgr.Deserialize("imprintV2.ResTakeOffImprint", buffer)
    if protoAdjust.imprint_adj ~= nil and protoAdjust.imprint_adj.AdjustResTakeOffImprint ~= nil then
        protoAdjust.imprint_adj.AdjustResTakeOffImprint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 120006
    protobufMgr.mMsgDeserializedTblCache = res
end

