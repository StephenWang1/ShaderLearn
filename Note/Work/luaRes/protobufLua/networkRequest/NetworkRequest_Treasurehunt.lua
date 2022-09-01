--[[本文件为工具自动生成,禁止手动修改]]
--treasurehunt.xml

--region ID:11101 获取寻宝信息
---获取寻宝信息
---msgID: 11101
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetTreasureHunt()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetTreasureHuntMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetTreasureHuntMessage](LuaEnumNetDef.ReqGetTreasureHuntMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetTreasureHuntMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11102 寻宝积分信息
---寻宝积分信息
---msgID: 11102
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPointInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPointInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPointInfoMessage](LuaEnumNetDef.ReqPointInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqPointInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11103 寻宝请求
---寻宝请求
---msgID: 11103
---@param type number 选填参数 1为一次，2为10次，3为50次;
---@param treasurePrivate boolean 选填参数 是否私有牌面
---@param cardPage number 选填参数 页数
---@param buttonMax boolean 选填参数 是否按下了最大按钮
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTreasureHunt(type, treasurePrivate, cardPage, buttonMax)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if treasurePrivate ~= nil then
        reqTable.treasurePrivate = treasurePrivate
    end
    if cardPage ~= nil then
        reqTable.cardPage = cardPage
    end
    if buttonMax ~= nil then
        reqTable.buttonMax = buttonMax
    end
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.TreasureRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTreasureHuntMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTreasureHuntMessage](LuaEnumNetDef.ReqTreasureHuntMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTreasureHuntMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTreasureHuntMessage", 11103, "TreasureRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11104 寻宝积分兑换请求
---寻宝积分兑换请求
---msgID: 11104
---@param id number 必填参数 物品id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqExchangePoint(id)
    local reqTable = {}
    reqTable.id = id
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.ExchangePointRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqExchangePointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqExchangePointMessage](LuaEnumNetDef.ReqExchangePointMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqExchangePointMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqExchangePointMessage", 11104, "ExchangePointRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11106 获取某个物品
---获取某个物品
---msgID: 11106
---@param itemId number 必填参数 物品的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetItem(itemId)
    local reqTable = {}
    reqTable.itemId = itemId
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.GetTreasureItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetItemMessage](LuaEnumNetDef.ReqGetItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetItemMessage", 11106, "GetTreasureItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11107 获取所有物品
---获取所有物品
---msgID: 11107
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetWholeItem()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetWholeItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetWholeItemMessage](LuaEnumNetDef.ReqGetWholeItemMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetWholeItemMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11109 寻宝仓库信息请求
---寻宝仓库信息请求
---msgID: 11109
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTreasureStorehouse()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTreasureStorehouseMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTreasureStorehouseMessage](LuaEnumNetDef.ReqTreasureStorehouseMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTreasureStorehouseMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11112 使用寻宝经验丹
---使用寻宝经验丹
---msgID: 11112
---@param idList System.Collections.Generic.List1T<number> 列表参数 id集合
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseTreasureExp(idList)
    local reqData = CS.treasureHuntV2.ExpUseRequest()
    if idList ~= nil then
        reqData.idList:AddRange(idList)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseTreasureExpMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseTreasureExpMessage](LuaEnumNetDef.ReqUseTreasureExpMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUseTreasureExpMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:11114 寻宝界面宝箱请求
---寻宝界面宝箱请求
---msgID: 11114
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTreasureId()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTreasureIdMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTreasureIdMessage](LuaEnumNetDef.ReqTreasureIdMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTreasureIdMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11116 全服寻宝的奖励请求
---全服寻宝的奖励请求
---msgID: 11116
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServerTreasureReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServerTreasureRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServerTreasureRewardMessage](LuaEnumNetDef.ReqServerTreasureRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqServerTreasureRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11117 取消全服寻宝的奖励请求
---取消全服寻宝的奖励请求
---msgID: 11117
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCancelServerTreasureReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCancelServerTreasureRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCancelServerTreasureRewardMessage](LuaEnumNetDef.ReqCancelServerTreasureRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCancelServerTreasureRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11118 寻宝仓库中回收装备请求
---寻宝仓库中回收装备请求
---msgID: 11118
---@param idList System.Collections.Generic.List1T<number> 列表参数 物品的仓库id列表
---@return boolean 网络请求是否成功发送
function networkRequest.ReqHuntCallBack(idList)
    local reqData = CS.treasureHuntV2.HuntCallbackRequest()
    if idList ~= nil then
        reqData.idList:AddRange(idList)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqHuntCallBackMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqHuntCallBackMessage](LuaEnumNetDef.ReqHuntCallBackMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqHuntCallBackMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:11120 查看限时寻宝池请求
---查看限时寻宝池请求
---msgID: 11120
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLimitTimeTreasureHuntPool()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLimitTimeTreasureHuntPoolMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLimitTimeTreasureHuntPoolMessage](LuaEnumNetDef.ReqLimitTimeTreasureHuntPoolMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLimitTimeTreasureHuntPoolMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11122 寻宝新特戒今日是否显示提示
---寻宝新特戒今日是否显示提示
---msgID: 11122
---@param todatDisplay boolean 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqNewRingDisplay(todatDisplay)
    local reqTable = {}
    if todatDisplay ~= nil then
        reqTable.todatDisplay = todatDisplay
    end
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.NewRingDisplay" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqNewRingDisplayMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqNewRingDisplayMessage](LuaEnumNetDef.ReqNewRingDisplayMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqNewRingDisplayMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqNewRingDisplayMessage", 11122, "NewRingDisplay", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11123 请求寻宝卡牌信息
---请求寻宝卡牌信息
---msgID: 11123
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTreasureCard()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTreasureCardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTreasureCardMessage](LuaEnumNetDef.ReqTreasureCardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTreasureCardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11125 请求翻牌
---请求翻牌
---msgID: 11125
---@param page number 选填参数 页数
---@param index number 选填参数 卡牌的位置，从0开始
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTreasureTurnCard(page, index)
    local reqTable = {}
    if page ~= nil then
        reqTable.page = page
    end
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.TurnCardRequset" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTreasureTurnCardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTreasureTurnCardMessage](LuaEnumNetDef.ReqTreasureTurnCardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTreasureTurnCardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTreasureTurnCardMessage", 11125, "TurnCardRequset", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11127 请求寻宝卡牌私有结束信息
---请求寻宝卡牌私有结束信息
---msgID: 11127
---@param privateOver boolean 选填参数 是否私有牌面结束
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTreasurePrivateCardOver(privateOver)
    local reqTable = {}
    if privateOver ~= nil then
        reqTable.privateOver = privateOver
    end
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.PrivateCardOverRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTreasurePrivateCardOverMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTreasurePrivateCardOverMessage](LuaEnumNetDef.ReqTreasurePrivateCardOverMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTreasurePrivateCardOverMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTreasurePrivateCardOverMessage", 11127, "PrivateCardOverRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11129 请求历史信息
---请求历史信息
---msgID: 11129
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServerHistory()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServerHistoryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServerHistoryMessage](LuaEnumNetDef.ReqServerHistoryMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqServerHistoryMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11131 请求全服转生信息
---请求全服转生信息
---msgID: 11131
---@param rein System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReinNum(rein)
    local reqData = CS.treasureHuntV2.ReinNumRequest()
    if rein ~= nil then
        reqData.rein:AddRange(rein)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReinNumMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReinNumMessage](LuaEnumNetDef.ReqReinNumMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqReinNumMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:11133 请求挖宝
---请求挖宝
---msgID: 11133
---@param type number 选填参数 type=1黄金挖宝 else 普通挖宝
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDigTreasure(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.ReqDigTreasure" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDigTreasureMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDigTreasureMessage](LuaEnumNetDef.ReqDigTreasureMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDigTreasureMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDigTreasureMessage", 11133, "ReqDigTreasure", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11134 挖宝仓库请求一键提取、使用
---挖宝仓库请求一键提取、使用
---msgID: 11134
---@param type number 选填参数 1 :使用 2：提取
---@param lid number 选填参数 type==2时 该字段传值就是单个提取
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOneKeyOperation(type, lid)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if lid ~= nil then
        reqTable.lid = lid
    end
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.ReqOneKeyOperation" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOneKeyOperationMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOneKeyOperationMessage](LuaEnumNetDef.ReqOneKeyOperationMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOneKeyOperationMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOneKeyOperationMessage", 11134, "ReqOneKeyOperation", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11135 挖宝仓库请求一键回收
---挖宝仓库请求一键回收
---msgID: 11135
---@param itemIds table<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOneKeyCallBack(itemIds)
    local reqTable = {}
    if itemIds ~= nil then
        reqTable.itemIds = itemIds
    else
        reqTable.itemIds = {}
    end
    local reqMsgData = protobufMgr.Serialize("treasureHuntV2.ReqOneKeyCallBack" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOneKeyCallBackMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOneKeyCallBackMessage](LuaEnumNetDef.ReqOneKeyCallBackMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOneKeyCallBackMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOneKeyCallBackMessage", 11135, "ReqOneKeyCallBack", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:11137 请求打开挖宝仓库
---请求打开挖宝仓库
---msgID: 11137
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenDigTreasureWareHouse()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenDigTreasureWareHouseMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenDigTreasureWareHouseMessage](LuaEnumNetDef.ReqOpenDigTreasureWareHouseMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOpenDigTreasureWareHouseMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:11138 请求玩家挖宝次数
---请求玩家挖宝次数
---msgID: 11138
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDigTreasureCount()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDigTreasureCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDigTreasureCountMessage](LuaEnumNetDef.ReqDigTreasureCountMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDigTreasureCountMessage, nil, true)
    end
    return canSendMsg
end
--endregion

