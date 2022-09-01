--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--role.xml

--region ID:8001 ResPlayerAttributeChangeMessage 通知属性发生变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResPlayerAttributeChange lua table类型消息数据
---@param csData roleV2.ResPlayerAttributeChange C# class类型消息数据
netMsgPreprocessing[8001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --region 修改属性
    if tblData ~= nil then
        local info = CS.CSScene.GetAvatarInfo(tblData.uid)
        if info ~= nil then
            info.FightPower = tblData.power
            info:UpdatePlayerAttribute(csData.attr)
        end
    end
    --endregion
end
--endregion

--region ID:8003 ResPlayerExpChangeMessage 通知玩家经验发生变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResPlayerExpChange lua table类型消息数据
---@param csData roleV2.ResPlayerExpChange C# class类型消息数据
netMsgPreprocessing[8003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.Exp = tblData.curExp
        CS.CSScene.MainPlayerInfo.InnerExp = tblData.curInnerPowerExp
    end
end
--endregion

--region ID:8004 ResPlayerLevelChangeMessage 通知玩家等级发生变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResPlayerLevelChange lua table类型消息数据
---@param csData roleV2.ResPlayerLevelChange C# class类型消息数据
netMsgPreprocessing[8004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (CS.CSScene.Sington ~= nil and CS.CSScene.Sington.MainPlayer ~= nil and CS.CSScene.MainPlayerInfo.ID == tblData.uid) then
        local lastLevel = CS.CSScene.MainPlayerInfo.Level;
        CS.CSScene.MainPlayerInfo.Level = tblData.curLevel;
        CS.CSScene.MainPlayerInfo.Exp = tblData.curExp;
        CS.CSNetwork.SendClientEvent(CS.CEvent.Role_UpdateLevel, lastLevel, tblData.curLevel);
        CS.CSNetwork.SendDelayClientEvent(CS.CEvent.Role_UpdateLevel_Delay);
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SERVANT_SECOND_PUSH)
        CS.SDKManager.GameInterface:SubmitGameData(CS.ESDKSubmitType.LevelUp);
        CS.Cfg_GlobalTableManager.Instance:ParseDataRecycleAnnounceItemCount();
        CS.Cfg_GlobalTableManager.Instance:ParseDataDropAnnounceItemCount();
        ---移除常显活动列表
        CS.CSNetwork.SendDelayClientEvent(CS.CEvent.V2_RefreshOutActivity);
        if gameMgr and gameMgr:GetLuaMainPlayer() then
            local addTime = tblData.curLevel - lastLevel
            gameMgr:GetLuaMainPlayer():AddLevelUpEffectTime(addTime)
        end
        luaEventManager.DoDelayCallBack(LuaCEvent.Task_CrawlTower);
        if gameMgr:GetPlayerDataMgr() then
            ---等级变化时触发一次合成官阶计算
            gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.OfficialState)
            ---等级变化时触发一次合成红点计算
            gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint()
            ---刷新专精红点
            gameMgr:GetPlayerDataMgr():GetEquipProficientMgr():CallRed(nil, true)
            ---刷新升星红点
            gameMgr:GetPlayerDataMgr():GetLuaStrengthInfo():RefreshStrengthRedPoint()
        end

        --[[        local r = CS.CSResourceManager.Singleton:AddQueue("upgrade", CS.ResourceType.Effect, function(res)
                    if (res == nil or CS.CSScene.IsLanuchMainPlayer == false or CS.CSScene.Sington.MainPlayer.CacheTransform == nil) then
                        return ;
                    end

                    local effect = CS.CSScene.Sington.MainPlayer.Model.Effect.GoTrans;
                    if (effect == nil) then
                        return ;
                    end

                    local RoleUpdatePoolItem = res:GetPoolItem(CS.EPoolType.Normal, 0, 2);
                    if (RoleUpdatePoolItem == nil or RoleUpdatePoolItem.go == nil) then
                        return ;
                    end

                    RoleUpdatePoolItem.go:SetActive(false);
                    RoleUpdatePoolItem.go.transform.parent = effect;
                    RoleUpdatePoolItem.go.transform.localPosition = CS.UnityEngine.Vector3(0, 0, -5);
                    RoleUpdatePoolItem.go.transform.localScale = CS.UnityEngine.Vector3.one;
                    RoleUpdatePoolItem.go:SetActive(true);
                end, CS.ResourceAssistType.UI);
                r.IsCanBeDelete = false;]]
    end
    luaEventManager.DoDelayCallBack(LuaCEvent.RefreshArrestMissionShow)
end
--endregion

--region ID:8007 ResSendRoleReinInfoMessage 发送角色转生信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResSendRoleReinInfo lua table类型消息数据
---@param csData roleV2.ResSendRoleReinInfo C# class类型消息数据
netMsgPreprocessing[8007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData.reinNum ~= nil then
        CS.CSScene.MainPlayerInfo.ReinExp = tblData.reinNum
        CS.CSScene.MainPlayerInfo.ReinCfgID = tblData.cfgId

        local lastReinLevel = CS.CSScene.MainPlayerInfo.ReinLevel
        CS.CSScene.MainPlayerInfo.ReinLevel = tblData.reinLevel
        --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.PLAYER_TurnGrow)

        if lastReinLevel ~= CS.CSScene.MainPlayerInfo.ReinLevel and gameMgr:GetPlayerDataMgr() then
            ---等级变化时触发一次合成红点计算
            gameMgr:GetPlayerDataMgr():GetSynthesisMgr():CallAllRedPoint()
        end
        if tblData.info[1] ~= nil then
            gameMgr:GetPlayerDataMgr():GetReinDataManager():GetMonsterKill(tblData.info)
        end
    end

    --region 设置当前账号当前转生等级所需要的材料箱子Id
    local otherItemDataDic = LuaGlobalTableDeal:GetReinPanelShowItemData();
    ---@type ReinPanelShowItemParams
    if (otherItemDataDic ~= nil) then
        for k, v in pairs(otherItemDataDic) do
            if (CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(v.conditionId)) then
                uiStaticParameter.mCurRoleReinBoxId = v.itemId
                break ;
            end
        end
    end
    --endregion

    luaEventManager.DoDelayCallBack(LuaCEvent.RefreshArrestMissionShow)
end
--endregion

--region ID:8010 ResRoleExchangeReinResultMessage 发送角色兑换修为结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRoleExchangeReinResult lua table类型消息数据
---@param csData roleV2.ResRoleExchangeReinResult C# class类型消息数据
netMsgPreprocessing[8010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil and tblData.reinNum ~= nil then
        CS.CSScene.MainPlayerInfo.ReinExp = tblData.reinNum
        --CS.CSUIRedPointManager:GetInstance():CallRedPoint(CS.RedPointKey.PLAYER_TurnGrow)
    end
end
--endregion

--region ID:8011 ResTotalFightValueChangeMessage 发送总战斗力
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResTotalFightValueChange lua table类型消息数据
---@param csData roleV2.ResTotalFightValueChange C# class类型消息数据
netMsgPreprocessing[8011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.FightPower = tblData.totalFightValue
    end
end
--endregion

--region ID:8027 ResSendInnerPowerInfoMessage 发送内功信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResSendInnerPowerInfo lua table类型消息数据
---@param csData roleV2.ResSendInnerPowerInfo C# class类型消息数据
netMsgPreprocessing[8027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        CS.CSScene.MainPlayerInfo.InnerExp = csData.powerBeans.innerExp;
        CS.CSScene.MainPlayerInfo.InnerLevle = csData.powerBeans.innerCfgId;
    end
end
--endregion

--region ID:8029 ResInnerPowerInfoChangeMessage 内功信息变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResInnerPowerInfoChange lua table类型消息数据
---@param csData roleV2.ResInnerPowerInfoChange C# class类型消息数据
netMsgPreprocessing[8029] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        CS.CSScene.MainPlayerInfo.InnerExp = csData.changeBean.innerExp;
        CS.CSScene.MainPlayerInfo.InnerLevle = csData.changeBean.innerCfgId;
    end
end
--endregion

--region ID:8036 ResOtherRoleInfoMessage 查看其他玩家信息响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.RoleToOtherInfo lua table类型消息数据
---@param csData roleV2.RoleToOtherInfo C# class类型消息数据
netMsgPreprocessing[8036] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        gameMgr:GetOtherPlayerDataMgr():ResOtherRoleInfoMessage(tblData)
        if (tblData.shield == 0) then
            gameMgr:GetOtherPlayerDataMgr():GetShieldAndHatManager():RemoveEquipList(LuaEnumEquipSubType.Equip_Shield)
        else
            gameMgr:GetOtherPlayerDataMgr():GetShieldAndHatManager():AddEquipList(tblData.shield)
        end

        if (tblData.bambooHat == 0) then
            gameMgr:GetOtherPlayerDataMgr():GetShieldAndHatManager():RemoveEquipList(LuaEnumEquipSubType.Equip_Hat)
        else
            gameMgr:GetOtherPlayerDataMgr():GetShieldAndHatManager():AddEquipList(tblData.bambooHat)
        end

        CS.CSScene.MainPlayerInfo.OtherPlayerInfo:RefreshOtherRoleMsg(csData)
    end
end
--endregion

--region ID:8044 ResRoleReinSuccess 转生成功
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRoleReinSuccess lua table类型消息数据
---@param csData roleV2.ResRoleReinSuccess C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8044] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8045 SystemOpenReminderMessage 系统开启提醒
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.SystemOpenReminder lua table类型消息数据
---@param csData roleV2.SystemOpenReminder C# class类型消息数据
netMsgPreprocessing[8045] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.OpenSystemTipInfo = csData
    end
end
--endregion

--region ID:8046 ResOpenKeySettingPanelMessage 打开快捷栏
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[8046] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8047 ResBubbleOnlineExpMessage 在线增加泡点经验消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResBubbleOnlineExp lua table类型消息数据
---@param csData roleV2.ResBubbleOnlineExp C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8047] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    uiStaticParameter.ExpNeedDelay = true
end
--endregion

--region ID:8048 ResOverBubblePointMessage 泡点结束消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[8048] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8049 ResBubbleOfflineExpMessage 返回泡点离线经验消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.BubbleOfflineExp lua table类型消息数据
---@param csData roleV2.BubbleOfflineExp C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8049] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8051 ResReceiveBubbleOfflineExpMessage 返回领取离线泡点经验
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.BubbleOfflineExp lua table类型消息数据
---@param csData roleV2.BubbleOfflineExp C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8051] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8054 ResRefreshInfoMessage 玩家零点刷新信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRefreshInfo lua table类型消息数据
---@param csData roleV2.ResRefreshInfo C# class类型消息数据
netMsgPreprocessing[8054] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.ActiveInfo:UpdateActiveInfo(csData);
end
--endregion

