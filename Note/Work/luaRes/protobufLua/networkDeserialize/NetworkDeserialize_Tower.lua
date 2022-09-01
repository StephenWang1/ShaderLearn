--[[本文件为工具自动生成,禁止手动修改]]
--tower.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送通天塔面板信息
---msgID: 54001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleTowerInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 54001 towerV2.ResRoleTowerInfo 发送通天塔面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("towerV2.ResRoleTowerInfo", buffer)
    if protoAdjust.tower_adj ~= nil and protoAdjust.tower_adj.AdjustResRoleTowerInfo ~= nil then
        protoAdjust.tower_adj.AdjustResRoleTowerInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 54001
    protobufMgr.mMsgDeserializedTblCache = res
end

