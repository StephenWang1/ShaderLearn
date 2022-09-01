--[[本文件为工具自动生成,禁止手动修改]]
--activity.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回领取活动奖励
---msgID: 4002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetActivityRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4002 activityV2.ResGetActivityReward 返回领取活动奖励")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResGetActivityReward", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResGetActivityReward ~= nil then
        protoAdjust.activity_adj.AdjustResGetActivityReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4002
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回活动面板数据
---msgID: 4004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOpenPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4004 activityV2.ResOpenPanel 返回活动面板数据")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResOpenPanel", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResOpenPanel ~= nil then
        protoAdjust.activity_adj.AdjustResOpenPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4004
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回排行榜类型活动数据
---msgID: 4005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRankActivityMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4005 activityV2.ResRankActivity 返回排行榜类型活动数据")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResRankActivity", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResRankActivity ~= nil then
        protoAdjust.activity_adj.AdjustResRankActivity(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4005
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回每周充值累计数量
---msgID: 4006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResWeekTotalRechargeNumMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4006 activityV2.ResWeekTotalRechargeNum 返回每周充值累计数量")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResWeekTotalRechargeNum", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResWeekTotalRechargeNum ~= nil then
        protoAdjust.activity_adj.AdjustResWeekTotalRechargeNum(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4006
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回限时任务额外奖励
---msgID: 4007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResExtraRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4007 activityV2.ResExtraReward 返回限时任务额外奖励")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResExtraReward", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResExtraReward ~= nil then
        protoAdjust.activity_adj.AdjustResExtraReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4007
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回经验炼制面板
---msgID: 4010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOpenLianZhiMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4010 activityV2.ResOpenLianZhi 返回经验炼制面板")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResOpenLianZhi", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResOpenLianZhi ~= nil then
        protoAdjust.activity_adj.AdjustResOpenLianZhi(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4010
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送带目标的活动数据改变
---msgID: 4012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivityDataChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4012 activityV2.ResActivityDataChange 发送带目标的活动数据改变")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResActivityDataChange", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResActivityDataChange ~= nil then
        protoAdjust.activity_adj.AdjustResActivityDataChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4012
    protobufMgr.mMsgDeserializedTblCache = res
end

---通知条件活动开启
---msgID: 4037
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOpenConditionActivityMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4037 activityV2.ResOpenConditionActivity 通知条件活动开启")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResOpenConditionActivity", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResOpenConditionActivity ~= nil then
        protoAdjust.activity_adj.AdjustResOpenConditionActivity(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4037
    protobufMgr.mMsgDeserializedTblCache = res
end

---活动开启信息响应
---msgID: 4066
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServerActivityDataMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4066 activityV2.ActivityOpenTable 活动开启信息响应")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ActivityOpenTable", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustActivityOpenTable ~= nil then
        protoAdjust.activity_adj.AdjustActivityOpenTable(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4066
    protobufMgr.mMsgDeserializedTblCache = res
end

---怪物攻城排行榜
---msgID: 4068
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivityMonsterRankScoreListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4068 activityV2.ResActivityMonsterRankScoreList 怪物攻城排行榜")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResActivityMonsterRankScoreList", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResActivityMonsterRankScoreList ~= nil then
        protoAdjust.activity_adj.AdjustResActivityMonsterRankScoreList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4068
    protobufMgr.mMsgDeserializedTblCache = res
end

---怪物攻城信息下发
---msgID: 4069
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivityMonsterAttackTimesInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4069 activityV2.ResActivityMonsterAttackTimesInfo 怪物攻城信息下发")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResActivityMonsterAttackTimesInfo", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResActivityMonsterAttackTimesInfo ~= nil then
        protoAdjust.activity_adj.AdjustResActivityMonsterAttackTimesInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4069
    protobufMgr.mMsgDeserializedTblCache = res
end

---怪物攻城活动阶段
---msgID: 4070
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivityMonsterStageMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4070 activityV2.ResActivityMonsterStage 怪物攻城活动阶段")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResActivityMonsterStage", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResActivityMonsterStage ~= nil then
        protoAdjust.activity_adj.AdjustResActivityMonsterStage(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4070
    protobufMgr.mMsgDeserializedTblCache = res
end

---怪物攻城BOSS击杀排行榜
---msgID: 4071
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivityMonsterKillBossRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4071 activityV2.ResActivityMonsterKillBossRank 怪物攻城BOSS击杀排行榜")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResActivityMonsterKillBossRank", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResActivityMonsterKillBossRank ~= nil then
        protoAdjust.activity_adj.AdjustResActivityMonsterKillBossRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4071
    protobufMgr.mMsgDeserializedTblCache = res
end

---更新保卫国王活动面板
---msgID: 4073
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDefendKingActivityInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4073 activityV2.ResDefendKingActivityInfo 更新保卫国王活动面板")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResDefendKingActivityInfo", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResDefendKingActivityInfo ~= nil then
        protoAdjust.activity_adj.AdjustResDefendKingActivityInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4073
    protobufMgr.mMsgDeserializedTblCache = res
end

---保卫国王关闭活动面板
---msgID: 4075
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDefendClosePanelMessageReceived(msgID, buffer)
end

---返回保卫国王上次活动排行
---msgID: 4077
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDefendLastRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4077 activityV2.ResDefendLastRank 返回保卫国王上次活动排行")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResDefendLastRank", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResDefendLastRank ~= nil then
        protoAdjust.activity_adj.AdjustResDefendLastRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4077
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回保卫国王活动结束消息
---msgID: 4078
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDefendOverMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4078 activityV2.ResDefendOver 返回保卫国王活动结束消息")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResDefendOver", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResDefendOver ~= nil then
        protoAdjust.activity_adj.AdjustResDefendOver(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4078
    protobufMgr.mMsgDeserializedTblCache = res
end

---活动状态改变
---msgID: 4079
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDailyActivityStatusChangedMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4079 activityV2.ResDailyActivityStatusChanged 活动状态改变")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResDailyActivityStatusChanged", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResDailyActivityStatusChanged ~= nil then
        protoAdjust.activity_adj.AdjustResDailyActivityStatusChanged(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4079
    protobufMgr.mMsgDeserializedTblCache = res
end

---活动状态
---msgID: 4080
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResActivityCommonStatusMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4080 activityV2.ResAllActivityCommonStatus 活动状态")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResAllActivityCommonStatus", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResAllActivityCommonStatus ~= nil then
        protoAdjust.activity_adj.AdjustResAllActivityCommonStatus(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4080
    protobufMgr.mMsgDeserializedTblCache = res
end

---boss积分
---msgID: 4081
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBossScoreMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4081 activityV2.BossScoreRes boss积分")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.BossScoreRes", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustBossScoreRes ~= nil then
        protoAdjust.activity_adj.AdjustBossScoreRes(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4081
    protobufMgr.mMsgDeserializedTblCache = res
end

---领取到的物品提示面板
---msgID: 4083
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnTheActivityHasRewardedMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4083 activityV2.TheActivityHasRewarded 领取到的物品提示面板")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.TheActivityHasRewarded", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustTheActivityHasRewarded ~= nil then
        protoAdjust.activity_adj.AdjustTheActivityHasRewarded(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4083
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回保卫国王排行
---msgID: 4087
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDefendKingRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4087 activityV2.DefendRank 返回保卫国王排行")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.DefendRank", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustDefendRank ~= nil then
        protoAdjust.activity_adj.AdjustDefendRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4087
    protobufMgr.mMsgDeserializedTblCache = res
end

---首杀首爆个人红包
---msgID: 4088
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResServerRoleRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4088 activityV2.ServerRoleReward 首杀首爆个人红包")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ServerRoleReward", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustServerRoleReward ~= nil then
        protoAdjust.activity_adj.AdjustServerRoleReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4088
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回保卫国王活动排行榜期数列表
---msgID: 4090
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDefendLastRankListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4090 activityV2.ResDefendRankList 返回保卫国王活动排行榜期数列表")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResDefendRankList", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResDefendRankList ~= nil then
        protoAdjust.activity_adj.AdjustResDefendRankList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4090
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家上线发送今日已结束的活动type（每日0点清空）
---msgID: 4091
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTodayClosedActivitiesMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4091 activityV2.ResTodayClosedActivities 玩家上线发送今日已结束的活动type（每日0点清空）")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResTodayClosedActivities", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResTodayClosedActivities ~= nil then
        protoAdjust.activity_adj.AdjustResTodayClosedActivities(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4091
    protobufMgr.mMsgDeserializedTblCache = res
end

---活动期黑铁矿消耗
---msgID: 4093
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBlackIronCostMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4093 activityV2.ResBlackIronCost 活动期黑铁矿消耗")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResBlackIronCost", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResBlackIronCost ~= nil then
        protoAdjust.activity_adj.AdjustResBlackIronCost(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4093
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回全部历法小礼包状态
---msgID: 4097
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllCalendarGiftStateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4097 activityV2.ResReceivedGiftState 返回全部历法小礼包状态")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.ResReceivedGiftState", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustResReceivedGiftState ~= nil then
        protoAdjust.activity_adj.AdjustResReceivedGiftState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4097
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回幸运转盘信息
---msgID: 4100
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLuckTurntableInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4100 activityV2.LuckTurntableInfo 返回幸运转盘信息")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.LuckTurntableInfo", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustLuckTurntableInfo ~= nil then
        protoAdjust.activity_adj.AdjustLuckTurntableInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4100
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回幸运转盘抽奖
---msgID: 4102
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLuckTurntableLotteryMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 4102 activityV2.LotteryReward 返回幸运转盘抽奖")
        return nil
    end
    local res = protobufMgr.Deserialize("activityV2.LotteryReward", buffer)
    if protoAdjust.activity_adj ~= nil and protoAdjust.activity_adj.AdjustLotteryReward ~= nil then
        protoAdjust.activity_adj.AdjustLotteryReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 4102
    protobufMgr.mMsgDeserializedTblCache = res
end

