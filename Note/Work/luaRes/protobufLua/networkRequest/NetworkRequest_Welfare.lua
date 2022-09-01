--[[本文件为工具自动生成,禁止手动修改]]
--welfare.xml

--region ID:27001 请求签到信息
---请求签到信息
---msgID: 27001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSignInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSignInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSignInfoMessage](LuaEnumNetDef.ReqSignInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSignInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:27003 请求签到领奖
---请求签到领奖
---msgID: 27003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetSignReward()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetSignRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetSignRewardMessage](LuaEnumNetDef.ReqGetSignRewardMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetSignRewardMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:27004 请求cdkey领奖
---请求cdkey领奖
---msgID: 27004
---@param cdkey string 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCdkeyReward(cdkey)
    local reqTable = {}
    if cdkey ~= nil then
        reqTable.cdkey = cdkey
    end
    local reqMsgData = protobufMgr.Serialize("welfareV2.ReqCdkeyReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCdkeyRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCdkeyRewardMessage](LuaEnumNetDef.ReqCdkeyRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCdkeyRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCdkeyRewardMessage", 27004, "ReqCdkeyReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:27006 请求领取累计签到天数奖励
---请求领取累计签到天数奖励
---msgID: 27006
---@param index number 选填参数 编号
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawSummaryDayReward(index)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("welfareV2.ReqDrawSummaryDayReward" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawSummaryDayRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawSummaryDayRewardMessage](LuaEnumNetDef.ReqDrawSummaryDayRewardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawSummaryDayRewardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawSummaryDayRewardMessage", 27006, "ReqDrawSummaryDayReward", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:27007 请求七天奖励信息
---请求七天奖励信息
---msgID: 27007
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSevenDaysInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSevenDaysInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSevenDaysInfoMessage](LuaEnumNetDef.ReqSevenDaysInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSevenDaysInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:27009 请求领取七天奖励
---请求领取七天奖励
---msgID: 27009
---@param days number 必填参数 领取的天数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawSevenDays(days)
    local reqTable = {}
    reqTable.days = days
    local reqMsgData = protobufMgr.Serialize("welfareV2.ReqDrawSevenDays" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawSevenDaysMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawSevenDaysMessage](LuaEnumNetDef.ReqDrawSevenDaysMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawSevenDaysMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawSevenDaysMessage", 27009, "ReqDrawSevenDays", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:27010 在线奖励信息请求
---在线奖励信息请求
---msgID: 27010
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOnlineRewardInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOnlineRewardInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOnlineRewardInfoMessage](LuaEnumNetDef.ReqOnlineRewardInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOnlineRewardInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:27011 在线奖励领取请求
---在线奖励领取请求
---msgID: 27011
---@param index System.Collections.Generic.List1T<number> 列表参数 奖励id 的List
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOnlineReward(index)
    local reqData = CS.welfareV2.OnlineRewardRequest()
    if index ~= nil then
        reqData.index:AddRange(index)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOnlineRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOnlineRewardMessage](LuaEnumNetDef.ReqOnlineRewardMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOnlineRewardMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:27013 每周在线礼券奖励请求
---每周在线礼券奖励请求
---msgID: 27013
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOnlineLiquan()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOnlineLiquanMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOnlineLiquanMessage](LuaEnumNetDef.ReqOnlineLiquanMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOnlineLiquanMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:27014 请求奖励大厅信息
---请求奖励大厅信息
---msgID: 27014
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRewardHall()
    local reqTable = {}
    local reqMsgData = protobufMgr.Serialize("welfareV2.GetRewardHall" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRewardHallMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRewardHallMessage](LuaEnumNetDef.ReqGetRewardHallMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetRewardHallMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetRewardHallMessage", 27014, "GetRewardHall", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:27016 领取定时奖励
---领取定时奖励
---msgID: 27016
---@param timingRewardType number 选填参数 奖励类型 1每天奖励  2每周奖励
---@param index System.Collections.Generic.List1T<number> 列表参数 奖励id的List
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTimingReward(timingRewardType, index)
    local reqData = CS.welfareV2.TimingRewardRequest()
    if timingRewardType ~= nil then
        reqData.timingRewardType = timingRewardType
    end
    if index ~= nil then
        reqData.index:AddRange(index)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTimingRewardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTimingRewardMessage](LuaEnumNetDef.ReqTimingRewardMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTimingRewardMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:27018 请求定时奖励信息
---请求定时奖励信息
---msgID: 27018
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTimmngRewardInfo()
    local reqTable = {}
    local reqMsgData = protobufMgr.Serialize("welfareV2.TimmngRewardInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTimmngRewardInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTimmngRewardInfoMessage](LuaEnumNetDef.ReqTimmngRewardInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqTimmngRewardInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqTimmngRewardInfoMessage", 27018, "TimmngRewardInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:27019 请求领取等级奖励
---请求领取等级奖励
---msgID: 27019
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetLevelPacks()
    local reqTable = {}
    local reqMsgData = protobufMgr.Serialize("welfareV2.GetLevelPacks" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetLevelPacksMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetLevelPacksMessage](LuaEnumNetDef.ReqGetLevelPacksMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetLevelPacksMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetLevelPacksMessage", 27019, "GetLevelPacks", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:27021 请求领取等级奖励信息
---请求领取等级奖励信息
---msgID: 27021
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetLevelPacksInfo()
    local reqTable = {}
    local reqMsgData = protobufMgr.Serialize("welfareV2.GetLevelPacksInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetLevelPacksInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetLevelPacksInfoMessage](LuaEnumNetDef.ReqGetLevelPacksInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetLevelPacksInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetLevelPacksInfoMessage", 27021, "GetLevelPacksInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:27022 请求领取最后一个灵兽格子
---请求领取最后一个灵兽格子
---msgID: 27022
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetServantGrid()
    local reqTable = {}
    local reqMsgData = protobufMgr.Serialize("welfareV2.GetServantGrid" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetServantGridMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetServantGridMessage](LuaEnumNetDef.ReqGetServantGridMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetServantGridMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetServantGridMessage", 27022, "GetServantGrid", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

