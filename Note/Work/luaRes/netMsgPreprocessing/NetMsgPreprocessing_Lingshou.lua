--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--lingshou.xml

--region ID:48018 ResLingShouTaskPanelMessage 请求灵兽任务面板
---@param msgID LuaEnumNetDef 消息ID
---@param tblData lingshouV2.ResLingShouTaskPanel lua table类型消息数据
---@param csData lingshouV2.ResLingShouTaskPanel C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[48018] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        --if CS.CSMissionManager.Instance.LsMisssionMgr then
        --    CS.CSMissionManager.Instance.LsMisssionMgr:RefershLsTaskPanelInfo(csData)
        --end
        if gameMgr:GetPlayerDataMgr() then
            gameMgr:GetPlayerDataMgr():GetLsMissionData():InitLsTaskData(tblData)
        end
    end
end
--endregion

--region ID:48019 ResLingShouTaskInfoMessage 更新灵兽任务信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData lingshouV2.ResLingShouTaskInfo lua table类型消息数据
---@param csData lingshouV2.ResLingShouTaskInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[48019] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        --if CS.CSMissionManager.Instance.LsMisssionMgr then
        --    CS.CSMissionManager.Instance.LsMisssionMgr:RefershLsTaskInfo(csData)
        --end
        if gameMgr:GetPlayerDataMgr() then
            gameMgr:GetPlayerDataMgr():GetLsMissionData():RefreshLsMission(tblData)
        end
    end

end
--endregion

--region ID:48020 ResLinshouSectionInfoMessage 更新灵兽章节信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData lingshouV2.ResLinshouSectionInfo lua table类型消息数据
---@param csData lingshouV2.ResLinshouSectionInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[48020] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        --if CS.CSMissionManager.Instance.LsMisssionMgr then
        --    CS.CSMissionManager.Instance.LsMisssionMgr:RefershLsSectionInfo(csData)
        --end

        if gameMgr:GetPlayerDataMgr() then
            gameMgr:GetPlayerDataMgr():GetLsMissionData():SetSecData(tblData)
        end
    end
end
--endregion

--region ID:48025 ResUnlockEffectMessage 解锁灵兽
---@param msgID LuaEnumNetDef 消息ID
---@param tblData lingshouV2.UnlockSecEffect lua table类型消息数据
---@param csData lingshouV2.UnlockSecEffect C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[48025] = function(msgID, tblData, csData)
    --在此处填入预处理代码

end
--endregion
