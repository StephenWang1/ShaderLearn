--[[本文件为工具自动生成,禁止手动修改]]
--npcstore.xml

--region ID:124001 请求NPC商店
---请求NPC商店
---msgID: 124001
---@param type number 选填参数 NPC物品类型
---@param page number 选填参数 页码（从多少页）
---@param countPerPage number 选填参数 每页条数
---@param pageNumber number 选填参数 页数（总共要多少页）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetNpcStore(type, page, countPerPage, pageNumber)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if page ~= nil then
        reqTable.page = page
    end
    if countPerPage ~= nil then
        reqTable.countPerPage = countPerPage
    end
    if pageNumber ~= nil then
        reqTable.pageNumber = pageNumber
    end
    local reqMsgData = protobufMgr.Serialize("npcstoreV2.ReqGetNpcStoreInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetNpcStoreMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetNpcStoreMessage](LuaEnumNetDef.ReqGetNpcStoreMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetNpcStoreMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetNpcStoreMessage", 124001, "ReqGetNpcStoreInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:124003 请求NPC商店出售列表
---请求NPC商店出售列表
---msgID: 124003
---@param type number 选填参数 NPC物品类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetNpcStoreSellList(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("npcstoreV2.ReqSellList" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetNpcStoreSellListMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetNpcStoreSellListMessage](LuaEnumNetDef.ReqGetNpcStoreSellListMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetNpcStoreSellListMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetNpcStoreSellListMessage", 124003, "ReqSellList", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:124005 请求NPC商店上架
---请求NPC商店上架
---msgID: 124005
---@param itemId number 选填参数 物品的ItemId
---@param count number 选填参数 购买数量
---@param type number 选填参数 /NPC物品类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqNpcStorePutOn(itemId, count, type)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("npcstoreV2.ReqPutOnNpcStoreItem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqNpcStorePutOnMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqNpcStorePutOnMessage](LuaEnumNetDef.ReqNpcStorePutOnMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqNpcStorePutOnMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqNpcStorePutOnMessage", 124005, "ReqPutOnNpcStoreItem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:124007 请求NPC商店购买
---请求NPC商店购买
---msgID: 124007
---@param npcStoreGridId number 选填参数 NPC格子id
---@param lid number 选填参数 物品的唯一id
---@param type number 选填参数 NPC物品类型
---@param count number 选填参数 购买数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqNpcStoreBuy(npcStoreGridId, lid, type, count)
    local reqTable = {}
    if npcStoreGridId ~= nil then
        reqTable.npcStoreGridId = npcStoreGridId
    end
    if lid ~= nil then
        reqTable.lid = lid
    end
    if type ~= nil then
        reqTable.type = type
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("npcstoreV2.ReqBuyNpcStore" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqNpcStoreBuyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqNpcStoreBuyMessage](LuaEnumNetDef.ReqNpcStoreBuyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqNpcStoreBuyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqNpcStoreBuyMessage", 124007, "ReqBuyNpcStore", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

