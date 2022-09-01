--[[本文件为工具自动生成,禁止手动修改]]
--activities.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回所有打开的活动奖励
---msgID: 128001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllOpenActivitiesMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 128001 activitiesV2.AllActivitiesOpenInfo 返回所有打开的活动奖励")
        return nil
    end
    local res = protobufMgr.Deserialize("activitiesV2.AllActivitiesOpenInfo", buffer)
    if protoAdjust.activities_adj ~= nil and protoAdjust.activities_adj.AdjustAllActivitiesOpenInfo ~= nil then
        protoAdjust.activities_adj.AdjustAllActivitiesOpenInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 128001
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回某类的活动信息
---msgID: 128003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOneActivitiesInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 128003 activitiesV2.ResOneActivitiesInfo 返回某类的活动信息")
        return nil
    end
    local res = protobufMgr.Deserialize("activitiesV2.ResOneActivitiesInfo", buffer)
    if protoAdjust.activities_adj ~= nil and protoAdjust.activities_adj.AdjustResOneActivitiesInfo ~= nil then
        protoAdjust.activities_adj.AdjustResOneActivitiesInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 128003
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回领取活动奖励
---msgID: 128005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetOneActivitiesAwardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 128005 activitiesV2.ResAwardActivitiesInfo 返回领取活动奖励")
        return nil
    end
    local res = protobufMgr.Deserialize("activitiesV2.ResAwardActivitiesInfo", buffer)
    if protoAdjust.activities_adj ~= nil and protoAdjust.activities_adj.AdjustResAwardActivitiesInfo ~= nil then
        protoAdjust.activities_adj.AdjustResAwardActivitiesInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 128005
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回某类活动的开启关闭信息
---msgID: 128006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivitiesOpenInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 128006 activitiesV2.OneActivitiesInfo 返回某类活动的开启关闭信息")
        return nil
    end
    local res = protobufMgr.Deserialize("activitiesV2.OneActivitiesInfo", buffer)
    if protoAdjust.activities_adj ~= nil and protoAdjust.activities_adj.AdjustOneActivitiesInfo ~= nil then
        protoAdjust.activities_adj.AdjustOneActivitiesInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 128006
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回某类的活动信息
---msgID: 128007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSubTypeActivitiesInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 128007 activitiesV2.OneActivitiesInfo 返回某类的活动信息")
        return nil
    end
    local res = protobufMgr.Deserialize("activitiesV2.OneActivitiesInfo", buffer)
    if protoAdjust.activities_adj ~= nil and protoAdjust.activities_adj.AdjustOneActivitiesInfo ~= nil then
        protoAdjust.activities_adj.AdjustOneActivitiesInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 128007
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回白日门活动面板信息
---msgID: 128009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSunActivitiesPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 128009 activitiesV2.ResSunActivitiesPanel 返回白日门活动面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("activitiesV2.ResSunActivitiesPanel", buffer)
    if protoAdjust.activities_adj ~= nil and protoAdjust.activities_adj.AdjustResSunActivitiesPanel ~= nil then
        protoAdjust.activities_adj.AdjustResSunActivitiesPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 128009
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回活动的部分变动信息.
---msgID: 128010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivitiesPartInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 128010 activitiesV2.ActivitiesPartInfo 返回活动的部分变动信息.")
        return nil
    end
    local res = protobufMgr.Deserialize("activitiesV2.ActivitiesPartInfo", buffer)
    if protoAdjust.activities_adj ~= nil and protoAdjust.activities_adj.AdjustActivitiesPartInfo ~= nil then
        protoAdjust.activities_adj.AdjustActivitiesPartInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 128010
    protobufMgr.mMsgDeserializedTblCache = res
end

---同步客户端一个踢人的时间
---msgID: 128011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResKickOutTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 128011 activitiesV2.ResKickOutTime 同步客户端一个踢人的时间")
        return nil
    end
    local res = protobufMgr.Deserialize("activitiesV2.ResKickOutTime", buffer)
    if protoAdjust.activities_adj ~= nil and protoAdjust.activities_adj.AdjustResKickOutTime ~= nil then
        protoAdjust.activities_adj.AdjustResKickOutTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 128011
    protobufMgr.mMsgDeserializedTblCache = res
end

