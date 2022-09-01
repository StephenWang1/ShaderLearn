--[[本文件为工具自动生成,禁止手动修改]]
--play.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回客户端通用消息
---msgID: 73022
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCommonMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 73022 playV2.CommonInfo 返回客户端通用消息")
        return nil
    end
    local res = protobufMgr.Deserialize("playV2.CommonInfo", buffer)
    if protoAdjust.play_adj ~= nil and protoAdjust.play_adj.AdjustCommonInfo ~= nil then
        protoAdjust.play_adj.AdjustCommonInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 73022
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回客户端地图通用消息
---msgID: 73026
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMapCommonMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 73026 playV2.CommonInfo 返回客户端地图通用消息")
        return nil
    end
    local res = protobufMgr.Deserialize("playV2.CommonInfo", buffer)
    if protoAdjust.play_adj ~= nil and protoAdjust.play_adj.AdjustCommonInfo ~= nil then
        protoAdjust.play_adj.AdjustCommonInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 73026
    protobufMgr.mMsgDeserializedTblCache = res
end

---需要弹出攻击模式提示面板
---msgID: 73027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnNeedHasAttackModePanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 73027 playV2.NeedHasAttackModePanel 需要弹出攻击模式提示面板")
        return nil
    end
    local res = protobufMgr.Deserialize("playV2.NeedHasAttackModePanel", buffer)
    if protoAdjust.play_adj ~= nil and protoAdjust.play_adj.AdjustNeedHasAttackModePanel ~= nil then
        protoAdjust.play_adj.AdjustNeedHasAttackModePanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 73027
    protobufMgr.mMsgDeserializedTblCache = res
end

