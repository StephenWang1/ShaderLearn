--[[本文件为工具自动生成,禁止手动修改]]
--socialcontact.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回送花
---msgID: 150002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendFlowersMessageReceived(msgID, buffer)
end

---返回花的数量达到99或999
---msgID: 150005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTeXiaoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 150005 socialcontactV2.ResTeXiao 返回花的数量达到99或999")
        return nil
    end
    local res = protobufMgr.Deserialize("socialcontactV2.ResTeXiao", buffer)
    if protoAdjust.socialcontact_adj ~= nil and protoAdjust.socialcontact_adj.AdjustResTeXiao ~= nil then
        protoAdjust.socialcontact_adj.AdjustResTeXiao(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 150005
    protobufMgr.mMsgDeserializedTblCache = res
end

