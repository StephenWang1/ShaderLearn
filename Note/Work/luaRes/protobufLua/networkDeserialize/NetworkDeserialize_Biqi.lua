--[[本文件为工具自动生成,禁止手动修改]]
--biqi.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送积分排行信息
---msgID: 79004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResScoreRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 79004 biqiV2.ResScoreRank 发送积分排行信息")
        return nil
    end
    local res = protobufMgr.Deserialize("biqiV2.ResScoreRank", buffer)
    if protoAdjust.biqi_adj ~= nil and protoAdjust.biqi_adj.AdjustResScoreRank ~= nil then
        protoAdjust.biqi_adj.AdjustResScoreRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 79004
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送逆袭buff信息
---msgID: 79005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNixiBuffInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 79005 biqiV2.ResNixiBuffInfo 发送逆袭buff信息")
        return nil
    end
    local res = protobufMgr.Deserialize("biqiV2.ResNixiBuffInfo", buffer)
    if protoAdjust.biqi_adj ~= nil and protoAdjust.biqi_adj.AdjustResNixiBuffInfo ~= nil then
        protoAdjust.biqi_adj.AdjustResNixiBuffInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 79005
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送积分领奖信息
---msgID: 79006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResScoreRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 79006 biqiV2.ResScoreReward 发送积分领奖信息")
        return nil
    end
    local res = protobufMgr.Deserialize("biqiV2.ResScoreReward", buffer)
    if protoAdjust.biqi_adj ~= nil and protoAdjust.biqi_adj.AdjustResScoreReward ~= nil then
        protoAdjust.biqi_adj.AdjustResScoreReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 79006
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送玩家积分信息
---msgID: 79007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleScoreMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 79007 biqiV2.ResRoleScore 发送玩家积分信息")
        return nil
    end
    local res = protobufMgr.Deserialize("biqiV2.ResRoleScore", buffer)
    if protoAdjust.biqi_adj ~= nil and protoAdjust.biqi_adj.AdjustResRoleScore ~= nil then
        protoAdjust.biqi_adj.AdjustResRoleScore(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 79007
    protobufMgr.mMsgDeserializedTblCache = res
end

---提示即将切换阵营
---msgID: 79010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResChangCampTipMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 79010 biqiV2.ResChangCampTip 提示即将切换阵营")
        return nil
    end
    local res = protobufMgr.Deserialize("biqiV2.ResChangCampTip", buffer)
    if protoAdjust.biqi_adj ~= nil and protoAdjust.biqi_adj.AdjustResChangCampTip ~= nil then
        protoAdjust.biqi_adj.AdjustResChangCampTip(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 79010
    protobufMgr.mMsgDeserializedTblCache = res
end

