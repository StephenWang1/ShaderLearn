--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--duplicate.xml

--region ID:71001 ResDuplicateBasicInfoMessage 副本基本信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDuplicateBasicInfo lua table类型消息数据
---@param csData duplicateV2.ResDuplicateBasicInfo C# class类型消息数据
netMsgPreprocessing[71001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --副本基本信息
    CS.CSScene.MainPlayerInfo.DuplicateV2:ResDuplicateBasicInfo(csData)
    --阻断传送，副本不允许直接退出，退出前会有提示框警告
    CS.CSScene.MainPlayerInfo.DeliverInfoV2.IsBreak = true
    CS.CSScene.MainPlayerInfo.SanctuaryInfo:RefrehNowDuplicateId(tblData.cfgId)
    --玩家分线
    CS.CSScene.MainPlayerInfo.Line = csData.line
end
--endregion

--region ID:71005 ResDuplicateEndMessage 副本结束信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDuplicateEnd lua table类型消息数据
---@param csData duplicateV2.ResDuplicateEnd C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --取消阻断传送
    CS.CSScene.MainPlayerInfo.DeliverInfoV2.IsBreak = false
end
--endregion

--region ID:71015 ResSabacInfoMessage 沙巴克信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.SabacInfo lua table类型消息数据
---@param csData duplicateV2.SabacInfo C# class类型消息数据
netMsgPreprocessing[71015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2:UpdateShaBakInfo(csData);
    local panel = uimanager:GetPanel("UICityWarTipsPanel")
    if panel == nil then
        if Utility.IsSabacActivityChangeMissionPanel() then
            local menuPanel = uimanager:GetPanel("UIMainMenusPanel")
            if menuPanel then
                menuPanel:ChangLeftPanel("UICityWarTipsPanel")
            end
        end
    end

    gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():UpdateShaBaKData(tblData)
end
--endregion

--region ID:71016 ResFlagDieMessage 雕像死亡
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[71016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --uimanager:CreatePanel("UICityWarMiDaoFaZhenActivedTipsPanel", nil, { type = luaEnumShaBakTipsType.FlagDie });
end
--endregion

--region ID:71018 ResSabacPanelInfoMessage 沙巴克面板响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.SabacPanelInfo lua table类型消息数据
---@param csData duplicateV2.SabacPanelInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71021 TyrantDuplicateScoreMessage 发送暴君降临积分排名
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.TyrantDuplicateScore lua table类型消息数据
---@param csData duplicateV2.TyrantDuplicateScore C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71021] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71023 ResInspireBuffMessage 返回暴君鼓舞
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResInspireBuff lua table类型消息数据
---@param csData duplicateV2.ResInspireBuff C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71023] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71024 ResTyrantDeathMessage 暴君boss死亡发送消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResTyrantDeath lua table类型消息数据
---@param csData duplicateV2.ResTyrantDeath C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71025 ResThisDuplicateTokenCountMessage 发送副本道具信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDuplicateItem lua table类型消息数据
---@param csData duplicateV2.ResDuplicateItem C# class类型消息数据
netMsgPreprocessing[71025] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.Sington then
        local npc = CS.CSScene.Sington:getAvatar(csData.playerId)
        if npc ~= nil then
            local baseInfo = npc.BaseInfo
            if baseInfo ~= nil and baseInfo.DuplicateV2 ~= nil then
                baseInfo.DuplicateV2.DuplicateItem = csData
            end
        end
    end
end
--endregion

--region ID:71026 ResDuplicateInfoMessage 发送玩家所在层数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDuplicateInfo lua table类型消息数据
---@param csData duplicateV2.ResDuplicateInfo C# class类型消息数据
netMsgPreprocessing[71026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.DuplicateV2.MausoleumAntiquesDuplicateInfo = csData
    end
end
--endregion

--region ID:71027 ResCavesDuplicateRankInfoMessage 洞窟试炼返回玩家排行信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.CavesDuplicateRankInfo lua table类型消息数据
---@param csData duplicateV2.CavesDuplicateRankInfo C# class类型消息数据
netMsgPreprocessing[71027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2:ResCavesDuplicateRankInfo(csData.duplicateRank)
end
--endregion

--region ID:71029 ResCavesDuplicateInitTimeMessage 返回洞窟试炼开启时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.CavesDuplicateInitTime lua table类型消息数据
---@param csData duplicateV2.CavesDuplicateInitTime C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71029] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71030 ResGodPowerMessage 返回神威狱开启时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResGodPower lua table类型消息数据
---@param csData duplicateV2.ResGodPower C# class类型消息数据
netMsgPreprocessing[71030] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.DuplicateV2.GodPowerDuplicateInfo = csData
    end
end
--endregion

--region ID:71031 ResEntryTokenItemMessage 进入门票信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResEntryTokenItem lua table类型消息数据
---@param csData duplicateV2.ResEntryTokenItem C# class类型消息数据
netMsgPreprocessing[71031] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        CS.CSScene.MainPlayerInfo.DuplicateV2.EntryTokenItem = csData
    end
end
--endregion

--region ID:71032 ResWolfDreamTimeMessage 狼烟梦境时间消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResWolfDreamTime lua table类型消息数据
---@param csData duplicateV2.ResWolfDreamTime C# class类型消息数据
netMsgPreprocessing[71032] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.MainPlayerInfo ~= nil then
        local curRemainTime = CS.CSScene.MainPlayerInfo.DuplicateV2.RemainTime
        CS.CSScene.MainPlayerInfo.DuplicateV2.UseTime = csData.useTime
        CS.CSScene.MainPlayerInfo.DuplicateV2.RemainTime = csData.remainTime
        --luaEventManager.DoCallback(LuaCEvent.RefreshDreamlandRemainTimeChange, { oldTime = curRemainTime, newTime = tblData.remainTime });
    end
    luaEventManager.DoCallback(LuaCEvent.Task_YanHua);


end
--endregion

--region ID:71034 ResSanctuarySpaceInfoMessage 发送圣域空间次数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResSanctuarySpaceInfo lua table类型消息数据
---@param csData duplicateV2.ResSanctuarySpaceInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71034] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil and tblData.count ~= nil then
        local UISanctuaryPanel = uimanager:GetPanel("UISanctuaryPanel")
        if UISanctuaryPanel ~= nil then
            UISanctuaryPanel:ChangeRemainKillNum(tblData.count)
        end
    end
end
--endregion

--region ID:71036 ResCleanBossOwnerMessage 返回副本boss信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDuplicateBossInfo lua table类型消息数据
---@param csData duplicateV2.ResDuplicateBossInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71036] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2.HaveBoss = not tblData.bossSurvival
end
--endregion

