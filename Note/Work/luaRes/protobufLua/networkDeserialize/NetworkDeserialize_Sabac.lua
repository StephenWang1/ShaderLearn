--[[本文件为工具自动生成,禁止手动修改]]
--sabac.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---请求排行榜
---msgID: 129002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacDonateRankInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 129002 sabacV2.ResSabacDonateRankInfo 请求排行榜")
        return nil
    end
    local res = protobufMgr.Deserialize("sabacV2.ResSabacDonateRankInfo", buffer)
    if protoAdjust.sabac_adj ~= nil and protoAdjust.sabac_adj.AdjustResSabacDonateRankInfo ~= nil then
        protoAdjust.sabac_adj.AdjustResSabacDonateRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 129002
    protobufMgr.mMsgDeserializedTblCache = res
end

