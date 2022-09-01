--[[本文件为工具自动生成,禁止手动修改]]
--uniteunion.xml

--region ID:1002002 申请加入同盟
---申请加入同盟
---msgID: 1002002
---@param type number 选填参数 同盟类型 1,2,3,4
---@return boolean 网络请求是否成功发送
function networkRequest.ReqApplyJoinUniteUnion(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("uniteunionV2.UniteUnionType" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqApplyJoinUniteUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqApplyJoinUniteUnionMessage](LuaEnumNetDef.ReqApplyJoinUniteUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqApplyJoinUniteUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqApplyJoinUniteUnionMessage", 1002002, "UniteUnionType", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1002003 申请退出同盟
---申请退出同盟
---msgID: 1002003
---@param type number 选填参数 同盟类型 1,2,3,4
---@return boolean 网络请求是否成功发送
function networkRequest.ReqApplyExitUniteUnion(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("uniteunionV2.UniteUnionType" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqApplyExitUniteUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqApplyExitUniteUnionMessage](LuaEnumNetDef.ReqApplyExitUniteUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqApplyExitUniteUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqApplyExitUniteUnionMessage", 1002003, "UniteUnionType", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1002004 请求某个同盟
---请求某个同盟
---msgID: 1002004
---@param type number 选填参数 同盟类型 1,2,3,4
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOneUniteUnion(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("uniteunionV2.UniteUnionType" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOneUniteUnionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOneUniteUnionMessage](LuaEnumNetDef.ReqOneUniteUnionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOneUniteUnionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOneUniteUnionMessage", 1002004, "UniteUnionType", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1002007 请求封印塔联盟排行
---请求封印塔联盟排行
---msgID: 1002007
---@param uniteUnionType number 选填参数 同盟类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUniteUnionSealTowerRank(uniteUnionType)
    local reqTable = {}
    if uniteUnionType ~= nil then
        reqTable.uniteUnionType = uniteUnionType
    end
    local reqMsgData = protobufMgr.Serialize("uniteunionV2.ReqUniteUnionSealTowerRank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUniteUnionSealTowerRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUniteUnionSealTowerRankMessage](LuaEnumNetDef.ReqUniteUnionSealTowerRankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUniteUnionSealTowerRankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUniteUnionSealTowerRankMessage", 1002007, "ReqUniteUnionSealTowerRank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1002008 请求封印塔捐献
---请求封印塔捐献
---msgID: 1002008
---@param type number 选填参数 捐献type
---@param count number 选填参数 捐献次数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSealTowerDonation(type, count)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("uniteunionV2.ReqSealTowerDonation" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSealTowerDonationMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSealTowerDonationMessage](LuaEnumNetDef.ReqSealTowerDonationMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSealTowerDonationMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSealTowerDonationMessage", 1002008, "ReqSealTowerDonation", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1002010 请求前往击杀封印塔怪物
---请求前往击杀封印塔怪物
---msgID: 1002010
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetSealTowerMonsterPoint()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetSealTowerMonsterPointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetSealTowerMonsterPointMessage](LuaEnumNetDef.ReqGetSealTowerMonsterPointMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetSealTowerMonsterPointMessage, nil, true)
    end
    return canSendMsg
end
--endregion

