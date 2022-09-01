--[[本文件为工具自动生成,禁止手动修改]]
--zhenfa.xml

--region ID:131001 请求阵法信息
---请求阵法信息
---msgID: 131001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqZhenfaInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqZhenfaInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqZhenfaInfoMessage](LuaEnumNetDef.ReqZhenfaInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqZhenfaInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:131003 请求培养阵法
---请求培养阵法
---msgID: 131003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpgradeZhenfa()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpgradeZhenfaMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpgradeZhenfaMessage](LuaEnumNetDef.ReqUpgradeZhenfaMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUpgradeZhenfaMessage, nil, true)
    end
    return canSendMsg
end
--endregion

