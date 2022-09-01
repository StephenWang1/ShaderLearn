--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--tip.xml

--region ID:7001 ResPromptMessage 提示消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData tipV2.PromptMsg lua table类型消息数据
---@param csData tipV2.PromptMsg C# class类型消息数据
netMsgPreprocessing[7001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:7002 ResUIBubbleMessage 提示气泡
---@param msgID LuaEnumNetDef 消息ID
---@param tblData tipV2.ResUIBubbleMsg lua table类型消息数据
---@param csData tipV2.ResUIBubbleMsg C# class类型消息数据
netMsgPreprocessing[7002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil then
        Utility.ReceiveServerPromptTipsPanel(tblData.id,tblData.msg)
    end
end
--endregion
