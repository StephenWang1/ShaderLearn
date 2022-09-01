--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--imprint.xml

--region ID:120002 ResImprintInfoMessage 返回印记信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData imprintV2.ResImprintInfo lua table类型消息数据
---@param csData imprintV2.ResImprintInfo C# class类型消息数据
netMsgPreprocessing[120002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.SignetV2:ResImprintInfo(csData)
end
--endregion

--region ID:120005 ResPutOnImprintMessage 镶嵌成功返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData imprintV2.ResPutOnImprint lua table类型消息数据
---@param csData imprintV2.ResPutOnImprint C# class类型消息数据
netMsgPreprocessing[120005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:120006 ResTakeOffImprintMessage 取下成功返回
---@param msgID LuaEnumNetDef 消息ID
---@param tblData imprintV2.ResTakeOffImprint lua table类型消息数据
---@param csData imprintV2.ResTakeOffImprint C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[120006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