--region ID:71037 ResPrisonRemainTimeMessage 返回犯人剩余坐牢时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResPrisonRemainTime lua table类型消息数据
---@param csData duplicateV2.ResPrisonRemainTime C# class类型消息数据
netMsgPreprocessing[71037] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if csData.isPrisoner then
            uimanager:CreatePanel("UIPrisonPanel", nil, csData.remainTime)
        end
    end
end
--endregion

--region ID:71040 ResSabacRankInfoMessage 沙巴克排名信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResSabacRankInfo lua table类型消息数据
---@param csData duplicateV2.ResSabacRankInfo C# class类型消息数据
netMsgPreprocessing[71040] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    -- print('沙巴克排名信息~~~')
    -- --print("ResSabacRankInfoMessage 71040 沙巴克排行信息返回")
    if (not uiStaticParameter.mIsCurrentShaBaK) then
        return ;
    end
    uiStaticParameter.CurShaBaKRankIndex = 0;
    CS.CSScene.MainPlayerInfo.DuplicateV2:UpdateShaBaKRankInfo(csData);
end
--endregion

--region ID:71042 ResGoddessBlessingInfoMessage 女神赐福信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResGoddessBlessingInfo lua table类型消息数据
---@param csData duplicateV2.ResGoddessBlessingInfo C# class类型消息数据
netMsgPreprocessing[71042] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2:SetGoddessBlessingInfo(csData)
    -- print("女神赐福信息~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    local panel = uimanager:GetPanel("UIGoddessesBlessLeftMianPanel")
    if panel == nil then
        if CS.CSScene.Sington:IsOnGoddesMap() then
            uimanager:GetPanel("UIMainMenusPanel"):ChangLeftPanel("UIGoddessesBlessLeftMianPanel")
        end
    end
end
--endregion

--region ID:71043 ResDreamlandInfoMessage 幻境迷宫消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDreamlandInfo lua table类型消息数据
---@param csData duplicateV2.ResDreamlandInfo C# class类型消息数据
netMsgPreprocessing[71043] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2:SetDreamLandInfo(csData)
    --local panel = uimanager:GetPanel("UIHuanJingLeftMainPanel")
    --if panel == nil then
    --    uimanager:GetPanel("UIMainMenusPanel"):ChangLeftPanel("UIHuanJingLeftMainPanel")
    --end
end
--endregion

--region ID:71044 ResCanDeliveryMessage 返回幻境可传送层数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResCanDelivery lua table类型消息数据
---@param csData duplicateV2.ResCanDelivery C# class类型消息数据
netMsgPreprocessing[71044] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2.CanDeliverFloor = csData.layer
end
--endregion

--region ID:71048 ResDuboLookBetMessage 请求武道会下注
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResBetPlayerInfo lua table类型消息数据
---@param csData duplicateV2.ResBetPlayerInfo C# class类型消息数据
netMsgPreprocessing[71048] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --CS.CSScene.MainPlayerInfo.BudowillInfo:UpdateBetPlayerList(csData)
    luaclass.BuDouKaiBetDataClass:RefreshBetTable(tblData)
end
--endregion

--region ID:71050 ResLookDuboRankMessage 响应查看武道会排行榜
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResBudoRank lua table类型消息数据
---@param csData duplicateV2.ResBudoRank C# class类型消息数据
netMsgPreprocessing[71050] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        CS.CSScene.MainPlayerInfo.RankInfoV2:UpdataWdhRankInfo(csData)
        CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateBuDouKaiSettleInfo(csData)
    end
end
--endregion

--region ID:71051 ResBudoDuplicatePhaseInfoMessage 查看武道会阶段信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.BudoDuplicatePhaseInfo lua table类型消息数据
---@param csData duplicateV2.BudoDuplicatePhaseInfo C# class类型消息数据
netMsgPreprocessing[71051] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BudowillInfo:UpdateBuDouKaiStageMsg(csData)
    end
end
--endregion

--region ID:71052 ResBudoDuplicateUpdateInfoMessage 武道会玩家更新信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.BudoDuplicateUpdateInfo lua table类型消息数据
---@param csData duplicateV2.BudoDuplicateUpdateInfo C# class类型消息数据
netMsgPreprocessing[71052] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BudowillInfo:UpdateBuDouKaiStageMsg(csData)
    end
end
--endregion

--region ID:71054 ResSabacTacticsMessage 沙巴克法阵状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResSabacTactics lua table类型消息数据
---@param csData duplicateV2.ResSabacTactics C# class类型消息数据
netMsgPreprocessing[71054] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2.LastTacticsTryActiveTime = tblData.tacticsEndTime;
    local panel = uimanager:GetPanel("UICityWarMiDaoFaZhenTipsPanel");
    local customData = {};
    customData.faZhenState = csData;
    if (panel == nil) then
        uimanager:CreatePanel("UICityWarMiDaoFaZhenTipsPanel", nil, customData)
    else
        panel:Show(customData);
    end
end
--endregion

--region ID:71056 ResSabacTacticsFailMessage 沙巴克法阵激活失败
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[71056] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2.LastTacticsTryActiveTime = CS.CSServerTime.Instance.TotalMillisecond;
    uimanager:ClosePanel("UICityWarMiDaoFaZhenTipsPanel");
    uimanager:ClosePanel("UICityWarMiDaoFaZhenPanel");

end
--endregion

--region ID:71057 ResSabacTacticsActivedMessage 沙巴克法阵激活公告, 全服
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResSabacTacticsActived lua table类型消息数据
---@param csData duplicateV2.ResSabacTacticsActived C# class类型消息数据
netMsgPreprocessing[71057] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2.LastTacticsActivedTime = tblData.activeTime;
    uimanager:ClosePanel("UICityWarMiDaoFaZhenTipsPanel");
    uimanager:ClosePanel("UICityWarMiDaoFaZhenPanel");
    --uimanager:CreatePanel("UICityWarMiDaoFaZhenActivedTipsPanel", nil, { type = luaEnumShaBakTipsType.MiDaoFaZhenWarring });
end
--endregion

--region ID:71058 ResSabacTacticsEffectMessage 沙巴克法阵激活效果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResSabacTacticsEffect lua table类型消息数据
---@param csData duplicateV2.ResSabacTacticsEffect C# class类型消息数据
netMsgPreprocessing[71058] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --print("沙巴克法阵激活效果");
end
--endregion

--region ID:71059 ResSabacScoreInfoMessage 沙巴克积分信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.SabacScoreInfo lua table类型消息数据
---@param csData duplicateV2.SabacScoreInfo C# class类型消息数据
netMsgPreprocessing[71059] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DuplicateV2.ShaBaKScoreInfo = csData;

    gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():UpdateShaBaKScoreData(tblData)
end
--endregion

--region ID:71061 ResCrowdFundingPanelMessage 发送众筹面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResCrowdFundingPanel lua table类型消息数据
---@param csData duplicateV2.ResCrowdFundingPanel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71061] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71064 ResCrowdFundingChangeMessage 发送酬金金额变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResCrowdFundingChange lua table类型消息数据
---@param csData duplicateV2.ResCrowdFundingChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71064] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71066 ResBrokerPanelMessage 掮客面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResBrokerPanel lua table类型消息数据
---@param csData duplicateV2.ResBrokerPanel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71066] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71069 ResGoddessBlessingRankInfoMessage 女神赐福排名信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.GoddessBlessingRankInfo lua table类型消息数据
---@param csData duplicateV2.GoddessBlessingRankInfo C# class类型消息数据
netMsgPreprocessing[71069] = function(msgID, tblData, csData)
    if csData == nil then
        return
    end
    if csData.rankType == 3 then
        return
    end
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo:SetGoddessList(csData)
    --local customData = {}
    --customData.id = 3
    --customData.myRankId = 1
    uimanager:CreatePanel("UIActivityRankPanel", nil, {
        id = LuaEnuActivityRankID.Goddess
    })
