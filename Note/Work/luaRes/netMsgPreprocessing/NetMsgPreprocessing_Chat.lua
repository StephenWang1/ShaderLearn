--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--chat.xml

--region ID:6004 ResChatMessage 聊天结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData chatV2.ResChat lua table类型消息数据
---@param csData chatV2.ResChat C# class类型消息数据
netMsgPreprocessing[6004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData.channel == 5) then
        local chatpanel = uimanager:GetPanel("UIChatPanel")
        ---聊天面板没打开或打开但没有选中私聊列表时 未读条数+1
        if (chatpanel == nil) then
            if (csData.senderId ~= CS.CSScene.MainPlayerInfo.ID) then
                CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount = CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount + 1
            end
        else
            if (csData.senderId ~= CS.CSScene.MainPlayerInfo.ID) then
                if (uiStaticParameter.UIChatPanel_SelectIndex ~= 5 and uiStaticParameter.UIChatPanel_SelectIndex ~= 0) then
                    CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount = CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount + 1
                    chatpanel.SocialChatRedPointCount.text = CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount > 99 and "99+" or CS.CSScene.MainPlayerInfo.ChatInfoV2.AllSocialChatCount
                    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.AllSocialChat)
                end
            end
        end
        if (csData.senderId ~= CS.CSScene.MainPlayerInfo.ID and CS.CSScene.MainPlayerInfo.FriendInfoV2:GetFriend(csData.senderId) ~= nil) then
            uiStaticParameter.UnReadChatCount = uiStaticParameter.UnReadChatCount + 1
            CS.CSGame.Sington.EventHandler:SendEvent(CS.CEvent.V2_SocialChatCount, uiStaticParameter.UnReadChatCount);
            --region 红点新消息提醒
            if (CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Contains(csData.senderId) == false) then
                CS.CSScene.MainPlayerInfo.ChatInfoV2.NewInfosList:Add(csData.senderId)
                CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.SocialChat)
            end
            --endregion
        end

        CS.CSScene.MainPlayerInfo.FriendInfoV2:AddPrivateChatToMeCache(csData);
    end
end
--endregion

--region ID:6008 ResAnnounceMessage 公告消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData chatV2.ResAnnounce lua table类型消息数据
---@param csData chatV2.ResAnnounce C# class类型消息数据
netMsgPreprocessing[6008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --local co;
    --if (tblData.params[1] == "1" and tonumber(tblData.params[2]) == CS.CSScene.MainPlayerInfo.ID) then
    --    co = StartCoroutine(function()
    --        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(3))
    --        local panel = uimanager:GetPanel("UIMainMenusPanel")
    --        if (panel ~= nil) then
    --            panel.ResAnnounceMessage(msgID, tblData)
    --            if (co ~= nil) then
    --                StopCoroutine(co)
    --            end
    --        end
    --    end)
    --end
    if tblData ~= nil then
        if tblData.params ~= nil then
            if tblData.params[2] then
                ---怪物攻城弹窗id，地图ID#flashingID#promptwordID#conditionid#promptframeID#弹窗有效时间（毫秒）#传送deliverID#提醒显示限制（conditionID)
                local Lua_GlobalTABLE = LuaGlobalTableDeal.GetGlobalTabl(23027)
                local tempData = {}
                local data = string.Split(Lua_GlobalTABLE.value, "&")
                for i = 1, #data do
                    local temp = string.Split(data[i], "#")
                    if tonumber(tblData.params[2]) == tonumber(temp[1]) then
                        tempData = temp
                    end
                end
                local canShow = Utility.IsMainPlayerMatchCondition_LuaAndCS(tonumber(tempData[8]))
                if tempData[1] ~= nil and canShow ~= nil and canShow.success == true then
                    local currentTime = CS.UnityEngine.Time.time
                    local flashtemp = {}
                    flashtemp.id = tonumber(tempData[2])
                    local timeStamp = gameMgr:GetLuaTimeMgr():GetServerNowTimeStamp()
                    flashtemp.mTime = tonumber(tempData[6]) + timeStamp
                    flashtemp.clickCallBack = function()
                        local isOpen = Utility.IsMainPlayerMatchCondition_LuaAndCS(tonumber(tempData[4]))
                        local temp = {}
                        temp.ID = tonumber(tempData[3])
                        local currentTime2 = CS.UnityEngine.Time.time
                        local time = tonumber(tempData[6]) - ((currentTime2 - currentTime) * 1000)
                        temp.Time = time
                        temp.TimeType = LuaEnumSecondComfirmTimeType.MinuteAndSecond
                        temp.TimeEndCallBack = function()
                            uimanager:ClosePanel('UIPromptPanel')
                        end
                        if isOpen == nil or isOpen.success == true then
                            temp.CallBack = function()
                                Utility.RemoveFlashPrompt(1, tonumber(tempData[2]))
                                Utility.TryTransfer(tonumber(tempData[7]))
                            end
                        else
                            temp.IsShowGoldLabel = true
                            temp.GoldIcon = ""
                            local conditionTbl = clientTableManager.cfg_conditionsManager:TryGetValue(tonumber(tempData[4]))
                            temp.GoldCount = "[e85038]"..conditionTbl:GetTxt()
                            temp.IsClose = false
                            temp.CallBack = function()
                                local panel = uimanager:GetPanel("UIPromptPanel")
                                Utility.ShowPopoTips(panel.mCenterButton, nil, tonumber(tempData[5]), "UIPromptPanel")
                            end
                        end
                        temp.CancelCallBack = function()
                            Utility.RemoveFlashPrompt(1, tonumber(tempData[2]))
                            uimanager:ClosePanel('UIPromptPanel')
                        end
                        uimanager:CreatePanel("UIPromptPanel",nil,temp)
                    end
                    Utility.AddFlashPrompt(flashtemp)
                end
            end
        end
    end
end
--endregion

--region ID:6014 ResHuntAnnounceMessage 返回塔罗神庙公告历史记录
---@param msgID LuaEnumNetDef 消息ID
---@param tblData chatV2.ResHuntAnnounceHistory lua table类型消息数据
---@param csData chatV2.ResHuntAnnounceHistory C# class类型消息数据
netMsgPreprocessing[6014] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:6015 ResHuntAnnounceUpdateMessage 返回塔罗神庙公告更新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData chatV2.ResHuntAnnounceUpdate lua table类型消息数据
---@param csData chatV2.ResHuntAnnounceUpdate C# class类型消息数据
netMsgPreprocessing[6015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
