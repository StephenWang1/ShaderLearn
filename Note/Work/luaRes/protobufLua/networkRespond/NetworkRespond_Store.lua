--[[本文件为工具自动生成,禁止手动修改]]
--store.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回商店商品列表
---msgID: 16002
---@param msgID LuaEnumNetDef 消息ID
---@return storeV2.ResOpenStoreById C#数据结构
function networkRespond.OnResOpenStoreByIdMessageReceived(msgID)
    ---@type storeV2.ResOpenStoreById
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 16002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 16002 storeV2.ResOpenStoreById 返回商店商品列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.store ~= nil and  protobufMgr.DecodeTable.store.ResOpenStoreById ~= nil then
        csData = protobufMgr.DecodeTable.store.ResOpenStoreById(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送商店单个商品变化信息
---msgID: 16003
---@param msgID LuaEnumNetDef 消息ID
---@return storeV2.ResSendStoreInfoChange C#数据结构
function networkRespond.OnResSendStoreInfoChangeMessageReceived(msgID)
    ---@type storeV2.ResSendStoreInfoChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 16003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 16003 storeV2.ResSendStoreInfoChange 发送商店单个商品变化信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.store ~= nil and  protobufMgr.DecodeTable.store.ResSendStoreInfoChange ~= nil then
        csData = protobufMgr.DecodeTable.store.ResSendStoreInfoChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回一件商品信息
---msgID: 16015
---@param msgID LuaEnumNetDef 消息ID
---@return storeV2.ResStoreInfo C#数据结构
function networkRespond.OnResStoreInfoMessageReceived(msgID)
    ---@type storeV2.ResStoreInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 16015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 16015 storeV2.ResStoreInfo 返回一件商品信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.store ~= nil and  protobufMgr.DecodeTable.store.ResStoreInfo ~= nil then
        csData = protobufMgr.DecodeTable.store.ResStoreInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回合成成功
---msgID: 16017
---@param msgID LuaEnumNetDef 消息ID
---@return storeV2.ResSynthesis C#数据结构
function networkRespond.OnResSynthesisMessageReceived(msgID)
    ---@type storeV2.ResSynthesis
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 16017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 16017 storeV2.ResSynthesis 返回合成成功")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSynthesisMessage", 16017, "ResSynthesis", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.store ~= nil and  protobufMgr.DecodeTable.store.ResSynthesis ~= nil then
        csData = protobufMgr.DecodeTable.store.ResSynthesis(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---购买回调
---msgID: 16018
---@param msgID LuaEnumNetDef 消息ID
---@return storeV2.ResBuyItem C#数据结构
function networkRespond.OnResBuyItemMessageReceived(msgID)
    ---@type storeV2.ResBuyItem
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 16018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 16018 storeV2.ResBuyItem 购买回调")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBuyItemMessage", 16018, "ResBuyItem", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---高级回收面板下发
---msgID: 16020
---@param msgID LuaEnumNetDef 消息ID
---@return storeV2.ResMostResyclePanel C#数据结构
function networkRespond.OnResMostResyclePanelMessageReceived(msgID)
    ---@type storeV2.ResMostResyclePanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 16020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 16020 storeV2.ResMostResyclePanel 高级回收面板下发")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResMostResyclePanelMessage", 16020, "ResMostResyclePanel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---合成记录
---msgID: 16023
---@param msgID LuaEnumNetDef 消息ID
---@return storeV2.CombineRecord C#数据结构
function networkRespond.OnResCombineRecordMessageReceived(msgID)
    ---@type storeV2.CombineRecord
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 16023 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 16023 storeV2.CombineRecord 合成记录")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCombineRecordMessage", 16023, "CombineRecord", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---淬炼返回
---msgID: 16025
---@param msgID LuaEnumNetDef 消息ID
---@return storeV2.ResCuiLian C#数据结构
function networkRespond.OnResCuiLianMessageReceived(msgID)
    ---@type storeV2.ResCuiLian
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 16025 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 16025 storeV2.ResCuiLian 淬炼返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCuiLianMessage", 16025, "ResCuiLian", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

