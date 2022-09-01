--[[本文件为工具自动生成,禁止手动修改]]
--sharesocialcontact.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回客户端通用消息
---msgID: 1500012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareCommonMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1500012 playV2.CommonInfo 返回客户端通用消息")
        return nil
    end
    local res = protobufMgr.Deserialize("playV2.CommonInfo", buffer)
    if protoAdjust.play_adj ~= nil and protoAdjust.play_adj.AdjustCommonInfo ~= nil then
        protoAdjust.play_adj.AdjustCommonInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1500012
    protobufMgr.mMsgDeserializedTblCache = res
end

