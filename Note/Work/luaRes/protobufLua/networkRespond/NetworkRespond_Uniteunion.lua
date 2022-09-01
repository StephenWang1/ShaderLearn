--[[本文件为工具自动生成,禁止手动修改]]
--uniteunion.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---返回所有同盟
---msgID: 1002001
---@param msgID LuaEnumNetDef 消息ID
---@return uniteunionV2.AllUniteUnion C#数据结构
function networkRespond.OnResAllUniteUnionMessageReceived(msgID)
    ---@type uniteunionV2.AllUniteUnion
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1002001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1002001 uniteunionV2.AllUniteUnion 返回所有同盟")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.uniteunion ~= nil and  protobufMgr.DecodeTable.uniteunion.AllUniteUnion ~= nil then
        csData = protobufMgr.DecodeTable.uniteunion.AllUniteUnion(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回某个同盟
---msgID: 1002005
---@param msgID LuaEnumNetDef 消息ID
---@return uniteunionV2.UniteUnionInfo C#数据结构
function networkRespond.OnResOneUniteUnionMessageReceived(msgID)
    ---@type uniteunionV2.UniteUnionInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1002005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1002005 uniteunionV2.UniteUnionInfo 返回某个同盟")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResOneUniteUnionMessage", 1002005, "UniteUnionInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回封印塔联盟排行
---msgID: 1002006
---@param msgID LuaEnumNetDef 消息ID
---@return uniteunionV2.ResUniteUnionSealTowerRank C#数据结构
function networkRespond.OnResUniteUnionSealTowerRankMessageReceived(msgID)
    ---@type uniteunionV2.ResUniteUnionSealTowerRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1002006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1002006 uniteunionV2.ResUniteUnionSealTowerRank 返回封印塔联盟排行")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUniteUnionSealTowerRankMessage", 1002006, "ResUniteUnionSealTowerRank", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回封印塔捐献是否成功
---msgID: 1002009
---@param msgID LuaEnumNetDef 消息ID
---@return uniteunionV2.ResSealTowerDonation C#数据结构
function networkRespond.OnResSealTowerDonationMessageReceived(msgID)
    ---@type uniteunionV2.ResSealTowerDonation
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1002009 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1002009 uniteunionV2.ResSealTowerDonation 返回封印塔捐献是否成功")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSealTowerDonationMessage", 1002009, "ResSealTowerDonation", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回前往击杀封印塔怪物
---msgID: 1002011
---@param msgID LuaEnumNetDef 消息ID
---@return uniteunionV2.ResGetSealTowerMonsterPoint C#数据结构
function networkRespond.OnResGetSealTowerMonsterPointMessageReceived(msgID)
    ---@type uniteunionV2.ResGetSealTowerMonsterPoint
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 1002011 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 1002011 uniteunionV2.ResGetSealTowerMonsterPoint 返回前往击杀封印塔怪物")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResGetSealTowerMonsterPointMessage", 1002011, "ResGetSealTowerMonsterPoint", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

