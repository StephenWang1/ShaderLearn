--[[本文件为工具自动生成,禁止手动修改]]
--tip.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---提示消息
---msgID: 7001
---@param msgID LuaEnumNetDef 消息ID
---@return tipV2.PromptMsg C#数据结构
function networkRespond.OnResPromptMessageReceived(msgID)
    ---@type tipV2.PromptMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 7001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 7001 tipV2.PromptMsg 提示消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.tip ~= nil and  protobufMgr.DecodeTable.tip.PromptMsg ~= nil then
        csData = protobufMgr.DecodeTable.tip.PromptMsg(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---提示气泡
---msgID: 7002
---@param msgID LuaEnumNetDef 消息ID
---@return tipV2.ResUIBubbleMsg C#数据结构
function networkRespond.OnResUIBubbleMessageReceived(msgID)
    ---@type tipV2.ResUIBubbleMsg
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 7002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 7002 tipV2.ResUIBubbleMsg 提示气泡")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.tip ~= nil and  protobufMgr.DecodeTable.tip.ResUIBubbleMsg ~= nil then
        csData = protobufMgr.DecodeTable.tip.ResUIBubbleMsg(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

