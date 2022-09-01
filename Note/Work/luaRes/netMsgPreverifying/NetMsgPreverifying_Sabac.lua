--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--sabac.xml

--region ID:129001 ReqSabacDonateRankInfoMessage 请求排行榜
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[129001] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:129003 ReqSabacDonateMessage 请求捐献
---@param msgID LuaEnumNetDef 消息ID
---@param csData sabacV2.ReqSabacDonate lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[129003] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
