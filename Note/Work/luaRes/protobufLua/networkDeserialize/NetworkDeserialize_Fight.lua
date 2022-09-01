--[[本文件为工具自动生成,禁止手动修改]]
--fight.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---内功发生变化（用于单独的通知内功，内功回复）
---msgID: 69009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInnerChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 69009 fightV2.ResInnerChange 内功发生变化（用于单独的通知内功，内功回复）")
        return nil
    end
    local res = protobufMgr.Deserialize("fightV2.ResInnerChange", buffer)
    if protoAdjust.fight_adj ~= nil and protoAdjust.fight_adj.AdjustResInnerChange ~= nil then
        protoAdjust.fight_adj.AdjustResInnerChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 69009
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回秒杀提示
---msgID: 69015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLampCoreSeckillMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 69015 fightV2.ResLampCoreSeckill 返回秒杀提示")
        return nil
    end
    local res = protobufMgr.Deserialize("fightV2.ResLampCoreSeckill", buffer)
    if protoAdjust.fight_adj ~= nil and protoAdjust.fight_adj.AdjustResLampCoreSeckill ~= nil then
        protoAdjust.fight_adj.AdjustResLampCoreSeckill(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 69015
    protobufMgr.mMsgDeserializedTblCache = res
end

