--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--map.xml

--region ID:67009 ResPlayerEnterMapMessage 玩家进入地图
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResPlayerEnterMap lua table类型消息数据
---@param csData mapV2.ResPlayerEnterMap C# class类型消息数据
netMsgPreprocessing[67009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---每次收到玩家进入地图的消息后都向服务器请求一次小地图信息
    uiStaticParameter.isNeedSendMinReq = 1
    ---主角跨服信息处理
    if tblData ~= nil and CS.CSScene.MainPlayerInfo ~= nil and tblData.lid == CS.CSScene.MainPlayerInfo.ID then
        CS.CSScene.MainPlayerInfo.RemoteHostInfo.RemoteHostId = tblData.remoteHostId
    end

    ---玩家进入地图后请求boss数据
    networkRequest.ReqFieldBossOpen(LuaEnumBossType.FinalBoss);
    networkRequest.ReqFieldBossOpen(LuaEnumBossType.WorldBoss);
    networkRequest.ReqFieldBossOpen(LuaEnumBossType.EliteBoss);
    networkRequest.ReqFieldBossOpen(LuaEnumBossType.DemonBoss);
    networkRequest.ReqFieldBossOpen(LuaEnumBossType.PersonalBoss);
    ---玩家进入地图后请求历法小礼包数据
    networkRequest.ReqAllCalendarGiftState();
    ---玩家进入地图后请求魂装数据
    networkRequest.ReqGetAllSoulInfo()
    ---请求今日已关闭的活动数据
    networkRequest.ReqTodayClosedActivities();
end
--endregion

--region ID:67010 ResPlayerChangeMapMessage 玩家切换地图
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResPlayerChangeMap lua table类型消息数据
---@param csData mapV2.ResPlayerChangeMap C# class类型消息数据
netMsgPreprocessing[67010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.Line = csData.line
        CS.CSScene.MainPlayerInfo.MapInfoV2:ResPlayerChangeMap(csData)
    end
    local res, mapInfo = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(csData.mid)
    if (res) then
        if (mapInfo.announceDeliver ~= 1072) then
            if (uimanager:GetPanel("UICrawlTowerResultPanel")) then
                uimanager:ClosePanel("UICrawlTowerResultPanel")
            end
            uimanager:ClosePanel("UICrawlTowerLeftMainPanel")
        end
    end
    luaEventManager.DoCallback(LuaCEvent.Map_ResPlayerChangeMap, tblData)
    if tblData ~= nil and tblData.reason == 28 or tblData.reason == 32 then
        local deliverID = CS.CSTouchEvent.touchInfo.deliverID
        CS.CSTouchEvent.touchInfo = CS.CSTouchEvent.TouchInfo(CS.TouchType.TouchTransfer, nil, deliverID, tblData.reasonParam);
    end
    luaEventManager.DoCallback(LuaCEvent.FastUseItem_UpdateRandomStoneEffect);
    ---@type boolean 是否打开自动战斗
    local isOpenAutoFight = false
    ---@type boolean 是否改变自动战斗状态
    local isChangeAutoFightState = false
    ---判断传送原因
    if tblData ~= nil then
        if tblData.reason == luaEnumTransReason.TASK_EMOGUANGCHANGRANDOM then
            if CS.CSScene.MainPlayerInfo ~= nil then
                CS.CSScene.MainPlayerInfo.AsyncOperationController:Stop();
                CS.CSMissionManager.Instance:ClearCurrentTask();
            end
            uimanager:ClosePanel('UIMonsterArrestPanel')
            isOpenAutoFight = tblData.reasonParam == 1
            isChangeAutoFightState = true
        elseif tblData.reason == luaEnumTransReason.Elit_Task then
            isOpenAutoFight = true
            isChangeAutoFightState = true
        elseif tblData.reason == luaEnumTransReason.DeliverConfig then
            Utility.ChangeMapOrPosOpereation({ deliverId = tblData.reasonParam, x = tblData.x, y = tblData.y })
        elseif tblData.reason == luaEnumTransReason.Task then
            Utility.DoMainTask()
        elseif tblData.reason == luaEnumTransReason.ShareStall_CangYue then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.ShareSell_Stall)
        end
    end
    if (uiStaticParameter.IsExitRequireOpenAutoFight()) then
        isOpenAutoFight = true
        isChangeAutoFightState = true
    end

    ---判断是否有代码方面的配置传送后开启自动战斗
    if uiStaticParameter.GetIsNeedOpenAutoFightAfterDeliver() then
        isChangeAutoFightState = true
        isOpenAutoFight = true
    end

    ---进入地图自动战斗配置进入后开启自动战斗
    if mapInfo ~= nil and mapInfo.automatic ~= 0 then
        isChangeAutoFightState = true
        isOpenAutoFight = true
    end
    ---设置自动战斗
    if isChangeAutoFightState then
        local transfer = CS.CSListUpdateMgr.Add(1000, nil, function()
            if CS.CSAutoFightMgr.Instance ~= nil then
                CS.CSAutoFightMgr.Instance:Toggle(isOpenAutoFight);
            end
        end)
    end

    --假如正在加载地图,又收到了新地图切换请求,那么先保存请求,在地图加载完成后,进行检查
    if (CS.CSSceneManager.Instance.IsChangeMap) then
        local bytes = protobufMgr.Serialize("mapV2.ResPlayerChangeMap", tblData)
        CS.CSMapManager.Instance.SaveMapResponse = bytes;
        return ;
    end
    CS.CSMapManager.Instance.resPlayerChangeMap = csData;
    CS.CSNetwork.SendClientEvent(CS.CEvent.V2_StartLoadMap, tblData.mid, CS.SFMiscBase.Dot2(tblData.x, tblData.y));
    CS.CSMapManager.Instance:Load(tblData.mid);
    local ismap, practice_room = clientTableManager.cfg_practice_roomManager:IsPracticeMap(tblData.mid)
    if ismap then
        uimanager:CreatePanel("UIPracticeRoomCountDownPanel", nil, practice_room)
    else
        uimanager:ClosePanel("UIPracticeRoomCountDownPanel")
    end

    if (uiStaticParameter.CallbackResTreeMonsterRefreshTrans ~= nil) then
        uiStaticParameter.CallbackResTreeMonsterRefreshTrans()
        uiStaticParameter.CallbackResTreeMonsterRefreshTrans = nil
    end

    ---检查当前地图是否在行会秘境地图,如果已在行会秘境中,则弹出气泡“已在当前地图”并返回
    ---@type TABLE.CFG_DUPLICATE
    local duplicateExist, currentDuplicateTbl = CS.Cfg_DuplicateTableManager.Instance:TryGetValue(csData.mid)
    if currentDuplicateTbl ~= nil and currentDuplicateTbl.type == 45 then
        uimanager:ClosePanel("UIGuildPanel")
    end

end
--endregion

--region ID:67011 ResChangePosMessage 切换位置
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResChangePos lua table类型消息数据
---@param csData mapV2.ResChangePos C# class类型消息数据
netMsgPreprocessing[67011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil and tblData.reason == 28 or tblData.reason == 32 then
        local deliverID = CS.CSTouchEvent.touchInfo.deliverID
        CS.CSTouchEvent.touchInfo = CS.CSTouchEvent.TouchInfo(CS.TouchType.TouchTransfer, nil, deliverID, tblData.reasonParam);
        ---每次地图内因为配置传送或者小地图传送时都向服务器请求一次小地图信息
        uiStaticParameter.isNeedSendMinReq = 1
    end
    ---@type boolean 是否打开自动战斗
    local isOpenAutoFight = false
    ---@type boolean 是否改变自动战斗状态
    local isChangeAutoFightState = false
    ---判断传送原因
    if tblData ~= nil then
        if tblData.reason == luaEnumTransReason.TASK_EMOGUANGCHANGRANDOM then
            uimanager:ClosePanel('UIMonsterArrestPanel')
            isOpenAutoFight = tblData.reasonParam == 1
            isChangeAutoFightState = true
        elseif tblData.reason == luaEnumTransReason.Elit_Task then
            isOpenAutoFight = true
            isChangeAutoFightState = true
        elseif tblData.reason == luaEnumTransReason.Task then
            if tblData.lid == CS.CSScene.MainPlayerInfo.ID then
                Utility.DoMainTask()
            end
        elseif tblData.reason == luaEnumTransReason.DeliverConfig then
            Utility.ChangeMapOrPosOpereation({ deliverId = tblData.reasonParam, x = tblData.x, y = tblData.y })
        end
    end
    ---判断是否有代码方面的配置传送后开启自动战斗
    if uiStaticParameter.GetIsNeedOpenAutoFightAfterDeliver() then
        isChangeAutoFightState = true
        isOpenAutoFight = true
    end
    ---设置自动战斗
    if isChangeAutoFightState then
        local transfer = CS.CSListUpdateMgr.Add(500, nil, function()
            if CS.CSAutoFightMgr.Instance ~= nil then
                CS.CSAutoFightMgr.Instance:Toggle(isOpenAutoFight);
            end
        end)
    end
    --当前是否正在切换地图,如果正在切换,那么先等这次切换完成后,再进行下次坐标拉回
    if (CS.CSSceneManager.Instance.IsChangeMap) then
        local bytes = protobufMgr.Serialize("mapV2.ResChangePos", tblData)
        CS.CSMapManager.Instance.SaveChangePosResponse = bytes;
        return ;
    end
    --如果是主角-那么需要设置IsSwitchPos  并且发送消息去执行一些刷新地图的操作
    local avater = CS.CSScene.Sington:getAvatar(tblData.lid);
    if (CS.CSScene.MainPlayerInfo ~= nil and tblData.lid == CS.CSScene.MainPlayerInfo.ID) then
        CS.CSMapManager.IsSwitchPos = true;
        CS.CSNetwork.SendClientEvent(CS.CEvent.V2_ResetPlayerPosition, csData);
        CS.CSNetwork.SendClientEvent(CS.CEvent.Scene_PlayerPositionReseted, csData);
        avater:ResetCheckkCellOverlap();

        if (uiStaticParameter.CallbackResTreeMonsterRefreshTrans ~= nil) then
            uiStaticParameter.CallbackResTreeMonsterRefreshTrans()
            uiStaticParameter.CallbackResTreeMonsterRefreshTrans = nil
        end

        if tblData.reason == luaEnumTransReason.ShareStall_CangYue then
            uiTransferManager:TransferToPanel(LuaEnumTransferType.ShareSell_Stall)
        end

    else
        --除开主角之外的其他单位,没有什么好操作的,直接设置坐标就好
        if (avater == nil) then
            return
        end
        avater:SetPos(CS.SFMiscBase.Dot2(tblData.x, tblData.y), 0);
        if (avater.AvatarType == CS.EAvatarType.Servant or avater.AvatarType == CS.EAvatarType.Pet) then
            avater.ModelLoad:LoadTransferEffect();
        end
    end

end
--endregion

--region ID:67014 ResReliveMessage 对象复活
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResRelive lua table类型消息数据
---@param csData mapV2.ResRelive C# class类型消息数据
netMsgPreprocessing[67014] = function(msgID, tblData, csData)
    if isOpenLog then
        CS.UnityEngine.Debug.LogWarning("玩家复活消息,关闭死亡面板")
    end
    if (csData == nil or csData.Length == 0) then
        uimanager:ClosePanel("UIDeadGrayPanel")
        uimanager:ClosePanel("UIDeadPanel")
        return
    end

    if (csData.lid == CS.CSScene.MainPlayerInfo.ID) then
        uimanager:ClosePanel("UIDeadGrayPanel")
        uimanager:ClosePanel("UIDeadPanel")
        if (tblData.reliveType == LuaEnumReliveType.BackCityRelive or tblData.reliveType == LuaEnumReliveType.Null) and uiStaticParameter.isFirstStrongPrompt then
            uiStaticParameter.isFirstStrongPrompt = false
            if CS.CSScene.MainPlayerInfo.Level <= LuaGlobalTableDeal.GetReliveShowBianQiangHintMaxLevel() then
                local attackRank = Utility.RemoveEndZero(tonumber(string.format("%.2f", tblData.powerRankPercent * 0.01))) .. "%"
                Utility.ShowSecondConfirmPanel({ PromptWordId = 118, placeHolderData = attackRank, ComfireAucion = function()
                    uimanager:CreatePanel("UISystemOpenMainPanel", nil, { targetPageType = LuaEnumSystemPageType.Stronge })
                end })
            end
        end
    end

    local avaterInfo = CS.CSScene.GetAvatarInfo(csData.lid);
    if avaterInfo == nil then
        uimanager:ClosePanel("UIDeadGrayPanel")
        uimanager:ClosePanel("UIDeadPanel")
        return
    end
    avaterInfo.HP = csData.hp;
    avaterInfo.RealHP = csData.hp;
    avaterInfo.MaxHP = csData.hp;

    avaterInfo.MP = csData.mp;
    avaterInfo.MaxMP = csData.mp;

    if avaterInfo.mOwner == nil then
        return
    end
    local head = avaterInfo.mOwner.Head
    if head then
        head:Init(avaterInfo.mOwner)
    end

    if CS.CSScene.MainPlayerInfo ~= nil and csData.lid == CS.CSScene.MainPlayerInfo.ID then
        if CS.CSAutoFightMgr.Instance.AutoReleaseSkill ~= nil then
            CS.CSScene.MainPlayerInfo.MainPlayerIsResurgence = true
        end
    end

end
--endregion

--region ID:67018 ResTryEnterMapMessage 玩家尝试进入地图
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResTryEnterMap lua table类型消息数据
---@param csData mapV2.ResTryEnterMap C# class类型消息数据
netMsgPreprocessing[67018] = function(msgID, tblData, csData)
    if (CS.CSScene.IsLanuchMainPlayer) then
        if (CS.CSMapManager.Instance.mapInfoTbl ~= nil and tblData.mid == CS.CSMapManager.Instance.mapInfoTbl.id) then
            CS.CSInterfaceSingleton.NetReq:ReqLoginMapMessage();
            ---这里是断线重连的时候  请求登入地图,和正常登入地图存在一定的差异
            -----延迟1000ms
            --CS.CSListUpdateMgr.Add(1000, nil, function()
            --    networkRequest.ReqMapCommon(9)
            --end, false)
            networkRequest.ReqMapCommon(9)
        else
            CS.CSMapManager.Instance:Load(tblData.mid);
        end
    else
        CS.CSMapManager.Instance:EnterMap(tblData.mid)
    end
end
--endregion

--region ID:67021 ResPerformTotalHpMessage 同步boss和玩家总血量信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData duplicateV2.ResPerformTotalHp lua table类型消息数据
---@param csData duplicateV2.ResPerformTotalHp C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67021] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67024 ResPlayerUnionChangeMessage 玩家行会变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResPlayerUnionChange lua table类型消息数据
---@param csData mapV2.ResPlayerUnionChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67030 ResSwitchFightModelMessage 返回选择攻击模式
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResSwitchFightModel lua table类型消息数据
---@param csData mapV2.ResSwitchFightModel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67030] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and CS.CSScene.Sington ~= nil then
        local avater = CS.CSScene.Sington:getAvatar(tblData.changedManId)
        if avater ~= nil then
            avater.BaseInfo.PKMode = tblData.fightModel
            if (CS.CSScene.Sington ~= nil) then
                if (avater.ID == CS.CSScene.MainPlayerInfo.ID) then
                    --CS.CSScene.Sington.mClient:SendEvent(CS.CEvent.Role_UpdatePKMode);
                    CS.CSScene.MainPlayerInfo.ConfigInfo:SetInt(CS.EConfigOption.PkMode, tblData.fightModel)
                end
            end
        end
    end
