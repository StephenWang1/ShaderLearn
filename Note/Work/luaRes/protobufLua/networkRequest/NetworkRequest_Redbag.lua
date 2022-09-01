--[[本文件为工具自动生成,禁止手动修改]]
--redbag.xml

--region ID:109001 发送红包请求
---发送红包请求
---msgID: 109001
---@param money number 必填参数 金钱，如果是红包券，当前值为数量
---@param isTicket boolean 选填参数 是否使用红包券
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSendRedBag(money, isTicket)
    local reqTable = {}
    reqTable.money = money
    if isTicket ~= nil then
        reqTable.isTicket = isTicket
    end
    local reqMsgData = protobufMgr.Serialize("redbagV2.RedBagDonateRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSendRedBagMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSendRedBagMessage](LuaEnumNetDef.ReqSendRedBagMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSendRedBagMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSendRedBagMessage", 109001, "RedBagDonateRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:109003 领取红包请求
---领取红包请求
---msgID: 109003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRedBag()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRedBagMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRedBagMessage](LuaEnumNetDef.ReqGetRedBagMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetRedBagMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:109004 红包信息请求
---红包信息请求
---msgID: 109004
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRedBagInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRedBagInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRedBagInfoMessage](LuaEnumNetDef.ReqRedBagInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRedBagInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

