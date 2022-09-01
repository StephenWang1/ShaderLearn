--[[本文件为工具自动生成,禁止手动修改]]
--treasurehunt.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---历史信息
---msgID: 11105
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.HuntHistory C#数据结构
function networkRespond.OnResServerHistoryMessageReceived(msgID)
    ---@type treasureHuntV2.HuntHistory
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11105 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11105 treasureHuntV2.HuntHistory 历史信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.treasurehunt ~= nil and  protobufMgr.DecodeTable.treasurehunt.HuntHistory ~= nil then
        csData = protobufMgr.DecodeTable.treasurehunt.HuntHistory(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---寻宝仓库物品变动信息
---msgID: 11108
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.TreasureItemChangeList C#数据结构
function networkRespond.OnResTreasureItemChangedMessageReceived(msgID)
    ---@type treasureHuntV2.TreasureItemChangeList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11108 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11108 treasureHuntV2.TreasureItemChangeList 寻宝仓库物品变动信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTreasureItemChangedMessage", 11108, "TreasureItemChangeList", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---寻宝仓库信息
---msgID: 11110
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.TreasureHuntInfo C#数据结构
function networkRespond.OnResTreasureStorehouseMessageReceived(msgID)
    ---@type treasureHuntV2.TreasureHuntInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11110 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11110 treasureHuntV2.TreasureHuntInfo 寻宝仓库信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.treasurehunt ~= nil and  protobufMgr.DecodeTable.treasurehunt.TreasureHuntInfo ~= nil then
        csData = protobufMgr.DecodeTable.treasurehunt.TreasureHuntInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---寻宝结束信息
---msgID: 11111
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResTreasureEndMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---使用寻宝经验丹响应
---msgID: 11113
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.ExpUseRequest C#数据结构
function networkRespond.OnResUseTreasureExpMessageReceived(msgID)
    ---@type treasureHuntV2.ExpUseRequest
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11113 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11113 treasureHuntV2.ExpUseRequest 使用寻宝经验丹响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUseTreasureExpMessage", 11113, "ExpUseRequest", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---寻宝界面宝箱响应
---msgID: 11115
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.TreasureIdResponse C#数据结构
function networkRespond.OnResTreasureIdMessageReceived(msgID)
    ---@type treasureHuntV2.TreasureIdResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11115 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11115 treasureHuntV2.TreasureIdResponse 寻宝界面宝箱响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTreasureIdMessage", 11115, "TreasureIdResponse", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---寻宝仓库中回收装备响应
---msgID: 11119
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.HuntCallbackResponse C#数据结构
function networkRespond.OnResHuntCallBackMessageReceived(msgID)
    ---@type treasureHuntV2.HuntCallbackResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11119 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11119 treasureHuntV2.HuntCallbackResponse 寻宝仓库中回收装备响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResHuntCallBackMessage", 11119, "HuntCallbackResponse", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---查看限时寻宝池响应
---msgID: 11121
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.LimitTimeTreasureHuntPool C#数据结构
function networkRespond.OnResLimitTimeTreasureHuntPoolMessageReceived(msgID)
    ---@type treasureHuntV2.LimitTimeTreasureHuntPool
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11121 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11121 treasureHuntV2.LimitTimeTreasureHuntPool 查看限时寻宝池响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLimitTimeTreasureHuntPoolMessage", 11121, "LimitTimeTreasureHuntPool", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回所有卡牌信息
---msgID: 11124
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.AllCardInfo C#数据结构
function networkRespond.OnResTreasureCardMessageReceived(msgID)
    ---@type treasureHuntV2.AllCardInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11124 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11124 treasureHuntV2.AllCardInfo 返回所有卡牌信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.treasurehunt ~= nil and  protobufMgr.DecodeTable.treasurehunt.AllCardInfo ~= nil then
        csData = protobufMgr.DecodeTable.treasurehunt.AllCardInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---寻宝仓库更新
---msgID: 11130
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.StorageUpdateInfo C#数据结构
function networkRespond.OnResHuntStorageUpdateMessageReceived(msgID)
    ---@type treasureHuntV2.StorageUpdateInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11130 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11130 treasureHuntV2.StorageUpdateInfo 寻宝仓库更新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.treasurehunt ~= nil and  protobufMgr.DecodeTable.treasurehunt.StorageUpdateInfo ~= nil then
        csData = protobufMgr.DecodeTable.treasurehunt.StorageUpdateInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回全服转生信息
---msgID: 11132
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.ReinNumResponse C#数据结构
function networkRespond.OnResReinNumMessageReceived(msgID)
    ---@type treasureHuntV2.ReinNumResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11132 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11132 treasureHuntV2.ReinNumResponse 返回全服转生信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.treasurehunt ~= nil and  protobufMgr.DecodeTable.treasurehunt.ReinNumResponse ~= nil then
        csData = protobufMgr.DecodeTable.treasurehunt.ReinNumResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回挖宝仓库信息
---msgID: 11136
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.DigTreasureWareHouse C#数据结构
function networkRespond.OnResDigTreasureWareHouseMessageReceived(msgID)
    ---@type treasureHuntV2.DigTreasureWareHouse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11136 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11136 treasureHuntV2.DigTreasureWareHouse 返回挖宝仓库信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDigTreasureWareHouseMessage", 11136, "DigTreasureWareHouse", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---玩家挖宝次数
---msgID: 11139
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.RoleDigTreasureCount C#数据结构
function networkRespond.OnResRoleDigTreasureCountMessageReceived(msgID)
    ---@type treasureHuntV2.RoleDigTreasureCount
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11139 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11139 treasureHuntV2.RoleDigTreasureCount 玩家挖宝次数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleDigTreasureCountMessage", 11139, "RoleDigTreasureCount", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---玩家挖宝状态数
---msgID: 11140
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.DigTreasureState C#数据结构
function networkRespond.OnResDigTreasureStateMessageReceived(msgID)
    ---@type treasureHuntV2.DigTreasureState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11140 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11140 treasureHuntV2.DigTreasureState 玩家挖宝状态数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.treasurehunt ~= nil and  protobufMgr.DecodeTable.treasurehunt.DigTreasureState ~= nil then
        csData = protobufMgr.DecodeTable.treasurehunt.DigTreasureState(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---玩家挖宝状态数
---msgID: 11141
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.DigTreasureItems C#数据结构
function networkRespond.OnResDigTreasureItemsMessageReceived(msgID)
    ---@type treasureHuntV2.DigTreasureItems
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11141 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11141 treasureHuntV2.DigTreasureItems 玩家挖宝状态数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDigTreasureItemsMessage", 11141, "DigTreasureItems", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---黄金挖宝活动状态
---msgID: 11142
---@param msgID LuaEnumNetDef 消息ID
---@return treasureHuntV2.GoldDigActiveState C#数据结构
function networkRespond.OnResGoldDigActiveStateMessageReceived(msgID)
    ---@type treasureHuntV2.GoldDigActiveState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 11142 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 11142 treasureHuntV2.GoldDigActiveState 黄金挖宝活动状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGoldDigActiveStateMessage", 11142, "GoldDigActiveState", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

