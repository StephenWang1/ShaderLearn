--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--rechargegiftbox.xml

--region ID:127002 ResUpdateRechargeGiftBoxMessage 更新充值礼包信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargegiftboxV2.RechargeGiftBoxInfo lua table类型消息数据
---@param csData rechargegiftboxV2.RechargeGiftBoxInfo C# class类型消息数据
netMsgPreprocessing[127002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if gameMgr:GetPlayerDataMgr() == nil then
        return
    end
    gameMgr:GetPlayerDataMgr():GetRechargeInfo():SetRechargeGiftBoxInfo(tblData)
    for i = 0, csData.continuousGiftBoxInfo.rewardInfo.Count - 1 do
        for j = i + 1, csData.continuousGiftBoxInfo.rewardInfo.Count - 1 do
            if tonumber(csData.continuousGiftBoxInfo.rewardInfo[i].id) > tonumber(csData.continuousGiftBoxInfo.rewardInfo[j].id) then
                csData.continuousGiftBoxInfo.rewardInfo[i], csData.continuousGiftBoxInfo.rewardInfo[j] = csData.continuousGiftBoxInfo.rewardInfo[j], csData.continuousGiftBoxInfo.rewardInfo[i]
            end
        end
    end
    uiStaticParameter.CirCleDiamondList = tblData.buyTimes
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo then
        mainPlayerInfo.RechargeInfo:UpdateRewardRedPoint(csData)
    end
end
--endregion

--region ID:127004 ResReceiveOnlineGiftBoxMessage 发送领取在线礼包返回消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargegiftboxV2.RewardId lua table类型消息数据
---@param csData rechargegiftboxV2.RewardId C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[127004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:127006 ResReceiveTotalRechargeGiftBoxMessage 发送领取累充礼包返回消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargegiftboxV2.RewardId lua table类型消息数据
---@param csData rechargegiftboxV2.RewardId C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[127006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:127011 ResReceiveContinuousGiftBoxMessage 发送领取连充礼包返回消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargegiftboxV2.RewardId lua table类型消息数据
---@param csData rechargegiftboxV2.RewardId C# class类型消息数据
netMsgPreprocessing[127011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:127013 ResReceiveDailyRechargeGiftBoxMessage 发送领取每日累充礼包返回消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargegiftboxV2.RewardId lua table类型消息数据
---@param csData rechargegiftboxV2.RewardId C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[127013] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:127014 ResRoleCycleGiftBoxInfoMessage 开服循环礼包信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rechargegiftboxV2.ResRoleCycleGiftBoxInfo lua table类型消息数据
---@param csData rechargegiftboxV2.ResRoleCycleGiftBoxInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[127014] = function(msgID, tblData, csData)
    --在此处填入预处理代码

end
--endregion
