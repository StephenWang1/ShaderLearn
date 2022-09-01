--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--group.xml

--region ID:101008 ResGroupDetailedInfoMessage 返回组队面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.ResGroupDetailedInfo lua table类型消息数据
---@param csData groupV2.ResGroupDetailedInfo C# class类型消息数据
netMsgPreprocessing[101008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.GroupInfoV2:InitGroupDataInfo(csData)
end
--endregion

--region ID:101011 ResApplyListMessage 返回组队请求列表界面
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.ApplyList lua table类型消息数据
---@param csData groupV2.ApplyList C# class类型消息数据
netMsgPreprocessing[101011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.GroupInfoV2:ResApplyListMessageReceived(csData)
    uimanager:GetPanel("UIMainChatPanel").mNewInfos = 2
end
--endregion

--region ID:101013 ResNearbyGroupMessage 返回玩家请求附近可以申请队伍列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.NearbyGroup lua table类型消息数据
---@param csData groupV2.NearbyGroup C# class类型消息数据
netMsgPreprocessing[101013] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.GroupInfoV2:ResNearbyGroupMessage(csData)
end
--endregion

--region ID:101016 ResInvitationListMessage 玩家邀请列表响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.ResInvitationList lua table类型消息数据
---@param csData groupV2.ResInvitationList C# class类型消息数据
netMsgPreprocessing[101016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.GroupInfoV2:ResInvitationList(csData)
    uimanager:GetPanel("UIMainChatPanel").mNewInfos = 2
end
--endregion

--region ID:101018 ResGroupInvitationNearbyListMessage 返回队伍请求邀请附近的人列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.ResGroupInvitationNearbyList lua table类型消息数据
---@param csData groupV2.ResGroupInvitationNearbyList C# class类型消息数据
netMsgPreprocessing[101018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.GroupInfoV2:GroupInvitationNearbyListDataInfo(csData)
end
--endregion

--region ID:101020 ResGroupInvitationFriendListMessage 返回队伍请求邀请好友列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.ResGroupInvitationFriendList lua table类型消息数据
---@param csData groupV2.ResGroupInvitationFriendList C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[101020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:101024 ResLeaveTeamMessage 离开队伍响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[101024] = function(msgID, tblData, csData)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        --在此处填入预处理代码
        CS.CSScene.MainPlayerInfo.GroupInfoV2:QuitTeam();
        CS.CSScene.MainPlayerInfo.GroupInfoV2:ClearCacheAll();
    end
end
--endregion

--region ID:101025 ResApplyTeamMessage 消息提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.MsgPrompt lua table类型消息数据
---@param csData groupV2.MsgPrompt C# class类型消息数据
netMsgPreprocessing[101025] = function(msgID, tblData, csData)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        --在此处填入预处理代码
        CS.CSScene.MainPlayerInfo.GroupInfoV2:ResApplyTeamMessage(csData)
        uimanager:GetPanel("UIMainChatPanel").mNewInfos = 2
    end
end
--endregion

--region ID:101030 ResCallBackMessage 召唤令响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.TeamCallBack lua table类型消息数据
---@param csData groupV2.TeamCallBack C# class类型消息数据
netMsgPreprocessing[101030] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.LuaGroupManager:DealCallBackMessage(msgID, tblData, csData)
end
--endregion

--region ID:101033 ResHasPlayerSomeInfoMessage 返回玩家是否在线及其部分消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.ResHasPlayerSomeInfo lua table类型消息数据
---@param csData groupV2.ResHasPlayerSomeInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[101033] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:101035 ResTeamPlayerHpMessage 组队玩家血量同步
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.TeamPlayerHpInfo lua table类型消息数据
---@param csData groupV2.TeamPlayerHpInfo C# class类型消息数据
netMsgPreprocessing[101035] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.GroupInfoV2:UpdateTeamPlayerHpInfo(csData);
    end
end
--endregion

--region ID:101036 ResTeamAllMemHpInfoMessage 请求组队所有玩家血量同步
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.ResTeamAllMemHpInfo lua table类型消息数据
---@param csData groupV2.ResTeamAllMemHpInfo C# class类型消息数据
netMsgPreprocessing[101036] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.GroupInfoV2:UpdateTeamAllPlayerHpInfo(csData);
end
--endregion

--region ID:101037 ResCheckCallBackMessage 召唤令确认结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData groupV2.ResCallBack lua table类型消息数据
---@param csData groupV2.ResCallBack C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[101037] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
