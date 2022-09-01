--[[本文件为工具自动生成,禁止手动修改]]
--servant.xml

--region ID:103002 请求升级仆从
---请求升级仆从
---msgID: 103002
---@param type number 选填参数
---@param exp number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpServant(type, exp)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if exp ~= nil then
        reqTable.exp = exp
    end
    local reqMsgData = protobufMgr.Serialize("servantV2.ReqInjectExp" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpServantMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpServantMessage](LuaEnumNetDef.ReqUpServantMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpServantMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpServantMessage", 103002, "ReqInjectExp", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103003 请求切换状态
---请求切换状态
---msgID: 103003
---@param toState number 必填参数 切换状态
---@param type number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantChangeState(toState, type)
    local reqTable = {}
    reqTable.toState = toState
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("servantV2.ReqServantChangeState" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantChangeStateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantChangeStateMessage](LuaEnumNetDef.ReqServantChangeStateMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqServantChangeStateMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqServantChangeStateMessage", 103003, "ReqServantChangeState", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103004 请求元灵转生
---请求元灵转生
---msgID: 103004
---@param type number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpLevelServantRein(type)
    local reqTable = {}
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("servantV2.ServantIdInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpLevelServantReinMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpLevelServantReinMessage](LuaEnumNetDef.ReqUpLevelServantReinMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpLevelServantReinMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpLevelServantReinMessage", 103004, "ServantIdInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103005 请求元灵兑换灵力
---请求元灵兑换灵力
---msgID: 103005
---@param type number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantExchangeRein(type)
    local reqTable = {}
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("servantV2.ServantIdInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantExchangeReinMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantExchangeReinMessage](LuaEnumNetDef.ReqServantExchangeReinMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqServantExchangeReinMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqServantExchangeReinMessage", 103005, "ServantIdInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103006 请求使用元灵蛋
---请求使用元灵蛋
---msgID: 103006
---@param itemId number 选填参数
---@param targetType number 选填参数 新增第四种灵兽, 可以放任意位置, 此处填具体位置, 以前三种填自己位置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseServantEgg(itemId, targetType)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if targetType ~= nil then
        reqTable.targetType = targetType
    end
    local reqMsgData = protobufMgr.Serialize("servantV2.ReqUseServantEgg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseServantEggMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseServantEggMessage](LuaEnumNetDef.ReqUseServantEggMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseServantEggMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseServantEggMessage", 103006, "ReqUseServantEgg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103007 请求仆从信息
---请求仆从信息
---msgID: 103007
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantInfoMessage](LuaEnumNetDef.ReqServantInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqServantInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:103010 请求修改元灵名字
---请求修改元灵名字
---msgID: 103010
---@param type number 选填参数
---@param name string 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRename(type, name)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if name ~= nil then
        reqTable.name = name
    end
    local reqMsgData = protobufMgr.Serialize("servantV2.ReqServantRename" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRenameMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRenameMessage](LuaEnumNetDef.ReqRenameMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRenameMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRenameMessage", 103010, "ReqServantRename", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103015 请求他人灵兽信息
---请求他人灵兽信息
---msgID: 103015
---@param targetId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOtherServantInfo(targetId)
    local reqTable = {}
    if targetId ~= nil then
        reqTable.targetId = targetId
    end
    local reqMsgData = protobufMgr.Serialize("servantV2.ReqOtherServantInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOtherServantInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOtherServantInfoMessage](LuaEnumNetDef.ReqOtherServantInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOtherServantInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOtherServantInfoMessage", 103015, "ReqOtherServantInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103019 请求通灵魂继
---请求通灵魂继
---msgID: 103019
---@param position number 必填参数 装备位置, servantType * 10000 + 格子号, 脱下发当前装备的位置, 发其他替换
---@return boolean 网络请求是否成功发送
function networkRequest.ReqServantEquipSoul(position)
    local reqTable = {}
    reqTable.position = position
    local reqMsgData = protobufMgr.Serialize("servantV2.ReqServantEquipSoul" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqServantEquipSoulMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqServantEquipSoulMessage](LuaEnumNetDef.ReqServantEquipSoulMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqServantEquipSoulMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqServantEquipSoulMessage", 103019, "ReqServantEquipSoul", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103021 请求购买灵兽位信息
---请求购买灵兽位信息
---msgID: 103021
---@param site number 必填参数 购买的位置
---@param type number 必填参数 1.钻石购买 2.元宝购买
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPurchaseServantSite(site, type)
    local reqTable = {}
    reqTable.site = site
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("servantV2.ReqPurchaseServantSite" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPurchaseServantSiteMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPurchaseServantSiteMessage](LuaEnumNetDef.ReqPurchaseServantSiteMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPurchaseServantSiteMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPurchaseServantSiteMessage", 103021, "ReqPurchaseServantSite", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103024 请求领取灵兽灵力
---请求领取灵兽灵力
---msgID: 103024
---@param receiveType number 必填参数 领取类型 1：普通领取 2 ：充值领取
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReceiveMana(receiveType)
    local reqTable = {}
    reqTable.receiveType = receiveType
    local reqMsgData = protobufMgr.Serialize("servantV2.ReqReceiveMana" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReceiveManaMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReceiveManaMessage](LuaEnumNetDef.ReqReceiveManaMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReceiveManaMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReceiveManaMessage", 103024, "ReqReceiveMana", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:103025 打开灵兽聚灵面板
---打开灵兽聚灵面板
---msgID: 103025
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpneServantMana()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpneServantManaMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpneServantManaMessage](LuaEnumNetDef.ReqOpneServantManaMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOpneServantManaMessage, nil, true)
    end
    return canSendMsg
end
--endregion

