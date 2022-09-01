--[[本文件为工具自动生成,禁止手动修改]]
--sharegroup.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回组队面板信息
---msgID: 1001008
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.ResGroupDetailedInfo C#数据结构
function networkRespond.OnResShareGroupDetailedInfoMessageReceived(msgID)
    ---@type shareGroupV2.ResGroupDetailedInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001008 shareGroupV2.ResGroupDetailedInfo 返回组队面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareGroupDetailedInfoMessage", 1001008, "ResGroupDetailedInfo", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.ResGroupDetailedInfo ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.ResGroupDetailedInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回组队请求列表界面
---msgID: 1001011
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.ApplyList C#数据结构
function networkRespond.OnResShareApplyListMessageReceived(msgID)
    ---@type shareGroupV2.ApplyList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001011 shareGroupV2.ApplyList 返回组队请求列表界面")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareApplyListMessage", 1001011, "ApplyList", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.ApplyList ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.ApplyList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家请求附近可以申请队伍列表
---msgID: 1001013
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.NearbyGroup C#数据结构
function networkRespond.OnResShareNearbyGroupMessageReceived(msgID)
    ---@type shareGroupV2.NearbyGroup
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001013 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001013 shareGroupV2.NearbyGroup 返回玩家请求附近可以申请队伍列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareNearbyGroupMessage", 1001013, "NearbyGroup", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.NearbyGroup ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.NearbyGroup(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---玩家邀请列表响应
---msgID: 1001016
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.ResInvitationList C#数据结构
function networkRespond.OnResShareInvitationListMessageReceived(msgID)
    ---@type shareGroupV2.ResInvitationList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001016 shareGroupV2.ResInvitationList 玩家邀请列表响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareInvitationListMessage", 1001016, "ResInvitationList", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.ResInvitationList ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.ResInvitationList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回队伍请求邀请附近的人列表
---msgID: 1001018
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.ResGroupInvitationNearbyList C#数据结构
function networkRespond.OnResShareGroupInvitationNearbyListMessageReceived(msgID)
    ---@type shareGroupV2.ResGroupInvitationNearbyList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001018 shareGroupV2.ResGroupInvitationNearbyList 返回队伍请求邀请附近的人列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareGroupInvitationNearbyListMessage", 1001018, "ResGroupInvitationNearbyList", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.ResGroupInvitationNearbyList ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.ResGroupInvitationNearbyList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回队伍请求邀请好友列表
---msgID: 1001020
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.ResGroupInvitationFriendList C#数据结构
function networkRespond.OnResShareGroupInvitationFriendListMessageReceived(msgID)
    ---@type shareGroupV2.ResGroupInvitationFriendList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001020 shareGroupV2.ResGroupInvitationFriendList 返回队伍请求邀请好友列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareGroupInvitationFriendListMessage", 1001020, "ResGroupInvitationFriendList", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---离开队伍响应
---msgID: 1001024
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResShareLeaveTeamMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---消息提示
---msgID: 1001025
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.MsgPrompt C#数据结构
function networkRespond.OnResShareApplyTeamMessageReceived(msgID)
    ---@type shareGroupV2.MsgPrompt
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001025 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001025 shareGroupV2.MsgPrompt 消息提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareApplyTeamMessage", 1001025, "MsgPrompt", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.MsgPrompt ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.MsgPrompt(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---召唤令响应
---msgID: 1001030
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.TeamCallBack C#数据结构
function networkRespond.OnResShareCallBackMessageReceived(msgID)
    ---@type shareGroupV2.TeamCallBack
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001030 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001030 shareGroupV2.TeamCallBack 召唤令响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareCallBackMessage", 1001030, "TeamCallBack", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.TeamCallBack ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.TeamCallBack(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家是否在线及其部分消息
---msgID: 1001033
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.ResHasPlayerSomeInfo C#数据结构
function networkRespond.OnResShareHasPlayerSomeInfoMessageReceived(msgID)
    ---@type shareGroupV2.ResHasPlayerSomeInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001033 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001033 shareGroupV2.ResHasPlayerSomeInfo 返回玩家是否在线及其部分消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareHasPlayerSomeInfoMessage", 1001033, "ResHasPlayerSomeInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---组队玩家血量同步
---msgID: 1001035
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.TeamPlayerHpInfo C#数据结构
function networkRespond.OnResShareTeamPlayerHpMessageReceived(msgID)
    ---@type shareGroupV2.TeamPlayerHpInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001035 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001035 shareGroupV2.TeamPlayerHpInfo 组队玩家血量同步")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareTeamPlayerHpMessage", 1001035, "TeamPlayerHpInfo", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.TeamPlayerHpInfo ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.TeamPlayerHpInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---请求组队所有玩家血量同步
---msgID: 1001036
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.ResTeamAllMemHpInfo C#数据结构
function networkRespond.OnResShareTeamAllMemHpInfoMessageReceived(msgID)
    ---@type shareGroupV2.ResTeamAllMemHpInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001036 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001036 shareGroupV2.ResTeamAllMemHpInfo 请求组队所有玩家血量同步")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareTeamAllMemHpInfoMessage", 1001036, "ResTeamAllMemHpInfo", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.sharegroup ~= nil and  protobufMgr.DecodeTable.sharegroup.ResTeamAllMemHpInfo ~= nil then
        csData = protobufMgr.DecodeTable.sharegroup.ResTeamAllMemHpInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---召唤令确认结果
---msgID: 1001037
---@param msgID LuaEnumNetDef 消息ID
---@return shareGroupV2.ResCallBack C#数据结构
function networkRespond.OnResShareCheckCallBackMessageReceived(msgID)
    ---@type shareGroupV2.ResCallBack
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1001037 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1001037 shareGroupV2.ResCallBack 召唤令确认结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareCheckCallBackMessage", 1001037, "ResCallBack", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

