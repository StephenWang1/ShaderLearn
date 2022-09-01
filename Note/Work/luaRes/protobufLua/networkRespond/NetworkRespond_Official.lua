--[[本文件为工具自动生成,禁止手动修改]]
--official.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送官职界面信息
---msgID: 56001
---@param msgID LuaEnumNetDef 消息ID
---@return officialV2.ResOfficialInfo C#数据结构
function networkRespond.OnResOfficialInfoMessageReceived(msgID)
    ---@type officialV2.ResOfficialInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 56001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 56001 officialV2.ResOfficialInfo 发送官职界面信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOfficialInfoMessage", 56001, "ResOfficialInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回官职晋升结果
---msgID: 56003
---@param msgID LuaEnumNetDef 消息ID
---@return officialV2.ResOfficialUp C#数据结构
function networkRespond.OnResOfficialUpMessageReceived(msgID)
    ---@type officialV2.ResOfficialUp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 56003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 56003 officialV2.ResOfficialUp 返回官职晋升结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOfficialUpMessage", 56003, "ResOfficialUp", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回领取日活奖励结果
---msgID: 56005
---@param msgID LuaEnumNetDef 消息ID
---@return officialV2.ResDrawDailyActiveReward C#数据结构
function networkRespond.OnResDrawDailyActiveRewardMessageReceived(msgID)
    ---@type officialV2.ResDrawDailyActiveReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 56005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 56005 officialV2.ResDrawDailyActiveReward 返回领取日活奖励结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDrawDailyActiveRewardMessage", 56005, "ResDrawDailyActiveReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---同步官职和虎符信息,上线和变化都是这一条
---msgID: 56011
---@param msgID LuaEnumNetDef 消息ID
---@return officialV2.ResOfficialInfoV2 C#数据结构
function networkRespond.OnResOfficialInfoV2MessageReceived(msgID)
    ---@type officialV2.ResOfficialInfoV2
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 56011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 56011 officialV2.ResOfficialInfoV2 同步官职和虎符信息,上线和变化都是这一条")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOfficialInfoV2Message", 56011, "ResOfficialInfoV2", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

