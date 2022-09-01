--[[本文件为工具自动生成,禁止手动修改]]
--rank.xml

--region ID:26001 请求查看排行榜
---请求查看排行榜
---msgID: 26001
---@param rankId number 选填参数 rankConfig id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLookRank(rankId)
    local reqTable = {}
    if rankId ~= nil then
        reqTable.rankId = rankId
    end
    local reqMsgData = protobufMgr.Serialize("rankV2.ReqLookRank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLookRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLookRankMessage](LuaEnumNetDef.ReqLookRankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLookRankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLookRankMessage", 26001, "ReqLookRank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:26003 请求排行奖励信息
---请求排行奖励信息
---msgID: 26003
---@param rankId number 选填参数 rankConfig id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRankRewardInfo(rankId)
    local reqTable = {}
    if rankId ~= nil then
        reqTable.rankId = rankId
    end
    local reqMsgData = protobufMgr.Serialize("rankV2.ReqRankRewardInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRankRewardInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRankRewardInfoMessage](LuaEnumNetDef.ReqRankRewardInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRankRewardInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRankRewardInfoMessage", 26003, "ReqRankRewardInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:26005 领取排行奖励
---领取排行奖励
---msgID: 26005
---@param rankId number 选填参数 rankConfig id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveReward(rankId)
    local reqTable = {}
    if rankId ~= nil then
        reqTable.rankId = rankId
    end
    local reqMsgData = protobufMgr.Serialize("rankV2.ReqReceiveReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveRewardMessage](LuaEnumNetDef.ReqReceiveRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveRewardMessage", 26005, "ReqReceiveReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:26007 请求排行榜详情
---请求排行榜详情
---msgID: 26007
---@param rankId number 选填参数 rankConfig id
---@param rid number 选填参数 玩家唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRankDetail(rankId, rid)
    local reqTable = {}
    if rankId ~= nil then
        reqTable.rankId = rankId
    end
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("rankV2.ReqRankDetail" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRankDetailMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRankDetailMessage](LuaEnumNetDef.ReqRankDetailMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRankDetailMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRankDetailMessage", 26007, "ReqRankDetail", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:26009 共享服请求查看排行榜
---共享服请求查看排行榜
---msgID: 26009
---@param rankId number 选填参数 rankConfig id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShareLookRank(rankId)
    local reqTable = {}
    if rankId ~= nil then
        reqTable.rankId = rankId
    end
    local reqMsgData = protobufMgr.Serialize("rankV2.ReqLookRank" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShareLookRankMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShareLookRankMessage](LuaEnumNetDef.ReqShareLookRankMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShareLookRankMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShareLookRankMessage", 26009, "ReqLookRank", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

