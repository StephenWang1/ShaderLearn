--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--task.xml

--region ID:102022 ReqTaskSettingMessage 请求任务设置
---@param msgID LuaEnumNetDef 消息ID
---@param csData taskV2.TaskSetting lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[102022] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:102024 ReqEliteTaskBuyTimesMessage 购买精英任务
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[102024] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:102025 ReqEliteBuyPriceMessage 精英任务购买价格请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[102025] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:102031 ReqAccepNewDailyTaskMessage 请求领取每日任务
---@param msgID LuaEnumNetDef 消息ID
---@param csData taskV2.ReqAccepNewDailyTask lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[102031] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:102032 ReqSubmitNewDailyTaskMessage 请求提交每日任务
---@param msgID LuaEnumNetDef 消息ID
---@param csData taskV2.ReqSubmitNewDailyTask lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[102032] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:102026 ResEliteBuyPriceMessage 精英任务购买价格回复
---@param msgID LuaEnumNetDef 消息ID
---@param csData taskV2.ResEliteBuyPrice lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[102026] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]

--[[
--region ID:102019 ReqSubmitDailyItemMessage 提交日常任务物品
---@param msgID LuaEnumNetDef 消息ID
---@param csData taskV2.ReqSubmitDailyItem lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[102019] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
