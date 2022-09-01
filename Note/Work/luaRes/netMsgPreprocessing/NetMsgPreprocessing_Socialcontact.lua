--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--socialcontact.xml

--region ID:150002 ResSendFlowersMessage 返回送花
---@param msgID LuaEnumNetDef 消息ID
---@param tblData table lua table类型消息数据
---@param csData userdata C# class类型消息数据(nil)
netMsgPreprocessing[150002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:150005 ResTeXiaoMessage 返回花的数量达到99或999
---@param msgID LuaEnumNetDef 消息ID
---@param tblData socialcontactV2.ResTeXiao lua table类型消息数据
---@param csData socialcontactV2.ResTeXiao C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[150005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData and tblData.itemId then
        local effectId = ""
        local flowerId = tblData.itemId
        if flowerId == LuaEnumFlowerType.SecondRose then
            effectId = "700060"
        elseif flowerId == LuaEnumFlowerType.SecondGoldOrchid then
            effectId = "700063"
        elseif flowerId == LuaEnumFlowerType .ThirdRose then
            effectId = "700059"
        elseif flowerId == LuaEnumFlowerType.ThirdGoldOrchid then
            effectId = "700064"
        end
        if luaEventManager.HasCallback(LuaCEvent.SceneEffect_ShowEffect) then
            luaEventManager.DoCallback(LuaCEvent.SceneEffect_ShowEffect, { sceneEffectId = effectId, showCount = tblData.count,showFlowerId = flowerId })
        end
    end
end
--endregion

--[[
--region ID:150004 ResGetTheFlowerCountMessage 返回花的数量
---@param msgID LuaEnumNetDef 消息ID
---@param tblData socialcontactV2.ResGetTheFlowerCount lua table类型消息数据
---@param csData socialcontactV2.ResGetTheFlowerCount C# class类型消息数据
netMsgPreprocessing[150004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]
