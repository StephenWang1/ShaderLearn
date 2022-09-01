--[[本文件为工具自动生成,禁止手动修改]]
--zhenfa.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送阵法信息
---msgID: 131002
---@param msgID LuaEnumNetDef 消息ID
---@return zhenfaV2.ResZhenfaInfo C#数据结构
function networkRespond.OnResZhenfaInfoMessageReceived(msgID)
    ---@type zhenfaV2.ResZhenfaInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 131002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 131002 zhenfaV2.ResZhenfaInfo 发送阵法信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResZhenfaInfoMessage", 131002, "ResZhenfaInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

