--[[本文件为工具自动生成,禁止手动修改]]
--mail.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---邮件列表响应
---msgID: 36002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMailListMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 36002 mailV2.MailList 邮件列表响应")
        return nil
    end
    local res = protobufMgr.Deserialize("mailV2.MailList", buffer)
    if protoAdjust.mail_adj ~= nil and protoAdjust.mail_adj.AdjustMailList ~= nil then
        protoAdjust.mail_adj.AdjustMailList(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 36002
    protobufMgr.mMsgDeserializedTblCache = res
end

---新邮件响应
---msgID: 36003
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResNewMailMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 36003 mailV2.MsgRemind 新邮件响应")
        return nil
    end
    local res = protobufMgr.Deserialize("mailV2.MsgRemind", buffer)
    if protoAdjust.mail_adj ~= nil and protoAdjust.mail_adj.AdjustMsgRemind ~= nil then
        protoAdjust.mail_adj.AdjustMsgRemind(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 36003
    protobufMgr.mMsgDeserializedTblCache = res
end

---提取物品响应
---msgID: 36006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetMailItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 36006 mailV2.MailIdMsg 提取物品响应")
        return nil
    end
    local res = protobufMgr.Deserialize("mailV2.MailIdMsg", buffer)
    if protoAdjust.mail_adj ~= nil and protoAdjust.mail_adj.AdjustMailIdMsg ~= nil then
        protoAdjust.mail_adj.AdjustMailIdMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 36006
    protobufMgr.mMsgDeserializedTblCache = res
end

---删除邮件响应
---msgID: 36008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDeleteMailMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 36008 mailV2.MailIdMsg 删除邮件响应")
        return nil
    end
    local res = protobufMgr.Deserialize("mailV2.MailIdMsg", buffer)
    if protoAdjust.mail_adj ~= nil and protoAdjust.mail_adj.AdjustMailIdMsg ~= nil then
        protoAdjust.mail_adj.AdjustMailIdMsg(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 36008
    protobufMgr.mMsgDeserializedTblCache = res
end

