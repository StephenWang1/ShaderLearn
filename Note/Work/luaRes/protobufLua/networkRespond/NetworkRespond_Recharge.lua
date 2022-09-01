--[[本文件为工具自动生成,禁止手动修改]]
--recharge.xml
local protobufMgr = protobufMgr
local commonNetMsgDeal = commonNetMsgDeal

---发送充值界面信息
---msgID: 39002
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResSendRechargeInfo C#数据结构
function networkRespond.OnResSendRechargeInfoMessageReceived(msgID)
    ---@type rechargeV2.ResSendRechargeInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39002 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39002 rechargeV2.ResSendRechargeInfo 发送充值界面信息")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    local csData
    if protobufMgr.DecodeTable.recharge ~= nil and  protobufMgr.DecodeTable.recharge.ResSendRechargeInfo ~= nil then
        csData = protobufMgr.DecodeTable.recharge.ResSendRechargeInfo(tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, csData)
    return csData
end

---发送终身限购列表
---msgID: 39016
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResLimitGiftBox C#数据结构
function networkRespond.OnResLimitGiftBoxMessageReceived(msgID)
    ---@type rechargeV2.ResLimitGiftBox
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39016 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39016 rechargeV2.ResLimitGiftBox 发送终身限购列表")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResLimitGiftBoxMessage", 39016, "ResLimitGiftBox", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---完成首充的时间
---msgID: 39017
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResCompleteFirstChargeTime C#数据结构
function networkRespond.OnResCompleteFirstChargeTimeMessageReceived(msgID)
    ---@type rechargeV2.ResCompleteFirstChargeTime
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39017 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39017 rechargeV2.ResCompleteFirstChargeTime 完成首充的时间")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCompleteFirstChargeTimeMessage", 39017, "ResCompleteFirstChargeTime", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回投资计划数据
---msgID: 39021
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResInvestPlanData C#数据结构
function networkRespond.OnResInvestPlanDataMessageReceived(msgID)
    ---@type rechargeV2.ResInvestPlanData
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39021 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39021 rechargeV2.ResInvestPlanData 返回投资计划数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResInvestPlanDataMessage", 39021, "ResInvestPlanData", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回某期投资计划数据
---msgID: 39024
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResInvestPlanInfo C#数据结构
function networkRespond.OnResInvestPlanInfoMessageReceived(msgID)
    ---@type rechargeV2.ResInvestPlanInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39024 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39024 rechargeV2.ResInvestPlanInfo 返回某期投资计划数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResInvestPlanInfoMessage", 39024, "ResInvestPlanInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回累计充值数据
---msgID: 39026
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResCumRechargeData C#数据结构
function networkRespond.OnResCumRechargeDataMessageReceived(msgID)
    ---@type rechargeV2.ResCumRechargeData
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39026 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39026 rechargeV2.ResCumRechargeData 返回累计充值数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCumRechargeDataMessage", 39026, "ResCumRechargeData", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回某期累计充值数据
---msgID: 39029
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResCumChargeInfo C#数据结构
function networkRespond.OnResCumChargeInfoMessageReceived(msgID)
    ---@type rechargeV2.ResCumChargeInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39029 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39029 rechargeV2.ResCumChargeInfo 返回某期累计充值数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCumChargeInfoMessage", 39029, "ResCumChargeInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回累计充值是否更新
---msgID: 39032
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.RewardState C#数据结构
function networkRespond.OnResIfCumRechargeUpdateMessageReceived(msgID)
    ---@type rechargeV2.RewardState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39032 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39032 rechargeV2.RewardState 返回累计充值是否更新")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResIfCumRechargeUpdateMessage", 39032, "RewardState", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---检测累计充值是否开启
---msgID: 39034
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.CumChargeOpen C#数据结构
function networkRespond.OnResCumChargeOpenMessageReceived(msgID)
    ---@type rechargeV2.CumChargeOpen
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39034 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39034 rechargeV2.CumChargeOpen 检测累计充值是否开启")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResCumChargeOpenMessage", 39034, "CumChargeOpen", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回某一类型的时装投资数据
---msgID: 39036
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResFashionInvest C#数据结构
function networkRespond.OnResFashionInvestMessageReceived(msgID)
    ---@type rechargeV2.ResFashionInvest
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39036 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39036 rechargeV2.ResFashionInvest 返回某一类型的时装投资数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResFashionInvestMessage", 39036, "ResFashionInvest", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---返回时装投资数据
---msgID: 39037
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.ResFashionInvestInfo C#数据结构
function networkRespond.OnResFashionInvestInfoMessageReceived(msgID)
    ---@type rechargeV2.ResFashionInvestInfo
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39037 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39037 rechargeV2.ResFashionInvestInfo 返回时装投资数据")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResFashionInvestInfoMessage", 39037, "ResFashionInvestInfo", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

---时装投资红点包
---msgID: 39039
---@param msgID LuaEnumNetDef 消息ID
---@return rechargeV2.RewardState C#数据结构
function networkRespond.OnResRedPointFashionInvestMessageReceived(msgID)
    ---@type rechargeV2.RewardState
    local tblData
    if protobufMgr.mMsgDeserializedIDCache == 39039 then
        tblData = protobufMgr.mMsgDeserializedTblCache
        protobufMgr.mMsgDeserializedTblCache = nil
    end
    if tblData == nil then
        CS.OnlineDebug.LogError("Lua消息内容为空\r\nID: 39039 rechargeV2.RewardState 时装投资红点包")
        commonNetMsgDeal.DoCallback(msgID, nil)
        return nil
    end
    ---消息不回写到C#中
    if isOpenLog then
        luaDebug.WriteNetMsgToLog("ResRedPointFashionInvestMessage", 39039, "RewardState", tblData)
    end
    commonNetMsgDeal.DoCallback(msgID, tblData, nil)
    return nil
end

