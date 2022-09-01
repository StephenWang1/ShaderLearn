--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--share.xml

--region ID:1003001 ResEnterShareMapMessage 返回进入共享服的信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData shareV2.EnterShareMapInfo lua table类型消息数据
---@param csData shareV2.EnterShareMapInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1003001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetLeagueInfo():RefreshLeagueInfo(tblData)
    if tblData then
        CS.CSScene.MainPlayerInfo.LeagueInfo.LeagueType = tblData.uniteUnionType
    end
end
--endregion

--region ID:1003002 ResRoleUniteTypeMessage 角色联盟类型信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData uniteunionV2.ResRoleUniteType lua table类型消息数据
---@param csData uniteunionV2.ResRoleUniteType C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[1003002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if tblData then
        local avatar = CS.CSScene.Sington:getAvatar(tblData.roleId)
        if avatar then
            avatar.BaseInfo.LeagueInfo.LeagueType = tblData.uniteType
        end
    end
end
--endregion
