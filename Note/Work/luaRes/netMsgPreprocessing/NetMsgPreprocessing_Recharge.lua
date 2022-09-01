--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--recharge.xml

--region ID:39002 ResSendRechargeInfoMessage 发送充值界面信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResSendRechargeInfo lua table类型消息数据
---@param csData rechargeV2.ResSendRechargeInfo C# class类型消息数据
netMsgPreprocessing[39002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetRechargeInfo():SetResSendRechargeInfo(tblData)
    CS.CSScene.MainPlayerInfo.RechargeInfo.ResRechargeInfo = csData
    if (tblData.totalRechargeRewardTaken >= 1) then
        CS.CSScene.MainPlayerInfo.RechargeInfo.IsGetFirstRechargeReward = true;
    end
    local isFind, info = CS.Cfg_CumulativeRechargeTableManager.Instance.dic:TryGetValue("1")
    if (isFind) then
        if (tblData.totalRechargeCount ~= nil and tblData.totalRechargeCount >= info.cost) then
            CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_FirstReward)
        end
    end
    if (CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.RechargeInfo ~= nil) then
        if (tblData.firstRechargeReward ~= nil and tblData.firstRechargeReward > 0) then
            CS.CSScene.MainPlayerInfo.RechargeInfo.IsGetFirstRechargeReward = true;
        end
        CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeGetLevel = tblData.firstRechargeReward
        --CS.CSScene.MainPlayerInfo.RechargeInfo.FirstRechargeLastGetTime = tblData.firstRechargeLastGetTime
    end

    local csData = CS.CSScene.MainPlayerInfo.RechargeInfo.CurrentRechargeGiftBoxInfo
    local tableData = gameMgr:GetPlayerDataMgr():GetRechargeInfo():GetRechargeGiftBoxInfo()
    if csData == nil or tableData == nil then
        return
    end
    local isshow = false
    if (csData.continuousGiftBoxInfo.nowGroup ~= 0) then
        local count = csData.continuousGiftBoxInfo.rewardInfo.Count
        for i = 0, count - 1 do
            if (csData.continuousGiftBoxInfo.rewardInfo[i].receive == 1) then
                isshow = true
            end
        end
    end
    CS.CSScene.MainPlayerInfo.RechargeInfo.IsCanGetContinueReward = isshow
    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_ContinueReward)
    --StartCoroutine(function()
    --    print("Test")
    --    coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
    --    CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_ContinueReward)
    --end)

end
--endregion

--region ID:39016 ResLimitGiftBoxMessage 发送终身限购列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResLimitGiftBox lua table类型消息数据
---@param csData rechargeV2.ResLimitGiftBox C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    CS.CSRechargeInfoV2.LastRechargeTableList:Clear()
    local cfgRechargeTblMgr = CS.Cfg_RechargeTableManager.Instance
    if tblData.id then
        for i = 1, #tblData.id do
            local idTemp = tblData.id[i]
            local isExist, tbl = cfgRechargeTblMgr:TryGetValue(idTemp)
            if tbl then
                CS.CSRechargeInfoV2.LastRechargeTableList:Add(tbl)
            end
        end
    end
    if (tblData.isRemind == 1) then
        CS.CSScene.MainPlayerInfo.RechargeInfo.isFirstShowLastRechargeRedPoint = true
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge_LastRecharge);
        CS.CSUIRedPointManager.GetInstance():CallRedPoint(CS.RedPointKey.Recharge);
    end
end
--endregion

--region ID:39017 ResCompleteFirstChargeTimeMessage 完成首充的时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResCompleteFirstChargeTime lua table类型消息数据
---@param csData rechargeV2.ResCompleteFirstChargeTime C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetRechargeInfo():SetFirstRechargeTimestamp(tblData)
    end

end
--endregion

--region ID:39021 ResInvestPlanDataMessage 返回投资计划数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResInvestPlanData lua table类型消息数据
---@param csData rechargeV2.ResInvestPlanData C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39021] = function(msgID, tblData, csData)
    --print("返回投资计划数据",tblData,csData)
    --在此处填入预处理代码
    if tblData and gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr():RefreshAllData(tblData)
    end
end
--endregion

--region ID:39024 ResInvestPlanInfoMessage 返回某期投资计划数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResInvestPlanInfo lua table类型消息数据
---@param csData rechargeV2.ResInvestPlanInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and gameMgr:GetPlayerDataMgr() ~= nil then
        gameMgr:GetPlayerDataMgr():GetMainPlayerInvestmentMgr():RefreshSingleData(tblData)
    end
end
--endregion

--region ID:39026 ResFirstRechargeGiveMessage 返回累计充值数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResCumRechargeData lua table类型消息数据
---@param csData rechargeV2.ResCumRechargeData C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and gameMgr:GetPlayerDataMgr() then
        gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():SetAllMissionInfo(tblData)
    end
end
--endregion

--region ID:39029 ResCumChargeInfoMessage 返回某期累计充值数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResCumChargeInfo lua table类型消息数据
---@param csData rechargeV2.ResCumChargeInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39029] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and gameMgr:GetPlayerDataMgr() then
        gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():SetMissionInfoByPeriod(tblData)
    end
end
--endregion

--region ID:39032 ResIfCumRechargeUpdateMessage 返回累计充值是否更新
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.RewardState lua table类型消息数据
---@param csData rechargeV2.RewardState C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39032] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and gameMgr:GetPlayerDataMgr() then
        gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():SetRewardState(tblData.state)
    end
end
--endregion

--region ID:39034 ResCumChargeOpenMessage 检测累计充值是否开启
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.CumChargeOpen lua table类型消息数据
---@param csData rechargeV2.CumChargeOpen C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39034] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and gameMgr:GetPlayerDataMgr() then
        gameMgr:GetPlayerDataMgr():GeAccumulatedRechargeMissionMgr():SetOpenState(tblData.state)
    end
end
--endregion

--region ID:39036 ResFashionInvestMessage 返回某一类型的时装投资数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResFashionInvest lua table类型消息数据
---@param csData rechargeV2.ResFashionInvest C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39036] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():RefreshInvestTypeData(tblData)
end
--endregion

--region ID:39037 ResFashionInvestInfoMessage 返回时装投资数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.ResFashionInvestInfo lua table类型消息数据
---@param csData rechargeV2.ResFashionInvestInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39037] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetPotentialInvestInfo():RefreshData(tblData)
end
--endregion

--region ID:39039 ResRedPointFashionInvestMessage 时装投资红点包
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.RewardState lua table类型消息数据
---@param csData rechargeV2.RewardState C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[39039] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetLuaRedPointManager():CallRedPoint(gameMgr:GetLuaRedPointManager():GetLuaRedPointKey(LuaRedPointName.PotentialInvestRedPoint))
end
--endregion

--[[
--region ID:39031 ResFirstRechargeGiveMessage 返回已经领取的首冲赠送
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargeV2.FirstRechargeGive lua table类型消息数据
---@param csData rechargeV2.FirstRechargeGive C# class类型消息数据
netMsgPreprocessing[39031] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetRechargeInfo():ResFirstRechargeGiveMessage(tblData)
end
--endregion
--]]