end
--endregion

--region ID:67043 ResGatherMessage 返回采集数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResGatherState lua table类型消息数据
---@param csData mapV2.ResGatherState C# class类型消息数据
netMsgPreprocessing[67043] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67051 ResMonsterOwnerChangedMessage 怪物归属改变
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.RoundMonsterInfo lua table类型消息数据
---@param csData mapV2.RoundMonsterInfo C# class类型消息数据
netMsgPreprocessing[67051] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.Sington ~= nil then
        local avater = CS.CSScene.Sington:getAvatar(csData.lid)
        if avater ~= nil and avater.AvatarType == CS.EAvatarType.Monster then
            avater.OwnerId = csData.ownerId
            avater.Info.OwnerName = csData.ownerName
            avater.Info.Data.ownerTeamId = tblData.ownerTeamId;
        end
    end
end
--endregion

--region ID:67054 ResAnimalNPCInfoMessage 返回生肖npc信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResAnimalNPCInfo lua table类型消息数据
---@param csData mapV2.ResAnimalNPCInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67054] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67056 ResSkyAngerGodInfoMessage 返回天怒神像信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResSkyAngerGodInfo lua table类型消息数据
---@param csData mapV2.ResSkyAngerGodInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67056] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67057 ResEnterNumRefreshMessage 发送进入人数改变信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.EnterNumRefresh lua table类型消息数据
---@param csData mapV2.EnterNumRefresh C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67057] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67059 ResPlayerModChangeMessage 玩家信息改变
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.RoundPlayerInfo lua table类型消息数据
---@param csData mapV2.RoundPlayerInfo C# class类型消息数据
netMsgPreprocessing[67059] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if CS.CSScene.Sington == nil then
            return
        end
        local avater = CS.CSScene.Sington:getAvatar(csData.rid)
        if avater and avater.Info then

            if csData.servant then
                avater.Info:OperaCombitServantList(csData.servant)
            end

            avater.Info.TitleInfoV2.TitleId = csData.titleId
        end
    end
