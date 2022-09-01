--[[本文件为工具自动生成,禁止手动修改]]
--tower.xml

--region ID:54002 请求通天塔面板信息
---请求通天塔面板信息
---msgID: 54002
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRoleTowerInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRoleTowerInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRoleTowerInfoMessage](LuaEnumNetDef.ReqRoleTowerInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRoleTowerInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

