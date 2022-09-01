--[[本文件为工具自动生成,禁止手动修改]]
--map.xml

--region ID:67012 玩家登录地图
---玩家登录地图
---msgID: 67012
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLoginMap()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLoginMapMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLoginMapMessage](LuaEnumNetDef.ReqLoginMapMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLoginMapMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:67017 玩家尝试进入地图
---玩家尝试进入地图
---msgID: 67017
---@param mid number 必填参数
---@param line number 必填参数 地图分线
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTryEnterMap(mid, line)
    local reqTable = {}
    reqTable.mid = mid
    reqTable.line = line
    local reqMsgData = protobufMgr.Serialize("mapV2.TryEnterMapRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTryEnterMapMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTryEnterMapMessage](LuaEnumNetDef.ReqTryEnterMapMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTryEnterMapMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTryEnterMapMessage", 67017, "TryEnterMapRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67025 请求复活
---请求复活
---msgID: 67025
---@param reliveType number 必填参数 1、自动复活（走配置配置是啥，就是啥），2、原地复活
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPlayerRelive(reliveType)
    local reqTable = {}
    reqTable.reliveType = reliveType
    local reqMsgData = protobufMgr.Serialize("mapV2.PlayerReliveRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPlayerReliveMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPlayerReliveMessage](LuaEnumNetDef.ReqPlayerReliveMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPlayerReliveMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPlayerReliveMessage", 67025, "PlayerReliveRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67029 请求切换攻击模式
---请求切换攻击模式
---msgID: 67029
---@param fightModel number 必填参数 攻击模式 0和平 1组队 2行会 3全体 4善恶  5阵营
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSwitchFightModel(fightModel)
    local reqTable = {}
    reqTable.fightModel = fightModel
    local reqMsgData = protobufMgr.Serialize("mapV2.SwitchFightModelRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSwitchFightModelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSwitchFightModelMessage](LuaEnumNetDef.ReqSwitchFightModelMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSwitchFightModelMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSwitchFightModelMessage", 67029, "SwitchFightModelRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67031 拾取地图道具
---拾取地图道具
---msgID: 67031
---@param objId number 必填参数 地面道具的唯一id
---@param time number 选填参数 客户端拾取的时间戳
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPickUpMapItem(objId, time)
    local reqTable = {}
    reqTable.objId = objId
    if time ~= nil then
        reqTable.time = time
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.PickUpMapItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPickUpMapItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPickUpMapItemMessage](LuaEnumNetDef.ReqPickUpMapItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPickUpMapItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPickUpMapItemMessage", 67031, "PickUpMapItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67035 请求boss归属
---请求boss归属
---msgID: 67035
---@param bossId number 必填参数 boss唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBossOwner(bossId)
    local reqTable = {}
    reqTable.bossId = bossId
    local reqMsgData = protobufMgr.Serialize("mapV2.BossOwnerRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBossOwnerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBossOwnerMessage](LuaEnumNetDef.ReqBossOwnerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBossOwnerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBossOwnerMessage", 67035, "BossOwnerRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67041 请求采集操作
---请求采集操作
---msgID: 67041
---@param type number 必填参数 1 采集的类型 1挖肉；2尸体挖掘；3挖矿；4采药植；5收集宝箱
---@param lid number 必填参数 被采集对象唯一id
---@param consumeType number 选填参数 消耗类型，默认0-不消耗(兼容之前的)，1-消耗元宝，2-消耗钻石
---@param isAutomatic number 选填参数 是否是客户端自动采集 默认0不是  1是
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGatherOperator(type, lid, consumeType, isAutomatic)
    local reqTable = {}
    reqTable.type = type
    reqTable.lid = lid
    if consumeType ~= nil then
        reqTable.consumeType = consumeType
    end
    if isAutomatic ~= nil then
        reqTable.isAutomatic = isAutomatic
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.GatherOperatorRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGatherOperatorMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGatherOperatorMessage](LuaEnumNetDef.ReqGatherOperatorMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGatherOperatorMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGatherOperatorMessage", 67041, "GatherOperatorRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67047 停止采集
---停止采集
---msgID: 67047
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStopGather()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStopGatherMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStopGatherMessage](LuaEnumNetDef.ReqStopGatherMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqStopGatherMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:67048 点击事件(比如开宝箱)
---点击事件(比如开宝箱)
---msgID: 67048
---@param groundEventId number 必填参数 要点击的事件的唯一 id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqClickEvent(groundEventId)
    local reqTable = {}
    reqTable.groundEventId = groundEventId
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqClickEvent" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqClickEventMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqClickEventMessage](LuaEnumNetDef.ReqClickEventMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqClickEventMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqClickEventMessage", 67048, "ReqClickEvent", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67053 请求生肖npc信息
---请求生肖npc信息
---msgID: 67053
---@param npcId number 选填参数 npcId
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAnimalNPCInfo(npcId)
    local reqTable = {}
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqAnimalNPCInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAnimalNPCInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAnimalNPCInfoMessage](LuaEnumNetDef.ReqAnimalNPCInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAnimalNPCInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAnimalNPCInfoMessage", 67053, "ReqAnimalNPCInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67055 请求天怒神像信息
---请求天怒神像信息
---msgID: 67055
---@param npcId number 选填参数 npcId（唯一id）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSkyAngerGodInfo(npcId)
    local reqTable = {}
    if npcId ~= nil then
        reqTable.npcId = npcId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqSkyAngerGodInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSkyAngerGodInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSkyAngerGodInfoMessage](LuaEnumNetDef.ReqSkyAngerGodInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSkyAngerGodInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSkyAngerGodInfoMessage", 67055, "ReqSkyAngerGodInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67066 请求停止钓鱼
---请求停止钓鱼
---msgID: 67066
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStopFishing()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStopFishingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStopFishingMessage](LuaEnumNetDef.ReqStopFishingMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqStopFishingMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:67067 请求神医恢复
---请求神医恢复
---msgID: 67067
---@param moneyId number 选填参数 货币id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDoctorRecover(moneyId)
    local reqTable = {}
    if moneyId ~= nil then
        reqTable.moneyId = moneyId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqDoctorRecover" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDoctorRecoverMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDoctorRecoverMessage](LuaEnumNetDef.ReqDoctorRecoverMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDoctorRecoverMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDoctorRecoverMessage", 67067, "ReqDoctorRecover", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67070 请求玩家的仲裁信息
---请求玩家的仲裁信息
---msgID: 67070
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDropProtect()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDropProtectMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDropProtectMessage](LuaEnumNetDef.ReqDropProtectMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDropProtectMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:67072 掉落物品赎回
---掉落物品赎回
---msgID: 67072
---@param itemId number 选填参数 物品唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDropBuy(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.reqDropBuy" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDropBuyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDropBuyMessage](LuaEnumNetDef.ReqDropBuyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDropBuyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDropBuyMessage", 67072, "reqDropBuy", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67073 掉落物品领取奖励
---掉落物品领取奖励
---msgID: 67073
---@param itemId number 选填参数 物品唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPickUpAward(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.reqPickUpBuy" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPickUpAwardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPickUpAwardMessage](LuaEnumNetDef.ReqPickUpAwardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPickUpAwardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPickUpAwardMessage", 67073, "reqPickUpBuy", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67074 掉落物品无偿归还
---掉落物品无偿归还
---msgID: 67074
---@param itemId number 选填参数 物品唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDropReturn(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.reqDropReturn" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDropReturnMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDropReturnMessage](LuaEnumNetDef.ReqDropReturnMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDropReturnMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDropReturnMessage", 67074, "reqDropReturn", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67075 掉落物品归还领取
---掉落物品归还领取
---msgID: 67075
---@param itemId number 选填参数 物品唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDropReturnAward(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.reqDropReturnAward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDropReturnAwardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDropReturnAwardMessage](LuaEnumNetDef.ReqDropReturnAwardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDropReturnAwardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDropReturnAwardMessage", 67075, "reqDropReturnAward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67084 幻境副本领奖
---幻境副本领奖
---msgID: 67084
---@param npcLid number 选填参数 npc的唯一ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqNpcReceivePrize(npcLid)
    local reqTable = {}
    if npcLid ~= nil then
        reqTable.npcLid = npcLid
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqNpcReceivePrize" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqNpcReceivePrizeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqNpcReceivePrizeMessage](LuaEnumNetDef.ReqNpcReceivePrizeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqNpcReceivePrizeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqNpcReceivePrizeMessage", 67084, "ReqNpcReceivePrize", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67085 请求查看NPC上玩家的领取排行
---请求查看NPC上玩家的领取排行
---msgID: 67085
---@param npcLid number 选填参数 npc的唯一ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveRankingForNpc(npcLid)
    local reqTable = {}
    if npcLid ~= nil then
        reqTable.npcLid = npcLid
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqReceiveRankingForNpc" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveRankingForNpcMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveRankingForNpcMessage](LuaEnumNetDef.ReqReceiveRankingForNpcMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveRankingForNpcMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveRankingForNpcMessage", 67085, "ReqReceiveRankingForNpc", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67092 聊天框寻路小飞鞋传送处理
---聊天框寻路小飞鞋传送处理
---msgID: 67092
---@param mapId number 选填参数 目标地图ID
---@param x number 选填参数 目标X
---@param y number 选填参数 目标Y
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLocationDelivery(mapId, x, y)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqLocationDelivery" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLocationDeliveryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLocationDeliveryMessage](LuaEnumNetDef.ReqLocationDeliveryMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLocationDeliveryMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLocationDeliveryMessage", 67092, "ReqLocationDelivery", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67094 锁定怪物
---锁定怪物
---msgID: 67094
---@param monsterId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLockMonster(monsterId)
    local reqTable = {}
    reqTable.monsterId = monsterId
    local reqMsgData = protobufMgr.Serialize("mapV2.MonsterIdInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLockMonsterMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLockMonsterMessage](LuaEnumNetDef.ReqLockMonsterMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLockMonsterMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLockMonsterMessage", 67094, "MonsterIdInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67099 请求传送到千年树妖
---请求传送到千年树妖
---msgID: 67099
---@param mapId number 选填参数
---@param line number 选填参数
---@param pointX number 选填参数
---@param pointY number 选填参数
---@param StartTime number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeliverTreeMonster(mapId, line, pointX, pointY, StartTime)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if line ~= nil then
        reqTable.line = line
    end
    if pointX ~= nil then
        reqTable.pointX = pointX
    end
    if pointY ~= nil then
        reqTable.pointY = pointY
    end
    if StartTime ~= nil then
        reqTable.StartTime = StartTime
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.DeliverTreeMonsterInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeliverTreeMonsterMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeliverTreeMonsterMessage](LuaEnumNetDef.ReqDeliverTreeMonsterMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDeliverTreeMonsterMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDeliverTreeMonsterMessage", 67099, "DeliverTreeMonsterInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67102 请求魔之boss信息
---请求魔之boss信息
---msgID: 67102
---@param id number 选填参数 怪物的唯一ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDemonBossInfo(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqDemonBossInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDemonBossInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDemonBossInfoMessage](LuaEnumNetDef.ReqDemonBossInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDemonBossInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDemonBossInfoMessage", 67102, "ReqDemonBossInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67106 魔之请求拉令
---魔之请求拉令
---msgID: 67106
---@param id number 选填参数 怪物的唯一ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDemonBossHelp(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqDemonBossHelp" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDemonBossHelpMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDemonBossHelpMessage](LuaEnumNetDef.ReqDemonBossHelpMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDemonBossHelpMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDemonBossHelpMessage", 67106, "ReqDemonBossHelp", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67109 拉令传送
---拉令传送
---msgID: 67109
---@param mapId number 选填参数 拉令所在地图
---@param line number 选填参数 地图线
---@param x number 选填参数
---@param y number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAcceptDemonBossHelp(mapId, line, x, y)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if line ~= nil then
        reqTable.line = line
    end
    if x ~= nil then
        reqTable.x = x
    end
    if y ~= nil then
        reqTable.y = y
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqAcceptDemonBossHelp" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAcceptDemonBossHelpMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAcceptDemonBossHelpMessage](LuaEnumNetDef.ReqAcceptDemonBossHelpMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAcceptDemonBossHelpMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAcceptDemonBossHelpMessage", 67109, "ReqAcceptDemonBossHelp", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67111 请求领奖
---请求领奖
---msgID: 67111
---@param ownerId number 选填参数 所有者ID
---@param ownerUnionId number 选填参数 归属者的帮会ID
---@param monsterConfigId number 选填参数 怪物configId
---@param monsterLid number 选填参数 怪物唯一ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDemonDieCanReward(ownerId, ownerUnionId, monsterConfigId, monsterLid)
    local reqTable = {}
    if ownerId ~= nil then
        reqTable.ownerId = ownerId
    end
    if ownerUnionId ~= nil then
        reqTable.ownerUnionId = ownerUnionId
    end
    if monsterConfigId ~= nil then
        reqTable.monsterConfigId = monsterConfigId
    end
    if monsterLid ~= nil then
        reqTable.monsterLid = monsterLid
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqDemonDieCanReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDemonDieCanRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDemonDieCanRewardMessage](LuaEnumNetDef.ReqDemonDieCanRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDemonDieCanRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDemonDieCanRewardMessage", 67111, "ReqDemonDieCanReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67117 请求篝火信息
---请求篝火信息
---msgID: 67117
---@param lid number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBonfireInfo(lid)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.ReqBonfireInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBonfireInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBonfireInfoMessage](LuaEnumNetDef.ReqBonfireInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBonfireInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBonfireInfoMessage", 67117, "ReqBonfireInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67120 联服请求玩家的仲裁信息
---联服请求玩家的仲裁信息
---msgID: 67120
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareDropProtect()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareDropProtectMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareDropProtectMessage](LuaEnumNetDef.ReqShareDropProtectMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqShareDropProtectMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:67121 联服掉落物品赎回
---联服掉落物品赎回
---msgID: 67121
---@param itemId number 选填参数 物品唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareDropBuy(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.reqDropBuy" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareDropBuyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareDropBuyMessage](LuaEnumNetDef.ReqShareDropBuyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareDropBuyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareDropBuyMessage", 67121, "reqDropBuy", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67122 联服掉落物品领取奖励
---联服掉落物品领取奖励
---msgID: 67122
---@param itemId number 选填参数 物品唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSharePickUpAward(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.reqPickUpBuy" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSharePickUpAwardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSharePickUpAwardMessage](LuaEnumNetDef.ReqSharePickUpAwardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSharePickUpAwardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSharePickUpAwardMessage", 67122, "reqPickUpBuy", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67123 联服掉落物品无偿归还
---联服掉落物品无偿归还
---msgID: 67123
---@param itemId number 选填参数 物品唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareDropReturn(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.reqDropReturn" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareDropReturnMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareDropReturnMessage](LuaEnumNetDef.ReqShareDropReturnMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareDropReturnMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareDropReturnMessage", 67123, "reqDropReturn", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67124 联服掉落物品归还领取
---联服掉落物品归还领取
---msgID: 67124
---@param itemId number 选填参数 物品唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareDropReturnAward(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.reqDropReturnAward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareDropReturnAwardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareDropReturnAwardMessage](LuaEnumNetDef.ReqShareDropReturnAwardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareDropReturnAwardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareDropReturnAwardMessage", 67124, "reqDropReturnAward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:67126 拾取地图道具列表
---拾取地图道具列表
---msgID: 67126
---@param objId table<number> 列表参数 地面道具的唯一id
---@param time number 选填参数 客户端拾取的时间戳
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPickUpMapItems(objId, time)
    local reqTable = {}
    if objId ~= nil then
        reqTable.objId = objId
    else
        reqTable.objId = {}
    end
    if time ~= nil then
        reqTable.time = time
    end
    local reqMsgData = protobufMgr.Serialize("mapV2.PickUpMapItemsRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPickUpMapItemsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPickUpMapItemsMessage](LuaEnumNetDef.ReqPickUpMapItemsMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPickUpMapItemsMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPickUpMapItemsMessage", 67126, "PickUpMapItemsRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

