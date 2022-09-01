--[[本文件为工具自动生成,禁止手动修改]]
--bag.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回请求背包
---msgID: 10002
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResBagInfo C#数据结构
function networkRespond.OnResBagInfoMessageReceived(msgID)
    ---@type bagV2.ResBagInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10002 bagV2.ResBagInfo 返回请求背包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResBagInfo ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResBagInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---背包发生变化
---msgID: 10003
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResBagChange C#数据结构
function networkRespond.OnResBagChangeMessageReceived(msgID)
    ---@type bagV2.ResBagChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10003 bagV2.ResBagChange 背包发生变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResBagChange ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResBagChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---使用道具返回消息
---msgID: 10005
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResUseItem C#数据结构
function networkRespond.OnResUseItemMessageReceived(msgID)
    ---@type bagV2.ResUseItem
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10005 bagV2.ResUseItem 使用道具返回消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResUseItem ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResUseItem(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---回收装备
---msgID: 10009
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.RecycleSuccess C#数据结构
function networkRespond.OnResRecycleEquipmentMessageReceived(msgID)
    ---@type bagV2.RecycleSuccess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10009 bagV2.RecycleSuccess 回收装备")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRecycleEquipmentMessage", 10009, "RecycleSuccess", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回请求仓库
---msgID: 10022
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResStorageInfo C#数据结构
function networkRespond.OnResStorageInfoMessageReceived(msgID)
    ---@type bagV2.ResStorageInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10022 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10022 bagV2.ResStorageInfo 返回请求仓库")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResStorageInfo ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResStorageInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---仓库更新变化
---msgID: 10023
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResStorageUpdate C#数据结构
function networkRespond.OnResStorageUpdateMessageReceived(msgID)
    ---@type bagV2.ResStorageUpdate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10023 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10023 bagV2.ResStorageUpdate 仓库更新变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResStorageUpdate ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResStorageUpdate(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回增加格子上限消息
---msgID: 10027
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResAddStorageMaxCount C#数据结构
function networkRespond.OnResAddStorageMaxCountMessageReceived(msgID)
    ---@type bagV2.ResAddStorageMaxCount
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10027 bagV2.ResAddStorageMaxCount 返回增加格子上限消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResAddStorageMaxCount ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResAddStorageMaxCount(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---强化, 转移, 清除响应
---msgID: 10038
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResIntensify C#数据结构
function networkRespond.OnResIntensifyMessageReceived(msgID)
    ---@type bagV2.ResIntensify
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10038 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10038 bagV2.ResIntensify 强化, 转移, 清除响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResIntensify ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResIntensify(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---神炉升级响应
---msgID: 10042
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResGodFurnaceUpGradeMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---耐久值变化响应
---msgID: 10043
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.LastingUpdate C#数据结构
function networkRespond.OnResLastingUpdateMessageReceived(msgID)
    ---@type bagV2.LastingUpdate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10043 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10043 bagV2.LastingUpdate 耐久值变化响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.LastingUpdate ~= nil then
        csData = protobufMgr.DecodeTable.bag.LastingUpdate(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---赤炎灯灯芯升级返回
---msgID: 10046
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.LampUpgradeRes C#数据结构
function networkRespond.OnReslampUpgradeResMessageReceived(msgID)
    ---@type bagV2.LampUpgradeRes
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10046 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10046 bagV2.LampUpgradeRes 赤炎灯灯芯升级返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ReslampUpgradeResMessage", 10046, "LampUpgradeRes", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---生命精魄升级响应
---msgID: 10048
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResUpgradeSoulJade C#数据结构
function networkRespond.OnResUpgradeSoulJadeMessageReceived(msgID)
    ---@type bagV2.ResUpgradeSoulJade
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10048 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10048 bagV2.ResUpgradeSoulJade 生命精魄升级响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUpgradeSoulJadeMessage", 10048, "ResUpgradeSoulJade", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---打开掠宝袋的返回
---msgID: 10050
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.PreyTreasureBagResponse C#数据结构
function networkRespond.OnResPreyTreasureBagMessageReceived(msgID)
    ---@type bagV2.PreyTreasureBagResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10050 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10050 bagV2.PreyTreasureBagResponse 打开掠宝袋的返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.PreyTreasureBagResponse ~= nil then
        csData = protobufMgr.DecodeTable.bag.PreyTreasureBagResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---掠宝袋的领取响应
---msgID: 10051
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.DrawPreyTreasureBagResponse C#数据结构
function networkRespond.OnResDrawPreyTreasureBagMessageReceived(msgID)
    ---@type bagV2.DrawPreyTreasureBagResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10051 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10051 bagV2.DrawPreyTreasureBagResponse 掠宝袋的领取响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDrawPreyTreasureBagMessage", 10051, "DrawPreyTreasureBagResponse", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---魂玉合成返回
---msgID: 10056
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResGetNextSoulJade C#数据结构
function networkRespond.OnResGetNextSoulJadeMessageReceived(msgID)
    ---@type bagV2.ResGetNextSoulJade
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10056 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10056 bagV2.ResGetNextSoulJade 魂玉合成返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetNextSoulJadeMessage", 10056, "ResGetNextSoulJade", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---装备进化返回
---msgID: 10058
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResEvolve C#数据结构
function networkRespond.OnResEvolveMessageReceived(msgID)
    ---@type bagV2.ResEvolve
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10058 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10058 bagV2.ResEvolve 装备进化返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResEvolve ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResEvolve(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回打捆的商店列表
---msgID: 10060
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResBundlitem C#数据结构
function networkRespond.OnResBundlitemMessageReceived(msgID)
    ---@type bagV2.ResBundlitem
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10060 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10060 bagV2.ResBundlitem 返回打捆的商店列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBundlitemMessage", 10060, "ResBundlitem", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回成功兑换打捆商品信息
---msgID: 10062
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResSuccessBuyBindlitem C#数据结构
function networkRespond.OnResSuccessBuyBindlitemMessageReceived(msgID)
    ---@type bagV2.ResSuccessBuyBindlitem
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10062 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10062 bagV2.ResSuccessBuyBindlitem 返回成功兑换打捆商品信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSuccessBuyBindlitemMessage", 10062, "ResSuccessBuyBindlitem", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回快捷购买成功消息
---msgID: 10064
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResBuyMaterialWaySuccess C#数据结构
function networkRespond.OnResBuyMaterialWaySuccessMessageReceived(msgID)
    ---@type bagV2.ResBuyMaterialWaySuccess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10064 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10064 bagV2.ResBuyMaterialWaySuccess 返回快捷购买成功消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBuyMaterialWaySuccessMessage", 10064, "ResBuyMaterialWaySuccess", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回每日使用物品数量限制
---msgID: 10066
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResDayUseItemCount C#数据结构
function networkRespond.OnResDayUseItemCountMessageReceived(msgID)
    ---@type bagV2.ResDayUseItemCount
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10066 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10066 bagV2.ResDayUseItemCount 返回每日使用物品数量限制")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResDayUseItemCount ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResDayUseItemCount(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新物品产出
---msgID: 10070
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.UpdateItemOutput C#数据结构
function networkRespond.OnResUpdateItemOutputMessageReceived(msgID)
    ---@type bagV2.UpdateItemOutput
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10070 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10070 bagV2.UpdateItemOutput 更新物品产出")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.UpdateItemOutput ~= nil then
        csData = protobufMgr.DecodeTable.bag.UpdateItemOutput(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---物品获得提示
---msgID: 10073
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResItemTips C#数据结构
function networkRespond.OnResItemTipsMessageReceived(msgID)
    ---@type bagV2.ResItemTips
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10073 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10073 bagV2.ResItemTips 物品获得提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResItemTips ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResItemTips(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---打开掠宝袋宝箱的返回
---msgID: 10075
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.PreyTreasureBoxResponse C#数据结构
function networkRespond.OnResPreyTreasureBoxMessageReceived(msgID)
    ---@type bagV2.PreyTreasureBoxResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10075 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10075 bagV2.PreyTreasureBoxResponse 打开掠宝袋宝箱的返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.PreyTreasureBoxResponse ~= nil then
        csData = protobufMgr.DecodeTable.bag.PreyTreasureBoxResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---掠宝袋宝箱的领取响应
---msgID: 10076
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.DrawPreyTreasureBoxResponse C#数据结构
function networkRespond.OnResDrawPreyTreasureBoxMessageReceived(msgID)
    ---@type bagV2.DrawPreyTreasureBoxResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10076 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10076 bagV2.DrawPreyTreasureBoxResponse 掠宝袋宝箱的领取响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.DrawPreyTreasureBoxResponse ~= nil then
        csData = protobufMgr.DecodeTable.bag.DrawPreyTreasureBoxResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回掠宝袋宝箱使用多个请求
---msgID: 10080
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResAwardPreyTreasureBoxMulti C#数据结构
function networkRespond.OnResAwardPreyTreasureBoxMultiMessageReceived(msgID)
    ---@type bagV2.ResAwardPreyTreasureBoxMulti
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10080 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10080 bagV2.ResAwardPreyTreasureBoxMulti 返回掠宝袋宝箱使用多个请求")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResAwardPreyTreasureBoxMulti ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResAwardPreyTreasureBoxMulti(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---熔炼物品回包
---msgID: 10083
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResSmelt C#数据结构
function networkRespond.OnResSmeltMessageReceived(msgID)
    ---@type bagV2.ResSmelt
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10083 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10083 bagV2.ResSmelt 熔炼物品回包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSmeltMessage", 10083, "ResSmelt", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---熔炼血继回包
---msgID: 10085
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResBloodSmelt C#数据结构
function networkRespond.OnResBloodSmeltMessageReceived(msgID)
    ---@type bagV2.ResBloodSmelt
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10085 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10085 bagV2.ResBloodSmelt 熔炼血继回包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.bag ~= nil and  protobufMgr.DecodeTable.bag.ResBloodSmelt ~= nil then
        csData = protobufMgr.DecodeTable.bag.ResBloodSmelt(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---熔炼胜利回包
---msgID: 10087
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResDivineSmelt C#数据结构
function networkRespond.OnResDivineSmeltMessageReceived(msgID)
    ---@type bagV2.ResDivineSmelt
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10087 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10087 bagV2.ResDivineSmelt 熔炼胜利回包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDivineSmeltMessage", 10087, "ResDivineSmelt", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回背包格子上限消息
---msgID: 10088
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResBagSizeByMonthCard C#数据结构
function networkRespond.OnResBagSizeByMonthCardMessageReceived(msgID)
    ---@type bagV2.ResBagSizeByMonthCard
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10088 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10088 bagV2.ResBagSizeByMonthCard 返回背包格子上限消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBagSizeByMonthCardMessage", 10088, "ResBagSizeByMonthCard", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---同步自动挖掘数量
---msgID: 10090
---@param msgID LuaEnumNetDef 消息ID
---@return bagV2.ResUpdateAutomaticCollect C#数据结构
function networkRespond.OnResUpdateAutomaticCollectMessageReceived(msgID)
    ---@type bagV2.ResUpdateAutomaticCollect
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 10090 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 10090 bagV2.ResUpdateAutomaticCollect 同步自动挖掘数量")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUpdateAutomaticCollectMessage", 10090, "ResUpdateAutomaticCollect", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