end
--endregion

--region ID:67060 ResServantCombineEffectMessage 发送合体特效给周围玩家
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResServantInfo lua table类型消息数据
---@param csData mapV2.ResServantInfo C# class类型消息数据
netMsgPreprocessing[67060] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --加载合体特效
    if (CS.CSSceneExt.Sington ~= nil) then
        CS.CSSceneExt.Sington:LoadComBineEffect(csData)
    end
end
--endregion

--region ID:67061 ResTheTokenNotEnoughMessage 门票不足弹出快捷购买面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResTheTokenNotEnough lua table类型消息数据
---@param csData mapV2.ResTheTokenNotEnough C# class类型消息数据
netMsgPreprocessing[67061] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67063 ResBoothEnterViewMessage 摊位进入视野
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResBoothEnterView lua table类型消息数据
---@param csData mapV2.ResBoothEnterView C# class类型消息数据
netMsgPreprocessing[67063] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67064 ResStartMiningMessage 返回挖矿衰减开始信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResStartMining lua table类型消息数据
---@param csData mapV2.ResStartMining C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67064] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67065 ResChangeSpiritMessage 返回体力改变的消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResChangeSpirit lua table类型消息数据
---@param csData mapV2.ResChangeSpirit C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67065] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67069 ResUpdateUnionCartInfoMessage 行会镖车更新信息包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResUpdateUnionCartInfo lua table类型消息数据
---@param csData mapV2.ResUpdateUnionCartInfo C# class类型消息数据
netMsgPreprocessing[67069] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67071 ResDropProtectMessage 返回玩家的仲裁信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.reqDropProtect lua table类型消息数据
---@param csData mapV2.reqDropProtect C# class类型消息数据
netMsgPreprocessing[67071] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DropInfo:UpdateDropData(csData)
end
--endregion