--region ID:8056 ResGetMinerInfoMessage 返回查看矿工信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResGetMinerInfo lua table类型消息数据
---@param csData roleV2.ResGetMinerInfo C# class类型消息数据
netMsgPreprocessing[8056] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.HireMinersInfo:ReqGetMinerInfoMessage(csData)
end
--endregion

--region ID:8057 ResUpdateMineInfoMessage 刷新矿石信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResUpdateMineInfo lua table类型消息数据
---@param csData roleV2.ResUpdateMineInfo C# class类型消息数据
netMsgPreprocessing[8057] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    CS.CSScene.MainPlayerInfo.HireMinersInfo:ResUpdateMineInfo(csData)
end
--endregion

--region ID:8060 ResPlayerSpyInfoMessage 返回变或取消间谍消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResPlayerSpyInfo lua table类型消息数据
---@param csData roleV2.ResPlayerSpyInfo C# class类型消息数据
netMsgPreprocessing[8060] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8065 ResRoleFirstRechargeChangeMessage 是否首冲改变
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRoleFirstRechargeChange lua table类型消息数据
---@param csData roleV2.ResRoleFirstRechargeChange C# class类型消息数据
netMsgPreprocessing[8065] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        mainPlayerInfo.Data.firstRecharge = csData.firstRecharge
        if (csData.firstRecharge ~= 0) then
            local UIRechargeFirstSloganTipsPanel = uimanager:GetPanel("UIRechargeFirstSloganTipsPanel")
            if UIRechargeFirstSloganTipsPanel ~= nil then
                UIRechargeFirstSloganTipsPanel:HidePanel()
            end
        end
    end
