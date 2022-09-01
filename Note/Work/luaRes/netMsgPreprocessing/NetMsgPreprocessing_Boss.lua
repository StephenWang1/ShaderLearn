--[[本文件为工具自动生成]]
--[[本文件用于网络消息分发之前,根据网络消息进行全局预处理,可编辑区域为所生成的每个方法内部,对可编辑区域外的修改将在工具下次修改时作废]]
--[[不建议在方法内使用--region和--endregion,以免干扰工具读取]]
--boss.xml

--region ID:30002 ResPersonalBossInfoMessage 个人BOSS面板信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResPersonalBossInfo lua table类型消息数据
---@param csData bossV2.ResPersonalBossInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[30002] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:30015 ResBossActivityOpenMessage 发送boss活动开启信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResBossActivityOpen lua table类型消息数据
---@param csData bossV2.ResBossActivityOpen C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[30015] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:30017 ResFieldBossOpenMessage 发送野外boss开启信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResFieldBossInfo lua table类型消息数据
---@param csData bossV2.ResFieldBossInfo C# class类型消息数据
netMsgPreprocessing[30017] = function(msgID, tblData, csData)
    if tblData.type ~= 10 then
        luaclass.FieldBossExtraDeal:DealFieldBossOpenMsg(tblData)
    end
    --在此处填入预处理代码
    if tblData.type == 4 and tblData.subType == 2 then
        return -- 神力BOSS不更新C#层BossInfo
    end
    if CS.CSScene.MainPlayerInfo ~= nil then
        CS.CSScene.MainPlayerInfo.BossInfoV2:UpdateBossInfo(csData);
    end
end
--endregion

--region ID:30019 ResMinMapMessage 打开小地图返回信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResMinMapInfo lua table类型消息数据
---@param csData bossV2.ResMinMapInfo C# class类型消息数据
netMsgPreprocessing[30019] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    if CS.CSScene.MainPlayerInfo.MapInfoV2.MiniMapID == CS.CSScene.getMapID() and CS.CSScene.MainPlayerInfo.MapInfoV2.MiniMapID ~= 0 then
        --CS.UnityEngine.Debug.LogError("ResMinMapMessage 0 " .. tostring(CS.CSScene.MainPlayerInfo.MapInfoV2.MiniMapID))
        --若当前地图ID与上次请求小地图时的地图ID不同,则向服务器再次请求一次小地图信息
        CS.CSScene.MainPlayerInfo.MapInfoV2:ResMinMapInfo(csData)
    else
        --CS.UnityEngine.Debug.LogError("ResMinMapMessage 1 " .. tostring(CS.CSScene.MainPlayerInfo.MapInfoV2.MiniMapID))
        --networkRequest.ReqMinMap()
        uiStaticParameter.isNeedSendMinReq = 1
    end
end
--endregion

--region ID:30021 ResGetBossInfoMessage boss信息响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResGetBossInfo lua table类型消息数据
---@param csData bossV2.ResGetBossInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[30021] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--region ID:30022 ResBossRefreshMessage boss刷新提示
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResBossRefresh lua table类型消息数据
---@param csData bossV2.ResBossRefresh C# class类型消息数据
netMsgPreprocessing[30022] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.BossInfoV2:UpdateBossInfo(csData);
end
--endregion

--region ID:30024 ResAncientBossDamageRankMessage 远古 boss 伤害排行响应
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResAncientBossDamageRank lua table类型消息数据
---@param csData bossV2.ResAncientBossDamageRank C# class类型消息数据
netMsgPreprocessing[30024] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.BossInfoV2:UpdateBossDamageRank(csData);
end
--endregion

--region ID:30026 ResHasAncientBossAliveMessage 是否有远古 boss 存活
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResHasAncientBossAlive lua table类型消息数据
---@param csData bossV2.ResHasAncientBossAlive C# class类型消息数据
netMsgPreprocessing[30026] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        CS.CSScene.MainPlayerInfo.BossInfoV2:UpdateHasAncientBoss(csData);
    end
end
--endregion

--region ID:30027 RefreshDemonBossInfoMessage boss面板魔之boss红点
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.RefreshDemonBossInfo lua table类型消息数据
---@param csData bossV2.RefreshDemonBossInfo C# class类型消息数据
netMsgPreprocessing[30027] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    if (CS.CSScene.MainPlayerInfo ~= nil and CS.CSScene.MainPlayerInfo.BossInfoV2 ~= nil and csData ~= nil) then
        CS.CSScene.MainPlayerInfo.BossInfoV2:UpdateDemonBossInfo(csData);
    end
end
--endregion

--region ID:30031 ResOmenComeBossInfoMessage 返回天魔boss信息
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ResOmenComeBossInfo lua table类型消息数据
---@param csData bossV2.ResOmenComeBossInfo C# class类型消息数据(nil, 被优化掉了)
netMsgPreprocessing[30031] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion

--[[
--region ID:30029 ReqAncientBossDamageRankV2Message 请求远古 boss 伤害排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ReqAncientBossDamageRank lua table类型消息数据
---@param csData bossV2.ReqAncientBossDamageRank C# class类型消息数据
netMsgPreprocessing[30029] = function(msgID, tblData, csData)
    --在此处填入预处理代码
end
--endregion
--]]

--[[
--region ID:30023 ResAncientBossDamageRankMessage 请求远古 boss 伤害排行
---@param msgID LuaEnumNetDef 消息ID
---@param tblData bossV2.ReqAncientBossDamageRank lua table类型消息数据
---@param csData bossV2.ReqAncientBossDamageRank C# class类型消息数据
netMsgPreprocessing[30023] = function(msgID, tblData, csData)
    --在此处填入预处理代码
    CS.CSScene.MainPlayerInfo.BossInfoV2:UpdateBossDamageRank(csData);
end
--endregion
--]]
