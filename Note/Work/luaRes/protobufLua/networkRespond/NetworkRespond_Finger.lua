--[[本文件为工具自动生成,禁止手动修改]]
--finger.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送最近划拳对象
---msgID: 112002
---@param msgID LuaEnumNetDef 消息ID
---@return fingerV2.LatelyFingerPlayers C#数据结构
function networkRespond.OnResLatelyFingerPlayersMessageReceived(msgID)
    ---@type fingerV2.LatelyFingerPlayers
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 112002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 112002 fingerV2.LatelyFingerPlayers 发送最近划拳对象")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLatelyFingerPlayersMessage", 112002, "LatelyFingerPlayers", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---被挑战者收到邀请
---msgID: 112004
---@param msgID LuaEnumNetDef 消息ID
---@return fingerV2.ResInviteFinger C#数据结构
function networkRespond.OnResInviteFingerMessageReceived(msgID)
    ---@type fingerV2.ResInviteFinger
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 112004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 112004 fingerV2.ResInviteFinger 被挑战者收到邀请")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResInviteFingerMessage", 112004, "ResInviteFinger", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回邀请结果
---msgID: 112006
---@param msgID LuaEnumNetDef 消息ID
---@return fingerV2.ResEchoInvite C#数据结构
function networkRespond.OnResEchoInviteMessageReceived(msgID)
    ---@type fingerV2.ResEchoInvite
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 112006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 112006 fingerV2.ResEchoInvite 返回邀请结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.finger ~= nil and  protobufMgr.DecodeTable.finger.ResEchoInvite ~= nil then
        csData = protobufMgr.DecodeTable.finger.ResEchoInvite(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回赢得奖励信息
---msgID: 112008
---@param msgID LuaEnumNetDef 消息ID
---@return fingerV2.ResRewardInfo C#数据结构
function networkRespond.OnResFingerRewardInfoMessageReceived(msgID)
    ---@type fingerV2.ResRewardInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 112008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 112008 fingerV2.ResRewardInfo 返回赢得奖励信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.finger ~= nil and  protobufMgr.DecodeTable.finger.ResRewardInfo ~= nil then
        csData = protobufMgr.DecodeTable.finger.ResRewardInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回开始猜拳
---msgID: 112010
---@param msgID LuaEnumNetDef 消息ID
---@return fingerV2.ResAllChosed C#数据结构
function networkRespond.OnResAllChosedMessageReceived(msgID)
    ---@type fingerV2.ResAllChosed
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 112010 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 112010 fingerV2.ResAllChosed 返回开始猜拳")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.finger ~= nil and  protobufMgr.DecodeTable.finger.ResAllChosed ~= nil then
        csData = protobufMgr.DecodeTable.finger.ResAllChosed(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回猜拳结果
---msgID: 112012
---@param msgID LuaEnumNetDef 消息ID
---@return fingerV2.ResFingerReason C#数据结构
function networkRespond.OnResFingerReasonMessageReceived(msgID)
    ---@type fingerV2.ResFingerReason
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 112012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 112012 fingerV2.ResFingerReason 返回猜拳结果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.finger ~= nil and  protobufMgr.DecodeTable.finger.ResFingerReason ~= nil then
        csData = protobufMgr.DecodeTable.finger.ResFingerReason(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回终止猜拳
---msgID: 112014
---@param msgID LuaEnumNetDef 消息ID
---@return fingerV2.ResTerminate C#数据结构
function networkRespond.OnResTerminateFingerMessageReceived(msgID)
    ---@type fingerV2.ResTerminate
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 112014 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 112014 fingerV2.ResTerminate 返回终止猜拳")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.finger ~= nil and  protobufMgr.DecodeTable.finger.ResTerminate ~= nil then
        csData = protobufMgr.DecodeTable.finger.ResTerminate(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回邀请剩余时间
---msgID: 112016
---@param msgID LuaEnumNetDef 消息ID
---@return fingerV2.ResInviteFinger C#数据结构
function networkRespond.OnResEchoInviteTimeMessageReceived(msgID)
    ---@type fingerV2.ResInviteFinger
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 112016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 112016 fingerV2.ResInviteFinger 返回邀请剩余时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResEchoInviteTimeMessage", 112016, "ResInviteFinger", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回背包使用筹码
---msgID: 112017
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResUseBagChipMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---通知玩家对方已经出拳
---msgID: 112018
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResChoseFingerMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

