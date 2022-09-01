--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--official.xml

--region ID:56001 ResOfficialInfoMessage 发送官职界面信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData officialV2.ResOfficialInfo lua table类型消息数据
---@param csData officialV2.ResOfficialInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[56001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:56003 ResOfficialUpMessage 返回官职晋升结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData officialV2.ResOfficialUp lua table类型消息数据
---@param csData officialV2.ResOfficialUp C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[56003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:56005 ResDrawDailyActiveRewardMessage 返回领取日活奖励结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData officialV2.ResDrawDailyActiveReward lua table类型消息数据
---@param csData officialV2.ResDrawDailyActiveReward C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[56005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:56011 ResOfficialInfoV2Message 同步官职和虎符信息,上线和变化都是这一条
---@param msgID LuaEnumNetDef 消息ID
---@param tblData officialV2.ResOfficialInfoV2 lua table类型消息数据
---@param csData officialV2.ResOfficialInfoV2 C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[56011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetPlayerOfficialInfo():SetOfficialInfo(tblData)
    gameMgr:GetLuaRedPointManager():CallRedPointKey(LuaRedPointName.OfficialState)
end
--endregion

--[[
--region ID:56013 ReqOfficialEmperorTokenActivateV2Message 激活虎符
---@param msgID LuaEnumNetDef 消息ID
---@param tblData officialV2.ReqOfficialEmperorTokenActivateV2 lua table类型消息数据
---@param csData officialV2.ReqOfficialEmperorTokenActivateV2 C# class类型消息数据
netMsgPreprocessing[56013] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
