--[[本文件为工具自动生成,禁止手动修改]]
--duplicate.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---副本基本信息
---msgID: 71001
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDuplicateBasicInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71001 duplicateV2.ResDuplicateBasicInfo 副本基本信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDuplicateBasicInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDuplicateBasicInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResDuplicateBasicInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71001
    protobufMgr.mMsgDeserializedTblCache = res
end

---副本结束信息
---msgID: 71005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDuplicateEndMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71005 duplicateV2.ResDuplicateEnd 副本结束信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDuplicateEnd", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDuplicateEnd ~= nil then
        protoAdjust.duplicate_adj.AdjustResDuplicateEnd(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71005
    protobufMgr.mMsgDeserializedTblCache = res
end

---沙巴克信息
---msgID: 71015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71015 duplicateV2.SabacInfo 沙巴克信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.SabacInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustSabacInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustSabacInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71015
    protobufMgr.mMsgDeserializedTblCache = res
end

---雕像死亡
---msgID: 71016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFlagDieMessageReceived(msgID, buffer)
end

---沙巴克面板响应
---msgID: 71018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacPanelInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71018 duplicateV2.SabacPanelInfo 沙巴克面板响应")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.SabacPanelInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustSabacPanelInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustSabacPanelInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71018
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送暴君降临积分排名
---msgID: 71021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnTyrantDuplicateScoreMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71021 duplicateV2.TyrantDuplicateScore 发送暴君降临积分排名")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.TyrantDuplicateScore", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustTyrantDuplicateScore ~= nil then
        protoAdjust.duplicate_adj.AdjustTyrantDuplicateScore(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71021
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回暴君鼓舞
---msgID: 71023
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInspireBuffMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71023 duplicateV2.ResInspireBuff 返回暴君鼓舞")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResInspireBuff", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResInspireBuff ~= nil then
        protoAdjust.duplicate_adj.AdjustResInspireBuff(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71023
    protobufMgr.mMsgDeserializedTblCache = res
end

---暴君boss死亡发送消息
---msgID: 71024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTyrantDeathMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71024 duplicateV2.ResTyrantDeath 暴君boss死亡发送消息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResTyrantDeath", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResTyrantDeath ~= nil then
        protoAdjust.duplicate_adj.AdjustResTyrantDeath(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71024
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送副本道具信息
---msgID: 71025
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDuplicateItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71025 duplicateV2.ResDuplicateItem 发送副本道具信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDuplicateItem", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDuplicateItem ~= nil then
        protoAdjust.duplicate_adj.AdjustResDuplicateItem(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71025
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送玩家所在层数
---msgID: 71026
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDuplicateInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71026 duplicateV2.ResDuplicateInfo 发送玩家所在层数")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDuplicateInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDuplicateInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResDuplicateInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71026
    protobufMgr.mMsgDeserializedTblCache = res
end

---洞窟试炼返回玩家排行信息
---msgID: 71027
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCavesDuplicateRankInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71027 duplicateV2.CavesDuplicateRankInfo 洞窟试炼返回玩家排行信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.CavesDuplicateRankInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustCavesDuplicateRankInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustCavesDuplicateRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71027
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回洞窟试炼开启时间
---msgID: 71029
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCavesDuplicateInitTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71029 duplicateV2.CavesDuplicateInitTime 返回洞窟试炼开启时间")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.CavesDuplicateInitTime", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustCavesDuplicateInitTime ~= nil then
        protoAdjust.duplicate_adj.AdjustCavesDuplicateInitTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71029
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回神威狱开启时间
---msgID: 71030
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGodPowerMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71030 duplicateV2.ResGodPower 返回神威狱开启时间")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResGodPower", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResGodPower ~= nil then
        protoAdjust.duplicate_adj.AdjustResGodPower(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71030
    protobufMgr.mMsgDeserializedTblCache = res
end

---进入门票信息
---msgID: 71031
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResEntryTokenItemMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71031 duplicateV2.ResEntryTokenItem 进入门票信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResEntryTokenItem", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResEntryTokenItem ~= nil then
        protoAdjust.duplicate_adj.AdjustResEntryTokenItem(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71031
    protobufMgr.mMsgDeserializedTblCache = res
end

---狼烟梦境时间消息
---msgID: 71032
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResWolfDreamTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71032 duplicateV2.ResWolfDreamTime 狼烟梦境时间消息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResWolfDreamTime", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResWolfDreamTime ~= nil then
        protoAdjust.duplicate_adj.AdjustResWolfDreamTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71032
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送圣域空间次数
---msgID: 71034
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSanctuarySpaceInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71034 duplicateV2.ResSanctuarySpaceInfo 发送圣域空间次数")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResSanctuarySpaceInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResSanctuarySpaceInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResSanctuarySpaceInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71034
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回副本boss信息
---msgID: 71036
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDuplicateBossInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71036 duplicateV2.ResDuplicateBossInfo 返回副本boss信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDuplicateBossInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDuplicateBossInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResDuplicateBossInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71036
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回犯人剩余坐牢时间
---msgID: 71037
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPrisonRemainTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71037 duplicateV2.ResPrisonRemainTime 返回犯人剩余坐牢时间")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResPrisonRemainTime", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResPrisonRemainTime ~= nil then
        protoAdjust.duplicate_adj.AdjustResPrisonRemainTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71037
    protobufMgr.mMsgDeserializedTblCache = res
end

---沙巴克排名信息
---msgID: 71040
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacRankInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71040 duplicateV2.ResSabacRankInfo 沙巴克排名信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResSabacRankInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResSabacRankInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResSabacRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71040
    protobufMgr.mMsgDeserializedTblCache = res
end

---女神赐福信息
---msgID: 71042
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGoddessBlessingInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71042 duplicateV2.ResGoddessBlessingInfo 女神赐福信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResGoddessBlessingInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResGoddessBlessingInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResGoddessBlessingInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71042
    protobufMgr.mMsgDeserializedTblCache = res
end

---幻境迷宫消息
---msgID: 71043
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDreamlandInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71043 duplicateV2.ResDreamlandInfo 幻境迷宫消息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDreamlandInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDreamlandInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResDreamlandInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71043
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回幻境可传送层数
---msgID: 71044
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCanDeliveryMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71044 duplicateV2.ResCanDelivery 返回幻境可传送层数")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResCanDelivery", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResCanDelivery ~= nil then
        protoAdjust.duplicate_adj.AdjustResCanDelivery(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71044
    protobufMgr.mMsgDeserializedTblCache = res
end

---请求武道会下注
---msgID: 71048
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDuboLookBetMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71048 duplicateV2.ResBetPlayerInfo 请求武道会下注")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResBetPlayerInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResBetPlayerInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResBetPlayerInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71048
    protobufMgr.mMsgDeserializedTblCache = res
end

---响应查看武道会排行榜
---msgID: 71050
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLookDuboRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71050 duplicateV2.ResBudoRank 响应查看武道会排行榜")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResBudoRank", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResBudoRank ~= nil then
        protoAdjust.duplicate_adj.AdjustResBudoRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71050
    protobufMgr.mMsgDeserializedTblCache = res
end

---查看武道会阶段信息
---msgID: 71051
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBudoDuplicatePhaseInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71051 duplicateV2.BudoDuplicatePhaseInfo 查看武道会阶段信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.BudoDuplicatePhaseInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustBudoDuplicatePhaseInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustBudoDuplicatePhaseInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71051
    protobufMgr.mMsgDeserializedTblCache = res
end

---武道会玩家更新信息
---msgID: 71052
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBudoDuplicateUpdateInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71052 duplicateV2.BudoDuplicateUpdateInfo 武道会玩家更新信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.BudoDuplicateUpdateInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustBudoDuplicateUpdateInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustBudoDuplicateUpdateInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71052
    protobufMgr.mMsgDeserializedTblCache = res
end

---沙巴克法阵状态
---msgID: 71054
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacTacticsMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71054 duplicateV2.ResSabacTactics 沙巴克法阵状态")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResSabacTactics", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResSabacTactics ~= nil then
        protoAdjust.duplicate_adj.AdjustResSabacTactics(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71054
    protobufMgr.mMsgDeserializedTblCache = res
end

---沙巴克法阵激活失败
---msgID: 71056
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacTacticsFailMessageReceived(msgID, buffer)
end

---沙巴克法阵激活公告, 全服
---msgID: 71057
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacTacticsActivedMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71057 duplicateV2.ResSabacTacticsActived 沙巴克法阵激活公告, 全服")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResSabacTacticsActived", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResSabacTacticsActived ~= nil then
        protoAdjust.duplicate_adj.AdjustResSabacTacticsActived(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71057
    protobufMgr.mMsgDeserializedTblCache = res
end

---沙巴克法阵激活效果
---msgID: 71058
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacTacticsEffectMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71058 duplicateV2.ResSabacTacticsEffect 沙巴克法阵激活效果")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResSabacTacticsEffect", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResSabacTacticsEffect ~= nil then
        protoAdjust.duplicate_adj.AdjustResSabacTacticsEffect(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71058
    protobufMgr.mMsgDeserializedTblCache = res
end

---沙巴克积分信息
---msgID: 71059
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacScoreInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71059 duplicateV2.SabacScoreInfo 沙巴克积分信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.SabacScoreInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustSabacScoreInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustSabacScoreInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71059
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送众筹面板信息
---msgID: 71061
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCrowdFundingPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71061 duplicateV2.ResCrowdFundingPanel 发送众筹面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResCrowdFundingPanel", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResCrowdFundingPanel ~= nil then
        protoAdjust.duplicate_adj.AdjustResCrowdFundingPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71061
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送酬金金额变化
---msgID: 71064
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCrowdFundingChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71064 duplicateV2.ResCrowdFundingChange 发送酬金金额变化")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResCrowdFundingChange", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResCrowdFundingChange ~= nil then
        protoAdjust.duplicate_adj.AdjustResCrowdFundingChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71064
    protobufMgr.mMsgDeserializedTblCache = res
end

---掮客面板信息
---msgID: 71066
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBrokerPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71066 duplicateV2.ResBrokerPanel 掮客面板信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResBrokerPanel", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResBrokerPanel ~= nil then
        protoAdjust.duplicate_adj.AdjustResBrokerPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71066
    protobufMgr.mMsgDeserializedTblCache = res
end

---女神赐福排名信息
---msgID: 71069
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGoddessBlessingRankInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71069 duplicateV2.GoddessBlessingRankInfo 女神赐福排名信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.GoddessBlessingRankInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustGoddessBlessingRankInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustGoddessBlessingRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71069
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回玩家活动数据
---msgID: 71070
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPlayerActivityDataRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71070 duplicateV2.ResPlayerActivityDataRank 返回玩家活动数据")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResPlayerActivityDataRank", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResPlayerActivityDataRank ~= nil then
        protoAdjust.duplicate_adj.AdjustResPlayerActivityDataRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71070
    protobufMgr.mMsgDeserializedTblCache = res
end

---点赞返回
---msgID: 71072
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLikeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71072 duplicateV2.LikeResponseCommon 点赞返回")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.LikeResponseCommon", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustLikeResponseCommon ~= nil then
        protoAdjust.duplicate_adj.AdjustLikeResponseCommon(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71072
    protobufMgr.mMsgDeserializedTblCache = res
end

---弹出活动结算面板
---msgID: 71074
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnActivityEndRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71074 duplicateV2.ActivityEndRank 弹出活动结算面板")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ActivityEndRank", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustActivityEndRank ~= nil then
        protoAdjust.duplicate_adj.AdjustActivityEndRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71074
    protobufMgr.mMsgDeserializedTblCache = res
end

---女神赐福结束
---msgID: 71075
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGoddessBlessingEndMessageReceived(msgID, buffer)
end

---返回今日是否使用烟花
---msgID: 71077
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTodayUseFireworkMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71077 duplicateV2.ResTodayUseFirework 返回今日是否使用烟花")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResTodayUseFirework", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResTodayUseFirework ~= nil then
        protoAdjust.duplicate_adj.AdjustResTodayUseFirework(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71077
    protobufMgr.mMsgDeserializedTblCache = res
end

---活动往期时间响应
---msgID: 71079
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGBPreviousPeriodTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71079 duplicateV2.ResGBPreviousPeriodTime 活动往期时间响应")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResGBPreviousPeriodTime", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResGBPreviousPeriodTime ~= nil then
        protoAdjust.duplicate_adj.AdjustResGBPreviousPeriodTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71079
    protobufMgr.mMsgDeserializedTblCache = res
end

---往期女神赐福数据响应
---msgID: 71081
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGBPreviousPeriodInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71081 duplicateV2.GoddessBlessingRankInfo 往期女神赐福数据响应")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.GoddessBlessingRankInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustGoddessBlessingRankInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustGoddessBlessingRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71081
    protobufMgr.mMsgDeserializedTblCache = res
end

---沙巴克历史记录
---msgID: 71083
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacRecordMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71083 duplicateV2.ResSabacRecord 沙巴克历史记录")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResSabacRecord", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResSabacRecord ~= nil then
        protoAdjust.duplicate_adj.AdjustResSabacRecord(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71083
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回往期内容时间
---msgID: 71085
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResGetPreviousReviewMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71085 duplicateV2.ResGetPreviousReview 返回往期内容时间")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResGetPreviousReview", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResGetPreviousReview ~= nil then
        protoAdjust.duplicate_adj.AdjustResGetPreviousReview(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71085
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回幻境具体某一期的内容
---msgID: 71087
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDreamlandRankInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71087 duplicateV2.ResDreamlandRankInfo 返回幻境具体某一期的内容")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDreamlandRankInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDreamlandRankInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResDreamlandRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71087
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回武道会决赛圈
---msgID: 71090
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBudoMeetAroundMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71090 duplicateV2.ResBudoMeetAround 返回武道会决赛圈")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResBudoMeetAround", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResBudoMeetAround ~= nil then
        protoAdjust.duplicate_adj.AdjustResBudoMeetAround(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71090
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回恶魔广场结束时间
---msgID: 71091
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDevilSquareEndTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71091 duplicateV2.ResDevilSquareEndTime 返回恶魔广场结束时间")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDevilSquareEndTime", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDevilSquareEndTime ~= nil then
        protoAdjust.duplicate_adj.AdjustResDevilSquareEndTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71091
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回恶魔广场剩余时间
---msgID: 71093
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResDevilSquareHasTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71093 duplicateV2.ResDevilSquareHasTime 返回恶魔广场剩余时间")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResDevilSquareHasTime", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResDevilSquareHasTime ~= nil then
        protoAdjust.duplicate_adj.AdjustResDevilSquareHasTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71093
    protobufMgr.mMsgDeserializedTblCache = res
end

---使用恶魔卷轴后提示
---msgID: 71094
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUseDevilScrollPromptMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71094 duplicateV2.ResUseDevilScrollPrompt 使用恶魔卷轴后提示")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResUseDevilScrollPrompt", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResUseDevilScrollPrompt ~= nil then
        protoAdjust.duplicate_adj.AdjustResUseDevilScrollPrompt(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71094
    protobufMgr.mMsgDeserializedTblCache = res
end

---武道会押注信息
---msgID: 71096
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBudoBetBeiInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71096 duplicateV2.BudoBetBeiInfo 武道会押注信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.BudoBetBeiInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustBudoBetBeiInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustBudoBetBeiInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71096
    protobufMgr.mMsgDeserializedTblCache = res
end

---武道会押注成功信息
---msgID: 71097
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBudoBetSuccessMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71097 duplicateV2.BudoBetSuccess 武道会押注成功信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.BudoBetSuccess", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustBudoBetSuccess ~= nil then
        protoAdjust.duplicate_adj.AdjustBudoBetSuccess(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71097
    protobufMgr.mMsgDeserializedTblCache = res
end

---狼烟梦境放XP技能更改加速系数
---msgID: 71098
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResWolfDreamXpSkillChangeTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71098 duplicateV2.ResWolfDreamXpSkillChangeTime 狼烟梦境放XP技能更改加速系数")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResWolfDreamXpSkillChangeTime", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResWolfDreamXpSkillChangeTime ~= nil then
        protoAdjust.duplicate_adj.AdjustResWolfDreamXpSkillChangeTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71098
    protobufMgr.mMsgDeserializedTblCache = res
end

---地下行宫副本信息
---msgID: 71099
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUndergroundDuplicateInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71099 duplicateV2.UndergroundDuplicateInfo 地下行宫副本信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.UndergroundDuplicateInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustUndergroundDuplicateInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustUndergroundDuplicateInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71099
    protobufMgr.mMsgDeserializedTblCache = res
end

---推送地下行宫气泡消息
---msgID: 71100
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResPushBubbleMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71100 duplicateV2.PushBubble 推送地下行宫气泡消息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.PushBubble", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustPushBubble ~= nil then
        protoAdjust.duplicate_adj.AdjustPushBubble(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71100
    protobufMgr.mMsgDeserializedTblCache = res
end

---行宫我的帮会排名
---msgID: 71101
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUndergroundMyUnionRankMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71101 duplicateV2.UndergroundMyUnionRank 行宫我的帮会排名")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.UndergroundMyUnionRank", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustUndergroundMyUnionRank ~= nil then
        protoAdjust.duplicate_adj.AdjustUndergroundMyUnionRank(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71101
    protobufMgr.mMsgDeserializedTblCache = res
end

---夺宝奇兵副本信息
---msgID: 71102
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRaiderDuplicateInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71102 duplicateV2.RaiderInfo 夺宝奇兵副本信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.RaiderInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustRaiderInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustRaiderInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71102
    protobufMgr.mMsgDeserializedTblCache = res
end

---沙巴克个人积分排名信息
---msgID: 71103
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSabacPersonalRankInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71103 duplicateV2.ResSabacRankInfo 沙巴克个人积分排名信息")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResSabacRankInfo", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResSabacRankInfo ~= nil then
        protoAdjust.duplicate_adj.AdjustResSabacRankInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71103
    protobufMgr.mMsgDeserializedTblCache = res
end

---通天塔通关后获取到的奖励弹面板
---msgID: 71105
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResTowerInstanceEndGetRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 71105 duplicateV2.ResTowerInstanceEndGetReward 通天塔通关后获取到的奖励弹面板")
        return nil
    end
    local res = protobufMgr.Deserialize("duplicateV2.ResTowerInstanceEndGetReward", buffer)
    if protoAdjust.duplicate_adj ~= nil and protoAdjust.duplicate_adj.AdjustResTowerInstanceEndGetReward ~= nil then
        protoAdjust.duplicate_adj.AdjustResTowerInstanceEndGetReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 71105
    protobufMgr.mMsgDeserializedTblCache = res
end

