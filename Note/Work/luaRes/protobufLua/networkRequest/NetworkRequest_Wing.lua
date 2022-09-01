--[[本文件为工具自动生成,禁止手动修改]]
--wing.xml

--region ID:18001 请求光翼信息
---请求光翼信息
---msgID: 18001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqWingInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqWingInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqWingInfoMessage](LuaEnumNetDef.ReqWingInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqWingInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:18003 请求升级光翼
---请求升级光翼
---msgID: 18003
---@param autoUseMoney number 选填参数 是否自动使用元宝购买羽毛 1自动/ 0不
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLevelUpWing(autoUseMoney)
    local reqTable = {}
    if autoUseMoney ~= nil then
        reqTable.autoUseMoney = autoUseMoney
    end
    local reqMsgData = protobufMgr.Serialize("wingV2.ReqLevelUpWing" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLevelUpWingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLevelUpWingMessage](LuaEnumNetDef.ReqLevelUpWingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLevelUpWingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLevelUpWingMessage", 18003, "ReqLevelUpWing", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