end
--endregion

--region ID:8067 ResCheckPreTaskIsCompleteMessage 返回前置任务是否完成
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResCheckPreTaskIsComplete lua table类型消息数据
---@param csData roleV2.ResCheckPreTaskIsComplete C# class类型消息数据
netMsgPreprocessing[8067] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8068 ResEditNameMessage 改名返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResEditName lua table类型消息数据
---@param csData roleV2.ResEditName C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8068] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8070 ResMainTaskPushMessage 返回小秘书主线推送是否已经发过
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResMainTaskPush lua table类型消息数据
---@param csData roleV2.ResMainTaskPush C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8070] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8073 ResRefineMasterPanelMessage 返回炼制大师面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRefineMasterPanel lua table类型消息数据
---@param csData roleV2.ResRefineMasterPanel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8073] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8075 ResRefineResultMessage 返回炼制结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRefineResult lua table类型消息数据
---@param csData roleV2.ResRefineResult C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8075] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8076 ResUpdateAuctionDiamondMessage 更新钻石额度
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.UpdateAuctionDiamond lua table类型消息数据
---@param csData roleV2.UpdateAuctionDiamond C# class类型消息数据
netMsgPreprocessing[8076] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        ---@type CSMainPlayerInfo
        local mainPlayerInfo = CS.CSScene.MainPlayerInfo
        if mainPlayerInfo then
            mainPlayerInfo.Data.auctionDiamond = csData.auctionDiamond
        end
    end
