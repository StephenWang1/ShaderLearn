--[[本文件为工具自动生成,禁止手动修改]]
--role.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---通知属性发生变化
---msgID: 8001
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResPlayerAttributeChange C#数据结构
function networkRespond.OnResPlayerAttributeChangeMessageReceived(msgID)
    ---@type roleV2.ResPlayerAttributeChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8001 roleV2.ResPlayerAttributeChange 通知属性发生变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResPlayerAttributeChange ~= nil then
        csData = protobufMgr.DecodeTable.role.ResPlayerAttributeChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---通知玩家经验发生变化
---msgID: 8003
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResPlayerExpChange C#数据结构
function networkRespond.OnResPlayerExpChangeMessageReceived(msgID)
    ---@type roleV2.ResPlayerExpChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8003 roleV2.ResPlayerExpChange 通知玩家经验发生变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResPlayerExpChange ~= nil then
        csData = protobufMgr.DecodeTable.role.ResPlayerExpChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---通知玩家等级发生变化
---msgID: 8004
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResPlayerLevelChange C#数据结构
function networkRespond.OnResPlayerLevelChangeMessageReceived(msgID)
    ---@type roleV2.ResPlayerLevelChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8004 roleV2.ResPlayerLevelChange 通知玩家等级发生变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResPlayerLevelChange ~= nil then
        csData = protobufMgr.DecodeTable.role.ResPlayerLevelChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送角色转生信息
---msgID: 8007
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResSendRoleReinInfo C#数据结构
function networkRespond.OnResSendRoleReinInfoMessageReceived(msgID)
    ---@type roleV2.ResSendRoleReinInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8007 roleV2.ResSendRoleReinInfo 发送角色转生信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResSendRoleReinInfo ~= nil then
        csData = protobufMgr.DecodeTable.role.ResSendRoleReinInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送角色兑换修为结果
