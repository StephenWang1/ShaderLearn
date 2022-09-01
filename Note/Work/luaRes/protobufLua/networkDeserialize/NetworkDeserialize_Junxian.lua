--[[本文件为工具自动生成,禁止手动修改]]
--junxian.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---升级向周围玩家发送消息
---msgID: 59001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoundJunXianUpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 59001 junxianV2.ResRoundJunXianUp 升级向周围玩家发送消息")
        return nil
    end
    local res = protobufMgr.Deserialize("junxianV2.ResRoundJunXianUp", buffer)
    if protoAdjust.junxian_adj ~= nil and protoAdjust.junxian_adj.AdjustResRoundJunXianUp ~= nil then
        protoAdjust.junxian_adj.AdjustResRoundJunXianUp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 59001
    protobufMgr.mMsgDeserializedTblCache = res
end

---军衔当前等级响应
---msgID: 59007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResJunXianLevelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 59007 junxianV2.ResJunXianLevel 军衔当前等级响应")
        return nil
    end
    local res = protobufMgr.Deserialize("junxianV2.ResJunXianLevel", buffer)
    if protoAdjust.junxian_adj ~= nil and protoAdjust.junxian_adj.AdjustResJunXianLevel ~= nil then
        protoAdjust.junxian_adj.AdjustResJunXianLevel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 59007
    protobufMgr.mMsgDeserializedTblCache = res
end

---军衔升级响应
---msgID: 59009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResJunXianUpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 59009 junxianV2.ResJunXianUp 军衔升级响应")
        return nil
    end
    local res = protobufMgr.Deserialize("junxianV2.ResJunXianUp", buffer)
    if protoAdjust.junxian_adj ~= nil and protoAdjust.junxian_adj.AdjustResJunXianUp ~= nil then
        protoAdjust.junxian_adj.AdjustResJunXianUp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 59009
    protobufMgr.mMsgDeserializedTblCache = res
end

