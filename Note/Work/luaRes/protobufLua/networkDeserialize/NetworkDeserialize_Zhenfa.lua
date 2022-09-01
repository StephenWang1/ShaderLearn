--[[本文件为工具自动生成,禁止手动修改]]
--zhenfa.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送阵法信息
---msgID: 131002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResZhenfaInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 131002 zhenfaV2.ResZhenfaInfo 发送阵法信息")
        return nil
    end
    local res = protobufMgr.Deserialize("zhenfaV2.ResZhenfaInfo", buffer)
    if protoAdjust.zhenfa_adj ~= nil and protoAdjust.zhenfa_adj.AdjustResZhenfaInfo ~= nil then
        protoAdjust.zhenfa_adj.AdjustResZhenfaInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 131002
    protobufMgr.mMsgDeserializedTblCache = res
end

