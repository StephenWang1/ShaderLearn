--[[本文件为工具自动生成,禁止手动修改]]
--equip.xml

--region ID:13002 请求一键换装
---请求一键换装
---msgID: 13002
---@param pos System.Collections.Generic.List1T<number> 列表参数 位置
---@param uniqueId System.Collections.Generic.List1T<number> 列表参数 要换的装备列表
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOneKeyPutOnEquip(pos, uniqueId)
    local reqData = CS.equipV2.ReqOneKeyPutOnEquip()
    if pos ~= nil then
        reqData.pos:AddRange(pos)
    end
    if uniqueId ~= nil then
        reqData.uniqueId:AddRange(uniqueId)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOneKeyPutOnEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOneKeyPutOnEquipMessage](LuaEnumNetDef.ReqOneKeyPutOnEquipMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqOneKeyPutOnEquipMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:13005 获取装备信息
---获取装备信息
---msgID: 13005
---@param armId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetItemInfo(armId)
    local reqTable = {}
    if armId ~= nil then
        reqTable.armId = armId
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqGetItemInfo" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetItemInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetItemInfoMessage](LuaEnumNetDef.ReqGetItemInfoMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetItemInfoMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetItemInfoMessage", 13005, "ReqGetItemInfo", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13006 请求穿装备
---请求穿装备
---msgID: 13006
---@param index number 选填参数 装备位置
---@param equipId number 选填参数 唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOnTheEquip(index, equipId)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    if equipId ~= nil then
        reqTable.equipId = equipId
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqPutOnTheEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOnTheEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOnTheEquipMessage](LuaEnumNetDef.ReqPutOnTheEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOnTheEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOnTheEquipMessage", 13006, "ReqPutOnTheEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13007 请求合成橙色装备
---请求合成橙色装备
---msgID: 13007
---@param type number 选填参数 1主角 2英雄
---@param heroId number 选填参数 英雄id
---@param index number 选填参数 装备位置
---@param equipId number 选填参数 唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCombineOrangeEquip(type, heroId, index, equipId)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if heroId ~= nil then
        reqTable.heroId = heroId
    end
    if index ~= nil then
        reqTable.index = index
    end
    if equipId ~= nil then
        reqTable.equipId = equipId
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqCombineOrangeEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCombineOrangeEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCombineOrangeEquipMessage](LuaEnumNetDef.ReqCombineOrangeEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCombineOrangeEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCombineOrangeEquipMessage", 13007, "ReqCombineOrangeEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13008 请求脱装备
---请求脱装备
---msgID: 13008
---@param index number 选填参数 位置
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOffTheEquip(index)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqPutOffEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOffTheEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOffTheEquipMessage](LuaEnumNetDef.ReqPutOffTheEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOffTheEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOffTheEquipMessage", 13008, "ReqPutOffEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13010 请求修理装备
---请求修理装备
---msgID: 13010
---@param itemId System.Collections.Generic.List1T<number> 列表参数 要修理的装备
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRepairEquip(itemId)
    local reqData = CS.equipV2.ReqRepairEquip()
    if itemId ~= nil then
        reqData.itemId:AddRange(itemId)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRepairEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRepairEquipMessage](LuaEnumNetDef.ReqRepairEquipMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRepairEquipMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:13013 请求镶嵌勋章
---请求镶嵌勋章
---msgID: 13013
---@param equipOwnId number 选填参数
---@param inlayId number 选填参数
---@param pos number 选填参数 暂时只能镶嵌一个，只发0
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInlayMedal(equipOwnId, inlayId, pos)
    local reqTable = {}
    if equipOwnId ~= nil then
        reqTable.equipOwnId = equipOwnId
    end
    if inlayId ~= nil then
        reqTable.inlayId = inlayId
    end
    if pos ~= nil then
        reqTable.pos = pos
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqInlayMedal" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInlayMedalMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInlayMedalMessage](LuaEnumNetDef.ReqInlayMedalMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInlayMedalMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInlayMedalMessage", 13013, "ReqInlayMedal", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13015 请求修理灵兽肉身装备
---请求修理灵兽肉身装备
---msgID: 13015
---@param itemId System.Collections.Generic.List1T<number> 列表参数 要修理的装备
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRepairServantEquip(itemId)
    local reqData = CS.equipV2.ReqRepairServantEquip()
    if itemId ~= nil then
        reqData.itemId:AddRange(itemId)
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRepairServantEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRepairServantEquipMessage](LuaEnumNetDef.ReqRepairServantEquipMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqRepairServantEquipMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:13016 装备炼制请求
---装备炼制请求
---msgID: 13016
---@param equipId1 number 必填参数
---@param equipId2 number 必填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEquipRefine(equipId1, equipId2)
    local reqTable = {}
    reqTable.equipId1 = equipId1
    reqTable.equipId2 = equipId2
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqEquipRefine" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEquipRefineMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEquipRefineMessage](LuaEnumNetDef.ReqEquipRefineMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqEquipRefineMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqEquipRefineMessage", 13016, "ReqEquipRefine", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13017 保存炼制属性请求
---保存炼制属性请求
---msgID: 13017
---@param equipId number 必填参数 要保存的属性， rateAttribute 0, rateAttribute1 1 rateAttribute2 2
---@param index number 必填参数 要保存的属性， rateAttribute 0, rateAttribute1 1 rateAttribute2 2
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSaveEquipRefine(equipId, index)
    local reqTable = {}
    reqTable.equipId = equipId
    reqTable.index = index
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqSaveEquipRefine" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSaveEquipRefineMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSaveEquipRefineMessage](LuaEnumNetDef.ReqSaveEquipRefineMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSaveEquipRefineMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSaveEquipRefineMessage", 13017, "ReqSaveEquipRefine", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13024 请求开启血继装备位
---请求开启血继装备位
---msgID: 13024
---@param equipIndex number 必填参数
---@param costIndex number 必填参数 选择消耗的物品
---@return boolean 网络请求是否成功发送
function networkRequest.ReqOpenBloodSuitGrid(equipIndex, costIndex)
    local reqTable = {}
    reqTable.equipIndex = equipIndex
    reqTable.costIndex = costIndex
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqOpenBloodSuitGrid" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqOpenBloodSuitGridMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqOpenBloodSuitGridMessage](LuaEnumNetDef.ReqOpenBloodSuitGridMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqOpenBloodSuitGridMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqOpenBloodSuitGridMessage", 13024, "ReqOpenBloodSuitGrid", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13025 请求镶嵌魂装
---请求镶嵌魂装
---msgID: 13025
---@param index number 选填参数 装备位
---@param itemLid number 选填参数 镶嵌装备唯一id
---@param type number 选填参数 10001:魂装黄金套 10002：仙装 10003：神器
---@param subIndex number 选填参数 子索引，从做到右1-3
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOnSoulEquip(index, itemLid, type, subIndex)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    if itemLid ~= nil then
        reqTable.itemLid = itemLid
    end
    if type ~= nil then
        reqTable.type = type
    end
    if subIndex ~= nil then
        reqTable.subIndex = subIndex
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqPutOnSoulEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOnSoulEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOnSoulEquipMessage](LuaEnumNetDef.ReqPutOnSoulEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOnSoulEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOnSoulEquipMessage", 13025, "ReqPutOnSoulEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13026 请求卸下镶嵌魂装
---请求卸下镶嵌魂装
---msgID: 13026
---@param index number 选填参数 装备位置
---@param type number 选填参数 10001:魂装黄金套 10002：仙装 10003：神器
---@param subIndex number 选填参数 子索引，从做到右1-3
---@return boolean 网络请求是否成功发送
function networkRequest.ReqPutOffSoulEquip(index, type, subIndex)
    local reqTable = {}
    if index ~= nil then
        reqTable.index = index
    end
    if type ~= nil then
        reqTable.type = type
    end
    if subIndex ~= nil then
        reqTable.subIndex = subIndex
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqPutOffSoulEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqPutOffSoulEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqPutOffSoulEquipMessage](LuaEnumNetDef.ReqPutOffSoulEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqPutOffSoulEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqPutOffSoulEquipMessage", 13026, "ReqPutOffSoulEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13028 请求魂装镶嵌数据
---请求魂装镶嵌数据
---msgID: 13028
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetAllSoulInfo()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetAllSoulInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetAllSoulInfoMessage](LuaEnumNetDef.ReqGetAllSoulInfoMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetAllSoulInfoMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:13029 请求洗炼魂装
---请求洗炼魂装
---msgID: 13029
---@param itemLid number 选填参数 洗炼的目标装备
---@param type number 选填参数 1 :身上的 2：背包里的
---@return boolean 网络请求是否成功发送
function networkRequest.ReqSoulEquipRefin(itemLid, type)
    local reqTable = {}
    if itemLid ~= nil then
        reqTable.itemLid = itemLid
    end
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqSoulEquipRefin" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqSoulEquipRefinMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqSoulEquipRefinMessage](LuaEnumNetDef.ReqSoulEquipRefinMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqSoulEquipRefinMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqSoulEquipRefinMessage", 13029, "ReqSoulEquipRefin", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13032 请求鉴定装备
---请求鉴定装备
---msgID: 13032
---@param lid number 选填参数 鉴定道具的唯一id
---@param type number 选填参数 鉴定类型 1：普通鉴定 2:稀有鉴定 3：完美鉴定
---@param souce number 选填参数 1 :身上的 2：背包里的
---@param index number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAppraisaEquip(lid, type, souce, index)
    local reqTable = {}
    if lid ~= nil then
        reqTable.lid = lid
    end
    if type ~= nil then
        reqTable.type = type
    end
    if souce ~= nil then
        reqTable.souce = souce
    end
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqAppraisaEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAppraisaEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAppraisaEquipMessage](LuaEnumNetDef.ReqAppraisaEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqAppraisaEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqAppraisaEquipMessage", 13032, "ReqAppraisaEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13034 鉴定勾选今日不在提示
---鉴定勾选今日不在提示
---msgID: 13034
---@return boolean 网络请求是否成功发送
function networkRequest.ReqAppraisaTodaynOTip()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqAppraisaTodaynOTipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqAppraisaTodaynOTipMessage](LuaEnumNetDef.ReqAppraisaTodaynOTipMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqAppraisaTodaynOTipMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:13036 配饰重铸
---配饰重铸
---msgID: 13036
---@param type number 选填参数 配饰类型
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRecast(type)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqRecast" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRecastMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRecastMessage](LuaEnumNetDef.ReqRecastMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRecastMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRecastMessage", 13036, "ReqRecast", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13038 请求解锁仙装镶嵌位
---请求解锁仙装镶嵌位
---msgID: 13038
---@param subIndex number 选填参数 子索引，从做到右1-3
---@param index number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUnlockSoulEquipIndex(subIndex, index)
    local reqTable = {}
    if subIndex ~= nil then
        reqTable.subIndex = subIndex
    end
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.UnlockSoulEquipIndex" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUnlockSoulEquipIndexMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUnlockSoulEquipIndexMessage](LuaEnumNetDef.ReqUnlockSoulEquipIndexMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUnlockSoulEquipIndexMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUnlockSoulEquipIndexMessage", 13038, "UnlockSoulEquipIndex", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:13039 成长兵鉴升级或突破
---成长兵鉴升级或突破
---msgID: 13039
---@param type number 选填参数 1:升级 2:突破
---@param index number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGrowthEquip(type, index)
    local reqTable = {}
    if type ~= nil then
        reqTable.type = type
    end
    if index ~= nil then
        reqTable.index = index
    end
    local reqMsgData = protobufMgr.Serialize("equipV2.ReqGrowthEquip" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGrowthEquipMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGrowthEquipMessage](LuaEnumNetDef.ReqGrowthEquipMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGrowthEquipMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGrowthEquipMessage", 13039, "ReqGrowthEquip", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