--region ID:67076 ResDropProtectNoticeMessage 返回玩家的仲裁小红点信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.dropProtectNotice lua table类型消息数据
---@param csData mapV2.dropProtectNotice C# class类型消息数据
netMsgPreprocessing[67076] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.DropInfo:UpdateRedPointData(csData)
end
--endregion

--region ID:67081 MinerActivityTypeMessage 发送矿工状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.MinerActivityType lua table类型消息数据
---@param csData mapV2.MinerActivityType C# class类型消息数据
netMsgPreprocessing[67081] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local MinerTipInfo = CS.CSScene.MainPlayerInfo.HireMinersInfo:OnResMinerActivityType(csData)
    if MinerTipInfo == nil then
        return
    end
    local temp = {}
    local KickInfo = {}
    KickInfo.Title = MinerTipInfo.TabPromptWord.title
    KickInfo.CenterDescription = MinerTipInfo.TabPromptWord.leftButton
    KickInfo.Content = MinerTipInfo.Des
    KickInfo.TabFlashingID = MinerTipInfo.TabFlashingID
    KickInfo.ID = MinerTipInfo.TabPromptWord.id
    temp.id = MinerTipInfo.TabFlashingID
    temp.panelPriority = KickInfo
    KickInfo.CallBack = function(panel)
        MinerTipInfo:FindPath();
        Utility.RemoveFlashPrompt(1, panel.mtabFlashingID)
    end
    temp.clickCallBack = function(panel)
        uimanager:CreatePanel("UIPromptPanel", nil, temp.panelPriority)
    end
    Utility.AddFlashPrompt(temp)
