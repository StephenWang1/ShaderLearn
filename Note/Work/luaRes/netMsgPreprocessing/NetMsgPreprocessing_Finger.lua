--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--finger.xml

--region ID:112002 ResLatelyFingerPlayersMessage 发送最近划拳对象
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fingerV2.LatelyFingerPlayers lua table类型消息数据
---@param csData fingerV2.LatelyFingerPlayers C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[112002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:112004 ResInviteFingerMessage 被挑战者收到邀请
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fingerV2.ResInviteFinger lua table类型消息数据
---@param csData fingerV2.ResInviteFinger C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[112004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --添加闪烁提示
    if tblData then
        local temp = {}
        temp.id = 2
        temp.configid = tblData.dealerId
        temp.clickCallBack = function()
            networkRequest.ReqEchoInviteTime(tblData.dealerId)
        end
        Utility.AddFlashPrompt(temp)
    end
end
--endregion

--region ID:112006 ResEchoInviteMessage 返回邀请结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fingerV2.ResEchoInvite lua table类型消息数据
---@param csData fingerV2.ResEchoInvite C# class类型消息数据
netMsgPreprocessing[112006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if csData.dealer and csData.player then
            local id = CS.CSScene.MainPlayerInfo.ID
            local guessFistInfo = CS.CSScene.MainPlayerInfo.GuessFistInfo
            --判断自己是否为发起者
            if csData.dealer.lid == id then
                guessFistInfo.FistOurid = csData.dealer.lid
                guessFistInfo .OurFistInfo = csData.dealer
                guessFistInfo.FistEnemyid = csData.player.lid
                guessFistInfo.EnemyFistInfo = csData.player
                guessFistInfo.guessCamp = 1
            else
                guessFistInfo.FistOurid = csData.player.lid
                guessFistInfo.FistEnemyid = csData.dealer.lid
                guessFistInfo.EnemyFistInfo = csData.dealer
                guessFistInfo .OurFistInfo = csData.player
                guessFistInfo.guessCamp = 2
            end
            uimanager:CreatePanel('UIguessPanel', nil, csData.dealer.lid)
        end
    end

end
--endregion

--region ID:112008 ResRewardInfoMessage 返回赢得奖励信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fingerV2.ResRewardInfo lua table类型消息数据
---@param csData fingerV2.ResRewardInfo C# class类型消息数据
netMsgPreprocessing[112008] = function(msgID, tblData, csData)
    --在此处填入预处理代码

    if csData then
        local id = CS.CSScene.MainPlayerInfo.ID
        local guessFistInfo = CS.CSScene.MainPlayerInfo.GuessFistInfo
        --判断自己是否为发起者
        if csData.dealerReward.lid == id then
            guessFistInfo.OurRewardInfo = csData.dealerReward
            guessFistInfo.EnemyRewardInfo = csData.playerReward
        else
            guessFistInfo.OurRewardInfo = csData.playerReward
            guessFistInfo.EnemyRewardInfo = csData.dealerReward
        end
    end


end
--endregion

--region ID:112010 ResAllChosedMessage 返回开始猜拳
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fingerV2.ResAllChosed lua table类型消息数据
---@param csData fingerV2.ResAllChosed C# class类型消息数据
netMsgPreprocessing[112010] = function(msgID, tblData, csData)
    if csData then
        if CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo then
            CS.CSScene.MainPlayerInfo.GuessFistInfo.ourGuessType = csData.dealerChose
            CS.CSScene.MainPlayerInfo.GuessFistInfo.enemyGuessType = csData.playerChose
        end
    end
end
--endregion

--region ID:112012 ResFingerReasonMessage 返回猜拳结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fingerV2.ResFingerReason lua table类型消息数据
---@param csData fingerV2.ResFingerReason C# class类型消息数据
netMsgPreprocessing[112012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if csData.type == 1 then
            CS.Utility.ShowTips("平局", 1.5, CS.ColorType.Red)
            return
        end

        if CS.CSScene.MainPlayerInfo and CS.CSScene.MainPlayerInfo then
            local guessFistInfo = CS.CSScene.MainPlayerInfo.GuessFistInfo
            guessFistInfo. isOurWin = csData.winner.lid == guessFistInfo.FistOurid
            if guessFistInfo.isOurWin then
                CS.Utility.ShowTips("您赢了", 1.5, CS.ColorType.Red)
            else
                CS.Utility.ShowTips("您输了", 1.5, CS.ColorType.Red)
            end

        end
    end
end
--endregion

--region ID:112014 ResTerminateFingerMessage 返回终止猜拳
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fingerV2.ResTerminate lua table类型消息数据
---@param csData fingerV2.ResTerminate C# class类型消息数据
netMsgPreprocessing[112014] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    Utility.RemoveFlashPrompt(2, csData.dealer)

    local panel = uimanager:GetPanel('UIguessPanel')
    if panel ~= nil then
        if panel.dealerId == csData.dealer then
            uimanager:ClosePanel('UIguessPanel')
        end
    end
    uimanager:ClosePanel('UIPromptPanel')

end
--endregion

--region ID:112016 ResEchoInviteTimeMessage 返回邀请剩余时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData fingerV2.ResInviteFinger lua table类型消息数据
---@param csData fingerV2.ResInviteFinger C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[112016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:112017 ResUseBagChipMessage 返回背包使用筹码
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[112017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    uimanager:CreatePanel('UIGuessChoosePanel')
end
--endregion

--region ID:112018 ResChoseFingerMessage 通知玩家对方已经出拳
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[112018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
