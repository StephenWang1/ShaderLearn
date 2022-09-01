--[[本文件为工具自动生成,禁止手动修改]]
--element.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送元素套装信息
---msgID: 110002
---@param msgID LuaEnumNetDef 消息ID
---@return elementV2.ResElementSuitInfo C#数据结构
function networkRespond.OnResElementSuitInfoMessageReceived(msgID)
    ---@type elementV2.ResElementSuitInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 110002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 110002 elementV2.ResElementSuitInfo 发送元素套装信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.element ~= nil and  protobufMgr.DecodeTable.element.ResElementSuitInfo ~= nil then
        csData = protobufMgr.DecodeTable.element.ResElementSuitInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

