--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--play.xml

--region ID:73022 ResCommonMessage 返回客户端通用消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData playV2.CommonInfo lua table类型消息数据
---@param csData playV2.CommonInfo C# class类型消息数据
netMsgPreprocessing[73022] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo == nil then
            return
        end
        if tblData.type == luaEnumRspServerCommonType.MidNight then
            --零点事件
            --零点时需要清空物品的使用次数
            mainPlayerInfo.BagInfo:ClearItemUseCount()
            --零点时需要重置开服时间
            mainPlayerInfo.OpenServerDayNumber = -1
            --零点时需要重置合服时间
            mainPlayerInfo.CombineServerDayNumber = -1
            networkRequest.ReqGetRechargeInfo()
            CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_FirstReward)
            CS.Cfg_GlobalTableManager.Instance:ResetVIPLevelList()
            CS.Cfg_GlobalTableManager.Instance:ParseVipLevel()
            CS.Cfg_GlobalTableManager.Instance:ParseChatLevelLimit()
            gameMgr:GetLuaTimeMgr():UpdateNowDayWeeHoursTime(CS.CSServerTime.Instance.TotalMillisecond, true)
            gameMgr:GetPlayerDataMgr():GetMainPlayerSkillMgr():CallSpecialRed()
            if gameMgr:GetPlayerDataMgr() then
                ---零点时触发一次合成红点计算
                gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint()
            end
            gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RequestRefreshItemUseCount()
        end
        if tblData.type == luaEnumRspServerCommonType.PutOnTheEquip and tblData.data ~= nil then
            local eventId = tblData.data64
            if (eventId == 1 or eventId == 2) then
                ---装备变动来源为1的话是合成, 合成不推送
                ---装备变动来源为2的话是淬炼, 淬炼不推
                return ;
            end
            ---推送自动穿戴的装备不自动打开角色界面
            if luaclass.BetterItemHint_Control:IsHintEquip(tblData.data) == true then
                return
            end
            local equipIndex = tonumber(tblData.str)
            if equipIndex ~= nil and CS.CSServantInfoV2.GetEquipSubTypeFromRoleEquipIndexForServant(equipIndex) ~= 0 then
                ---若为灵兽穿戴的角色装备,则不打开角色界面
                return
            end
            local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(tblData.data)
            local level = CS.Cfg_GlobalTableManager.Instance:GetAutoOpenRolePanelLevel()
            if uiStaticParameter.PutOnEquipAutoOpenRolePanel and itemInfoIsFind and mainPlayerInfo.Level < level then
                ---套装类型
                local DivineSuitType = clientTableManager.cfg_itemsManager:GetDivineSuitType(tblData.data)
                ---人物穿戴装备||兵鉴穿戴后，自动打开对应的角色-兵鉴界面
                if (mainPlayerInfo.EquipInfo:CheckIsRoleEquip(itemInfo) or (DivineSuitType ~= nil and DivineSuitType > 0)) then
                    local isZhenFaEquip = itemInfo.subType >= LuaEnumPlayerEquipIndex.LingFu and itemInfo.subType <= LuaEnumPlayerEquipIndex.XianZhu
                    if not isZhenFaEquip then
                        local customData = {
                            type = LuaEnumLeftTagType.UIRolePanel,
                            openSourceType = LuaEnumPanelOpenSourceType.ByBagPanel,
                        }
                        ---@param uiPanel UIRolePanel
                        local openPanelFunc = (DivineSuitType ~= nil and DivineSuitType > 0) and function(uiPanel)
                            if (uiPanel ~= nil) then
                                uiPanel:SwitchSuitPage(DivineSuitType)
                            end
                        end or nil
                        uimanager:CreatePanel("UIRolePanelTagPanel", nil, customData, openPanelFunc)
                    end
                end
            end
            uiStaticParameter.PutOnEquipAutoOpenRolePanel = true
        elseif tblData.type == luaEnumRspServerCommonType.Activity_CanAward and tblData.data ~= nil then
            mainPlayerInfo.ActivityInfo:UpdateCompetitionSingleInfo(csData)
        elseif tblData.type == luaEnumRspServerCommonType.PlayerZeroLevelChange then
            mainPlayerInfo:UpdateZeroLevel(csData);
        elseif tblData.type == luaEnumRspServerCommonType.ServantExpAndReinPool then
            mainPlayerInfo.ServantInfoV2.ResServantInfo.expPool = tblData.data64
            mainPlayerInfo.ServantInfoV2.ResServantInfo.reinPool = tblData.str
        end

        if (tblData.type == luaEnumRspServerCommonType.OpenBuDouKaiRankPanel) then
            CS.CSListUpdateMgr.Add(200, nil, function()
                if mainPlayerInfo == nil or mainPlayerInfo.ActivityInfo == nil then
                    return
                end
                mainPlayerInfo.ActivityInfo:UpdateMainPlayerSettleInfo(csData)
                mainPlayerInfo.ActivityInfo.ShowRank = true
                networkRequest.ReqLookDuboRank(1)
            end, false)
        end
        if tblData.type == luaEnumRspServerCommonType.FirstLogIn then
            local unionInfo = mainPlayerInfo.UnionInfoV2
            local unionID = unionInfo.UnionID
            local levelLimit = CS.Cfg_GlobalTableManager.Instance:GetUnionPushList()
            if levelLimit and levelLimit.Length >= 2 then
                if mainPlayerInfo.Level >= levelLimit[0] and mainPlayerInfo.Level <= levelLimit[1] and unionID == 0 then
                    uiStaticParameter.mNeedShowUnionPush = true
                end
            end
        end

        if tblData.type == luaEnumRspServerCommonType.TreasureWarehouseHaveProp then
            mainPlayerInfo.TreasureInfo.IsStartTreasureWarehouseHaveProp = true
        end

        if (tblData.type == luaEnumRspServerCommonType.Group_Refuse) then
            local autoTeamVo = CS.CSScene.Sington.AutomaticTeam:GetCurrentAutoTeamParams();
            if (autoTeamVo ~= nil) then
                if (autoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_OR_CHANGEPKMODEL)) then
                    autoTeamVo:UpdateState(Utility.EnumToInt(CS.AutomaticTeamState.JOIN_REFUSE_CHANGEPKMODEL));
                elseif (autoTeamVo.state == Utility.EnumToInt(CS.AutomaticTeamState.JOIN_OR_FIGHT)) then
                    autoTeamVo:UpdateState(Utility.EnumToInt(CS.AutomaticTeamState.JOIN_REFUSE_FIGHT));
                end
                uimanager:CreatePanel(autoTeamVo.panelName, nil, autoTeamVo);
            end
        end

        if tblData.type == luaEnumRspServerCommonType.StoreNextFlush then
            ---商店下次刷新时间
            if gameMgr:GetGameDataManager() ~= nil then
                gameMgr:GetGameDataManager():GetLuaStoreData():SetStoreFlushTime(tblData)
            end
        end

        if tblData.type == LuaEnumCommonMapMsgType.LoginLeagueMapTime then
            local time = tblData.data64
            gameMgr:GetPlayerDataMgr():GetLeagueInfo():RefreshLoginLeagueMapTime(time)
        end

        if tblData.type == luaEnumRspServerCommonType.KuaFuState then
            ---跨服开启状态
            gameMgr:GetPlayerDataMgr():GetShareMapInfo():RefreshKuaFuOpenState(tblData.data == 1)
            --CS.CSCalendarInfoV2.Instance:InitializeCalendar();
            --改变历法事件
        end

        if tblData.type == luaEnumRspServerCommonType.RoleExpChangeByExpBox then
            if tblData.data ~= nil and tblData.data64 ~= nil then
                ---@type TABLE.cfg_items
                local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(tblData.data64)
                if itemTbl ~= nil then
                    local num = tonumber(tblData.str)
                    if num == nil or num == 0 then
                        num = 1
                    end
                    local expNum = (itemTbl:GetUseParam() ~= nil and itemTbl:GetUseParam().list.Count > 0) and itemTbl:GetUseParam().list[0] or 0
                    expNum = expNum * num
                    for i = 1, tblData.data do
                        ---@type UIAllTextTipsContainerPanel
                        local uiAllTextTipsContainerPanel = uimanager:GetPanel("UIAllTextTipsContainerPanel")
                        if uiAllTextTipsContainerPanel then
                            uiAllTextTipsContainerPanel.SendMiddleTopTips("[fffab3]获得了[-]", tblData.data64, '人物经验' .. tostring(expNum))
                        else
                            uimanager:CreatePanel("UIAllTextTipsContainerPanel", function()
                                uiAllTextTipsContainerPanel.SendMiddleTopTips("[fffab3]获得了[-]", tblData.data64, '人物经验' .. tostring(expNum))
                            end)
                        end
                    end
                end
            end
        end
        if tblData.type == luaEnumRspServerCommonType.SpecialActivity then
            if tblData.data ~= nil and tblData.data64 ~= nil then
                gameMgr:GetPlayerDataMgr():GetSpecialActivityData():ChangeSingleActivityRedPointState(tblData.data, tblData.data64 == 1)
            end
        end
        if tblData.type == luaEnumRspServerCommonType.AddShengWang then
            if tblData.data ~= nil then
                local avatar = CS.CSScene.Sington:getAvatar(CS.CSScene.MainPlayerInfo.ID)
                if avatar and avatar.Head then
                    local showStr = 's+' .. tostring(tblData.data)
                    avatar.Head:PlayText(showStr, CS.ThrowTextType.Prestige)
                end
            end
        end
    end
