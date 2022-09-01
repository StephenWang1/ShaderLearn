--[[本文件为工具自动生成,禁止手动修改]]
--union.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---申请入会状态变化
---msgID: 23002
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResApplyForUnionStateChange C#数据结构
function networkRespond.OnResApplyForUnionStateChangeMessageReceived(msgID)
    ---@type unionV2.ResApplyForUnionStateChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23002 unionV2.ResApplyForUnionStateChange 申请入会状态变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResApplyForUnionStateChange ~= nil then
        csData = protobufMgr.DecodeTable.union.ResApplyForUnionStateChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送行会列表信息
---msgID: 23003
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSendAllUnionInfo C#数据结构
function networkRespond.OnResSendAllUnionInfoMessageReceived(msgID)
    ---@type unionV2.ResSendAllUnionInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23003 unionV2.ResSendAllUnionInfo 发送行会列表信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResSendAllUnionInfo ~= nil then
        csData = protobufMgr.DecodeTable.union.ResSendAllUnionInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送玩家所在行会信息
---msgID: 23005
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSendPlayerUnionInfo C#数据结构
function networkRespond.OnResSendPlayerUnionInfoMessageReceived(msgID)
    ---@type unionV2.ResSendPlayerUnionInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23005 unionV2.ResSendPlayerUnionInfo 发送玩家所在行会信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResSendPlayerUnionInfo ~= nil then
        csData = protobufMgr.DecodeTable.union.ResSendPlayerUnionInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送申请入会列表信息
---msgID: 23012
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSendApplyListInfo C#数据结构
function networkRespond.OnResSendApplyListInfoMessageReceived(msgID)
    ---@type unionV2.ResSendApplyListInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23012 unionV2.ResSendApplyListInfo 发送申请入会列表信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResSendApplyListInfo ~= nil then
        csData = protobufMgr.DecodeTable.union.ResSendApplyListInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送退出行会成功信息
