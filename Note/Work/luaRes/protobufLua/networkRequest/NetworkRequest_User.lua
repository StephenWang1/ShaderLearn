--[[本文件为工具自动生成,禁止手动修改]]
--user.xml

--region ID:1001 请求登录
---请求登录
---msgID: 1001
---@param loginName string 必填参数 登录账户
---@param sid number 选填参数 服务器ID
---@param platformId number 选填参数 平台ID
---@param client number 选填参数 登录方式（1、网页，2、微端）
---@param IDNumber string 选填参数 身份证号码
---@param version number 选填参数 版本号
---@param qudao number 选填参数 渠道
---@param time number 选填参数 登录验证返回的时间戳
---@param sign string 选填参数 登录验证返回的 sign
---@param reconnect number 选填参数 是否重连 1:是 0: 否
---@return boolean 网络请求是否成功发送
function networkRequest.ReqLogin(loginName, sid, platformId, client, IDNumber, version, qudao, time, sign, reconnect)
    local reqTable = {}
    reqTable.loginName = loginName
    if sid ~= nil then
        reqTable.sid = sid
    end
    if platformId ~= nil then
        reqTable.platformId = platformId
    end
    if client ~= nil then
        reqTable.client = client
    end
    if IDNumber ~= nil then
        reqTable.IDNumber = IDNumber
    end
    if version ~= nil then
        reqTable.version = version
    end
    if qudao ~= nil then
        reqTable.qudao = qudao
    end
    if time ~= nil then
        reqTable.time = time
    end
    if sign ~= nil then
        reqTable.sign = sign
    end
    if reconnect ~= nil then
        reqTable.reconnect = reconnect
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ReqLogin" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqLoginMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqLoginMessage](LuaEnumNetDef.ReqLoginMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqLoginMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqLoginMessage", 1001, "ReqLogin", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1003 请求创建角色
---请求创建角色
---msgID: 1003
---@param roleName string 选填参数 角色名字
---@param sex number 选填参数 性别
---@param career number 选填参数 职业
---@param inviteCode string 选填参数 创角邀请码
---@return boolean 网络请求是否成功发送
function networkRequest.ReqCreateRole(roleName, sex, career, inviteCode)
    local reqTable = {}
    if roleName ~= nil then
        reqTable.roleName = roleName
    end
    if sex ~= nil then
        reqTable.sex = sex
    end
    if career ~= nil then
        reqTable.career = career
    end
    if inviteCode ~= nil then
        reqTable.inviteCode = inviteCode
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ReqCreateRole" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqCreateRoleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqCreateRoleMessage](LuaEnumNetDef.ReqCreateRoleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqCreateRoleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqCreateRoleMessage", 1003, "ReqCreateRole", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1004 请求随机名字
---请求随机名字
---msgID: 1004
---@param sex number 选填参数 性别
---@return boolean 网络请求是否成功发送
function networkRequest.ReqRandomName(sex)
    local reqTable = {}
    if sex ~= nil then
        reqTable.sex = sex
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ReqRandomName" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqRandomNameMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqRandomNameMessage](LuaEnumNetDef.ReqRandomNameMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqRandomNameMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqRandomNameMessage", 1004, "ReqRandomName", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1008 客户端请求进入游戏
---客户端请求进入游戏
---msgID: 1008
---@return boolean 网络请求是否成功发送
function networkRequest.ReqEnterGame()
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqEnterGameMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqEnterGameMessage](LuaEnumNetDef.ReqEnterGameMessage, nil)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsg(LuaEnumNetDef.ReqEnterGameMessage, nil, true)
    end
    return canSendMsg
end
--endregion

