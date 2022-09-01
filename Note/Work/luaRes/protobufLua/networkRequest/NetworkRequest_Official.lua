--[[本文件为工具自动生成,禁止手动修改]]
--official.xml

--region ID:56002 请求官职晋升
---请求官职晋升
---msgID: 56002
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOfficialUp()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOfficialUpMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOfficialUpMessage](LuaEnumNetDef.ReqOfficialUpMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOfficialUpMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:56004 请求领取日活奖励
---请求领取日活奖励
---msgID: 56004
---@param rewardId number 选填参数 奖励id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawDailyActiveReward(rewardId)
    local reqTable = {}
    if rewardId ~= nil then
        reqTable.rewardId = rewardId
    end
    local reqMsgData = protobufMgr.Serialize("officialV2.ReqDrawDailyActiveReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawDailyActiveRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawDailyActiveRewardMessage](LuaEnumNetDef.ReqDrawDailyActiveRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawDailyActiveRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawDailyActiveRewardMessage", 56004, "ReqDrawDailyActiveReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:56006 请求领取日常任务完成奖励
---请求领取日常任务完成奖励
---msgID: 56006
---@param taskId number 选填参数 任务id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawDailyTaskReward(taskId)
    local reqTable = {}
    if taskId ~= nil then
        reqTable.taskId = taskId
    end
    local reqMsgData = protobufMgr.Serialize("officialV2.ReqDrawDailyTaskReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawDailyTaskRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawDailyTaskRewardMessage](LuaEnumNetDef.ReqDrawDailyTaskRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawDailyTaskRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawDailyTaskRewardMessage", 56006, "ReqDrawDailyTaskReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:56012 升级官职
---升级官职
---msgID: 56012
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOfficialUpgradeV2()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOfficialUpgradeV2Message] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOfficialUpgradeV2Message](LuaEnumNetDef.ReqOfficialUpgradeV2Message, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOfficialUpgradeV2Message, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:56013 激活虎符
---激活虎符
---msgID: 56013
---@param emperorTokenId number 必填参数 激活虎符.
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOfficialEmperorTokenActivateV2(emperorTokenId)
    local reqTable = {}
    reqTable.emperorTokenId = emperorTokenId
    local reqMsgData = protobufMgr.Serialize("officialV2.ReqOfficialEmperorTokenActivateV2" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOfficialEmperorTokenActivateV2Message] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOfficialEmperorTokenActivateV2Message](LuaEnumNetDef.ReqOfficialEmperorTokenActivateV2Message, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOfficialEmperorTokenActivateV2Message, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOfficialEmperorTokenActivateV2Message", 56013, "ReqOfficialEmperorTokenActivateV2", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

