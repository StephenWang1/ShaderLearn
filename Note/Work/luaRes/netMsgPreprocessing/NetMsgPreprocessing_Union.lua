--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--union.xml

--region ID:23002 ResApplyForUnionStateChangeMessage 申请入会状态变化
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResApplyForUnionStateChange lua table类型消息数据
---@param csData unionV2.ResApplyForUnionStateChange C# class类型消息数据
netMsgPreprocessing[23002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateAllUnionApplyInfo(csData)
end
--endregion

--region ID:23003 ResSendAllUnionInfoMessage 发送行会列表信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSendAllUnionInfo lua table类型消息数据
---@param csData unionV2.ResSendAllUnionInfo C# class类型消息数据
netMsgPreprocessing[23003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local playerInfo = CS.CSScene.MainPlayerInfo
    if playerInfo then
        playerInfo.UnionInfoV2:UpdateAllUnionInfo(csData)
    end
end
--endregion

--region ID:23005 ResSendPlayerUnionInfoMessage 发送玩家所在行会信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSendPlayerUnionInfo lua table类型消息数据
---@param csData unionV2.ResSendPlayerUnionInfo C# class类型消息数据
netMsgPreprocessing[23005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdatePlayerGuildInfo(csData)
    end
    if tblData ~= nil then
        gameMgr:GetPlayerDataMgr():GetUnionInfo():ResSendPlayerUnionInfoMessage(tblData)
    end
    gameMgr:GetPlayerDataMgr():GetShareMapInfo():CheckRegisteVoteEvent()
end
--endregion

--region ID:23012 ResSendApplyListInfoMessage 发送申请入会列表信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSendApplyListInfo lua table类型消息数据
---@param csData unionV2.ResSendApplyListInfo C# class类型消息数据
netMsgPreprocessing[23012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateApplyInfo(csData)
end
--endregion

--region ID:23015 ResSendQuitUnionSuccessMessage 发送退出行会成功信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSendQuitUnionSuccess lua table类型消息数据
---@param csData unionV2.ResSendQuitUnionSuccess C# class类型消息数据
netMsgPreprocessing[23015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateUnionQuitInfo(csData)
end
--endregion

--region ID:23016 ResSendChangeAnnounceMessage 发送修改公告信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSendChangeAnnounce lua table类型消息数据
---@param csData unionV2.ResSendChangeAnnounce C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23017 ResSendChangePositionMessage 发送调整职位信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSendChangePosition lua table类型消息数据
---@param csData unionV2.ResSendChangePosition C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23057 ResInviteForEnterUnionMessage 发送内推信息至被邀请者
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResInviteForEnterUnion lua table类型消息数据
---@param csData unionV2.ResInviteForEnterUnion C# class类型消息数据
netMsgPreprocessing[23057] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        ---@type UIMainChatPanel
        local flashData = {}
        flashData.id = 17
        flashData.clickCallBack = function()
            local CancelInfo
            local res, data = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(58)
            if res then
                CancelInfo = {
                    Title = data.title,
                    LeftDescription = data.leftButton,
                    RightDescription = data.rightButton,
                    ID = 58,
                    Content = string.format(data.des, csData.inviterName, csData.unionName),
                    CallBack = function()
                        networkRequest.ReqAgreeUnionInvite(csData.unionId)
                        Utility.RemoveFlashPrompt(1, 17)
                    end,
                    CancelCallBack = function()
                        uimanager:ClosePanel("UIPromptPanel")
                        Utility.RemoveFlashPrompt(1, 17)
                    end
                }
                uimanager:CreatePanel("UIPromptPanel", nil, CancelInfo)
            end
        end
        Utility.AddFlashPrompt(flashData)
    end
end
--endregion

--region ID:23060 ResDissolveUnionMessage 返回解散行会
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResDissolveUnion lua table类型消息数据
---@param csData unionV2.ResDissolveUnion C# class类型消息数据
netMsgPreprocessing[23060] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateUnionDissolveInfo(csData)
end
--endregion

--region ID:23062 ResUnionWarehouseInfoMessage 返回请求行会仓库
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUnionWarehouseInfo lua table类型消息数据
---@param csData unionV2.ResUnionWarehouseInfo C# class类型消息数据
netMsgPreprocessing[23062] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateUnionBagInfo(csData)
end
--endregion

--region ID:23071 ResSendCreateUnionSuccessMessage 返回成功创建行会信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSendCreateUnionSuccess lua table类型消息数据
---@param csData unionV2.ResSendCreateUnionSuccess C# class类型消息数据
netMsgPreprocessing[23071] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateUnionCreateInfo(csData)
end
--endregion

--region ID:23072 ResDonateMoneyMessage 返回捐赠金钱信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResDonateMoney lua table类型消息数据
---@param csData unionV2.ResDonateMoney C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23072] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23077 ResUnionMemberInfoMessage 返回行会成员列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUnionMemberInfo lua table类型消息数据
---@param csData unionV2.ResUnionMemberInfo C# class类型消息数据
netMsgPreprocessing[23077] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateUnionMemberInfo(csData)
    end
end
--endregion

--region ID:23082 ResGetBlackApplyRoleMessage 返回拉黑的玩家列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResGetBlackApplyRole lua table类型消息数据
---@param csData unionV2.ResGetBlackApplyRole C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23082] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23085 ResKickOutGuildMessage 返回被T的人的公会ID和名字
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResKickOutGuild lua table类型消息数据
---@param csData unionV2.ResKickOutGuild C# class类型消息数据
netMsgPreprocessing[23085] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateKickMemberInfo(csData)
end
--endregion

--region ID:23088 ResImpeachmentVoteMessage 返回弹劾票行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResImpeachmentVote lua table类型消息数据
---@param csData unionV2.ResImpeachmentVote C# class类型消息数据
netMsgPreprocessing[23088] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateUnionImpeachment(csData)
end
--endregion

--region ID:23091 ResTheUnionChangeMessage 行会改变消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResTheUnionChange lua table类型消息数据
---@param csData unionV2.ResTheUnionChange C# class类型消息数据
netMsgPreprocessing[23091] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdatePlayerUnionInfo(csData)
end
--endregion

--region ID:23092 ResUnionNameChangeMessage 行会改变向周围玩家发送消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUnionNameChange lua table类型消息数据
---@param csData unionV2.ResUnionNameChange C# class类型消息数据
netMsgPreprocessing[23092] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        local avater = CS.CSScene.Sington:getAvatar(tblData.rid);
        if avater == nil then
            return
        end
        if avater.BaseInfo ~= nil and avater.BaseInfo.CommonUnionInfoV2 ~= nil then
            avater.BaseInfo.CommonUnionInfoV2.UnionName = tblData.unionName;
            avater.BaseInfo.CommonUnionInfoV2.UnionID = tblData.unionId;
            avater.BaseInfo.CommonUnionInfoV2.Ranking = tblData.unionRank;
            avater.BaseInfo.CommonUnionInfoV2.UnionTotemId = tostring(tblData.unionIconId);
        end
        if avater.AvatarType == CS.EAvatarType.MainPlayer then
            if (CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.UnionInfoV2 ~= nil) then
                CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionName = tblData.unionName;
                CS.CSScene.MainPlayerInfo.UnionPos = tblData.unionPos;
                CS.CSScene.MainPlayerInfo.UnionInfoV2.Ranking = tblData.unionRank;
            end
        end
    end
end
--endregion

--region ID:23094 ResGetAllUnionIconMessage 返回所有会徽
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResGetAllUnionIcon lua table类型消息数据
---@param csData unionV2.ResGetAllUnionIcon C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23094] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23097 ResGetUnionJournalMessage 返回日志
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResGetUnionJournal lua table类型消息数据
---@param csData unionV2.ResGetUnionJournal C# class类型消息数据
netMsgPreprocessing[23097] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local playerInfo = CS.CSScene.MainPlayerInfo
    if playerInfo then
        playerInfo.UnionInfoV2:UpdateUnionJournal(csData)
    end
end
--endregion

--region ID:23099 ResGetUnionAttributeMessage 返回行会属性
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResGetUnionAttribute lua table类型消息数据
---@param csData unionV2.ResGetUnionAttribute C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23099] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        if gameMgr:GetPlayerDataMgr() then
            gameMgr:GetPlayerDataMgr():GetUnionInfo():SetUnionBossRank(tblData.unionBossRankNo)
        end
    end
end
--endregion

--region ID:23101 GetAssignmentMessage 收到了请求转让会长消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.GetAssignment lua table类型消息数据
---@param csData unionV2.GetAssignment C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23101] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and tblData.oldMonsterName and tblData.oldMonsterId and tblData.position then
        local res, info = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(8)
        if res then
            local KickInfo = {
                Title = info.title,
                LeftDescription = info.leftButton,
                RightDescription = info.rightButton,
                ID = 8,
                Content = string.format(string.gsub(info.des, "\\n", '\n'), tblData.oldMonsterName),
                CallBack = function()
                    networkRequest.YesGetUnionMonster(tblData.oldMonsterId, tblData.position, CS.CSScene.MainPlayerInfo.ID, 1)
                end,
                CancelCallBack = function()
                    networkRequest.YesGetUnionMonster(tblData.oldMonsterId, tblData.position, CS.CSScene.MainPlayerInfo.ID, 2)
                end
            }
            uimanager:CreatePanel("UIPromptPanel", nil, KickInfo)
        end
    end
