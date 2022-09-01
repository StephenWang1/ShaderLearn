--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--trade.xml

--region ID:104001 ReqTradeMessage 请求进行交易
---@param msgID LuaEnumNetDef 消息ID
---@param csData tradeV2.ReqTrade lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[104001] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:104003 ReqAgreeTradeMessage 同意交易
---@param msgID LuaEnumNetDef 消息ID
---@param csData tradeV2.ReqAgreeTrade lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[104003] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:104006 ReqSetTradeProgressMessage 设置交易进度
---@param msgID LuaEnumNetDef 消息ID
---@param csData tradeV2.ReqSetTradeProgress lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[104006] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:104010 ReqAddItemToTradeMessage 添加物品请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData tradeV2.AddItemToTradeRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[104010] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:104011 ReqRemoveItemFromTradeMessage 去除物品请求
---@param msgID LuaEnumNetDef 消息ID
---@param csData tradeV2.RemoveItemFromTradeRequest lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[104011] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
