--[[本文件为工具自动生成,禁止手动修改]]
--deliver.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---直接传送响应
---msgID: 72006
---@param msgID LuaEnumNetDef 消息ID
---@return deliverV2.DirectlyTransferRes C#数据结构
function networkRespond.OnResDirectlyTransferMessageReceived(msgID)
    ---@type deliverV2.DirectlyTransferRes
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 72006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 72006 deliverV2.DirectlyTransferRes 直接传送响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.deliver ~= nil and  protobufMgr.DecodeTable.deliver.DirectlyTransferRes ~= nil then
        csData = protobufMgr.DecodeTable.deliver.DirectlyTransferRes(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

