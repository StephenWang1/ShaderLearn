--[[本文件为工具自动生成,禁止手动修改]]
--servantcultivate.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---灵兽修炼信息
---msgID: 151002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantCultivateInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 151002 servantcultivateV2.resCultivateInfo 灵兽修炼信息")
        return nil
    end
    local res = protobufMgr.Deserialize("servantcultivateV2.resCultivateInfo", buffer)
    if protoAdjust.servantcultivate_adj ~= nil and protoAdjust.servantcultivate_adj.AdjustresCultivateInfo ~= nil then
        protoAdjust.servantcultivate_adj.AdjustresCultivateInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 151002
    protobufMgr.mMsgDeserializedTblCache = res
end

---灵兽修炼小红点
---msgID: 151006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantCultivateRedMessageReceived(msgID, buffer)
end

---灵兽修炼被攻击
---msgID: 151008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServantCultivateBeAttackMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 151008 servantcultivateV2.cultivateRedInfo 灵兽修炼被攻击")
        return nil
    end
    local res = protobufMgr.Deserialize("servantcultivateV2.cultivateRedInfo", buffer)
    if protoAdjust.servantcultivate_adj ~= nil and protoAdjust.servantcultivate_adj.AdjustcultivateRedInfo ~= nil then
        protoAdjust.servantcultivate_adj.AdjustcultivateRedInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 151008
    protobufMgr.mMsgDeserializedTblCache = res
end

