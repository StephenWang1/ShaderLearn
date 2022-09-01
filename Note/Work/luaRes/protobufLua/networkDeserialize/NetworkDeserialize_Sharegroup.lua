--[[本文件为工具自动生成,禁止手动修改]]
--sharegroup.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回组队面板信息
---msgID: 1001008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareGroupDetailedInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001008 shareGroupV2.ResGroupDetailedInfo 返回组队面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.ResGroupDetailedInfo", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustResGroupDetailedInfo ~= nil then
        protoAdjust.sharegroup_adj.AdjustResGroupDetailedInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001008
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回组队请求列表界面
---msgID: 1001011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareApplyListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001011 shareGroupV2.ApplyList 返回组队请求列表界面")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.ApplyList", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustApplyList ~= nil then
        protoAdjust.sharegroup_adj.AdjustApplyList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001011
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家请求附近可以申请队伍列表
---msgID: 1001013
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareNearbyGroupMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001013 shareGroupV2.NearbyGroup 返回玩家请求附近可以申请队伍列表")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.NearbyGroup", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustNearbyGroup ~= nil then
        protoAdjust.sharegroup_adj.AdjustNearbyGroup(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001013
    protobufMgr.mMsgDeserializedTblCache = res
end

---玩家邀请列表响应
---msgID: 1001016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareInvitationListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001016 shareGroupV2.ResInvitationList 玩家邀请列表响应")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.ResInvitationList", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustResInvitationList ~= nil then
        protoAdjust.sharegroup_adj.AdjustResInvitationList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001016
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回队伍请求邀请附近的人列表
---msgID: 1001018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareGroupInvitationNearbyListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001018 shareGroupV2.ResGroupInvitationNearbyList 返回队伍请求邀请附近的人列表")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.ResGroupInvitationNearbyList", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustResGroupInvitationNearbyList ~= nil then
        protoAdjust.sharegroup_adj.AdjustResGroupInvitationNearbyList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001018
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回队伍请求邀请好友列表
---msgID: 1001020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareGroupInvitationFriendListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001020 shareGroupV2.ResGroupInvitationFriendList 返回队伍请求邀请好友列表")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.ResGroupInvitationFriendList", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustResGroupInvitationFriendList ~= nil then
        protoAdjust.sharegroup_adj.AdjustResGroupInvitationFriendList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001020
    protobufMgr.mMsgDeserializedTblCache = res
end

---离开队伍响应
---msgID: 1001024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareLeaveTeamMessageReceived(msgID, buffer)
end

---消息提示
---msgID: 1001025
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareApplyTeamMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001025 shareGroupV2.MsgPrompt 消息提示")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.MsgPrompt", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustMsgPrompt ~= nil then
        protoAdjust.sharegroup_adj.AdjustMsgPrompt(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001025
    protobufMgr.mMsgDeserializedTblCache = res
end

---召唤令响应
---msgID: 1001030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareCallBackMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001030 shareGroupV2.TeamCallBack 召唤令响应")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.TeamCallBack", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustTeamCallBack ~= nil then
        protoAdjust.sharegroup_adj.AdjustTeamCallBack(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001030
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家是否在线及其部分消息
---msgID: 1001033
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareHasPlayerSomeInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001033 shareGroupV2.ResHasPlayerSomeInfo 返回玩家是否在线及其部分消息")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.ResHasPlayerSomeInfo", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustResHasPlayerSomeInfo ~= nil then
        protoAdjust.sharegroup_adj.AdjustResHasPlayerSomeInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001033
    protobufMgr.mMsgDeserializedTblCache = res
end

---组队玩家血量同步
---msgID: 1001035
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareTeamPlayerHpMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001035 shareGroupV2.TeamPlayerHpInfo 组队玩家血量同步")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.TeamPlayerHpInfo", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustTeamPlayerHpInfo ~= nil then
        protoAdjust.sharegroup_adj.AdjustTeamPlayerHpInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001035
    protobufMgr.mMsgDeserializedTblCache = res
end

---请求组队所有玩家血量同步
---msgID: 1001036
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareTeamAllMemHpInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001036 shareGroupV2.ResTeamAllMemHpInfo 请求组队所有玩家血量同步")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.ResTeamAllMemHpInfo", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustResTeamAllMemHpInfo ~= nil then
        protoAdjust.sharegroup_adj.AdjustResTeamAllMemHpInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001036
    protobufMgr.mMsgDeserializedTblCache = res
end

---召唤令确认结果
---msgID: 1001037
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResShareCheckCallBackMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1001037 shareGroupV2.ResCallBack 召唤令确认结果")
        return nil
    end
    local res = protobufMgr.Deserialize("shareGroupV2.ResCallBack", buffer)
    if protoAdjust.sharegroup_adj ~= nil and protoAdjust.sharegroup_adj.AdjustResCallBack ~= nil then
        protoAdjust.sharegroup_adj.AdjustResCallBack(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1001037
    protobufMgr.mMsgDeserializedTblCache = res
end

