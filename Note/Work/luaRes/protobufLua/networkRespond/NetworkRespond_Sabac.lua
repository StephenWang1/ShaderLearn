--[[本文件为工具自动生成,禁止手动修改]]
--sabac.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---请求排行榜
---msgID: 129002
---@param msgID LuaEnumNetDef 消息ID
---@return sabacV2.ResSabacDonateRankInfo C#数据结构
function networkRespond.OnResSabacDonateRankInfoMessageReceived(msgID)
    ---@type sabacV2.ResSabacDonateRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 129002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 129002 sabacV2.ResSabacDonateRankInfo 请求排行榜")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSabacDonateRankInfoMessage", 129002, "ResSabacDonateRankInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

