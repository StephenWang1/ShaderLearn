--[[本文件为工具自动生成,禁止手动修改]]
--activity.xml

--region ID:4001 请求领取活动奖励
---请求领取活动奖励
---msgID: 4001
---@param activityId number 选填参数 活动id
---@param type number 选填参数 目标类型
---@param goal number 选填参数 目标参数
---@param multi number 选填参数 多倍领取倍数
---@param data64 number 选填参数 客户端传过来的64位，暂时表示回收选择的物品id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetActivityReward(activityId, type, goal, multi, data64)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if type ~= nil then
        reqTable.type = type
    end
    if goal ~= nil then
        reqTable.goal = goal
    end
    if multi ~= nil then
        reqTable.multi = multi
    end
    if data64 ~= nil then
        reqTable.data64 = data64
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqGetActivityReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetActivityRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetActivityRewardMessage](LuaEnumNetDef.ReqGetActivityRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetActivityRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetActivityRewardMessage", 4001, "ReqGetActivityReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4003 请求打开活动面板
---请求打开活动面板
---msgID: 4003
---@param activityType number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenPanel(activityType)
    local reqTable = {}
    if activityType ~= nil then
        reqTable.activityType = activityType
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqOpenPanel" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenPanelMessage](LuaEnumNetDef.ReqOpenPanelMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOpenPanelMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOpenPanelMessage", 4003, "ReqOpenPanel", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4008 请求领取限时任务额外奖励
---请求领取限时任务额外奖励
---msgID: 4008
---@param activityId number 选填参数 活动id
---@param goalType number 选填参数 当前第几轮
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetExtraReward(activityId, goalType)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if goalType ~= nil then
        reqTable.goalType = goalType
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqGetExtraReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetExtraRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetExtraRewardMessage](LuaEnumNetDef.ReqGetExtraRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetExtraRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetExtraRewardMessage", 4008, "ReqGetExtraReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4009 请求打开炼制面板
---请求打开炼制面板
---msgID: 4009
---@param activityId number 选填参数 活动id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenLianZhi(activityId)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqOpenLianZhi" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenLianZhiMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenLianZhiMessage](LuaEnumNetDef.ReqOpenLianZhiMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOpenLianZhiMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOpenLianZhiMessage", 4009, "ReqOpenLianZhi", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4011 请求炼制
---请求炼制
---msgID: 4011
---@param activityId number 选填参数 活动id
---@param times number 选填参数 档次
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLianZhi(activityId, times)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if times ~= nil then
        reqTable.times = times
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqLianZhi" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLianZhiMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLianZhiMessage](LuaEnumNetDef.ReqLianZhiMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLianZhiMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLianZhiMessage", 4011, "ReqLianZhi", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4022 请求领取首杀boss奖励
---请求领取首杀boss奖励
---msgID: 4022
---@param activityId number 选填参数
---@param cfgId number 选填参数 首杀表配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetFirstKillBossReward(activityId, cfgId)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if cfgId ~= nil then
        reqTable.cfgId = cfgId
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqGetFirstKillBossReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetFirstKillBossRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetFirstKillBossRewardMessage](LuaEnumNetDef.ReqGetFirstKillBossRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetFirstKillBossRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetFirstKillBossRewardMessage", 4022, "ReqGetFirstKillBossReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4025 领取限时任务完成奖励
---领取限时任务完成奖励
---msgID: 4025
---@param rate number 选填参数 倍数
---@param taskId number 选填参数 任务id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawTimeLimitTaskReward(rate, taskId)
    local reqTable = {}
    if rate ~= nil then
        reqTable.rate = rate
    end
    if taskId ~= nil then
        reqTable.taskId = taskId
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqDrawTimeLimitTaskReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawTimeLimitTaskRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawTimeLimitTaskRewardMessage](LuaEnumNetDef.ReqDrawTimeLimitTaskRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawTimeLimitTaskRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawTimeLimitTaskRewardMessage", 4025, "ReqDrawTimeLimitTaskReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4027 请求玩家排行数据
---请求玩家排行数据
---msgID: 4027
---@param activityId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRoleActivityRankInfo(activityId)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqRoleActivityRankInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRoleActivityRankInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRoleActivityRankInfoMessage](LuaEnumNetDef.ReqRoleActivityRankInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRoleActivityRankInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRoleActivityRankInfoMessage", 4027, "ReqRoleActivityRankInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4030 开始幸运转盘
---开始幸运转盘
---msgID: 4030
---@param activityId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStartLuckyWheel(activityId)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqStartLuckyWheel" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStartLuckyWheelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStartLuckyWheelMessage](LuaEnumNetDef.ReqStartLuckyWheelMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqStartLuckyWheelMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqStartLuckyWheelMessage", 4030, "ReqStartLuckyWheel", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4032 发送幸运转盘奖励
---发送幸运转盘奖励
---msgID: 4032
---@param activityId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetLuckyWheelReward(activityId)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqGetLuckyWheelReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetLuckyWheelRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetLuckyWheelRewardMessage](LuaEnumNetDef.ReqGetLuckyWheelRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetLuckyWheelRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetLuckyWheelRewardMessage", 4032, "ReqGetLuckyWheelReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4035 请求领取七日狂欢奖励
---请求领取七日狂欢奖励
---msgID: 4035
---@param activityId number 选填参数 活动id
---@param day number 选填参数 天数
---@param group number 选填参数 组别
---@param index number 选填参数 序号
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawHappySevenDayActivityReward(activityId, day, group, index)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if day ~= nil then
        reqTable.day = day
    end
    if group ~= nil then
        reqTable.group = group
    end
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqDrawHappySevenDayActivityReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawHappySevenDayActivityRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawHappySevenDayActivityRewardMessage](LuaEnumNetDef.ReqDrawHappySevenDayActivityRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawHappySevenDayActivityRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawHappySevenDayActivityRewardMessage", 4035, "ReqDrawHappySevenDayActivityReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4038 请求抽奖
---请求抽奖
---msgID: 4038
---@param activityId number 选填参数
---@param count number 选填参数 抽奖次数
---@param costType number 选填参数 1.元宝 2.道具
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRaffle(activityId, count, costType)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if count ~= nil then
        reqTable.count = count
    end
    if costType ~= nil then
        reqTable.costType = costType
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqRaffle" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRaffleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRaffleMessage](LuaEnumNetDef.ReqRaffleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRaffleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRaffleMessage", 4038, "ReqRaffle", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4044 请求领取狂欢活动奖励
---请求领取狂欢活动奖励
---msgID: 4044
---@param activityId number 选填参数
---@param group number 选填参数 组别 总奖励组别为-1,狂欢转盘为-2
---@param index number 选填参数 编号
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawCrazyHappyReward(activityId, group, index)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if group ~= nil then
        reqTable.group = group
    end
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqDrawCrazyHappyReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawCrazyHappyRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawCrazyHappyRewardMessage](LuaEnumNetDef.ReqDrawCrazyHappyRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawCrazyHappyRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawCrazyHappyRewardMessage", 4044, "ReqDrawCrazyHappyReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4051 请求领取投资返利奖励
---请求领取投资返利奖励
---msgID: 4051
---@param activityId number 选填参数
---@param dayNo number 选填参数 第n天
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawInvestPlanReward(activityId, dayNo)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if dayNo ~= nil then
        reqTable.dayNo = dayNo
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqDrawInvestPlanReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawInvestPlanRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawInvestPlanRewardMessage](LuaEnumNetDef.ReqDrawInvestPlanRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawInvestPlanRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawInvestPlanRewardMessage", 4051, "ReqDrawInvestPlanReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4052 请求狂欢转盘抽奖
---请求狂欢转盘抽奖
---msgID: 4052
---@param activityId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCrazyRaffle(activityId)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqCrazyRaffle" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCrazyRaffleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCrazyRaffleMessage](LuaEnumNetDef.ReqCrazyRaffleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCrazyRaffleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCrazyRaffleMessage", 4052, "ReqCrazyRaffle", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4056 请求领取成长试炼奖励
---请求领取成长试炼奖励
---msgID: 4056
---@param activityId number 选填参数
---@param dayNo number 选填参数 天数
---@param group number 选填参数 组
---@param index number 选填参数 编号
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawGrowTrailReward(activityId, dayNo, group, index)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if dayNo ~= nil then
        reqTable.dayNo = dayNo
    end
    if group ~= nil then
        reqTable.group = group
    end
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqDrawGrowTrailReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawGrowTrailRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawGrowTrailRewardMessage](LuaEnumNetDef.ReqDrawGrowTrailRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawGrowTrailRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawGrowTrailRewardMessage", 4056, "ReqDrawGrowTrailReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4057 请求领取成长试炼终极奖励
---请求领取成长试炼终极奖励
---msgID: 4057
---@param activityId number 选填参数
---@param index number 选填参数 编号
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawGrowTrailFinalReward(activityId, index)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqDrawGrowTrailFinalReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawGrowTrailFinalRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawGrowTrailFinalRewardMessage](LuaEnumNetDef.ReqDrawGrowTrailFinalRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawGrowTrailFinalRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawGrowTrailFinalRewardMessage", 4057, "ReqDrawGrowTrailFinalReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4060 请求设置自选转盘
---请求设置自选转盘
---msgID: 4060
---@param activityId number 选填参数
---@param cfgIdList System.Collections.Generic.List1T<number> 列表参数 配置id集合
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSetChoseTurntable(activityId, cfgIdList)
    local reqData = CS.activityV2.ReqSetChoseTurntable()
    if activityId ~= nil then
        reqData.activityId = activityId
    end
    if cfgIdList ~= nil then
        reqData.cfgIdList:AddRange(cfgIdList)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSetChoseTurntableMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSetChoseTurntableMessage](LuaEnumNetDef.ReqSetChoseTurntableMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSetChoseTurntableMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:4062 请求面板信息
---请求面板信息
---msgID: 4062
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenGrowTrailInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenGrowTrailInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenGrowTrailInfoMessage](LuaEnumNetDef.ReqOpenGrowTrailInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOpenGrowTrailInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:4064 请求面板信息
---请求面板信息
---msgID: 4064
---@param activityId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyLimitedOffer(activityId)
    local reqTable = {}
    reqTable.activityId = activityId
    local reqMsgData = protobufMgr.Serialize("activityV2.BuyLimitedOfferRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyLimitedOfferMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyLimitedOfferMessage](LuaEnumNetDef.ReqBuyLimitedOfferMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyLimitedOfferMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyLimitedOfferMessage", 4064, "BuyLimitedOfferRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4067 活动开启信息请求
---活动开启信息请求
---msgID: 4067
---@param type number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServerActivityData(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ActivityOpenMsgRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServerActivityDataMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServerActivityDataMessage](LuaEnumNetDef.ReqServerActivityDataMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqServerActivityDataMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqServerActivityDataMessage", 4067, "ActivityOpenMsgRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4076 请求保卫国王上次活动排行
---请求保卫国王上次活动排行
---msgID: 4076
---@param time number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDefendLastRank(time)
    local reqTable = {}
    reqTable.time = time
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqDefendLastRank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDefendLastRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDefendLastRankMessage](LuaEnumNetDef.ReqDefendLastRankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDefendLastRankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDefendLastRankMessage", 4076, "ReqDefendLastRank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4082 boss积分奖励领取
---boss积分奖励领取
---msgID: 4082
---@param id number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetBossScoreReward(id)
    local reqTable = {}
    reqTable.id = id
    local reqMsgData = protobufMgr.Serialize("activityV2.GetBossScoreReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetBossScoreRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetBossScoreRewardMessage](LuaEnumNetDef.ReqGetBossScoreRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetBossScoreRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetBossScoreRewardMessage", 4082, "GetBossScoreReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4085 一键领取猎魔人
---一键领取猎魔人
---msgID: 4085
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLieMoRenGetReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLieMoRenGetRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLieMoRenGetRewardMessage](LuaEnumNetDef.ReqLieMoRenGetRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLieMoRenGetRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:4086 请求保卫国王排行
---请求保卫国王排行
---msgID: 4086
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDefendKingRank()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDefendKingRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDefendKingRankMessage](LuaEnumNetDef.ReqDefendKingRankMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDefendKingRankMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:4089 请求保卫国王活动排行榜期数列表
---请求保卫国王活动排行榜期数列表
---msgID: 4089
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDefendLastRankList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDefendLastRankListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDefendLastRankListMessage](LuaEnumNetDef.ReqDefendLastRankListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDefendLastRankListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:4092 请求玩家上线今日已结束的活动type
---请求玩家上线今日已结束的活动type
---msgID: 4092
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTodayClosedActivities()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTodayClosedActivitiesMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTodayClosedActivitiesMessage](LuaEnumNetDef.ReqTodayClosedActivitiesMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTodayClosedActivitiesMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:4096 请求全部历法下礼包状态
---请求全部历法下礼包状态
---msgID: 4096
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAllCalendarGiftState()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAllCalendarGiftStateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAllCalendarGiftStateMessage](LuaEnumNetDef.ReqAllCalendarGiftStateMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqAllCalendarGiftStateMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:4098 请求领取历法小礼包
---请求领取历法小礼包
---msgID: 4098
---@param id number 选填参数 小礼包id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveCalendarGift(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("activityV2.ReqReceiveGift" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveCalendarGiftMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveCalendarGiftMessage](LuaEnumNetDef.ReqReceiveCalendarGiftMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveCalendarGiftMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveCalendarGiftMessage", 4098, "ReqReceiveGift", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:4099 请求幸运转盘信息
---请求幸运转盘信息
---msgID: 4099
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLuckTurntableInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLuckTurntableInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLuckTurntableInfoMessage](LuaEnumNetDef.ReqLuckTurntableInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLuckTurntableInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:4101 请求幸运转盘抽奖
---请求幸运转盘抽奖
---msgID: 4101
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLuckTurntableLottery()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLuckTurntableLotteryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLuckTurntableLotteryMessage](LuaEnumNetDef.ReqLuckTurntableLotteryMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLuckTurntableLotteryMessage, nil, true)
    end
    return canSendMsg
end
--endregion

