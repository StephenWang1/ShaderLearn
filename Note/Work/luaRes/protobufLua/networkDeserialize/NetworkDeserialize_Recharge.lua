--[[本文件为工具自动生成,禁止手动修改]]
--recharge.xml
local protobufMgr = protobufMgr
local protoAdjust = protobufMgr.AdjustTable

---发送充值界面信息
---msgID: 39002
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResSendRechargeInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39002 rechargeV2.ResSendRechargeInfo 发送充值界面信息")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResSendRechargeInfo", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResSendRechargeInfo ~= nil then
        protoAdjust.recharge_adj.AdjustResSendRechargeInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39002
    protobufMgr.mMsgDeserializedTblCache = res
end

---发送终身限购列表
---msgID: 39016
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResLimitGiftBoxMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39016 rechargeV2.ResLimitGiftBox 发送终身限购列表")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResLimitGiftBox", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResLimitGiftBox ~= nil then
        protoAdjust.recharge_adj.AdjustResLimitGiftBox(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39016
    protobufMgr.mMsgDeserializedTblCache = res
end

---完成首充的时间
---msgID: 39017
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCompleteFirstChargeTimeMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39017 rechargeV2.ResCompleteFirstChargeTime 完成首充的时间")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResCompleteFirstChargeTime", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResCompleteFirstChargeTime ~= nil then
        protoAdjust.recharge_adj.AdjustResCompleteFirstChargeTime(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39017
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回投资计划数据
---msgID: 39021
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInvestPlanDataMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39021 rechargeV2.ResInvestPlanData 返回投资计划数据")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResInvestPlanData", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResInvestPlanData ~= nil then
        protoAdjust.recharge_adj.AdjustResInvestPlanData(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39021
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回某期投资计划数据
---msgID: 39024
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResInvestPlanInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39024 rechargeV2.ResInvestPlanInfo 返回某期投资计划数据")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResInvestPlanInfo", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResInvestPlanInfo ~= nil then
        protoAdjust.recharge_adj.AdjustResInvestPlanInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39024
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回累计充值数据
---msgID: 39026
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCumRechargeDataMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39026 rechargeV2.ResCumRechargeData 返回累计充值数据")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResCumRechargeData", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResCumRechargeData ~= nil then
        protoAdjust.recharge_adj.AdjustResCumRechargeData(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39026
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回某期累计充值数据
---msgID: 39029
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCumChargeInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39029 rechargeV2.ResCumChargeInfo 返回某期累计充值数据")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResCumChargeInfo", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResCumChargeInfo ~= nil then
        protoAdjust.recharge_adj.AdjustResCumChargeInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39029
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回累计充值是否更新
---msgID: 39032
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResIfCumRechargeUpdateMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39032 rechargeV2.RewardState 返回累计充值是否更新")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.RewardState", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustRewardState ~= nil then
        protoAdjust.recharge_adj.AdjustRewardState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39032
    protobufMgr.mMsgDeserializedTblCache = res
end

---检测累计充值是否开启
---msgID: 39034
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResCumChargeOpenMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39034 rechargeV2.CumChargeOpen 检测累计充值是否开启")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.CumChargeOpen", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustCumChargeOpen ~= nil then
        protoAdjust.recharge_adj.AdjustCumChargeOpen(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39034
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回某一类型的时装投资数据
---msgID: 39036
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFashionInvestMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39036 rechargeV2.ResFashionInvest 返回某一类型的时装投资数据")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResFashionInvest", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResFashionInvest ~= nil then
        protoAdjust.recharge_adj.AdjustResFashionInvest(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39036
    protobufMgr.mMsgDeserializedTblCache = res
end

---返回时装投资数据
---msgID: 39037
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResFashionInvestInfoMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39037 rechargeV2.ResFashionInvestInfo 返回时装投资数据")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.ResFashionInvestInfo", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustResFashionInvestInfo ~= nil then
        protoAdjust.recharge_adj.AdjustResFashionInvestInfo(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39037
    protobufMgr.mMsgDeserializedTblCache = res
end

---时装投资红点包
---msgID: 39039
---@param msgID LuaEnumNetDef 消息ID
---@param buffer string 消息内容
function networkDeserialize.OnResRedPointFashionInvestMessageReceived(msgID, buffer)
    if buffer == nil then
        CS.OnlineDebug.LogError("Lua解析消息: 待解析内容为空\r\nID: 39039 rechargeV2.RewardState 时装投资红点包")
        return nil
    end
    local res = protobufMgr.Deserialize("rechargeV2.RewardState", buffer)
    if protoAdjust.recharge_adj ~= nil and protoAdjust.recharge_adj.AdjustRewardState ~= nil then
        protoAdjust.recharge_adj.AdjustRewardState(res)
    end
    protobufMgr.mMsgDeserializedIDCache = 39039
    protobufMgr.mMsgDeserializedTblCache = res
end

