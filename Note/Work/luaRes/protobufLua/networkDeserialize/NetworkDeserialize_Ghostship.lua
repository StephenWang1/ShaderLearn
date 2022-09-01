--[[本文件为工具自动生成,禁止手动修改]]
--ghostship.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---幽灵船状态
---msgID: 132002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGhostShipStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 132002 ghostshipV2.GhostShipState 幽灵船状态")
        return nil
    end
    local res = protobufMgr.Deserialize("ghostshipV2.GhostShipState", buffer)
    if protoAdjust.ghostship_adj ~= nil and protoAdjust.ghostship_adj.AdjustGhostShipState ~= nil then
        protoAdjust.ghostship_adj.AdjustGhostShipState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 132002
    protobufMgr.mMsgDeserializedTblCache = res
end

---幽灵船玩家数据
---msgID: 132003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGhostShipRoleDataMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 132003 ghostshipV2.GhostShipRoleData 幽灵船玩家数据")
        return nil
    end
    local res = protobufMgr.Deserialize("ghostshipV2.GhostShipRoleData", buffer)
    if protoAdjust.ghostship_adj ~= nil and protoAdjust.ghostship_adj.AdjustGhostShipRoleData ~= nil then
        protoAdjust.ghostship_adj.AdjustGhostShipRoleData(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 132003
    protobufMgr.mMsgDeserializedTblCache = res
end

---幽灵船剩余时间
---msgID: 132004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGhostShipRoleTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 132004 ghostshipV2.GhostShipTime 幽灵船剩余时间")
        return nil
    end
    local res = protobufMgr.Deserialize("ghostshipV2.GhostShipTime", buffer)
    if protoAdjust.ghostship_adj ~= nil and protoAdjust.ghostship_adj.AdjustGhostShipTime ~= nil then
        protoAdjust.ghostship_adj.AdjustGhostShipTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 132004
    protobufMgr.mMsgDeserializedTblCache = res
end

