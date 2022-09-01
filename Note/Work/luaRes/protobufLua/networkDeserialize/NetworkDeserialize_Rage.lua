--[[本文件为工具自动生成,禁止手动修改]]
--rage.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---狂暴之力弹窗
---msgID: 130002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRageTipMessageReceived(msgID, buffer)
end

---狂暴之力状态响应
---msgID: 130005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRageStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 130005 rageV2.RageState 狂暴之力状态响应")
        return nil
    end
    local res = protobufMgr.Deserialize("rageV2.RageState", buffer)
    if protoAdjust.rage_adj ~= nil and protoAdjust.rage_adj.AdjustRageState ~= nil then
        protoAdjust.rage_adj.AdjustRageState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 130005
    protobufMgr.mMsgDeserializedTblCache = res
end

