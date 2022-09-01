--[[本文件为工具自动生成,禁止手动修改]]
--booth.xml

--region ID:123001 摊位地图请求
---摊位地图请求
---msgID: 123001
---@param type number 选填参数 0 ：原来的摊位 1：苍月摊位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBoothMaps(type)
    local reqData = CS.boothV2.BoothMaps()
    if type ~= nil then
        reqData.type = type
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBoothMapsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBoothMapsMessage](LuaEnumNetDef.ReqBoothMapsMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqBoothMapsMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:123003 创建摊位请求
---创建摊位请求
---msgID: 123003
---@param label System.Collections.Generic.List1T<number> 列表参数 摊位名字标签
---@param boothConfigId number 选填参数 摊位配置id(苍月摆摊该参数无用)
---@param boothCoordinateId number 选填参数 摊位地图坐标数据
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCreateBooth(label, boothConfigId, boothCoordinateId)
    local reqData = CS.boothV2.CreateBoothRequest()
    if label ~= nil then
        reqData.label:AddRange(label)
    end
    if boothConfigId ~= nil then
        reqData.boothConfigId = boothConfigId
    end
    if boothCoordinateId ~= nil then
        reqData.boothCoordinateId = boothCoordinateId
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCreateBoothMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCreateBoothMessage](LuaEnumNetDef.ReqCreateBoothMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCreateBoothMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:123005 改变摊位名字请求
---改变摊位名字请求
---msgID: 123005
---@param label System.Collections.Generic.List1T<number> 列表参数 摊位名字标签
---@param type number 选填参数 0 ：原来的摊位 1：苍月摊位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeBoothName(label, type)
    local reqData = CS.boothV2.ChangeBoothNameRequest()
    if label ~= nil then
        reqData.label:AddRange(label)
    end
    if type ~= nil then
        reqData.type = type
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeBoothNameMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeBoothNameMessage](LuaEnumNetDef.ReqChangeBoothNameMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqChangeBoothNameMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:123007 取消摊位请求
---取消摊位请求
---msgID: 123007
---@param type number 选填参数 0 ：原来的摊位 1：苍月摊位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCancelBooth(type)
    local reqData = CS.boothV2.CancelBooth()
    if type ~= nil then
        reqData.type = type
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCancelBoothMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCancelBoothMessage](LuaEnumNetDef.ReqCancelBoothMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCancelBoothMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:123009 请求摊位的商品列表信息
---请求摊位的商品列表信息
---msgID: 123009
---@param BoothId number 选填参数 摊位的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetBoothItems(BoothId)
    local reqTable = {}
    if BoothId ~= nil then
        reqTable.BoothId = BoothId
    end
    local reqMsgData = protobufMgr.Serialize("boothV2.BoothIdMsg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetBoothItemsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetBoothItemsMessage](LuaEnumNetDef.ReqGetBoothItemsMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetBoothItemsMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetBoothItemsMessage", 123009, "BoothIdMsg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:123011 请求摊位信息
---请求摊位信息
---msgID: 123011
---@param type number 选填参数 0 ：原来的摊位 1：苍月摊位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetShelfBoothInfo(type)
    local reqData = CS.boothV2.GetShelfBoothInfo()
    if type ~= nil then
        reqData.type = type
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetShelfBoothInfoMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetShelfBoothInfoMessage](LuaEnumNetDef.ReqGetShelfBoothInfoMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqGetShelfBoothInfoMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:123013 摊位购买请求
---摊位购买请求
---msgID: 123013
---@param boothId number 选填参数 摊位的唯一id
---@param lid number 选填参数 物品id（唯一id）
---@param count number 选填参数 物品数量
---@param type number 选填参数 0 ：原来的摊位 1：苍月摊位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqBoothBuy(boothId, lid, count, type)
    local reqTable = {}
    if boothId ~= nil then
        reqTable.boothId = boothId
    end
    if lid ~= nil then
        reqTable.lid = lid
    end
    if count ~= nil then
        reqTable.count = count
    end
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("boothV2.BoothBuy" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqBoothBuyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqBoothBuyMessage](LuaEnumNetDef.ReqBoothBuyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqBoothBuyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqBoothBuyMessage", 123013, "BoothBuy", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:123015 得到更新的摊位坐标请求
---得到更新的摊位坐标请求
---msgID: 123015
---@param mapId number 选填参数 地图id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetUpdateBoothPoint(mapId)
    local reqTable = {}
    if mapId ~= nil then
        reqTable.mapId = mapId
    end
    local reqMsgData = protobufMgr.Serialize("boothV2.BoothPointRequest" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetUpdateBoothPointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetUpdateBoothPointMessage](LuaEnumNetDef.ReqGetUpdateBoothPointMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetUpdateBoothPointMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetUpdateBoothPointMessage", 123015, "BoothPointRequest", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:123017 更新摊位坐标请求
---更新摊位坐标请求
---msgID: 123017
---@param boothCoordinateId number 选填参数 摊位坐标id
---@param type number 选填参数 0 ：原来的摊位 1：苍月摊位
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUpdateBoothPoint(boothCoordinateId, type)
    local reqTable = {}
    if boothCoordinateId ~= nil then
        reqTable.boothCoordinateId = boothCoordinateId
    end
    if type ~= nil then
        reqTable.type = type
    end
    local reqMsgData = protobufMgr.Serialize("boothV2.BoothCoordinateIdMsg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUpdateBoothPointMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUpdateBoothPointMessage](LuaEnumNetDef.ReqUpdateBoothPointMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUpdateBoothPointMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUpdateBoothPointMessage", 123017, "BoothCoordinateIdMsg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:123019 创建苍月摊位请求
---创建苍月摊位请求
---msgID: 123019
---@param label System.Collections.Generic.List1T<number> 列表参数 摊位名字标签
---@param boothConfigId number 选填参数 摊位配置id(苍月摆摊该参数无用)
---@param boothCoordinateId number 选填参数 摊位地图坐标数据
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCreateMoonBooth(label, boothConfigId, boothCoordinateId)
    local reqData = CS.boothV2.CreateBoothRequest()
    if label ~= nil then
        reqData.label:AddRange(label)
    end
    if boothConfigId ~= nil then
        reqData.boothConfigId = boothConfigId
    end
    if boothCoordinateId ~= nil then
        reqData.boothCoordinateId = boothCoordinateId
    end
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCreateMoonBoothMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCreateMoonBoothMessage](LuaEnumNetDef.ReqCreateMoonBoothMessage, reqData)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqCreateMoonBoothMessage, reqData, true)
    end
    return canSendMsg
end
--endregion

--region ID:123020 请求摊位的商品列表信息
---请求摊位的商品列表信息
---msgID: 123020
---@param BoothId number 选填参数 摊位的唯一id
---@return boolean 网络请求是否成功发送
function networkRequest.ReqGetMoonBoothItems(BoothId)
    local reqTable = {}
    if BoothId ~= nil then
        reqTable.BoothId = BoothId
    end
    local reqMsgData = protobufMgr.Serialize("boothV2.BoothIdMsg" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqGetMoonBoothItemsMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqGetMoonBoothItemsMessage](LuaEnumNetDef.ReqGetMoonBoothItemsMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqGetMoonBoothItemsMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqGetMoonBoothItemsMessage", 123020, "BoothIdMsg", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:123021 请求广播来纳夫摊位坐标及物品信息
---请求广播来纳夫摊位坐标及物品信息
---msgID: 123021
---@param boothCoordinateId number 选填参数 摊位坐标
---@param boothId number 选填参数 摊位的唯一id
---@param itemInfo boothV2.bagV2.BagItemInfo 选填参数 物品属性
---@return boolean 网络请求是否成功发送
function networkRequest.ReqUniteServerItemRadio(boothCoordinateId, boothId, itemInfo)
    local reqTable = {}
    if boothCoordinateId ~= nil then
        reqTable.boothCoordinateId = boothCoordinateId
    end
    if boothId ~= nil then
        reqTable.boothId = boothId
    end
    if itemInfo ~= nil then
        reqTable.itemInfo = itemInfo
    end
    local reqMsgData = protobufMgr.Serialize("boothV2.ReqUniteServerItemRadio" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqUniteServerItemRadioMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqUniteServerItemRadioMessage](LuaEnumNetDef.ReqUniteServerItemRadioMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqUniteServerItemRadioMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqUniteServerItemRadioMessage", 123021, "ReqUniteServerItemRadio", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

