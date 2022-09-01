--[[本文件为工具自动生成,禁止手动修改]]
--sealmark.xml

--region ID:85001 请求当前封号等级
---请求当前封号等级
---msgID: 85001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSealMarkInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSealMarkInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSealMarkInfoMessage](LuaEnumNetDef.ReqSealMarkInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSealMarkInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:85003 请求升级封号等级
---请求升级封号等级
---msgID: 85003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpgradeSealMark()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpgradeSealMarkMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpgradeSealMarkMessage](LuaEnumNetDef.ReqUpgradeSealMarkMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUpgradeSealMarkMessage, nil, true)
    end
    return canSendMsg
end
--endregion