end
--endregion

--region ID:71070 ResPlayerActivityDataRankMessage 返回玩家活动数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResPlayerActivityDataRank lua table类型消息数据
---@param csData duplicateV2.ResPlayerActivityDataRank C# class类型消息数据
netMsgPreprocessing[71070] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo:SetDreamLandMazeList(csData)
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllBossHurt = csData.allBossHurt
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllBossKill = csData.allBossKill
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllKill = csData.allKill
    CS.CSScene.MainPlayerInfo.ActivityInfo.dreamLandState = 1
end
--endregion

--region ID:71072 ResLikeMessage 点赞返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.LikeResponseCommon lua table类型消息数据
---@param csData duplicateV2.LikeResponseCommon C# class类型消息数据
netMsgPreprocessing[71072] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        --判断是否是当前活动的当前期数
        if uiStaticParameter.ActivityRankPanelType[csData.activityId] ~= nil then
            if uiStaticParameter.UIRankManager ~= nil and csData.periodParam == uiStaticParameter[uiStaticParameter.ActivityRankPanelType[csData.activityId]] then
                uiStaticParameter.UIRankManager:RefreshLikeInfo(csData)
            end
        end
    end
end
--endregion

--region ID:71074 ActivityEndRankMessage 弹出活动结算面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ActivityEndRank lua table类型消息数据
---@param csData duplicateV2.ActivityEndRank C# class类型消息数据
netMsgPreprocessing[71074] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo:SetDreamLandMazeListEnd(csData)
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllBossHurt = csData.allBossHurt
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllBossKill = csData.allBossKill
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllKill = csData.allKill

    CS.CSScene.MainPlayerInfo.ActivityInfo.dreamLandState = 2
    if (uimanager:GetPanel("UIActivityRankPanel") == nil) then
        uimanager:CreatePanel("UIActivityRankPanel", function()
            --networkRequest.ReqPlayerActivityDataRank()
        end, {
            id = LuaEnuActivityRankID.DreamLandMaze,
            closeCallback = function()

            end,
            refreshCallBack = function()
                --networkRequest.ReqPlayerActivityDataRank()
            end
        })
    end

