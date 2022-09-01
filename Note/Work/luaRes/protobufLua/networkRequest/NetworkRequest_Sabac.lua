--[[本文件为工具自动生成,禁止手动修改]]
--sabac.xml

--region ID:129001 请求排行榜
---请求排行榜
---msgID: 129001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSabacDonateRankInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSabacDonateRankInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSabacDonateRankInfoMessage](LuaEnumNetDef.ReqSabacDonateRankInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSabacDonateRankInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:129003 请求捐献
---请求捐献
---msgID: 129003
---@param donate number 必填参数 捐献的钻石.
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSabacDonate(donate)
    local reqTable = {}
    reqTable.donate = donate
    local reqMsgData = protobufMgr.Serialize("sabacV2.ReqSabacDonate" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSabacDonateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSabacDonateMessage](LuaEnumNetDef.ReqSabacDonateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSabacDonateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSabacDonateMessage", 129003, "ReqSabacDonate", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

