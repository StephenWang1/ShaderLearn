--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--task.xml

--region ID:102001 ResTaskProcessMessage 返回任务进度消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResTaskProcess lua table类型消息数据
---@param csData taskV2.ResTaskProcess C# class类型消息数据
netMsgPreprocessing[102001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --print('返回任务进度消息')
    CS.CSMissionManager.Instance:UpdateMission(csData.info)
    if gameMgr and gameMgr:GetPlayerDataMgr() then
        gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():ResMonsterArrestInfoChange()
    end
end
--endregion

--region ID:102003 ResAllTaskListMessage 返回任务列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResTaskData lua table类型消息数据
---@param csData taskV2.ResTaskData C# class类型消息数据
netMsgPreprocessing[102003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --print('返回任务列表')
    CS.CSMissionManager.Instance:InitialMissionV2(csData)
end
--endregion

--region ID:102004 ResOtherTaskStateMessage 返回支线任务状态
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResOtherTaskState lua table类型消息数据
---@param csData taskV2.ResOtherTaskState C# class类型消息数据
netMsgPreprocessing[102004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    -- print('返回支线任务状态')
    CS.CSMissionManager.Instance:AddOtherMissionV2(csData)
end
--endregion

--region ID:102008 ResRecycleTaskInfoMessage 返回循环任务面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResRecycleTaskInfo lua table类型消息数据
---@param csData taskV2.ResRecycleTaskInfo C# class类型消息数据
netMsgPreprocessing[102008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:102011 ResMercenaryTaskInfoMessage 返回雇佣兵任务面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResMercenaryTaskInfo lua table类型消息数据
---@param csData taskV2.ResMercenaryTaskInfo C# class类型消息数据
netMsgPreprocessing[102011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --  print('返回雇佣兵任务面板信息')
    CS.CSMissionManager.Instance:ResMercenaryTaskInfoMessage(csData)
end
--endregion

--region ID:102012 ResDailyTaskInfoMessage 返回日常任务面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResDailyTaskInfo lua table类型消息数据
---@param csData taskV2.ResDailyTaskInfo C# class类型消息数据
netMsgPreprocessing[102012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --print('返回日常任务面板信息')
    CS.CSMissionManager.Instance:ResDailyTaskInfoMessage(csData)
    --gameMgr:GetLuaMissionManager():SetDailyExtraSurplusTimeDic(tblData)
end
--endregion

--region ID:102014 ResRecycleTaskInfoMessage 返回主线任务面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResMainTaskInfo lua table类型消息数据
---@param csData taskV2.ResMainTaskInfo C# class类型消息数据
netMsgPreprocessing[102014] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSMissionManager.Instance:ResMainTaskInfoMessage(csData)
end
--endregion

--region ID:102016 ResMaterialListMessage 返回日常材料列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResMaterialList lua table类型消息数据
---@param csData taskV2.ResMaterialList C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[102016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:102018 ResMainOtherTaskInfoPanelMessage 返回支线任务信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResMainOtherTaskInfoPanel lua table类型消息数据
---@param csData taskV2.ResMainOtherTaskInfoPanel C# class类型消息数据
netMsgPreprocessing[102018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData ~= nil) then
        CS.CSMissionManager.Instance:ResSecondTaskInfoMessage(csData);
    end
end
--endregion

--region ID:102020 ResTaskStrategyMessage 攻略
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResTaskStrategy lua table类型消息数据
---@param csData taskV2.ResTaskStrategy C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[102020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:102021 ResEliteTaskInfoPanelMessage 返回精英任务
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResEliteTaskInfoPanel lua table类型消息数据
---@param csData taskV2.ResEliteTaskInfoPanel C# class类型消息数据
netMsgPreprocessing[102021] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData ~= nil) then
        CS.CSMissionManager.Instance:ResEliteTaskInfoMessage(csData);
    end
end
--endregion

--region ID:102023 ResTaskSettingMessage 返回任务设置
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.TaskSetting lua table类型消息数据
---@param csData taskV2.TaskSetting C# class类型消息数据
netMsgPreprocessing[102023] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData ~= nil then
        CS.CSMissionManager.Instance:InitTaskSetting(csData.tips)
    end

end
--endregion

--region ID:102026 ResEliteBuyPriceMessage 精英任务购买价格回复
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResEliteBuyPrice lua table类型消息数据
---@param csData taskV2.ResEliteBuyPrice C# class类型消息数据
netMsgPreprocessing[102026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:102027 ResBossTaskInfoPanelMessage 返回Boss任务
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResBossTaskInfoPanel lua table类型消息数据
---@param csData taskV2.ResBossTaskInfoPanel C# class类型消息数据
netMsgPreprocessing[102027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData ~= nil) then
        CS.CSMissionManager.Instance:ResBossTaskInfoMessage(csData);
    end
end
--endregion

--region ID:102028 ResMonsterRewardTaskInfoPanelMessage 返回怪物悬赏任务
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResMonsterRewardTaskInfoPanel lua table类型消息数据
---@param csData taskV2.ResMonsterRewardTaskInfoPanel C# class类型消息数据
netMsgPreprocessing[102028] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (csData ~= nil) then
        CS.CSMissionManager.Instance:ResMonsterRewardTaskInfoPanelMessage(csData);
        --
        --if (tblData.info ~= nil) then
        --    for k, v in pairs(tblData.info) do
        --        if (v.taskId == 110001 or v.taskId == 110007) then
        --            print("102028    ", v.taskId)
        --            print(v.acceptTime, CS.CSServerTime.Instance.TotalMillisecond)
        --            if v.acceptTime == nil or v.acceptTime - CS.CSServerTime.Instance.TotalMillisecond < 5000 then
        --                --如果超过5s则认为不是当前时刻
        --                uiStaticParameter.IsReciveTaskWaitOpenMonsterArrestPanel = true
        --                CS.CSListUpdateMgr.Add(60000, nil, function()
        --                    if (uiStaticParameter.IsReciveTaskWaitOpenMonsterArrestPanel == true) then
        --                        uimanager:CreatePanel("UIMonsterArrestPanel")
        --                    end
        --                end)
        --            end
        --        end
        --    end
        --end
    end
    if gameMgr and gameMgr:GetPlayerDataMgr() then
        gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetMonsterArrestData():ResMonsterArrestInfoChange()
    end
end
--endregion

--region ID:102029 ResTheTaskHasRewardedMessage 任务奖励提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.TheTaskHasRewarded lua table类型消息数据
---@param csData taskV2.TheTaskHasRewarded C# class类型消息数据
netMsgPreprocessing[102029] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---BOSS悬赏奖励
    local rewardList = CS.Utility_Lua.GetActivityHasReward(csData.reward);
    local otherData = {}
    otherData.tips = luaEnumColorType.White .. "领先了" .. luaEnumColorType.Green .. csData.per / 10 .. "%[-]" .. "的玩家[-]";
    otherData.type = csData.group;
    uimanager:CreatePanel("UIRewardTipsPanel", nil, { rewards = rewardList }, otherData);
end
--endregion

--region ID:102030 ResMonsterTaskAllCompleteMessage 现有全部
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[102030] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.UIMapPanelController.IsLimitMonsterPointShow = true
end
--endregion

--region ID:102033 ResAllNewDailyTaskInfoMessage 全部日常任务信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.ResAllNewDailyTaskInfo lua table类型消息数据
---@param csData taskV2.ResAllNewDailyTaskInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[102033] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetSfMissionMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetChallengeBossData():ResAllNewDailyTaskInfo(tblData)
    end

end
--endregion

--region ID:102036 ResSoulTaskStateMessage 灵魂任务信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData taskV2.SoulTaskInfo lua table类型消息数据
---@param csData taskV2.SoulTaskInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[102036] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() ~= nil and gameMgr:GetPlayerDataMgr():GetSfMissionMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetSfMissionMgr():GetLingHunMissionData():GetNetMes(tblData)
    end
end
--endregion
