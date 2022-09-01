--[[本文件为工具自动生成,禁止手动修改]]
--merit.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回行会之争
---msgID: 122002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionBattleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 122002 meritV2.ResUnionBattle 返回行会之争")
        return nil
    end
    local res = protobufMgr.Deserialize("meritV2.ResUnionBattle", buffer)
    if protoAdjust.merit_adj ~= nil and protoAdjust.merit_adj.AdjustResUnionBattle ~= nil then
        protoAdjust.merit_adj.AdjustResUnionBattle(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 122002
    protobufMgr.mMsgDeserializedTblCache = res
end

---霸业活动红点
---msgID: 122003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMeritRedPointMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 122003 meritV2.ResMeritRedPoint 霸业活动红点")
        return nil
    end
    local res = protobufMgr.Deserialize("meritV2.ResMeritRedPoint", buffer)
    if protoAdjust.merit_adj ~= nil and protoAdjust.merit_adj.AdjustResMeritRedPoint ~= nil then
        protoAdjust.merit_adj.AdjustResMeritRedPoint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 122003
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回领袖之路
---msgID: 122004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLeaderGloryMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 122004 meritV2.ResLeaderGlory 返回领袖之路")
        return nil
    end
    local res = protobufMgr.Deserialize("meritV2.ResLeaderGlory", buffer)
    if protoAdjust.merit_adj ~= nil and protoAdjust.merit_adj.AdjustResLeaderGlory ~= nil then
        protoAdjust.merit_adj.AdjustResLeaderGlory(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 122004
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回建功立业
---msgID: 122005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionAchievementMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 122005 meritV2.ResUnionAchievement 返回建功立业")
        return nil
    end
    local res = protobufMgr.Deserialize("meritV2.ResUnionAchievement", buffer)
    if protoAdjust.merit_adj ~= nil and protoAdjust.merit_adj.AdjustResUnionAchievement ~= nil then
        protoAdjust.merit_adj.AdjustResUnionAchievement(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 122005
    protobufMgr.mMsgDeserializedTblCache = res
end

---领奖返回
---msgID: 122009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReturnRewardStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 122009 meritV2.ResReturnRewardState 领奖返回")
        return nil
    end
    local res = protobufMgr.Deserialize("meritV2.ResReturnRewardState", buffer)
    if protoAdjust.merit_adj ~= nil and protoAdjust.merit_adj.AdjustResReturnRewardState ~= nil then
        protoAdjust.merit_adj.AdjustResReturnRewardState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 122009
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回领袖之路小面板
---msgID: 122011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPositionInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 122011 meritV2.ResPositionInfo 返回领袖之路小面板")
        return nil
    end
    local res = protobufMgr.Deserialize("meritV2.ResPositionInfo", buffer)
    if protoAdjust.merit_adj ~= nil and protoAdjust.merit_adj.AdjustResPositionInfo ~= nil then
        protoAdjust.merit_adj.AdjustResPositionInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 122011
    protobufMgr.mMsgDeserializedTblCache = res
end

