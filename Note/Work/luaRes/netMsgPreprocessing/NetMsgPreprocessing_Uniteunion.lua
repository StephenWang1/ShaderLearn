--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--uniteunion.xml

--region ID:1002001 ResAllUniteUnionMessage 返回所有同盟
---@param msgID LuaEnumNetDef 消息ID
---@param tblData uniteunionV2.AllUniteUnion lua table类型消息数据
---@param csData uniteunionV2.AllUniteUnion C# class类型消息数据
netMsgPreprocessing[1002001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        CS.CSScene.MainPlayerInfo.LeagueInfo:RefreshLeagueRank(csData)
    end
end
--endregion

--region ID:1002005 ResOneUniteUnionMessage 返回某个同盟
---@param msgID LuaEnumNetDef 消息ID
---@param tblData uniteunionV2.UniteUnionInfo lua table类型消息数据
---@param csData uniteunionV2.UniteUnionInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1002005] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:1002006 ResUniteUnionSealTowerRankMessage 返回封印塔联盟排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData uniteunionV2.ResUniteUnionSealTowerRank lua table类型消息数据
---@param csData uniteunionV2.ResUniteUnionSealTowerRank C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1002006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    luaclass.SealTowerDataInfo:RefreshSealTowerInfo(tblData)
end
--endregion

--region ID:1002009 ResSealTowerDonationMessage 返回封印塔捐献是否成功
---@param msgID LuaEnumNetDef 消息ID
---@param tblData uniteunionV2.ResSealTowerDonation lua table类型消息数据
---@param csData uniteunionV2.ResSealTowerDonation C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1002009] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:1002011 ResGetSealTowerMonsterPointMessage 返回前往击杀封印塔怪物
---@param msgID LuaEnumNetDef 消息ID
---@param tblData uniteunionV2.ResGetSealTowerMonsterPoint lua table类型消息数据
---@param csData uniteunionV2.ResGetSealTowerMonsterPoint C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1002011] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData ~= nil then
        local dot2 = CS.SFMiscBase.Dot2(tblData.x, tblData.y)
        CS.CSScene.MainPlayerInfo.AsyncOperationController.SealTowerFindPathOperation:DoOperation(tblData.monsterLid, tblData.mapId, dot2)
        uimanager:ClosePanel("UISealTowerPanel")
    end
end
--endregion
