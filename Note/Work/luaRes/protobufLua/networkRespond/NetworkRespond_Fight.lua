--[[本文件为工具自动生成,禁止手动修改]]
--fight.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---内功发生变化（用于单独的通知内功，内功回复）
---msgID: 69009
---@param msgID LuaEnumNetDef 消息ID
---@return fightV2.ResInnerChange C#数据结构
function networkRespond.OnResInnerChangeMessageReceived(msgID)
    ---@type fightV2.ResInnerChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 69009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 69009 fightV2.ResInnerChange 内功发生变化（用于单独的通知内功，内功回复）")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResInnerChangeMessage", 69009, "ResInnerChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回秒杀提示
---msgID: 69015
---@param msgID LuaEnumNetDef 消息ID
---@return fightV2.ResLampCoreSeckill C#数据结构
function networkRespond.OnResLampCoreSeckillMessageReceived(msgID)
    ---@type fightV2.ResLampCoreSeckill
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 69015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 69015 fightV2.ResLampCoreSeckill 返回秒杀提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLampCoreSeckillMessage", 69015, "ResLampCoreSeckill", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

