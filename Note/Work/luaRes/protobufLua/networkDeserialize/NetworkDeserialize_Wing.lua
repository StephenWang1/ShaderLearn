--[[本文件为工具自动生成,禁止手动修改]]
--wing.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送光翼信息
---msgID: 18002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResWingInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 18002 wingV2.ResWingInfo 发送光翼信息")
        return nil
    end
    local res = protobufMgr.Deserialize("wingV2.ResWingInfo", buffer)
    if protoAdjust.wing_adj ~= nil and protoAdjust.wing_adj.AdjustResWingInfo ~= nil then
        protoAdjust.wing_adj.AdjustResWingInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 18002
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回升级光翼
---msgID: 18004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLevelUpWingMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 18004 wingV2.ResLevelUpWing 返回升级光翼")
        return nil
    end
    local res = protobufMgr.Deserialize("wingV2.ResLevelUpWing", buffer)
    if protoAdjust.wing_adj ~= nil and protoAdjust.wing_adj.AdjustResLevelUpWing ~= nil then
        protoAdjust.wing_adj.AdjustResLevelUpWing(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 18004
    protobufMgr.mMsgDeserializedTblCache = res
end

