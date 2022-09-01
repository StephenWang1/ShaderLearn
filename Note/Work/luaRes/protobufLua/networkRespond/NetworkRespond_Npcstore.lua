--[[本文件为工具自动生成,禁止手动修改]]
--npcstore.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回NPC商店
---msgID: 124002
---@param msgID LuaEnumNetDef 消息ID
---@return npcstoreV2.ResNpcStoreInfo C#数据结构
function networkRespond.OnResNpcStoreMessageReceived(msgID)
    ---@type npcstoreV2.ResNpcStoreInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 124002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 124002 npcstoreV2.ResNpcStoreInfo 返回NPC商店")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.npcstore ~= nil and  protobufMgr.DecodeTable.npcstore.ResNpcStoreInfo ~= nil then
        csData = protobufMgr.DecodeTable.npcstore.ResNpcStoreInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回NPC商店出售列表
---msgID: 124004
---@param msgID LuaEnumNetDef 消息ID
---@return npcstoreV2.NpcStoreGridList C#数据结构
function networkRespond.OnResNpcStoreSellListMessageReceived(msgID)
    ---@type npcstoreV2.NpcStoreGridList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 124004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 124004 npcstoreV2.NpcStoreGridList 返回NPC商店出售列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.npcstore ~= nil and  protobufMgr.DecodeTable.npcstore.NpcStoreGridList ~= nil then
        csData = protobufMgr.DecodeTable.npcstore.NpcStoreGridList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回NPC商店上架
---msgID: 124006
---@param msgID LuaEnumNetDef 消息ID
---@return npcstoreV2.ResPutOnNpcStoreItem C#数据结构
function networkRespond.OnResNpcStorePutOnMessageReceived(msgID)
    ---@type npcstoreV2.ResPutOnNpcStoreItem
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 124006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 124006 npcstoreV2.ResPutOnNpcStoreItem 返回NPC商店上架")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResNpcStorePutOnMessage", 124006, "ResPutOnNpcStoreItem", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回NPC商店购买
---msgID: 124008
---@param msgID LuaEnumNetDef 消息ID
---@return npcstoreV2.ResBuyNpcStore C#数据结构
function networkRespond.OnResNpcStoreBuyMessageReceived(msgID)
    ---@type npcstoreV2.ResBuyNpcStore
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 124008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 124008 npcstoreV2.ResBuyNpcStore 返回NPC商店购买")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResNpcStoreBuyMessage", 124008, "ResBuyNpcStore", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

