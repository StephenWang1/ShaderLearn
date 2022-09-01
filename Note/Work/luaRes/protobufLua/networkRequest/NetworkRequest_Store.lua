--[[本文件为工具自动生成,禁止手动修改]]
--store.xml

--region ID:16001 请求打开商店根据storeClassId
---请求打开商店根据storeClassId
---msgID: 16001
---@param storeClassId number 选填参数 商店唯一ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenStoreById(storeClassId)
    local reqTable = {}
    if storeClassId ~= nil then
        reqTable.storeClassId = storeClassId
    end
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqOpenStoreById" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenStoreByIdMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenStoreByIdMessage](LuaEnumNetDef.ReqOpenStoreByIdMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOpenStoreByIdMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOpenStoreByIdMessage", 16001, "ReqOpenStoreById", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:16004 购买请求
---购买请求
---msgID: 16004
---@param storeId number 选填参数 商品唯一ID
---@param count number 选填参数 商品数量
---@param itemId number 选填参数 无用
---@param isUse number 选填参数 1不使用，2使用
---@param replaceMoney number 选填参数 1:表示用这个字段的货币买
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyItem(storeId, count, itemId, isUse, replaceMoney)
    local reqTable = {}
    if storeId ~= nil then
        reqTable.storeId = storeId
    end
    if count ~= nil then
        reqTable.count = count
    end
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if isUse ~= nil then
        reqTable.isUse = isUse
    end
    if replaceMoney ~= nil then
        reqTable.replaceMoney = replaceMoney
    end
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqBuyItem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyItemMessage](LuaEnumNetDef.ReqBuyItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyItemMessage", 16004, "ReqBuyItem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:16005 请求指定商品能购买的最大数量
---请求指定商品能购买的最大数量
---msgID: 16005
---@param storeId number 选填参数 store配置Id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMaxBuyCount(storeId)
    local reqTable = {}
    if storeId ~= nil then
        reqTable.storeId = storeId
    end
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqMaxBuyCount" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMaxBuyCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMaxBuyCountMessage](LuaEnumNetDef.ReqMaxBuyCountMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMaxBuyCountMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMaxBuyCountMessage", 16005, "ReqMaxBuyCount", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:16007 请求手动刷新
---请求手动刷新
---msgID: 16007
---@param type number 选填参数 0不扣消耗 1扣消耗
---@param storeClassId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMaualFresh(type, storeClassId)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if storeClassId ~= nil then
        reqTable.storeClassId = storeClassId
    end
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqManualFresh" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMaualFreshMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMaualFreshMessage](LuaEnumNetDef.ReqMaualFreshMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMaualFreshMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMaualFreshMessage", 16007, "ReqManualFresh", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:16014 请求一件商品信息
---请求一件商品信息
---msgID: 16014
---@param storeId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStoreInfo(storeId)
    local reqTable = {}
    if storeId ~= nil then
        reqTable.storeId = storeId
    end
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqStoreInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStoreInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStoreInfoMessage](LuaEnumNetDef.ReqStoreInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqStoreInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqStoreInfoMessage", 16014, "ReqStoreInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:16016 请求合成
---请求合成
---msgID: 16016
---@param configId number 选填参数 要合成的装备对应的configId
---@param type number 选填参数 合成的type 1为需要辅材料提示合成率，0为不需要
---@param count number 选填参数 要合成的数量
---@param mustItemIds table<number> 列表参数 必须扣除的物品（唯一id）
---@param itemIds table<number> 列表参数 需要扣除的物品（唯一id）
---@param resourceId table<number> 列表参数 资源id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSynthesis(configId, type, count, mustItemIds, itemIds, resourceId)
    local reqTable = {}
    if configId ~= nil then
        reqTable.configId = configId
    end
    if type ~= nil then
        reqTable.type = type
    end
    if count ~= nil then
        reqTable.count = count
    end
    if mustItemIds ~= nil then
        reqTable.mustItemIds = mustItemIds
    else
        reqTable.mustItemIds = {}
    end
    if itemIds ~= nil then
        reqTable.itemIds = itemIds
    else
        reqTable.itemIds = {}
    end
    if resourceId ~= nil then
        reqTable.resourceId = resourceId
    else
        reqTable.resourceId = {}
    end
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqSynthesis" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSynthesisMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSynthesisMessage](LuaEnumNetDef.ReqSynthesisMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSynthesisMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSynthesisMessage", 16016, "ReqSynthesis", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:16019 高级回收面板请求
---高级回收面板请求
---msgID: 16019
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMostResyclePanel()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMostResyclePanelMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMostResyclePanelMessage](LuaEnumNetDef.ReqMostResyclePanelMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqMostResyclePanelMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:16021 高级回收请求
---高级回收请求
---msgID: 16021
---@param id table<number> 列表参数 背包里的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMostResycle(id)
    local reqTable = {}
    if id ~= nil then
        reqTable.id = id
    else
        reqTable.id = {}
    end
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqMostResycle" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMostResycleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMostResycleMessage](LuaEnumNetDef.ReqMostResycleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMostResycleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMostResycleMessage", 16021, "ReqMostResycle", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:16022 高级赎回
---高级赎回
---msgID: 16022
---@param id number 必填参数 背包里的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqMostRedeem(id)
    local reqTable = {}
    reqTable.id = id
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqMostRedeem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqMostRedeemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqMostRedeemMessage](LuaEnumNetDef.ReqMostRedeemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqMostRedeemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqMostRedeemMessage", 16022, "ReqMostRedeem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:16024 淬炼请求
---淬炼请求
---msgID: 16024
---@param configId number 选填参数 要淬炼的装备对应的configId
---@param itemUniqueId number 选填参数 要淬炼的装备唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCuiLian(configId, itemUniqueId)
    local reqTable = {}
    if configId ~= nil then
        reqTable.configId = configId
    end
    if itemUniqueId ~= nil then
        reqTable.itemUniqueId = itemUniqueId
    end
    local reqMsgData = protobufMgr.Serialize("storeV2.ReqCuiLian" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCuiLianMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCuiLianMessage](LuaEnumNetDef.ReqCuiLianMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCuiLianMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCuiLianMessage", 16024, "ReqCuiLian", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

