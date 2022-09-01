--[[本文件为工具自动生成,禁止手动修改]]
--rechargegiftbox.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---更新充值礼包信息
---msgID: 127002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateRechargeGiftBoxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 127002 rechargegiftboxV2.RechargeGiftBoxInfo 更新充值礼包信息")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargegiftboxV2.RechargeGiftBoxInfo", buffer)
    if protoAdjust.rechargegiftbox_adj ~= nil and protoAdjust.rechargegiftbox_adj.AdjustRechargeGiftBoxInfo ~= nil then
        protoAdjust.rechargegiftbox_adj.AdjustRechargeGiftBoxInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 127002
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送领取在线礼包返回消息
---msgID: 127004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReceiveOnlineGiftBoxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 127004 rechargegiftboxV2.RewardId 发送领取在线礼包返回消息")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargegiftboxV2.RewardId", buffer)
    if protoAdjust.rechargegiftbox_adj ~= nil and protoAdjust.rechargegiftbox_adj.AdjustRewardId ~= nil then
        protoAdjust.rechargegiftbox_adj.AdjustRewardId(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 127004
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送领取累充礼包返回消息
---msgID: 127006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReceiveTotalRechargeGiftBoxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 127006 rechargegiftboxV2.RewardId 发送领取累充礼包返回消息")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargegiftboxV2.RewardId", buffer)
    if protoAdjust.rechargegiftbox_adj ~= nil and protoAdjust.rechargegiftbox_adj.AdjustRewardId ~= nil then
        protoAdjust.rechargegiftbox_adj.AdjustRewardId(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 127006
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送领取连充礼包返回消息
---msgID: 127011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReceiveContinuousGiftBoxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 127011 rechargegiftboxV2.RewardId 发送领取连充礼包返回消息")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargegiftboxV2.RewardId", buffer)
    if protoAdjust.rechargegiftbox_adj ~= nil and protoAdjust.rechargegiftbox_adj.AdjustRewardId ~= nil then
        protoAdjust.rechargegiftbox_adj.AdjustRewardId(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 127011
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送领取每日累充礼包返回消息
---msgID: 127013
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReceiveDailyRechargeGiftBoxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 127013 rechargegiftboxV2.RewardId 发送领取每日累充礼包返回消息")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargegiftboxV2.RewardId", buffer)
    if protoAdjust.rechargegiftbox_adj ~= nil and protoAdjust.rechargegiftbox_adj.AdjustRewardId ~= nil then
        protoAdjust.rechargegiftbox_adj.AdjustRewardId(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 127013
    protobufMgr.mMsgDeserializedTblCache = res
end

---开服循环礼包信息
---msgID: 127014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleCycleGiftBoxInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 127014 rechargegiftboxV2.ResRoleCycleGiftBoxInfo 开服循环礼包信息")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargegiftboxV2.ResRoleCycleGiftBoxInfo", buffer)
    if protoAdjust.rechargegiftbox_adj ~= nil and protoAdjust.rechargegiftbox_adj.AdjustResRoleCycleGiftBoxInfo ~= nil then
        protoAdjust.rechargegiftbox_adj.AdjustResRoleCycleGiftBoxInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 127014
    protobufMgr.mMsgDeserializedTblCache = res
end