end
--endregion

--region ID:23103 HandlingSuccessMessage 发给双方转让会长处理的消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.HandlingSuccess lua table类型消息数据
---@param csData unionV2.HandlingSuccess C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23103] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23106 ResGetBagItemInfoMessage 返回行会仓库一个格子的所有数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResGetBagItemInfo lua table类型消息数据
---@param csData unionV2.ResGetBagItemInfo C# class类型消息数据
netMsgPreprocessing[23106] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23113 ResApplyCombineUnionMessage 请求合并响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResApplyCombineUnion lua table类型消息数据
---@param csData unionV2.ResApplyCombineUnion C# class类型消息数据
netMsgPreprocessing[23113] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local isFind, promptInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(46)
    if isFind then
        local temp = {}
        temp.Title = promptInfo.title
        -- [878787][e85038]%s[-]的帮主[e85038]%s[-]申请与本帮主合并，是否同意？
        temp.Content = string.format(promptInfo.des, csData.unionName, csData.leaderName)
        temp.LeftDescription = promptInfo.leftButton
        temp.RightDescription = promptInfo.rightButton
        temp.ID = 46
        temp.CallBack = function()
            networkRequest.ReqConfirmCombineUnion(csData.unionId, 1)
        end
        temp.CloseCallBack = function()
            networkRequest.ReqConfirmCombineUnion(csData.unionId, 0)
        end
        uimanager:CreatePanel("UIPromptPanel", nil, temp)
    end
