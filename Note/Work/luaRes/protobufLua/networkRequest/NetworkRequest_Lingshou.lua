--[[本文件为工具自动生成,禁止手动修改]]
--lingshou.xml

--region ID:48002 请求升级灵兽
---请求升级灵兽
---msgID: 48002
---@param type number 选填参数 类型 1.灵兽 其他幻形
---@param useType number 选填参数 1.使用元宝
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLevelUpLingShou(type, useType)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if useType ~= nil then
        reqTable.useType = useType
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqLevelUpLingShou" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLevelUpLingShouMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLevelUpLingShouMessage](LuaEnumNetDef.ReqLevelUpLingShouMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLevelUpLingShouMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLevelUpLingShouMessage", 48002, "ReqLevelUpLingShou", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48004 请求升级资质
---请求升级资质
---msgID: 48004
---@param cls number 选填参数 资质类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLevelUpLingShouTalent(cls)
    local reqTable = {}
    if cls ~= nil then
        reqTable.cls = cls
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqLevelUpLingShouTalent" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLevelUpLingShouTalentMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLevelUpLingShouTalentMessage](LuaEnumNetDef.ReqLevelUpLingShouTalentMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLevelUpLingShouTalentMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLevelUpLingShouTalentMessage", 48004, "ReqLevelUpLingShouTalent", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48006 请求穿戴灵兽装备
---请求穿戴灵兽装备
---msgID: 48006
---@param index number 选填参数 装备位置
---@param uniqueId number 选填参数 装备唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOnLingShouEquip(index, uniqueId)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    if uniqueId ~= nil then
        reqTable.uniqueId = uniqueId
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqPutOnLingShouEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOnLingShouEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOnLingShouEquipMessage](LuaEnumNetDef.ReqPutOnLingShouEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOnLingShouEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOnLingShouEquipMessage", 48006, "ReqPutOnLingShouEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48008 请求脱下灵兽装备
---请求脱下灵兽装备
---msgID: 48008
---@param index number 选填参数 装备位置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOffLingShouEquip(index)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqPutOffLingShouEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOffLingShouEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOffLingShouEquipMessage](LuaEnumNetDef.ReqPutOffLingShouEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOffLingShouEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOffLingShouEquipMessage", 48008, "ReqPutOffLingShouEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48009 请求换肤
---请求换肤
---msgID: 48009
---@param type number 选填参数 类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOnSkin(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqPutOnSkin" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOnSkinMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOnSkinMessage](LuaEnumNetDef.ReqPutOnSkinMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOnSkinMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOnSkinMessage", 48009, "ReqPutOnSkin", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48011 请求脱下皮肤
---请求脱下皮肤
---msgID: 48011
---@param type number 选填参数 类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOffLingSkin(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqPutOffLingSkin" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOffLingSkinMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOffLingSkinMessage](LuaEnumNetDef.ReqPutOffLingSkinMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOffLingSkinMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOffLingSkinMessage", 48011, "ReqPutOffLingSkin", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48012 请求激活灵兽
---请求激活灵兽
---msgID: 48012
---@param type number 选填参数 类型 1.灵兽 其他幻形
---@return boolean 网络请求是否成功发送
function networkRequest.ReqActivateLingShou(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqActivateLingShou" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqActivateLingShouMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqActivateLingShouMessage](LuaEnumNetDef.ReqActivateLingShouMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqActivateLingShouMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqActivateLingShouMessage", 48012, "ReqActivateLingShou", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48013 请求升级天赋
---请求升级天赋
---msgID: 48013
---@param type number 选填参数 类型 1.灵兽 其他幻形
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLevelUpTianFu(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqLevelUpTianFu" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLevelUpTianFuMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLevelUpTianFuMessage](LuaEnumNetDef.ReqLevelUpTianFuMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLevelUpTianFuMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLevelUpTianFuMessage", 48013, "ReqLevelUpTianFu", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48016 请求圣灵
---请求圣灵
---msgID: 48016
---@param index number 选填参数 位置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqShengLing(index)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqShengLing" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqShengLingMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqShengLingMessage](LuaEnumNetDef.ReqShengLingMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqShengLingMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqShengLingMessage", 48016, "ReqShengLing", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48017 请求灵兽任务面板
---请求灵兽任务面板
---msgID: 48017
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLingShouTaskPanel()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLingShouTaskPanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLingShouTaskPanelMessage](LuaEnumNetDef.ReqLingShouTaskPanelMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqLingShouTaskPanelMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:48021 领取任务奖励
---领取任务奖励
---msgID: 48021
---@param id number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetRewards(id)
    local reqTable = {}
    reqTable.id = id
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqGetRewards" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetRewardsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetRewardsMessage](LuaEnumNetDef.ReqGetRewardsMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetRewardsMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetRewardsMessage", 48021, "ReqGetRewards", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48022 领取章节奖励
---领取章节奖励
---msgID: 48022
---@param sec number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetSecRewards(sec)
    local reqTable = {}
    reqTable.sec = sec
    local reqMsgData = protobufMgr.Serialize("lingshouV2.ReqGetSecRewards" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetSecRewardsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetSecRewardsMessage](LuaEnumNetDef.ReqGetSecRewardsMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetSecRewardsMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetSecRewardsMessage", 48022, "ReqGetSecRewards", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:48023 完成所有灵兽任务
---完成所有灵兽任务
---msgID: 48023
---@return boolean 网络请求是否成功发送
function networkRequest.ReqFinishAllLingshouTask()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqFinishAllLingshouTaskMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqFinishAllLingshouTaskMessage](LuaEnumNetDef.ReqFinishAllLingshouTaskMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqFinishAllLingshouTaskMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:48024 立即开启
---立即开启
---msgID: 48024
---@param sec number 选填参数 灵兽位置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnlockLingShouTask(sec)
    local reqTable = {}
    if sec ~= nil then
        reqTable.sec = sec
    end
    local reqMsgData = protobufMgr.Serialize("lingshouV2.UnlockLingShouTask" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnlockLingShouTaskMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnlockLingShouTaskMessage](LuaEnumNetDef.ReqUnlockLingShouTaskMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnlockLingShouTaskMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnlockLingShouTaskMessage", 48024, "UnlockLingShouTask", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

