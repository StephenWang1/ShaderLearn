--[[本文件为工具自动生成,禁止手动修改]]
--booth.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---摊位地图响应
---msgID: 123002
---@param msgID LuaEnumNetDef 消息ID
---@return boothV2.BoothMapsResponse C#数据结构
function networkRespond.OnResBoothMapsMessageReceived(msgID)
    ---@type boothV2.BoothMapsResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 123002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 123002 boothV2.BoothMapsResponse 摊位地图响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.booth ~= nil and  protobufMgr.DecodeTable.booth.BoothMapsResponse ~= nil then
        csData = protobufMgr.DecodeTable.booth.BoothMapsResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---创建摊位响应
---msgID: 123004
---@param msgID LuaEnumNetDef 消息ID
---@return boothV2.BoothInfo C#数据结构
function networkRespond.OnResCreateBoothMessageReceived(msgID)
    ---@type boothV2.BoothInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 123004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 123004 boothV2.BoothInfo 创建摊位响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCreateBoothMessage", 123004, "BoothInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---改变摊位名字响应
---msgID: 123006
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResChangeBoothNameMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---取消摊位响应
---msgID: 123008
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResCancelBoothMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---摊位的商品列表信息响应
---msgID: 123010
---@param msgID LuaEnumNetDef 消息ID
---@return boothV2.BoothItemList C#数据结构
function networkRespond.OnResGetBoothItemsMessageReceived(msgID)
    ---@type boothV2.BoothItemList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 123010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 123010 boothV2.BoothItemList 摊位的商品列表信息响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.booth ~= nil and  protobufMgr.DecodeTable.booth.BoothItemList ~= nil then
        csData = protobufMgr.DecodeTable.booth.BoothItemList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---摊位信息响应
---msgID: 123012
---@param msgID LuaEnumNetDef 消息ID
---@return boothV2.ResBoothInfo C#数据结构
function networkRespond.OnResGetShelfBoothInfoMessageReceived(msgID)
    ---@type boothV2.ResBoothInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 123012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 123012 boothV2.ResBoothInfo 摊位信息响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.booth ~= nil and  protobufMgr.DecodeTable.booth.ResBoothInfo ~= nil then
        csData = protobufMgr.DecodeTable.booth.ResBoothInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---摊位购买响应
---msgID: 123014
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResBoothBuyMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---得到更新的摊位坐标响应
---msgID: 123016
---@param msgID LuaEnumNetDef 消息ID
---@return boothV2.BoothCoordinateIdMsg C#数据结构
function networkRespond.OnResGetUpdateBoothPointMessageReceived(msgID)
    ---@type boothV2.BoothCoordinateIdMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 123016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 123016 boothV2.BoothCoordinateIdMsg 得到更新的摊位坐标响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.booth ~= nil and  protobufMgr.DecodeTable.booth.BoothCoordinateIdMsg ~= nil then
        csData = protobufMgr.DecodeTable.booth.BoothCoordinateIdMsg(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新摊位坐标响应
---msgID: 123018
---@param msgID LuaEnumNetDef 消息ID
---@return boothV2.UpdateBoothPointResponse C#数据结构
function networkRespond.OnResUpdateBoothPointMessageReceived(msgID)
    ---@type boothV2.UpdateBoothPointResponse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 123018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 123018 boothV2.UpdateBoothPointResponse 更新摊位坐标响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.booth ~= nil and  protobufMgr.DecodeTable.booth.UpdateBoothPointResponse ~= nil then
        csData = protobufMgr.DecodeTable.booth.UpdateBoothPointResponse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

