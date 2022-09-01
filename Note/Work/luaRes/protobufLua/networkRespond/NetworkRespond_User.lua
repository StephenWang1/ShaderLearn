--[[本文件为工具自动生成,禁止手动修改]]
--user.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---告知客户端需要创建角色
---msgID: 1002
---@param msgID LuaEnumNetDef 消息ID
---@return userV2.ResCreateRole C#数据结构
function networkRespond.OnResCreateRoleMessageReceived(msgID)
    ---@type userV2.ResCreateRole
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1002 userV2.ResCreateRole 告知客户端需要创建角色")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCreateRoleMessage", 1002, "ResCreateRole", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.user ~= nil and  protobufMgr.DecodeTable.user.ResCreateRole ~= nil then
        csData = protobufMgr.DecodeTable.user.ResCreateRole(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---告知随机名字
---msgID: 1005
---@param msgID LuaEnumNetDef 消息ID
---@return userV2.ResRandomName C#数据结构
function networkRespond.OnResRandomNameMessageReceived(msgID)
    ---@type userV2.ResRandomName
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1005 userV2.ResRandomName 告知随机名字")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.user ~= nil and  protobufMgr.DecodeTable.user.ResRandomName ~= nil then
        csData = protobufMgr.DecodeTable.user.ResRandomName(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---告知客户端进入游戏
---msgID: 1006
---@param msgID LuaEnumNetDef 消息ID
---@return userV2.ResEnterGame C#数据结构
function networkRespond.OnResEnterGameMessageReceived(msgID)
    ---@type userV2.ResEnterGame
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1006 userV2.ResEnterGame 告知客户端进入游戏")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.user ~= nil and  protobufMgr.DecodeTable.user.ResEnterGame ~= nil then
        csData = protobufMgr.DecodeTable.user.ResEnterGame(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---通知登录成功
---msgID: 1007
---@param msgID LuaEnumNetDef 消息ID
---@return userV2.ResLogin C#数据结构
function networkRespond.OnResLoginMessageReceived(msgID)
    ---@type userV2.ResLogin
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1007 userV2.ResLogin 通知登录成功")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.user ~= nil and  protobufMgr.DecodeTable.user.ResLogin ~= nil then
        csData = protobufMgr.DecodeTable.user.ResLogin(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---心跳返回
---msgID: 1010
---@param msgID LuaEnumNetDef 消息ID
---@return userV2.ResHeart C#数据结构
function networkRespond.OnResHeartMessageReceived(msgID)
    ---@type userV2.ResHeart
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1010 userV2.ResHeart 心跳返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResHeartMessage", 1010, "ResHeart", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回登陆前信息
---msgID: 1019
---@param msgID LuaEnumNetDef 消息ID
---@return userV2.ResAfterLoginInfo C#数据结构
function networkRespond.OnResAfterLoginInfoMessageReceived(msgID)
    ---@type userV2.ResAfterLoginInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1019 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1019 userV2.ResAfterLoginInfo 返回登陆前信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---C#中对消息结构引用到的某个类型的字段未实现,故需要打印出lua的网络日志
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAfterLoginInfoMessage", 1019, "ResAfterLoginInfo", tblData)
    end
    local csData
    if protobufMgr.DecodeTable.user ~= nil and  protobufMgr.DecodeTable.user.ResAfterLoginInfo ~= nil then
        csData = protobufMgr.DecodeTable.user.ResAfterLoginInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---资源重载或强制下线
---msgID: 1020
---@param msgID LuaEnumNetDef 消息ID
---@return userV2.ForceRoleReload C#数据结构
function networkRespond.OnResForceRoleReloadMessageReceived(msgID)
    ---@type userV2.ForceRoleReload
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1020 userV2.ForceRoleReload 资源重载或强制下线")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResForceRoleReloadMessage", 1020, "ForceRoleReload", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---邀请码验证应答
---msgID: 1022
---@param msgID LuaEnumNetDef 消息ID
---@return userV2.ResInviteCodeVerify C#数据结构
function networkRespond.OnResInviteCodeVerifyMessageReceived(msgID)
    ---@type userV2.ResInviteCodeVerify
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1022 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1022 userV2.ResInviteCodeVerify 邀请码验证应答")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResInviteCodeVerifyMessage", 1022, "ResInviteCodeVerify", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

