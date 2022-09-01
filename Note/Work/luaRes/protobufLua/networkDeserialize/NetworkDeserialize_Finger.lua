--[[本文件为工具自动生成,禁止手动修改]]
--finger.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送最近划拳对象
---msgID: 112002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLatelyFingerPlayersMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 112002 fingerV2.LatelyFingerPlayers 发送最近划拳对象")
        return nil
    end
    local res = protobufMgr.Deserialize("fingerV2.LatelyFingerPlayers", buffer)
    if protoAdjust.finger_adj ~= nil and protoAdjust.finger_adj.AdjustLatelyFingerPlayers ~= nil then
        protoAdjust.finger_adj.AdjustLatelyFingerPlayers(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 112002
    protobufMgr.mMsgDeserializedTblCache = res
end

---被挑战者收到邀请
---msgID: 112004
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInviteFingerMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 112004 fingerV2.ResInviteFinger 被挑战者收到邀请")
        return nil
    end
    local res = protobufMgr.Deserialize("fingerV2.ResInviteFinger", buffer)
    if protoAdjust.finger_adj ~= nil and protoAdjust.finger_adj.AdjustResInviteFinger ~= nil then
        protoAdjust.finger_adj.AdjustResInviteFinger(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 112004
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回邀请结果
---msgID: 112006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEchoInviteMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 112006 fingerV2.ResEchoInvite 返回邀请结果")
        return nil
    end
    local res = protobufMgr.Deserialize("fingerV2.ResEchoInvite", buffer)
    if protoAdjust.finger_adj ~= nil and protoAdjust.finger_adj.AdjustResEchoInvite ~= nil then
        protoAdjust.finger_adj.AdjustResEchoInvite(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 112006
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回赢得奖励信息
---msgID: 112008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFingerRewardInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 112008 fingerV2.ResRewardInfo 返回赢得奖励信息")
        return nil
    end
    local res = protobufMgr.Deserialize("fingerV2.ResRewardInfo", buffer)
    if protoAdjust.finger_adj ~= nil and protoAdjust.finger_adj.AdjustResRewardInfo ~= nil then
        protoAdjust.finger_adj.AdjustResRewardInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 112008
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回开始猜拳
---msgID: 112010
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllChosedMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 112010 fingerV2.ResAllChosed 返回开始猜拳")
        return nil
    end
    local res = protobufMgr.Deserialize("fingerV2.ResAllChosed", buffer)
    if protoAdjust.finger_adj ~= nil and protoAdjust.finger_adj.AdjustResAllChosed ~= nil then
        protoAdjust.finger_adj.AdjustResAllChosed(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 112010
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回猜拳结果
---msgID: 112012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFingerReasonMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 112012 fingerV2.ResFingerReason 返回猜拳结果")
        return nil
    end
    local res = protobufMgr.Deserialize("fingerV2.ResFingerReason", buffer)
    if protoAdjust.finger_adj ~= nil and protoAdjust.finger_adj.AdjustResFingerReason ~= nil then
        protoAdjust.finger_adj.AdjustResFingerReason(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 112012
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回终止猜拳
---msgID: 112014
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTerminateFingerMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 112014 fingerV2.ResTerminate 返回终止猜拳")
        return nil
    end
    local res = protobufMgr.Deserialize("fingerV2.ResTerminate", buffer)
    if protoAdjust.finger_adj ~= nil and protoAdjust.finger_adj.AdjustResTerminate ~= nil then
        protoAdjust.finger_adj.AdjustResTerminate(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 112014
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回邀请剩余时间
---msgID: 112016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEchoInviteTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 112016 fingerV2.ResInviteFinger 返回邀请剩余时间")
        return nil
    end
    local res = protobufMgr.Deserialize("fingerV2.ResInviteFinger", buffer)
    if protoAdjust.finger_adj ~= nil and protoAdjust.finger_adj.AdjustResInviteFinger ~= nil then
        protoAdjust.finger_adj.AdjustResInviteFinger(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 112016
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回背包使用筹码
---msgID: 112017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUseBagChipMessageReceived(msgID, buffer)
end

---通知玩家对方已经出拳
---msgID: 112018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResChoseFingerMessageReceived(msgID, buffer)
end

