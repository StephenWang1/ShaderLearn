--[[本文件为工具自动生成,禁止手动修改]]
--bag.xml

--region ID:10001 请求背包信息
---请求背包信息
---msgID: 10001
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBagInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBagInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBagInfoMessage](LuaEnumNetDef.ReqBagInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqBagInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:10004 请求使用道具
---请求使用道具
---msgID: 10004
---@param count number 必填参数 道具数量
---@param itemId number 必填参数 物品唯一ID
---@param clientParam number 选填参数 使用参数 聚灵珠： 1：正常倍数 2：多倍
---@param clientParams table<number> 列表参数 使用参数列表，主要是使用宝箱多选多
---@param clientParamStrs table<string> 列表参数 使用参数（string类型的）
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseItem(count, itemId, clientParam, clientParams, clientParamStrs)
    local reqTable = {}
    reqTable.count = count
    reqTable.itemId = itemId
    if clientParam ~= nil then
        reqTable.clientParam = clientParam
    end
    if clientParams ~= nil then
        reqTable.clientParams = clientParams
    else
        reqTable.clientParams = {}
    end
    if clientParamStrs ~= nil then
        reqTable.clientParamStrs = clientParamStrs
    else
        reqTable.clientParamStrs = {}
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.UseItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseItemMessage](LuaEnumNetDef.ReqUseItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseItemMessage", 10004, "UseItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10006 增加装备页签格子上限消息
---增加装备页签格子上限消息
---msgID: 10006
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddEquipMaxCount()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddEquipMaxCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddEquipMaxCountMessage](LuaEnumNetDef.ReqAddEquipMaxCountMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqAddEquipMaxCountMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:10007 请求回收装备
---请求回收装备
---msgID: 10007
---@param recycleList System.Collections.Generic.List1T<number> 列表参数 回收列表(唯一id)
---@param intensifyLv number 选填参数 强化等级
---@param recycleData System.Collections.Generic.List1T<number> 列表参数 回收设置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRecycleEquipment(recycleList, intensifyLv, recycleData)
    local reqData = CS.bagV2.RecycleEquipmentRequest()
    if recycleList ~= nil then
        reqData.recycleList:AddRange(recycleList)
    end
    if intensifyLv ~= nil then
        reqData.intensifyLv = intensifyLv
    end
    if recycleData ~= nil then
        reqData.recycleData:AddRange(recycleData)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRecycleEquipmentMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRecycleEquipmentMessage](LuaEnumNetDef.ReqRecycleEquipmentMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRecycleEquipmentMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:10011 请求使用副本道具
---请求使用副本道具
---msgID: 10011
---@param line number 选填参数 副本唯一id
---@param globalId number 选填参数 globalId(35/36)
---@param instanceId number 选填参数 副本id
---@param useTime number 选填参数 战报中时间 攻击药水使用要用
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseInstanceItem(line, globalId, instanceId, useTime)
    local reqTable = {}
    if line ~= nil then
        reqTable.line = line
    end
    if globalId ~= nil then
        reqTable.globalId = globalId
    end
    if instanceId ~= nil then
        reqTable.instanceId = instanceId
    end
    if useTime ~= nil then
        reqTable.useTime = useTime
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.UseInstanceItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseInstanceItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseInstanceItemMessage](LuaEnumNetDef.ReqUseInstanceItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseInstanceItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseInstanceItemMessage", 10011, "UseInstanceItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10013 请求vip回收装备
---请求vip回收装备
---msgID: 10013
---@param recycleList System.Collections.Generic.List1T<number> 列表参数 回收列表(唯一id)
---@return boolean 网络请求是否成功发送
function networkRequest.ReqVipRecycleEquipment(recycleList)
    local reqData = CS.bagV2.VipRecycleEquipmentRequest()
    if recycleList ~= nil then
        reqData.recycleList:AddRange(recycleList)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqVipRecycleEquipmentMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqVipRecycleEquipmentMessage](LuaEnumNetDef.ReqVipRecycleEquipmentMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqVipRecycleEquipmentMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:10014 请删除特殊道具
---请删除特殊道具
---msgID: 10014
---@param uniqueId number 必填参数 道具唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDeleteSpecialItem(uniqueId)
    local reqTable = {}
    reqTable.uniqueId = uniqueId
    local reqMsgData = protobufMgr.Serialize("bagV2.DeleteSpecialItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDeleteSpecialItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDeleteSpecialItemMessage](LuaEnumNetDef.ReqDeleteSpecialItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDeleteSpecialItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDeleteSpecialItemMessage", 10014, "DeleteSpecialItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10016 出售活动道具
---出售活动道具
---msgID: 10016
---@param itemId number 必填参数 道具id
---@param count number 必填参数 数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSellActivityItem(itemId, count)
    local reqTable = {}
    reqTable.itemId = itemId
    reqTable.count = count
    local reqMsgData = protobufMgr.Serialize("bagV2.SellActivityItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSellActivityItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSellActivityItemMessage](LuaEnumNetDef.ReqSellActivityItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSellActivityItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSellActivityItemMessage", 10016, "SellActivityItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10017 请求抽奖
---请求抽奖
---msgID: 10017
---@param itemId number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStartZhuanPan(itemId)
    local reqTable = {}
    reqTable.itemId = itemId
    local reqMsgData = protobufMgr.Serialize("bagV2.StartZhuanPanRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStartZhuanPanMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStartZhuanPanMessage](LuaEnumNetDef.ReqStartZhuanPanMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqStartZhuanPanMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqStartZhuanPanMessage", 10017, "StartZhuanPanRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10020 请求特殊道具激活情况
---请求特殊道具激活情况
---msgID: 10020
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSpecialItemActivate()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSpecialItemActivateMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSpecialItemActivateMessage](LuaEnumNetDef.ReqSpecialItemActivateMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSpecialItemActivateMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:10021 请求仓库信息
---请求仓库信息
---msgID: 10021
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStorageInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStorageInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStorageInfoMessage](LuaEnumNetDef.ReqStorageInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqStorageInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:10024 请求提取道具
---请求提取道具
---msgID: 10024
---@param objId number 必填参数 道具id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStorageOutItem(objId)
    local reqTable = {}
    reqTable.objId = objId
    local reqMsgData = protobufMgr.Serialize("bagV2.StorageOutItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStorageOutItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStorageOutItemMessage](LuaEnumNetDef.ReqStorageOutItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqStorageOutItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqStorageOutItemMessage", 10024, "StorageOutItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10025 请求存储道具
---请求存储道具
---msgID: 10025
---@param objId number 必填参数 道具id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqStorageInItem(objId)
    local reqTable = {}
    reqTable.objId = objId
    local reqMsgData = protobufMgr.Serialize("bagV2.StorageInItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqStorageInItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqStorageInItemMessage](LuaEnumNetDef.ReqStorageInItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqStorageInItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqStorageInItemMessage", 10025, "StorageInItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10026 请求增加格子上限消息
---请求增加格子上限消息
---msgID: 10026
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddStorageMaxCount()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddStorageMaxCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddStorageMaxCountMessage](LuaEnumNetDef.ReqAddStorageMaxCountMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqAddStorageMaxCountMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:10028 请求整理仓库
---请求整理仓库
---msgID: 10028
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTidyStorage()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTidyStorageMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTidyStorageMessage](LuaEnumNetDef.ReqTidyStorageMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTidyStorageMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:10029 添加交易物品
---添加交易物品
---msgID: 10029
---@param lid number 选填参数 物品唯一ID
---@param itemId number 选填参数 物品ID
---@param count number 选填参数 物品数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAddTradeItem(lid, itemId, count)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.AddTradeItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAddTradeItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAddTradeItemMessage](LuaEnumNetDef.ReqAddTradeItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAddTradeItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAddTradeItemMessage", 10029, "AddTradeItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10031 请求丢弃道具
---请求丢弃道具
---msgID: 10031
---@param objId number 必填参数 道具唯一id
---@param count number 必填参数 丢弃数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDiscardItem(objId, count)
    local reqTable = {}
    reqTable.objId = objId
    reqTable.count = count
    local reqMsgData = protobufMgr.Serialize("bagV2.DiscardItemRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDiscardItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDiscardItemMessage](LuaEnumNetDef.ReqDiscardItemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDiscardItemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDiscardItemMessage", 10031, "DiscardItemRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10033 物品拆分请求
---物品拆分请求
---msgID: 10033
---@param itemId number 必填参数 道具唯一id
---@param count number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqItemApart(itemId, count)
    local reqTable = {}
    reqTable.itemId = itemId
    reqTable.count = count
    local reqMsgData = protobufMgr.Serialize("bagV2.ItemApart" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqItemApartMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqItemApartMessage](LuaEnumNetDef.ReqItemApartMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqItemApartMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqItemApartMessage", 10033, "ItemApart", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10035 强化装备请求
---强化装备请求
---msgID: 10035
---@param equipId number 必填参数 穿在身上的填负的位置, 在背包里的填唯一 ID
---@param itemId number 选填参数 itemConfigId
---@return boolean 网络请求是否成功发送
function networkRequest.ReqIntensify(equipId, itemId)
    local reqTable = {}
    reqTable.equipId = equipId
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqIntensify" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqIntensifyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqIntensifyMessage](LuaEnumNetDef.ReqIntensifyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqIntensifyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqIntensifyMessage", 10035, "ReqIntensify", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10036 强化转移请求
---强化转移请求
---msgID: 10036
---@param oldEquipId number 必填参数 源装备, 穿在身上的填负的位置, 在背包里的填唯一 ID
---@param newEquipId number 必填参数 目标装备, 同上
---@return boolean 网络请求是否成功发送
function networkRequest.ReqIntensifyTransfer(oldEquipId, newEquipId)
    local reqTable = {}
    reqTable.oldEquipId = oldEquipId
    reqTable.newEquipId = newEquipId
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqIntensifyTrans" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqIntensifyTransferMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqIntensifyTransferMessage](LuaEnumNetDef.ReqIntensifyTransferMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqIntensifyTransferMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqIntensifyTransferMessage", 10036, "ReqIntensifyTrans", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10037 清除强化请求
---清除强化请求
---msgID: 10037
---@param equipId number 必填参数 穿在身上的填负的位置, 在背包里的填唯一 ID
---@param itemId number 选填参数 itemConfigId
---@return boolean 网络请求是否成功发送
function networkRequest.ReqIntensifyClear(equipId, itemId)
    local reqTable = {}
    reqTable.equipId = equipId
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqIntensify" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqIntensifyClearMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqIntensifyClearMessage](LuaEnumNetDef.ReqIntensifyClearMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqIntensifyClearMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqIntensifyClearMessage", 10037, "ReqIntensify", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10039 请求销毁道具
---请求销毁道具
---msgID: 10039
---@param objId number 必填参数 道具唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDestruction(objId)
    local reqTable = {}
    reqTable.objId = objId
    local reqMsgData = protobufMgr.Serialize("bagV2.Destruction" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDestructionMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDestructionMessage](LuaEnumNetDef.ReqDestructionMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDestructionMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDestructionMessage", 10039, "Destruction", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10040 整理背包
---整理背包
---msgID: 10040
---@param itemId System.Collections.Generic.List1T<number> 列表参数 整理时顺便使用的道具的唯一id列表
---@return boolean 网络请求是否成功发送
function networkRequest.ReqTidyItem(itemId)
    local reqData = CS.bagV2.TidyItem()
    if itemId ~= nil then
        reqData.itemId:AddRange(itemId)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqTidyItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqTidyItemMessage](LuaEnumNetDef.ReqTidyItemMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqTidyItemMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:10041 神炉升级请求
---神炉升级请求
---msgID: 10041
---@param currentId number 必填参数 当前id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGodFurnaceUpGrade(currentId)
    local reqTable = {}
    reqTable.currentId = currentId
    local reqMsgData = protobufMgr.Serialize("bagV2.GemUpgrade" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGodFurnaceUpGradeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGodFurnaceUpGradeMessage](LuaEnumNetDef.ReqGodFurnaceUpGradeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGodFurnaceUpGradeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGodFurnaceUpGradeMessage", 10041, "GemUpgrade", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10044 批量使用聚灵珠
---批量使用聚灵珠
---msgID: 10044
---@param data number 必填参数 倍数 1：正常倍数 2：多倍
---@param useSpiritPoint number 选填参数 是否使用聚灵点 1.是 0.否
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseAllExpBox(data, useSpiritPoint)
    local reqTable = {}
    reqTable.data = data
    if useSpiritPoint ~= nil then
        reqTable.useSpiritPoint = useSpiritPoint
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.UseAllExpBox" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseAllExpBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseAllExpBoxMessage](LuaEnumNetDef.ReqUseAllExpBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseAllExpBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseAllExpBoxMessage", 10044, "UseAllExpBox", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10045 赤炎灯灯芯升级
---赤炎灯灯芯升级
---msgID: 10045
---@param currentId number 必填参数 当前灯或元灵configId
---@param lampId number 必填参数 当前灯芯、进攻、守护之源configId
---@param type number 必填参数 1:赤炎灯 2:进攻之源 3:守护之源
---@return boolean 网络请求是否成功发送
function networkRequest.ReqlampUpgrade(currentId, lampId, type)
    local reqTable = {}
    reqTable.currentId = currentId
    reqTable.lampId = lampId
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("bagV2.LampUpgrade" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqlampUpgradeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqlampUpgradeMessage](LuaEnumNetDef.ReqlampUpgradeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqlampUpgradeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqlampUpgradeMessage", 10045, "LampUpgrade", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10047 生命精魄升级
---生命精魄升级
---msgID: 10047
---@param soulJadeId number 必填参数 当前魂玉id
---@param thisId number 必填参数 当前生命精魄id
---@param type number 必填参数 生命精魄升级消耗材料的数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpgradeSoulJade(soulJadeId, thisId, type)
    local reqTable = {}
    reqTable.soulJadeId = soulJadeId
    reqTable.thisId = thisId
    reqTable.type = type
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqUpgradeSoulJade" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpgradeSoulJadeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpgradeSoulJadeMessage](LuaEnumNetDef.ReqUpgradeSoulJadeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpgradeSoulJadeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpgradeSoulJadeMessage", 10047, "ReqUpgradeSoulJade", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10049 掠宝袋领取请求
---掠宝袋领取请求
---msgID: 10049
---@param lid number 选填参数 宝箱的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawPreyTreasureBag(lid)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.DrawPreyTreasureBag" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawPreyTreasureBagMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawPreyTreasureBagMessage](LuaEnumNetDef.ReqDrawPreyTreasureBagMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawPreyTreasureBagMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawPreyTreasureBagMessage", 10049, "DrawPreyTreasureBag", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10053 掠宝袋的抽奖
---掠宝袋的抽奖
---msgID: 10053
---@param lid number 选填参数 宝箱的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRafflePreyTreasureBag(lid)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.RafflePreyTreasureBag" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRafflePreyTreasureBagMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRafflePreyTreasureBagMessage](LuaEnumNetDef.ReqRafflePreyTreasureBagMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRafflePreyTreasureBagMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRafflePreyTreasureBagMessage", 10053, "RafflePreyTreasureBag", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10054 删除到期道具
---删除到期道具
---msgID: 10054
---@param itemIdList System.Collections.Generic.List1T<number> 列表参数 到期道具的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRemoveTimeEndItem(itemIdList)
    local reqData = CS.bagV2.RemoveTimeEnd()
    if itemIdList ~= nil then
        reqData.itemIdList:AddRange(itemIdList)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRemoveTimeEndItemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRemoveTimeEndItemMessage](LuaEnumNetDef.ReqRemoveTimeEndItemMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRemoveTimeEndItemMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:10055 魂玉合成请求
---魂玉合成请求
---msgID: 10055
---@param thisId number 选填参数 选择的魂玉ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetNextSoulJade(thisId)
    local reqTable = {}
    if thisId ~= nil then
        reqTable.thisId = thisId
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqGetNextSoulJade" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetNextSoulJadeMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetNextSoulJadeMessage](LuaEnumNetDef.ReqGetNextSoulJadeMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetNextSoulJadeMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetNextSoulJadeMessage", 10055, "ReqGetNextSoulJade", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10057 装备进化请求
---装备进化请求
---msgID: 10057
---@param equipId number 选填参数 要进化的装备
---@param sacrifices System.Collections.Generic.List1T<number> 列表参数 被消耗的装备列表
---@param type number 选填参数 要进化的类型 1神2圣3至尊
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEvolve(equipId, sacrifices, type)
    local reqData = CS.bagV2.ReqEvolve()
    if equipId ~= nil then
        reqData.equipId = equipId
    end
    if sacrifices ~= nil then
        reqData.sacrifices:AddRange(sacrifices)
    end
    if type ~= nil then
        reqData.type = type
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEvolveMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEvolveMessage](LuaEnumNetDef.ReqEvolveMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqEvolveMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:10059 请求打捆的商店列表
---请求打捆的商店列表
---msgID: 10059
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBundlitem()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBundlitemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBundlitemMessage](LuaEnumNetDef.ReqBundlitemMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqBundlitemMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:10061 请求购买打捆的物品
---请求购买打捆的物品
---msgID: 10061
---@param itemId number 选填参数
---@param count number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyResBundlitem(itemId, count)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqBuyResBundlitem" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyResBundlitemMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyResBundlitemMessage](LuaEnumNetDef.ReqBuyResBundlitemMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyResBundlitemMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyResBundlitemMessage", 10061, "ReqBuyResBundlitem", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10063 请求快捷购买物品
---请求快捷购买物品
---msgID: 10063
---@param itemId number 选填参数 购买的物品ID
---@param count number 选填参数 购买的物品数量
---@param materialId number 选填参数 要消耗的物品ID
---@param materialCount number 选填参数 要消耗的物品数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBuyMaterialWay(itemId, count, materialId, materialCount)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    if materialId ~= nil then
        reqTable.materialId = materialId
    end
    if materialCount ~= nil then
        reqTable.materialCount = materialCount
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqBuyMaterialWay" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBuyMaterialWayMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBuyMaterialWayMessage](LuaEnumNetDef.ReqBuyMaterialWayMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBuyMaterialWayMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBuyMaterialWayMessage", 10063, "ReqBuyMaterialWay", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10065 请求每日使用物品数量限制
---请求每日使用物品数量限制
---msgID: 10065
---@param itemId number 选填参数 物品cfgId
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDayUseItemCount(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqDayUseItemCount" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDayUseItemCountMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDayUseItemCountMessage](LuaEnumNetDef.ReqDayUseItemCountMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDayUseItemCountMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDayUseItemCountMessage", 10065, "ReqDayUseItemCount", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10067 请求能否使用聚灵珠
---请求能否使用聚灵珠
---msgID: 10067
---@param itemId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCanUseGatherSpiritBead(itemId)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqCanUseGatherSpiritBead" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCanUseGatherSpiritBeadMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCanUseGatherSpiritBeadMessage](LuaEnumNetDef.ReqCanUseGatherSpiritBeadMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCanUseGatherSpiritBeadMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCanUseGatherSpiritBeadMessage", 10067, "ReqCanUseGatherSpiritBead", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10071 使用兑换码
---使用兑换码
---msgID: 10071
---@param cdKey string 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseCDKey(cdKey)
    local reqTable = {}
    reqTable.cdKey = cdKey
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqUseCDKey" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseCDKeyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseCDKeyMessage](LuaEnumNetDef.ReqUseCDKeyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseCDKeyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseCDKeyMessage", 10071, "ReqUseCDKey", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10072 请求使用间谍牌
---请求使用间谍牌
---msgID: 10072
---@param itemLid number 选填参数 物品的唯一ID
---@param roleLid number 选填参数 变身成目标玩家的玩家ID
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseSpyBrand(itemLid, roleLid)
    local reqTable = {}
    if itemLid ~= nil then
        reqTable.itemLid = itemLid
    end
    if roleLid ~= nil then
        reqTable.roleLid = roleLid
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqUseSpyBrand" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseSpyBrandMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseSpyBrandMessage](LuaEnumNetDef.ReqUseSpyBrandMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseSpyBrandMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseSpyBrandMessage", 10072, "ReqUseSpyBrand", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10074 批量使用聚灵珠
---批量使用聚灵珠
---msgID: 10074
---@param itemId number 选填参数 聚灵珠id
---@param count number 选填参数 使用数量
---@param useSpiritPoint number 选填参数 是否使用聚灵点 1.是 0.否
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseExpBox(itemId, count, useSpiritPoint)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    if useSpiritPoint ~= nil then
        reqTable.useSpiritPoint = useSpiritPoint
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.UseExpBox" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseExpBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseExpBoxMessage](LuaEnumNetDef.ReqUseExpBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseExpBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseExpBoxMessage", 10074, "UseExpBox", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10077 掠宝袋宝箱的抽奖
---掠宝袋宝箱的抽奖
---msgID: 10077
---@param lid number 选填参数 宝箱的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRafflePreyTreasureBox(lid)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.RafflePreyTreasureBox" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRafflePreyTreasureBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRafflePreyTreasureBoxMessage](LuaEnumNetDef.ReqRafflePreyTreasureBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRafflePreyTreasureBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRafflePreyTreasureBoxMessage", 10077, "RafflePreyTreasureBox", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10078 掠宝袋宝箱领取请求
---掠宝袋宝箱领取请求
---msgID: 10078
---@param lid number 选填参数 宝箱的唯一id
---@param dayCount number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDrawPreyTreasureBox(lid, dayCount)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if dayCount ~= nil then
        reqTable.dayCount = dayCount
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.DrawPreyTreasureBox" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDrawPreyTreasureBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDrawPreyTreasureBoxMessage](LuaEnumNetDef.ReqDrawPreyTreasureBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDrawPreyTreasureBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDrawPreyTreasureBoxMessage", 10078, "DrawPreyTreasureBox", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10079 掠宝袋宝箱使用多个请求
---掠宝袋宝箱使用多个请求
---msgID: 10079
---@param itemId number 选填参数 宝箱配置id
---@param count number 选填参数 使用个数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUsePreyTreasureBoxMulti(itemId, count)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.UsePreyTreasureBoxMulti" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUsePreyTreasureBoxMultiMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUsePreyTreasureBoxMultiMessage](LuaEnumNetDef.ReqUsePreyTreasureBoxMultiMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUsePreyTreasureBoxMultiMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUsePreyTreasureBoxMultiMessage", 10079, "UsePreyTreasureBoxMulti", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10081 领取掠宝袋宝箱多个请求
---领取掠宝袋宝箱多个请求
---msgID: 10081
---@param itemId number 选填参数 宝箱配置id
---@param count number 选填参数 使用个数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAwardPreyTreasureBoxMulti(itemId, count)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.AwardPreyTreasureBoxMulti" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAwardPreyTreasureBoxMultiMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAwardPreyTreasureBoxMultiMessage](LuaEnumNetDef.ReqAwardPreyTreasureBoxMultiMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAwardPreyTreasureBoxMultiMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAwardPreyTreasureBoxMultiMessage", 10081, "AwardPreyTreasureBoxMulti", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10082 请求熔炼物品
---请求熔炼物品
---msgID: 10082
---@param recycleList System.Collections.Generic.List1T<number> 列表参数 回收列表(唯一id)
---@param intensifyLv number 选填参数 强化等级
---@param recycleData System.Collections.Generic.List1T<number> 列表参数 回收设置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSmelt(recycleList, intensifyLv, recycleData)
    local reqData = CS.bagV2.RecycleEquipmentRequest()
    if recycleList ~= nil then
        reqData.recycleList:AddRange(recycleList)
    end
    if intensifyLv ~= nil then
        reqData.intensifyLv = intensifyLv
    end
    if recycleData ~= nil then
        reqData.recycleData:AddRange(recycleData)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSmeltMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSmeltMessage](LuaEnumNetDef.ReqSmeltMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqSmeltMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:10084 请求熔炼血继
---请求熔炼血继
---msgID: 10084
---@param equipId number 必填参数 血继 id， 身上发 -index
---@param recycleList table<number> 列表参数 熔炼物品
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBloodSmelt(equipId, recycleList)
    local reqTable = {}
    reqTable.equipId = equipId
    if recycleList ~= nil then
        reqTable.recycleList = recycleList
    else
        reqTable.recycleList = {}
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqBloodSmelt" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBloodSmeltMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBloodSmeltMessage](LuaEnumNetDef.ReqBloodSmeltMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBloodSmeltMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBloodSmeltMessage", 10084, "ReqBloodSmelt", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10086 请求熔炼神力装备
---请求熔炼神力装备
---msgID: 10086
---@param equipId number 必填参数 胜利装备 id， 身上发 -index
---@param recycleList table<number> 列表参数 熔炼物品
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDivineSmelt(equipId, recycleList)
    local reqTable = {}
    reqTable.equipId = equipId
    if recycleList ~= nil then
        reqTable.recycleList = recycleList
    else
        reqTable.recycleList = {}
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.ReqDivineSmelt" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDivineSmeltMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDivineSmeltMessage](LuaEnumNetDef.ReqDivineSmeltMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDivineSmeltMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDivineSmeltMessage", 10086, "ReqDivineSmelt", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:10089 请求使用元宝宝箱
---请求使用元宝宝箱
---msgID: 10089
---@param itemId number 选填参数 元宝宝箱唯一ID
---@param count number 选填参数 使用数量
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUseMoneyBox(itemId, count)
    local reqTable = {}
    if itemId ~= nil then
        reqTable.itemId = itemId
    end
    if count ~= nil then
        reqTable.count = count
    end
    local reqMsgData = protobufMgr.Serialize("bagV2.UseMoneyBox" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUseMoneyBoxMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUseMoneyBoxMessage](LuaEnumNetDef.ReqUseMoneyBoxMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUseMoneyBoxMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUseMoneyBoxMessage", 10089, "UseMoneyBox", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

