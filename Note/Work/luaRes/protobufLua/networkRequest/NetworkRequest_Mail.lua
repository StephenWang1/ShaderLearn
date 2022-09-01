--[[本文件为工具自动生成,禁止手动修改]]
--mail.xml

--region ID:36001 获取邮件列表请求
---获取邮件列表请求
---msgID: 36001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetMailList()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetMailListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetMailListMessage](LuaEnumNetDef.ReqGetMailListMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetMailListMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:36004 标记为已读请求
---标记为已读请求
---msgID: 36004
---@param mailIds System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReadMail(mailIds)
    local reqData = CS.mailV2.MailIdMsg()
    if mailIds ~= nil then
        reqData.mailIds:AddRange(mailIds)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReadMailMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReadMailMessage](LuaEnumNetDef.ReqReadMailMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqReadMailMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:36005 提取物品请求
---提取物品请求
---msgID: 36005
---@param mailIds System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetMailItem(mailIds)
    local reqData = CS.mailV2.MailIdMsg()
    if mailIds ~= nil then
        reqData.mailIds:AddRange(mailIds)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetMailItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetMailItemMessage](LuaEnumNetDef.ReqGetMailItemMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetMailItemMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:36007 删除邮件请求
---删除邮件请求
---msgID: 36007
---@param mailIds System.Collections.Generic.List1T<number> 列表参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeleteMail(mailIds)
    local reqData = CS.mailV2.MailIdMsg()
    if mailIds ~= nil then
        reqData.mailIds:AddRange(mailIds)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeleteMailMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeleteMailMessage](LuaEnumNetDef.ReqDeleteMailMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqDeleteMailMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

