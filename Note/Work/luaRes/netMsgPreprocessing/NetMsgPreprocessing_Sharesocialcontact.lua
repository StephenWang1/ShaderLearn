--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--sharesocialcontact.xml

--region ID:1500012 ResShareCommonMessage 返回客户端通用消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData playV2.CommonInfo lua table类型消息数据
---@param csData playV2.CommonInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1500012] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
