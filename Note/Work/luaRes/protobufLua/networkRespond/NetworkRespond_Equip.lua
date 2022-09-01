--[[本文件为工具自动生成,禁止手动修改]]
--equip.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---所有装备信息
---msgID: 13001
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ResAllEquip C#数据结构
function networkRespond.OnResAllEquipMessageReceived(msgID)
    ---@type equipV2.ResAllEquip
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13001 equipV2.ResAllEquip 所有装备信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.equip ~= nil and  protobufMgr.DecodeTable.equip.ResAllEquip ~= nil then
        csData = protobufMgr.DecodeTable.equip.ResAllEquip(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---装备信息更新
---msgID: 13003
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ResEquipChange C#数据结构
function networkRespond.OnResEquipChangeMessageReceived(msgID)
    ---@type equipV2.ResEquipChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13003 equipV2.ResEquipChange 装备信息更新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.equip ~= nil and  protobufMgr.DecodeTable.equip.ResEquipChange ~= nil then
        csData = protobufMgr.DecodeTable.equip.ResEquipChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回修理装备
---msgID: 13011
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ResRepairEquip C#数据结构
function networkRespond.OnResRepairEquipMessageReceived(msgID)
    ---@type equipV2.ResRepairEquip
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13011 equipV2.ResRepairEquip 返回修理装备")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.equip ~= nil and  protobufMgr.DecodeTable.equip.ResRepairEquip ~= nil then
        csData = protobufMgr.DecodeTable.equip.ResRepairEquip(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---同步物品的使用次数
---msgID: 13012
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ItemUseCountInfo C#数据结构
function networkRespond.OnResSynItemUseCountMessageReceived(msgID)
    ---@type equipV2.ItemUseCountInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13012 equipV2.ItemUseCountInfo 同步物品的使用次数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.equip ~= nil and  protobufMgr.DecodeTable.equip.ItemUseCountInfo ~= nil then
        csData = protobufMgr.DecodeTable.equip.ItemUseCountInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回修理灵兽肉身装备
---msgID: 13014
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ResRepairServantEquip C#数据结构
function networkRespond.OnResRepairServantEquipMessageReceived(msgID)
    ---@type equipV2.ResRepairServantEquip
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13014 equipV2.ResRepairServantEquip 返回修理灵兽肉身装备")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.equip ~= nil and  protobufMgr.DecodeTable.equip.ResRepairServantEquip ~= nil then
        csData = protobufMgr.DecodeTable.equip.ResRepairServantEquip(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---装备炼制响应
---msgID: 13018
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.BagItemInfo C#数据结构
function networkRespond.OnResEquipRefineMessageReceived(msgID)
    ---@type bagV2.BagItemInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13018 bagV2.BagItemInfo 装备炼制响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.BagItemInfo ~= nil then
        csData = protobufMgr.DecodeTable.bag.BagItemInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---单个套装法宝信息
---msgID: 13021
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.MagicWeapon C#数据结构
function networkRespond.OnResMagicWeaponInfoMessageReceived(msgID)
    ---@type equipV2.MagicWeapon
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13021 equipV2.MagicWeapon 单个套装法宝信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResMagicWeaponInfoMessage", 13021, "MagicWeapon", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---全部法宝信息
---msgID: 13022
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.AllMagicWeaponInfo C#数据结构
function networkRespond.OnResAllMagicWeaponInfoMessageReceived(msgID)
    ---@type equipV2.AllMagicWeaponInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13022 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13022 equipV2.AllMagicWeaponInfo 全部法宝信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAllMagicWeaponInfoMessage", 13022, "AllMagicWeaponInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---玩家获得过的法宝类型
---msgID: 13023
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.UpdateGetedType C#数据结构
function networkRespond.OnResUpdateGetedTypeMessageReceived(msgID)
    ---@type equipV2.UpdateGetedType
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13023 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13023 equipV2.UpdateGetedType 玩家获得过的法宝类型")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUpdateGetedTypeMessage", 13023, "UpdateGetedType", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回魂装镶嵌数据
---msgID: 13027
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.AllSoulEquipInfo C#数据结构
function networkRespond.OnResAllSoulEquipInfoMessageReceived(msgID)
    ---@type equipV2.AllSoulEquipInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13027 equipV2.AllSoulEquipInfo 返回魂装镶嵌数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAllSoulEquipInfoMessage", 13027, "AllSoulEquipInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回魂装洗炼结果
---msgID: 13030
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ResRefinResult C#数据结构
function networkRespond.OnResRefinResultMessageReceived(msgID)
    ---@type equipV2.ResRefinResult
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13030 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13030 equipV2.ResRefinResult 返回魂装洗炼结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.equip ~= nil and  protobufMgr.DecodeTable.equip.ResRefinResult ~= nil then
        csData = protobufMgr.DecodeTable.equip.ResRefinResult(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---全部魂装信息
---msgID: 13031
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.WholeSoulEquips C#数据结构
function networkRespond.OnResWholeSoulEquipsMessageReceived(msgID)
    ---@type equipV2.WholeSoulEquips
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13031 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13031 equipV2.WholeSoulEquips 全部魂装信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResWholeSoulEquipsMessage", 13031, "WholeSoulEquips", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回鉴定结果
---msgID: 13033
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ResAppraisaResult C#数据结构
function networkRespond.OnResAppraisaResultMessageReceived(msgID)
    ---@type equipV2.ResAppraisaResult
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13033 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13033 equipV2.ResAppraisaResult 返回鉴定结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAppraisaResultMessage", 13033, "ResAppraisaResult", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回鉴定今日不在提示信息
---msgID: 13035
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ResAppraisaTip C#数据结构
function networkRespond.OnResResAppraisaTipMessageReceived(msgID)
    ---@type equipV2.ResAppraisaTip
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13035 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13035 equipV2.ResAppraisaTip 返回鉴定今日不在提示信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResResAppraisaTipMessage", 13035, "ResAppraisaTip", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---配饰重铸
---msgID: 13037
---@param msgID LuaEnumNetDef 消息ID
---@return equipV2.ResRecast C#数据结构
function networkRespond.OnResRecastMessageReceived(msgID)
    ---@type equipV2.ResRecast
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 13037 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 13037 equipV2.ResRecast 配饰重铸")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRecastMessage", 13037, "ResRecast", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

