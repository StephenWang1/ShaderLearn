--[[本文件为工具自动生成,禁止手动修改]]
--npcstore.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回NPC商店
---msgID: 124002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNpcStoreMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 124002 npcstoreV2.ResNpcStoreInfo 返回NPC商店")
        return nil
    end
    local res = protobufMgr.Deserialize("npcstoreV2.ResNpcStoreInfo", buffer)
    if protoAdjust.npcstore_adj ~= nil and protoAdjust.npcstore_adj.AdjustResNpcStoreInfo ~= nil then
        protoAdjust.npcstore_adj.AdjustResNpcStoreInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 124002
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回NPC商店出售列表
---msgID: 124004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNpcStoreSellListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 124004 npcstoreV2.NpcStoreGridList 返回NPC商店出售列表")
        return nil
    end
    local res = protobufMgr.Deserialize("npcstoreV2.NpcStoreGridList", buffer)
    if protoAdjust.npcstore_adj ~= nil and protoAdjust.npcstore_adj.AdjustNpcStoreGridList ~= nil then
        protoAdjust.npcstore_adj.AdjustNpcStoreGridList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 124004
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回NPC商店上架
---msgID: 124006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNpcStorePutOnMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 124006 npcstoreV2.ResPutOnNpcStoreItem 返回NPC商店上架")
        return nil
    end
    local res = protobufMgr.Deserialize("npcstoreV2.ResPutOnNpcStoreItem", buffer)
    if protoAdjust.npcstore_adj ~= nil and protoAdjust.npcstore_adj.AdjustResPutOnNpcStoreItem ~= nil then
        protoAdjust.npcstore_adj.AdjustResPutOnNpcStoreItem(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 124006
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回NPC商店购买
---msgID: 124008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNpcStoreBuyMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 124008 npcstoreV2.ResBuyNpcStore 返回NPC商店购买")
        return nil
    end
    local res = protobufMgr.Deserialize("npcstoreV2.ResBuyNpcStore", buffer)
    if protoAdjust.npcstore_adj ~= nil and protoAdjust.npcstore_adj.AdjustResBuyNpcStore ~= nil then
        protoAdjust.npcstore_adj.AdjustResBuyNpcStore(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 124008
    protobufMgr.mMsgDeserializedTblCache = res
end

