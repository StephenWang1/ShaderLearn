--[[本文件为工具自动生成,禁止手动修改]]
--cart.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回镖师面板
---msgID: 105002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBodyGuardInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105002 cartV2.ResBodyGuardInfo 返回镖师面板")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResBodyGuardInfo", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResBodyGuardInfo ~= nil then
        protoAdjust.cart_adj.AdjustResBodyGuardInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105002
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回押镖信息
---msgID: 105005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionCartInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105005 cartV2.ResUnionCartInfo 返回押镖信息")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResUnionCartInfo", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResUnionCartInfo ~= nil then
        protoAdjust.cart_adj.AdjustResUnionCartInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105005
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回退出押镖响应
---msgID: 105006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResWithdrawUnionCartMessageReceived(msgID, buffer)
end

---行会镖车结束消息
---msgID: 105007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionCartFinishMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105007 cartV2.ResUnionCartFinish 行会镖车结束消息")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResUnionCartFinish", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResUnionCartFinish ~= nil then
        protoAdjust.cart_adj.AdjustResUnionCartFinish(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105007
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回个人押镖列表
---msgID: 105009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPersonalCartListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105009 cartV2.ResPersonalCartList 返回个人押镖列表")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResPersonalCartList", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResPersonalCartList ~= nil then
        protoAdjust.cart_adj.AdjustResPersonalCartList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105009
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回个人镖车动态
---msgID: 105010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPersonalCartSituationMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105010 cartV2.ResPersonalCartSituation 返回个人镖车动态")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResPersonalCartSituation", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResPersonalCartSituation ~= nil then
        protoAdjust.cart_adj.AdjustResPersonalCartSituation(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105010
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回更新个人镖车列表
---msgID: 105012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdatePersonalCartMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105012 cartV2.ResUpdatePersonalCart 返回更新个人镖车列表")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResUpdatePersonalCart", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResUpdatePersonalCart ~= nil then
        protoAdjust.cart_adj.AdjustResUpdatePersonalCart(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105012
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回个人镖车错误码
---msgID: 105014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCartMatterCodeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105014 cartV2.CartMatterCode 返回个人镖车错误码")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.CartMatterCode", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustCartMatterCode ~= nil then
        protoAdjust.cart_adj.AdjustCartMatterCode(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105014
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回更新个人镖车血量
---msgID: 105015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPersonalCartHpUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105015 cartV2.ResPersonalCartHpUpdate 返回更新个人镖车血量")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResPersonalCartHpUpdate", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResPersonalCartHpUpdate ~= nil then
        protoAdjust.cart_adj.AdjustResPersonalCartHpUpdate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105015
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回行会押镖排行
---msgID: 105017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionCartRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105017 cartV2.UnionCartRank 返回行会押镖排行")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.UnionCartRank", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustUnionCartRank ~= nil then
        protoAdjust.cart_adj.AdjustUnionCartRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105017
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回行会押镖上次活动排行
---msgID: 105019
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUnionCartLastRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105019 cartV2.ResUnionCartRankRecord 返回行会押镖上次活动排行")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResUnionCartRankRecord", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResUnionCartRankRecord ~= nil then
        protoAdjust.cart_adj.AdjustResUnionCartRankRecord(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105019
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回个人镖车坐标
---msgID: 105021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPersonalCartPositionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105021 cartV2.ResPersonalCartPosition 返回个人镖车坐标")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResPersonalCartPosition", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResPersonalCartPosition ~= nil then
        protoAdjust.cart_adj.AdjustResPersonalCartPosition(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105021
    protobufMgr.mMsgDeserializedTblCache = res
end

---运货押镖车信息
---msgID: 105023
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFreightCarInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105023 cartV2.ResFreightCarInfo 运货押镖车信息")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResFreightCarInfo", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResFreightCarInfo ~= nil then
        protoAdjust.cart_adj.AdjustResFreightCarInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105023
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回个人押镖信息
---msgID: 105024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleFreightInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105024 cartV2.ResRoleFreightInfo 返回个人押镖信息")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResRoleFreightInfo", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResRoleFreightInfo ~= nil then
        protoAdjust.cart_adj.AdjustResRoleFreightInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105024
    protobufMgr.mMsgDeserializedTblCache = res
end

---返会飙车血量
---msgID: 105026
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFreightCarHpChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105026 cartV2.ResFreightCarHpChange 返会飙车血量")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResFreightCarHpChange", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResFreightCarHpChange ~= nil then
        protoAdjust.cart_adj.AdjustResFreightCarHpChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105026
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回飙车XY变更
---msgID: 105027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFreightCarPointChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105027 cartV2.ResFreightCarPointChange 返回飙车XY变更")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResFreightCarPointChange", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResFreightCarPointChange ~= nil then
        protoAdjust.cart_adj.AdjustResFreightCarPointChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105027
    protobufMgr.mMsgDeserializedTblCache = res
end

---送货押镖结束包
---msgID: 105028
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFinishFreightCarMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 105028 cartV2.ResFinishFreightCar 送货押镖结束包")
        return nil
    end
    local res = protobufMgr.Deserialize("cartV2.ResFinishFreightCar", buffer)
    if protoAdjust.cart_adj ~= nil and protoAdjust.cart_adj.AdjustResFinishFreightCar ~= nil then
        protoAdjust.cart_adj.AdjustResFinishFreightCar(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 105028
    protobufMgr.mMsgDeserializedTblCache = res
end