end
--endregion

--region ID:8079 ResPlayerDieDropEquipByWearMessage 身上的装备掉落变动
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResPlayerDieDropEquipByWear lua table类型消息数据
---@param csData roleV2.ResPlayerDieDropEquipByWear C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8079] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---@type CSMainPlayerInfo
    local csmainplayerinfo = CS.CSScene.MainPlayerInfo
    if tblData.dropType == 1 then
        ---玩家装备
        if csmainplayerinfo ~= nil then
            local equipInfo = csmainplayerinfo.EquipInfo
            equipInfo:DropEquip(tblData.itemLid)
        end
    elseif tblData.dropType == 4 or tblData.dropType == 5 then
        ---肉身装备或生肖装备
        if csmainplayerinfo ~= nil then
            --local servantInfo = csmainplayerinfo.ServantInfoV2
            --servantInfo:ServantEquipChange(tblData.itemLid)
            gameMgr:GetPlayerDataMgr():GetLuaServantInfo():GetServantEquip():OnResPlayerDieDropEquipByWearMessageReceived(tblData.itemLid)
        end
    end
end
--endregion

--region ID:8081 ResPaperCraneDeliveryMessage 千纸鹤传送返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResPaperCraneDelivery lua table类型消息数据
---@param csData roleV2.ResPaperCraneDelivery C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8081] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8082 ResFirstChargePushMessage 首充推送
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[8082] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    uimanager:CreatePanel("UIRechargeFirstSloganTipsPanel", nil, 2)
end
--endregion

--region ID:8083 ResNewFirstChargePushMessage 首充推送-新服优势
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResNewFirstChargePush lua table类型消息数据
---@param csData roleV2.ResNewFirstChargePush C# class类型消息数据
netMsgPreprocessing[8083] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    uimanager:CreatePanel("UIRechargeFirstSloganTipsPanel", nil, 1, csData.endTime)
end
--endregion

--region ID:8084 ResNeedPromptMessage 系统开起感叹号提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResNeedPrompt lua table类型消息数据
---@param csData roleV2.ResNeedPrompt C# class类型消息数据
netMsgPreprocessing[8084] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil and tblData.needPromptList ~= nil and CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.ActivityListInfo:RefreshRedHintList(tblData.needPromptList)
    end
end
--endregion

--region ID:8086 ResGameBasicShareInfoMessage 返回玩家在游戏服的联服的基本数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.GameBasicShareInfo lua table类型消息数据
---@param csData roleV2.GameBasicShareInfo C# class类型消息数据
netMsgPreprocessing[8086] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --CS.CSCalendarInfoV2.Instance.CrossServerInfo = csData
    if gameMgr ~= nil and gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetShareMapInfo() then
        gameMgr:GetPlayerDataMgr():GetShareMapInfo():RefreshLuaShareMapData(tblData)
    end
    if tblData ~= nil and tblData.shareOpenTime ~= nil and type(tblData.shareOpenTime) == 'number' then
        luaclass.KuaFuStartHint:StartLianFuCountDown(tblData.shareOpenTime)
    end
    if tblData.voteUnionType ~= nil and gameMgr:GetPlayerDataMgr():GetLeagueInfo() then
        gameMgr:GetPlayerDataMgr():GetLeagueInfo():SetTodayLeagueVoteType(tblData.voteUnionType)
    end
