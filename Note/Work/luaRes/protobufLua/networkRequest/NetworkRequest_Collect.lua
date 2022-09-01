--[[本文件为工具自动生成,禁止手动修改]]
--collect.xml

--region ID:111101 藏品上架请求
---藏品上架请求
---msgID: 111101
---@param lid number 必填参数
---@param page number 必填参数
---@param x number 必填参数
---@param y number 必填参数
---@param item collect.bagV2.BagItemInfo 选填参数 请求里面不用填这个
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutCollectionItem(lid, page, x, y, item)
    local reqTable = {}
    reqTable.lid = lid
    reqTable.page = page
    reqTable.x = x
    reqTable.y = y
    if item ~= nil then
        reqTable.item = item
    end
    local reqMsgData = protobufMgr.Serialize("collect.PutCollectionItemMsg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutCollectionItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutCollectionItemMessage](LuaEnumNetDef.ReqPutCollectionItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutCollectionItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutCollectionItemMessage", 111101, "PutCollectionItemMsg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111103 藏品下架请求
---藏品下架请求
---msgID: 111103
---@param itemId number 必填参数
---@param bagIndex number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRemoveCollectionItem(itemId, bagIndex)
    local reqTable = {}
    reqTable.itemId = itemId
    if bagIndex ~= nil then
        reqTable.bagIndex = bagIndex
    end
    local reqMsgData = protobufMgr.Serialize("collect.RemoveCollectionItemMsg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRemoveCollectionItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRemoveCollectionItemMessage](LuaEnumNetDef.ReqRemoveCollectionItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRemoveCollectionItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRemoveCollectionItemMessage", 111103, "RemoveCollectionItemMsg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111105 藏品交换位置架请求
---藏品交换位置架请求
---msgID: 111105
---@param itemId number 必填参数 物品1ID
---@param page number 必填参数 目标页
---@param x number 必填参数 目标位置(当物品2为空)或物品2左上角坐标
---@param y number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSwapCollectionItem(itemId, page, x, y)
    local reqTable = {}
    reqTable.itemId = itemId
    reqTable.page = page
    reqTable.x = x
    reqTable.y = y
    local reqMsgData = protobufMgr.Serialize("collect.SwapCollectionItemMsg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSwapCollectionItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSwapCollectionItemMessage](LuaEnumNetDef.ReqSwapCollectionItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSwapCollectionItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSwapCollectionItemMessage", 111105, "SwapCollectionItemMsg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111107 藏品回收请求
---藏品回收请求
---msgID: 111107
---@param itemIds table<number> 列表参数 已上架物品ID
---@param lids table<number> 列表参数 背包里的藏品的bagIndex
---@param cabinet collect.collect.CabinetInfo 选填参数 只在响应里
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCallbackCollection(itemIds, lids, cabinet)
    local reqTable = {}
    if itemIds ~= nil then
        reqTable.itemIds = itemIds
    else
        reqTable.itemIds = {}
    end
    if lids ~= nil then
        reqTable.lids = lids
    else
        reqTable.lids = {}
    end
    if cabinet ~= nil then
        reqTable.cabinet = cabinet
    end
    local reqMsgData = protobufMgr.Serialize("collect.CallbackCollectionMsg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCallbackCollectionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCallbackCollectionMessage](LuaEnumNetDef.ReqCallbackCollectionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCallbackCollectionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCallbackCollectionMessage", 111107, "CallbackCollectionMsg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:111119 升级收藏柜请求
---升级收藏柜请求
---msgID: 111119
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpgradeCabinet()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpgradeCabinetMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpgradeCabinetMessage](LuaEnumNetDef.ReqUpgradeCabinetMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqUpgradeCabinetMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:111120 藏品合成请求
---藏品合成请求
---msgID: 111120
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCollectionMerge()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCollectionMergeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCollectionMergeMessage](LuaEnumNetDef.ReqCollectionMergeMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCollectionMergeMessage, nil, true)
    end
    return canSendMsg
end
--endregion

