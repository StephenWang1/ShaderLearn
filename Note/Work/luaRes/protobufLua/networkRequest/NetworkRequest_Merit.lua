--[[本文件为工具自动生成,禁止手动修改]]
--merit.xml

--region ID:122001 请求霸业活动数据
---请求霸业活动数据
---msgID: 122001
---@param type number 选填参数 活动类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetMeritData(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("meritV2.ReqGetMeritData" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetMeritDataMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetMeritDataMessage](LuaEnumNetDef.ReqGetMeritDataMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetMeritDataMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetMeritDataMessage", 122001, "ReqGetMeritData", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:122006 请求领奖行会之争
---请求领奖行会之争
---msgID: 122006
---@param unionId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRewardUinonBattle(unionId)
    local reqTable = {}
    if unionId ~= nil then
        reqTable.unionId = unionId
    end
    local reqMsgData = protobufMgr.Serialize("meritV2.ReqRewardUinonBattle" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRewardUinonBattleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRewardUinonBattleMessage](LuaEnumNetDef.ReqRewardUinonBattleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRewardUinonBattleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRewardUinonBattleMessage", 122006, "ReqRewardUinonBattle", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:122007 请求领奖领袖之路
---请求领奖领袖之路
---msgID: 122007
---@param id number 选填参数 领袖之路放overlord_reward_two的ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRewardLeaderGlory(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("meritV2.ReqRewardLeaderGlory" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRewardLeaderGloryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRewardLeaderGloryMessage](LuaEnumNetDef.ReqRewardLeaderGloryMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRewardLeaderGloryMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRewardLeaderGloryMessage", 122007, "ReqRewardLeaderGlory", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:122008 请求领奖建功立业
---请求领奖建功立业
---msgID: 122008
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRewardUnionAchievement(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("meritV2.ReqRewardUnionAchievement" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRewardUnionAchievementMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRewardUnionAchievementMessage](LuaEnumNetDef.ReqRewardUnionAchievementMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRewardUnionAchievementMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRewardUnionAchievementMessage", 122008, "ReqRewardUnionAchievement", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:122010 请求领袖之路小面板
---请求领袖之路小面板
---msgID: 122010
---@param subtype number 选填参数 对应的subtype
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPositionInfo(subtype)
    local reqTable = {}
    if subtype ~= nil then
        reqTable.subtype = subtype
    end
    local reqMsgData = protobufMgr.Serialize("meritV2.ReqPositionInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPositionInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPositionInfoMessage](LuaEnumNetDef.ReqPositionInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPositionInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPositionInfoMessage", 122010, "ReqPositionInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