end
--endregion

--region ID:8087 ResRoleRefreshWanLiMessage 腕力刷新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRoleRefreshWanLi lua table类型消息数据
---@param csData roleV2.ResRoleRefreshWanLi C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8087] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.ID == tblData.rid then
        CS.CSScene.MainPlayerInfo.WanLi = tblData.wanLi
    end
end
--endregion

--region ID:8088 RoleAddFakeBuffMessage 给客户端发送假buff消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.RoleAddFakeBuff lua table类型消息数据
---@param csData roleV2.RoleAddFakeBuff C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8088] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and tblData.buffers and CS.CSScene.MainPlayerInfo then
        if tblData.addOrRemove == 0 then
            local csBuffInfo = CS.fightV2.BufferInfo()
            csBuffInfo.bufferConfigId = tblData.buffers.bufferConfigId
            csBuffInfo.bufferValue = tblData.buffers.bufferValue
            csBuffInfo.bufferValue2 = tblData.buffers.bufferValue2
            CS.CSScene.MainPlayerInfo.BuffInfo:AddClientBuff(csBuffInfo)
        else
            CS.CSScene.MainPlayerInfo.BuffInfo:RemoveClientBuff(tblData.buffers.bufferConfigId)
        end
    end
end
--endregion

--region ID:8089 ResRoleTameMessage 给客户端发送驯服次数信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRoleTame lua table类型消息数据
---@param csData roleV2.ResRoleTame C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8089] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetGatherInfo():SaveTrainingHorseTime(tblData)
end
--endregion

--region ID:8090 ResRefineMasterRedDotMessage 炼制大师红点信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRefineMasterRedDot lua table类型消息数据
---@param csData roleV2.ResRefineMasterRedDot C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8090] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaLianZhiMgr():RefreShData(tblData)
end
--endregion

--region ID:8091 ResTitleTianfuMessage 给客户端发送封号天赋数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResTitleTianfu lua table类型消息数据
---@param csData roleV2.ResTitleTianfu C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8091] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetMilitaryRankTitleFlairInfo():RefreshData(tblData)
end
--endregion

--region ID:8095 ResKongFuHouseTimeLimitMessage 练功房时间限制
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResKongFuHouseTimeLimit lua table类型消息数据
---@param csData roleV2.ResKongFuHouseTimeLimit C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8095] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8097 ResPotentialInfoMessage 返回潜能信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.RespotentialInfo lua table类型消息数据
---@param csData roleV2.RespotentialInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8097] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8101 ResRedPointPotentialMessage 返回潜能红点信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResPotentialRedPoint lua table类型消息数据
---@param csData roleV2.ResPotentialRedPoint C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8101] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if uiStaticParameter.PotentialRedPointInfo == nil then
        uiStaticParameter.PotentialRedPointInfo = {
            [0] = false,
            [1] = false,
            [2] = false,
            [3] = false
        }
    end
    uiStaticParameter.PotentialRedPointInfo[tblData.type] = tblData.state == 1
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.Potential))
end
--endregion

--region ID:8103 ResCollectionSettingMessage 返回回收配置
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.CollectionSetting lua table类型消息数据
---@param csData roleV2.CollectionSetting C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8103] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil and gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    gameMgr:GetPlayerDataMgr():GetConfigManager():GetBagRecycleData():ResCollectionSetting(tblData)
end
--endregion

--region ID:8107 ResRoleModelInfoMessage 返回玩家模型数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.RoleModelInfo lua table类型消息数据
---@param csData roleV2.RoleModelInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8107] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8109 ResMysteriousExchangeMessage 神秘老人兑换详情
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResMysteriousExchange lua table类型消息数据
---@param csData roleV2.ResMysteriousExchange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8109] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaMysteriousExchangeOldManInfo():SetLuaMysteriousExchangeOldManInfo(tblData)
end
--endregion

--region ID:8110 ResBossKillDataMessage 终极boss击杀数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.BossKillData lua table类型消息数据
---@param csData roleV2.BossKillData C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8110] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetBossDataManager():SaveFinalBossData(tblData)
end
--endregion

