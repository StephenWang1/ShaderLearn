--[[本文件为工具自动生成,禁止手动修改]]
--count.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回数量的列表
---msgID: 21001
---@param msgID LuaEnumNetDef 消息ID
---@return countV2.ResCountData C#数据结构
function networkRespond.OnResCountDataMessageReceived(msgID)
    ---@type countV2.ResCountData
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 21001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 21001 countV2.ResCountData 返回数量的列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.count ~= nil and  protobufMgr.DecodeTable.count.ResCountData ~= nil then
        csData = protobufMgr.DecodeTable.count.ResCountData(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回数量变化的消息
---msgID: 21002
---@param msgID LuaEnumNetDef 消息ID
---@return countV2.ResCountChange C#数据结构
function networkRespond.OnResCountChangeMessageReceived(msgID)
    ---@type countV2.ResCountChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 21002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 21002 countV2.ResCountChange 返回数量变化的消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCountChangeMessage", 21002, "ResCountChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---道具共享使用上限(已使用次数)
---msgID: 21004
---@param msgID LuaEnumNetDef 消息ID
---@return countV2.ResCountShareUsed C#数据结构
function networkRespond.OnResCountShareUsedLimitMessageReceived(msgID)
    ---@type countV2.ResCountShareUsed
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 21004 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 21004 countV2.ResCountShareUsed 道具共享使用上限(已使用次数)")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCountShareUsedLimitMessage", 21004, "ResCountShareUsed", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