end
--endregion

--region ID:71075 ResGoddessBlessingEndMessage 女神赐福结束
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[71075] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo.rankTime = 0
    networkRequest.ReqGetGoddessBlessingRankInfo(1)
    CS.CSScene.MainPlayerInfo.ActivityInfo.IsOpenGoddess = true
end
--endregion

--region ID:71077 ResTodayUseFireworkMessage 返回今日是否使用烟花
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResTodayUseFirework lua table类型消息数据
---@param csData duplicateV2.ResTodayUseFirework C# class类型消息数据
netMsgPreprocessing[71077] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSMissionManager.Instance.IsUsedYanHua = csData.isUse == 1
    luaEventManager.DoCallback(LuaCEvent.Task_YanHua);
end
--endregion

--region ID:71079 ResGBPreviousPeriodTimeMessage 活动往期时间响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResGBPreviousPeriodTime lua table类型消息数据
---@param csData duplicateV2.ResGBPreviousPeriodTime C# class类型消息数据
netMsgPreprocessing[71079] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71081 ResGBPreviousPeriodInfoMessage 往期女神赐福数据响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.GoddessBlessingRankInfo lua table类型消息数据
---@param csData duplicateV2.GoddessBlessingRankInfo C# class类型消息数据
netMsgPreprocessing[71081] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo:SetGoddessList(csData)
    local customData = {}
    customData.id = 3
    customData.myRankId = 1
    uimanager:CreatePanel("UIActivityRankPanel", nil, customData)
