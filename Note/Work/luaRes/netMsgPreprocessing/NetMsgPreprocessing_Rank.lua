--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--rank.xml

--region ID:26002 ResLookRankMessage 排行榜数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rankV2.ResLookRank lua table类型消息数据
---@param csData rankV2.ResLookRank C# class类型消息数据
netMsgPreprocessing[26002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if gameMgr:GetPlayerDataMgr() == nil or tblData == nil then
            return
        end
        gameMgr:GetPlayerDataMgr():GetRankData():RefreshRankData(tblData)
        --CS.CSScene.MainPlayerInfo.RankInfoV2:InitRankDataInfo(csData)
    end
end
--endregion

--region ID:26004 ResRankRewardInfoMessage 发送排行奖励信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rankV2.ResRankRewardInfo lua table类型消息数据
---@param csData rankV2.ResRankRewardInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[26004] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:26006 ResUnRewardRankTypesMessage 发送未领取奖励的排行列表
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rankV2.ResUnRewardRankTypes lua table类型消息数据
---@param csData rankV2.ResUnRewardRankTypes C# class类型消息数据
netMsgPreprocessing[26006] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.RankInfoV2:InitUnRewawrdRank(csData)
end
--endregion

--region ID:26008 ResBattleDamageRankDatailMessage 战损榜详情响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rankV2.DamageItemRankInfo lua table类型消息数据
---@param csData rankV2.DamageItemRankInfo C# class类型消息数据
netMsgPreprocessing[26008] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:26010 ResShareLookRankMessage 排行榜数据
---@param msgID LuaEnumNetDef 消息ID
---@param tblData rankV2.ResLookRank lua table类型消息数据
---@param csData rankV2.ResLookRank C# class类型消息数据
netMsgPreprocessing[26010] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if csData then
        if gameMgr:GetPlayerDataMgr() == nil or tblData == nil then
            return
        end
        gameMgr:GetPlayerDataMgr():GetRankData():RefreshRankData(tblData)
        --CS.CSScene.MainPlayerInfo.RankInfoV2:InitRankDataInfo(csData)
    end
end
--endregion
