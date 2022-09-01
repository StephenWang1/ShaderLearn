--[[本文件为工具自动生成,禁止手动修改]]
--active.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---玩家活跃度
---msgID: 108001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActiveDataMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 108001 activeV2.ActiveInfo 玩家活跃度")
        return nil
    end
    local res = protobufMgr.Deserialize("activeV2.ActiveInfo", buffer)
    if protoAdjust.active_adj ~= nil and protoAdjust.active_adj.AdjustActiveInfo ~= nil then
        protoAdjust.active_adj.AdjustActiveInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 108001
    protobufMgr.mMsgDeserializedTblCache = res
end

