--[[本文件为工具自动生成,禁止手动修改]]
--junxian.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---升级向周围玩家发送消息
---msgID: 59001
---@param msgID LuaEnumNetDef 消息ID
---@return junxianV2.ResRoundJunXianUp C#数据结构
function networkRespond.OnResRoundJunXianUpMessageReceived(msgID)
    ---@type junxianV2.ResRoundJunXianUp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 59001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 59001 junxianV2.ResRoundJunXianUp 升级向周围玩家发送消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.junxian ~= nil and  protobufMgr.DecodeTable.junxian.ResRoundJunXianUp ~= nil then
        csData = protobufMgr.DecodeTable.junxian.ResRoundJunXianUp(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---军衔当前等级响应
---msgID: 59007
---@param msgID LuaEnumNetDef 消息ID
---@return junxianV2.ResJunXianLevel C#数据结构
function networkRespond.OnResJunXianLevelMessageReceived(msgID)
    ---@type junxianV2.ResJunXianLevel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 59007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 59007 junxianV2.ResJunXianLevel 军衔当前等级响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResJunXianLevelMessage", 59007, "ResJunXianLevel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---军衔升级响应
---msgID: 59009
---@param msgID LuaEnumNetDef 消息ID
---@return junxianV2.ResJunXianUp C#数据结构
function networkRespond.OnResJunXianUpMessageReceived(msgID)
    ---@type junxianV2.ResJunXianUp
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 59009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 59009 junxianV2.ResJunXianUp 军衔升级响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.junxian ~= nil and  protobufMgr.DecodeTable.junxian.ResJunXianUp ~= nil then
        csData = protobufMgr.DecodeTable.junxian.ResJunXianUp(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

