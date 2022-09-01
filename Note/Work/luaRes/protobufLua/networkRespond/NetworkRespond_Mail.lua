--[[本文件为工具自动生成,禁止手动修改]]
--mail.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---邮件列表响应
---msgID: 36002
---@param msgID LuaEnumNetDef 消息ID
---@return mailV2.MailList C#数据结构
function networkRespond.OnResMailListMessageReceived(msgID)
    ---@type mailV2.MailList
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 36002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 36002 mailV2.MailList 邮件列表响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.mail ~= nil and  protobufMgr.DecodeTable.mail.MailList ~= nil then
        csData = protobufMgr.DecodeTable.mail.MailList(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---新邮件响应
---msgID: 36003
---@param msgID LuaEnumNetDef 消息ID
---@return mailV2.MsgRemind C#数据结构
function networkRespond.OnResNewMailMessageReceived(msgID)
    ---@type mailV2.MsgRemind
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 36003 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 36003 mailV2.MsgRemind 新邮件响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResNewMailMessage", 36003, "MsgRemind", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---提取物品响应
---msgID: 36006
---@param msgID LuaEnumNetDef 消息ID
---@return mailV2.MailIdMsg C#数据结构
function networkRespond.OnResGetMailItemMessageReceived(msgID)
    ---@type mailV2.MailIdMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 36006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 36006 mailV2.MailIdMsg 提取物品响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetMailItemMessage", 36006, "MailIdMsg", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---删除邮件响应
---msgID: 36008
---@param msgID LuaEnumNetDef 消息ID
---@return mailV2.MailIdMsg C#数据结构
function networkRespond.OnResDeleteMailMessageReceived(msgID)
    ---@type mailV2.MailIdMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 36008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 36008 mailV2.MailIdMsg 删除邮件响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDeleteMailMessage", 36008, "MailIdMsg", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

