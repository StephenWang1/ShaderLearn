--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--merit.xml

--region ID:122002 ResUnionBattleMessage 返回行会之争
---@param msgID LuaEnumNetDef 消息ID
---@param tblData meritV2.ResUnionBattle lua table类型消息数据
---@param csData meritV2.ResUnionBattle C# class类型消息数据
netMsgPreprocessing[122002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.RankInfoV2:RefreshOverlordUnionList(csData)
    end
end
--endregion

--region ID:122003 ResMeritRedPointMessage 霸业活动红点
---@param msgID LuaEnumNetDef 消息ID
---@param tblData meritV2.ResMeritRedPoint lua table类型消息数据
---@param csData meritV2.ResMeritRedPoint C# class类型消息数据
netMsgPreprocessing[122003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.RankInfoV2:RefreshOverlordRedPoint(csData)
    end
end
--endregion

--region ID:122004 ResLeaderGloryMessage 返回领袖之路
---@param msgID LuaEnumNetDef 消息ID
---@param tblData meritV2.ResLeaderGlory lua table类型消息数据
---@param csData meritV2.ResLeaderGlory C# class类型消息数据
netMsgPreprocessing[122004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.RankInfoV2:RefreshOverlordLeaderList(csData)
    end
end
--endregion

--region ID:122005 ResUnionAchievementMessage 返回建功立业
---@param msgID LuaEnumNetDef 消息ID
---@param tblData meritV2.ResUnionAchievement lua table类型消息数据
---@param csData meritV2.ResUnionAchievement C# class类型消息数据
netMsgPreprocessing[122005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.RankInfoV2:RefreshOverlordMeritList(csData)
    end
end
--endregion

--region ID:122009 ResReturnRewardStateMessage 领奖返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData meritV2.ResReturnRewardState lua table类型消息数据
---@param csData meritV2.ResReturnRewardState C# class类型消息数据
netMsgPreprocessing[122009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.RankInfoV2:RefreshOverlordRankRewardState(csData)
    end
end
--endregion

--region ID:122011 ResPositionInfoMessage 返回领袖之路小面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData meritV2.ResPositionInfo lua table类型消息数据
---@param csData meritV2.ResPositionInfo C# class类型消息数据
netMsgPreprocessing[122011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
