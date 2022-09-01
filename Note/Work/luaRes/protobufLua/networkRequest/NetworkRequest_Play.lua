--[[本文件为工具自动生成,禁止手动修改]]
--play.xml

--region ID:73002 请求领取野外boss掉落
---请求领取野外boss掉落
---msgID: 73002
---@param mapId number 选填参数 boss地图Id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRewardWorldBoss(mapId)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    local reqMsgData = protobufMgr.Serialize("playV2.ReqRewardWorldBoss" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRewardWorldBossMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRewardWorldBossMessage](LuaEnumNetDef.ReqRewardWorldBossMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRewardWorldBossMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRewardWorldBossMessage", 73002, "ReqRewardWorldBoss", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:73003 请求进入玩法地图
---请求进入玩法地图
---msgID: 73003
---@param mapId number 选填参数 地图id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEnterPlayMap(mapId)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    local reqMsgData = protobufMgr.Serialize("playV2.ReqEnterPlayMap" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEnterPlayMapMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEnterPlayMapMessage](LuaEnumNetDef.ReqEnterPlayMapMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEnterPlayMapMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEnterPlayMapMessage", 73003, "ReqEnterPlayMap", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:73006 请求roll点
---请求roll点
---msgID: 73006
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRollPoint()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRollPointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRollPointMessage](LuaEnumNetDef.ReqRollPointMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRollPointMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:73009 请求对应类型boss的状态
---请求对应类型boss的状态
---msgID: 73009
---@param mapType number 选填参数 boss类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFetchWorldBossState(mapType)
    local reqTable = {}
    if mapType ~= nil then
        reqTable.mapType = mapType
    end
    local reqMsgData = protobufMgr.Serialize("playV2.ReqFetchWorldBossState" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFetchWorldBossStateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFetchWorldBossStateMessage](LuaEnumNetDef.ReqFetchWorldBossStateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqFetchWorldBossStateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqFetchWorldBossStateMessage", 73009, "ReqFetchWorldBossState", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:73011 请求使用战役道具
---请求使用战役道具
---msgID: 73011
---@param globalId number 选填参数 globalId(35/36)
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseFightItem(globalId)
    local reqTable = {}
    if globalId ~= nil then
        reqTable.globalId = globalId
    end
    local reqMsgData = protobufMgr.Serialize("playV2.ReqUseFightItem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseFightItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseFightItemMessage](LuaEnumNetDef.ReqUseFightItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseFightItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseFightItemMessage", 73011, "ReqUseFightItem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:73014 请求设置Boss提醒
---请求设置Boss提醒
---msgID: 73014
---@param mapId number 选填参数 boss地图id
---@param state number 选填参数 状态 0未勾选 1勾选
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSetBossRemind(mapId, state)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if state ~= nil then
        reqTable.state = state
    end
    local reqMsgData = protobufMgr.Serialize("playV2.ReqSetBossRemind" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSetBossRemindMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSetBossRemindMessage](LuaEnumNetDef.ReqSetBossRemindMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSetBossRemindMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSetBossRemindMessage", 73014, "ReqSetBossRemind", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:73017 请求使用道具次数信息
---请求使用道具次数信息
---msgID: 73017
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseFightItemInfos()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseFightItemInfosMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseFightItemInfosMessage](LuaEnumNetDef.ReqUseFightItemInfosMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUseFightItemInfosMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:73020 请求购买次数
---请求购买次数
---msgID: 73020
---@param type number 选填参数 购买类型 1 挑战次数 2 归属者领奖次数 3 协助领奖次数
---@param mapId number 选填参数 地图id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyCount(type, mapId)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    local reqMsgData = protobufMgr.Serialize("playV2.ReqBuyCount" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyCountMessage](LuaEnumNetDef.ReqBuyCountMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyCountMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyCountMessage", 73020, "ReqBuyCount", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:73023 客户端请求通用消息
---客户端请求通用消息
---msgID: 73023
---@param type number 选填参数
---@param data number 选填参数
---@param str string 选填参数
---@param data64 number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCommon(type, data, str, data64)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if data ~= nil then
        reqTable.data = data
    end
    if str ~= nil then
        reqTable.str = str
    end
    if data64 ~= nil then
        reqTable.data64 = data64
    end
    local reqMsgData = protobufMgr.Serialize("playV2.CommonInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCommonMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCommonMessage](LuaEnumNetDef.ReqCommonMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCommonMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCommonMessage", 73023, "CommonInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:73024 客户端请求地图通用消息
---客户端请求地图通用消息
---msgID: 73024
---@param type number 选填参数
---@param data number 选填参数
---@param str string 选填参数
---@param data64 number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMapCommon(type, data, str, data64)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if data ~= nil then
        reqTable.data = data
    end
    if str ~= nil then
        reqTable.str = str
    end
    if data64 ~= nil then
        reqTable.data64 = data64
    end
    local reqMsgData = protobufMgr.Serialize("playV2.CommonInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMapCommonMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMapCommonMessage](LuaEnumNetDef.ReqMapCommonMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMapCommonMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMapCommonMessage", 73024, "CommonInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:73028 今日不在提醒
---今日不在提醒
---msgID: 73028
---@param activityType number 选填参数 当前活动类型
---@return boolean 网络请求是否成功发送
function networkRequest.TodayNoReminder(activityType)
    local reqTable = {}
    if activityType ~= nil then
        reqTable.activityType = activityType
    end
    local reqMsgData = protobufMgr.Serialize("playV2.TodayNoReminder" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.TodayNoReminderMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.TodayNoReminderMessage](LuaEnumNetDef.TodayNoReminderMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.TodayNoReminderMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("TodayNoReminderMessage", 73028, "TodayNoReminder", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

