--[[本文件为工具自动生成,禁止手动修改]]
--merit.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回行会之争
---msgID: 122002
---@param msgID LuaEnumNetDef 消息ID
---@return meritV2.ResUnionBattle C#数据结构
function networkRespond.OnResUnionBattleMessageReceived(msgID)
    ---@type meritV2.ResUnionBattle
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 122002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 122002 meritV2.ResUnionBattle 返回行会之争")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.merit ~= nil and  protobufMgr.DecodeTable.merit.ResUnionBattle ~= nil then
        csData = protobufMgr.DecodeTable.merit.ResUnionBattle(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---霸业活动红点
---msgID: 122003
---@param msgID LuaEnumNetDef 消息ID
---@return meritV2.ResMeritRedPoint C#数据结构
function networkRespond.OnResMeritRedPointMessageReceived(msgID)
    ---@type meritV2.ResMeritRedPoint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 122003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 122003 meritV2.ResMeritRedPoint 霸业活动红点")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.merit ~= nil and  protobufMgr.DecodeTable.merit.ResMeritRedPoint ~= nil then
        csData = protobufMgr.DecodeTable.merit.ResMeritRedPoint(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回领袖之路
---msgID: 122004
---@param msgID LuaEnumNetDef 消息ID
---@return meritV2.ResLeaderGlory C#数据结构
function networkRespond.OnResLeaderGloryMessageReceived(msgID)
    ---@type meritV2.ResLeaderGlory
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 122004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 122004 meritV2.ResLeaderGlory 返回领袖之路")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.merit ~= nil and  protobufMgr.DecodeTable.merit.ResLeaderGlory ~= nil then
        csData = protobufMgr.DecodeTable.merit.ResLeaderGlory(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回建功立业
---msgID: 122005
---@param msgID LuaEnumNetDef 消息ID
---@return meritV2.ResUnionAchievement C#数据结构
function networkRespond.OnResUnionAchievementMessageReceived(msgID)
    ---@type meritV2.ResUnionAchievement
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 122005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 122005 meritV2.ResUnionAchievement 返回建功立业")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.merit ~= nil and  protobufMgr.DecodeTable.merit.ResUnionAchievement ~= nil then
        csData = protobufMgr.DecodeTable.merit.ResUnionAchievement(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---领奖返回
---msgID: 122009
---@param msgID LuaEnumNetDef 消息ID
---@return meritV2.ResReturnRewardState C#数据结构
function networkRespond.OnResReturnRewardStateMessageReceived(msgID)
    ---@type meritV2.ResReturnRewardState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 122009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 122009 meritV2.ResReturnRewardState 领奖返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.merit ~= nil and  protobufMgr.DecodeTable.merit.ResReturnRewardState ~= nil then
        csData = protobufMgr.DecodeTable.merit.ResReturnRewardState(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回领袖之路小面板
---msgID: 122011
---@param msgID LuaEnumNetDef 消息ID
---@return meritV2.ResPositionInfo C#数据结构
function networkRespond.OnResPositionInfoMessageReceived(msgID)
    ---@type meritV2.ResPositionInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 122011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 122011 meritV2.ResPositionInfo 返回领袖之路小面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.merit ~= nil and  protobufMgr.DecodeTable.merit.ResPositionInfo ~= nil then
        csData = protobufMgr.DecodeTable.merit.ResPositionInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

