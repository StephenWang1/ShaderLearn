--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--junxian.xml

--region ID:59001 ResRoundJunXianUpMessage 升级向周围玩家发送消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData junxianV2.ResRoundJunXianUp lua table类型消息数据
---@param csData junxianV2.ResRoundJunXianUp C# class类型消息数据
netMsgPreprocessing[59001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        local id = csData.rid
        local avtar = CS.CSScene.Sington:getAvatar(id)
        if avtar then
            avtar.BaseInfo.PrefixId = csData.thisJunXianId
        end
    end
end
--endregion

--region ID:59007 ResJunXianLevelMessage 军衔当前等级响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData junxianV2.ResJunXianLevel lua table类型消息数据
---@param csData junxianV2.ResJunXianLevel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[59007] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:59009 ResJunXianUpMessage 军衔升级响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData junxianV2.ResJunXianUp lua table类型消息数据
---@param csData junxianV2.ResJunXianUp C# class类型消息数据
netMsgPreprocessing[59009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        local id = CS.CSScene.MainPlayerInfo.ID
        local avtar = CS.CSScene.Sington:getAvatar(id)
        if avtar then
            avtar.BaseInfo.PrefixId = csData.thisJunXianId
        end
    end
end
--endregion