end
--endregion

--region ID:67086 ResReceiveRankingForNpcMessage 查看NPC上玩家的领取排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResReceiveRankingForNpc lua table类型消息数据
---@param csData mapV2.ResReceiveRankingForNpc C# class类型消息数据
netMsgPreprocessing[67086] = function(msgID, tblData, csData)
    --在此处填入预处理代码

end
--endregion

--region ID:67090 ResDoctorHealthMessage 发送神医满状态消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResDoctorRecover lua table类型消息数据
---@param csData mapV2.ResDoctorRecover C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67090] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        uiStaticParameter.mDoctorCD = tblData.cd
    end
end
--endregion

--region ID:67091 ResMultiItemEffectMessage 发送多数量特效
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.MultiItemEffect lua table类型消息数据
---@param csData mapV2.MultiItemEffect C# class类型消息数据
netMsgPreprocessing[67091] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67097 ResPlayerDieDropItemInfoMessage 玩家死亡掉落物品信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResPlayerDropInfo lua table类型消息数据
---@param csData mapV2.ResPlayerDropInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67097] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.Sington == nil or CS.CSScene.Sington.MainPlayer == nil then
        return
    end
    uiStaticParameter.mDeadAndDropItemParam = {}
    for i = 1, #tblData.itemList do
        local csBagItem = protobufMgr.DecodeTable.bag.BagItemInfo(tblData.itemList[i])
        table.insert(uiStaticParameter.mDeadAndDropItemParam, csBagItem)
    end
    uiStaticParameter.mDeadAndDropItemTime = CS.UnityEngine.Time.time
    ---@type UIDeadPanel
    local deadPanel = uimanager:GetPanel("UIDeadPanel")
    if deadPanel ~= nil then
        deadPanel:RefreshDropItems()
    end
end
--endregion

