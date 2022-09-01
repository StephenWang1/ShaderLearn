--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--friend.xml

--region ID:100001 ResFriendInfoMessage 返回好友信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResFriendInfo lua table类型消息数据
---@param csData friendV2.ResFriendInfo C# class类型消息数据
netMsgPreprocessing[100001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData.type == LuaEnumSocialLieBiaoType.ZuiJinLieBiao) then
        uiStaticParameter.UnReadChatCount = 0
        for i = 0, csData.friends.Count - 1 do
            if (csData.friends[i].unreadNum > 0) then
                uiStaticParameter.UnReadChatCount = uiStaticParameter.UnReadChatCount + csData.friends[i].unreadNum
                if (CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Contains(csData.friends[i].rid) == false) then
                    CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Add(csData.friends[i].rid)
                end
            end
        end
    end
    if (csData.type == LuaEnumSocialLieBiaoType.ShenQingLieBiao) then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddFriend(csData.type, csData.friends)
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddMayKnowFriend(csData.mayKnowList)
    else
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddFriend(csData.type, csData.friends)
    end
end
--endregion

--region ID:100005 ResFriendChangeMessage 返回好友变化信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResFriendChange lua table类型消息数据
---@param csData friendV2.ResFriendChange C# class类型消息数据
netMsgPreprocessing[100005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local FriendInfoV2 = CS.CSScene.MainPlayerInfo.FriendInfoV2
    if (csData.addOrRemove == 1) then
        FriendInfoV2:AddFriend(csData.type, csData.friend)
    elseif (csData.addOrRemove == 2) then
        ---移除聊天列表红点
        for i = 0, csData.friend.Count - 1 do
            if (csData.type == LuaEnumSocialLieBiaoType.ZuiJinLieBiao) then
                if (csData.friend[i].unreadNum > 0) then
                    --CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount = CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount - csData.friend[i].unreadNum > 0 and CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount - csData.friend[i].unreadNum or 0
                    uiStaticParameter.UnReadChatCount = uiStaticParameter.UnReadChatCount - csData.friend[i].unreadNum > 0 and uiStaticParameter.UnReadChatCount - csData.friend[i].unreadNum or 0
                end
                CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.V2_SocialChatCount, uiStaticParameter.UnReadChatCount);
            end
            if (CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Contains(csData.friend[i].rid)) then
                CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Remove(csData.friend[i].rid)
                CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SocialChat)
            end
        end
        FriendInfoV2:RemoveFriend(csData.type, csData.friend)
    else
        FriendInfoV2:UpdateFriendDic(csData.type, csData.friend)
    end
end
--endregion

