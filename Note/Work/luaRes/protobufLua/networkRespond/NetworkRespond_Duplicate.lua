--[[本文件为工具自动生成,禁止手动修改]]
--duplicate.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---副本基本信息
---msgID: 71001
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDuplicateBasicInfo C#数据结构
function networkRespond.OnResDuplicateBasicInfoMessageReceived(msgID)
    ---@type duplicateV2.ResDuplicateBasicInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71001 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71001 duplicateV2.ResDuplicateBasicInfo 副本基本信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResDuplicateBasicInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResDuplicateBasicInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---副本结束信息
---msgID: 71005
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDuplicateEnd C#数据结构
function networkRespond.OnResDuplicateEndMessageReceived(msgID)
    ---@type duplicateV2.ResDuplicateEnd
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71005 duplicateV2.ResDuplicateEnd 副本结束信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDuplicateEndMessage", 71005, "ResDuplicateEnd", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---沙巴克信息
---msgID: 71015
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.SabacInfo C#数据结构
function networkRespond.OnResSabacInfoMessageReceived(msgID)
    ---@type duplicateV2.SabacInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71015 duplicateV2.SabacInfo 沙巴克信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.SabacInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.SabacInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---雕像死亡
---msgID: 71016
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResFlagDieMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---沙巴克面板响应
---msgID: 71018
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.SabacPanelInfo C#数据结构
function networkRespond.OnResSabacPanelInfoMessageReceived(msgID)
    ---@type duplicateV2.SabacPanelInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71018 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71018 duplicateV2.SabacPanelInfo 沙巴克面板响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSabacPanelInfoMessage", 71018, "SabacPanelInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送暴君降临积分排名
