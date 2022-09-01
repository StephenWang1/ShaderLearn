--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--activities.xml

--region ID:128001 ResAllOpenActivitiesMessage 返回所有打开的活动奖励
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activitiesV2.AllActivitiesOpenInfo lua table类型消息数据
---@param csData activitiesV2.AllActivitiesOpenInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[128001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetSpecialActivityData():SaveActivityData(tblData)
end
--endregion

--region ID:128003 ResOneActivitiesInfoMessage 返回某类的活动信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activitiesV2.ResOneActivitiesInfo lua table类型消息数据
---@param csData activitiesV2.ResOneActivitiesInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[128003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData == nil or tblData.type == nil then
        return
    end
    gameMgr:GetPlayerDataMgr():GetSpecialActivityData():SaveSingleActivityData(tblData.type, tblData)
end
--endregion

--region ID:128005 ResGetOneActivitiesAwardMessage 返回领取活动奖励
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activitiesV2.ResAwardActivitiesInfo lua table类型消息数据
---@param csData activitiesV2.ResAwardActivitiesInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[128005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:128006 ResActivitiesOpenInfoMessage 返回某类活动的开启关闭信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activitiesV2.OneActivitiesInfo lua table类型消息数据
---@param csData activitiesV2.OneActivitiesInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[128006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetSpecialActivityData():ChangeActivityOpenState(tblData.configId, tblData.openStatus == 1)
end
--endregion

--region ID:128007 ResSubTypeActivitiesInfoMessage 返回某类的活动信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activitiesV2.OneActivitiesInfo lua table类型消息数据
---@param csData activitiesV2.OneActivitiesInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[128007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetSpecialActivityData():ChangeSingleActivityInfo(tblData)
end
--endregion

--region ID:128009 ResSunActivitiesPanelMessage 返回白日门活动面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activitiesV2.ResSunActivitiesPanel lua table类型消息数据
---@param csData activitiesV2.ResSunActivitiesPanel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[128009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:128010 ResActivitiesPartInfoMessage 返回活动的部分变动信息.
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activitiesV2.ActivitiesPartInfo lua table类型消息数据
---@param csData activitiesV2.ActivitiesPartInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[128010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetSpecialActivityData():ChangeExtData(tblData)


end
--endregion

--region ID:128011 ResKickOutTimeMessage 同步客户端一个踢人的时间
---@param msgID LuaEnumNetDef 消息ID
---@param tblData activitiesV2.ResKickOutTime lua table类型消息数据
---@param csData activitiesV2.ResKickOutTime C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[128011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.ActivityEndCountDownData:PushCountDown(LuaEnumCountDownEndType.DarkPalaceActivityEnd, tblData)
end
--endregion
