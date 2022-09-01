--[[本文件为工具自动生成,禁止手动修改]]
--activities.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回所有打开的活动奖励
---msgID: 128001
---@param msgID LuaEnumNetDef 消息ID
---@return activitiesV2.AllActivitiesOpenInfo C#数据结构
function networkRespond.OnResAllOpenActivitiesMessageReceived(msgID)
    ---@type activitiesV2.AllActivitiesOpenInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 128001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 128001 activitiesV2.AllActivitiesOpenInfo 返回所有打开的活动奖励")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAllOpenActivitiesMessage", 128001, "AllActivitiesOpenInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回某类的活动信息
---msgID: 128003
---@param msgID LuaEnumNetDef 消息ID
---@return activitiesV2.ResOneActivitiesInfo C#数据结构
function networkRespond.OnResOneActivitiesInfoMessageReceived(msgID)
    ---@type activitiesV2.ResOneActivitiesInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 128003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 128003 activitiesV2.ResOneActivitiesInfo 返回某类的活动信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOneActivitiesInfoMessage", 128003, "ResOneActivitiesInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回领取活动奖励
---msgID: 128005
---@param msgID LuaEnumNetDef 消息ID
---@return activitiesV2.ResAwardActivitiesInfo C#数据结构
function networkRespond.OnResGetOneActivitiesAwardMessageReceived(msgID)
    ---@type activitiesV2.ResAwardActivitiesInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 128005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 128005 activitiesV2.ResAwardActivitiesInfo 返回领取活动奖励")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetOneActivitiesAwardMessage", 128005, "ResAwardActivitiesInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回某类活动的开启关闭信息
---msgID: 128006
---@param msgID LuaEnumNetDef 消息ID
---@return activitiesV2.OneActivitiesInfo C#数据结构
function networkRespond.OnResActivitiesOpenInfoMessageReceived(msgID)
    ---@type activitiesV2.OneActivitiesInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 128006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 128006 activitiesV2.OneActivitiesInfo 返回某类活动的开启关闭信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResActivitiesOpenInfoMessage", 128006, "OneActivitiesInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回某类的活动信息
---msgID: 128007
---@param msgID LuaEnumNetDef 消息ID
---@return activitiesV2.OneActivitiesInfo C#数据结构
function networkRespond.OnResSubTypeActivitiesInfoMessageReceived(msgID)
    ---@type activitiesV2.OneActivitiesInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 128007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 128007 activitiesV2.OneActivitiesInfo 返回某类的活动信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSubTypeActivitiesInfoMessage", 128007, "OneActivitiesInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回白日门活动面板信息
---msgID: 128009
---@param msgID LuaEnumNetDef 消息ID
---@return activitiesV2.ResSunActivitiesPanel C#数据结构
function networkRespond.OnResSunActivitiesPanelMessageReceived(msgID)
    ---@type activitiesV2.ResSunActivitiesPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 128009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 128009 activitiesV2.ResSunActivitiesPanel 返回白日门活动面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSunActivitiesPanelMessage", 128009, "ResSunActivitiesPanel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回活动的部分变动信息.
---msgID: 128010
---@param msgID LuaEnumNetDef 消息ID
---@return activitiesV2.ActivitiesPartInfo C#数据结构
function networkRespond.OnResActivitiesPartInfoMessageReceived(msgID)
    ---@type activitiesV2.ActivitiesPartInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 128010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 128010 activitiesV2.ActivitiesPartInfo 返回活动的部分变动信息.")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResActivitiesPartInfoMessage", 128010, "ActivitiesPartInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---同步客户端一个踢人的时间
---msgID: 128011
---@param msgID LuaEnumNetDef 消息ID
---@return activitiesV2.ResKickOutTime C#数据结构
function networkRespond.OnResKickOutTimeMessageReceived(msgID)
    ---@type activitiesV2.ResKickOutTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 128011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 128011 activitiesV2.ResKickOutTime 同步客户端一个踢人的时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResKickOutTimeMessage", 128011, "ResKickOutTime", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

