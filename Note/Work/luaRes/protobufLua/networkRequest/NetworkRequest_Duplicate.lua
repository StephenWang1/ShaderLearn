--[[本文件为工具自动生成,禁止手动修改]]
--duplicate.xml

--region ID:71002 请求进入副本
---请求进入副本
---msgID: 71002
---@param duplicateId number 选填参数 副本配置id
---@param costType number 选填参数 0 default, 1 消耗1 ，2 消耗2.
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEnterDuplicate(duplicateId, costType)
    local reqTable = {}
    if duplicateId ~= nil then
        reqTable.duplicateId = duplicateId
    end
    if costType ~= nil then
        reqTable.costType = costType
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqEnterDuplicate" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEnterDuplicateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEnterDuplicateMessage](LuaEnumNetDef.ReqEnterDuplicateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEnterDuplicateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEnterDuplicateMessage", 71002, "ReqEnterDuplicate", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71003 请求退出副本
---请求退出副本
---msgID: 71003
---@param option number 必填参数 0:Exit 1:Continue
---@return boolean 网络请求是否成功发送
function networkRequest.ReqExitDuplicate(option)
    local reqTable = {}
    reqTable.option = option
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqLeaveDuplicate" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqExitDuplicateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqExitDuplicateMessage](LuaEnumNetDef.ReqExitDuplicateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqExitDuplicateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqExitDuplicateMessage", 71003, "ReqLeaveDuplicate", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71004 请求领取副本奖励
---请求领取副本奖励
---msgID: 71004
---@param multi number 必填参数 领取倍数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRewardDuplicate(multi)
    local reqTable = {}
    reqTable.multi = multi
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqDuplicateReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRewardDuplicateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRewardDuplicateMessage](LuaEnumNetDef.ReqRewardDuplicateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRewardDuplicateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRewardDuplicateMessage", 71004, "ReqDuplicateReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71008 请求副本信息
---请求副本信息
---msgID: 71008
---@param duplicateType number 选填参数 副本类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDuplicatePanelInfo(duplicateType)
    local reqTable = {}
    if duplicateType ~= nil then
        reqTable.duplicateType = duplicateType
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqDuplicatePanelInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDuplicatePanelInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDuplicatePanelInfoMessage](LuaEnumNetDef.ReqDuplicatePanelInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDuplicatePanelInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDuplicatePanelInfoMessage", 71008, "ReqDuplicatePanelInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71017 沙巴克面板
---沙巴克面板
---msgID: 71017
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSabacPanelInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSabacPanelInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSabacPanelInfoMessage](LuaEnumNetDef.ReqSabacPanelInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSabacPanelInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71019 快速完成副本请求
---快速完成副本请求
---msgID: 71019
---@param cfgId number 必填参数
---@param multi number 必填参数 领取倍数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAutoFinshDuplicate(cfgId, multi)
    local reqTable = {}
    reqTable.cfgId = cfgId
    reqTable.multi = multi
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqAutoFinshDuplicate" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAutoFinshDuplicateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAutoFinshDuplicateMessage](LuaEnumNetDef.ReqAutoFinshDuplicateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAutoFinshDuplicateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAutoFinshDuplicateMessage", 71019, "ReqAutoFinshDuplicate", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71022 请求暴君鼓舞
---请求暴君鼓舞
---msgID: 71022
---@param inspireType number 选填参数 鼓舞的方式，是元宝还是绑金 1是绑元  2是元宝
---@param playerId number 选填参数 玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInspireBuff(inspireType, playerId)
    local reqTable = {}
    if inspireType ~= nil then
        reqTable.inspireType = inspireType
    end
    if playerId ~= nil then
        reqTable.playerId = playerId
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqInspireBuff" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInspireBuffMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInspireBuffMessage](LuaEnumNetDef.ReqInspireBuffMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInspireBuffMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInspireBuffMessage", 71022, "ReqInspireBuff", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71028 请求陵墓信息
---请求陵墓信息
---msgID: 71028
---@param playerId number 选填参数 玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMausoleumDuplicate(playerId)
    local reqTable = {}
    if playerId ~= nil then
        reqTable.playerId = playerId
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqMausoleumDuplicate" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMausoleumDuplicateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMausoleumDuplicateMessage](LuaEnumNetDef.ReqMausoleumDuplicateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMausoleumDuplicateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMausoleumDuplicateMessage", 71028, "ReqMausoleumDuplicate", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71033 请求狼烟梦境时间消息
---请求狼烟梦境时间消息
---msgID: 71033
---@return boolean 网络请求是否成功发送
function networkRequest.ReqWolfDreamTime()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqWolfDreamTimeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqWolfDreamTimeMessage](LuaEnumNetDef.ReqWolfDreamTimeMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqWolfDreamTimeMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71035 购买圣域空间次数
---购买圣域空间次数
---msgID: 71035
---@param buyCount number 选填参数 要购买几次
---@return boolean 网络请求是否成功发送
function networkRequest.ReqButSanctuaryCount(buyCount)
    local reqTable = {}
    if buyCount ~= nil then
        reqTable.buyCount = buyCount
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqButSanctuaryCount" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqButSanctuaryCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqButSanctuaryCountMessage](LuaEnumNetDef.ReqButSanctuaryCountMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqButSanctuaryCountMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqButSanctuaryCountMessage", 71035, "ReqButSanctuaryCount", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71038 请求犯人剩余坐牢时间
---请求犯人剩余坐牢时间
---msgID: 71038
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPrisonRemainTime()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPrisonRemainTimeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPrisonRemainTimeMessage](LuaEnumNetDef.ReqPrisonRemainTimeMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqPrisonRemainTimeMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71039 获取沙巴克排名
---获取沙巴克排名
---msgID: 71039
---@param type number 必填参数
---@param page number 必填参数 页码
---@param countPerPage number 必填参数 每页条数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetSabacRankInfo(type, page, countPerPage)
    local reqTable = {}
    reqTable.type = type
    reqTable.page = page
    reqTable.countPerPage = countPerPage
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqGetSabacRankInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetSabacRankInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetSabacRankInfoMessage](LuaEnumNetDef.ReqGetSabacRankInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetSabacRankInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetSabacRankInfoMessage", 71039, "ReqGetSabacRankInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71041 女神赐福兑换物品
---女神赐福兑换物品
---msgID: 71041
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGoddessBlessingExchange()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGoddessBlessingExchangeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGoddessBlessingExchangeMessage](LuaEnumNetDef.ReqGoddessBlessingExchangeMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGoddessBlessingExchangeMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71045 请求幻境传送
---请求幻境传送
---msgID: 71045
---@param duplicateId number 选填参数 传送的层数ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeliveryDuplicate(duplicateId)
    local reqTable = {}
    if duplicateId ~= nil then
        reqTable.duplicateId = duplicateId
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqDeliveryDuplicate" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeliveryDuplicateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeliveryDuplicateMessage](LuaEnumNetDef.ReqDeliveryDuplicateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDeliveryDuplicateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDeliveryDuplicateMessage", 71045, "ReqDeliveryDuplicate", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71046 请求武道会下注
---请求武道会下注
---msgID: 71046
---@param targetPlayerId number 选填参数 目标玩家id
---@param finalWar boolean 选填参数 是否争霸赛
---@param zhu number 选填参数 下的注
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDuboBet(targetPlayerId, finalWar, zhu)
    local reqTable = {}
    if targetPlayerId ~= nil then
        reqTable.targetPlayerId = targetPlayerId
    end
    if finalWar ~= nil then
        reqTable.finalWar = finalWar
    end
    if zhu ~= nil then
        reqTable.zhu = zhu
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqDuboBet" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDuboBetMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDuboBetMessage](LuaEnumNetDef.ReqDuboBetMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDuboBetMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDuboBetMessage", 71046, "ReqDuboBet", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71047 请求查看武道会能下注
---请求查看武道会能下注
---msgID: 71047
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDuboLookBet()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDuboLookBetMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDuboLookBetMessage](LuaEnumNetDef.ReqDuboLookBetMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDuboLookBetMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71049 请求查看武道会排行榜
---请求查看武道会排行榜
---msgID: 71049
---@param type number 选填参数 0:武道会排行榜 1：点赞
---@param history number 选填参数 0,1,2 0：上期， 1：上上期， 2： 上上上期
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLookDuboRank(type, history)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if history ~= nil then
        reqTable.history = history
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqLookBudoMeet" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLookDuboRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLookDuboRankMessage](LuaEnumNetDef.ReqLookDuboRankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLookDuboRankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLookDuboRankMessage", 71049, "ReqLookBudoMeet", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71053 请求激活沙巴克法阵
---请求激活沙巴克法阵
---msgID: 71053
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStartSabacTactics()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStartSabacTacticsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStartSabacTacticsMessage](LuaEnumNetDef.ReqStartSabacTacticsMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqStartSabacTacticsMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71055 激活沙巴克法阵付费
---激活沙巴克法阵付费
---msgID: 71055
---@return boolean 网络请求是否成功发送
function networkRequest.ReqActiveSabacTactics()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqActiveSabacTacticsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqActiveSabacTacticsMessage](LuaEnumNetDef.ReqActiveSabacTacticsMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqActiveSabacTacticsMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71060 请求众筹面板信息
---请求众筹面板信息
---msgID: 71060
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCrowdFundingPanel()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCrowdFundingPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCrowdFundingPanelMessage](LuaEnumNetDef.ReqCrowdFundingPanelMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCrowdFundingPanelMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71062 请求开启众筹
---请求开启众筹
---msgID: 71062
---@param id number 选填参数 众筹表id
---@param startMins number 选填参数 开启时间(距离0的分钟)
---@param money number 选填参数 个人元宝
---@param unionMoney number 选填参数 帮会元宝
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenCrowdFunding(id, startMins, money, unionMoney)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    if startMins ~= nil then
        reqTable.startMins = startMins
    end
    if money ~= nil then
        reqTable.money = money
    end
    if unionMoney ~= nil then
        reqTable.unionMoney = unionMoney
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqOpenCrowdFunding" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenCrowdFundingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenCrowdFundingMessage](LuaEnumNetDef.ReqOpenCrowdFundingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOpenCrowdFundingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOpenCrowdFundingMessage", 71062, "ReqOpenCrowdFunding", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71063 请求捐赠
---请求捐赠
---msgID: 71063
---@param money number 选填参数
---@param unionMoney number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDonateFunding(money, unionMoney)
    local reqTable = {}
    if money ~= nil then
        reqTable.money = money
    end
    if unionMoney ~= nil then
        reqTable.unionMoney = unionMoney
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqDonateFunding" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDonateFundingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDonateFundingMessage](LuaEnumNetDef.ReqDonateFundingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDonateFundingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDonateFundingMessage", 71063, "ReqDonateFunding", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71065 请求掮客信息
---请求掮客信息
---msgID: 71065
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenBrokerPanel()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenBrokerPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenBrokerPanelMessage](LuaEnumNetDef.ReqOpenBrokerPanelMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOpenBrokerPanelMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71067 掮客查询
---掮客查询
---msgID: 71067
---@param roleId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBrokerQuery(roleId)
    local reqTable = {}
    reqTable.roleId = roleId
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqBrokerQuery" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBrokerQueryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBrokerQueryMessage](LuaEnumNetDef.ReqBrokerQueryMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBrokerQueryMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBrokerQueryMessage", 71067, "ReqBrokerQuery", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71068 获取女神赐福排名
---获取女神赐福排名
---msgID: 71068
---@param rankType number 选填参数 排行类型 1现在的 2以前的
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetGoddessBlessingRankInfo(rankType)
    local reqTable = {}
    if rankType ~= nil then
        reqTable.rankType = rankType
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.GetGoddessBlessingRank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetGoddessBlessingRankInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetGoddessBlessingRankInfoMessage](LuaEnumNetDef.ReqGetGoddessBlessingRankInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetGoddessBlessingRankInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetGoddessBlessingRankInfoMessage", 71068, "GetGoddessBlessingRank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71071 活动点赞请求
---活动点赞请求
---msgID: 71071
---@param activityId number 选填参数 活动id
---@param targetId number 选填参数 点赞的对象id
---@param periodParam number 选填参数 周期参数 0代表本期
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLike(activityId, targetId, periodParam)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    if periodParam ~= nil then
        reqTable.periodParam = periodParam
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.LikeRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLikeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLikeMessage](LuaEnumNetDef.ReqLikeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLikeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLikeMessage", 71071, "LikeRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71073 请求玩家活动数据
---请求玩家活动数据
---msgID: 71073
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPlayerActivityDataRank()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPlayerActivityDataRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPlayerActivityDataRankMessage](LuaEnumNetDef.ReqPlayerActivityDataRankMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqPlayerActivityDataRankMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71076 请求今日是否使用烟花
---请求今日是否使用烟花
---msgID: 71076
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTodayUseFirework()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTodayUseFireworkMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTodayUseFireworkMessage](LuaEnumNetDef.ReqTodayUseFireworkMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTodayUseFireworkMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:71078 请求活动往期时间
---请求活动往期时间
---msgID: 71078
---@param activityType number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGBPreviousPeriodTime(activityType)
    local reqTable = {}
    reqTable.activityType = activityType
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqGBPreviousPeriodTime" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGBPreviousPeriodTimeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGBPreviousPeriodTimeMessage](LuaEnumNetDef.ReqGBPreviousPeriodTimeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGBPreviousPeriodTimeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGBPreviousPeriodTimeMessage", 71078, "ReqGBPreviousPeriodTime", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71080 请求女神赐福往期数据
---请求女神赐福往期数据
---msgID: 71080
---@param times number 选填参数 往期时间
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGBPreviousPeriodInfo(times)
    local reqTable = {}
    if times ~= nil then
        reqTable.times = times
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqGBPreviousPeriodInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGBPreviousPeriodInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGBPreviousPeriodInfoMessage](LuaEnumNetDef.ReqGBPreviousPeriodInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGBPreviousPeriodInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGBPreviousPeriodInfoMessage", 71080, "ReqGBPreviousPeriodInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71082 请求沙巴克历史记录
---请求沙巴克历史记录
---msgID: 71082
---@param index number 必填参数
---@param unionId number 选填参数
---@param unionName string 选填参数
---@param rankInfo System.Collections.Generic.List1T<duplicateV2.duplicateV2.SabacRankInfo> 列表参数
---@param myRankInfo duplicateV2.duplicateV2.SabacRankInfo 选填参数 自己的信息
---@param hostId number 选填参数 客户端标志
---@param uniteId number 选填参数 联盟Id
---@param uniteType number 选填参数 联盟类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSabacRecord(index, unionId, unionName, rankInfo, myRankInfo, hostId, uniteId, uniteType)
    local reqData = CS.duplicateV2.ResSabacRecord()
    reqData.index = index
    if unionId ~= nil then
        reqData.unionId = unionId
    end
    if unionName ~= nil then
        reqData.unionName = unionName
    end
    if rankInfo ~= nil then
        reqData.rankInfo:AddRange(rankInfo)
    end
    if myRankInfo ~= nil then
        reqData.myRankInfo = myRankInfo
    end
    if hostId ~= nil then
        reqData.hostId = hostId
    end
    if uniteId ~= nil then
        reqData.uniteId = uniteId
    end
    if uniteType ~= nil then
        reqData.uniteType = uniteType
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSabacRecordMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSabacRecordMessage](LuaEnumNetDef.ReqSabacRecordMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSabacRecordMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:71084 查看往期内容（用于幻境）
---查看往期内容（用于幻境）
---msgID: 71084
---@param activeType number 选填参数 活动Type
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetPreviousReview(activeType)
    local reqTable = {}
    if activeType ~= nil then
        reqTable.activeType = activeType
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqGetPreviousReview" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetPreviousReviewMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetPreviousReviewMessage](LuaEnumNetDef.ReqGetPreviousReviewMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetPreviousReviewMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetPreviousReviewMessage", 71084, "ReqGetPreviousReview", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71086 查看具体某个活动的往期内容（用于幻境）
---查看具体某个活动的往期内容（用于幻境）
---msgID: 71086
---@param activeType number 选填参数 活动Type
---@param activeTime number 选填参数 举办的活动时间戳
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetSpecificPreviousReview(activeType, activeTime)
    local reqTable = {}
    if activeType ~= nil then
        reqTable.activeType = activeType
    end
    if activeTime ~= nil then
        reqTable.activeTime = activeTime
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqGetSpecificPreviousReview" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetSpecificPreviousReviewMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetSpecificPreviousReviewMessage](LuaEnumNetDef.ReqGetSpecificPreviousReviewMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetSpecificPreviousReviewMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetSpecificPreviousReviewMessage", 71086, "ReqGetSpecificPreviousReview", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71088 记录打开往期数据面板的玩家
---记录打开往期数据面板的玩家
---msgID: 71088
---@param id number 选填参数 客户端定义的ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSeePreviousData(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqSeePreviousData" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSeePreviousDataMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSeePreviousDataMessage](LuaEnumNetDef.ReqSeePreviousDataMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSeePreviousDataMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSeePreviousDataMessage", 71088, "ReqSeePreviousData", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71089 记录关闭往期数据面板的玩家
---记录关闭往期数据面板的玩家
---msgID: 71089
---@param id number 选填参数 客户端定义的ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqClosePreviousData(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqClosePreviousData" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqClosePreviousDataMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqClosePreviousDataMessage](LuaEnumNetDef.ReqClosePreviousDataMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqClosePreviousDataMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqClosePreviousDataMessage", 71089, "ReqClosePreviousData", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71092 请求恶魔广场剩余时间
---请求恶魔广场剩余时间
---msgID: 71092
---@param duplicateType number 选填参数 副本类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDevilSquareHasTime(duplicateType)
    local reqTable = {}
    if duplicateType ~= nil then
        reqTable.duplicateType = duplicateType
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqDevilSquareEndTime" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDevilSquareHasTimeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDevilSquareHasTimeMessage](LuaEnumNetDef.ReqDevilSquareHasTimeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDevilSquareHasTimeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDevilSquareHasTimeMessage", 71092, "ReqDevilSquareEndTime", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71095 请求复活塔罗神庙怪物
---请求复活塔罗神庙怪物
---msgID: 71095
---@param NpcId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReliveHuntMonster(NpcId)
    local reqTable = {}
    if NpcId ~= nil then
        reqTable.NpcId = NpcId
    end
    local reqMsgData = protobufMgr.Serialize("duplicateV2.ReqReliveHuntMonster" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReliveHuntMonsterMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReliveHuntMonsterMessage](LuaEnumNetDef.ReqReliveHuntMonsterMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReliveHuntMonsterMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReliveHuntMonsterMessage", 71095, "ReqReliveHuntMonster", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:71104 获取沙巴克个人积分排名
---获取沙巴克个人积分排名
---msgID: 71104
---@param type number 必填参数
---@param page number 必填参数 页码
---@param countPerPage number 必填参数 每页条数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetSabacPersonalRankInfo(type, page, countPerPage)
    local reqData = CS.duplicateV2.ReqGetSabacRankInfo()
    reqData.type = type
    reqData.page = page
    reqData.countPerPage = countPerPage
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetSabacPersonalRankInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetSabacPersonalRankInfoMessage](LuaEnumNetDef.ReqGetSabacPersonalRankInfoMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetSabacPersonalRankInfoMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

