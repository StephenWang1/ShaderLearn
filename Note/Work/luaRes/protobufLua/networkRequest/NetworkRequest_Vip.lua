--[[本文件为工具自动生成,禁止手动修改]]
--vip.xml

--region ID:28004 请求领取vip礼包
---请求领取vip礼包
---msgID: 28004
---@param vipLevel number 选填参数 vip等级
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyVipReward(vipLevel)
    local reqTable = {}
    if vipLevel ~= nil then
        reqTable.vipLevel = vipLevel
    end
    local reqMsgData = protobufMgr.Serialize("vipV2.ReqBuyVipReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyVipRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyVipRewardMessage](LuaEnumNetDef.ReqBuyVipRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyVipRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyVipRewardMessage", 28004, "ReqBuyVipReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:28009 请求vip数据
---请求vip数据
---msgID: 28009
---@return boolean 网络请求是否成功发送
function networkRequest.ReqVipInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqVipInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqVipInfoMessage](LuaEnumNetDef.ReqVipInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqVipInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:28010 请求购买月卡
---请求购买月卡
---msgID: 28010
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyMonthCard(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("vipV2.CardId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyMonthCardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyMonthCardMessage](LuaEnumNetDef.ReqBuyMonthCardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyMonthCardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyMonthCardMessage", 28010, "CardId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:28011 请求商会界面
---请求商会界面
---msgID: 28011
---@param kind number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMonthCardPanel(kind)
    local reqTable = {}
    if kind ~= nil then
        reqTable.kind = kind
    end
    local reqMsgData = protobufMgr.Serialize("vipV2.CardKind" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMonthCardPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMonthCardPanelMessage](LuaEnumNetDef.ReqMonthCardPanelMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMonthCardPanelMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMonthCardPanelMessage", 28011, "CardKind", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:28014 请求领取月卡每日福利
---请求领取月卡每日福利
---msgID: 28014
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveCardDayReward(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("vipV2.CardId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveCardDayRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveCardDayRewardMessage](LuaEnumNetDef.ReqReceiveCardDayRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveCardDayRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveCardDayRewardMessage", 28014, "CardId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:28016 请求月卡福利详情
---请求月卡福利详情
---msgID: 28016
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCardDayRewardInfo(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("vipV2.CardId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCardDayRewardInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCardDayRewardInfoMessage](LuaEnumNetDef.ReqCardDayRewardInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCardDayRewardInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCardDayRewardInfoMessage", 28016, "CardId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:28021 请求超级会员数据
---请求超级会员数据
---msgID: 28021
---@return boolean 网络请求是否成功发送
function networkRequest.ReqVipMemberInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqVipMemberInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqVipMemberInfoMessage](LuaEnumNetDef.ReqVipMemberInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqVipMemberInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:28024 领取等级奖励
---领取等级奖励
---msgID: 28024
---@param level number 必填参数 会员的等级.
---@return boolean 网络请求是否成功发送
function networkRequest.ReqVipMemberLevelReward(level)
    local reqTable = {}
    reqTable.level = level
    local reqMsgData = protobufMgr.Serialize("vipV2.VipMemberReveiveLevelReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqVipMemberLevelRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqVipMemberLevelRewardMessage](LuaEnumNetDef.ReqVipMemberLevelRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqVipMemberLevelRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqVipMemberLevelRewardMessage", 28024, "VipMemberReveiveLevelReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:28025 领取每日奖励
---领取每日奖励
---msgID: 28025
---@return boolean 网络请求是否成功发送
function networkRequest.ReqVipMemberDailyReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqVipMemberDailyRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqVipMemberDailyRewardMessage](LuaEnumNetDef.ReqVipMemberDailyRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqVipMemberDailyRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

