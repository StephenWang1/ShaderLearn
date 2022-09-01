--[[本文件为工具自动生成,禁止手动修改]]
--group.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回组队面板信息
---msgID: 101008
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.ResGroupDetailedInfo C#数据结构
function networkRespond.OnResGroupDetailedInfoMessageReceived(msgID)
    ---@type groupV2.ResGroupDetailedInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101008 groupV2.ResGroupDetailedInfo 返回组队面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.ResGroupDetailedInfo ~= nil then
        csData = protobufMgr.DecodeTable.group.ResGroupDetailedInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回组队请求列表界面
---msgID: 101011
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.ApplyList C#数据结构
function networkRespond.OnResApplyListMessageReceived(msgID)
    ---@type groupV2.ApplyList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101011 groupV2.ApplyList 返回组队请求列表界面")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.ApplyList ~= nil then
        csData = protobufMgr.DecodeTable.group.ApplyList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家请求附近可以申请队伍列表
---msgID: 101013
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.NearbyGroup C#数据结构
function networkRespond.OnResNearbyGroupMessageReceived(msgID)
    ---@type groupV2.NearbyGroup
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101013 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101013 groupV2.NearbyGroup 返回玩家请求附近可以申请队伍列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.NearbyGroup ~= nil then
        csData = protobufMgr.DecodeTable.group.NearbyGroup(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---玩家邀请列表响应
---msgID: 101016
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.ResInvitationList C#数据结构
function networkRespond.OnResInvitationListMessageReceived(msgID)
    ---@type groupV2.ResInvitationList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101016 groupV2.ResInvitationList 玩家邀请列表响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.ResInvitationList ~= nil then
        csData = protobufMgr.DecodeTable.group.ResInvitationList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回队伍请求邀请附近的人列表
---msgID: 101018
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.ResGroupInvitationNearbyList C#数据结构
function networkRespond.OnResGroupInvitationNearbyListMessageReceived(msgID)
    ---@type groupV2.ResGroupInvitationNearbyList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101018 groupV2.ResGroupInvitationNearbyList 返回队伍请求邀请附近的人列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.ResGroupInvitationNearbyList ~= nil then
        csData = protobufMgr.DecodeTable.group.ResGroupInvitationNearbyList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回队伍请求邀请好友列表
---msgID: 101020
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.ResGroupInvitationFriendList C#数据结构
function networkRespond.OnResGroupInvitationFriendListMessageReceived(msgID)
    ---@type groupV2.ResGroupInvitationFriendList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101020 groupV2.ResGroupInvitationFriendList 返回队伍请求邀请好友列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGroupInvitationFriendListMessage", 101020, "ResGroupInvitationFriendList", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---离开队伍响应
---msgID: 101024
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResLeaveTeamMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---消息提示
---msgID: 101025
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.MsgPrompt C#数据结构
function networkRespond.OnResApplyTeamMessageReceived(msgID)
    ---@type groupV2.MsgPrompt
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101025 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101025 groupV2.MsgPrompt 消息提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.MsgPrompt ~= nil then
        csData = protobufMgr.DecodeTable.group.MsgPrompt(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---召唤令响应
---msgID: 101030
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.TeamCallBack C#数据结构
function networkRespond.OnResCallBackMessageReceived(msgID)
    ---@type groupV2.TeamCallBack
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101030 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101030 groupV2.TeamCallBack 召唤令响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCallBackMessage", 101030, "TeamCallBack", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.TeamCallBack ~= nil then
        csData = protobufMgr.DecodeTable.group.TeamCallBack(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家是否在线及其部分消息
---msgID: 101033
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.ResHasPlayerSomeInfo C#数据结构
function networkRespond.OnResHasPlayerSomeInfoMessageReceived(msgID)
    ---@type groupV2.ResHasPlayerSomeInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101033 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101033 groupV2.ResHasPlayerSomeInfo 返回玩家是否在线及其部分消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResHasPlayerSomeInfoMessage", 101033, "ResHasPlayerSomeInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---组队玩家血量同步
---msgID: 101035
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.TeamPlayerHpInfo C#数据结构
function networkRespond.OnResTeamPlayerHpMessageReceived(msgID)
    ---@type groupV2.TeamPlayerHpInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101035 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101035 groupV2.TeamPlayerHpInfo 组队玩家血量同步")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.TeamPlayerHpInfo ~= nil then
        csData = protobufMgr.DecodeTable.group.TeamPlayerHpInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---请求组队所有玩家血量同步
---msgID: 101036
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.ResTeamAllMemHpInfo C#数据结构
function networkRespond.OnResTeamAllMemHpInfoMessageReceived(msgID)
    ---@type groupV2.ResTeamAllMemHpInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101036 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101036 groupV2.ResTeamAllMemHpInfo 请求组队所有玩家血量同步")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.group ~= nil and  protobufMgr.DecodeTable.group.ResTeamAllMemHpInfo ~= nil then
        csData = protobufMgr.DecodeTable.group.ResTeamAllMemHpInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---召唤令确认结果
---msgID: 101037
---@param msgID LuaEnumNetDef 消息ID
---@return groupV2.ResCallBack C#数据结构
function networkRespond.OnResCheckCallBackMessageReceived(msgID)
    ---@type groupV2.ResCallBack
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 101037 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 101037 groupV2.ResCallBack 召唤令确认结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCheckCallBackMessage", 101037, "ResCallBack", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