--region ID:67098 ResTreeMonsterRefreshMessage 千年树妖刷新消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.TreeMonsterRefreshCall lua table类型消息数据
---@param csData mapV2.TreeMonsterRefreshCall C# class类型消息数据
netMsgPreprocessing[67098] = function(msgID, tblData, csData)
    --在此处填入预处理代码

    local intervalTime = 120000;
    local isFind, promptWordTable = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(102);
    if (isFind) then
        local customData = {};
        customData.PromptWordID = 102
        customData.Content = string.gsub(promptWordTable.des, "\\n", '\n')
        customData.Time = (CS.CSServerTime.Instance.TotalMillisecond + intervalTime) / 1000;
        customData.LastTime = CS.CSServerTime.Instance.TotalMillisecond + intervalTime;
        customData.mapId = csData.mapId
        customData.CancelCallBack = function()
            Utility.RemoveFlashPrompt(1, 32)
        end
        customData.TimeEndCallBack = function()
            Utility.RemoveFlashPrompt(1, 32)
            uimanager:ClosePanel("UISummonTipsPanel")
        end
        customData.CallBack = function()
            Utility.RemoveFlashPrompt(1, 32)

            uiStaticParameter.CallbackResTreeMonsterRefreshTrans = function()
                local Info = CS.CSSceneExt.MainPlayerInfo;
                if (Info.ServantInfoV2.IsServantCanAllCombine) then
                    Info.ServantInfoV2:ConstraintServantCombine();
                    Info.ServantInfoV2.CombineWay = CS.AllCombineWay.Automatic;
                end
            end

            networkRequest.ReqDeliverTreeMonster(csData.mapId, csData.line, csData.pointX, csData.pointY, csData.startTime);
        end
        customData.CenterDescription = promptWordTable.leftButton
        customData.IsToggleVisable = false
        customData.IsShowCloseBtn = true
        customData.IsToggleVisable = false
        customData.IsShowCloseBtn = true
        local temp = {};
        temp.id = 32;
        temp.mTime = CS.CSServerTime.Instance.TotalMillisecond + intervalTime;
        temp.panelPriority = customData;
        Utility.AddFlashPrompt(temp)
    end
end
--endregion

--region ID:67100 ResDeliverTreeMonsterMessage 响应传送到千年树妖
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.DeliverTreeMonsterResult lua table类型消息数据
---@param csData mapV2.DeliverTreeMonsterResult C# class类型消息数据
netMsgPreprocessing[67100] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67101 ResServantCultivateEnterViewMessage 元灵修炼进入视野
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResServantCultivateEnterView lua table类型消息数据
---@param csData mapV2.ResServantCultivateEnterView C# class类型消息数据
netMsgPreprocessing[67101] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67103 ResDemonBossInfoMessage 通知客户端魔之boss倒计时开始
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResDemonBossInfo lua table类型消息数据
---@param csData mapV2.ResDemonBossInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67103] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil and tblData.id ~= nil and tblData.endTime ~= nil then
        local params = {}
        local monsterLid = tblData.id
        local avater = CS.CSSceneExt.Sington:GetAvater(CS.EAvatarType.Monster, monsterLid)
        local endTime = tblData.endTime
        params.avater = avater
        params.endTime = endTime
        luaclass.MagicBossDataInfo:TryOpenMagicBossPanel(params)

        local luaAvatar = gameMgr:GetMainScene():GetLuaAvatarByID(tblData.id)
        if luaAvatar ~= nil then
            luaAvatar:SetDemonBossEndTime(tblData.endTime)
        end
    end
end
--endregion

--region ID:67104 ResDemonBossHasCountMessage 魔之boss总次数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResDemonBossHasCount lua table类型消息数据
---@param csData mapV2.ResDemonBossHasCount C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67104] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.MagicBossDataInfo:RefreshPlayerTime(tblData)
end
--endregion

--region ID:67105 ResDemonBossUpdateHasCountMessage 魔之boss次数更新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResDemonBossUpdateHasCount lua table类型消息数据
---@param csData mapV2.ResDemonBossUpdateHasCount C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67105] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.MagicBossDataInfo:RefreshSingleTime(tblData)
end
--endregion

