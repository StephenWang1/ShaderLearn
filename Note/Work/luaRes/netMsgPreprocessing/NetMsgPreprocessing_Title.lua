--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--title.xml

--region ID:33002 ResTitleListMessage 发送称号列表信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData titleV2.ResTitleList lua table类型消息数据
---@param csData titleV2.ResTitleList C# class类型消息数据
netMsgPreprocessing[33002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.mMainPlayerInfo.TitleInfoV2:ResetTitleInfo(csData.titleList)
end
--endregion

--region ID:33003 ResAddTitleMessage 获得称号
---@param msgID LuaEnumNetDef 消息ID
---@param tblData titleV2.TitleInfo lua table类型消息数据
---@param csData titleV2.TitleInfo C# class类型消息数据
netMsgPreprocessing[33003] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.mMainPlayerInfo.TitleInfoV2:AddTitleInfo(csData)
end
--endregion

--region ID:33004 ResRemoveTitleMessage 移除称号
---@param msgID LuaEnumNetDef 消息ID
---@param tblData titleV2.ResRemoveTitle lua table类型消息数据
---@param csData titleV2.ResRemoveTitle C# class类型消息数据
netMsgPreprocessing[33004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.mMainPlayerInfo.TitleInfoV2:RemoveTitleInfo(csData.titleId)
end
--endregion

--region ID:33006 ResPutOnTitleMessage 返回佩戴称号
---@param msgID LuaEnumNetDef 消息ID
---@param tblData titleV2.ResPutOnTitle lua table类型消息数据
---@param csData titleV2.ResPutOnTitle C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[33006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.mMainPlayerInfo.TitleInfoV2.TitleId = tblData.putOn.titleId
end
--endregion

--region ID:33008 ResPutOffTitleMessage 返回脱下称号
---@param msgID LuaEnumNetDef 消息ID
---@param tblData titleV2.ResPutOffTitle lua table类型消息数据
---@param csData titleV2.ResPutOffTitle C# class类型消息数据
netMsgPreprocessing[33008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.mMainPlayerInfo.TitleInfoV2.TitleId = 0
end
--endregion
