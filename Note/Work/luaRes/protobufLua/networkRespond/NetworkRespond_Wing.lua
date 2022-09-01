--[[本文件为工具自动生成,禁止手动修改]]
--wing.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送光翼信息
---msgID: 18002
---@param msgID LuaEnumNetDef 消息ID
---@return wingV2.ResWingInfo C#数据结构
function networkRespond.OnResWingInfoMessageReceived(msgID)
    ---@type wingV2.ResWingInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 18002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 18002 wingV2.ResWingInfo 发送光翼信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResWingInfoMessage", 18002, "ResWingInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回升级光翼
---msgID: 18004
---@param msgID LuaEnumNetDef 消息ID
---@return wingV2.ResLevelUpWing C#数据结构
function networkRespond.OnResLevelUpWingMessageReceived(msgID)
    ---@type wingV2.ResLevelUpWing
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 18004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 18004 wingV2.ResLevelUpWing 返回升级光翼")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLevelUpWingMessage", 18004, "ResLevelUpWing", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

