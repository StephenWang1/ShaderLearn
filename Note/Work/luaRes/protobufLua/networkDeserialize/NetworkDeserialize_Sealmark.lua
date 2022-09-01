--[[本文件为工具自动生成,禁止手动修改]]
--sealmark.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回当前封号等级
---msgID: 85002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSealMarkInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 85002 sealmarkV2.ResSealMarkInfo 返回当前封号等级")
        return nil
    end
    local res = protobufMgr.Deserialize("sealmarkV2.ResSealMarkInfo", buffer)
    if protoAdjust.sealmark_adj ~= nil and protoAdjust.sealmark_adj.AdjustResSealMarkInfo ~= nil then
        protoAdjust.sealmark_adj.AdjustResSealMarkInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 85002
    protobufMgr.mMsgDeserializedTblCache = res
end

