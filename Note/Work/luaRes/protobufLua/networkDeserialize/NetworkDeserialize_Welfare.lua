--[[本文件为工具自动生成,禁止手动修改]]
--welfare.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送签到信息
---msgID: 27002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSignInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 27002 welfareV2.ResSignInfo 发送签到信息")
        return nil
    end
    local res = protobufMgr.Deserialize("welfareV2.ResSignInfo", buffer)
    if protoAdjust.welfare_adj ~= nil and protoAdjust.welfare_adj.AdjustResSignInfo ~= nil then
        protoAdjust.welfare_adj.AdjustResSignInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 27002
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回cdkey领奖结果
---msgID: 27005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCdkeyRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 27005 welfareV2.ResCdkeyReward 返回cdkey领奖结果")
        return nil
    end
    local res = protobufMgr.Deserialize("welfareV2.ResCdkeyReward", buffer)
    if protoAdjust.welfare_adj ~= nil and protoAdjust.welfare_adj.AdjustResCdkeyReward ~= nil then
        protoAdjust.welfare_adj.AdjustResCdkeyReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 27005
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送七天奖励信息
---msgID: 27008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSevenDaysInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 27008 welfareV2.ResSevenDaysInfo 发送七天奖励信息")
        return nil
    end
    local res = protobufMgr.Deserialize("welfareV2.ResSevenDaysInfo", buffer)
    if protoAdjust.welfare_adj ~= nil and protoAdjust.welfare_adj.AdjustResSevenDaysInfo ~= nil then
        protoAdjust.welfare_adj.AdjustResSevenDaysInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 27008
    protobufMgr.mMsgDeserializedTblCache = res
end

---在线奖励领取响应
---msgID: 27012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOnlineRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 27012 welfareV2.OnlineRewardMsg 在线奖励领取响应")
        return nil
    end
    local res = protobufMgr.Deserialize("welfareV2.OnlineRewardMsg", buffer)
    if protoAdjust.welfare_adj ~= nil and protoAdjust.welfare_adj.AdjustOnlineRewardMsg ~= nil then
        protoAdjust.welfare_adj.AdjustOnlineRewardMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 27012
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送奖励大厅信息
---msgID: 27015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetRewardHallMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 27015 welfareV2.RewardHall 发送奖励大厅信息")
        return nil
    end
    local res = protobufMgr.Deserialize("welfareV2.RewardHall", buffer)
    if protoAdjust.welfare_adj ~= nil and protoAdjust.welfare_adj.AdjustRewardHall ~= nil then
        protoAdjust.welfare_adj.AdjustRewardHall(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 27015
    protobufMgr.mMsgDeserializedTblCache = res
end

---定时奖励信息
---msgID: 27017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTimmngRewardInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 27017 welfareV2.TimingReward 定时奖励信息")
        return nil
    end
    local res = protobufMgr.Deserialize("welfareV2.TimingReward", buffer)
    if protoAdjust.welfare_adj ~= nil and protoAdjust.welfare_adj.AdjustTimingReward ~= nil then
        protoAdjust.welfare_adj.AdjustTimingReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 27017
    protobufMgr.mMsgDeserializedTblCache = res
end

---等级奖励信息
---msgID: 27020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLevelPacksInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 27020 welfareV2.LevelPacksInfo 等级奖励信息")
        return nil
    end
    local res = protobufMgr.Deserialize("welfareV2.LevelPacksInfo", buffer)
    if protoAdjust.welfare_adj ~= nil and protoAdjust.welfare_adj.AdjustLevelPacksInfo ~= nil then
        protoAdjust.welfare_adj.AdjustLevelPacksInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 27020
    protobufMgr.mMsgDeserializedTblCache = res
end

