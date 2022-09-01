--[[本文件为工具自动生成,禁止手动修改]]
--sharesocialcontact.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回客户端通用消息
---msgID: 1500012
---@param msgID LuaEnumNetDef 消息ID
---@return playV2.CommonInfo C#数据结构
function networkRespond.OnResShareCommonMessageReceived(msgID)
    ---@type playV2.CommonInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1500012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1500012 playV2.CommonInfo 返回客户端通用消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResShareCommonMessage", 1500012, "CommonInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

