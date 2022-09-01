--[[本文件为工具自动生成,禁止手动修改]]
--group.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回组队面板信息
---msgID: 101008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGroupDetailedInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101008 groupV2.ResGroupDetailedInfo 返回组队面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.ResGroupDetailedInfo", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustResGroupDetailedInfo ~= nil then
        protoAdjust.group_adj.AdjustResGroupDetailedInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101008
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回组队请求列表界面
---msgID: 101011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResApplyListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101011 groupV2.ApplyList 返回组队请求列表界面")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.ApplyList", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustApplyList ~= nil then
        protoAdjust.group_adj.AdjustApplyList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101011
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家请求附近可以申请队伍列表
---msgID: 101013
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNearbyGroupMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101013 groupV2.NearbyGroup 返回玩家请求附近可以申请队伍列表")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.NearbyGroup", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustNearbyGroup ~= nil then
        protoAdjust.group_adj.AdjustNearbyGroup(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101013
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家邀请列表响应
---msgID: 101016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInvitationListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101016 groupV2.ResInvitationList 玩家邀请列表响应")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.ResInvitationList", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustResInvitationList ~= nil then
        protoAdjust.group_adj.AdjustResInvitationList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101016
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回队伍请求邀请附近的人列表
---msgID: 101018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGroupInvitationNearbyListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101018 groupV2.ResGroupInvitationNearbyList 返回队伍请求邀请附近的人列表")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.ResGroupInvitationNearbyList", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustResGroupInvitationNearbyList ~= nil then
        protoAdjust.group_adj.AdjustResGroupInvitationNearbyList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101018
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回队伍请求邀请好友列表
---msgID: 101020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGroupInvitationFriendListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101020 groupV2.ResGroupInvitationFriendList 返回队伍请求邀请好友列表")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.ResGroupInvitationFriendList", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustResGroupInvitationFriendList ~= nil then
        protoAdjust.group_adj.AdjustResGroupInvitationFriendList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101020
    protobufMgr.mMsgDeserializedTblCache = res
end

---离开队伍响应
---msgID: 101024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLeaveTeamMessageReceived(msgID, buffer)
end

---消息提示
---msgID: 101025
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResApplyTeamMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101025 groupV2.MsgPrompt 消息提示")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.MsgPrompt", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustMsgPrompt ~= nil then
        protoAdjust.group_adj.AdjustMsgPrompt(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101025
    protobufMgr.mMsgDeserializedTblCache = res
end

---召唤令响应
---msgID: 101030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCallBackMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101030 groupV2.TeamCallBack 召唤令响应")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.TeamCallBack", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustTeamCallBack ~= nil then
        protoAdjust.group_adj.AdjustTeamCallBack(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101030
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家是否在线及其部分消息
---msgID: 101033
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResHasPlayerSomeInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101033 groupV2.ResHasPlayerSomeInfo 返回玩家是否在线及其部分消息")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.ResHasPlayerSomeInfo", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustResHasPlayerSomeInfo ~= nil then
        protoAdjust.group_adj.AdjustResHasPlayerSomeInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101033
    protobufMgr.mMsgDeserializedTblCache = res
end

---组队玩家血量同步
---msgID: 101035
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTeamPlayerHpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101035 groupV2.TeamPlayerHpInfo 组队玩家血量同步")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.TeamPlayerHpInfo", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustTeamPlayerHpInfo ~= nil then
        protoAdjust.group_adj.AdjustTeamPlayerHpInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101035
    protobufMgr.mMsgDeserializedTblCache = res
end

---请求组队所有玩家血量同步
---msgID: 101036
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTeamAllMemHpInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101036 groupV2.ResTeamAllMemHpInfo 请求组队所有玩家血量同步")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.ResTeamAllMemHpInfo", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustResTeamAllMemHpInfo ~= nil then
        protoAdjust.group_adj.AdjustResTeamAllMemHpInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101036
    protobufMgr.mMsgDeserializedTblCache = res
end

---召唤令确认结果
---msgID: 101037
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCheckCallBackMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 101037 groupV2.ResCallBack 召唤令确认结果")
        return nil
    end
    local res = protobufMgr.Deserialize("groupV2.ResCallBack", buffer)
    if protoAdjust.group_adj ~= nil and protoAdjust.group_adj.AdjustResCallBack ~= nil then
        protoAdjust.group_adj.AdjustResCallBack(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 101037
    protobufMgr.mMsgDeserializedTblCache = res
end