--region ID:8112 ResRoleSystemPreviewMessage 玩家系统预告开启信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRoleSystemPreview lua table类型消息数据
---@param csData roleV2.ResRoleSystemPreview C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8112] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() then
        gameMgr:GetPlayerDataMgr():GetSystemPreviewMgr():RefreshSystemPerviewTbl(tblData)
    end
end
--endregion

--region ID:8115 ResRoleExpAccumulateMessage 返回当前累计的经验值
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRoleExpAccumulate lua table类型消息数据
---@param csData roleV2.ResRoleExpAccumulate C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8115] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:8116 ResRoleInviteCodeMessage 返回创角邀请码
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResRoleInviteCode lua table类型消息数据
---@param csData roleV2.ResRoleInviteCode C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8116] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    uiStaticParameter.invitationCode = tblData.inviteCode
end
--endregion

--region ID:8118 ResTransferSexMessage 转性
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResTransferSex lua table类型消息数据
---@param csData roleV2.ResTransferSex C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8118] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    local data = {}
    data.ID = 166
    data.CallBack = function()
        networkRequest.ReqCommon(3)
        clientMessageDeal.OnReturnLogin(true)
        uimanager:CloseAllPanel()
        if uiStaticParameter.voiceMgr ~= nil then
            uiStaticParameter.voiceMgr:LogOutGame()
        end
        uiStaticParameter.InCarAcitivity = false
        uiStaticParameter.firstEnterScene = true

    end
    data.CancelCallBack = function()
        uimanager:ClosePanel('UIPromptPanel')
    end
    uimanager:CreatePanel("UIPromptPanel", nil, data)
end
--endregion

--region ID:8120 ResTransferCareerMessage 转职
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResTransferCareer lua table类型消息数据
---@param csData roleV2.ResTransferCareer C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8120] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    local data = {}
    data.ID = 168
    data.CallBack = function()
        networkRequest.ReqCommon(3)
        clientMessageDeal.OnReturnLogin(true)
        uimanager:CloseAllPanel()
        if uiStaticParameter.voiceMgr ~= nil then
            uiStaticParameter.voiceMgr:LogOutGame()
        end
        uiStaticParameter.InCarAcitivity = false
        uiStaticParameter.firstEnterScene = true
    end
    data.CancelCallBack = function()
        uimanager:ClosePanel('UIPromptPanel')
    end
    uimanager:CreatePanel("UIPromptPanel", nil, data)
end
--endregion

--region ID:8121 ResCanInsuredEquipMessage 返回身上可投保列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResCanInsuredEquip lua table类型消息数据
---@param csData roleV2.ResCanInsuredEquip C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8121] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    luaEventManager.DoCallback(LuaCEvent.ResCanInsuredEquip, tblData)
end
--endregion

--region ID:8123 ResInsuredSuccesMessage 投保返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResInsuredSucces lua table类型消息数据
---@param csData roleV2.ResInsuredSucces C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[8123] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---更新背包/人物数据
    if (tblData.theEquip ~= nil) then
        local csBagItem = protobufMgr.DecodeTable.bag.BagItemInfo(tblData.theEquip)
        if (tblData.index == 0) then
            if CS.CSScene.MainPlayerInfo then
                CS.CSScene.MainPlayerInfo.BagInfo:UpdateSingleBagItemInfo(csBagItem)
            end
            gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():RespondInsure(tblData)
        else
            if CS.CSScene.MainPlayerInfo then
                CS.CSScene.MainPlayerInfo.EquipInfo:TryUpdateEquip(csBagItem)
            end
            gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():RefreshInsureData(tblData);
        end
    end
    ---
    gameMgr:GetPlayerDataMgr():GetMainPlayerInsureMgr():RefreshEquipData(tblData)
    luaEventManager.DoCallback(LuaCEvent.ResInsuredSucces, tblData)
end
--endregion

--[[
--region ID:8002 ResPlayerBasicInfoMessage 玩家基本数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData roleV2.ResPlayerBasicInfo lua table类型消息数据
---@param csData roleV2.ResPlayerBasicInfo C# class类型消息数据
netMsgPreprocessing[8002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLuaMemberInfo():SetPlayerMemberInfo(tblData.vipMember)
end
--endregion
--]]
