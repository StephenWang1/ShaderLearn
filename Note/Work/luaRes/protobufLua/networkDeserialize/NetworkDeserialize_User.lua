--[[本文件为工具自动生成,禁止手动修改]]
--user.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---告知客户端需要创建角色
---msgID: 1002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCreateRoleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1002 userV2.ResCreateRole 告知客户端需要创建角色")
        return nil
    end
    local res = protobufMgr.Deserialize("userV2.ResCreateRole", buffer)
    if protoAdjust.user_adj ~= nil and protoAdjust.user_adj.AdjustResCreateRole ~= nil then
        protoAdjust.user_adj.AdjustResCreateRole(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1002
    protobufMgr.mMsgDeserializedTblCache = res
end

---告知随机名字
---msgID: 1005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRandomNameMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1005 userV2.ResRandomName 告知随机名字")
        return nil
    end
    local res = protobufMgr.Deserialize("userV2.ResRandomName", buffer)
    if protoAdjust.user_adj ~= nil and protoAdjust.user_adj.AdjustResRandomName ~= nil then
        protoAdjust.user_adj.AdjustResRandomName(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1005
    protobufMgr.mMsgDeserializedTblCache = res
end

---告知客户端进入游戏
---msgID: 1006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEnterGameMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1006 userV2.ResEnterGame 告知客户端进入游戏")
        return nil
    end
    local res = protobufMgr.Deserialize("userV2.ResEnterGame", buffer)
    if protoAdjust.user_adj ~= nil and protoAdjust.user_adj.AdjustResEnterGame ~= nil then
        protoAdjust.user_adj.AdjustResEnterGame(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1006
    protobufMgr.mMsgDeserializedTblCache = res
end

---通知登录成功
---msgID: 1007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLoginMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1007 userV2.ResLogin 通知登录成功")
        return nil
    end
    local res = protobufMgr.Deserialize("userV2.ResLogin", buffer)
    if protoAdjust.user_adj ~= nil and protoAdjust.user_adj.AdjustResLogin ~= nil then
        protoAdjust.user_adj.AdjustResLogin(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1007
    protobufMgr.mMsgDeserializedTblCache = res
end

---心跳返回
---msgID: 1010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResHeartMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1010 userV2.ResHeart 心跳返回")
        return nil
    end
    local res = protobufMgr.Deserialize("userV2.ResHeart", buffer)
    if protoAdjust.user_adj ~= nil and protoAdjust.user_adj.AdjustResHeart ~= nil then
        protoAdjust.user_adj.AdjustResHeart(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1010
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回登陆前信息
---msgID: 1019
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAfterLoginInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1019 userV2.ResAfterLoginInfo 返回登陆前信息")
        return nil
    end
    local res = protobufMgr.Deserialize("userV2.ResAfterLoginInfo", buffer)
    if protoAdjust.user_adj ~= nil and protoAdjust.user_adj.AdjustResAfterLoginInfo ~= nil then
        protoAdjust.user_adj.AdjustResAfterLoginInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1019
    protobufMgr.mMsgDeserializedTblCache = res
end

---资源重载或强制下线
---msgID: 1020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResForceRoleReloadMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1020 userV2.ForceRoleReload 资源重载或强制下线")
        return nil
    end
    local res = protobufMgr.Deserialize("userV2.ForceRoleReload", buffer)
    if protoAdjust.user_adj ~= nil and protoAdjust.user_adj.AdjustForceRoleReload ~= nil then
        protoAdjust.user_adj.AdjustForceRoleReload(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1020
    protobufMgr.mMsgDeserializedTblCache = res
end

---邀请码验证应答
---msgID: 1022
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInviteCodeVerifyMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1022 userV2.ResInviteCodeVerify 邀请码验证应答")
        return nil
    end
    local res = protobufMgr.Deserialize("userV2.ResInviteCodeVerify", buffer)
    if protoAdjust.user_adj ~= nil and protoAdjust.user_adj.AdjustResInviteCodeVerify ~= nil then
        protoAdjust.user_adj.AdjustResInviteCodeVerify(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1022
    protobufMgr.mMsgDeserializedTblCache = res
end

