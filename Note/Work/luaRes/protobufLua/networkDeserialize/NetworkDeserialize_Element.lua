--[[本文件为工具自动生成,禁止手动修改]]
--element.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送元素套装信息
---msgID: 110002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResElementSuitInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 110002 elementV2.ResElementSuitInfo 发送元素套装信息")
        return nil
    end
    local res = protobufMgr.Deserialize("elementV2.ResElementSuitInfo", buffer)
    if protoAdjust.element_adj ~= nil and protoAdjust.element_adj.AdjustResElementSuitInfo ~= nil then
        protoAdjust.element_adj.AdjustResElementSuitInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 110002
    protobufMgr.mMsgDeserializedTblCache = res
end

