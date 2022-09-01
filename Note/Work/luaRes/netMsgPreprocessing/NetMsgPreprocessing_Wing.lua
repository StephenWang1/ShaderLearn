--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--wing.xml

--region ID:18002 ResWingInfoMessage 发送光翼信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData wingV2.ResWingInfo lua table类型消息数据
---@param csData wingV2.ResWingInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[18002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:18004 ResLevelUpWingMessage 返回升级光翼
---@param msgID LuaEnumNetDef 消息ID
---@param tblData wingV2.ResLevelUpWing lua table类型消息数据
---@param csData wingV2.ResLevelUpWing C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[18004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