end
--endregion

--region ID:23116 ResSpoilsHouseMessage 返回战利品仓库
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSpoilsHouse lua table类型消息数据
---@param csData unionV2.ResSpoilsHouse C# class类型消息数据
netMsgPreprocessing[23116] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:GetUnionSpoils(csData)
end
--endregion

--region ID:23118 ResSpoilsHouseUpdateMessage 战利品仓库更新消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResSpoilsHouseUpdate lua table类型消息数据
---@param csData unionV2.ResSpoilsHouseUpdate C# class类型消息数据
netMsgPreprocessing[23118] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdataUnionSpoils(csData)
end
--endregion

--region ID:23120 ResCanGetSpoilsMembersMessage 返回可发放战利品的成员列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResCanGetSpoilsMembers lua table类型消息数据
---@param csData unionV2.ResCanGetSpoilsMembers C# class类型消息数据
netMsgPreprocessing[23120] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateGrantPlayerList(csData)
end
--endregion

--region ID:23122 ResUpdateTodayCityTaxMessage 更新行会今天的税收
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.updateTodayCityTax lua table类型消息数据
---@param csData unionV2.updateTodayCityTax C# class类型消息数据
netMsgPreprocessing[23122] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2.unionInfo.unionTodayTax = csData.unionTodayTax
end
--endregion

--region ID:23124 ResUnionVoiceStatusMessage 语音权限信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.UnionVoiceStatus lua table类型消息数据
---@param csData unionV2.UnionVoiceStatus C# class类型消息数据
netMsgPreprocessing[23124] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateVoiceQuotaFullActive(csData)
    CS.CSScene.MainPlayerInfo.UnionInfoV2:SetVoicePermission(csData)


end
--endregion

