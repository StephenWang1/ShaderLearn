--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--deliver.xml

--region ID:72006 ResDirectlyTransferMessage 直接传送响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData deliverV2.DirectlyTransferRes lua table类型消息数据
---@param csData deliverV2.DirectlyTransferRes C# class类型消息数据
netMsgPreprocessing[72006] = function(msgID, tblData, csData)
    CS.CSMissionManager.Instance:ResDirectlyTransferMessage(csData);
end
--endregion

--[[
--region ID:72004 ResFlyToGoalMessage 小飞鞋响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[72004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