end
--endregion

--region ID:71083 ResSabacRecordMessage 沙巴克历史记录
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResSabacRecord lua table类型消息数据
---@param csData duplicateV2.ResSabacRecord C# class类型消息数据
netMsgPreprocessing[71083] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local data = CS.CSScene.MainPlayerInfo.DuplicateV2:GetShaBaKRankInfo(csData);
    CS.CSScene.MainPlayerInfo.DuplicateV2:UpdateShaBaKRankInfo(data);
    uimanager:CreatePanel("UIActivityRankPanel", function()
        networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill), 1, uiStaticParameter.mShaBaKRankOnePageCount);
    end, {
        id = LuaEnuActivityRankID.ShaBaK,
        refreshCallBack = function()
            networkRequest.ReqGetSabacRankInfo(Utility.EnumToInt(CS.duplicateV2.SabacRankType.Kill), 1, uiStaticParameter.mShaBaKRankOnePageCount);
        end
    })
end
--endregion

--region ID:71085 ResGetPreviousReviewMessage 返回往期内容时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResGetPreviousReview lua table类型消息数据
---@param csData duplicateV2.ResGetPreviousReview C# class类型消息数据
netMsgPreprocessing[71085] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:71087 ResDreamlandRankInfoMessage 返回幻境具体某一期的内容
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDreamlandRankInfo lua table类型消息数据
---@param csData duplicateV2.ResDreamlandRankInfo C# class类型消息数据
netMsgPreprocessing[71087] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.ActivityInfo.dreamLandState = 3
    CS.CSScene.MainPlayerInfo.ActivityInfo:UpdateDreamLandMazeList(csData);
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllBossHurt = csData.allBossHurt
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllBossKill = csData.allBossKill
    CS.CSScene.MainPlayerInfo.ActivityInfo.AllKill = csData.allKill
end
--endregion

--region ID:71090 ResBudoMeetAroundMessage 返回武道会决赛圈
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResBudoMeetAround lua table类型消息数据
---@param csData duplicateV2.ResBudoMeetAround C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71090] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil then
        --print("服务器触发打开隐形墙" .. "隐形墙阶段==>" .. tostring(tblData.phase) .. "  实际武道会阶段===>" .. tostring(CS.CSScene.MainPlayerInfo.BudowillInfo.mBuDouKaiStage) .. "   武道会是否有隐形墙点" .. tostring(tblData.wallPoint ~= nil and #tblData.wallPoint > 0))
        luaclass.BuDouKaiLuaDataClass:OpenInVisibilityWall(tblData)
    else
        luaclass.BuDouKaiLuaDataClass:CloseInVisibilityWall()
    end
end
--endregion

--region ID:71091 ResDevilSquareEndTimeMessage 返回恶魔广场结束时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDevilSquareEndTime lua table类型消息数据
---@param csData duplicateV2.ResDevilSquareEndTime C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71091] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    Utility.SetCopyEndTimestamp(tblData)
    luaEventManager.DoCallback(LuaCEvent.UpdateDevilEndTime, tblData)
end
--endregion

--region ID:71093 ResDevilSquareHasTimeMessage 返回恶魔广场剩余时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResDevilSquareHasTime lua table类型消息数据
---@param csData duplicateV2.ResDevilSquareHasTime C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71093] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    Utility.SetCopylastTimestamp(tblData)
    luaEventManager.DoCallback(LuaCEvent.UpdateDevilRemaining, tblData)
