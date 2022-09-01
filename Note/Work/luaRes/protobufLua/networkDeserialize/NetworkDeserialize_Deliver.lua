--[[本文件为工具自动生成,禁止手动修改]]
--deliver.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---直接传送响应
---msgID: 72006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDirectlyTransferMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 72006 deliverV2.DirectlyTransferRes 直接传送响应")
        return nil
    end
    local res = protobufMgr.Deserialize("deliverV2.DirectlyTransferRes", buffer)
    if protoAdjust.deliver_adj ~= nil and protoAdjust.deliver_adj.AdjustDirectlyTransferRes ~= nil then
        protoAdjust.deliver_adj.AdjustDirectlyTransferRes(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 72006
    protobufMgr.mMsgDeserializedTblCache = res
end

