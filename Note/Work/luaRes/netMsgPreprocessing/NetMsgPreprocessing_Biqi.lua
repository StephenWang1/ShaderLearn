--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--biqi.xml

--region ID:79004 ResScoreRankMessage 发送积分排行信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData biqiV2.ResScoreRank lua table类型消息数据
---@param csData biqiV2.ResScoreRank C# class类型消息数据
netMsgPreprocessing[79004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BiqiInfoV2:ResScoreRankMessage(csData)
    end
end
--endregion

--region ID:79005 ResNixiBuffInfoMessage 发送逆袭buff信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData biqiV2.ResNixiBuffInfo lua table类型消息数据
---@param csData biqiV2.ResNixiBuffInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[79005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:79006 ResScoreRewardMessage 发送积分领奖信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData biqiV2.ResScoreReward lua table类型消息数据
---@param csData biqiV2.ResScoreReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[79006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:79007 ResRoleScoreMessage 发送玩家积分信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData biqiV2.ResRoleScore lua table类型消息数据
---@param csData biqiV2.ResRoleScore C# class类型消息数据
netMsgPreprocessing[79007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.BiqiInfoV2:ResRoleScoreMessage(csData)
end
--endregion

--region ID:79010 ResChangCampTipMessage 提示即将切换阵营
---@param msgID LuaEnumNetDef 消息ID
---@param tblData biqiV2.ResChangCampTip lua table类型消息数据
---@param csData biqiV2.ResChangCampTip C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[79010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
