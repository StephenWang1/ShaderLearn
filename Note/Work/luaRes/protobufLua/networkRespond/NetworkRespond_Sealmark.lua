--[[本文件为工具自动生成,禁止手动修改]]
--sealmark.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回当前封号等级
---msgID: 85002
---@param msgID LuaEnumNetDef 消息ID
---@return sealmarkV2.ResSealMarkInfo C#数据结构
function networkRespond.OnResSealMarkInfoMessageReceived(msgID)
    ---@type sealmarkV2.ResSealMarkInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 85002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 85002 sealmarkV2.ResSealMarkInfo 返回当前封号等级")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSealMarkInfoMessage", 85002, "ResSealMarkInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

