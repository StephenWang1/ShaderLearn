--[[本文件为工具自动生成,禁止手动修改]]
--redbag.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---红包信息
---msgID: 109002
---@param msgID LuaEnumNetDef 消息ID
---@return redbagV2.RedBagInfo C#数据结构
function networkRespond.OnResRedBagInfoMessageReceived(msgID)
    ---@type redbagV2.RedBagInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 109002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 109002 redbagV2.RedBagInfo 红包信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRedBagInfoMessage", 109002, "RedBagInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---第一次红包信息
---msgID: 109006
---@param msgID LuaEnumNetDef 消息ID
---@return redbagV2.RedBagInfo C#数据结构
function networkRespond.OnResFirstRedBagMessageReceived(msgID)
    ---@type redbagV2.RedBagInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 109006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 109006 redbagV2.RedBagInfo 第一次红包信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResFirstRedBagMessage", 109006, "RedBagInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

