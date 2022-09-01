--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--sharegroup.xml

--region ID:1001008 ResShareGroupDetailedInfoMessage 返回组队面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.ResGroupDetailedInfo lua table类型消息数据
---@param csData shareGroupV2.ResGroupDetailedInfo C# class类型消息数据
netMsgPreprocessing[1001008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local dataTemp = protobufMgr.DecodeTable.group.ResGroupDetailedInfo(tblData)
    CS.CSScene.MainPlayerInfo.GroupInfoV2:InitGroupDataInfo(dataTemp)
end
--endregion

--region ID:1001011 ResShareApplyListMessage 返回组队请求列表界面
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.ApplyList lua table类型消息数据
---@param csData shareGroupV2.ApplyList C# class类型消息数据
netMsgPreprocessing[1001011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local dataTemp = protobufMgr.DecodeTable.group.ApplyList(tblData)
    CS.CSScene.MainPlayerInfo.GroupInfoV2:ResApplyListMessageReceived(dataTemp)
    uimanager:GetPanel("UIMainChatPanel").mNewInfos = 2
end
--endregion

--region ID:1001013 ResNearbyGroupMessage 返回玩家请求附近可以申请队伍列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.NearbyGroup lua table类型消息数据
---@param csData shareGroupV2.NearbyGroup C# class类型消息数据
netMsgPreprocessing[1001013] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local dataTemp = protobufMgr.DecodeTable.group.NearbyGroup(tblData)
    CS.CSScene.MainPlayerInfo.GroupInfoV2:ResNearbyGroupMessage(dataTemp)
end
--endregion

--region ID:1001016 ResInvitationListMessage 玩家邀请列表响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.ResInvitationList lua table类型消息数据
---@param csData shareGroupV2.ResInvitationList C# class类型消息数据
netMsgPreprocessing[1001016] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local dataTemp = protobufMgr.DecodeTable.group.ResInvitationList(tblData)
    CS.CSScene.MainPlayerInfo.GroupInfoV2:ResInvitationList(dataTemp)
    uimanager:GetPanel("UIMainChatPanel").mNewInfos = 2
end
--endregion

--region ID:1001018 ResGroupInvitationNearbyListMessage 返回队伍请求邀请附近的人列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.ResGroupInvitationNearbyList lua table类型消息数据
---@param csData shareGroupV2.ResGroupInvitationNearbyList C# class类型消息数据
netMsgPreprocessing[1001018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local dataTemp = protobufMgr.DecodeTable.group.ResGroupInvitationNearbyList(tblData)
    CS.CSScene.MainPlayerInfo.GroupInfoV2:GroupInvitationNearbyListDataInfo(dataTemp)
end
--endregion

--region ID:1001020 ResGroupInvitationFriendListMessage 返回队伍请求邀请好友列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.ResGroupInvitationFriendList lua table类型消息数据
---@param csData shareGroupV2.ResGroupInvitationFriendList C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1001020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:1001024 ResLeaveTeamMessage 离开队伍响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[1001024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        --在此处填入预处理代码
        CS.CSScene.MainPlayerInfo.GroupInfoV2:QuitTeam();
    end
end
--endregion

--region ID:1001025 ResApplyTeamMessage 消息提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.MsgPrompt lua table类型消息数据
---@param csData shareGroupV2.MsgPrompt C# class类型消息数据
netMsgPreprocessing[1001025] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local dataTemp = protobufMgr.DecodeTable.group.MsgPrompt(tblData)
        CS.CSScene.MainPlayerInfo.GroupInfoV2:ResApplyTeamMessage(dataTemp)
        uimanager:GetPanel("UIMainChatPanel").mNewInfos = 2
    end
end
--endregion

--region ID:1001030 ResCallBackMessage 召唤令响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.TeamCallBack lua table类型消息数据
---@param csData shareGroupV2.TeamCallBack C# class类型消息数据
netMsgPreprocessing[1001030] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.LuaGroupManager:DealCallBackMessage(msgID, tblData, csData)
end
--endregion

--region ID:1001033 ResShareHasPlayerSomeInfoMessage 返回玩家是否在线及其部分消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.ResHasPlayerSomeInfo lua table类型消息数据
---@param csData shareGroupV2.ResHasPlayerSomeInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1001033] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:1001035 ResTeamPlayerHpMessage 组队玩家血量同步
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.TeamPlayerHpInfo lua table类型消息数据
---@param csData shareGroupV2.TeamPlayerHpInfo C# class类型消息数据
netMsgPreprocessing[1001035] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo ~= nil then
        local dataTemp = protobufMgr.DecodeTable.group.TeamPlayerHpInfo(tblData)
        CS.CSScene.MainPlayerInfo.GroupInfoV2:UpdateTeamPlayerHpInfo(dataTemp);
    end
end
--endregion

--region ID:1001036 ResTeamAllMemHpInfoMessage 请求组队所有玩家血量同步
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.ResTeamAllMemHpInfo lua table类型消息数据
---@param csData shareGroupV2.ResTeamAllMemHpInfo C# class类型消息数据
netMsgPreprocessing[1001036] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    local dataTemp = protobufMgr.DecodeTable.group.ResTeamAllMemHpInfo(tblData)
    CS.CSScene.MainPlayerInfo.GroupInfoV2:UpdateTeamAllPlayerHpInfo(dataTemp);
end
--endregion

--region ID:1001037 ResCheckCallBackMessage 召唤令确认结果
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareGroupV2.ResCallBack lua table类型消息数据
---@param csData shareGroupV2.ResCallBack C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1001037] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