end
--endregion

--region ID:71094 ResUseDevilScrollPromptMessage 使用恶魔卷轴后提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResUseDevilScrollPrompt lua table类型消息数据
---@param csData duplicateV2.ResUseDevilScrollPrompt C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71094] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --恶魔广场
    --if (CS.CSMapManager.Instance.mapInfoTbl ~= nil and CS.CSMapManager.Instance.mapInfoTbl.announceDeliver == 1023) then
    --    return
    --end
    --local evilSquarePanel = uimanager:GetPanel("UIDevilSquarePanel")
    --if (evilSquarePanel) then
    --    return
    --end
    --
    --local panel = uimanager:GetPanel('UIPromptPanel')
    --local temp = {}
    --temp.Title = ''
    --temp.Content = "[fffff0]是否前往恶魔广场"
    --temp.LeftDescription = "取消"
    --temp.RightDescription = "确认"
    ----temp.IsClose = false
    --temp.CallBack = function()
    --    networkRequest.ReqDeliverByConfig(tblData.deliverId)
    --    uimanager:ClosePanel('UIPromptPanel')
    --
    --    --寻路后打开面板
    --    local aim = {}
    --    local npcId = 61
    --    table.insert(aim, npcId)
    --    local PanelName = "UIDevilSquarePanel"
    --    CS.CSScene.MainPlayerInfo.AsyncOperationController.GoForNPCAndOpenPanel:DoOperation(aim, PanelName, CS.EAutoPathFindSourceSystemType.Normal, CS.EAutoPathFindType.Normal_TowardNPC)
    --end
    --if panel then
    --    panel:Show(temp)
    --else
    --    uimanager:CreatePanel("UIPromptPanel", nil, temp)
    --end
end
--endregion

--region ID:71096 ResBudoBetBeiInfoMessage 武道会押注信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.BudoBetBeiInfo lua table类型消息数据
---@param csData duplicateV2.BudoBetBeiInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71096] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.BuDouKaiBetDataClass:RefreshAllMatchSingleBetInfo(tblData)
end
--endregion

--region ID:71097 ResBudoBetSuccessMessage 武道会押注成功信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.BudoBetSuccess lua table类型消息数据
---@param csData duplicateV2.BudoBetSuccess C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71097] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.BuDouKaiBetDataClass:RefreshSingleBetInfo(tblData)
end
--endregion

--region ID:71098 ResWolfDreamXpSkillChangeTimeMessage 狼烟梦境放XP技能更改加速系数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResWolfDreamXpSkillChangeTime lua table类型消息数据
---@param csData duplicateV2.ResWolfDreamXpSkillChangeTime C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71098] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        if uiStaticParameter.CurXpSkillId == tblData.skillId then
            return
        end
        uiStaticParameter.CurXpSkillId = tblData.skillId
        luaEventManager.DoCallback(LuaCEvent.RefreshCurXpSkillId)
    end
end
--endregion

--region ID:71099 ResUndergroundDuplicateInfoMessage 地下行宫副本信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.UndergroundDuplicateInfo lua table类型消息数据
---@param csData duplicateV2.UndergroundDuplicateInfo C# class类型消息数据
netMsgPreprocessing[71099] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData ~= nil then
        CS.CSScene.MainPlayerInfo.ActivityInfo.UninDungeonMonsterNumber = tblData.monsterLiveLeft;
    end

end
--endregion

