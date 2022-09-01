--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--activity.xml

--region ID:4002 ResGetActivityRewardMessage 返回领取活动奖励
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResGetActivityReward lua table类型消息数据
---@param csData activityV2.ResGetActivityReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4004 ResOpenPanelMessage 返回活动面板数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResOpenPanel lua table类型消息数据
---@param csData activityV2.ResOpenPanel C# class类型消息数据
netMsgPreprocessing[4004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData.activityType == luaEnumCompetitionType.Recycle then
        uiStaticParameter.CompetitionData = csData
        CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.Activity_Competition_Recycle);
    end
end
--endregion

--region ID:4005 ResRankActivityMessage 返回排行榜类型活动数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResRankActivity lua table类型消息数据
---@param csData activityV2.ResRankActivity C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4006 ResWeekTotalRechargeNumMessage 返回每周充值累计数量
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResWeekTotalRechargeNum lua table类型消息数据
---@param csData activityV2.ResWeekTotalRechargeNum C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4007 ResExtraRewardMessage 返回限时任务额外奖励
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResExtraReward lua table类型消息数据
---@param csData activityV2.ResExtraReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4010 ResOpenLianZhiMessage 返回经验炼制面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResOpenLianZhi lua table类型消息数据
---@param csData activityV2.ResOpenLianZhi C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4012 ResActivityDataChangeMessage 发送带目标的活动数据改变
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResActivityDataChange lua table类型消息数据
---@param csData activityV2.ResActivityDataChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4037 ResOpenConditionActivityMessage 通知条件活动开启
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResOpenConditionActivity lua table类型消息数据
---@param csData activityV2.ResOpenConditionActivity C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4037] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4066 ResServerActivityDataMessage 活动开启信息响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ActivityOpenTable lua table类型消息数据
---@param csData activityV2.ActivityOpenTable C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4066] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4068 ResActivityMonsterRankScoreListMessage 怪物攻城排行榜
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResActivityMonsterRankScoreList lua table类型消息数据
---@param csData activityV2.ResActivityMonsterRankScoreList C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4068] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4069 ResActivityMonsterAttackTimesInfoMessage 怪物攻城信息下发
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResActivityMonsterAttackTimesInfo lua table类型消息数据
---@param csData activityV2.ResActivityMonsterAttackTimesInfo C# class类型消息数据
netMsgPreprocessing[4069] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateMonsterTimesInfo(csData)
end
--endregion

--region ID:4070 ResActivityMonsterStageMessage 怪物攻城活动阶段
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResActivityMonsterStage lua table类型消息数据
---@param csData activityV2.ResActivityMonsterStage C# class类型消息数据
netMsgPreprocessing[4070] = function(msgID, tblData, csData)
    CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateState(csData)
end
--endregion

--region ID:4071 ResActivityMonsterKillBossRankMessage 怪物攻城BOSS击杀排行榜
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResActivityMonsterKillBossRank lua table类型消息数据
---@param csData activityV2.ResActivityMonsterKillBossRank C# class类型消息数据
netMsgPreprocessing[4071] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4073 ResDefendKingActivityInfoMessage 更新保卫国王活动面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResDefendKingActivityInfo lua table类型消息数据
---@param csData activityV2.ResDefendKingActivityInfo C# class类型消息数据
netMsgPreprocessing[4073] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ActivityInfo then
            CS.CSScene.MainPlayerInfo.ActivityInfo:SetEnterDefAreaState(true)
            CS.CSScene.MainPlayerInfo.ActivityInfo:RefreshCurDefRankData(csData)
        end
        if not uiStaticParameter.isOpenDefendKingLeftRankInfo then
            uiStaticParameter.isOpenDefendKingLeftRankInfo = true
            local panel = uimanager:GetPanel('UIDefendKingRankPanel')
            if panel == nil then
                uimanager:CreatePanel('UIDefendKingRankPanel')
            end
        end

    end
end
--endregion

--region ID:4075 ResDefendClosePanelMessage 保卫国王关闭活动面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[4075] = function(msgID, tblData, csData)
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ActivityInfo then
        CS.CSScene.MainPlayerInfo.ActivityInfo:SetEnterDefAreaState(false)
    end
    uimanager:ClosePanel('UIDefendKingRankPanel')
    Utility.CloseActivityIcon()
    uiStaticParameter.isOpenDefendKingLeftRankInfo = false
end
--endregion

--region ID:4077 ResDefendLastUnionRankMessage 返回保卫国王上次活动排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResDefendLastRank lua table类型消息数据
---@param csData activityV2.ResDefendLastRank C# class类型消息数据
netMsgPreprocessing[4077] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ActivityInfo then
            CS.CSScene.MainPlayerInfo.ActivityInfo:RefreshLastDefRank(csData)
        end
    end
