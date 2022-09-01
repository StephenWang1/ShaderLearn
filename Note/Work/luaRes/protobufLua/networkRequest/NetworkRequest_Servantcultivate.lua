--[[本文件为工具自动生成,禁止手动修改]]
--servantcultivate.xml

--region ID:151001 灵兽开始修炼
---灵兽开始修炼
---msgID: 151001
---@param type number 选填参数 灵兽类型  0：默认请求当前修炼
---@param hscultivationConfigId number 选填参数 请求进入的地图配置id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantCultivateBegin(type, hscultivationConfigId)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if hscultivationConfigId ~= nil then
        reqTable.hscultivationConfigId = hscultivationConfigId
    end
    local reqMsgData = protobufMgr.Serialize("servantcultivateV2.reqCultivateInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateBeginMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateBeginMessage](LuaEnumNetDef.ReqServantCultivateBeginMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqServantCultivateBeginMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqServantCultivateBeginMessage", 151001, "reqCultivateInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:151003 灵兽结束修炼
---灵兽结束修炼
---msgID: 151003
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantCultivateStop()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateStopMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateStopMessage](LuaEnumNetDef.ReqServantCultivateStopMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqServantCultivateStopMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:151004 灵兽提取经验
---灵兽提取经验
---msgID: 151004
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantCultivateTake()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateTakeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateTakeMessage](LuaEnumNetDef.ReqServantCultivateTakeMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqServantCultivateTakeMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:151005 灵兽修炼界面打开
---灵兽修炼界面打开
---msgID: 151005
---@param type number 选填参数 1: 打开， 2：关闭
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantCultivateOpenDlg(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("servantcultivateV2.reqOpenDlg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateOpenDlgMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateOpenDlgMessage](LuaEnumNetDef.ReqServantCultivateOpenDlgMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqServantCultivateOpenDlgMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqServantCultivateOpenDlgMessage", 151005, "reqOpenDlg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:151007 灵兽修炼飞地图坐标
---灵兽修炼飞地图坐标
---msgID: 151007
---@param mapId number 选填参数 地图id
---@param toX number 选填参数 坐标x
---@param toY number 选填参数 坐标y
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantCultivateFly(mapId, toX, toY)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    if toX ~= nil then
        reqTable.toX = toX
    end
    if toY ~= nil then
        reqTable.toY = toY
    end
    local reqMsgData = protobufMgr.Serialize("servantcultivateV2.reqFlyInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateFlyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantCultivateFlyMessage](LuaEnumNetDef.ReqServantCultivateFlyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqServantCultivateFlyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqServantCultivateFlyMessage", 151007, "reqFlyInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