--region ID:71100 ResPushBubbleMessage 推送地下行宫气泡消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.PushBubble lua table类型消息数据
---@param csData duplicateV2.PushBubble C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71100] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if uimanager:GetPanel("UIGuildPalaceLeftMainPanel") then
        Utility.RemoveFlashPrompt(1, 35)
        return
    end
    local AtciveID = Utility.GetNowGuildDungeonAtciveID()
    if AtciveID == 0 or AtciveID == nil then
        Utility.RemoveFlashPrompt(1, 35)
        return
    end
    if LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate ~= nil then
        LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate:Reset()
        CS.CSListUpdateMgr.Instance:Remove(LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate)
    end
    local time = LuaGlobalTableDeal:GetUnionDungeonBubbleTime()
    LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate = CS.CSListUpdateMgr.Add(time, nil, function()
        Utility.RemoveFlashPrompt(1, 35)
    end)
    CS.CSListUpdateMgr.Instance:Add(LuaGlobalTableDeal.GuildDungeonPrompShowListUpdate)

    --等级不够
    if Utility.UnionDungeonEnterLimit() == false then
        return
    end
    --获取地图数据
    local res, mapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(tblData.mapId)
    if not res then
        return
    end
    --获取怪物数据
    local res2, monsterInfo = CS.Cfg_MonsterTableManager.Instance.dic:TryGetValue(tblData.monsterId)
    if not res2 then
        return
    end
    local mapId = CS.CSScene.getMapID()
    --获取当前副本数据
    local res3, duplicateInfo = CS.Cfg_DuplicateTableManager.Instance.dic:TryGetValue(mapId)
    if res3 then
        --在地图内不提醒
        if duplicateInfo.type == 42 then
            return
        end
    end

    local PromptWordId = 137
    local dataID = 35
    local duplicateId = tblData.mapId
    local windowEndTime = CS.CSServerTime.Instance.TotalMillisecond + LuaGlobalTableDeal:GetUnionDungeonBubbleTime()
    Utility.RemoveFlashPrompt(1, dataID)

    local data = {}
    data.id = dataID
    data.clickCallBack = function()
        local TipData = {}
        TipData.PromptWordId = PromptWordId
        TipData.des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(PromptWordId, mapInfo.name, monsterInfo.name)
        TipData.Time = windowEndTime
        TipData.ComfireAucion = function()
            Utility.RemoveFlashPrompt(1, dataID)
            if Utility.IsMainPlayerHasGuild() then
                networkRequest.ReqEnterDuplicate(duplicateId)
                CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop()
                CS.CSPathFinderManager.Instance:Reset()
            end
        end
        TipData.CancelCallBack = function()
            Utility.RemoveFlashPrompt(1, dataID)
        end

        TipData.CloseCallBack = function()
            uimanager:ClosePanel('UIPromptPanel')
        end

        TipData.TimeCallBack = function(UICountdownLabel)
            UICountdownLabel:StartCountDown(nil, 7, windowEndTime, "[bb3520]", "内有效[-]", nil, function()
                uimanager:ClosePanel("UIPromptPanel")
            end)
        end
        Utility.ShowSecondConfirmPanel(TipData)
    end
    Utility.TryAddFlashPromp(data)
end
--endregion

--region ID:71101 ResUndergroundMyUnionRankMessage 行宫我的帮会排名
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.UndergroundMyUnionRank lua table类型消息数据
---@param csData duplicateV2.UndergroundMyUnionRank C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71101] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil then
        CS.CSScene.MainPlayerInfo.ActivityInfo.UninDungeonRank = tblData.myUnionRank
    end

end
--endregion

--region ID:71102 ResRaiderDuplicateInfoMessage 夺宝奇兵副本信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.RaiderInfo lua table类型消息数据
---@param csData duplicateV2.RaiderInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71102] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaDuplicateMgr():RefreshShiWangData(tblData)
    local panel = uimanager:GetPanel("UIShiWangDianLeftPanel")
    if panel == nil then
        if CS.CSScene:getMapID() == 21002 then
            local menuPanel = uimanager:GetPanel("UIMainMenusPanel")
            if menuPanel then
                menuPanel:ChangLeftPanel("UIShiWangDianLeftPanel")
            end
        end
    end
end
--endregion

--region ID:71103 ResSabacPersonalRankInfoMessage 沙巴克个人积分排名信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResSabacRankInfo lua table类型消息数据
---@param csData duplicateV2.ResSabacRankInfo C# class类型消息数据
netMsgPreprocessing[71103] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetShaBaKDataManager():UpdateShaBaKPersonalRankData(csData);
end
--endregion

--region ID:71105 ResTowerInstanceEndGetRewardMessage 通天塔通关后获取到的奖励弹面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResTowerInstanceEndGetReward lua table类型消息数据
---@param csData duplicateV2.ResTowerInstanceEndGetReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[71105] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():SetCurrentReward(tblData.rewards)
end
--endregion
