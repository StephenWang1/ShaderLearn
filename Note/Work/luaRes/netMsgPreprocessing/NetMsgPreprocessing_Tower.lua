--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--tower.xml

--region ID:54001 ResRoleTowerInfoMessage 发送通天塔面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData towerV2.ResRoleTowerInfo lua table类型消息数据
---@param csData towerV2.ResRoleTowerInfo C# class类型消息数据
netMsgPreprocessing[54001] = function(msgID, tblData, csData)
    if (tblData == nil) then
        return
    end
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.TowerInfoV2.ResTowerInfo = csData
    gameMgr:GetPlayerDataMgr():GetPlayerTowerInfo():SetPlayerTowerData(tblData)
    luaEventManager.DoDelayCallBack(LuaCEvent.Task_CrawlTower);
end
--endregion