---msgID: 23015
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSendQuitUnionSuccess C#数据结构
function networkRespond.OnResSendQuitUnionSuccessMessageReceived(msgID)
    ---@type unionV2.ResSendQuitUnionSuccess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23015 unionV2.ResSendQuitUnionSuccess 发送退出行会成功信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResSendQuitUnionSuccess ~= nil then
        csData = protobufMgr.DecodeTable.union.ResSendQuitUnionSuccess(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送修改公告信息
---msgID: 23016
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSendChangeAnnounce C#数据结构
function networkRespond.OnResSendChangeAnnounceMessageReceived(msgID)
    ---@type unionV2.ResSendChangeAnnounce
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23016 unionV2.ResSendChangeAnnounce 发送修改公告信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSendChangeAnnounceMessage", 23016, "ResSendChangeAnnounce", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送调整职位信息
---msgID: 23017
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSendChangePosition C#数据结构
function networkRespond.OnResSendChangePositionMessageReceived(msgID)
    ---@type unionV2.ResSendChangePosition
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23017 unionV2.ResSendChangePosition 发送调整职位信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSendChangePositionMessage", 23017, "ResSendChangePosition", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送内推信息至被邀请者
---msgID: 23057
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResInviteForEnterUnion C#数据结构
function networkRespond.OnResInviteForEnterUnionMessageReceived(msgID)
    ---@type unionV2.ResInviteForEnterUnion
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23057 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23057 unionV2.ResInviteForEnterUnion 发送内推信息至被邀请者")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResInviteForEnterUnion ~= nil then
        csData = protobufMgr.DecodeTable.union.ResInviteForEnterUnion(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回解散行会
---msgID: 23060
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResDissolveUnion C#数据结构
function networkRespond.OnResDissolveUnionMessageReceived(msgID)
    ---@type unionV2.ResDissolveUnion
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23060 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23060 unionV2.ResDissolveUnion 返回解散行会")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResDissolveUnion ~= nil then
        csData = protobufMgr.DecodeTable.union.ResDissolveUnion(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回请求行会仓库
---msgID: 23062
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUnionWarehouseInfo C#数据结构
function networkRespond.OnResUnionWarehouseInfoMessageReceived(msgID)
    ---@type unionV2.ResUnionWarehouseInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23062 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23062 unionV2.ResUnionWarehouseInfo 返回请求行会仓库")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResUnionWarehouseInfo ~= nil then
        csData = protobufMgr.DecodeTable.union.ResUnionWarehouseInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回成功创建行会信息
---msgID: 23071
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSendCreateUnionSuccess C#数据结构
function networkRespond.OnResSendCreateUnionSuccessMessageReceived(msgID)
    ---@type unionV2.ResSendCreateUnionSuccess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23071 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23071 unionV2.ResSendCreateUnionSuccess 返回成功创建行会信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResSendCreateUnionSuccess ~= nil then
        csData = protobufMgr.DecodeTable.union.ResSendCreateUnionSuccess(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回捐赠金钱信息
---msgID: 23072
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResDonateMoney C#数据结构
function networkRespond.OnResDonateMoneyMessageReceived(msgID)
    ---@type unionV2.ResDonateMoney
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23072 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23072 unionV2.ResDonateMoney 返回捐赠金钱信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDonateMoneyMessage", 23072, "ResDonateMoney", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回行会成员列表
---msgID: 23077
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUnionMemberInfo C#数据结构
function networkRespond.OnResUnionMemberInfoMessageReceived(msgID)
    ---@type unionV2.ResUnionMemberInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23077 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23077 unionV2.ResUnionMemberInfo 返回行会成员列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResUnionMemberInfo ~= nil then
        csData = protobufMgr.DecodeTable.union.ResUnionMemberInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回拉黑的玩家列表
---msgID: 23082
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResGetBlackApplyRole C#数据结构
function networkRespond.OnResGetBlackApplyRoleMessageReceived(msgID)
    ---@type unionV2.ResGetBlackApplyRole
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23082 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23082 unionV2.ResGetBlackApplyRole 返回拉黑的玩家列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetBlackApplyRoleMessage", 23082, "ResGetBlackApplyRole", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回被T的人的公会ID和名字
---msgID: 23085
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResKickOutGuild C#数据结构
function networkRespond.OnResKickOutGuildMessageReceived(msgID)
    ---@type unionV2.ResKickOutGuild
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23085 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23085 unionV2.ResKickOutGuild 返回被T的人的公会ID和名字")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResKickOutGuild ~= nil then
        csData = protobufMgr.DecodeTable.union.ResKickOutGuild(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回弹劾票行
---msgID: 23088
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResImpeachmentVote C#数据结构
function networkRespond.OnResImpeachmentVoteMessageReceived(msgID)
    ---@type unionV2.ResImpeachmentVote
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23088 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23088 unionV2.ResImpeachmentVote 返回弹劾票行")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResImpeachmentVote ~= nil then
        csData = protobufMgr.DecodeTable.union.ResImpeachmentVote(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---行会改变消息
---msgID: 23091
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResTheUnionChange C#数据结构
function networkRespond.OnResTheUnionChangeMessageReceived(msgID)
    ---@type unionV2.ResTheUnionChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23091 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23091 unionV2.ResTheUnionChange 行会改变消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResTheUnionChange ~= nil then
        csData = protobufMgr.DecodeTable.union.ResTheUnionChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---行会改变向周围玩家发送消息
---msgID: 23092
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUnionNameChange C#数据结构
function networkRespond.OnResUnionNameChangeMessageReceived(msgID)
    ---@type unionV2.ResUnionNameChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23092 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23092 unionV2.ResUnionNameChange 行会改变向周围玩家发送消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResUnionNameChange ~= nil then
        csData = protobufMgr.DecodeTable.union.ResUnionNameChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回所有会徽
---msgID: 23094
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResGetAllUnionIcon C#数据结构
function networkRespond.OnResGetAllUnionIconMessageReceived(msgID)
    ---@type unionV2.ResGetAllUnionIcon
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23094 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23094 unionV2.ResGetAllUnionIcon 返回所有会徽")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetAllUnionIconMessage", 23094, "ResGetAllUnionIcon", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回日志
---msgID: 23097
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResGetUnionJournal C#数据结构
function networkRespond.OnResGetUnionJournalMessageReceived(msgID)
    ---@type unionV2.ResGetUnionJournal
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23097 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23097 unionV2.ResGetUnionJournal 返回日志")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResGetUnionJournal ~= nil then
        csData = protobufMgr.DecodeTable.union.ResGetUnionJournal(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回行会属性
---msgID: 23099
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResGetUnionAttribute C#数据结构
function networkRespond.OnResGetUnionAttributeMessageReceived(msgID)
    ---@type unionV2.ResGetUnionAttribute
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23099 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23099 unionV2.ResGetUnionAttribute 返回行会属性")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetUnionAttributeMessage", 23099, "ResGetUnionAttribute", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---收到了请求转让会长消息
---msgID: 23101
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.GetAssignment C#数据结构
function networkRespond.OnGetAssignmentMessageReceived(msgID)
    ---@type unionV2.GetAssignment
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23101 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23101 unionV2.GetAssignment 收到了请求转让会长消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("GetAssignmentMessage", 23101, "GetAssignment", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发给双方转让会长处理的消息
---msgID: 23103
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.HandlingSuccess C#数据结构
function networkRespond.OnHandlingSuccessMessageReceived(msgID)
    ---@type unionV2.HandlingSuccess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23103 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23103 unionV2.HandlingSuccess 发给双方转让会长处理的消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("HandlingSuccessMessage", 23103, "HandlingSuccess", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回行会仓库一个格子的所有数据
---msgID: 23106
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResGetBagItemInfo C#数据结构
function networkRespond.OnResGetBagItemInfoMessageReceived(msgID)
    ---@type unionV2.ResGetBagItemInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23106 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23106 unionV2.ResGetBagItemInfo 返回行会仓库一个格子的所有数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResGetBagItemInfo ~= nil then
        csData = protobufMgr.DecodeTable.union.ResGetBagItemInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---请求合并响应
---msgID: 23113
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResApplyCombineUnion C#数据结构
function networkRespond.OnResApplyCombineUnionMessageReceived(msgID)
    ---@type unionV2.ResApplyCombineUnion
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23113 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23113 unionV2.ResApplyCombineUnion 请求合并响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResApplyCombineUnion ~= nil then
        csData = protobufMgr.DecodeTable.union.ResApplyCombineUnion(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回战利品仓库
---msgID: 23116
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSpoilsHouse C#数据结构
function networkRespond.OnResSpoilsHouseMessageReceived(msgID)
    ---@type unionV2.ResSpoilsHouse
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23116 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23116 unionV2.ResSpoilsHouse 返回战利品仓库")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResSpoilsHouse ~= nil then
        csData = protobufMgr.DecodeTable.union.ResSpoilsHouse(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---战利品仓库更新消息
---msgID: 23118
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResSpoilsHouseUpdate C#数据结构
function networkRespond.OnResSpoilsHouseUpdateMessageReceived(msgID)
    ---@type unionV2.ResSpoilsHouseUpdate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23118 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23118 unionV2.ResSpoilsHouseUpdate 战利品仓库更新消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResSpoilsHouseUpdate ~= nil then
        csData = protobufMgr.DecodeTable.union.ResSpoilsHouseUpdate(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回可发放战利品的成员列表
---msgID: 23120
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResCanGetSpoilsMembers C#数据结构
function networkRespond.OnResCanGetSpoilsMembersMessageReceived(msgID)
    ---@type unionV2.ResCanGetSpoilsMembers
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23120 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23120 unionV2.ResCanGetSpoilsMembers 返回可发放战利品的成员列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResCanGetSpoilsMembers ~= nil then
        csData = protobufMgr.DecodeTable.union.ResCanGetSpoilsMembers(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新行会今天的税收
---msgID: 23122
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.updateTodayCityTax C#数据结构
function networkRespond.OnResUpdateTodayCityTaxMessageReceived(msgID)
    ---@type unionV2.updateTodayCityTax
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23122 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23122 unionV2.updateTodayCityTax 更新行会今天的税收")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.updateTodayCityTax ~= nil then
        csData = protobufMgr.DecodeTable.union.updateTodayCityTax(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---语音权限信息
---msgID: 23124
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.UnionVoiceStatus C#数据结构
function networkRespond.OnResUnionVoiceStatusMessageReceived(msgID)
    ---@type unionV2.UnionVoiceStatus
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23124 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23124 unionV2.UnionVoiceStatus 语音权限信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.UnionVoiceStatus ~= nil then
        csData = protobufMgr.DecodeTable.union.UnionVoiceStatus(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---新行会消息
---msgID: 23127
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUnionChatAnnounce C#数据结构
function networkRespond.OnResUnionChatAnnounceMessageReceived(msgID)
    ---@type unionV2.ResUnionChatAnnounce
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23127 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23127 unionV2.ResUnionChatAnnounce 新行会消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResUnionChatAnnounce ~= nil then
        csData = protobufMgr.DecodeTable.union.ResUnionChatAnnounce(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---魔法阵开始
---msgID: 23128
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResMagicCircleStart C#数据结构
function networkRespond.OnResMagicCircleStartMessageReceived(msgID)
    ---@type unionV2.ResMagicCircleStart
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23128 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23128 unionV2.ResMagicCircleStart 魔法阵开始")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResMagicCircleStart ~= nil then
        csData = protobufMgr.DecodeTable.union.ResMagicCircleStart(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---魔法阵信息
---msgID: 23130
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResMagicCircleInfo C#数据结构
function networkRespond.OnResMagicCircleInfoMessageReceived(msgID)
    ---@type unionV2.ResMagicCircleInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23130 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23130 unionV2.ResMagicCircleInfo 魔法阵信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResMagicCircleInfo ~= nil then
        csData = protobufMgr.DecodeTable.union.ResMagicCircleInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---红包信息响应
---msgID: 23132
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUnionRedBagInfo C#数据结构
function networkRespond.OnResUnionRedBagInfoMessageReceived(msgID)
    ---@type unionV2.ResUnionRedBagInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23132 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23132 unionV2.ResUnionRedBagInfo 红包信息响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUnionRedBagInfoMessage", 23132, "ResUnionRedBagInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---行会成员喇叭状态
---msgID: 23136
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUnionSpeakerStatus C#数据结构
function networkRespond.OnResUnionSpeakerStatusMessageReceived(msgID)
    ---@type unionV2.ResUnionSpeakerStatus
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23136 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23136 unionV2.ResUnionSpeakerStatus 行会成员喇叭状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResUnionSpeakerStatus ~= nil then
        csData = protobufMgr.DecodeTable.union.ResUnionSpeakerStatus(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---响应帮会召唤令信息
---msgID: 23138
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUnionCallBackInfo C#数据结构
function networkRespond.OnResUnionCallBackInfoMessageReceived(msgID)
    ---@type unionV2.ResUnionCallBackInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23138 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23138 unionV2.ResUnionCallBackInfo 响应帮会召唤令信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResUnionCallBackInfo ~= nil then
        csData = protobufMgr.DecodeTable.union.ResUnionCallBackInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---魔法阵boss召唤
---msgID: 23139
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResUnionMagicCallBossMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---魔法阵boss积分排行
---msgID: 23140
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUnionMagicBossRank C#数据结构
function networkRespond.OnResUnionMagicBossRankMessageReceived(msgID)
    ---@type unionV2.ResUnionMagicBossRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23140 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23140 unionV2.ResUnionMagicBossRank 魔法阵boss积分排行")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResUnionMagicBossRank ~= nil then
        csData = protobufMgr.DecodeTable.union.ResUnionMagicBossRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---更新代理会长职位
---msgID: 23141
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResUpdateAgencyChairman C#数据结构
function networkRespond.OnResUpdateAgencyChairmanMessageReceived(msgID)
    ---@type unionV2.ResUpdateAgencyChairman
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23141 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23141 unionV2.ResUpdateAgencyChairman 更新代理会长职位")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResUpdateAgencyChairman ~= nil then
        csData = protobufMgr.DecodeTable.union.ResUpdateAgencyChairman(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回查看行会复仇
---msgID: 23143
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResToViewUnionRevenge C#数据结构
function networkRespond.OnResToViewUnionRevengeMessageReceived(msgID)
    ---@type unionV2.ResToViewUnionRevenge
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23143 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23143 unionV2.ResToViewUnionRevenge 返回查看行会复仇")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResToViewUnionRevenge ~= nil then
        csData = protobufMgr.DecodeTable.union.ResToViewUnionRevenge(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---行会复仇领奖返回
---msgID: 23145
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResRewardUnionRevenge C#数据结构
function networkRespond.OnResRewardUnionRevengeMessageReceived(msgID)
    ---@type unionV2.ResRewardUnionRevenge
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23145 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23145 unionV2.ResRewardUnionRevenge 行会复仇领奖返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResRewardUnionRevenge ~= nil then
        csData = protobufMgr.DecodeTable.union.ResRewardUnionRevenge(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---刷新一个行会仇人
---msgID: 23146
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResAddUnionRevenge C#数据结构
function networkRespond.OnResAddUnionRevengeMessageReceived(msgID)
    ---@type unionV2.ResAddUnionRevenge
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23146 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23146 unionV2.ResAddUnionRevenge 刷新一个行会仇人")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.union ~= nil and  protobufMgr.DecodeTable.union.ResAddUnionRevenge ~= nil then
        csData = protobufMgr.DecodeTable.union.ResAddUnionRevenge(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回仇人位置
---msgID: 23148
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.ResGetRevengePoint C#数据结构
function networkRespond.OnResGetRevengePointMessageReceived(msgID)
    ---@type unionV2.ResGetRevengePoint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23148 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23148 unionV2.ResGetRevengePoint 返回仇人位置")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetRevengePointMessage", 23148, "ResGetRevengePoint", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回所有联服同盟投票
---msgID: 23150
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.AllWillJoinUniteUnion C#数据结构
function networkRespond.OnResAllWillJoinUniteUnionMessageReceived(msgID)
    ---@type unionV2.AllWillJoinUniteUnion
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23150 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23150 unionV2.AllWillJoinUniteUnion 返回所有联服同盟投票")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAllWillJoinUniteUnionMessage", 23150, "AllWillJoinUniteUnion", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回所有服所有联服同盟投票
---msgID: 23153
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.OtherAllUniteUnionVoteInfo C#数据结构
function networkRespond.OnResAllOtherWillJoinUniteUnionMessageReceived(msgID)
    ---@type unionV2.OtherAllUniteUnionVoteInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23153 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23153 unionV2.OtherAllUniteUnionVoteInfo 返回所有服所有联服同盟投票")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResAllOtherWillJoinUniteUnionMessage", 23153, "OtherAllUniteUnionVoteInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回个人排行榜,进副本就推,
---msgID: 23154
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.UnionBossPlayerRankInfo C#数据结构
function networkRespond.OnResUnionBossPlayerRankInfoMessageReceived(msgID)
    ---@type unionV2.UnionBossPlayerRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23154 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23154 unionV2.UnionBossPlayerRankInfo 返回个人排行榜,进副本就推,")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUnionBossPlayerRankInfoMessage", 23154, "UnionBossPlayerRankInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回公会排行榜, 进副本就推
---msgID: 23155
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.UnionBossUnionRankInfo C#数据结构
function networkRespond.OnResUnionBossUnionRankInfoMessageReceived(msgID)
    ---@type unionV2.UnionBossUnionRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23155 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23155 unionV2.UnionBossUnionRankInfo 返回公会排行榜, 进副本就推")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUnionBossUnionRankInfoMessage", 23155, "UnionBossUnionRankInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回鼓舞buff的信息
---msgID: 23157
---@param msgID LuaEnumNetDef 消息ID
---@return unionV2.UnionBossBuffInfo C#数据结构
function networkRespond.OnResUnionBossBuffInfoMessageReceived(msgID)
    ---@type unionV2.UnionBossBuffInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 23157 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 23157 unionV2.UnionBossBuffInfo 返回鼓舞buff的信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUnionBossBuffInfoMessage", 23157, "UnionBossBuffInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

