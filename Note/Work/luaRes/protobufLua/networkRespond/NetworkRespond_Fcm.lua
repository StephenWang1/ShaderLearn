--[[本文件为工具自动生成,禁止手动修改]]
--fcm.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---认证状态
---msgID: 34001
---@param msgID LuaEnumNetDef 消息ID
---@return fcmV2.ResAuthorityState C#数据结构
function networkRespond.OnResAuthorityStateMessageReceived(msgID)
    ---@type fcmV2.ResAuthorityState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 34001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 34001 fcmV2.ResAuthorityState 认证状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.fcm ~= nil and  protobufMgr.DecodeTable.fcm.ResAuthorityState ~= nil then
        csData = protobufMgr.DecodeTable.fcm.ResAuthorityState(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---防沉迷状态 1-5对应小时
---msgID: 34003
---@param msgID LuaEnumNetDef 消息ID
---@return fcmV2.ResFcmState C#数据结构
function networkRespond.OnResFcmStateMessageReceived(msgID)
    ---@type fcmV2.ResFcmState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 34003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 34003 fcmV2.ResFcmState 防沉迷状态 1-5对应小时")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.fcm ~= nil and  protobufMgr.DecodeTable.fcm.ResFcmState ~= nil then
        csData = protobufMgr.DecodeTable.fcm.ResFcmState(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

