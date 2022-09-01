--[[本文件为工具自动生成,禁止手动修改]]
--vip.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---通知玩家vip等级发生变化
---msgID: 28005
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleVipInfoChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28005 vipV2.ResRoleVipInfoChange 通知玩家vip等级发生变化")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResRoleVipInfoChange", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResRoleVipInfoChange ~= nil then
        protoAdjust.vip_adj.AdjustResRoleVipInfoChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28005
    protobufMgr.mMsgDeserializedTblCache = res
end

---vip数据
---msgID: 28006
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleVipInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28006 vipV2.ResRoleVipInfo vip数据")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResRoleVipInfo", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResRoleVipInfo ~= nil then
        protoAdjust.vip_adj.AdjustResRoleVipInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28006
    protobufMgr.mMsgDeserializedTblCache = res
end

---vip领过的数据
---msgID: 28007
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResBuyVipRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28007 vipV2.ResBuyVipReward vip领过的数据")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResBuyVipReward", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResBuyVipReward ~= nil then
        protoAdjust.vip_adj.AdjustResBuyVipReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28007
    protobufMgr.mMsgDeserializedTblCache = res
end

---vip领过的数据
---msgID: 28008
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFreeVipRewardMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28008 vipV2.ResFreeVipReward vip领过的数据")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResFreeVipReward", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResFreeVipReward ~= nil then
        protoAdjust.vip_adj.AdjustResFreeVipReward(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28008
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回商会界面
---msgID: 28012
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMonthCardPanelMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28012 vipV2.ResCardPanel 返回商会界面")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResCardPanel", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResCardPanel ~= nil then
        protoAdjust.vip_adj.AdjustResCardPanel(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28012
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回月卡信息
---msgID: 28013
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMonthCardInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28013 vipV2.ResCardInfo 返回月卡信息")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResCardInfo", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResCardInfo ~= nil then
        protoAdjust.vip_adj.AdjustResCardInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28013
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回月卡改变
---msgID: 28015
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResMonthCardChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28015 vipV2.ResCardChange 返回月卡改变")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResCardChange", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResCardChange ~= nil then
        protoAdjust.vip_adj.AdjustResCardChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28015
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回月卡福利详情
---msgID: 28017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCardDayRewardInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28017 vipV2.ResCardDayRewardInfo 返回月卡福利详情")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResCardDayRewardInfo", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResCardDayRewardInfo ~= nil then
        protoAdjust.vip_adj.AdjustResCardDayRewardInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28017
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回使用月卡道具
---msgID: 28018
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResUseMonthCardItemMessageReceived(msgID, buffer)
end

---通知玩家vip2等级发生变化
---msgID: 28019
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleVip2InfoChangeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28019 vipV2.ResRoleVip2InfoChange 通知玩家vip2等级发生变化")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResRoleVip2InfoChange", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResRoleVip2InfoChange ~= nil then
        protoAdjust.vip_adj.AdjustResRoleVip2InfoChange(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28019
    protobufMgr.mMsgDeserializedTblCache = res
end

---vip2数据
---msgID: 28020
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRoleVip2InfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28020 vipV2.ResRoleVip2Info vip2数据")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.ResRoleVip2Info", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustResRoleVip2Info ~= nil then
        protoAdjust.vip_adj.AdjustResRoleVip2Info(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28020
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回超级会员数据
---msgID: 28022
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResVipMemberInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 28022 vipV2.VipMemberInfo 返回超级会员数据")
        return nil
    end
    local res = protobufMgr.Deserialize("vipV2.VipMemberInfo", buffer)
    if protoAdjust.vip_adj ~= nil and protoAdjust.vip_adj.AdjustVipMemberInfo ~= nil then
        protoAdjust.vip_adj.AdjustVipMemberInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 28022
    protobufMgr.mMsgDeserializedTblCache = res
end

