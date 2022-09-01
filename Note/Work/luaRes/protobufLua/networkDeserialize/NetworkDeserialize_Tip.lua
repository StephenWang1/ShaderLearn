--[[本文件为工具自动生成,禁止手动修改]]
--tip.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---提示消息
---msgID: 7001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPromptMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 7001 tipV2.PromptMsg 提示消息")
        return nil
    end
    local res = protobufMgr.Deserialize("tipV2.PromptMsg", buffer)
    if protoAdjust.tip_adj ~= nil and protoAdjust.tip_adj.AdjustPromptMsg ~= nil then
        protoAdjust.tip_adj.AdjustPromptMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 7001
    protobufMgr.mMsgDeserializedTblCache = res
end

---提示气泡
---msgID: 7002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUIBubbleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 7002 tipV2.ResUIBubbleMsg 提示气泡")
        return nil
    end
    local res = protobufMgr.Deserialize("tipV2.ResUIBubbleMsg", buffer)
    if protoAdjust.tip_adj ~= nil and protoAdjust.tip_adj.AdjustResUIBubbleMsg ~= nil then
        protoAdjust.tip_adj.AdjustResUIBubbleMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 7002
    protobufMgr.mMsgDeserializedTblCache = res
end

