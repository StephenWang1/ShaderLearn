--[[本文件为工具自动生成]]
--[[本文件用于向服务器发送消息前,对发送的消息进行预校验,返回的bool值决定该消息是否应当发送,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--servantcultivate.xml

--region ID:151001 ReqServantCultivateBeginMessage 灵兽开始修炼
---@param msgID LuaEnumNetDef 消息ID
---@param csData servantcultivateV2.reqCultivateInfo lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[151001] = function(msgID, csData)
    --在此处填入预校验代码

    return true
end
--endregion

--region ID:151003 ReqServantCultivateStopMessage 灵兽结束修炼
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[151003] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:151004 ReqServantCultivateTakeMessage 灵兽提取经验
---@param msgID LuaEnumNetDef 消息ID
---@param csData userdata C# class类型消息数据(nil)
---@return boolean 是否允许发送消息
netMsgPreverifying[151004] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion

--region ID:151005 ReqServantCultivateOpenDlgMessage 灵兽修炼界面打开
---@param msgID LuaEnumNetDef 消息ID
---@param csData servantcultivateV2.reqOpenDlg lua类型消息数据
---@return boolean 是否允许发送消息
netMsgPreverifying[151005] = function(msgID, csData)
    --在此处填入预校验代码
    return true
end
--endregion