end
--endregion

--region ID:4078 ResDefendOverMessage 返回保卫国王活动结束消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResDefendOver lua table类型消息数据
---@param csData activityV2.ResDefendOver C# class类型消息数据
netMsgPreprocessing[4078] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ActivityInfo ~= nil then
            CS.CSScene.MainPlayerInfo.ActivityInfo:SetEnterDefAreaState(false)
            CS.CSScene.MainPlayerInfo.ActivityInfo:RefreshSettleDefRank(csData)
            uiStaticParameter.isOpenDefendKingLeftRankInfo = false
            uimanager:ClosePanel('UIDefendKingRankPanel')
            Utility.CloseActivityIcon()
            uimanager:CreatePanel("UIActivityRankPanel", nil, {
                id = LuaEnuActivityRankID.DefendKing,
                closeCallback = function()
                    if CS.CSScene.MainPlayerInfo ~= nil then
                        CS.CSScene.MainPlayerInfo.ActivityInfo:ClearDefendKingRankInfo()
                    end
                end
            })
        end
    end
end
--endregion

--region ID:4079 ResDailyActivityStatusChangedMessage 活动状态改变
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResDailyActivityStatusChanged lua table类型消息数据
---@param csData activityV2.ResDailyActivityStatusChanged C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4079] = function(msgID, tblData, csData)
    --print("ID:4079 ResDailyActivityStatusChangedMessage 活动状态改变", tblData.activityType, tblData.status)
    --在此处填入预处理代码

    --if (CS.CSScene.MainPlayerInfo ~= nil) then
    --    if tblData.activityType == 46 then
    --        --CS.CSScene.MainPlayerInfo.CalendarInfoV2:SetTodayCalendarActivityState(434, tblData.status);
    --        --CS.CSScene.MainPlayerInfo.CalendarInfoV2:SetTodayCalendarActivityState(435, tblData.status);
    --        return
    --    end
    --    --local activityVo = CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetTodayActivityWithType(tblData.activityType);
    --    --if (activityVo ~= nil) then
    --    --    CS.CSScene.MainPlayerInfo.CalendarInfoV2:SetTodayCalendarActivityState(activityVo.id, tblData.status);
    --    --end
    --end

    --print("接收活动状态改变"..tblData.activityId.."-----"..tblData.status)
    local activityId = tblData.activityId;
    --print("设置活动状态"..activityId.."---"..tblData.status);
    ---@type TABLE.cfg_daily_activity_time
    local tbl = clientTableManager.cfg_daily_activity_timeManager:TryGetValue(activityId);
    if (tbl ~= nil) then
        local type = tbl:GetActivityType();
        local activities = gameMgr:GetLuaActivityMgr():GetCalendarActivity(type);
        if (activities ~= nil and activities.ActivityInfos ~= nil) then
            ---@param v LuaActivityItemSubInfo
            for k, v in pairs(activities.ActivityInfos) do
                if (v.Tbl:GetId() == activityId) then
                    v:SetServerData(tblData);
                    --print("设置活动状态"..activityId.."---"..tblData.status);
                end
            end
        end
    end

    if tblData ~= nil then
        if tblData.activityType == 42 then
            if Utility.UnionDungeonEnterLimit() then
                if tblData.status then
                    Utility.GuildDungeonPrompShow()
                else
                    Utility.RemoveFlashPrompt(1, 35)
                end
            end
        end
    end

    ---print("111111111111111111")
    ---服务器不好处理,客户端先做一下一分钟值刷新一次的处理了
    if (gameMgr:GetPlayerDataMgr():GetActivityMgr().LastUpdateActivityTime == nil or
            gameMgr:GetLuaTimeMgr():GetNowMinuteTime() - gameMgr:GetPlayerDataMgr():GetActivityMgr().LastUpdateActivityTime > 1) then
        gameMgr:GetPlayerDataMgr():GetActivityMgr().LastUpdateActivityTime = gameMgr:GetLuaTimeMgr():GetNowMinuteTime()

        --print("ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"..tblData.activityType)
        gameMgr:GetPlayerDataMgr():GetActivityMgr():SortTodayCalendar()
        CS.CSNetwork.SendClientEvent(CS.CEvent.Role_UpdateActiveInfo);
    end

    luaEventManager.DoCallback(LuaCEvent.Calendar_OnActivityStateChange, tblData);
    --if(tblData.activityType == 16 and not tblData.status) then
    --    uiStaticParameter.mIsCurrentShaBaK = false;
    --    uimanager:CreatePanel("UIActivityRankThirdPanel", function()
    --        networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill), 1, uiStaticParameter.mShaBaKRankOnePageCount);
    --    end, {
    --        id = LuaEnuActivityRankID.ShaBaK,
    --        refreshCallBack = function()
    --            networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill), 1, uiStaticParameter.mShaBaKRankOnePageCount);
    --        end
    --    })
    --end

    --print("ResDailyActivityStatusChangedMessage 活动状态改变 : " .. tblData.activityType .. " -- " .. (tblData.status and 0 or 1));
