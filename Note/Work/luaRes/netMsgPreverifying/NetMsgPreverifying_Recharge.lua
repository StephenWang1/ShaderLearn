--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--recharge.xml

--region ID:39014 ReqRechargeEntranceMessage 充值入口
---@param msgID LuaEnumNetDef 消息ID
---@param csData rechargeV2.ReqRechargeEntrance lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[39014] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:39019 ReqBuyInvestPlanMessage 请求购买投资计划
---@param msgID LuaEnumNetDef 消息ID
---@param csData rechargeV2.ReqBuyInvestPlanRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[39019] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:39020 ReqReceiveInvestMessage 领取投资奖励
---@param msgID LuaEnumNetDef 消息ID
---@param csData rechargeV2.ReqReceiveInvestRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[39020] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:39022 ReqInvestPlanDataMessage 请求投资计划数据
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[39022] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:39023 ReqInvestPlanInfoMessage 请求某期投资计划数据
---@param msgID LuaEnumNetDef 消息ID
---@param csData rechargeV2.ReqGetInvestPlanRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[39023] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:39025 ReqFirstRechargeGiveMessage 领取累计充值奖励
---@param msgID LuaEnumNetDef 消息ID
---@param csData rechargeV2.ReqReceiveCumRechargeRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[39025] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:39035 ReqActiveFashionInvestMessage 激活某一类型的时装投资
---@param msgID LuaEnumNetDef 消息ID
---@param csData rechargeV2.ReqActiveFashionInvest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[39035] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:39038 ReqReceiveFashionInvestMessage 领取时装投资奖励
---@param msgID LuaEnumNetDef 消息ID
---@param csData rechargeV2.ReqReceiveFashionInvest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[39038] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
