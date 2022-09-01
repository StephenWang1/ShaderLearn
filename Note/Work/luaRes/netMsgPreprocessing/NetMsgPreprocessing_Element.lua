--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--element.xml

--region ID:110002 ResElementSuitInfoMessage 发送元素套装信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData elementV2.ResElementSuitInfo lua table类型消息数据
---@param csData elementV2.ResElementSuitInfo C# class类型消息数据
netMsgPreprocessing[110002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    --元素套装等级套装类型
    if tblData ~= nil then
        if CS.CSScene.Sington ~= nil then
            local avater = CS.CSScene.Sington:getAvatar(tblData.roleId)
            if avater ~= nil then
                local csAvaterExtData = avater.BaseInfo
                if csAvaterExtData ~= nil then
                    csAvaterExtData.SuitLevel = tblData.suitLevel
                    csAvaterExtData.SuitType = tblData.suitType
                end
            end
        end
    end
    if csData ~= nil then
        CS.CSScene.MainPlayerInfo.ElementInfo:UpdateElements(csData)
    end
end
--endregion
