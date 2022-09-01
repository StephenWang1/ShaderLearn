--[[本文件为工具自动生成,禁止手动修改]]
--marry.xml

--region ID:114001 请求结婚
---请求结婚
---msgID: 114001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMarry()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMarryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMarryMessage](LuaEnumNetDef.ReqMarryMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqMarryMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114004 确认誓言
---确认誓言
---msgID: 114004
---@param matchmaker string 选填参数 誓言
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMatchmaker(matchmaker)
    local reqTable = {}
    if matchmaker ~= nil then
        reqTable.matchmaker = matchmaker
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqMatchmaker" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMatchmakerMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMatchmakerMessage](LuaEnumNetDef.ReqMatchmakerMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMatchmakerMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMatchmakerMessage", 114004, "ReqMatchmaker", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:114007 请求中断结婚
---请求中断结婚
---msgID: 114007
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInterruptMarry()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInterruptMarryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInterruptMarryMessage](LuaEnumNetDef.ReqInterruptMarryMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqInterruptMarryMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114009 请求升级婚戒
---请求升级婚戒
---msgID: 114009
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpdateRing()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpdateRingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpdateRingMessage](LuaEnumNetDef.ReqUpdateRingMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUpdateRingMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114010 请求离婚
---请求离婚
---msgID: 114010
---@param divorceType number 选填参数 离婚类型 0正常申请离婚 1强制离婚
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDivorce(divorceType)
    local reqTable = {}
    if divorceType ~= nil then
        reqTable.divorceType = divorceType
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqDivorce" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDivorceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDivorceMessage](LuaEnumNetDef.ReqDivorceMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDivorceMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDivorceMessage", 114010, "ReqDivorce", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:114013 请求执行离婚
---请求执行离婚
---msgID: 114013
---@param type number 选填参数 离婚类型 0普通强制  1收费强制  2在线离婚
---@return boolean 网络请求是否成功发送
function networkRequest.ReqImplementDivorce(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqImplementDivorce" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqImplementDivorceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqImplementDivorceMessage](LuaEnumNetDef.ReqImplementDivorceMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqImplementDivorceMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqImplementDivorceMessage", 114013, "ReqImplementDivorce", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:114015 请求中断离婚
---请求中断离婚
---msgID: 114015
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInterruptDivorce()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInterruptDivorceMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInterruptDivorceMessage](LuaEnumNetDef.ReqInterruptDivorceMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqInterruptDivorceMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114019 请求悔婚
---请求悔婚
---msgID: 114019
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRegretMarriage()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRegretMarriageMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRegretMarriageMessage](LuaEnumNetDef.ReqRegretMarriageMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRegretMarriageMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114021 确认悔婚消息
---确认悔婚消息
---msgID: 114021
---@return boolean 网络请求是否成功发送
function networkRequest.ReqConfirmRegretMarriage()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqConfirmRegretMarriageMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqConfirmRegretMarriageMessage](LuaEnumNetDef.ReqConfirmRegretMarriageMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqConfirmRegretMarriageMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114022 请求中断中断悔婚
---请求中断中断悔婚
---msgID: 114022
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInterruptRegretMarriage()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInterruptRegretMarriageMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInterruptRegretMarriageMessage](LuaEnumNetDef.ReqInterruptRegretMarriageMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqInterruptRegretMarriageMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114026 请求查看誓言
---请求查看誓言
---msgID: 114026
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSeeOath()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSeeOathMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSeeOathMessage](LuaEnumNetDef.ReqSeeOathMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSeeOathMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114028 请求修改誓言
---请求修改誓言
---msgID: 114028
---@param matchmaker string 选填参数 誓言
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpdateOath(matchmaker)
    local reqTable = {}
    if matchmaker ~= nil then
        reqTable.matchmaker = matchmaker
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqUpdateOath" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpdateOathMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpdateOathMessage](LuaEnumNetDef.ReqUpdateOathMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpdateOathMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpdateOathMessage", 114028, "ReqUpdateOath", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:114029 请求查看刻字
---请求查看刻字
---msgID: 114029
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSeeLettering()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSeeLetteringMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSeeLetteringMessage](LuaEnumNetDef.ReqSeeLetteringMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSeeLetteringMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114031 请求修改刻字
---请求修改刻字
---msgID: 114031
---@param lettering string 选填参数 刻字
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpdateLettering(lettering)
    local reqTable = {}
    if lettering ~= nil then
        reqTable.lettering = lettering
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqUpdateLettering" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpdateLetteringMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpdateLetteringMessage](LuaEnumNetDef.ReqUpdateLetteringMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpdateLetteringMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpdateLetteringMessage", 114031, "ReqUpdateLettering", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:114032 输入完成誓言判断屏蔽字
---输入完成誓言判断屏蔽字
---msgID: 114032
---@param matchmaker string 选填参数 誓言
---@return boolean 网络请求是否成功发送
function networkRequest.ReqVerificationOath(matchmaker)
    local reqTable = {}
    if matchmaker ~= nil then
        reqTable.matchmaker = matchmaker
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqVerificationOath" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqVerificationOathMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqVerificationOathMessage](LuaEnumNetDef.ReqVerificationOathMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqVerificationOathMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqVerificationOathMessage", 114032, "ReqVerificationOath", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:114033 请求判断刻字屏蔽字
---请求判断刻字屏蔽字
---msgID: 114033
---@param lettering string 选填参数 刻字
---@return boolean 网络请求是否成功发送
function networkRequest.ReqVerificationLettering(lettering)
    local reqTable = {}
    if lettering ~= nil then
        reqTable.lettering = lettering
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqVerificationLettering" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqVerificationLetteringMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqVerificationLetteringMessage](LuaEnumNetDef.ReqVerificationLetteringMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqVerificationLetteringMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqVerificationLetteringMessage", 114033, "ReqVerificationLettering", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:114034 请求赠送钻石
---请求赠送钻石
---msgID: 114034
---@param count number 选填参数 赠送的钻石数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGiveJewel(count)
    local reqTable = {}
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqGiveJewel" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGiveJewelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGiveJewelMessage](LuaEnumNetDef.ReqGiveJewelMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGiveJewelMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGiveJewelMessage", 114034, "ReqGiveJewel", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:114036 离婚时间到了清空数据
---离婚时间到了清空数据
---msgID: 114036
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCleanMarry()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCleanMarryMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCleanMarryMessage](LuaEnumNetDef.ReqCleanMarryMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCleanMarryMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:114037 请求查看其他玩家婚姻信息
---请求查看其他玩家婚姻信息
---msgID: 114037
---@param rid number 选填参数 要查看的玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSeeOthersMarriageInfo(rid)
    local reqTable = {}
    if rid ~= nil then
        reqTable.rid = rid
    end
    local reqMsgData = protobufMgr.Serialize("marryV2.ReqSeeOthersMarriageInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSeeOthersMarriageInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSeeOthersMarriageInfoMessage](LuaEnumNetDef.ReqSeeOthersMarriageInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSeeOthersMarriageInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSeeOthersMarriageInfoMessage", 114037, "ReqSeeOthersMarriageInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

