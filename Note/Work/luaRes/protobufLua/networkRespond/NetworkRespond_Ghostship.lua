--[[本文件为工具自动生成,禁止手动修改]]
--ghostship.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---幽灵船状态
---msgID: 132002
---@param msgID LuaEnumNetDef 消息ID
---@return ghostshipV2.GhostShipState C#数据结构
function networkRespond.OnResGhostShipStateMessageReceived(msgID)
    ---@type ghostshipV2.GhostShipState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 132002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 132002 ghostshipV2.GhostShipState 幽灵船状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGhostShipStateMessage", 132002, "GhostShipState", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---幽灵船玩家数据
---msgID: 132003
---@param msgID LuaEnumNetDef 消息ID
---@return ghostshipV2.GhostShipRoleData C#数据结构
function networkRespond.OnResGhostShipRoleDataMessageReceived(msgID)
    ---@type ghostshipV2.GhostShipRoleData
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 132003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 132003 ghostshipV2.GhostShipRoleData 幽灵船玩家数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGhostShipRoleDataMessage", 132003, "GhostShipRoleData", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---幽灵船剩余时间
---msgID: 132004
---@param msgID LuaEnumNetDef 消息ID
---@return ghostshipV2.GhostShipTime C#数据结构
function networkRespond.OnResGhostShipRoleTimeMessageReceived(msgID)
    ---@type ghostshipV2.GhostShipTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 132004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 132004 ghostshipV2.GhostShipTime 幽灵船剩余时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGhostShipRoleTimeMessage", 132004, "GhostShipTime", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

