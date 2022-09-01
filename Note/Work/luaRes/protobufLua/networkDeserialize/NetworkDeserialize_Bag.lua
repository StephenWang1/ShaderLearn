--[[本文件为工具自动生成,禁止手动修改]]
--bag.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回请求背包
---msgID: 10002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBagInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10002 bagV2.ResBagInfo 返回请求背包")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResBagInfo", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResBagInfo ~= nil then
        protoAdjust.bag_adj.AdjustResBagInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10002
    protobufMgr.mMsgDeserializedTblCache = res
end

---背包发生变化
---msgID: 10003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBagChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10003 bagV2.ResBagChange 背包发生变化")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResBagChange", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResBagChange ~= nil then
        protoAdjust.bag_adj.AdjustResBagChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10003
    protobufMgr.mMsgDeserializedTblCache = res
end

---使用道具返回消息
---msgID: 10005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUseItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10005 bagV2.ResUseItem 使用道具返回消息")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResUseItem", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResUseItem ~= nil then
        protoAdjust.bag_adj.AdjustResUseItem(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10005
    protobufMgr.mMsgDeserializedTblCache = res
end

---回收装备
---msgID: 10009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRecycleEquipmentMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10009 bagV2.RecycleSuccess 回收装备")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.RecycleSuccess", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustRecycleSuccess ~= nil then
        protoAdjust.bag_adj.AdjustRecycleSuccess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10009
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回请求仓库
---msgID: 10022
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResStorageInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10022 bagV2.ResStorageInfo 返回请求仓库")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResStorageInfo", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResStorageInfo ~= nil then
        protoAdjust.bag_adj.AdjustResStorageInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10022
    protobufMgr.mMsgDeserializedTblCache = res
end

---仓库更新变化
---msgID: 10023
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResStorageUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10023 bagV2.ResStorageUpdate 仓库更新变化")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResStorageUpdate", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResStorageUpdate ~= nil then
        protoAdjust.bag_adj.AdjustResStorageUpdate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10023
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回增加格子上限消息
---msgID: 10027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAddStorageMaxCountMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10027 bagV2.ResAddStorageMaxCount 返回增加格子上限消息")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResAddStorageMaxCount", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResAddStorageMaxCount ~= nil then
        protoAdjust.bag_adj.AdjustResAddStorageMaxCount(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10027
    protobufMgr.mMsgDeserializedTblCache = res
end

---强化, 转移, 清除响应
---msgID: 10038
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResIntensifyMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10038 bagV2.ResIntensify 强化, 转移, 清除响应")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResIntensify", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResIntensify ~= nil then
        protoAdjust.bag_adj.AdjustResIntensify(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10038
    protobufMgr.mMsgDeserializedTblCache = res
end

---神炉升级响应
---msgID: 10042
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGodFurnaceUpGradeMessageReceived(msgID, buffer)
end

---耐久值变化响应
---msgID: 10043
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLastingUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10043 bagV2.LastingUpdate 耐久值变化响应")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.LastingUpdate", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustLastingUpdate ~= nil then
        protoAdjust.bag_adj.AdjustLastingUpdate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10043
    protobufMgr.mMsgDeserializedTblCache = res
end

---赤炎灯灯芯升级返回
---msgID: 10046
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnReslampUpgradeResMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10046 bagV2.LampUpgradeRes 赤炎灯灯芯升级返回")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.LampUpgradeRes", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustLampUpgradeRes ~= nil then
        protoAdjust.bag_adj.AdjustLampUpgradeRes(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10046
    protobufMgr.mMsgDeserializedTblCache = res
end

---生命精魄升级响应
---msgID: 10048
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpgradeSoulJadeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10048 bagV2.ResUpgradeSoulJade 生命精魄升级响应")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResUpgradeSoulJade", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResUpgradeSoulJade ~= nil then
        protoAdjust.bag_adj.AdjustResUpgradeSoulJade(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10048
    protobufMgr.mMsgDeserializedTblCache = res
end

---打开掠宝袋的返回
---msgID: 10050
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPreyTreasureBagMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10050 bagV2.PreyTreasureBagResponse 打开掠宝袋的返回")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.PreyTreasureBagResponse", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustPreyTreasureBagResponse ~= nil then
        protoAdjust.bag_adj.AdjustPreyTreasureBagResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10050
    protobufMgr.mMsgDeserializedTblCache = res
end

---掠宝袋的领取响应
---msgID: 10051
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDrawPreyTreasureBagMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10051 bagV2.DrawPreyTreasureBagResponse 掠宝袋的领取响应")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.DrawPreyTreasureBagResponse", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustDrawPreyTreasureBagResponse ~= nil then
        protoAdjust.bag_adj.AdjustDrawPreyTreasureBagResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10051
    protobufMgr.mMsgDeserializedTblCache = res
end

---魂玉合成返回
---msgID: 10056
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetNextSoulJadeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10056 bagV2.ResGetNextSoulJade 魂玉合成返回")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResGetNextSoulJade", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResGetNextSoulJade ~= nil then
        protoAdjust.bag_adj.AdjustResGetNextSoulJade(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10056
    protobufMgr.mMsgDeserializedTblCache = res
end

---装备进化返回
---msgID: 10058
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEvolveMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10058 bagV2.ResEvolve 装备进化返回")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResEvolve", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResEvolve ~= nil then
        protoAdjust.bag_adj.AdjustResEvolve(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10058
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回打捆的商店列表
---msgID: 10060
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBundlitemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10060 bagV2.ResBundlitem 返回打捆的商店列表")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResBundlitem", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResBundlitem ~= nil then
        protoAdjust.bag_adj.AdjustResBundlitem(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10060
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回成功兑换打捆商品信息
---msgID: 10062
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSuccessBuyBindlitemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10062 bagV2.ResSuccessBuyBindlitem 返回成功兑换打捆商品信息")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResSuccessBuyBindlitem", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResSuccessBuyBindlitem ~= nil then
        protoAdjust.bag_adj.AdjustResSuccessBuyBindlitem(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10062
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回快捷购买成功消息
---msgID: 10064
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBuyMaterialWaySuccessMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10064 bagV2.ResBuyMaterialWaySuccess 返回快捷购买成功消息")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResBuyMaterialWaySuccess", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResBuyMaterialWaySuccess ~= nil then
        protoAdjust.bag_adj.AdjustResBuyMaterialWaySuccess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10064
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回每日使用物品数量限制
---msgID: 10066
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDayUseItemCountMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10066 bagV2.ResDayUseItemCount 返回每日使用物品数量限制")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResDayUseItemCount", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResDayUseItemCount ~= nil then
        protoAdjust.bag_adj.AdjustResDayUseItemCount(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10066
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新物品产出
---msgID: 10070
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateItemOutputMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10070 bagV2.UpdateItemOutput 更新物品产出")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.UpdateItemOutput", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustUpdateItemOutput ~= nil then
        protoAdjust.bag_adj.AdjustUpdateItemOutput(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10070
    protobufMgr.mMsgDeserializedTblCache = res
end

---物品获得提示
---msgID: 10073
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResItemTipsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10073 bagV2.ResItemTips 物品获得提示")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResItemTips", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResItemTips ~= nil then
        protoAdjust.bag_adj.AdjustResItemTips(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10073
    protobufMgr.mMsgDeserializedTblCache = res
end

---打开掠宝袋宝箱的返回
---msgID: 10075
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPreyTreasureBoxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10075 bagV2.PreyTreasureBoxResponse 打开掠宝袋宝箱的返回")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.PreyTreasureBoxResponse", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustPreyTreasureBoxResponse ~= nil then
        protoAdjust.bag_adj.AdjustPreyTreasureBoxResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10075
    protobufMgr.mMsgDeserializedTblCache = res
end

---掠宝袋宝箱的领取响应
---msgID: 10076
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDrawPreyTreasureBoxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10076 bagV2.DrawPreyTreasureBoxResponse 掠宝袋宝箱的领取响应")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.DrawPreyTreasureBoxResponse", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustDrawPreyTreasureBoxResponse ~= nil then
        protoAdjust.bag_adj.AdjustDrawPreyTreasureBoxResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10076
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回掠宝袋宝箱使用多个请求
---msgID: 10080
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAwardPreyTreasureBoxMultiMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10080 bagV2.ResAwardPreyTreasureBoxMulti 返回掠宝袋宝箱使用多个请求")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResAwardPreyTreasureBoxMulti", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResAwardPreyTreasureBoxMulti ~= nil then
        protoAdjust.bag_adj.AdjustResAwardPreyTreasureBoxMulti(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10080
    protobufMgr.mMsgDeserializedTblCache = res
end

---熔炼物品回包
---msgID: 10083
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSmeltMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10083 bagV2.ResSmelt 熔炼物品回包")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResSmelt", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResSmelt ~= nil then
        protoAdjust.bag_adj.AdjustResSmelt(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10083
    protobufMgr.mMsgDeserializedTblCache = res
end

---熔炼血继回包
---msgID: 10085
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBloodSmeltMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10085 bagV2.ResBloodSmelt 熔炼血继回包")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResBloodSmelt", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResBloodSmelt ~= nil then
        protoAdjust.bag_adj.AdjustResBloodSmelt(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10085
    protobufMgr.mMsgDeserializedTblCache = res
end

---熔炼胜利回包
---msgID: 10087
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDivineSmeltMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10087 bagV2.ResDivineSmelt 熔炼胜利回包")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResDivineSmelt", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResDivineSmelt ~= nil then
        protoAdjust.bag_adj.AdjustResDivineSmelt(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10087
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回背包格子上限消息
---msgID: 10088
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBagSizeByMonthCardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10088 bagV2.ResBagSizeByMonthCard 返回背包格子上限消息")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResBagSizeByMonthCard", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResBagSizeByMonthCard ~= nil then
        protoAdjust.bag_adj.AdjustResBagSizeByMonthCard(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10088
    protobufMgr.mMsgDeserializedTblCache = res
end

---同步自动挖掘数量
---msgID: 10090
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateAutomaticCollectMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 10090 bagV2.ResUpdateAutomaticCollect 同步自动挖掘数量")
        return nil
    end
    local res = protobufMgr.Deserialize("bagV2.ResUpdateAutomaticCollect", buffer)
    if protoAdjust.bag_adj ~= nil and protoAdjust.bag_adj.AdjustResUpdateAutomaticCollect ~= nil then
        protoAdjust.bag_adj.AdjustResUpdateAutomaticCollect(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 10090
    protobufMgr.mMsgDeserializedTblCache = res
end

