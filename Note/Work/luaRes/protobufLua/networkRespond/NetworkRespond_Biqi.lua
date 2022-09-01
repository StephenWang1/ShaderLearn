--[[本文件为工具自动生成,禁止手动修改]]
--biqi.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送积分排行信息
---msgID: 79004
---@param msgID LuaEnumNetDef 消息ID
---@return biqiV2.ResScoreRank C#数据结构
function networkRespond.OnResScoreRankMessageReceived(msgID)
    ---@type biqiV2.ResScoreRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 79004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 79004 biqiV2.ResScoreRank 发送积分排行信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.biqi ~= nil and  protobufMgr.DecodeTable.biqi.ResScoreRank ~= nil then
        csData = protobufMgr.DecodeTable.biqi.ResScoreRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送逆袭buff信息
---msgID: 79005
---@param msgID LuaEnumNetDef 消息ID
---@return biqiV2.ResNixiBuffInfo C#数据结构
function networkRespond.OnResNixiBuffInfoMessageReceived(msgID)
    ---@type biqiV2.ResNixiBuffInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 79005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 79005 biqiV2.ResNixiBuffInfo 发送逆袭buff信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResNixiBuffInfoMessage", 79005, "ResNixiBuffInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送积分领奖信息
---msgID: 79006
---@param msgID LuaEnumNetDef 消息ID
---@return biqiV2.ResScoreReward C#数据结构
function networkRespond.OnResScoreRewardMessageReceived(msgID)
    ---@type biqiV2.ResScoreReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 79006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 79006 biqiV2.ResScoreReward 发送积分领奖信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResScoreRewardMessage", 79006, "ResScoreReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送玩家积分信息
---msgID: 79007
---@param msgID LuaEnumNetDef 消息ID
---@return biqiV2.ResRoleScore C#数据结构
function networkRespond.OnResRoleScoreMessageReceived(msgID)
    ---@type biqiV2.ResRoleScore
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 79007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 79007 biqiV2.ResRoleScore 发送玩家积分信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.biqi ~= nil and  protobufMgr.DecodeTable.biqi.ResRoleScore ~= nil then
        csData = protobufMgr.DecodeTable.biqi.ResRoleScore(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---提示即将切换阵营
---msgID: 79010
---@param msgID LuaEnumNetDef 消息ID
---@return biqiV2.ResChangCampTip C#数据结构
function networkRespond.OnResChangCampTipMessageReceived(msgID)
    ---@type biqiV2.ResChangCampTip
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 79010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 79010 biqiV2.ResChangCampTip 提示即将切换阵营")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResChangCampTipMessage", 79010, "ResChangCampTip", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

