--[[本文件为工具自动生成,禁止手动修改]]
--uniteunion.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---返回所有同盟
---msgID: 1002001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResAllUniteUnionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1002001 uniteunionV2.AllUniteUnion 返回所有同盟")
        return nil
    end
    local res = protobufMgr.Deserialize("uniteunionV2.AllUniteUnion", buffer)
    if protoAdjust.uniteunion_adj ~= nil and protoAdjust.uniteunion_adj.AdjustAllUniteUnion ~= nil then
        protoAdjust.uniteunion_adj.AdjustAllUniteUnion(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1002001
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回某个同盟
---msgID: 1002005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResOneUniteUnionMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1002005 uniteunionV2.UniteUnionInfo 返回某个同盟")
        return nil
    end
    local res = protobufMgr.Deserialize("uniteunionV2.UniteUnionInfo", buffer)
    if protoAdjust.uniteunion_adj ~= nil and protoAdjust.uniteunion_adj.AdjustUniteUnionInfo ~= nil then
        protoAdjust.uniteunion_adj.AdjustUniteUnionInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1002005
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回封印塔联盟排行
---msgID: 1002006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUniteUnionSealTowerRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1002006 uniteunionV2.ResUniteUnionSealTowerRank 返回封印塔联盟排行")
        return nil
    end
    local res = protobufMgr.Deserialize("uniteunionV2.ResUniteUnionSealTowerRank", buffer)
    if protoAdjust.uniteunion_adj ~= nil and protoAdjust.uniteunion_adj.AdjustResUniteUnionSealTowerRank ~= nil then
        protoAdjust.uniteunion_adj.AdjustResUniteUnionSealTowerRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1002006
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回封印塔捐献是否成功
---msgID: 1002009
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSealTowerDonationMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1002009 uniteunionV2.ResSealTowerDonation 返回封印塔捐献是否成功")
        return nil
    end
    local res = protobufMgr.Deserialize("uniteunionV2.ResSealTowerDonation", buffer)
    if protoAdjust.uniteunion_adj ~= nil and protoAdjust.uniteunion_adj.AdjustResSealTowerDonation ~= nil then
        protoAdjust.uniteunion_adj.AdjustResSealTowerDonation(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1002009
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回前往击杀封印塔怪物
---msgID: 1002011
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetSealTowerMonsterPointMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 1002011 uniteunionV2.ResGetSealTowerMonsterPoint 返回前往击杀封印塔怪物")
        return nil
    end
    local res = protobufMgr.Deserialize("uniteunionV2.ResGetSealTowerMonsterPoint", buffer)
    if protoAdjust.uniteunion_adj ~= nil and protoAdjust.uniteunion_adj.AdjustResGetSealTowerMonsterPoint ~= nil then
        protoAdjust.uniteunion_adj.AdjustResGetSealTowerMonsterPoint(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 1002011
    protobufMgr.mMsgDeserializedTblCache = res
end

