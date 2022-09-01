--[[本文件为工具自动生成,禁止手动修改]]
--active.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---玩家活跃度
---msgID: 108001
---@param msgID LuaEnumNetDef 消息ID
---@return activeV2.ActiveInfo C#数据结构
function networkRespond.OnResActiveDataMessageReceived(msgID)
    ---@type activeV2.ActiveInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 108001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 108001 activeV2.ActiveInfo 玩家活跃度")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.active ~= nil and  protobufMgr.DecodeTable.active.ActiveInfo ~= nil then
        csData = protobufMgr.DecodeTable.active.ActiveInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

