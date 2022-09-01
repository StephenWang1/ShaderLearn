--[[本文件为工具自动生成,禁止手动修改]]
--servantcultivate.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---灵兽修炼信息
---msgID: 151002
---@param msgID LuaEnumNetDef 消息ID
---@return servantcultivateV2.resCultivateInfo C#数据结构
function networkRespond.OnResServantCultivateInfoMessageReceived(msgID)
    ---@type servantcultivateV2.resCultivateInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 151002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 151002 servantcultivateV2.resCultivateInfo 灵兽修炼信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResServantCultivateInfoMessage", 151002, "resCultivateInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---灵兽修炼小红点
---msgID: 151006
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResServantCultivateRedMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---灵兽修炼被攻击
---msgID: 151008
---@param msgID LuaEnumNetDef 消息ID
---@return servantcultivateV2.cultivateRedInfo C#数据结构
function networkRespond.OnResServantCultivateBeAttackMessageReceived(msgID)
    ---@type servantcultivateV2.cultivateRedInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 151008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 151008 servantcultivateV2.cultivateRedInfo 灵兽修炼被攻击")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResServantCultivateBeAttackMessage", 151008, "cultivateRedInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

