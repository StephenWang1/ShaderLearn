--[[本文件为工具自动生成,禁止手动修改]]
--vip.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---通知玩家vip等级发生变化
---msgID: 28005
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResRoleVipInfoChange C#数据结构
function networkRespond.OnResRoleVipInfoChangeMessageReceived(msgID)
    ---@type vipV2.ResRoleVipInfoChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28005 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28005 vipV2.ResRoleVipInfoChange 通知玩家vip等级发生变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleVipInfoChangeMessage", 28005, "ResRoleVipInfoChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---vip数据
---msgID: 28006
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResRoleVipInfo C#数据结构
function networkRespond.OnResRoleVipInfoMessageReceived(msgID)
    ---@type vipV2.ResRoleVipInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28006 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28006 vipV2.ResRoleVipInfo vip数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleVipInfoMessage", 28006, "ResRoleVipInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---vip领过的数据
---msgID: 28007
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResBuyVipReward C#数据结构
function networkRespond.OnResBuyVipRewardMessageReceived(msgID)
    ---@type vipV2.ResBuyVipReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28007 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28007 vipV2.ResBuyVipReward vip领过的数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResBuyVipRewardMessage", 28007, "ResBuyVipReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---vip领过的数据
---msgID: 28008
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResFreeVipReward C#数据结构
function networkRespond.OnResFreeVipRewardMessageReceived(msgID)
    ---@type vipV2.ResFreeVipReward
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28008 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28008 vipV2.ResFreeVipReward vip领过的数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResFreeVipRewardMessage", 28008, "ResFreeVipReward", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回商会界面
---msgID: 28012
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResCardPanel C#数据结构
function networkRespond.OnResMonthCardPanelMessageReceived(msgID)
    ---@type vipV2.ResCardPanel
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28012 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28012 vipV2.ResCardPanel 返回商会界面")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.vip ~= nil and  protobufMgr.DecodeTable.vip.ResCardPanel ~= nil then
        csData = protobufMgr.DecodeTable.vip.ResCardPanel(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回月卡信息
---msgID: 28013
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResCardInfo C#数据结构
function networkRespond.OnResMonthCardInfoMessageReceived(msgID)
    ---@type vipV2.ResCardInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28013 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28013 vipV2.ResCardInfo 返回月卡信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.vip ~= nil and  protobufMgr.DecodeTable.vip.ResCardInfo ~= nil then
        csData = protobufMgr.DecodeTable.vip.ResCardInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回月卡改变
---msgID: 28015
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResCardChange C#数据结构
function networkRespond.OnResMonthCardChangeMessageReceived(msgID)
    ---@type vipV2.ResCardChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28015 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28015 vipV2.ResCardChange 返回月卡改变")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.vip ~= nil and  protobufMgr.DecodeTable.vip.ResCardChange ~= nil then
        csData = protobufMgr.DecodeTable.vip.ResCardChange(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回月卡福利详情
---msgID: 28017
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResCardDayRewardInfo C#数据结构
function networkRespond.OnResCardDayRewardInfoMessageReceived(msgID)
    ---@type vipV2.ResCardDayRewardInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28017 vipV2.ResCardDayRewardInfo 返回月卡福利详情")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.vip ~= nil and  protobufMgr.DecodeTable.vip.ResCardDayRewardInfo ~= nil then
        csData = protobufMgr.DecodeTable.vip.ResCardDayRewardInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---返回使用月卡道具
---msgID: 28018
---@param msgID LuaEnumNetDef 消息ID
---@return nil
function networkRespond.OnResUseMonthCardItemMessageReceived(msgID)
    commonNetMsgDeal.DoCallback(msgID, nil, nil)
    return nil
end

---通知玩家vip2等级发生变化
---msgID: 28019
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResRoleVip2InfoChange C#数据结构
function networkRespond.OnResRoleVip2InfoChangeMessageReceived(msgID)
    ---@type vipV2.ResRoleVip2InfoChange
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28019 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28019 vipV2.ResRoleVip2InfoChange 通知玩家vip2等级发生变化")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleVip2InfoChangeMessage", 28019, "ResRoleVip2InfoChange", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---vip2数据
---msgID: 28020
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.ResRoleVip2Info C#数据结构
function networkRespond.OnResRoleVip2InfoMessageReceived(msgID)
    ---@type vipV2.ResRoleVip2Info
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28020 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28020 vipV2.ResRoleVip2Info vip2数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRoleVip2InfoMessage", 28020, "ResRoleVip2Info", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回超级会员数据
---msgID: 28022
---@param msgID LuaEnumNetDef 消息ID
---@return vipV2.VipMemberInfo C#数据结构
function networkRespond.OnResVipMemberInfoMessageReceived(msgID)
    ---@type vipV2.VipMemberInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 28022 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 28022 vipV2.VipMemberInfo 返回超级会员数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResVipMemberInfoMessage", 28022, "VipMemberInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

