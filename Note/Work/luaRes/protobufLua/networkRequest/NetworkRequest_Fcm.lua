--[[本文件为工具自动生成,禁止手动修改]]
--fcm.xml

--region ID:34002 请求认证
---请求认证
---msgID: 34002
---@param name string 选填参数 名字
---@param idNumber string 选填参数 身份证号
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAuthority(name, idNumber)
    local reqTable = {}
    if name ~= nil then
        reqTable.name = name
    end
    if idNumber ~= nil then
        reqTable.idNumber = idNumber
    end
    local reqMsgData = protobufMgr.Serialize("fcmV2.ReqAuthority" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAuthorityMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAuthorityMessage](LuaEnumNetDef.ReqAuthorityMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAuthorityMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAuthorityMessage", 34002, "ReqAuthority", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