end
--endregion

--region ID:73026 ResMapCommonMessage 返回客户端地图通用消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData playV2.CommonInfo lua table类型消息数据
---@param csData playV2.CommonInfo C# class类型消息数据
netMsgPreprocessing[73026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData.type == LuaEnumCommonMapMsgType.GROUPHP then
    end
    if tblData.type == LuaEnumCommonMapMsgType.BUDOUKAIREQ_TRANSFER then
        --print("服务器消息==>弹窗传送")
        CS.CSScene.MainPlayerInfo.BudowillInfo:RefreshTransferArenaInfo(csData)
        local commonData = {}
        local prompId = 51
        local prompWordInfoIsFind, prompWordInfo = CS.Cfg_GlobalTableManager.Instance:TryGetValue(prompId)
        if prompWordInfoIsFind then
            commonData.PromptWordId = prompId
            commonData.timeLittleChangeColor = false
            commonData.des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(prompId, CS.CSScene.MainPlayerInfo.BudowillInfo:GetBuDouKaiStageName())
            commonData.Time = CS.CSScene.MainPlayerInfo.BudowillInfo:GetRemainSecondTime() * 1000
            if prompWordInfo.countDown ~= nil and CS.CSScene.MainPlayerInfo.BudowillInfo:GetRemainSecondTime() > prompWordInfo.countDown then
                commonData.Time = prompWordInfo.countDown * 1000
            end
            commonData.TimeText = CS.Cfg_GlobalTableManager.Instance:GetBuDouKaiRemainTimeText()
            commonData.ComfireAucion = function()
                networkRequest.ReqMapCommon(LuaEnumCommonMapMsgType.BUDOUKAIREQ_TRANSFER, 1, csData.str)
                CS.CSScene.MainPlayerInfo.BudowillInfo:ClearTransferArenaInfo()
            end
            commonData.CancelCallBack = function()
                -- networkRequest.ReqMapCommon(LuaEnumCommonMapMsgType.BUDOUKAIREQ_TRANSFER, 2, csData.str)
                -- CS.CSScene.MainPlayerInfo.BudowillInfo:ClearTransferArenaInfo()
            end
            commonData.TimeEndCallBack = function()
                networkRequest.ReqMapCommon(LuaEnumCommonMapMsgType.BUDOUKAIREQ_TRANSFER, 1, csData.str)
                CS.CSScene.MainPlayerInfo.BudowillInfo:ClearTransferArenaInfo()
                uimanager:ClosePanel("UIPromptPanel")
            end
            Utility.ShowSecondConfirmPanel(commonData)

            local delayed = CS.CSListUpdateMgr.Add(commonData.Time, nil, function()
                if CS.CSResUpdateMgr.Instance ~= nil then
                    networkRequest.ReqMapCommon(LuaEnumCommonMapMsgType.BUDOUKAIREQ_TRANSFER, 1, csData.str)
                    CS.CSScene.MainPlayerInfo.BudowillInfo:ClearTransferArenaInfo()
                end
            end)
            CS.CSListUpdateMgr.Instance:Add(delayed)
        end
    end
    if tblData.type == LuaEnumCommonMapMsgType.MEET_WALL then
        if tblData.data == luaEnumArenaStageType.CLOSE then
            --print("服务器关闭擂台特效")
            CS.CSScene.MainPlayerInfo.BudowillInfo:CloseOpenArena()
        elseif tblData.data == luaEnumArenaStageType.OPEN then
            --print("服务器开启擂台特效")
            CS.CSScene.MainPlayerInfo.BudowillInfo:TryOpenArena()
        end
    end
    if tblData.type == LuaEnumCommonMapMsgType.BUDOUKAI_KILLNUM then
        ---刷新武道会存活数量
        CS.CSScene.MainPlayerInfo.BudowillInfo:UpdateSurvivalPlayerNum(tblData.str)
        ---杀人数
        CS.CSScene.MainPlayerInfo.BudowillInfo:RefreshAllPlayerKillCount(csData)
    end

    if (tblData.type == LuaEnumCommonMapMsgType.BUDOUKAI_ODDS) then
        local playerIdAndMaxBetNum = string.Split(tblData.str, "|");
        if (playerIdAndMaxBetNum[1] ~= nil and playerIdAndMaxBetNum[2] ~= nil) then
            local maxZhu = tonumber(playerIdAndMaxBetNum[1]);
            local playerId = tonumber(playerIdAndMaxBetNum[2]);
            CS.CSScene.MainPlayerInfo.BudowillInfo.MaxZhu = maxZhu;
            luaEventManager.DoCallback(LuaCEvent.WDH_OnPlayerBetUpdated);
        end
    end
    if tblData.type == LuaEnumCommonMapMsgType.Temple_Trans then
        --神庙传送
        local needItem = CS.Cfg_GlobalTableManager.Instance.TempleNeedItemId
        local needCount = CS.Cfg_GlobalTableManager.Instance.TempleNeedItemCount
        local isfind, itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(needItem)
        if not isfind then
            return
        end
        local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(93)
        if not isFind then
            return
        end
        local isNeedShow = true
        local coinName = CS.Cfg_ItemsTableManager.Instance:GetItemName(needItem)
        local eventid = tblData.data64
        uimanager:CreatePanel("UIPromptPanel", nil, {
            Content = info.des,
            CenterDescription = info.leftButton,
            IsClose = false,
            ID = 93,
            visabelText = "本次登录不再提示",
            IsToggleVisable = true,
            IsShowGoldLabel = true,
            isOpenToggleVisabel = true,
            GoldIcon = itemInfo.icon,
            GoldCount = needCount,
            CallBack = function(panel)
                local mCoinNum = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(needItem);
                if mCoinNum < needCount then
                    if panel.go ~= nil and panel.GetCenterButton_GameObject() ~= nil and not CS.StaticUtility.IsNull(panel.GetCenterButton_GameObject()) then
                        local IsFind, wordInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(313)
                        if IsFind then
                            Utility.ShowPopoTips(panel.GetCenterButton_GameObject(), string.format(wordInfo.content, coinName), 313)
                        end
                    else
                        uimanager:ClosePanel("UIPromptPanel")
                    end
                    return
                end
                networkRequest.ReqMapCommon(5, isNeedShow and 0 or 1, nil, eventid)
                uimanager:ClosePanel("UIPromptPanel")
            end,
            OptionBtnCallBack = function(value)
                isNeedShow = value
            end
        })
    end
    if tblData.type == LuaEnumCommonMapMsgType.GatherMonsterStateChange then
        CS.CSSceneExt.Sington:RefreshMonsterGatherState(tblData.data64)
    end

    if tblData.type == LuaEnumCommonMapMsgType.WristPotionPush or tblData.type == LuaEnumCommonMapMsgType.EnergyPotionPush then
        local promptWordID = tblData.type == LuaEnumCommonMapMsgType.WristPotionPush and 126 or 127
        local storeId = tblData.type == LuaEnumCommonMapMsgType.WristPotionPush and LuaGlobalTableDeal:GetWristStrengthStoreId() or LuaGlobalTableDeal:GetEnergyStoreId()
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            mainPlayerInfo.StoreInfoV2:TryGetStoreInfo(storeId, function(vo)
                local temp = {}
                temp.promptWordID = promptWordID
                temp.itemId = vo.storeTable.itemId
                temp.itemGoldID = vo.storeTable.moneyType
                temp.itemGoldNumber = vo.price
                temp.centerBtnClick = function(go)
                    ---判断价格
                    if vo.price > CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(vo.storeTable.moneyType) then
                        local showStr
                        local itemName = CS.Cfg_ItemsTableManager.Instance:GetItemName(vo.storeTable.moneyType)
                        local isFind, promptInfo = CS.Cfg_PromptFrameTableManager.Instance.dic:TryGetValue(401)
                        if isFind then
                            showStr = string.format(promptInfo.content, itemName == nil and '' or itemName)
                            Utility.ShowPopoTips(go, showStr, 401, "UIPurchasePromptPanel")
                        end
                        return
                    end
                    networkRequest.ReqBuyItem(vo.storeId, 1, vo.storeTable.itemId, 1)
                    uimanager:ClosePanel("UIPurchasePromptPanel")
                end
                uimanager:CreatePanel("UIPurchasePromptPanel", nil, temp)
            end)
        end
    end

    if tblData.type == LuaEnumCommonMapMsgType.PlayExpFloateWord then
        if tblData.data ~= nil and tblData.data64 ~= nil then
            local avatar = CS.CSScene.Sington:getAvatar(tblData.data64)
            if avatar and avatar.Head then
                local showStr = 'd+' .. tostring(tblData.data)
                avatar.Head:PlayText(showStr, CS.ThrowTextType.Exp)
            end
        end
    end
    if tblData.type == LuaEnumCommonMapMsgType.Can_Login_Map then
        ---客户端可以发进入地图的包了
        gameMgr:SetServerPrepareFinished()
    end
    if tblData.type == LuaEnumCommonMapMsgType.GodBossActivityOpen then
        luaclass.FinalBossDataInfo:GetMythBossDataInfo():TryOpenGodBossRedPoint()
    end
    if tblData.type == LuaEnumCommonMapMsgType.HidenMapCountDown then
        uimanager:CreatePanel("UIHidenMapCountDownPanel", nil, tblData.data, tblData.data64)
    end
end
--endregion

--region ID:73027 NeedHasAttackModePanelMessage 需要弹出攻击模式提示面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData playV2.NeedHasAttackModePanel lua table类型消息数据
---@param csData playV2.NeedHasAttackModePanel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[73027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        local name = ""
        local activityType = 0
        local res1, activityInfo = CS.Cfg_DailyActivityTimeTableManager.Instance.dic:TryGetValue(tblData.activityId)
        if res1 then
            name = activityInfo.name
            activityType = activityInfo.activityType
        end
        --print(tblData.need)
        local currentName = uiStaticParameter.SererTypeToPKName[tblData.current]
        local changeName = uiStaticParameter.SererTypeToPKName[tblData.need]
        local res, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(65)
        if res then
            local Prompt = {
                Title = promptInfo.title,
                Content = string.format(promptInfo.des, name, changeName, currentName, changeName),
                IsToggleVisable = true,
                ID = 65,
                CallBack = function()
                    networkRequest.ReqSwitchFightModel(tblData.need)
                    ---@type UIPromptPanel
                    local panel = uimanager:GetPanel("UIPromptPanel")
                    if panel then
                        if panel.GetValueToggle_UIToggle().value then
                            networkRequest.TodayNoReminder(activityType)
                        end
                    end
                end,
                CloseCallBack = function()
                    ---@type UIPromptPanel
                    local panel = uimanager:GetPanel("UIPromptPanel")
                    if panel then
                        if panel.GetValueToggle_UIToggle().value then
                            networkRequest.TodayNoReminder(activityType)
                        end
                    end
                end,
            }
            uimanager:CreatePanel("UIPromptPanel", nil, Prompt)
        end
    end

end
--endregion
