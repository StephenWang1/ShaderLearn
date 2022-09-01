--[[本文件为工具自动生成,禁止手动修改]]
--activities.xml

--region ID:128002 请求某类活动信息
---请求某类活动信息
---msgID: 128002
---@param configId number 选填参数 配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetOneActivitiesInfo(configId)
    local reqTable = {}
    if configId ~= nil then
        reqTable.configId = configId
    end
    local reqMsgData = protobufMgr.Serialize("activitiesV2.ReqOneActivitiesInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetOneActivitiesInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetOneActivitiesInfoMessage](LuaEnumNetDef.ReqGetOneActivitiesInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetOneActivitiesInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetOneActivitiesInfoMessage", 128002, "ReqOneActivitiesInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:128004 请求领取活动奖励
---请求领取活动奖励
---msgID: 128004
---@param configId number 选填参数 配置id
---@param dataParam number 选填参数 32位参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetOneActivitiesAward(configId, dataParam)
    local reqTable = {}
    if configId ~= nil then
        reqTable.configId = configId
    end
    if dataParam ~= nil then
        reqTable.dataParam = dataParam
    end
    local reqMsgData = protobufMgr.Serialize("activitiesV2.ReqAwardActivitiesInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetOneActivitiesAwardMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetOneActivitiesAwardMessage](LuaEnumNetDef.ReqGetOneActivitiesAwardMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetOneActivitiesAwardMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetOneActivitiesAwardMessage", 128004, "ReqAwardActivitiesInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:128008 请求白日门活动面板信息
---请求白日门活动面板信息
---msgID: 128008
---@param activityId number 选填参数 活动Id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSunActivitiesPanel(activityId)
    local reqTable = {}
    if activityId ~= nil then
        reqTable.activityId = activityId
    end
    local reqMsgData = protobufMgr.Serialize("activitiesV2.ReqSunActivitiesPanel" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSunActivitiesPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSunActivitiesPanelMessage](LuaEnumNetDef.ReqSunActivitiesPanelMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSunActivitiesPanelMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSunActivitiesPanelMessage", 128008, "ReqSunActivitiesPanel", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

