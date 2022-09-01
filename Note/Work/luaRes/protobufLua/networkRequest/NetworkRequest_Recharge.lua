--[[本文件为工具自动生成,禁止手动修改]]
--recharge.xml

--region ID:39001 获取充值界面信息
---获取充值界面信息
---msgID: 39001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRechargeInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRechargeInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRechargeInfoMessage](LuaEnumNetDef.ReqGetRechargeInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetRechargeInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39003 请求领取累计(首充)奖励
---请求领取累计(首充)奖励
---msgID: 39003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTotalRechargeReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTotalRechargeRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTotalRechargeRewardMessage](LuaEnumNetDef.ReqTotalRechargeRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTotalRechargeRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39005 请求领取每日充值奖励
---请求领取每日充值奖励
---msgID: 39005
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetDayRechargeReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetDayRechargeRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetDayRechargeRewardMessage](LuaEnumNetDef.ReqGetDayRechargeRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetDayRechargeRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39009 请求领取充值惊喜奖励
---请求领取充值惊喜奖励
---msgID: 39009
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRechargeSurpriseReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRechargeSurpriseRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRechargeSurpriseRewardMessage](LuaEnumNetDef.ReqGetRechargeSurpriseRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetRechargeSurpriseRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39010 请求领取限时直购奖励
---请求领取限时直购奖励
---msgID: 39010
---@param cfgId number 选填参数 配置表id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetThroughRechargeReward(cfgId)
    local reqTable = {}
    if cfgId ~= nil then
        reqTable.cfgId = cfgId
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqGetThroughRechargeReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetThroughRechargeRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetThroughRechargeRewardMessage](LuaEnumNetDef.ReqGetThroughRechargeRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetThroughRechargeRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetThroughRechargeRewardMessage", 39010, "ReqGetThroughRechargeReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39012 请求领取返利充值奖励
---请求领取返利充值奖励
---msgID: 39012
---@param activityId number 选填参数 活动id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetBackRechargeReward(activityId)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqGetBackRechargeReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetBackRechargeRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetBackRechargeRewardMessage](LuaEnumNetDef.ReqGetBackRechargeRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetBackRechargeRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetBackRechargeRewardMessage", 39012, "ReqGetBackRechargeReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39014 充值入口
---充值入口
---msgID: 39014
---@param entrance number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRechargeEntrance(entrance)
    local reqTable = {}
    reqTable.entrance = entrance
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqRechargeEntrance" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRechargeEntranceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRechargeEntranceMessage](LuaEnumNetDef.ReqRechargeEntranceMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRechargeEntranceMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRechargeEntranceMessage", 39014, "ReqRechargeEntrance", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39015 领取首充奖励
---领取首充奖励
---msgID: 39015
---@param index number 必填参数 首充奖励档位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetFirstRechargeReward(index)
    local reqData = CS.rechargeV2.ReqFirstRechargeReward()
    reqData.index = index
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetFirstRechargeRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetFirstRechargeRewardMessage](LuaEnumNetDef.ReqGetFirstRechargeRewardMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetFirstRechargeRewardMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:39018 请求消除红点
---请求消除红点
---msgID: 39018
---@return boolean 网络请求是否成功发送
function networkRequest.ReqClearFirstChargeRedPoint()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqClearFirstChargeRedPointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqClearFirstChargeRedPointMessage](LuaEnumNetDef.ReqClearFirstChargeRedPointMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqClearFirstChargeRedPointMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39019 请求购买投资计划
---请求购买投资计划
---msgID: 39019
---@param investPhase number 选填参数 投资计划期数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyInvestPlan(investPhase)
    local reqTable = {}
    if investPhase ~= nil then
        reqTable.investPhase = investPhase
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqBuyInvestPlanRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyInvestPlanMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyInvestPlanMessage](LuaEnumNetDef.ReqBuyInvestPlanMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyInvestPlanMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyInvestPlanMessage", 39019, "ReqBuyInvestPlanRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39020 领取投资奖励
---领取投资奖励
---msgID: 39020
---@param id number 选填参数 invest 表 id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveInvest(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqReceiveInvestRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveInvestMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveInvestMessage](LuaEnumNetDef.ReqReceiveInvestMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveInvestMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveInvestMessage", 39020, "ReqReceiveInvestRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39022 请求投资计划数据
---请求投资计划数据
---msgID: 39022
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInvestPlanData()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInvestPlanDataMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInvestPlanDataMessage](LuaEnumNetDef.ReqInvestPlanDataMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqInvestPlanDataMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39023 请求某期投资计划数据
---请求某期投资计划数据
---msgID: 39023
---@param investPhase number 选填参数 投资计划期数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInvestPlanInfo(investPhase)
    local reqTable = {}
    if investPhase ~= nil then
        reqTable.investPhase = investPhase
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqGetInvestPlanRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInvestPlanInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInvestPlanInfoMessage](LuaEnumNetDef.ReqInvestPlanInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInvestPlanInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInvestPlanInfoMessage", 39023, "ReqGetInvestPlanRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39025 领取累计充值奖励
---领取累计充值奖励
---msgID: 39025
---@param id number 选填参数 cumCharge 表 id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveCumRecharge(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqReceiveCumRechargeRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveCumRechargeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveCumRechargeMessage](LuaEnumNetDef.ReqReceiveCumRechargeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveCumRechargeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveCumRechargeMessage", 39025, "ReqReceiveCumRechargeRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39027 请求累计充值数据
---请求累计充值数据
---msgID: 39027
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCumRechargeData()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCumRechargeDataMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCumRechargeDataMessage](LuaEnumNetDef.ReqCumRechargeDataMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCumRechargeDataMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39028 请求某期累计充值数据
---请求某期累计充值数据
---msgID: 39028
---@param rechargePhase number 选填参数 累计充值期数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCumRechargeInfo(rechargePhase)
    local reqTable = {}
    if rechargePhase ~= nil then
        reqTable.rechargePhase = rechargePhase
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqGetCumRechargeRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCumRechargeInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCumRechargeInfoMessage](LuaEnumNetDef.ReqCumRechargeInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCumRechargeInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCumRechargeInfoMessage", 39028, "ReqGetCumRechargeRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39030 请求已经领取的首冲赠送
---请求已经领取的首冲赠送
---msgID: 39030
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFirstRechargeGive()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFirstRechargeGiveMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFirstRechargeGiveMessage](LuaEnumNetDef.ReqFirstRechargeGiveMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqFirstRechargeGiveMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39033 检测累计充值是否有奖励可领
---检测累计充值是否有奖励可领
---msgID: 39033
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCumRechargeCanReceive()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCumRechargeCanReceiveMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCumRechargeCanReceiveMessage](LuaEnumNetDef.ReqCumRechargeCanReceiveMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCumRechargeCanReceiveMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:39035 激活某一类型的时装投资
---激活某一类型的时装投资
---msgID: 39035
---@param investType number 选填参数 时装投资类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqActiveFashionInvest(investType)
    local reqTable = {}
    if investType ~= nil then
        reqTable.investType = investType
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqActiveFashionInvest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqActiveFashionInvestMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqActiveFashionInvestMessage](LuaEnumNetDef.ReqActiveFashionInvestMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqActiveFashionInvestMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqActiveFashionInvestMessage", 39035, "ReqActiveFashionInvest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:39038 领取时装投资奖励
---领取时装投资奖励
---msgID: 39038
---@param id number 选填参数 invest 表 id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveFashionInvest(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("rechargeV2.ReqReceiveFashionInvest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveFashionInvestMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveFashionInvestMessage](LuaEnumNetDef.ReqReceiveFashionInvestMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveFashionInvestMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveFashionInvestMessage", 39038, "ReqReceiveFashionInvest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

