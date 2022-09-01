--[[本文件为工具自动生成,禁止手动修改]]
--cart.xml

--region ID:105001 请求镖师面板
---请求镖师面板
---msgID: 105001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBodyGuardInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBodyGuardInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBodyGuardInfoMessage](LuaEnumNetDef.ReqBodyGuardInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqBodyGuardInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:105003 请求参与押镖
---请求参与押镖
---msgID: 105003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqJoinUnionCart()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqJoinUnionCartMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqJoinUnionCartMessage](LuaEnumNetDef.ReqJoinUnionCartMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqJoinUnionCartMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:105004 请求退出押镖
---请求退出押镖
---msgID: 105004
---@return boolean 网络请求是否成功发送
function networkRequest.ReqWithdrawUnionCart()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqWithdrawUnionCartMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqWithdrawUnionCartMessage](LuaEnumNetDef.ReqWithdrawUnionCartMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqWithdrawUnionCartMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:105008 请求个人押镖列表
---请求个人押镖列表
---msgID: 105008
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPersonalCartList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPersonalCartListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPersonalCartListMessage](LuaEnumNetDef.ReqPersonalCartListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqPersonalCartListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:105011 请求押镖
---请求押镖
---msgID: 105011
---@param cfgId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEscortCart(cfgId)
    local reqTable = {}
    if cfgId ~= nil then
        reqTable.cfgId = cfgId
    end
    local reqMsgData = protobufMgr.Serialize("cartV2.ReqEscortCart" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEscortCartMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEscortCartMessage](LuaEnumNetDef.ReqEscortCartMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEscortCartMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEscortCartMessage", 105011, "ReqEscortCart", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:105013 请求领取押镖奖励
---请求领取押镖奖励
---msgID: 105013
---@param id number 选填参数 要领取的id
---@param bei number 选填参数 领取倍数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceivePersonalCartReward(id, bei)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    if bei ~= nil then
        reqTable.bei = bei
    end
    local reqMsgData = protobufMgr.Serialize("cartV2.ReqReceiveReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceivePersonalCartRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceivePersonalCartRewardMessage](LuaEnumNetDef.ReqReceivePersonalCartRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceivePersonalCartRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceivePersonalCartRewardMessage", 105013, "ReqReceiveReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:105016 请求行会押镖排行
---请求行会押镖排行
---msgID: 105016
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionCartRank()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionCartRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionCartRankMessage](LuaEnumNetDef.ReqUnionCartRankMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUnionCartRankMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:105018 请求行会押镖上次活动排行
---请求行会押镖上次活动排行
---msgID: 105018
---@param index number 必填参数 1 上次, 2 上上次, 以此类推
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnionCartLastRank(index)
    local reqTable = {}
    reqTable.index = index
    local reqMsgData = protobufMgr.Serialize("cartV2.ReqUnionCartRankRecord" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnionCartLastRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnionCartLastRankMessage](LuaEnumNetDef.ReqUnionCartLastRankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnionCartLastRankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnionCartLastRankMessage", 105018, "ReqUnionCartRankRecord", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:105020 请求个人镖车坐标
---请求个人镖车坐标
---msgID: 105020
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPersonalCartPosition(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("cartV2.ReqPersonalCartPosition" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPersonalCartPositionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPersonalCartPositionMessage](LuaEnumNetDef.ReqPersonalCartPositionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPersonalCartPositionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPersonalCartPositionMessage", 105020, "ReqPersonalCartPosition", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:105022 请求开始运货押镖
---请求开始运货押镖
---msgID: 105022
---@param carConfigId number 选填参数 要创建车的表ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStartFreightCar(carConfigId)
    local reqTable = {}
    if carConfigId ~= nil then
        reqTable.carConfigId = carConfigId
    end
    local reqMsgData = protobufMgr.Serialize("cartV2.ReqStartFreightCar" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStartFreightCarMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStartFreightCarMessage](LuaEnumNetDef.ReqStartFreightCarMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqStartFreightCarMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqStartFreightCarMessage", 105022, "ReqStartFreightCar", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:105025 请求放弃押镖
---请求放弃押镖
---msgID: 105025
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGiveUpFreightCar()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGiveUpFreightCarMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGiveUpFreightCarMessage](LuaEnumNetDef.ReqGiveUpFreightCarMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGiveUpFreightCarMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:105029 请求个人玩家押镖运货信息
---请求个人玩家押镖运货信息
---msgID: 105029
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRoleFreightCarInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRoleFreightCarInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRoleFreightCarInfoMessage](LuaEnumNetDef.ReqGetRoleFreightCarInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetRoleFreightCarInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

