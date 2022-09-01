--[[本文件为工具自动生成,禁止手动修改]]
--socialcontact.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回送花
---msgID: 150002
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResSendFlowersMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---返回花的数量达到99或999
---msgID: 150005
---@param msgID LuaEnumNetDef 消息ID
---@return socialcontactV2.ResTeXiao C#数据结构
function networkRespond.OnResTeXiaoMessageReceived(msgID)
    ---@type socialcontactV2.ResTeXiao
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 150005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 150005 socialcontactV2.ResTeXiao 返回花的数量达到99或999")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTeXiaoMessage", 150005, "ResTeXiao", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

