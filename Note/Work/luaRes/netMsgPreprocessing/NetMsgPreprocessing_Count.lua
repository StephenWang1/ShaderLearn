--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--count.xml

--region ID:21001 ResCountDataMessage 返回数量的列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData countV2.ResCountData lua table类型消息数据
---@param csData countV2.ResCountData C# class类型消息数据
netMsgPreprocessing[21001] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData == nil then
        return
    end
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if mainPlayerInfo == nil then
        return
    end

    mainPlayerInfo.DuplicateV2:ResCountData(csData)
    for i = 0, csData.countList.Count - 1 do
        ---@type countV2.CountInfo
        local info = csData.countList[i]
        if info.countType == LuaEnumCommonCountType.LeagueVoteCount then
            if gameMgr:GetPlayerDataMgr() ~= nil then
                ---零点刷新投票类型
                gameMgr:GetPlayerDataMgr():GetLeagueInfo():SetTodayLeagueVoteType(0)
            end
        elseif (info.countType == LuaEnumCommonCountType.SLSuitActive) then
            --神力装备获取的计数
            ---key 是神力套装 type
            local suitType = info.key
            if (info.countNum > 0) then
                gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():ActivateSuitType(suitType)
            end
        else
            local key = info.countType .. "_" .. info.key
            if key == "211_" .. LuaEnumCoinType.JuLingDian then
                if mainPlayerInfo then
                    mainPlayerInfo.BagInfo:RefreshJLZUseTime(info.countNum)
                end
            elseif key == "231_" .. LuaEnumItemCountId.AgBox then
                if mainPlayerInfo then
                    mainPlayerInfo.BagInfo:InitItemUseTime(LuaEnumItemCountId.AgBox, info.countNum)
                end
            elseif key == "231_" .. LuaEnumItemCountId.AuBox then
                if mainPlayerInfo then
                    mainPlayerInfo.BagInfo:InitItemUseTime(LuaEnumItemCountId.AuBox, info.countNum)
                end
            end
        end
    end
end
--endregion

--region ID:21002 ResCountChangeMessage 返回数量变化的消息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData countV2.ResCountChange lua table类型消息数据
---@param csData countV2.ResCountChange C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[21002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    ---@type CSMainPlayerInfo
    local mainPlayerInfo = CS.CSScene.MainPlayerInfo
    if tblData.key == LuaEnumCoinType.JuLingDian then
        if mainPlayerInfo then
            mainPlayerInfo.BagInfo:RefreshJLZUseTime(tblData.countNum)
        end
    elseif tblData.key == LuaEnumItemCountId.AgBox and tblData.countType == 231 then
        if mainPlayerInfo then
            mainPlayerInfo.BagInfo:RefreshItemUseTime(LuaEnumItemCountId.AgBox, tblData.countNum)
        end
    elseif tblData.key == LuaEnumItemCountId.AuBox and tblData.countType == 231 then
        if mainPlayerInfo then
            mainPlayerInfo.BagInfo:RefreshItemUseTime(LuaEnumItemCountId.AuBox, tblData.countNum)
        end
    elseif (tblData.countType == LuaEnumCommonCountType.SLSuitActive) then
        --神力装备获取的计数
        ---key 是神力套装 type
        local suitType = tblData.key
        if (tblData.countNum > 0) then
            gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():ActivateSuitType(suitType)
        end
    end
end
--endregion

--region ID:21004 ResCountShareUsedLimitMessage 道具共享使用上限(已使用次数)
---@param msgID LuaEnumNetDef 消息ID
---@param tblData countV2.ResCountShareUsed lua table类型消息数据
---@param csData countV2.ResCountShareUsed C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[21004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():ResCountShareUsed(tblData)
end
--endregion
