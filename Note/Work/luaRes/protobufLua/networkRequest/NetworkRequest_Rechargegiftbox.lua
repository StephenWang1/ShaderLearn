--[[本文件为工具自动生成,禁止手动修改]]
--rechargegiftbox.xml

--region ID:127001 请求充值礼包信息
---请求充值礼包信息
---msgID: 127001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRechargeGiftBox()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRechargeGiftBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRechargeGiftBoxMessage](LuaEnumNetDef.ReqRechargeGiftBoxMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRechargeGiftBoxMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:127003 请求领取在线礼包
---请求领取在线礼包
---msgID: 127003
---@param id number 选填参数 配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveOnlineGiftBox(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("rechargegiftboxV2.RewardId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveOnlineGiftBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveOnlineGiftBoxMessage](LuaEnumNetDef.ReqReceiveOnlineGiftBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveOnlineGiftBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveOnlineGiftBoxMessage", 127003, "RewardId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:127005 请求领取累充礼包
---请求领取累充礼包
---msgID: 127005
---@param id number 选填参数 配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveTotalRechargeGiftBox(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("rechargegiftboxV2.RewardId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveTotalRechargeGiftBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveTotalRechargeGiftBoxMessage](LuaEnumNetDef.ReqReceiveTotalRechargeGiftBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveTotalRechargeGiftBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveTotalRechargeGiftBoxMessage", 127005, "RewardId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:127007 请求分享
---请求分享
---msgID: 127007
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShare()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareMessage](LuaEnumNetDef.ReqShareMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:127008 请求领取分享礼包
---请求领取分享礼包
---msgID: 127008
---@param id number 选填参数 配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveShareGiftBox(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("rechargegiftboxV2.RewardId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveShareGiftBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveShareGiftBoxMessage](LuaEnumNetDef.ReqReceiveShareGiftBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveShareGiftBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveShareGiftBoxMessage", 127008, "RewardId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:127010 请求领取连充礼包
---请求领取连充礼包
---msgID: 127010
---@param id number 选填参数 配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveContinuousGiftBox(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("rechargegiftboxV2.RewardId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveContinuousGiftBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveContinuousGiftBoxMessage](LuaEnumNetDef.ReqReceiveContinuousGiftBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveContinuousGiftBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveContinuousGiftBoxMessage", 127010, "RewardId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:127012 请求领取每日累充礼包
---请求领取每日累充礼包
---msgID: 127012
---@param id number 选填参数 配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveDailyRechargeGiftBox(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("rechargegiftboxV2.RewardId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveDailyRechargeGiftBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveDailyRechargeGiftBoxMessage](LuaEnumNetDef.ReqReceiveDailyRechargeGiftBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveDailyRechargeGiftBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveDailyRechargeGiftBoxMessage", 127012, "RewardId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:127015 开服循环礼包请求
---开服循环礼包请求
---msgID: 127015
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRoleCycleGiftBoxInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRoleCycleGiftBoxInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRoleCycleGiftBoxInfoMessage](LuaEnumNetDef.ReqRoleCycleGiftBoxInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRoleCycleGiftBoxInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

