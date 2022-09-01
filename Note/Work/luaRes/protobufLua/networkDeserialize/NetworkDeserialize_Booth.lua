--[[本文件为工具自动生成,禁止手动修改]]
--booth.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---摊位地图响应
---msgID: 123002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBoothMapsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 123002 boothV2.BoothMapsResponse 摊位地图响应")
        return nil
    end
    local res = protobufMgr.Deserialize("boothV2.BoothMapsResponse", buffer)
    if protoAdjust.booth_adj ~= nil and protoAdjust.booth_adj.AdjustBoothMapsResponse ~= nil then
        protoAdjust.booth_adj.AdjustBoothMapsResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 123002
    protobufMgr.mMsgDeserializedTblCache = res
end

---创建摊位响应
---msgID: 123004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCreateBoothMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 123004 boothV2.BoothInfo 创建摊位响应")
        return nil
    end
    local res = protobufMgr.Deserialize("boothV2.BoothInfo", buffer)
    if protoAdjust.booth_adj ~= nil and protoAdjust.booth_adj.AdjustBoothInfo ~= nil then
        protoAdjust.booth_adj.AdjustBoothInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 123004
    protobufMgr.mMsgDeserializedTblCache = res
end

---改变摊位名字响应
---msgID: 123006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResChangeBoothNameMessageReceived(msgID, buffer)
end

---取消摊位响应
---msgID: 123008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCancelBoothMessageReceived(msgID, buffer)
end

---摊位的商品列表信息响应
---msgID: 123010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetBoothItemsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 123010 boothV2.BoothItemList 摊位的商品列表信息响应")
        return nil
    end
    local res = protobufMgr.Deserialize("boothV2.BoothItemList", buffer)
    if protoAdjust.booth_adj ~= nil and protoAdjust.booth_adj.AdjustBoothItemList ~= nil then
        protoAdjust.booth_adj.AdjustBoothItemList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 123010
    protobufMgr.mMsgDeserializedTblCache = res
end

---摊位信息响应
---msgID: 123012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetShelfBoothInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 123012 boothV2.ResBoothInfo 摊位信息响应")
        return nil
    end
    local res = protobufMgr.Deserialize("boothV2.ResBoothInfo", buffer)
    if protoAdjust.booth_adj ~= nil and protoAdjust.booth_adj.AdjustResBoothInfo ~= nil then
        protoAdjust.booth_adj.AdjustResBoothInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 123012
    protobufMgr.mMsgDeserializedTblCache = res
end

---摊位购买响应
---msgID: 123014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBoothBuyMessageReceived(msgID, buffer)
end

---得到更新的摊位坐标响应
---msgID: 123016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetUpdateBoothPointMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 123016 boothV2.BoothCoordinateIdMsg 得到更新的摊位坐标响应")
        return nil
    end
    local res = protobufMgr.Deserialize("boothV2.BoothCoordinateIdMsg", buffer)
    if protoAdjust.booth_adj ~= nil and protoAdjust.booth_adj.AdjustBoothCoordinateIdMsg ~= nil then
        protoAdjust.booth_adj.AdjustBoothCoordinateIdMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 123016
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新摊位坐标响应
---msgID: 123018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUpdateBoothPointMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 123018 boothV2.UpdateBoothPointResponse 更新摊位坐标响应")
        return nil
    end
    local res = protobufMgr.Deserialize("boothV2.UpdateBoothPointResponse", buffer)
    if protoAdjust.booth_adj ~= nil and protoAdjust.booth_adj.AdjustUpdateBoothPointResponse ~= nil then
        protoAdjust.booth_adj.AdjustUpdateBoothPointResponse(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 123018
    protobufMgr.mMsgDeserializedTblCache = res
end

