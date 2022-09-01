--[[本文件为工具自动生成,禁止手动修改]]
--imprint.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回印记信息
---msgID: 120002
---@param msgID LuaEnumNetDef 消息ID
---@return imprintV2.ResImprintInfo C#数据结构
function networkRespond.OnResImprintInfoMessageReceived(msgID)
    ---@type imprintV2.ResImprintInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 120002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 120002 imprintV2.ResImprintInfo 返回印记信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.imprint ~= nil and  protobufMgr.DecodeTable.imprint.ResImprintInfo ~= nil then
        csData = protobufMgr.DecodeTable.imprint.ResImprintInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---镶嵌成功返回
---msgID: 120005
---@param msgID LuaEnumNetDef 消息ID
---@return imprintV2.ResPutOnImprint C#数据结构
function networkRespond.OnResPutOnImprintMessageReceived(msgID)
    ---@type imprintV2.ResPutOnImprint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 120005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 120005 imprintV2.ResPutOnImprint 镶嵌成功返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.imprint ~= nil and  protobufMgr.DecodeTable.imprint.ResPutOnImprint ~= nil then
        csData = protobufMgr.DecodeTable.imprint.ResPutOnImprint(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---取下成功返回
---msgID: 120006
---@param msgID LuaEnumNetDef 消息ID
---@return imprintV2.ResTakeOffImprint C#数据结构
function networkRespond.OnResTakeOffImprintMessageReceived(msgID)
    ---@type imprintV2.ResTakeOffImprint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 120006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 120006 imprintV2.ResTakeOffImprint 取下成功返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTakeOffImprintMessage", 120006, "ResTakeOffImprint", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