--region ID:67107 ResDemonBossHelpFailureMessage 拉令失败返回冷却结束时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResDemonBossHelpFailure lua table类型消息数据
---@param csData mapV2.ResDemonBossHelpFailure C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67107] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67108 ResDemonBossHelpToPeopleMessage 弹出拉令面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResDemonBossHelpToPeople lua table类型消息数据
---@param csData mapV2.ResDemonBossHelpToPeople C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67108] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData == nil or tblData.name == nil or tblData.mapId == nil or tblData.monsterConfigId == nil then
        return
    end
    if LuaGlobalTableDeal.ShowMagicBossFlashByConditionTable() == false then
        return false
    end
    local mapTableInfoIsFind, mapTableInfo = CS.Cfg_MapTableManager.Instance:TryGetValue(tblData.mapId)
    local monsterTableInfoIsFind, monsterTableInfo = CS.Cfg_MonsterTableManager.Instance:TryGetValue(tblData.monsterConfigId)
    if mapTableInfo == nil or monsterTableInfo == nil then
        return
    end
    local magicBossType = clientTableManager.cfg_demon_bossManager:GetMagicBossType(monsterTableInfo.id)
    local mainPlayerCanEnterMap = CS.Cfg_MapTableManager.Instance:IsMeetMapLevelCondition(mapTableInfo.id)
    if mainPlayerCanEnterMap == false then
        return
    end
    local remainTime = tblData.endTime - CS.CSScene.MainPlayerInfo.serverTime
    if remainTime <= 0 then
        return
    end
    if luaclass.MagicBossDataInfo:GetMagicBossTypeHelpNum(magicBossType) <= 0 and LuaGlobalTableDeal.GetMagicBossOpenServerDayConditionId() ~= nil and CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(LuaGlobalTableDeal.GetMagicBossOpenServerDayConditionId()) == false then
        return
    end
    local flashParam = {}
    flashParam.id = 34
    flashParam.mTime = tblData.endTime
    flashParam.clickCallBack = function()
        local param = {}
        param.PromptWordId = 129
        local promptInfoIsFind, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(param.PromptWordId)
        if promptInfoIsFind then
            param.des = string.format(string.gsub(promptInfo.des, "\\n", '\n'), tblData.name, mapTableInfo.name, LuaGlobalTableDeal.GetMonsterNameColorByType(tostring(monsterTableInfo.type)) .. monsterTableInfo.name)
        end
        param.Time = tblData.endTime - CS.CSScene.MainPlayerInfo.serverTime
        param.TimeText = luaEnumColorType.Red .. "%02.0f:%02.0f"
        param.TimeType = LuaEnumSecondComfirmTimeType.MinuteAndSecond
        param.ComfireAucion = function()
            local isInGroup = false;
            if (tblData.groupId ~= nil and tblData.groupId ~= 0) then
                if (CS.CSScene.MainPlayerInfo ~= nil) then
                    if (CS.CSScene.MainPlayerInfo.GroupInfoV2.IsHaveGroup) then
                        if (CS.CSScene.MainPlayerInfo.GroupInfoV2.GroupInfo.id == tblData.groupId) then
                            isInGroup = true;
                        end
                        if (not isInGroup) then
                            if (luaclass.RemoteHostDataClass:IsKuaFuMap()) then
                                networkRequest.ReqShareExitGroup(CS.CSScene.MainPlayerInfo.ID);
                            else
                                networkRequest.ReqExitGroup(CS.CSScene.MainPlayerInfo.ID);
                            end
                        end
                    end
                end
                if (not isInGroup) then
                    if (luaclass.RemoteHostDataClass:IsKuaFuMap()) then
                        networkRequest.ReqShareJoinGroup(tblData.groupId, 2);
                    else
                        networkRequest.ReqJoinGroup(tblData.groupId, 2);
                    end
                end
            end

            networkRequest.ReqAcceptDemonBossHelp(mapTableInfo.id, tblData.line, tblData.x, tblData.y)
            Utility.RemoveFlashPrompt(1, 34)
        end
        param.CancelCallBack = function()
            uimanager:ClosePanel("UIPromptPanel")
            Utility.RemoveFlashPrompt(1, 34)
        end
        param.TimeEndCallBack = function()
            uimanager:ClosePanel("UIPromptPanel")
            Utility.RemoveFlashPrompt(1, 34)
        end
        Utility.ShowSecondConfirmPanel(param)
    end
    Utility.TryAddFlashPromp(flashParam)
end
--endregion

--region ID:67110 DemonDieCanRewardMessage 魔之boss死亡时可领取按钮
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.DemonDieCanReward lua table类型消息数据
---@param csData mapV2.DemonDieCanReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67110] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.MagicBossDataInfo:RefreshGetAwardInfo(tblData)
    local canGetRewardState = luaclass.MagicBossDataInfo:CanGetAward(CS.CSScene.MainPlayerInfo.MapID, CS.CSScene.MainPlayerInfo.Owner.OldCell.Coord)
    if canGetRewardState == LuaEnumCanGetMagicBossAwardType.NotWithinRange then
        luaclass.MagicBossDataInfo:OpenCheckDeadMonsterRange()
    end
end
--endregion

--region ID:67112 DemonBossEndTimeMessage 进入视野告诉客户端魔之boss剩余时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.DemonBossEndTime lua table类型消息数据
---@param csData mapV2.DemonBossEndTime C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67112] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData == nil or gameMgr:GetMainScene() == nil then
        return
    end
    local luaAvatar = gameMgr:GetMainScene():GetLuaAvatarByID(tblData.lid)
    if luaAvatar ~= nil and luaAvatar.SetDemonBossEndTime ~= nil then
        luaAvatar:SetDemonBossEndTime(tblData.endTime)
    end
end
--endregion

--region ID:67113 ResGodBossInfoMessage 神之boss信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResGodBossInfo lua table类型消息数据
---@param csData mapV2.ResGodBossInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67113] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData == nil then
        return
    end
    luaclass.FinalBossDataInfo:GetMythBossDataInfo():RefreshGodBossInfo(tblData)
    gameMgr:GetPlayerDataMgr():GetBossDataManager():SetBossState(tblData, true)
end
--endregion

