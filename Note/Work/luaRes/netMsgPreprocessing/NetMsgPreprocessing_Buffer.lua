--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--buffer.xml

--region ID:130005 ResRageStateMessage 狂暴之力状态响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bufferV2.RageState lua table类型消息数据
---@param csData bufferV2.RageState C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[130005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
