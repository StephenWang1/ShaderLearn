--[[本文件为工具自动生成,禁止手动修改]]
--store.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回商店商品列表
---msgID: 16002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOpenStoreByIdMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 16002 storeV2.ResOpenStoreById 返回商店商品列表")
        return nil
    end
    local res = protobufMgr.Deserialize("storeV2.ResOpenStoreById", buffer)
    if protoAdjust.store_adj ~= nil and protoAdjust.store_adj.AdjustResOpenStoreById ~= nil then
        protoAdjust.store_adj.AdjustResOpenStoreById(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 16002
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送商店单个商品变化信息
---msgID: 16003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendStoreInfoChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 16003 storeV2.ResSendStoreInfoChange 发送商店单个商品变化信息")
        return nil
    end
    local res = protobufMgr.Deserialize("storeV2.ResSendStoreInfoChange", buffer)
    if protoAdjust.store_adj ~= nil and protoAdjust.store_adj.AdjustResSendStoreInfoChange ~= nil then
        protoAdjust.store_adj.AdjustResSendStoreInfoChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 16003
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回一件商品信息
---msgID: 16015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResStoreInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 16015 storeV2.ResStoreInfo 返回一件商品信息")
        return nil
    end
    local res = protobufMgr.Deserialize("storeV2.ResStoreInfo", buffer)
    if protoAdjust.store_adj ~= nil and protoAdjust.store_adj.AdjustResStoreInfo ~= nil then
        protoAdjust.store_adj.AdjustResStoreInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 16015
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回合成成功
---msgID: 16017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSynthesisMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 16017 storeV2.ResSynthesis 返回合成成功")
        return nil
    end
    local res = protobufMgr.Deserialize("storeV2.ResSynthesis", buffer)
    if protoAdjust.store_adj ~= nil and protoAdjust.store_adj.AdjustResSynthesis ~= nil then
        protoAdjust.store_adj.AdjustResSynthesis(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 16017
    protobufMgr.mMsgDeserializedTblCache = res
end

---购买回调
---msgID: 16018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBuyItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 16018 storeV2.ResBuyItem 购买回调")
        return nil
    end
    local res = protobufMgr.Deserialize("storeV2.ResBuyItem", buffer)
    if protoAdjust.store_adj ~= nil and protoAdjust.store_adj.AdjustResBuyItem ~= nil then
        protoAdjust.store_adj.AdjustResBuyItem(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 16018
    protobufMgr.mMsgDeserializedTblCache = res
end

---高级回收面板下发
---msgID: 16020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMostResyclePanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 16020 storeV2.ResMostResyclePanel 高级回收面板下发")
        return nil
    end
    local res = protobufMgr.Deserialize("storeV2.ResMostResyclePanel", buffer)
    if protoAdjust.store_adj ~= nil and protoAdjust.store_adj.AdjustResMostResyclePanel ~= nil then
        protoAdjust.store_adj.AdjustResMostResyclePanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 16020
    protobufMgr.mMsgDeserializedTblCache = res
end

---合成记录
---msgID: 16023
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCombineRecordMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 16023 storeV2.CombineRecord 合成记录")
        return nil
    end
    local res = protobufMgr.Deserialize("storeV2.CombineRecord", buffer)
    if protoAdjust.store_adj ~= nil and protoAdjust.store_adj.AdjustCombineRecord ~= nil then
        protoAdjust.store_adj.AdjustCombineRecord(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 16023
    protobufMgr.mMsgDeserializedTblCache = res
end

---淬炼返回
---msgID: 16025
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCuiLianMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 16025 storeV2.ResCuiLian 淬炼返回")
        return nil
    end
    local res = protobufMgr.Deserialize("storeV2.ResCuiLian", buffer)
    if protoAdjust.store_adj ~= nil and protoAdjust.store_adj.AdjustResCuiLian ~= nil then
        protoAdjust.store_adj.AdjustResCuiLian(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 16025
    protobufMgr.mMsgDeserializedTblCache = res
end

