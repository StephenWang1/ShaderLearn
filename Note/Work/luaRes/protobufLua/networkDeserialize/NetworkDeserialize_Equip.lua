--[[本文件为工具自动生成,禁止手动修改]]
--equip.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---所有装备信息
---msgID: 13001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllEquipMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13001 equipV2.ResAllEquip 所有装备信息")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ResAllEquip", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustResAllEquip ~= nil then
        protoAdjust.equip_adj.AdjustResAllEquip(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13001
    protobufMgr.mMsgDeserializedTblCache = res
end

---装备信息更新
---msgID: 13003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEquipChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13003 equipV2.ResEquipChange 装备信息更新")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ResEquipChange", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustResEquipChange ~= nil then
        protoAdjust.equip_adj.AdjustResEquipChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13003
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回修理装备
---msgID: 13011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRepairEquipMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13011 equipV2.ResRepairEquip 返回修理装备")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ResRepairEquip", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustResRepairEquip ~= nil then
        protoAdjust.equip_adj.AdjustResRepairEquip(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13011
    protobufMgr.mMsgDeserializedTblCache = res
end

---同步物品的使用次数
---msgID: 13012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSynItemUseCountMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13012 equipV2.ItemUseCountInfo 同步物品的使用次数")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ItemUseCountInfo", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustItemUseCountInfo ~= nil then
        protoAdjust.equip_adj.AdjustItemUseCountInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13012
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回修理灵兽肉身装备
---msgID: 13014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRepairServantEquipMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13014 equipV2.ResRepairServantEquip 返回修理灵兽肉身装备")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ResRepairServantEquip", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustResRepairServantEquip ~= nil then
        protoAdjust.equip_adj.AdjustResRepairServantEquip(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13014
    protobufMgr.mMsgDeserializedTblCache = res
end

---装备炼制响应
---msgID: 13018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEquipRefineMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13018 bagV2.BagItemInfo 装备炼制响应")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.BagItemInfo", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustBagItemInfo ~= nil then
        protoAdjust.bag_adj.AdjustBagItemInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13018
    protobufMgr.mMsgDeserializedTblCache = res
end

---单个套装法宝信息
---msgID: 13021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMagicWeaponInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13021 equipV2.MagicWeapon 单个套装法宝信息")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.MagicWeapon", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustMagicWeapon ~= nil then
        protoAdjust.equip_adj.AdjustMagicWeapon(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13021
    protobufMgr.mMsgDeserializedTblCache = res
end

---全部法宝信息
---msgID: 13022
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllMagicWeaponInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13022 equipV2.AllMagicWeaponInfo 全部法宝信息")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.AllMagicWeaponInfo", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustAllMagicWeaponInfo ~= nil then
        protoAdjust.equip_adj.AdjustAllMagicWeaponInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13022
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家获得过的法宝类型
---msgID: 13023
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateGetedTypeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13023 equipV2.UpdateGetedType 玩家获得过的法宝类型")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.UpdateGetedType", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustUpdateGetedType ~= nil then
        protoAdjust.equip_adj.AdjustUpdateGetedType(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13023
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回魂装镶嵌数据
---msgID: 13027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllSoulEquipInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13027 equipV2.AllSoulEquipInfo 返回魂装镶嵌数据")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.AllSoulEquipInfo", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustAllSoulEquipInfo ~= nil then
        protoAdjust.equip_adj.AdjustAllSoulEquipInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13027
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回魂装洗炼结果
---msgID: 13030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRefinResultMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13030 equipV2.ResRefinResult 返回魂装洗炼结果")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ResRefinResult", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustResRefinResult ~= nil then
        protoAdjust.equip_adj.AdjustResRefinResult(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13030
    protobufMgr.mMsgDeserializedTblCache = res
end

---全部魂装信息
---msgID: 13031
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResWholeSoulEquipsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13031 equipV2.WholeSoulEquips 全部魂装信息")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.WholeSoulEquips", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustWholeSoulEquips ~= nil then
        protoAdjust.equip_adj.AdjustWholeSoulEquips(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13031
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回鉴定结果
---msgID: 13033
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAppraisaResultMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13033 equipV2.ResAppraisaResult 返回鉴定结果")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ResAppraisaResult", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustResAppraisaResult ~= nil then
        protoAdjust.equip_adj.AdjustResAppraisaResult(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13033
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回鉴定今日不在提示信息
---msgID: 13035
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResResAppraisaTipMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13035 equipV2.ResAppraisaTip 返回鉴定今日不在提示信息")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ResAppraisaTip", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustResAppraisaTip ~= nil then
        protoAdjust.equip_adj.AdjustResAppraisaTip(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13035
    protobufMgr.mMsgDeserializedTblCache = res
end

---配饰重铸
---msgID: 13037
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRecastMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 13037 equipV2.ResRecast 配饰重铸")
        return nil
    end
    local res = protobufMgr.Deserialize("equipV2.ResRecast", buffer)
    if protoAdjust.equip_adj ~= nil and protoAdjust.equip_adj.AdjustResRecast ~= nil then
        protoAdjust.equip_adj.AdjustResRecast(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 13037
    protobufMgr.mMsgDeserializedTblCache = res
end