--region ID:67114 ResSealTowerAddDamageMessage 联服封印塔加伤假buff消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResSealTowerAddDamage lua table类型消息数据
---@param csData mapV2.ResSealTowerAddDamage C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67114] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --print("联服封印塔加伤假buff消息", "tblData.openType", tblData.openType, "tblData.addDamgePercent", tblData.addDamgePercent)
    luaclass.SealTowerDataInfo.isTowerAddDamageOpened = tblData.openTypeSpecified and tblData.openType == 0
    luaclass.SealTowerDataInfo.towerAddDamagePercentage = tblData.addDamgePercent
    if CS.CSScene.MainPlayerInfo ~= nil then
        if luaclass.SealTowerDataInfo.isTowerAddDamageOpened and tblData.addDamgePercent > 0 then
            CS.CSScene.MainPlayerInfo.BuffInfo:AddClientBuff(13009001)
        else
            CS.CSScene.MainPlayerInfo.BuffInfo:RemoveClientBuff(13009001)
        end
    end
end
--endregion

--region ID:67116 ResBonfireAddExpMessage 烤篝火跳字
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.BonfireAddExp lua table类型消息数据
---@param csData mapV2.BonfireAddExp C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67116] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData == nil or tblData.exp == 0 then
        return
    end

    if tblData.rid ~= CS.CSScene.MainPlayerInfo.ID then
        return
    end

    local avatar = CS.CSScene.Sington:getAvatar(tblData.rid)
    if avatar and avatar.Head then
        local showStr = 'd+' .. tostring(tblData.exp)
        avatar.Head:PlayText(showStr, CS.ThrowTextType.Exp)
    end
end
--endregion

--region ID:67118 ResBonfireInfoMessage 返回篝火信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResBonfireInfo lua table类型消息数据
---@param csData mapV2.ResBonfireInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67118] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:67119 ResPlayerEnterBonfireStateMessage 返回篝火信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.PlayerEnterBonfireState lua table类型消息数据
---@param csData mapV2.PlayerEnterBonfireState C# class类型消息数据
netMsgPreprocessing[67119] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData == nil or tblData.bonfireId == nil then
        return
    end
    if tblData.state ~= nil and tblData.state == 1 and tblData.rid == gameMgr:GetLuaMainPlayer():GetID() then
        gameMgr:GetGameDataManager():GetLuaBonfireDataManager():TryAddPromptPushWine(tblData.bonfireId)
    end
end
--endregion

--region ID:67125 ResUseItemDeliverToMapMessage 使用物品传送到地图
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResUseItemDeliverToMap lua table类型消息数据
---@param csData mapV2.ResUseItemDeliverToMap C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67125] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        local data = tblData

        ---@type UtilityPromptPanelInfo
        local commonData = {}
        commonData.PromptWordId = 156
        commonData.Time = data.endTime - CS.CSServerTime.Instance.TotalMillisecond
        commonData.IsClose = false
        commonData.TimeType = LuaEnumSecondComfirmTimeType.MinuteAndSecond
        commonData.TimeEndCallBack = function()
            Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.DeliverSpecialMap)
            uimanager:ClosePanel("UIPromptPanel")
        end
        commonData.ComfireAucion = function()
            ---将服务器下发的DeliverId(实际为：副本id)发给服务器
            networkRequest.ReqEnterDuplicate(data.deliverId)
            Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.DeliverSpecialMap)
            uimanager:ClosePanel("UIPromptPanel")
            uimanager:ClosePanel("UIBagPanel")
        end
        ---先显示面板
        Utility.ShowSecondConfirmPanel(commonData)

        ---再添加气泡
        Utility.TryAddFlashPromp({
            id = LuaEnumFlashIdType.DeliverSpecialMap,
            clickCallBack = function()
                Utility.ShowSecondConfirmPanel({
                    PromptWordId = 156,
                    Time = data.endTime - CS.CSServerTime.Instance.TotalMillisecond,
                    IsClose = false,
                    TimeType = LuaEnumSecondComfirmTimeType.MinuteAndSecond,
                    TimeEndCallBack = function()
                        Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.DeliverSpecialMap)
                        uimanager:ClosePanel("UIPromptPanel")
                    end,
                    ComfireAucion = function()
                        ---将服务器下发的DeliverId(实际为：副本id)发给服务器
                        networkRequest.ReqEnterDuplicate(data.deliverId)
                        Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.DeliverSpecialMap)
                        uimanager:ClosePanel("UIPromptPanel")
                        uimanager:ClosePanel("UIBagPanel")
                    end
                })
            end
        })
    end
end
--endregion

--region ID:67130 ResActivityMapInfoMessage 返回活动地图信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData mapV2.ResActivityMapInfo lua table类型消息数据
---@param csData mapV2.ResActivityMapInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[67130] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr == nil or gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    gameMgr:GetPlayerDataMgr():GetLuaMonsterAttackMgr():MonsterAttackData(tblData.monsterNumber)
end
--endregion
