--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--store.xml

--region ID:16016 ReqSynthesisMessage 请求合成
---@param msgID LuaEnumNetDef 消息ID
---@param csData storeV2.ReqSynthesis lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[16016] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--[[
--region ID:16004 ReqBuyItemMessage 购买请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData storeV2.ReqBuyItem lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[16004] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
--]]
