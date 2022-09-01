--[[本文件为工具自动生成,禁止手动修改]]
--official.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送官职界面信息
---msgID: 56001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOfficialInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 56001 officialV2.ResOfficialInfo 发送官职界面信息")
        return nil
    end
    local res = protobufMgr.Deserialize("officialV2.ResOfficialInfo", buffer)
    if protoAdjust.official_adj ~= nil and protoAdjust.official_adj.AdjustResOfficialInfo ~= nil then
        protoAdjust.official_adj.AdjustResOfficialInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 56001
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回官职晋升结果
---msgID: 56003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOfficialUpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 56003 officialV2.ResOfficialUp 返回官职晋升结果")
        return nil
    end
    local res = protobufMgr.Deserialize("officialV2.ResOfficialUp", buffer)
    if protoAdjust.official_adj ~= nil and protoAdjust.official_adj.AdjustResOfficialUp ~= nil then
        protoAdjust.official_adj.AdjustResOfficialUp(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 56003
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回领取日活奖励结果
---msgID: 56005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDrawDailyActiveRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 56005 officialV2.ResDrawDailyActiveReward 返回领取日活奖励结果")
        return nil
    end
    local res = protobufMgr.Deserialize("officialV2.ResDrawDailyActiveReward", buffer)
    if protoAdjust.official_adj ~= nil and protoAdjust.official_adj.AdjustResDrawDailyActiveReward ~= nil then
        protoAdjust.official_adj.AdjustResDrawDailyActiveReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 56005
    protobufMgr.mMsgDeserializedTblCache = res
end

---同步官职和虎符信息,上线和变化都是这一条
---msgID: 56011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOfficialInfoV2MessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 56011 officialV2.ResOfficialInfoV2 同步官职和虎符信息,上线和变化都是这一条")
        return nil
    end
    local res = protobufMgr.Deserialize("officialV2.ResOfficialInfoV2", buffer)
    if protoAdjust.official_adj ~= nil and protoAdjust.official_adj.AdjustResOfficialInfoV2 ~= nil then
        protoAdjust.official_adj.AdjustResOfficialInfoV2(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 56011
    protobufMgr.mMsgDeserializedTblCache = res
end

