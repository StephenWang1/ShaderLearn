--[[本文件为工具自动生成,禁止手动修改]]
--chat.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---聊天结果
---msgID: 6004
---@param msgID LuaEnumNetDef 消息ID
---@return chatV2.ResChat C#数据结构
function networkRespond.OnResChatMessageReceived(msgID)
    ---@type chatV2.ResChat
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 6004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 6004 chatV2.ResChat 聊天结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.chat ~= nil and  protobufMgr.DecodeTable.chat.ResChat ~= nil then
        csData = protobufMgr.DecodeTable.chat.ResChat(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---公告消息
---msgID: 6008
---@param msgID LuaEnumNetDef 消息ID
---@return chatV2.ResAnnounce C#数据结构
function networkRespond.OnResAnnounceMessageReceived(msgID)
    ---@type chatV2.ResAnnounce
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 6008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 6008 chatV2.ResAnnounce 公告消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.chat ~= nil and  protobufMgr.DecodeTable.chat.ResAnnounce ~= nil then
        csData = protobufMgr.DecodeTable.chat.ResAnnounce(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回塔罗神庙公告历史记录
---msgID: 6014
---@param msgID LuaEnumNetDef 消息ID
---@return chatV2.ResHuntAnnounceHistory C#数据结构
function networkRespond.OnResHuntAnnounceMessageReceived(msgID)
    ---@type chatV2.ResHuntAnnounceHistory
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 6014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 6014 chatV2.ResHuntAnnounceHistory 返回塔罗神庙公告历史记录")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.chat ~= nil and  protobufMgr.DecodeTable.chat.ResHuntAnnounceHistory ~= nil then
        csData = protobufMgr.DecodeTable.chat.ResHuntAnnounceHistory(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回塔罗神庙公告更新
---msgID: 6015
---@param msgID LuaEnumNetDef 消息ID
---@return chatV2.ResHuntAnnounceUpdate C#数据结构
function networkRespond.OnResHuntAnnounceUpdateMessageReceived(msgID)
    ---@type chatV2.ResHuntAnnounceUpdate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 6015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 6015 chatV2.ResHuntAnnounceUpdate 返回塔罗神庙公告更新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.chat ~= nil and  protobufMgr.DecodeTable.chat.ResHuntAnnounceUpdate ~= nil then
        csData = protobufMgr.DecodeTable.chat.ResHuntAnnounceUpdate(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