--region ID:23127 ResUnionChatAnnounceMessage 新行会消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUnionChatAnnounce lua table类型消息数据
---@param csData unionV2.ResUnionChatAnnounce C# class类型消息数据
netMsgPreprocessing[23127] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23128 ResMagicCircleStartMessage 魔法阵开始
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResMagicCircleStart lua table类型消息数据
---@param csData unionV2.ResMagicCircleStart C# class类型消息数据
netMsgPreprocessing[23128] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.MagicCircleInfo:RefreshMagicCircleStartInfo(csData)
    if CS.CSScene.MainPlayerInfo.MagicCircleInfo:MainPlayerCanEnterMagicCircle() == 0 then
        Utility.TryAddFlashPromp({ id = LuaEnumFlashIdType.MagicCircleIsOpenHint, clickCallBack = function()
            Utility.RemoveFlashPrompt(1, LuaEnumFlashIdType.MagicCircleIsOpenHint)
            Utility.ShowSecondConfirmPanel({ PromptWordId = 88, des = CS.Cfg_PromptWordTableManager.Instance:GetShowContent(88, CS.CSScene.MainPlayerInfo.MagicCircleInfo.MonsterInfo.name), ComfireAucion = function()
                networkRequest.ReqEnterDuplicate(6001)
            end })
        end })
    end
end
--endregion

--region ID:23130 ResMagicCircleInfoMessage 魔法阵信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResMagicCircleInfo lua table类型消息数据
---@param csData unionV2.ResMagicCircleInfo C# class类型消息数据
netMsgPreprocessing[23130] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.MagicCircleInfo:RefreshMagicCircleInfo(csData)
    end
end
--endregion

--region ID:23132 ResUnionRedBagInfoMessage 红包信息响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUnionRedBagInfo lua table类型消息数据
---@param csData unionV2.ResUnionRedBagInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23132] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23136 ResUnionSpeakerStatusMessage 行会成员喇叭状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUnionSpeakerStatus lua table类型消息数据
---@param csData unionV2.ResUnionSpeakerStatus C# class类型消息数据
netMsgPreprocessing[23136] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:UpdateSpeakeQuotaFullActive(csData)
    CS.CSScene.MainPlayerInfo.UnionInfoV2:SetResUnionSpeakerStatus(csData)
    CS.CSScene.MainPlayerInfo.UnionInfoV2:RefreshMainPlayerRealVoice()
end
--endregion

--region ID:23138 ResUnionCallBackCdMessage 响应帮会召唤令信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUnionCallBackInfo lua table类型消息数据
---@param csData unionV2.ResUnionCallBackInfo C# class类型消息数据
netMsgPreprocessing[23138] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData ~= nil and csData.cdTime ~= nil then
        CS.CSScene.MainPlayerInfo.UnionInfoV2:RefreshUseEndTime(csData.cdTime)
    end
end
--endregion

--region ID:23139 ResUnionMagicCallBossMessage 魔法阵boss召唤
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[23139] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23140 ResUnionMagicBossRankMessage 魔法阵boss积分排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUnionMagicBossRank lua table类型消息数据
---@param csData unionV2.ResUnionMagicBossRank C# class类型消息数据
netMsgPreprocessing[23140] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---魔法结阵
    CS.CSScene.MainPlayerInfo.ActivityInfo:RefreshMagicCircleSettleVoList(csData)
    if CS.CSScene:getMapID() == 6001 and CS.CSScene.MainPlayerInfo.MagicCircleInfo.HaveMonster == true and CS.CSScene.MainPlayerInfo.MagicCircleInfo.MonsterInfo ~= nil then
        Utility.CreateSidebarRankPanel({ rankTable = Utility.ListChangeTable(CS.CSScene.MainPlayerInfo.ActivityInfo.MagicCircleSettleVoList), rewardListBtnOnClick = function(go)
            Utility.CreateRewardRankPanel({ type = 1 })
        end, helpBtnOnClick = function()
            local isFind, descriptionInfo = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(164)
            if isFind then
                uimanager:CreatePanel("UIHelpTipsPanel", nil, descriptionInfo)
            end
        end })
    else
        local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
        if uiMainMenusPanel == nil then
            return
        end
        uiMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
    end
end
--endregion

