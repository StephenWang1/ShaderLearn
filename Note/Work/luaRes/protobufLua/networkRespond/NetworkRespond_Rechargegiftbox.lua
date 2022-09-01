--[[本文件为工具自动生成,禁止手动修改]]
--rechargegiftbox.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---更新充值礼包信息
---msgID: 127002
---@param msgID LuaEnumNetDef 消息ID
---@return rechargegiftboxV2.RechargeGiftBoxInfo C#数据结构
function networkRespond.OnResUpdateRechargeGiftBoxMessageReceived(msgID)
    ---@type rechargegiftboxV2.RechargeGiftBoxInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 127002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 127002 rechargegiftboxV2.RechargeGiftBoxInfo 更新充值礼包信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.rechargegiftbox ~= nil and  protobufMgr.DecodeTable.rechargegiftbox.RechargeGiftBoxInfo ~= nil then
        csData = protobufMgr.DecodeTable.rechargegiftbox.RechargeGiftBoxInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送领取在线礼包返回消息
---msgID: 127004
---@param msgID LuaEnumNetDef 消息ID
---@return rechargegiftboxV2.RewardId C#数据结构
function networkRespond.OnResReceiveOnlineGiftBoxMessageReceived(msgID)
    ---@type rechargegiftboxV2.RewardId
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 127004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 127004 rechargegiftboxV2.RewardId 发送领取在线礼包返回消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResReceiveOnlineGiftBoxMessage", 127004, "RewardId", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送领取累充礼包返回消息
---msgID: 127006
---@param msgID LuaEnumNetDef 消息ID
---@return rechargegiftboxV2.RewardId C#数据结构
function networkRespond.OnResReceiveTotalRechargeGiftBoxMessageReceived(msgID)
    ---@type rechargegiftboxV2.RewardId
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 127006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 127006 rechargegiftboxV2.RewardId 发送领取累充礼包返回消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResReceiveTotalRechargeGiftBoxMessage", 127006, "RewardId", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送领取连充礼包返回消息
---msgID: 127011
---@param msgID LuaEnumNetDef 消息ID
---@return rechargegiftboxV2.RewardId C#数据结构
function networkRespond.OnResReceiveContinuousGiftBoxMessageReceived(msgID)
    ---@type rechargegiftboxV2.RewardId
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 127011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 127011 rechargegiftboxV2.RewardId 发送领取连充礼包返回消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.rechargegiftbox ~= nil and  protobufMgr.DecodeTable.rechargegiftbox.RewardId ~= nil then
        csData = protobufMgr.DecodeTable.rechargegiftbox.RewardId(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送领取每日累充礼包返回消息
---msgID: 127013
---@param msgID LuaEnumNetDef 消息ID
---@return rechargegiftboxV2.RewardId C#数据结构
function networkRespond.OnResReceiveDailyRechargeGiftBoxMessageReceived(msgID)
    ---@type rechargegiftboxV2.RewardId
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 127013 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 127013 rechargegiftboxV2.RewardId 发送领取每日累充礼包返回消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResReceiveDailyRechargeGiftBoxMessage", 127013, "RewardId", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---开服循环礼包信息
---msgID: 127014
---@param msgID LuaEnumNetDef 消息ID
---@return rechargegiftboxV2.ResRoleCycleGiftBoxInfo C#数据结构
function networkRespond.OnResRoleCycleGiftBoxInfoMessageReceived(msgID)
    ---@type rechargegiftboxV2.ResRoleCycleGiftBoxInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 127014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 127014 rechargegiftboxV2.ResRoleCycleGiftBoxInfo 开服循环礼包信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleCycleGiftBoxInfoMessage", 127014, "ResRoleCycleGiftBoxInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

