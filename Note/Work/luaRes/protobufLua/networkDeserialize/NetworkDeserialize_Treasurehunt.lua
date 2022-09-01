--[[本文件为工具自动生成,禁止手动修改]]
--treasurehunt.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---历史信息
---msgID: 11105
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServerHistoryMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11105 treasureHuntV2.HuntHistory 历史信息")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.HuntHistory", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustHuntHistory ~= nil then
        protoAdjust.treasurehunt_adj.AdjustHuntHistory(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11105
    protobufMgr.mMsgDeserializedTblCache = res
end

---寻宝仓库物品变动信息
---msgID: 11108
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTreasureItemChangedMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11108 treasureHuntV2.TreasureItemChangeList 寻宝仓库物品变动信息")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.TreasureItemChangeList", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustTreasureItemChangeList ~= nil then
        protoAdjust.treasurehunt_adj.AdjustTreasureItemChangeList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11108
    protobufMgr.mMsgDeserializedTblCache = res
end

---寻宝仓库信息
---msgID: 11110
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTreasureStorehouseMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11110 treasureHuntV2.TreasureHuntInfo 寻宝仓库信息")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.TreasureHuntInfo", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustTreasureHuntInfo ~= nil then
        protoAdjust.treasurehunt_adj.AdjustTreasureHuntInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11110
    protobufMgr.mMsgDeserializedTblCache = res
end

---寻宝结束信息
---msgID: 11111
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTreasureEndMessageReceived(msgID, buffer)
end

---使用寻宝经验丹响应
---msgID: 11113
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUseTreasureExpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11113 treasureHuntV2.ExpUseRequest 使用寻宝经验丹响应")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.ExpUseRequest", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustExpUseRequest ~= nil then
        protoAdjust.treasurehunt_adj.AdjustExpUseRequest(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11113
    protobufMgr.mMsgDeserializedTblCache = res
end

---寻宝界面宝箱响应
---msgID: 11115
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTreasureIdMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11115 treasureHuntV2.TreasureIdResponse 寻宝界面宝箱响应")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.TreasureIdResponse", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustTreasureIdResponse ~= nil then
        protoAdjust.treasurehunt_adj.AdjustTreasureIdResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11115
    protobufMgr.mMsgDeserializedTblCache = res
end

---寻宝仓库中回收装备响应
---msgID: 11119
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResHuntCallBackMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11119 treasureHuntV2.HuntCallbackResponse 寻宝仓库中回收装备响应")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.HuntCallbackResponse", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustHuntCallbackResponse ~= nil then
        protoAdjust.treasurehunt_adj.AdjustHuntCallbackResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11119
    protobufMgr.mMsgDeserializedTblCache = res
end

---查看限时寻宝池响应
---msgID: 11121
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLimitTimeTreasureHuntPoolMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11121 treasureHuntV2.LimitTimeTreasureHuntPool 查看限时寻宝池响应")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.LimitTimeTreasureHuntPool", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustLimitTimeTreasureHuntPool ~= nil then
        protoAdjust.treasurehunt_adj.AdjustLimitTimeTreasureHuntPool(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11121
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回所有卡牌信息
---msgID: 11124
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTreasureCardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11124 treasureHuntV2.AllCardInfo 返回所有卡牌信息")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.AllCardInfo", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustAllCardInfo ~= nil then
        protoAdjust.treasurehunt_adj.AdjustAllCardInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11124
    protobufMgr.mMsgDeserializedTblCache = res
end

---寻宝仓库更新
---msgID: 11130
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResHuntStorageUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11130 treasureHuntV2.StorageUpdateInfo 寻宝仓库更新")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.StorageUpdateInfo", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustStorageUpdateInfo ~= nil then
        protoAdjust.treasurehunt_adj.AdjustStorageUpdateInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11130
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回全服转生信息
---msgID: 11132
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResReinNumMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11132 treasureHuntV2.ReinNumResponse 返回全服转生信息")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.ReinNumResponse", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustReinNumResponse ~= nil then
        protoAdjust.treasurehunt_adj.AdjustReinNumResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11132
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回挖宝仓库信息
---msgID: 11136
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDigTreasureWareHouseMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11136 treasureHuntV2.DigTreasureWareHouse 返回挖宝仓库信息")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.DigTreasureWareHouse", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustDigTreasureWareHouse ~= nil then
        protoAdjust.treasurehunt_adj.AdjustDigTreasureWareHouse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11136
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家挖宝次数
---msgID: 11139
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleDigTreasureCountMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11139 treasureHuntV2.RoleDigTreasureCount 玩家挖宝次数")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.RoleDigTreasureCount", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustRoleDigTreasureCount ~= nil then
        protoAdjust.treasurehunt_adj.AdjustRoleDigTreasureCount(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11139
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家挖宝状态数
---msgID: 11140
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDigTreasureStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11140 treasureHuntV2.DigTreasureState 玩家挖宝状态数")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.DigTreasureState", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustDigTreasureState ~= nil then
        protoAdjust.treasurehunt_adj.AdjustDigTreasureState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11140
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家挖宝状态数
---msgID: 11141
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDigTreasureItemsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11141 treasureHuntV2.DigTreasureItems 玩家挖宝状态数")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.DigTreasureItems", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustDigTreasureItems ~= nil then
        protoAdjust.treasurehunt_adj.AdjustDigTreasureItems(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11141
    protobufMgr.mMsgDeserializedTblCache = res
end

---黄金挖宝活动状态
---msgID: 11142
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGoldDigActiveStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 11142 treasureHuntV2.GoldDigActiveState 黄金挖宝活动状态")
        return nil
    end
    local res = protobufMgr.Deserialize("treasureHuntV2.GoldDigActiveState", buffer)
    if protoAdjust.treasurehunt_adj ~= nil and protoAdjust.treasurehunt_adj.AdjustGoldDigActiveState ~= nil then
        protoAdjust.treasurehunt_adj.AdjustGoldDigActiveState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 11142
    protobufMgr.mMsgDeserializedTblCache = res
end

