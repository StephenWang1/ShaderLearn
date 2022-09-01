--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--imprint.xml

--region ID:120001 ReqImprintInfoMessage 请求印记信息
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[120001] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:120003 ReqPutOnImprintMessage 请求镶嵌
---@param msgID LuaEnumNetDef 消息ID
---@param csData imprintV2.ReqPutOnImprint lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[120003] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:120004 ReqTakeOffImprintMessage 请求取下
---@param msgID LuaEnumNetDef 消息ID
---@param csData imprintV2.ReqTakeOffImprint lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[120004] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