end
--endregion

--region ID:4080 ResDefendOverMessage 活动状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResAllActivityCommonStatus lua table类型消息数据
---@param csData activityV2.ResAllActivityCommonStatus C# class类型消息数据
netMsgPreprocessing[4080] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateCompetitionInfo(csData)
        end
    end
end
--endregion

--region ID:4081 ResBossScoreMessage boss积分
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.BossScoreRes lua table类型消息数据
---@param csData activityV2.BossScoreRes C# class类型消息数据
netMsgPreprocessing[4081] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---@type CSMainPlayerInfo
    local mainPlayer = CS.CSScene.MainPlayerInfo
    if mainPlayer then
        mainPlayer.ActivityInfo:UpdateBossScore(csData)
    end
end
--endregion

--region ID:4083 HasTheActivityRewardsMessage 领取到的物品提示面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.TheActivityHasRewarded lua table类型消息数据
---@param csData activityV2.TheActivityHasRewarded C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4083] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (tblData.fromModule == LuaEnumRewardTipsType.HangHuiShouLing) then
        uimanager:CreatePanel("UIGuildBossResultPanel", nil, tblData)
    else
        uimanager:CreatePanel("UIRewardTipsPanel", nil, tblData)
    end
end
--endregion

--region ID:4087 ResDefendKingRankMessage 返回保卫国王排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.DefendRank lua table类型消息数据
---@param csData activityV2.DefendRank C# class类型消息数据
netMsgPreprocessing[4087] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            mainPlayerInfo.ActivityInfo:RefereshCurDefendKingRank(csData)
        end
    end
end
--endregion

--region ID:4088 ResServerRoleRewardMessage 首杀首爆个人红包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ServerRoleReward lua table类型消息数据
---@param csData activityV2.ServerRoleReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4088] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4090 ResDefendLastRankListMessage 返回保卫国王活动排行榜期数列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResDefendRankList lua table类型消息数据
---@param csData activityV2.ResDefendRankList C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4090] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:4091 ResTodayClosedActivitiesMessage 玩家上线发送今日已结束的活动type（每日0点清空）
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResTodayClosedActivities lua table类型消息数据
---@param csData activityV2.ResTodayClosedActivities C# class类型消息数据
netMsgPreprocessing[4091] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --if (CS.CSScene.MainPlayerInfo ~= nil) then
    --    if (csData ~= nil and csData.activityType ~= nil and csData.activityType.Count > 0) then
    --        for i = 0, csData.activityType.Count - 1 do
    --            local activityVo = CS.CSScene.MainPlayerInfo.CalendarInfoV2:GetTodayActivityWithType(csData.activityType[i]);
    --            if (activityVo ~= nil) then
    --                CS.CSScene.MainPlayerInfo.CalendarInfoV2:SetTodayCalendarActivityState(activityVo.id, false);
    --            end
    --        end
    --    end
    --end
end
--endregion

--region ID:4093 ResBlackIronCostMessage 活动期黑铁矿消耗
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResBlackIronCost lua table类型消息数据
---@param csData activityV2.ResBlackIronCost C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4093] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    Utility.BlackIronCost = tblData.blackIronCost
end
--endregion

--region ID:4097 ResAllCalendarGiftStateMessage 返回全部历法小礼包状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.ResReceivedGiftState lua table类型消息数据
---@param csData activityV2.ResReceivedGiftState C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4097] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (tblData ~= nil) then
        gameMgr:GetPlayerDataMgr():GetActivityMgr():UpdateCalendarGiftState(tblData.id)
    end
end
--endregion

--region ID:4100 ResLuckTurntableInfoMessage 返回幸运转盘信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.LuckTurntableInfo lua table类型消息数据
---@param csData activityV2.LuckTurntableInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4100] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    gameMgr:GetPlayerDataMgr():GetLuckTurntableLotteryManager():SetLuckTurntableLotteryData(tblData)
end
--endregion

--region ID:4102 ResLuckTurntableLotteryMessage 返回幸运转盘抽奖
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activityV2.LotteryReward lua table类型消息数据
---@param csData activityV2.LotteryReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[4102] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
end
--endregion