--region ID:23141 ResUpdateAgencyChairmanMessage 更新代理会长职位
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResUpdateAgencyChairman lua table类型消息数据
---@param csData unionV2.ResUpdateAgencyChairman C# class类型消息数据
netMsgPreprocessing[23141] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        mainPlayerInfo.UnionInfoV2:UpdateActingPresident(csData)
    end
end
--endregion

--region ID:23143 ResToViewUnionRevengeMessage 返回查看行会复仇
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResToViewUnionRevenge lua table类型消息数据
---@param csData unionV2.ResToViewUnionRevenge C# class类型消息数据
netMsgPreprocessing[23143] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if  CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.UnionInfoV2.UnionRevengeInfo = csData
    end

    if (tblData ~= nil and tblData.info ~= nil) then
        gameMgr:GetPlayerDataMgr():GetUnionInfo():SetUnionEnemyTable(tblData.info)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.UNION_REVENGE)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.UNION_ALL)
    end
end
--endregion

--region ID:23145 ResRewardUnionRevengeMessage 行会复仇领奖返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResRewardUnionRevenge lua table类型消息数据
---@param csData unionV2.ResRewardUnionRevenge C# class类型消息数据
netMsgPreprocessing[23145] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.UnionInfoV2:SetUnionRevengeInfo(csData)
    gameMgr:GetPlayerDataMgr():GetUnionInfo():RefreshUnionEnemyReward(tblData)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.UNION_REVENGE)
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.UNION_ALL)
end
--endregion

--region ID:23146 ResAddUnionRevengeMessage 刷新一个行会仇人
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResAddUnionRevenge lua table类型消息数据
---@param csData unionV2.ResAddUnionRevenge C# class类型消息数据
netMsgPreprocessing[23146] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (tblData.unionRevenge ~= nil) then
        if (tblData.type == 0) then
            CS.CSScene.MainPlayerInfo.UnionInfoV2:AddUnionRevengeInfo(csData.unionRevenge)
            gameMgr:GetPlayerDataMgr():GetUnionInfo():AddUnionEnemyTable(tblData.unionRevenge)
        elseif (tblData.type == 1) then
            CS.CSScene.MainPlayerInfo.UnionInfoV2:RefreshUnionRevengeInfo(csData.unionRevenge)
            gameMgr:GetPlayerDataMgr():GetUnionInfo():RefreshUnionEnemyTable(tblData.unionRevenge)
        elseif (tblData.type == 2) then
            CS.CSScene.MainPlayerInfo.UnionInfoV2:RemoveUnionRevengeInfo(csData.unionRevenge)
            gameMgr:GetPlayerDataMgr():GetUnionInfo():RemoveUnionEnemyTable(tblData.unionRevenge)
        end
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.UNION_REVENGE)
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.UNION_ALL)
    end
end
--endregion

--region ID:23148 ResGetRevengePointMessage 返回仇人位置
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.ResGetRevengePoint lua table类型消息数据
---@param csData unionV2.ResGetRevengePoint C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23148] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23150 ResAllWillJoinUniteUnionMessage 返回所有联服同盟投票
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.AllWillJoinUniteUnion lua table类型消息数据
---@param csData unionV2.AllWillJoinUniteUnion C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23150] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23153 ResAllOtherWillJoinUniteUnionMessage 返回所有服所有联服同盟投票
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.OtherAllUniteUnionVoteInfo lua table类型消息数据
---@param csData unionV2.OtherAllUniteUnionVoteInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23153] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetLeagueInfo() ~= nil then
        gameMgr:GetPlayerDataMgr():GetLeagueInfo():SetAllWillLeagueVoteRankInfo(tblData)
    end
end
--endregion

--region ID:23154 ResUnionBossPlayerRankInfoMessage 返回个人排行榜,进副本就推,
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.UnionBossPlayerRankInfo lua table类型消息数据
---@param csData unionV2.UnionBossPlayerRankInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23154] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23155 ResUnionBossUnionRankInfoMessage 返回公会排行榜, 进副本就推
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.UnionBossUnionRankInfo lua table类型消息数据
---@param csData unionV2.UnionBossUnionRankInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23155] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:23157 ResUnionBossBuffInfoMessage 返回鼓舞buff的信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData unionV2.UnionBossBuffInfo lua table类型消息数据
---@param csData unionV2.UnionBossBuffInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[23157] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