---msgID: 8010
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRoleExchangeReinResult C#数据结构
function networkRespond.OnResRoleExchangeReinResultMessageReceived(msgID)
    ---@type roleV2.ResRoleExchangeReinResult
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8010 roleV2.ResRoleExchangeReinResult 发送角色兑换修为结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResRoleExchangeReinResult ~= nil then
        csData = protobufMgr.DecodeTable.role.ResRoleExchangeReinResult(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送总战斗力
---msgID: 8011
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResTotalFightValueChange C#数据结构
function networkRespond.OnResTotalFightValueChangeMessageReceived(msgID)
    ---@type roleV2.ResTotalFightValueChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8011 roleV2.ResTotalFightValueChange 发送总战斗力")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResTotalFightValueChange ~= nil then
        csData = protobufMgr.DecodeTable.role.ResTotalFightValueChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送内功信息
---msgID: 8027
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResSendInnerPowerInfo C#数据结构
function networkRespond.OnResSendInnerPowerInfoMessageReceived(msgID)
    ---@type roleV2.ResSendInnerPowerInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8027 roleV2.ResSendInnerPowerInfo 发送内功信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResSendInnerPowerInfo ~= nil then
        csData = protobufMgr.DecodeTable.role.ResSendInnerPowerInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---内功信息变化
---msgID: 8029
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResInnerPowerInfoChange C#数据结构
function networkRespond.OnResInnerPowerInfoChangeMessageReceived(msgID)
    ---@type roleV2.ResInnerPowerInfoChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8029 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8029 roleV2.ResInnerPowerInfoChange 内功信息变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResInnerPowerInfoChange ~= nil then
        csData = protobufMgr.DecodeTable.role.ResInnerPowerInfoChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---查看其他玩家信息响应
---msgID: 8036
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.RoleToOtherInfo C#数据结构
function networkRespond.OnResOtherRoleInfoMessageReceived(msgID)
    ---@type roleV2.RoleToOtherInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8036 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8036 roleV2.RoleToOtherInfo 查看其他玩家信息响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.RoleToOtherInfo ~= nil then
        csData = protobufMgr.DecodeTable.role.RoleToOtherInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---转生成功
---msgID: 8044
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRoleReinSuccess C#数据结构
function networkRespond.OnResRoleReinSuccessReceived(msgID)
    ---@type roleV2.ResRoleReinSuccess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8044 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8044 roleV2.ResRoleReinSuccess 转生成功")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleReinSuccess", 8044, "ResRoleReinSuccess", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---系统开启提醒
---msgID: 8045
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.SystemOpenReminder C#数据结构
function networkRespond.OnSystemOpenReminderMessageReceived(msgID)
    ---@type roleV2.SystemOpenReminder
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8045 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8045 roleV2.SystemOpenReminder 系统开启提醒")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.SystemOpenReminder ~= nil then
        csData = protobufMgr.DecodeTable.role.SystemOpenReminder(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---打开快捷栏
---msgID: 8046
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResOpenKeySettingPanelMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---在线增加泡点经验消息
---msgID: 8047
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResBubbleOnlineExp C#数据结构
function networkRespond.OnResBubbleOnlineExpMessageReceived(msgID)
    ---@type roleV2.ResBubbleOnlineExp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8047 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8047 roleV2.ResBubbleOnlineExp 在线增加泡点经验消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBubbleOnlineExpMessage", 8047, "ResBubbleOnlineExp", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---泡点结束消息
---msgID: 8048
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResOverBubblePointMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---返回泡点离线经验消息
---msgID: 8049
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.BubbleOfflineExp C#数据结构
function networkRespond.OnResBubbleOfflineExpMessageReceived(msgID)
    ---@type roleV2.BubbleOfflineExp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8049 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8049 roleV2.BubbleOfflineExp 返回泡点离线经验消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBubbleOfflineExpMessage", 8049, "BubbleOfflineExp", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回领取离线泡点经验
---msgID: 8051
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.BubbleOfflineExp C#数据结构
function networkRespond.OnResReceiveBubbleOfflineExpMessageReceived(msgID)
    ---@type roleV2.BubbleOfflineExp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8051 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8051 roleV2.BubbleOfflineExp 返回领取离线泡点经验")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResReceiveBubbleOfflineExpMessage", 8051, "BubbleOfflineExp", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---玩家零点刷新信息
---msgID: 8054
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRefreshInfo C#数据结构
function networkRespond.OnResRefreshInfoMessageReceived(msgID)
    ---@type roleV2.ResRefreshInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8054 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8054 roleV2.ResRefreshInfo 玩家零点刷新信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResRefreshInfo ~= nil then
        csData = protobufMgr.DecodeTable.role.ResRefreshInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回查看矿工信息
---msgID: 8056
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResGetMinerInfo C#数据结构
function networkRespond.OnResGetMinerInfoMessageReceived(msgID)
    ---@type roleV2.ResGetMinerInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8056 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8056 roleV2.ResGetMinerInfo 返回查看矿工信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResGetMinerInfo ~= nil then
        csData = protobufMgr.DecodeTable.role.ResGetMinerInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---刷新矿石信息
---msgID: 8057
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResUpdateMineInfo C#数据结构
function networkRespond.OnResUpdateMineInfoMessageReceived(msgID)
    ---@type roleV2.ResUpdateMineInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8057 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8057 roleV2.ResUpdateMineInfo 刷新矿石信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResUpdateMineInfo ~= nil then
        csData = protobufMgr.DecodeTable.role.ResUpdateMineInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回变或取消间谍消息
---msgID: 8060
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResPlayerSpyInfo C#数据结构
function networkRespond.OnResPlayerSpyInfoMessageReceived(msgID)
    ---@type roleV2.ResPlayerSpyInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8060 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8060 roleV2.ResPlayerSpyInfo 返回变或取消间谍消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResPlayerSpyInfo ~= nil then
        csData = protobufMgr.DecodeTable.role.ResPlayerSpyInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---是否首冲改变
---msgID: 8065
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRoleFirstRechargeChange C#数据结构
function networkRespond.OnResRoleFirstRechargeChangeMessageReceived(msgID)
    ---@type roleV2.ResRoleFirstRechargeChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8065 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8065 roleV2.ResRoleFirstRechargeChange 是否首冲改变")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResRoleFirstRechargeChange ~= nil then
        csData = protobufMgr.DecodeTable.role.ResRoleFirstRechargeChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回前置任务是否完成
---msgID: 8067
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResCheckPreTaskIsComplete C#数据结构
function networkRespond.OnResCheckPreTaskIsCompleteMessageReceived(msgID)
    ---@type roleV2.ResCheckPreTaskIsComplete
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8067 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8067 roleV2.ResCheckPreTaskIsComplete 返回前置任务是否完成")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResCheckPreTaskIsComplete ~= nil then
        csData = protobufMgr.DecodeTable.role.ResCheckPreTaskIsComplete(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---改名返回
---msgID: 8068
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResEditName C#数据结构
function networkRespond.OnResEditNameMessageReceived(msgID)
    ---@type roleV2.ResEditName
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8068 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8068 roleV2.ResEditName 改名返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResEditNameMessage", 8068, "ResEditName", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回小秘书主线推送是否已经发过
---msgID: 8070
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResMainTaskPush C#数据结构
function networkRespond.OnResMainTaskPushMessageReceived(msgID)
    ---@type roleV2.ResMainTaskPush
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8070 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8070 roleV2.ResMainTaskPush 返回小秘书主线推送是否已经发过")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResMainTaskPushMessage", 8070, "ResMainTaskPush", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回炼制大师面板信息
---msgID: 8073
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRefineMasterPanel C#数据结构
function networkRespond.OnResRefineMasterPanelMessageReceived(msgID)
    ---@type roleV2.ResRefineMasterPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8073 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8073 roleV2.ResRefineMasterPanel 返回炼制大师面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRefineMasterPanelMessage", 8073, "ResRefineMasterPanel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回炼制结果
---msgID: 8075
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRefineResult C#数据结构
function networkRespond.OnResRefineMasterResultMessageReceived(msgID)
    ---@type roleV2.ResRefineResult
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8075 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8075 roleV2.ResRefineResult 返回炼制结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRefineMasterResultMessage", 8075, "ResRefineResult", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---更新钻石额度
---msgID: 8076
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.UpdateAuctionDiamond C#数据结构
function networkRespond.OnResUpdateAuctionDiamondMessageReceived(msgID)
    ---@type roleV2.UpdateAuctionDiamond
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8076 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8076 roleV2.UpdateAuctionDiamond 更新钻石额度")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.UpdateAuctionDiamond ~= nil then
        csData = protobufMgr.DecodeTable.role.UpdateAuctionDiamond(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---身上的装备掉落变动
---msgID: 8079
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResPlayerDieDropEquipByWear C#数据结构
function networkRespond.OnResPlayerDieDropEquipByWearMessageReceived(msgID)
    ---@type roleV2.ResPlayerDieDropEquipByWear
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8079 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8079 roleV2.ResPlayerDieDropEquipByWear 身上的装备掉落变动")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPlayerDieDropEquipByWearMessage", 8079, "ResPlayerDieDropEquipByWear", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---千纸鹤传送返回
---msgID: 8081
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResPaperCraneDelivery C#数据结构
function networkRespond.OnResPaperCraneDeliveryMessageReceived(msgID)
    ---@type roleV2.ResPaperCraneDelivery
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8081 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8081 roleV2.ResPaperCraneDelivery 千纸鹤传送返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPaperCraneDeliveryMessage", 8081, "ResPaperCraneDelivery", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---首充推送
---msgID: 8082
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResFirstChargePushMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---首充推送-新服优势
---msgID: 8083
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResNewFirstChargePush C#数据结构
function networkRespond.OnResNewFirstChargePushMessageReceived(msgID)
    ---@type roleV2.ResNewFirstChargePush
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8083 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8083 roleV2.ResNewFirstChargePush 首充推送-新服优势")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResNewFirstChargePush ~= nil then
        csData = protobufMgr.DecodeTable.role.ResNewFirstChargePush(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---系统开起感叹号提示
---msgID: 8084
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResNeedPrompt C#数据结构
function networkRespond.OnResNeedPromptMessageReceived(msgID)
    ---@type roleV2.ResNeedPrompt
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8084 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8084 roleV2.ResNeedPrompt 系统开起感叹号提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.ResNeedPrompt ~= nil then
        csData = protobufMgr.DecodeTable.role.ResNeedPrompt(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家在游戏服的联服的基本数据
---msgID: 8086
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.GameBasicShareInfo C#数据结构
function networkRespond.OnResGameBasicShareInfoMessageReceived(msgID)
    ---@type roleV2.GameBasicShareInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8086 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8086 roleV2.GameBasicShareInfo 返回玩家在游戏服的联服的基本数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.role ~= nil and  protobufMgr.DecodeTable.role.GameBasicShareInfo ~= nil then
        csData = protobufMgr.DecodeTable.role.GameBasicShareInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---腕力刷新
---msgID: 8087
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRoleRefreshWanLi C#数据结构
function networkRespond.OnResRoleRefreshWanLiMessageReceived(msgID)
    ---@type roleV2.ResRoleRefreshWanLi
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8087 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8087 roleV2.ResRoleRefreshWanLi 腕力刷新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleRefreshWanLiMessage", 8087, "ResRoleRefreshWanLi", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---给客户端发送假buff消息
---msgID: 8088
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.RoleAddFakeBuff C#数据结构
function networkRespond.OnRoleAddFakeBuffMessageReceived(msgID)
    ---@type roleV2.RoleAddFakeBuff
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8088 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8088 roleV2.RoleAddFakeBuff 给客户端发送假buff消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("RoleAddFakeBuffMessage", 8088, "RoleAddFakeBuff", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---给客户端发送驯服次数信息
---msgID: 8089
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRoleTame C#数据结构
function networkRespond.OnResRoleTameMessageReceived(msgID)
    ---@type roleV2.ResRoleTame
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8089 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8089 roleV2.ResRoleTame 给客户端发送驯服次数信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleTameMessage", 8089, "ResRoleTame", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---炼制大师红点信息
---msgID: 8090
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRefineMasterRedDot C#数据结构
function networkRespond.OnResRefineMasterRedDotMessageReceived(msgID)
    ---@type roleV2.ResRefineMasterRedDot
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8090 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8090 roleV2.ResRefineMasterRedDot 炼制大师红点信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRefineMasterRedDotMessage", 8090, "ResRefineMasterRedDot", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---给客户端发送封号天赋数据
---msgID: 8091
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResTitleTianfu C#数据结构
function networkRespond.OnResTitleTianfuMessageReceived(msgID)
    ---@type roleV2.ResTitleTianfu
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8091 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8091 roleV2.ResTitleTianfu 给客户端发送封号天赋数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTitleTianfuMessage", 8091, "ResTitleTianfu", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---练功房时间限制
---msgID: 8095
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResKongFuHouseTimeLimit C#数据结构
function networkRespond.OnResKongFuHouseTimeLimitMessageReceived(msgID)
    ---@type roleV2.ResKongFuHouseTimeLimit
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8095 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8095 roleV2.ResKongFuHouseTimeLimit 练功房时间限制")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResKongFuHouseTimeLimitMessage", 8095, "ResKongFuHouseTimeLimit", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回潜能信息
---msgID: 8097
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.RespotentialInfo C#数据结构
function networkRespond.OnResPotentialInfoMessageReceived(msgID)
    ---@type roleV2.RespotentialInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8097 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8097 roleV2.RespotentialInfo 返回潜能信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPotentialInfoMessage", 8097, "RespotentialInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回潜能红点信息
---msgID: 8101
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResPotentialRedPoint C#数据结构
function networkRespond.OnResRedPointPotentialMessageReceived(msgID)
    ---@type roleV2.ResPotentialRedPoint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8101 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8101 roleV2.ResPotentialRedPoint 返回潜能红点信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRedPointPotentialMessage", 8101, "ResPotentialRedPoint", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回回收配置
---msgID: 8103
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.CollectionSetting C#数据结构
function networkRespond.OnResCollectionSettingMessageReceived(msgID)
    ---@type roleV2.CollectionSetting
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8103 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8103 roleV2.CollectionSetting 返回回收配置")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCollectionSettingMessage", 8103, "CollectionSetting", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回玩家模型数据
---msgID: 8107
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.RoleModelInfo C#数据结构
function networkRespond.OnResRoleModelInfoMessageReceived(msgID)
    ---@type roleV2.RoleModelInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8107 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8107 roleV2.RoleModelInfo 返回玩家模型数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleModelInfoMessage", 8107, "RoleModelInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---神秘老人兑换详情
---msgID: 8109
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResMysteriousExchange C#数据结构
function networkRespond.OnResMysteriousExchangeMessageReceived(msgID)
    ---@type roleV2.ResMysteriousExchange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8109 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8109 roleV2.ResMysteriousExchange 神秘老人兑换详情")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResMysteriousExchangeMessage", 8109, "ResMysteriousExchange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---终极boss击杀数据
---msgID: 8110
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.BossKillData C#数据结构
function networkRespond.OnResBossKillDataMessageReceived(msgID)
    ---@type roleV2.BossKillData
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8110 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8110 roleV2.BossKillData 终极boss击杀数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBossKillDataMessage", 8110, "BossKillData", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---玩家系统预告开启信息
---msgID: 8112
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRoleSystemPreview C#数据结构
function networkRespond.OnResRoleSystemPreviewMessageReceived(msgID)
    ---@type roleV2.ResRoleSystemPreview
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8112 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8112 roleV2.ResRoleSystemPreview 玩家系统预告开启信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleSystemPreviewMessage", 8112, "ResRoleSystemPreview", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回当前累计的经验值
---msgID: 8115
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRoleExpAccumulate C#数据结构
function networkRespond.OnResRoleExpAccumulateMessageReceived(msgID)
    ---@type roleV2.ResRoleExpAccumulate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8115 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8115 roleV2.ResRoleExpAccumulate 返回当前累计的经验值")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleExpAccumulateMessage", 8115, "ResRoleExpAccumulate", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回创角邀请码
---msgID: 8116
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResRoleInviteCode C#数据结构
function networkRespond.OnResRoleInviteCodeMessageReceived(msgID)
    ---@type roleV2.ResRoleInviteCode
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8116 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8116 roleV2.ResRoleInviteCode 返回创角邀请码")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleInviteCodeMessage", 8116, "ResRoleInviteCode", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---转性
---msgID: 8118
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResTransferSex C#数据结构
function networkRespond.OnResTransferSexMessageReceived(msgID)
    ---@type roleV2.ResTransferSex
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8118 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8118 roleV2.ResTransferSex 转性")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTransferSexMessage", 8118, "ResTransferSex", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---转职
---msgID: 8120
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResTransferCareer C#数据结构
function networkRespond.OnResTransferCareerMessageReceived(msgID)
    ---@type roleV2.ResTransferCareer
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8120 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8120 roleV2.ResTransferCareer 转职")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTransferCareerMessage", 8120, "ResTransferCareer", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回身上可投保列表
---msgID: 8121
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResCanInsuredEquip C#数据结构
function networkRespond.OnResCanInsuredEquipMessageReceived(msgID)
    ---@type roleV2.ResCanInsuredEquip
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8121 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8121 roleV2.ResCanInsuredEquip 返回身上可投保列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCanInsuredEquipMessage", 8121, "ResCanInsuredEquip", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---投保返回
---msgID: 8123
---@param msgID LuaEnumNetDef 消息ID
---@return roleV2.ResInsuredSucces C#数据结构
function networkRespond.OnResInsuredSuccesMessageReceived(msgID)
    ---@type roleV2.ResInsuredSucces
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 8123 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 8123 roleV2.ResInsuredSucces 投保返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResInsuredSuccesMessage", 8123, "ResInsuredSucces", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