--region ID:100007 ResSearchFriendMessage 好友查询响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.SearchFriend lua table类型消息数据
---@param csData friendV2.SearchFriend C# class类型消息数据
netMsgPreprocessing[100007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:100013 ResAscertainPointMessage 返回仇人坐标
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.AscertainPoint lua table类型消息数据
---@param csData friendV2.AscertainPoint C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[100013] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:100017 ResMayKnowFriendMessage 返回可能认识的朋友
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResMayKnowFriend lua table类型消息数据
---@param csData friendV2.ResMayKnowFriend C# class类型消息数据
netMsgPreprocessing[100017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.FriendInfoV2:AddMayKnowFriend(csData.list)
end
--endregion

--region ID:100021 ResPersonalInfoMessage 返回玩家个人信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResPersonalInfo lua table类型消息数据
---@param csData friendV2.ResPersonalInfo C# class类型消息数据
netMsgPreprocessing[100021] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.FriendInfoV2:RefreshRemarkLevel(csData)
end
--endregion

--region ID:100024 ResUnreadChatMessage 返回未读聊天
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResChatLog lua table类型消息数据
---@param csData friendV2.ResChatLog C# class类型消息数据
netMsgPreprocessing[100024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:100028 ResPersonalChatMessage 返回聊天记录
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResChatLog lua table类型消息数据
---@param csData friendV2.ResChatLog C# class类型消息数据
netMsgPreprocessing[100028] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:100030 ResFriendCirleMessage 返回朋友圈信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResFriendCircle lua table类型消息数据
---@param csData friendV2.ResFriendCircle C# class类型消息数据
netMsgPreprocessing[100030] = function(msgID, tblData, csData)
    CS.CSScene.MainPlayerInfo.FriendInfoV2:UpdateCircleOfFriends(csData);
end
--endregion

--region ID:100031 ResSingleFriendCirleMessage 单条朋友圈信息,发送,回复,点赞的响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.FriendCirclePostInfo lua table类型消息数据
---@param csData friendV2.FriendCirclePostInfo C# class类型消息数据
netMsgPreprocessing[100031] = function(msgID, tblData, csData)
    CS.CSScene.MainPlayerInfo.FriendInfoV2:UpdateCircleOfFriends(csData);
end
--endregion

--region ID:100037 ResEnemyPositionMessage 返回仇人位置
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResEnemyPosition lua table类型消息数据
---@param csData friendV2.ResEnemyPosition C# class类型消息数据
netMsgPreprocessing[100037] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        local panel = uimanager:GetPanel("UIArrestTrackPromptPanel")
        if panel then
            panel:Show(csData)
        else
            uimanager:CreatePanel("UIArrestTrackPromptPanel", nil, csData)
        end

    end
end
--endregion

--region ID:100040 ResOfferListMessage 返回悬赏列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResOfferList lua table类型消息数据
---@param csData friendV2.ResOfferList C# class类型消息数据
netMsgPreprocessing[100040] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:RefreshAllArrestList(csData)
    end
end
--endregion

--region ID:100042 ResFriendLoveChangeMessage 好感度变化消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResFriendLoveChange lua table类型消息数据
---@param csData friendV2.ResFriendLoveChange C# class类型消息数据
netMsgPreprocessing[100042] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:FriendLoverChange(csData);
    end
end
--endregion

--region ID:100044 ResFriendCircleUpdatedMessage 朋友圈有更新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResFriendCircleUpdated lua table类型消息数据
---@param csData friendV2.ResFriendCircleUpdated C# class类型消息数据
netMsgPreprocessing[100044] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:UpdateFriendCircleUpdated(csData);
    end
end
--endregion

--region ID:100048 ResUnLookApplicantMessage 返回未查看的申请人
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.UnLookApplicant lua table类型消息数据
---@param csData friendV2.UnLookApplicant C# class类型消息数据
netMsgPreprocessing[100048] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData.applicantList.Count > 0) then
        if (CS.CSScene.MainPlayerInfo.ChatInfoV2.NewFriendApplyList:Contains(1) == false) then
            CS.CSScene.MainPlayerInfo.ChatInfoV2.NewFriendApplyList:Add(1)
        end
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.FriendApply)
        uiStaticParameter.mNewInfos = LuaEnumMainChatType.Friend
    end
end
--endregion

--region ID:100049 ResOfferMatterCodeMessage 发送悬赏错误提示码
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.OfferMatterCode lua table类型消息数据
---@param csData friendV2.OfferMatterCode C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[100049] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:100050 ResUpdateLetteringMessage 刷新刻字
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.UpdateLettering lua table类型消息数据
---@param csData friendV2.UpdateLettering C# class类型消息数据
netMsgPreprocessing[100050] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.FriendInfoV2:FriendLetterChange(csData);
end
--endregion

--region ID:100051 ResUpdateOfferListMessage 更新悬赏列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResUpdateOfferList lua table类型消息数据
---@param csData friendV2.ResUpdateOfferList C# class类型消息数据
netMsgPreprocessing[100051] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData ~= nil and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.FriendInfoV2 ~= nil then
        --未接取时
        CS.CSScene.MainPlayerInfo.FriendInfoV2:UpdataMonsterArrest(csData)
    end
end
--endregion

--region ID:100054 ResUpdateMonsterOfferPanelMessage 更新怪物悬赏左侧栏
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.UpdateMonsterOfferPanel lua table类型消息数据
---@param csData friendV2.UpdateMonsterOfferPanel C# class类型消息数据
netMsgPreprocessing[100054] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData and CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.FriendInfoV2 ~= nil then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:UpdataReceivedMonsterArrest(csData)
    end
end
--endregion

--region ID:100058 ResUpdateCompleteNumMessage 更新完成人数
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResUpdateCompleteNum lua table类型消息数据
---@param csData friendV2.ResUpdateCompleteNum C# class类型消息数据
netMsgPreprocessing[100058] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:UpdataMonsterArrestComplete(csData)
    end
end
--endregion

--region ID:100059 ResFriendLoginMessage 好友上下线通知
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResFriendLogin lua table类型消息数据
---@param csData friendV2.ResFriendLogin C# class类型消息数据
netMsgPreprocessing[100059] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData) then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:UpdateFriendIsOnline(csData)
    end
end
--endregion

--region ID:100061 ResOfferSearchMessage 返回悬赏模糊查询
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResOfferSearch lua table类型消息数据
---@param csData friendV2.ResOfferSearch C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[100061] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:100063 ResAccurateSearchMessage 返回聊天框精确搜索
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ResAccurateSearch lua table类型消息数据
---@param csData friendV2.ResAccurateSearch C# class类型消息数据
netMsgPreprocessing[100063] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData.info.Count == 1) then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddPrivateChatFriend(LuaEnumSocialLieBiaoType.ZuiJinLieBiao, csData.info[0]);
    elseif (csData.info.Count >= 1) then
        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddPrivateChatFriendList(LuaEnumSocialLieBiaoType.ZuiJinLieBiao, csData.info);
    end
end
--endregion

--[[
--region ID:100026 ResAlreadyReadMessage 对方已读
---@param msgID LuaEnumNetDef 消息ID
---@param tblData friendV2.ChatTarget lua table类型消息数据
---@param csData friendV2.ChatTarget C# class类型消息数据
netMsgPreprocessing[100026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
