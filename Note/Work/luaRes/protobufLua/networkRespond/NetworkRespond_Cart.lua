--[[本文件为工具自动生成,禁止手动修改]]
--cart.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回镖师面板
---msgID: 105002
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResBodyGuardInfo C#数据结构
function networkRespond.OnResBodyGuardInfoMessageReceived(msgID)
    ---@type cartV2.ResBodyGuardInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105002 cartV2.ResBodyGuardInfo 返回镖师面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBodyGuardInfoMessage", 105002, "ResBodyGuardInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回押镖信息
---msgID: 105005
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResUnionCartInfo C#数据结构
function networkRespond.OnResUnionCartInfoMessageReceived(msgID)
    ---@type cartV2.ResUnionCartInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105005 cartV2.ResUnionCartInfo 返回押镖信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.ResUnionCartInfo ~= nil then
        csData = protobufMgr.DecodeTable.cart.ResUnionCartInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回退出押镖响应
---msgID: 105006
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResWithdrawUnionCartMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---行会镖车结束消息
---msgID: 105007
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResUnionCartFinish C#数据结构
function networkRespond.OnResUnionCartFinishMessageReceived(msgID)
    ---@type cartV2.ResUnionCartFinish
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105007 cartV2.ResUnionCartFinish 行会镖车结束消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.ResUnionCartFinish ~= nil then
        csData = protobufMgr.DecodeTable.cart.ResUnionCartFinish(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回个人押镖列表
---msgID: 105009
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResPersonalCartList C#数据结构
function networkRespond.OnResPersonalCartListMessageReceived(msgID)
    ---@type cartV2.ResPersonalCartList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105009 cartV2.ResPersonalCartList 返回个人押镖列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.ResPersonalCartList ~= nil then
        csData = protobufMgr.DecodeTable.cart.ResPersonalCartList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回个人镖车动态
---msgID: 105010
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResPersonalCartSituation C#数据结构
function networkRespond.OnResPersonalCartSituationMessageReceived(msgID)
    ---@type cartV2.ResPersonalCartSituation
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105010 cartV2.ResPersonalCartSituation 返回个人镖车动态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.ResPersonalCartSituation ~= nil then
        csData = protobufMgr.DecodeTable.cart.ResPersonalCartSituation(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回更新个人镖车列表
---msgID: 105012
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResUpdatePersonalCart C#数据结构
function networkRespond.OnResUpdatePersonalCartMessageReceived(msgID)
    ---@type cartV2.ResUpdatePersonalCart
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105012 cartV2.ResUpdatePersonalCart 返回更新个人镖车列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.ResUpdatePersonalCart ~= nil then
        csData = protobufMgr.DecodeTable.cart.ResUpdatePersonalCart(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回个人镖车错误码
---msgID: 105014
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.CartMatterCode C#数据结构
function networkRespond.OnResCartMatterCodeMessageReceived(msgID)
    ---@type cartV2.CartMatterCode
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105014 cartV2.CartMatterCode 返回个人镖车错误码")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCartMatterCodeMessage", 105014, "CartMatterCode", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回更新个人镖车血量
---msgID: 105015
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResPersonalCartHpUpdate C#数据结构
function networkRespond.OnResPersonalCartHpUpdateMessageReceived(msgID)
    ---@type cartV2.ResPersonalCartHpUpdate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105015 cartV2.ResPersonalCartHpUpdate 返回更新个人镖车血量")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.ResPersonalCartHpUpdate ~= nil then
        csData = protobufMgr.DecodeTable.cart.ResPersonalCartHpUpdate(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回行会押镖排行
---msgID: 105017
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.UnionCartRank C#数据结构
function networkRespond.OnResUnionCartRankMessageReceived(msgID)
    ---@type cartV2.UnionCartRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105017 cartV2.UnionCartRank 返回行会押镖排行")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.UnionCartRank ~= nil then
        csData = protobufMgr.DecodeTable.cart.UnionCartRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回行会押镖上次活动排行
---msgID: 105019
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResUnionCartRankRecord C#数据结构
function networkRespond.OnResUnionCartLastRankMessageReceived(msgID)
    ---@type cartV2.ResUnionCartRankRecord
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105019 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105019 cartV2.ResUnionCartRankRecord 返回行会押镖上次活动排行")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.ResUnionCartRankRecord ~= nil then
        csData = protobufMgr.DecodeTable.cart.ResUnionCartRankRecord(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回个人镖车坐标
---msgID: 105021
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResPersonalCartPosition C#数据结构
function networkRespond.OnResPersonalCartPositionMessageReceived(msgID)
    ---@type cartV2.ResPersonalCartPosition
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105021 cartV2.ResPersonalCartPosition 返回个人镖车坐标")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.cart ~= nil and  protobufMgr.DecodeTable.cart.ResPersonalCartPosition ~= nil then
        csData = protobufMgr.DecodeTable.cart.ResPersonalCartPosition(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---运货押镖车信息
---msgID: 105023
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResFreightCarInfo C#数据结构
function networkRespond.OnResFreightCarInfoMessageReceived(msgID)
    ---@type cartV2.ResFreightCarInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105023 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105023 cartV2.ResFreightCarInfo 运货押镖车信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResFreightCarInfoMessage", 105023, "ResFreightCarInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回个人押镖信息
---msgID: 105024
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResRoleFreightInfo C#数据结构
function networkRespond.OnResRoleFreightInfoMessageReceived(msgID)
    ---@type cartV2.ResRoleFreightInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105024 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105024 cartV2.ResRoleFreightInfo 返回个人押镖信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleFreightInfoMessage", 105024, "ResRoleFreightInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返会飙车血量
---msgID: 105026
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResFreightCarHpChange C#数据结构
function networkRespond.OnResFreightCarHpChangeMessageReceived(msgID)
    ---@type cartV2.ResFreightCarHpChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105026 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105026 cartV2.ResFreightCarHpChange 返会飙车血量")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResFreightCarHpChangeMessage", 105026, "ResFreightCarHpChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回飙车XY变更
---msgID: 105027
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResFreightCarPointChange C#数据结构
function networkRespond.OnResFreightCarPointChangeMessageReceived(msgID)
    ---@type cartV2.ResFreightCarPointChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105027 cartV2.ResFreightCarPointChange 返回飙车XY变更")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResFreightCarPointChangeMessage", 105027, "ResFreightCarPointChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---送货押镖结束包
---msgID: 105028
---@param msgID LuaEnumNetDef 消息ID
---@return cartV2.ResFinishFreightCar C#数据结构
function networkRespond.OnResFinishFreightCarMessageReceived(msgID)
    ---@type cartV2.ResFinishFreightCar
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 105028 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 105028 cartV2.ResFinishFreightCar 送货押镖结束包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResFinishFreightCarMessage", 105028, "ResFinishFreightCar", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

