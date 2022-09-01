--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--welfare.xml

--region ID:27002 ResSignInfoMessage 发送签到信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData welfareV2.ResSignInfo lua table类型消息数据
---@param csData welfareV2.ResSignInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[27002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:27005 ResCdkeyRewardMessage 返回cdkey领奖结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData welfareV2.ResCdkeyReward lua table类型消息数据
---@param csData welfareV2.ResCdkeyReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[27005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:27008 ResSevenDaysInfoMessage 发送七天奖励信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData welfareV2.ResSevenDaysInfo lua table类型消息数据
---@param csData welfareV2.ResSevenDaysInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[27008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:27012 ResOnlineRewardMessage 在线奖励领取响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData welfareV2.OnlineRewardMsg lua table类型消息数据
---@param csData welfareV2.OnlineRewardMsg C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[27012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:27015 ResGetRewardHallMessage 发送奖励大厅信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData welfareV2.RewardHall lua table类型消息数据
---@param csData welfareV2.RewardHall C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[27015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:27017 ResTimmngRewardInfoMessage 定时奖励信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData welfareV2.TimingReward lua table类型消息数据
---@param csData welfareV2.TimingReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[27017] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:27020 ResLevelPacksInfoMessage 等级奖励信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData welfareV2.LevelPacksInfo lua table类型消息数据
---@param csData welfareV2.LevelPacksInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[27020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--[[
--region ID:27013 ReqOnlineLiquanMessage 每周在线礼券奖励请求
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[27013] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
