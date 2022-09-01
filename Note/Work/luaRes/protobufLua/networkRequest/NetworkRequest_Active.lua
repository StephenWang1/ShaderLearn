--[[本文件为工具自动生成,禁止手动修改]]
--active.xml

--region ID:108002 领取活跃度奖励请求
---领取活跃度奖励请求
---msgID: 108002
---@param id number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetActiveRewards(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("activeV2.GetActiveRewardRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetActiveRewardsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetActiveRewardsMessage](LuaEnumNetDef.ReqGetActiveRewardsMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetActiveRewardsMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetActiveRewardsMessage", 108002, "GetActiveRewardRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:108003 完成活跃度请求
---完成活跃度请求
---msgID: 108003
---@param id number 选填参数 配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetActiveComplete(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    end
    local reqMsgData = protobufMgr.Serialize("activeV2.GetActiveCompleteRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetActiveCompleteMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetActiveCompleteMessage](LuaEnumNetDef.ReqGetActiveCompleteMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetActiveCompleteMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetActiveCompleteMessage", 108003, "GetActiveCompleteRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