--region ID:1009 心跳请求
---心跳请求
---msgID: 1009
---@param clientTime number 选填参数 客户端时间
---@return boolean 网络请求是否成功发送
function networkRequest.ReqHeart(clientTime)
    local reqTable = {}
    if clientTime ~= nil then
        reqTable.clientTime = clientTime
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ReqHeart" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqHeartMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqHeartMessage](LuaEnumNetDef.ReqHeartMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqHeartMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqHeartMessage", 1009, "ReqHeart", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1012 玩家改名
---玩家改名
---msgID: 1012
---@param name string 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChangeRoleName(name)
    local reqTable = {}
    if name ~= nil then
        reqTable.name = name
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ResRoleName" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChangeRoleNameMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChangeRoleNameMessage](LuaEnumNetDef.ReqChangeRoleNameMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChangeRoleNameMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChangeRoleNameMessage", 1012, "ResRoleName", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1014 选择角色进入游戏
---选择角色进入游戏
---msgID: 1014
---@param roleId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqChooseRole(roleId)
    local reqTable = {}
    if roleId ~= nil then
        reqTable.roleId = roleId
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ReqRoleId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqChooseRoleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqChooseRoleMessage](LuaEnumNetDef.ReqChooseRoleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqChooseRoleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqChooseRoleMessage", 1014, "ReqRoleId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1015 重连进入游戏
---重连进入游戏
---msgID: 1015
---@param loginName string 选填参数 登录账户
---@param sid number 选填参数 服务器ID
---@param platformId number 选填参数 平台ID
---@param client number 选填参数 登录方式（1、网页，2、微端）
---@param version number 选填参数 版本号
---@param roleId number 选填参数
---@param time number 选填参数
---@param sign string 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqReconnect(loginName, sid, platformId, client, version, roleId, time, sign)
    local reqTable = {}
    if loginName ~= nil then
        reqTable.loginName = loginName
    end
    if sid ~= nil then
        reqTable.sid = sid
    end
    if platformId ~= nil then
        reqTable.platformId = platformId
    end
    if client ~= nil then
        reqTable.client = client
    end
    if version ~= nil then
        reqTable.version = version
    end
    if roleId ~= nil then
        reqTable.roleId = roleId
    end
    if time ~= nil then
        reqTable.time = time
    end
    if sign ~= nil then
        reqTable.sign = sign
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ReqReconnect" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqReconnectMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqReconnectMessage](LuaEnumNetDef.ReqReconnectMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqReconnectMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqReconnectMessage", 1015, "ReqReconnect", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1016 删除角色
---删除角色
---msgID: 1016
---@param roleId number 选填参数
---@return boolean 网络请求是否成功发送
function networkRequest.ReqDelRole(roleId)
    local reqTable = {}
    if roleId ~= nil then
        reqTable.roleId = roleId
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ReqRoleId" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqDelRoleMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqDelRoleMessage](LuaEnumNetDef.ReqDelRoleMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqDelRoleMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqDelRoleMessage", 1016, "ReqRoleId", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

--region ID:1021 请求邀请码验证
---请求邀请码验证
---msgID: 1021
---@param inviteCode string 选填参数 创角邀请码
---@return boolean 网络请求是否成功发送
function networkRequest.ReqInviteCodeVerify(inviteCode)
    local reqTable = {}
    if inviteCode ~= nil then
        reqTable.inviteCode = inviteCode
    end
    local reqMsgData = protobufMgr.Serialize("userV2.ReqInviteCodeVerify" , reqTable)
    local canSendMsg = true
    if netMsgPreverifying and netMsgPreverifying[LuaEnumNetDef.ReqInviteCodeVerifyMessage] then
        canSendMsg = netMsgPreverifying[LuaEnumNetDef.ReqInviteCodeVerifyMessage](LuaEnumNetDef.ReqInviteCodeVerifyMessage, reqTable)
    end
    if canSendMsg then
        CS.CSNetwork.Instance:SendMsgByteByLua(LuaEnumNetDef.ReqInviteCodeVerifyMessage, reqMsgData)
        if isOpenLog then
            luaDebug.WriteNetMsgToLog("ReqInviteCodeVerifyMessage", 1021, "ReqInviteCodeVerify", reqTable, true)
        end
    end
    return canSendMsg
end
--endregion