---msgID: 71021
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.TyrantDuplicateScore C#数据结构
function networkRespond.OnTyrantDuplicateScoreMessageReceived(msgID)
    ---@type duplicateV2.TyrantDuplicateScore
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71021 duplicateV2.TyrantDuplicateScore 发送暴君降临积分排名")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("TyrantDuplicateScoreMessage", 71021, "TyrantDuplicateScore", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回暴君鼓舞
---msgID: 71023
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResInspireBuff C#数据结构
function networkRespond.OnResInspireBuffMessageReceived(msgID)
    ---@type duplicateV2.ResInspireBuff
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71023 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71023 duplicateV2.ResInspireBuff 返回暴君鼓舞")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResInspireBuffMessage", 71023, "ResInspireBuff", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---暴君boss死亡发送消息
---msgID: 71024
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResTyrantDeath C#数据结构
function networkRespond.OnResTyrantDeathMessageReceived(msgID)
    ---@type duplicateV2.ResTyrantDeath
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71024 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71024 duplicateV2.ResTyrantDeath 暴君boss死亡发送消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTyrantDeathMessage", 71024, "ResTyrantDeath", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送副本道具信息
---msgID: 71025
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDuplicateItem C#数据结构
function networkRespond.OnResDuplicateItemMessageReceived(msgID)
    ---@type duplicateV2.ResDuplicateItem
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71025 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71025 duplicateV2.ResDuplicateItem 发送副本道具信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResDuplicateItem ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResDuplicateItem(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送玩家所在层数
---msgID: 71026
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDuplicateInfo C#数据结构
function networkRespond.OnResDuplicateInfoMessageReceived(msgID)
    ---@type duplicateV2.ResDuplicateInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71026 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71026 duplicateV2.ResDuplicateInfo 发送玩家所在层数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResDuplicateInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResDuplicateInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---洞窟试炼返回玩家排行信息
---msgID: 71027
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.CavesDuplicateRankInfo C#数据结构
function networkRespond.OnResCavesDuplicateRankInfoMessageReceived(msgID)
    ---@type duplicateV2.CavesDuplicateRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71027 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71027 duplicateV2.CavesDuplicateRankInfo 洞窟试炼返回玩家排行信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.CavesDuplicateRankInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.CavesDuplicateRankInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回洞窟试炼开启时间
---msgID: 71029
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.CavesDuplicateInitTime C#数据结构
function networkRespond.OnResCavesDuplicateInitTimeMessageReceived(msgID)
    ---@type duplicateV2.CavesDuplicateInitTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71029 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71029 duplicateV2.CavesDuplicateInitTime 返回洞窟试炼开启时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCavesDuplicateInitTimeMessage", 71029, "CavesDuplicateInitTime", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回神威狱开启时间
---msgID: 71030
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResGodPower C#数据结构
function networkRespond.OnResGodPowerMessageReceived(msgID)
    ---@type duplicateV2.ResGodPower
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71030 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71030 duplicateV2.ResGodPower 返回神威狱开启时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResGodPower ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResGodPower(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---进入门票信息
---msgID: 71031
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResEntryTokenItem C#数据结构
function networkRespond.OnResEntryTokenItemMessageReceived(msgID)
    ---@type duplicateV2.ResEntryTokenItem
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71031 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71031 duplicateV2.ResEntryTokenItem 进入门票信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResEntryTokenItem ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResEntryTokenItem(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---狼烟梦境时间消息
---msgID: 71032
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResWolfDreamTime C#数据结构
function networkRespond.OnResWolfDreamTimeMessageReceived(msgID)
    ---@type duplicateV2.ResWolfDreamTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71032 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71032 duplicateV2.ResWolfDreamTime 狼烟梦境时间消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResWolfDreamTime ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResWolfDreamTime(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送圣域空间次数
---msgID: 71034
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResSanctuarySpaceInfo C#数据结构
function networkRespond.OnResSanctuarySpaceInfoMessageReceived(msgID)
    ---@type duplicateV2.ResSanctuarySpaceInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71034 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71034 duplicateV2.ResSanctuarySpaceInfo 发送圣域空间次数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResSanctuarySpaceInfoMessage", 71034, "ResSanctuarySpaceInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回副本boss信息
---msgID: 71036
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDuplicateBossInfo C#数据结构
function networkRespond.OnResDuplicateBossInfoMessageReceived(msgID)
    ---@type duplicateV2.ResDuplicateBossInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71036 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71036 duplicateV2.ResDuplicateBossInfo 返回副本boss信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDuplicateBossInfoMessage", 71036, "ResDuplicateBossInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回犯人剩余坐牢时间
---msgID: 71037
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResPrisonRemainTime C#数据结构
function networkRespond.OnResPrisonRemainTimeMessageReceived(msgID)
    ---@type duplicateV2.ResPrisonRemainTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71037 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71037 duplicateV2.ResPrisonRemainTime 返回犯人剩余坐牢时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResPrisonRemainTime ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResPrisonRemainTime(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---沙巴克排名信息
---msgID: 71040
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResSabacRankInfo C#数据结构
function networkRespond.OnResSabacRankInfoMessageReceived(msgID)
    ---@type duplicateV2.ResSabacRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71040 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71040 duplicateV2.ResSabacRankInfo 沙巴克排名信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResSabacRankInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResSabacRankInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---女神赐福信息
---msgID: 71042
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResGoddessBlessingInfo C#数据结构
function networkRespond.OnResGoddessBlessingInfoMessageReceived(msgID)
    ---@type duplicateV2.ResGoddessBlessingInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71042 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71042 duplicateV2.ResGoddessBlessingInfo 女神赐福信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResGoddessBlessingInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResGoddessBlessingInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---幻境迷宫消息
---msgID: 71043
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDreamlandInfo C#数据结构
function networkRespond.OnResDreamlandInfoMessageReceived(msgID)
    ---@type duplicateV2.ResDreamlandInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71043 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71043 duplicateV2.ResDreamlandInfo 幻境迷宫消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResDreamlandInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResDreamlandInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回幻境可传送层数
---msgID: 71044
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResCanDelivery C#数据结构
function networkRespond.OnResCanDeliveryMessageReceived(msgID)
    ---@type duplicateV2.ResCanDelivery
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71044 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71044 duplicateV2.ResCanDelivery 返回幻境可传送层数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResCanDelivery ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResCanDelivery(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---请求武道会下注
---msgID: 71048
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResBetPlayerInfo C#数据结构
function networkRespond.OnResDuboLookBetMessageReceived(msgID)
    ---@type duplicateV2.ResBetPlayerInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71048 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71048 duplicateV2.ResBetPlayerInfo 请求武道会下注")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResBetPlayerInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResBetPlayerInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---响应查看武道会排行榜
---msgID: 71050
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResBudoRank C#数据结构
function networkRespond.OnResLookDuboRankMessageReceived(msgID)
    ---@type duplicateV2.ResBudoRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71050 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71050 duplicateV2.ResBudoRank 响应查看武道会排行榜")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResBudoRank ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResBudoRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---查看武道会阶段信息
---msgID: 71051
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.BudoDuplicatePhaseInfo C#数据结构
function networkRespond.OnResBudoDuplicatePhaseInfoMessageReceived(msgID)
    ---@type duplicateV2.BudoDuplicatePhaseInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71051 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71051 duplicateV2.BudoDuplicatePhaseInfo 查看武道会阶段信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.BudoDuplicatePhaseInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.BudoDuplicatePhaseInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---武道会玩家更新信息
---msgID: 71052
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.BudoDuplicateUpdateInfo C#数据结构
function networkRespond.OnResBudoDuplicateUpdateInfoMessageReceived(msgID)
    ---@type duplicateV2.BudoDuplicateUpdateInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71052 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71052 duplicateV2.BudoDuplicateUpdateInfo 武道会玩家更新信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.BudoDuplicateUpdateInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.BudoDuplicateUpdateInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---沙巴克法阵状态
---msgID: 71054
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResSabacTactics C#数据结构
function networkRespond.OnResSabacTacticsMessageReceived(msgID)
    ---@type duplicateV2.ResSabacTactics
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71054 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71054 duplicateV2.ResSabacTactics 沙巴克法阵状态")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResSabacTactics ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResSabacTactics(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---沙巴克法阵激活失败
---msgID: 71056
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResSabacTacticsFailMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---沙巴克法阵激活公告, 全服
---msgID: 71057
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResSabacTacticsActived C#数据结构
function networkRespond.OnResSabacTacticsActivedMessageReceived(msgID)
    ---@type duplicateV2.ResSabacTacticsActived
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71057 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71057 duplicateV2.ResSabacTacticsActived 沙巴克法阵激活公告, 全服")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResSabacTacticsActived ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResSabacTacticsActived(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---沙巴克法阵激活效果
---msgID: 71058
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResSabacTacticsEffect C#数据结构
function networkRespond.OnResSabacTacticsEffectMessageReceived(msgID)
    ---@type duplicateV2.ResSabacTacticsEffect
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71058 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71058 duplicateV2.ResSabacTacticsEffect 沙巴克法阵激活效果")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResSabacTacticsEffect ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResSabacTacticsEffect(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---沙巴克积分信息
---msgID: 71059
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.SabacScoreInfo C#数据结构
function networkRespond.OnResSabacScoreInfoMessageReceived(msgID)
    ---@type duplicateV2.SabacScoreInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71059 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71059 duplicateV2.SabacScoreInfo 沙巴克积分信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.SabacScoreInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.SabacScoreInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送众筹面板信息
---msgID: 71061
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResCrowdFundingPanel C#数据结构
function networkRespond.OnResCrowdFundingPanelMessageReceived(msgID)
    ---@type duplicateV2.ResCrowdFundingPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71061 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71061 duplicateV2.ResCrowdFundingPanel 发送众筹面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCrowdFundingPanelMessage", 71061, "ResCrowdFundingPanel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---发送酬金金额变化
---msgID: 71064
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResCrowdFundingChange C#数据结构
function networkRespond.OnResCrowdFundingChangeMessageReceived(msgID)
    ---@type duplicateV2.ResCrowdFundingChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71064 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71064 duplicateV2.ResCrowdFundingChange 发送酬金金额变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCrowdFundingChangeMessage", 71064, "ResCrowdFundingChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---掮客面板信息
---msgID: 71066
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResBrokerPanel C#数据结构
function networkRespond.OnResBrokerPanelMessageReceived(msgID)
    ---@type duplicateV2.ResBrokerPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71066 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71066 duplicateV2.ResBrokerPanel 掮客面板信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBrokerPanelMessage", 71066, "ResBrokerPanel", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---女神赐福排名信息
---msgID: 71069
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.GoddessBlessingRankInfo C#数据结构
function networkRespond.OnResGoddessBlessingRankInfoMessageReceived(msgID)
    ---@type duplicateV2.GoddessBlessingRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71069 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71069 duplicateV2.GoddessBlessingRankInfo 女神赐福排名信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.GoddessBlessingRankInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.GoddessBlessingRankInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回玩家活动数据
---msgID: 71070
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResPlayerActivityDataRank C#数据结构
function networkRespond.OnResPlayerActivityDataRankMessageReceived(msgID)
    ---@type duplicateV2.ResPlayerActivityDataRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71070 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71070 duplicateV2.ResPlayerActivityDataRank 返回玩家活动数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResPlayerActivityDataRank ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResPlayerActivityDataRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---点赞返回
---msgID: 71072
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.LikeResponseCommon C#数据结构
function networkRespond.OnResLikeMessageReceived(msgID)
    ---@type duplicateV2.LikeResponseCommon
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71072 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71072 duplicateV2.LikeResponseCommon 点赞返回")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.LikeResponseCommon ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.LikeResponseCommon(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---弹出活动结算面板
---msgID: 71074
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ActivityEndRank C#数据结构
function networkRespond.OnActivityEndRankMessageReceived(msgID)
    ---@type duplicateV2.ActivityEndRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71074 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71074 duplicateV2.ActivityEndRank 弹出活动结算面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ActivityEndRank ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ActivityEndRank(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---女神赐福结束
---msgID: 71075
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResGoddessBlessingEndMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---返回今日是否使用烟花
---msgID: 71077
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResTodayUseFirework C#数据结构
function networkRespond.OnResTodayUseFireworkMessageReceived(msgID)
    ---@type duplicateV2.ResTodayUseFirework
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71077 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71077 duplicateV2.ResTodayUseFirework 返回今日是否使用烟花")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResTodayUseFirework ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResTodayUseFirework(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---活动往期时间响应
---msgID: 71079
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResGBPreviousPeriodTime C#数据结构
function networkRespond.OnResGBPreviousPeriodTimeMessageReceived(msgID)
    ---@type duplicateV2.ResGBPreviousPeriodTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71079 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71079 duplicateV2.ResGBPreviousPeriodTime 活动往期时间响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResGBPreviousPeriodTime ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResGBPreviousPeriodTime(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---往期女神赐福数据响应
---msgID: 71081
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.GoddessBlessingRankInfo C#数据结构
function networkRespond.OnResGBPreviousPeriodInfoMessageReceived(msgID)
    ---@type duplicateV2.GoddessBlessingRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71081 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71081 duplicateV2.GoddessBlessingRankInfo 往期女神赐福数据响应")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.GoddessBlessingRankInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.GoddessBlessingRankInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---沙巴克历史记录
---msgID: 71083
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResSabacRecord C#数据结构
function networkRespond.OnResSabacRecordMessageReceived(msgID)
    ---@type duplicateV2.ResSabacRecord
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71083 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71083 duplicateV2.ResSabacRecord 沙巴克历史记录")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResSabacRecord ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResSabacRecord(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回往期内容时间
---msgID: 71085
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResGetPreviousReview C#数据结构
function networkRespond.OnResGetPreviousReviewMessageReceived(msgID)
    ---@type duplicateV2.ResGetPreviousReview
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71085 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71085 duplicateV2.ResGetPreviousReview 返回往期内容时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResGetPreviousReview ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResGetPreviousReview(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回幻境具体某一期的内容
---msgID: 71087
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDreamlandRankInfo C#数据结构
function networkRespond.OnResDreamlandRankInfoMessageReceived(msgID)
    ---@type duplicateV2.ResDreamlandRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71087 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71087 duplicateV2.ResDreamlandRankInfo 返回幻境具体某一期的内容")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResDreamlandRankInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResDreamlandRankInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回武道会决赛圈
---msgID: 71090
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResBudoMeetAround C#数据结构
function networkRespond.OnResBudoMeetAroundMessageReceived(msgID)
    ---@type duplicateV2.ResBudoMeetAround
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71090 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71090 duplicateV2.ResBudoMeetAround 返回武道会决赛圈")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBudoMeetAroundMessage", 71090, "ResBudoMeetAround", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回恶魔广场结束时间
---msgID: 71091
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDevilSquareEndTime C#数据结构
function networkRespond.OnResDevilSquareEndTimeMessageReceived(msgID)
    ---@type duplicateV2.ResDevilSquareEndTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71091 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71091 duplicateV2.ResDevilSquareEndTime 返回恶魔广场结束时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDevilSquareEndTimeMessage", 71091, "ResDevilSquareEndTime", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回恶魔广场剩余时间
---msgID: 71093
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResDevilSquareHasTime C#数据结构
function networkRespond.OnResDevilSquareHasTimeMessageReceived(msgID)
    ---@type duplicateV2.ResDevilSquareHasTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71093 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71093 duplicateV2.ResDevilSquareHasTime 返回恶魔广场剩余时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResDevilSquareHasTimeMessage", 71093, "ResDevilSquareHasTime", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---使用恶魔卷轴后提示
---msgID: 71094
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResUseDevilScrollPrompt C#数据结构
function networkRespond.OnResUseDevilScrollPromptMessageReceived(msgID)
    ---@type duplicateV2.ResUseDevilScrollPrompt
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71094 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71094 duplicateV2.ResUseDevilScrollPrompt 使用恶魔卷轴后提示")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUseDevilScrollPromptMessage", 71094, "ResUseDevilScrollPrompt", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---武道会押注信息
---msgID: 71096
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.BudoBetBeiInfo C#数据结构
function networkRespond.OnResBudoBetBeiInfoMessageReceived(msgID)
    ---@type duplicateV2.BudoBetBeiInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71096 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71096 duplicateV2.BudoBetBeiInfo 武道会押注信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBudoBetBeiInfoMessage", 71096, "BudoBetBeiInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---武道会押注成功信息
---msgID: 71097
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.BudoBetSuccess C#数据结构
function networkRespond.OnResBudoBetSuccessMessageReceived(msgID)
    ---@type duplicateV2.BudoBetSuccess
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71097 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71097 duplicateV2.BudoBetSuccess 武道会押注成功信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBudoBetSuccessMessage", 71097, "BudoBetSuccess", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---狼烟梦境放XP技能更改加速系数
---msgID: 71098
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResWolfDreamXpSkillChangeTime C#数据结构
function networkRespond.OnResWolfDreamXpSkillChangeTimeMessageReceived(msgID)
    ---@type duplicateV2.ResWolfDreamXpSkillChangeTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71098 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71098 duplicateV2.ResWolfDreamXpSkillChangeTime 狼烟梦境放XP技能更改加速系数")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResWolfDreamXpSkillChangeTimeMessage", 71098, "ResWolfDreamXpSkillChangeTime", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---地下行宫副本信息
---msgID: 71099
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.UndergroundDuplicateInfo C#数据结构
function networkRespond.OnResUndergroundDuplicateInfoMessageReceived(msgID)
    ---@type duplicateV2.UndergroundDuplicateInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71099 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71099 duplicateV2.UndergroundDuplicateInfo 地下行宫副本信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.UndergroundDuplicateInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.UndergroundDuplicateInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---推送地下行宫气泡消息
---msgID: 71100
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.PushBubble C#数据结构
function networkRespond.OnResPushBubbleMessageReceived(msgID)
    ---@type duplicateV2.PushBubble
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71100 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71100 duplicateV2.PushBubble 推送地下行宫气泡消息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResPushBubbleMessage", 71100, "PushBubble", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---行宫我的帮会排名
---msgID: 71101
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.UndergroundMyUnionRank C#数据结构
function networkRespond.OnResUndergroundMyUnionRankMessageReceived(msgID)
    ---@type duplicateV2.UndergroundMyUnionRank
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71101 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71101 duplicateV2.UndergroundMyUnionRank 行宫我的帮会排名")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResUndergroundMyUnionRankMessage", 71101, "UndergroundMyUnionRank", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---夺宝奇兵副本信息
---msgID: 71102
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.RaiderInfo C#数据结构
function networkRespond.OnResRaiderDuplicateInfoMessageReceived(msgID)
    ---@type duplicateV2.RaiderInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71102 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71102 duplicateV2.RaiderInfo 夺宝奇兵副本信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRaiderDuplicateInfoMessage", 71102, "RaiderInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---沙巴克个人积分排名信息
---msgID: 71103
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResSabacRankInfo C#数据结构
function networkRespond.OnResSabacPersonalRankInfoMessageReceived(msgID)
    ---@type duplicateV2.ResSabacRankInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71103 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71103 duplicateV2.ResSabacRankInfo 沙巴克个人积分排名信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.duplicate ~= nil and  protobufMgr.DecodeTable.duplicate.ResSabacRankInfo ~= nil then
        csData = protobufMgr.DecodeTable.duplicate.ResSabacRankInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---通天塔通关后获取到的奖励弹面板
---msgID: 71105
---@param msgID LuaEnumNetDef 消息ID
---@return duplicateV2.ResTowerInstanceEndGetReward C#数据结构
function networkRespond.OnResTowerInstanceEndGetRewardMessageReceived(msgID)
    ---@type duplicateV2.ResTowerInstanceEndGetReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 71105 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 71105 duplicateV2.ResTowerInstanceEndGetReward 通天塔通关后获取到的奖励弹面板")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResTowerInstanceEndGetRewardMessage", 71105, "ResTowerInstanceEndGetReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

