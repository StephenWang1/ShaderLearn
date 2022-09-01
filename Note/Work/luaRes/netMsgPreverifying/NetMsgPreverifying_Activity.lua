--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--activity.xml

--region ID:4092 ReqTodayClosedActivitiesMessage 请求玩家上线今日已结束的活动type
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[4092] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:4096 ReqAllCalendarGiftStateMessage 请求全部历法下礼包状态
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[4096] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:4098 ReqReceiveCalendarGiftMessage 请求领取历法小礼包
---@param msgID LuaEnumNetDef 消息ID
---@param csData activityV2.ReqReceiveGift lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[4098] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:4102 ResLuckTurntableLotteryMessage 返回幸运转盘抽奖
---@param msgID LuaEnumNetDef 消息ID
---@param csData activityV2.LotteryReward lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[4102] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
