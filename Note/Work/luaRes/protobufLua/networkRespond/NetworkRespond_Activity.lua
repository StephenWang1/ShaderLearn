--[[本文件为工具自动生成,禁止手动修改]]
--activity.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回领取活动奖励
---msgID: 4002
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResGetActivityReward C#数据结构
function networkRespond.OnResGetActivityRewardMessageReceived(msgID)
    ---@type activityV2.ResGetActivityReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4002 activityV2.ResGetActivityReward 返回领取活动奖励")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetActivityRewardMessage", 4002, "ResGetActivityReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回活动面板数据
---msgID: 4004
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResOpenPanel C#数据结构
function networkRespond.OnResOpenPanelMessageReceived(msgID)
    ---@type activityV2.ResOpenPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4004 activityV2.ResOpenPanel 返回活动面板数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResOpenPanel ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResOpenPanel(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回排行榜类型活动数据
---msgID: 4005
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResRankActivity C#数据结构
function networkRespond.OnResRankActivityMessageReceived(msgID)
    ---@type activityV2.ResRankActivity
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4005 activityV2.ResRankActivity 返回排行榜类型活动数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRankActivityMessage", 4005, "ResRankActivity", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回每周充值累计数量
---msgID: 4006
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResWeekTotalRechargeNum C#数据结构
function networkRespond.OnResWeekTotalRechargeNumMessageReceived(msgID)
    ---@type activityV2.ResWeekTotalRechargeNum
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4006 activityV2.ResWeekTotalRechargeNum 返回每周充值累计数量")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResWeekTotalRechargeNumMessage", 4006, "ResWeekTotalRechargeNum", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回限时任务额外奖励
---msgID: 4007
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResExtraReward C#数据结构
function networkRespond.OnResExtraRewardMessageReceived(msgID)
    ---@type activityV2.ResExtraReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4007 activityV2.ResExtraReward 返回限时任务额外奖励")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResExtraRewardMessage", 4007, "ResExtraReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回经验炼制面板
---msgID: 4010
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResOpenLianZhi C#数据结构
function networkRespond.OnResOpenLianZhiMessageReceived(msgID)
    ---@type activityV2.ResOpenLianZhi
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4010 activityV2.ResOpenLianZhi 返回经验炼制面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOpenLianZhiMessage", 4010, "ResOpenLianZhi", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送带目标的活动数据改变
---msgID: 4012
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResActivityDataChange C#数据结构
function networkRespond.OnResActivityDataChangeMessageReceived(msgID)
    ---@type activityV2.ResActivityDataChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4012 activityV2.ResActivityDataChange 发送带目标的活动数据改变")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResActivityDataChangeMessage", 4012, "ResActivityDataChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---通知条件活动开启
---msgID: 4037
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResOpenConditionActivity C#数据结构
function networkRespond.OnResOpenConditionActivityMessageReceived(msgID)
    ---@type activityV2.ResOpenConditionActivity
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4037 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4037 activityV2.ResOpenConditionActivity 通知条件活动开启")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOpenConditionActivityMessage", 4037, "ResOpenConditionActivity", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---活动开启信息响应
---msgID: 4066
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ActivityOpenTable C#数据结构
function networkRespond.OnResServerActivityDataMessageReceived(msgID)
    ---@type activityV2.ActivityOpenTable
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4066 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4066 activityV2.ActivityOpenTable 活动开启信息响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResServerActivityDataMessage", 4066, "ActivityOpenTable", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---怪物攻城排行榜
---msgID: 4068
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResActivityMonsterRankScoreList C#数据结构
function networkRespond.OnResActivityMonsterRankScoreListMessageReceived(msgID)
    ---@type activityV2.ResActivityMonsterRankScoreList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4068 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4068 activityV2.ResActivityMonsterRankScoreList 怪物攻城排行榜")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResActivityMonsterRankScoreListMessage", 4068, "ResActivityMonsterRankScoreList", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---怪物攻城信息下发
---msgID: 4069
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResActivityMonsterAttackTimesInfo C#数据结构
function networkRespond.OnResActivityMonsterAttackTimesInfoMessageReceived(msgID)
    ---@type activityV2.ResActivityMonsterAttackTimesInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4069 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4069 activityV2.ResActivityMonsterAttackTimesInfo 怪物攻城信息下发")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResActivityMonsterAttackTimesInfo ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResActivityMonsterAttackTimesInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---怪物攻城活动阶段
---msgID: 4070
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResActivityMonsterStage C#数据结构
function networkRespond.OnResActivityMonsterStageMessageReceived(msgID)
    ---@type activityV2.ResActivityMonsterStage
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4070 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4070 activityV2.ResActivityMonsterStage 怪物攻城活动阶段")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResActivityMonsterStage ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResActivityMonsterStage(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---怪物攻城BOSS击杀排行榜
---msgID: 4071
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResActivityMonsterKillBossRank C#数据结构
function networkRespond.OnResActivityMonsterKillBossRankMessageReceived(msgID)
    ---@type activityV2.ResActivityMonsterKillBossRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4071 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4071 activityV2.ResActivityMonsterKillBossRank 怪物攻城BOSS击杀排行榜")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResActivityMonsterKillBossRank ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResActivityMonsterKillBossRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新保卫国王活动面板
---msgID: 4073
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResDefendKingActivityInfo C#数据结构
function networkRespond.OnResDefendKingActivityInfoMessageReceived(msgID)
    ---@type activityV2.ResDefendKingActivityInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4073 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4073 activityV2.ResDefendKingActivityInfo 更新保卫国王活动面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResDefendKingActivityInfo ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResDefendKingActivityInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---保卫国王关闭活动面板
---msgID: 4075
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResDefendClosePanelMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---返回保卫国王上次活动排行
---msgID: 4077
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResDefendLastRank C#数据结构
function networkRespond.OnResDefendLastRankMessageReceived(msgID)
    ---@type activityV2.ResDefendLastRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4077 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4077 activityV2.ResDefendLastRank 返回保卫国王上次活动排行")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResDefendLastRank ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResDefendLastRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回保卫国王活动结束消息
---msgID: 4078
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResDefendOver C#数据结构
function networkRespond.OnResDefendOverMessageReceived(msgID)
    ---@type activityV2.ResDefendOver
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4078 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4078 activityV2.ResDefendOver 返回保卫国王活动结束消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResDefendOver ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResDefendOver(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---活动状态改变
---msgID: 4079
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResDailyActivityStatusChanged C#数据结构
function networkRespond.OnResDailyActivityStatusChangedMessageReceived(msgID)
    ---@type activityV2.ResDailyActivityStatusChanged
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4079 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4079 activityV2.ResDailyActivityStatusChanged 活动状态改变")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDailyActivityStatusChangedMessage", 4079, "ResDailyActivityStatusChanged", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---活动状态
---msgID: 4080
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResAllActivityCommonStatus C#数据结构
function networkRespond.OnResActivityCommonStatusMessageReceived(msgID)
    ---@type activityV2.ResAllActivityCommonStatus
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4080 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4080 activityV2.ResAllActivityCommonStatus 活动状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResAllActivityCommonStatus ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResAllActivityCommonStatus(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---boss积分
---msgID: 4081
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.BossScoreRes C#数据结构
function networkRespond.OnResBossScoreMessageReceived(msgID)
    ---@type activityV2.BossScoreRes
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4081 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4081 activityV2.BossScoreRes boss积分")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.BossScoreRes ~= nil then
        csData = protobufMgr.DecodeTable.activity.BossScoreRes(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---领取到的物品提示面板
---msgID: 4083
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.TheActivityHasRewarded C#数据结构
function networkRespond.OnTheActivityHasRewardedMessageReceived(msgID)
    ---@type activityV2.TheActivityHasRewarded
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4083 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4083 activityV2.TheActivityHasRewarded 领取到的物品提示面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("TheActivityHasRewardedMessage", 4083, "TheActivityHasRewarded", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回保卫国王排行
---msgID: 4087
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.DefendRank C#数据结构
function networkRespond.OnResDefendKingRankMessageReceived(msgID)
    ---@type activityV2.DefendRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4087 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4087 activityV2.DefendRank 返回保卫国王排行")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.DefendRank ~= nil then
        csData = protobufMgr.DecodeTable.activity.DefendRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---首杀首爆个人红包
---msgID: 4088
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ServerRoleReward C#数据结构
function networkRespond.OnResServerRoleRewardMessageReceived(msgID)
    ---@type activityV2.ServerRoleReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4088 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4088 activityV2.ServerRoleReward 首杀首爆个人红包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResServerRoleRewardMessage", 4088, "ServerRoleReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回保卫国王活动排行榜期数列表
---msgID: 4090
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResDefendRankList C#数据结构
function networkRespond.OnResDefendLastRankListMessageReceived(msgID)
    ---@type activityV2.ResDefendRankList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4090 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4090 activityV2.ResDefendRankList 返回保卫国王活动排行榜期数列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDefendLastRankListMessage", 4090, "ResDefendRankList", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---玩家上线发送今日已结束的活动type（每日0点清空）
---msgID: 4091
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResTodayClosedActivities C#数据结构
function networkRespond.OnResTodayClosedActivitiesMessageReceived(msgID)
    ---@type activityV2.ResTodayClosedActivities
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4091 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4091 activityV2.ResTodayClosedActivities 玩家上线发送今日已结束的活动type（每日0点清空）")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.activity ~= nil and  protobufMgr.DecodeTable.activity.ResTodayClosedActivities ~= nil then
        csData = protobufMgr.DecodeTable.activity.ResTodayClosedActivities(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---活动期黑铁矿消耗
---msgID: 4093
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResBlackIronCost C#数据结构
function networkRespond.OnResBlackIronCostMessageReceived(msgID)
    ---@type activityV2.ResBlackIronCost
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4093 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4093 activityV2.ResBlackIronCost 活动期黑铁矿消耗")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBlackIronCostMessage", 4093, "ResBlackIronCost", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回全部历法小礼包状态
---msgID: 4097
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.ResReceivedGiftState C#数据结构
function networkRespond.OnResAllCalendarGiftStateMessageReceived(msgID)
    ---@type activityV2.ResReceivedGiftState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4097 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4097 activityV2.ResReceivedGiftState 返回全部历法小礼包状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAllCalendarGiftStateMessage", 4097, "ResReceivedGiftState", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回幸运转盘信息
---msgID: 4100
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.LuckTurntableInfo C#数据结构
function networkRespond.OnResLuckTurntableInfoMessageReceived(msgID)
    ---@type activityV2.LuckTurntableInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4100 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4100 activityV2.LuckTurntableInfo 返回幸运转盘信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLuckTurntableInfoMessage", 4100, "LuckTurntableInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回幸运转盘抽奖
---msgID: 4102
---@param msgID LuaEnumNetDef 消息ID
---@return activityV2.LotteryReward C#数据结构
function networkRespond.OnResLuckTurntableLotteryMessageReceived(msgID)
    ---@type activityV2.LotteryReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 4102 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 4102 activityV2.LotteryReward 返回幸运转盘抽奖")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLuckTurntableLotteryMessage", 4102, "LotteryReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

