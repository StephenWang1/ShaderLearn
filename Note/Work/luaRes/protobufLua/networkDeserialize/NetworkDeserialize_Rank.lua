--[[本文件为工具自动生成,禁止手动修改]]
--rank.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---排行榜数据
---msgID: 26002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLookRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 26002 rankV2.ResLookRank 排行榜数据")
        return nil
    end
    local res = protobufMgr.Deserialize("rankV2.ResLookRank", buffer)
    if protoAdjust.rank_adj ~= nil and protoAdjust.rank_adj.AdjustResLookRank ~= nil then
        protoAdjust.rank_adj.AdjustResLookRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 26002
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送排行奖励信息
---msgID: 26004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRankRewardInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 26004 rankV2.ResRankRewardInfo 发送排行奖励信息")
        return nil
    end
    local res = protobufMgr.Deserialize("rankV2.ResRankRewardInfo", buffer)
    if protoAdjust.rank_adj ~= nil and protoAdjust.rank_adj.AdjustResRankRewardInfo ~= nil then
        protoAdjust.rank_adj.AdjustResRankRewardInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 26004
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送未领取奖励的排行列表
---msgID: 26006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnRewardRankTypesMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 26006 rankV2.ResUnRewardRankTypes 发送未领取奖励的排行列表")
        return nil
    end
    local res = protobufMgr.Deserialize("rankV2.ResUnRewardRankTypes", buffer)
    if protoAdjust.rank_adj ~= nil and protoAdjust.rank_adj.AdjustResUnRewardRankTypes ~= nil then
        protoAdjust.rank_adj.AdjustResUnRewardRankTypes(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 26006
    protobufMgr.mMsgDeserializedTblCache = res
end

---战损榜详情响应
---msgID: 26008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBattleDamageRankDatailMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 26008 rankV2.DamageItemRankInfo 战损榜详情响应")
        return nil
    end
    local res = protobufMgr.Deserialize("rankV2.DamageItemRankInfo", buffer)
    if protoAdjust.rank_adj ~= nil and protoAdjust.rank_adj.AdjustDamageItemRankInfo ~= nil then
        protoAdjust.rank_adj.AdjustDamageItemRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 26008
    protobufMgr.mMsgDeserializedTblCache = res
end

---排行榜数据
---msgID: 26010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareLookRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 26010 rankV2.ResLookRank 排行榜数据")
        return nil
    end
    local res = protobufMgr.Deserialize("rankV2.ResLookRank", buffer)
    if protoAdjust.rank_adj ~= nil and protoAdjust.rank_adj.AdjustResLookRank ~= nil then
        protoAdjust.rank_adj.AdjustResLookRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 26010
    protobufMgr.mMsgDeserializedTblCache = res
end

