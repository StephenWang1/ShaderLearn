local MagicBossDataInfo = {}
--region 数据
--region 当前正在对战的魔之boss信息
---@type CSMonster 怪物信息
MagicBossDataInfo.magicBossAvater = nil
---@type TABLE.CFG_MONSTERS 怪物表
MagicBossDataInfo.monsterTableInfo = nil
---@type TABLE.cfg_demon_boss 魔之boss表
MagicBossDataInfo.magicBossTableInfo = nil
---@type number 结束时间
MagicBossDataInfo.endTime = nil
--endregion

--region 魔之boss类型信息
---@type table<number,MagicBossTypeDataInfo> 客户端魔之boss类型信息列表(key = 魔之boss类型，value = 魔之boss类型信息)
MagicBossDataInfo.MagicBossTypeInfoTable = {}
--endregion
--endregion

--region 数据刷新
--region 魔之boss数据刷新
---解析魔之boss显示数据
---@param commonData.avater CSMonster 怪物信息
---@param commonData.endTime number 结束时间
---@return boolean 是否解析成功
function MagicBossDataInfo:AnalysisMagicBossInfo(commonData)
    self:ResetParams()
    self.analysisMagicBossSuccess = false
    if commonData == nil or commonData.avater == nil or commonData.endTime == nil or commonData.avater.MonsterTable == nil then
        return self.analysisMagicBossSuccess
    end
    self.magicBossAvater = commonData.avater
    self.monsterTableInfo = commonData.avater.MonsterTable
    self.magicBossTableInfo = clientTableManager.cfg_demon_bossManager:TryGetValue(self.monsterTableInfo.id)
    if self.magicBossTableInfo == nil then
        self:ResetParams()
        return self.analysisMagicBossSuccess
    end
    self.endTime = commonData.endTime
    self.analysisMagicBossSuccess = true
    return self.analysisMagicBossSuccess
end

---数据重置
function MagicBossDataInfo:ResetParams()
    self.magicBossAvater = nil
    self.monsterTableInfo = nil
    self.magicBossTableInfo = nil
    self.endTime = nil
end
--endregion

--region 魔之boss玩家信息刷新
---刷新魔之boss次数
---@param tblData mapV2.ResDemonBossHasCount lua table类型消息数据
function MagicBossDataInfo:RefreshPlayerTime(tblData)
    if tblData ~= nil and tblData.demonInfo ~= nil and type(tblData.demonInfo) == 'table' then
        for k, v in pairs(tblData.demonInfo) do
            local serverDemonInfo = v
            local clientDemonInfo = self:GetMagicBossTypeInfoByType(serverDemonInfo.killType)
            if clientDemonInfo == nil then
                ---@type MagicBossTypeDataInfo
                clientDemonInfo = luaclass.MagicBossTypeDataInfo:New()
            end
            local data = {}
            data.serverDemonInfo = serverDemonInfo
            data.helpNum = tblData.helpCount
            data.killNum = serverDemonInfo.killCount
            data.magicBossType = serverDemonInfo.killType
            data.addKillNumEndTime = serverDemonInfo.nextHasTime
            data.totalKillNum = tblData.allCount
            data.totalKillNumNextRecoverTime = tblData.nextHasAllCountTime
            clientDemonInfo:RefreshMagicBossTypeInfo(data)
            self.MagicBossTypeInfoTable[clientDemonInfo.magicBossType] = clientDemonInfo
        end
        gameMgr:GetLuaRedPointManager():CallMagicBossRedPoint(true)
        luaEventManager.DoCallback(LuaCEvent.RefreshMagicBossTime)
    end
end

---刷新魔之boss单个次数
---@param tblData mapV2.ResDemonBossUpdateHasCount lua table类型消息数据
function MagicBossDataInfo:RefreshSingleTime(tblData)
    --协助次数全刷
    if tblData ~= nil and tblData.count ~= nil and tblData.type == LuaEnumMagicBossTimeType.HelpNum then
        if self.MagicBossTypeInfoTable ~= nil then
            for k, v in pairs(self.MagicBossTypeInfoTable) do
                if v ~= nil and v.magicBossType ~= nil and self.MagicBossTypeInfoTable[v.magicBossType] ~= nil then
                    v.helpNum = tblData.count
                    self.MagicBossTypeInfoTable[v.magicBossType] = v
                end
            end
            luaEventManager.DoCallback(LuaCEvent.RefreshMagicBossTime)
        end
        return
    end

    if tblData == nil or tblData.killType == nil or tblData.type == nil or tblData.count == nil then
        return
    end
    local magicBossTypeInfo = self:GetMagicBossTypeInfoByType(tblData.killType)
    if magicBossTypeInfo == nil then
        return
    end
    if tblData.type == LuaEnumMagicBossTimeType.KillNum then
        magicBossTypeInfo.killNum = tblData.count
        gameMgr:GetLuaRedPointManager():CallMagicBossRedPoint(true)
    elseif tblData.type == LuaEnumMagicBossTimeType.HelpNum then
        magicBossTypeInfo.helpNum = tblData.count
    end
    self.MagicBossTypeInfoTable[tblData.killType] = magicBossTypeInfo
    luaEventManager.DoCallback(LuaCEvent.RefreshMagicBossTime)
end
--endregion

--region 领取奖励数据刷新
---刷新领取奖励数据
---@param tblData mapV2.DemonDieCanReward lua table类型消息数据
function MagicBossDataInfo:RefreshGetAwardInfo(tblData)
    if tblData == nil or self.magicBossAvater == nil then
        self:ClearAwardParams()
        return
    end
    self.CanGetReward = true
    self.DeadMonsterId = tblData.monsterId
    self.DeadMonsterMapId = tblData.mapId
    self.DeadMonsterLine = tblData.line
    self.DeadMonsterPosX = tblData.x
    self.DeadMonsterPosY = tblData.y
    self.DeadMonsterOwnerPlayerUnionId = tblData.ownerUnionId
    self.DeadMonsterOwnerId = tblData.ownerId
    self.DeadMonsterConfigId = tblData.monsterConfigId
    luaEventManager.DoCallback(LuaCEvent.RefreshCanGetReward)
end

---玩家是否可以领取奖励
---@param mapId 主角的地图id
---@param dot2 主角的坐标位置
---@return LuaEnumCanGetMagicBossAwardType 可领奖励类型
function MagicBossDataInfo:CanGetAward(mapId, dot2)
    if self.CanGetReward == false or self.CanGetReward == nil or CS.CSScene.MainPlayerInfo == nil then
        return LuaEnumCanGetMagicBossAwardType.None
    end
    local mainPlayerMapId = CS.CSScene.MainPlayerInfo.MapID
    if self.DeadMonsterMapId ~= mainPlayerMapId then
        return LuaEnumCanGetMagicBossAwardType.NotWithinRange
    end
    local distance = Utility.MainPlayerToTargetDistance(self.DeadMonsterPosX, self.DeadMonsterPosY)
    local configRange = LuaGlobalTableDeal.GetMagicBossRangeNumber()
    if distance ~= nil and configRange ~= nil then
        if distance <= configRange then
            return LuaEnumCanGetMagicBossAwardType.WithinRange
        else
            return LuaEnumCanGetMagicBossAwardType.NotWithinRange
        end
    end
    return LuaEnumCanGetMagicBossAwardType.None
end

---尝试请求获取奖励
function MagicBossDataInfo:TryReqGetAward()
    if CS.CSScene.MainPlayerInfo == nil then
        return
    end
    local canGetRewardState = self:CanGetAward(CS.CSScene.MainPlayerInfo.MapID, CS.CSScene.MainPlayerInfo.Owner.OldCell.Coord)
    if canGetRewardState == LuaEnumCanGetMagicBossAwardType.None then
        self:ClearAwardParams()
        return
    end
    if networkRequest.ReqDemonDieCanReward ~= nil then
        networkRequest.ReqDemonDieCanReward(self.DeadMonsterOwnerId, self.DeadMonsterOwnerPlayerUnionId, self.DeadMonsterConfigId, self.DeadMonsterId)
    end
    ---关闭左侧魔之boss面板（策划说主角视野内同时出现两个魔之boss的情况）
    local uiDemonLeftlMainPanel = uimanager:GetPanel("UIDemonLeftlMainPanel")
    local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
    if uiDemonLeftlMainPanel ~= nil and uiMainMenusPanel ~= nil then
        uiMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
    end
    self:ClearAwardParams()
    self:ResetParams()
end

---清空领取奖励数据
function MagicBossDataInfo:ClearAwardParams()
    self.CanGetReward = false
    self.DeadMonsterId = nil
    self.DeadMonsterMapId = nil
    self.DeadMonsterLine = nil
    self.DeadMonsterPosX = nil
    self.DeadMonsterPosY = nil
    self.DeadMonsterOwnerPlayerUnionId = nil
    self.DeadMonsterOwnerId = nil
    self.DeadMonsterConfigId = nil
    self:CloseDelayCloseDemonLeftPanel()
    self:CloseCheckDeadMonsterRange()
end
--endregion
--endregion

--region 获取
---获取boss复活剩余时间
---@return number 剩余时间
function MagicBossDataInfo:GetRemainTime()
    local remainTime = 0
    if self.endTime ~= nil then
        remainTime = self.endTime - CS.CSScene.MainPlayerInfo.serverTime
    end
    return remainTime
end

---获取增加击杀次数剩余时间
---@param monsterType LuaEnumMagicBossDropType 怪物类型
---@param remainTimeType LuaEnumRemainTimeType 剩余时间类型
---@return number 剩余时间
function MagicBossDataInfo:GetAddKillNumRemainTime(monsterType,remainTimeType)
    local remainTime = 0
    local addKillNumEndTime = nil
    if remainTimeType == LuaEnumRemainTimeType.SingleTypeRecoverKillNumRemainTime then
        addKillNumEndTime = self:GetMagicBossTypeAddKillNumEndTime(monsterType)
    elseif remainTimeType == LuaEnumRemainTimeType.TotalKillNumRecoverRemainTime  then
        addKillNumEndTime = self:GetMagicBossTypeAddTotalKillNumEndTime(monsterType)
    end
    if addKillNumEndTime ~= nil then
        remainTime = addKillNumEndTime - CS.CSScene.MainPlayerInfo.serverTime
    end
    return remainTime
end

---是否显示魔之boss红点
---@return boolean
function MagicBossDataInfo:ShowMagicBossRedPoint()
    if uiStaticParameter.MagicBossRedPointLock == false then
        return false
    end
    if LuaGlobalTableDeal.ShowMagicBossRedPointByConditionTable() == false then
        return false
    end
    local magciBossDicIsFind, magicBossDic = CS.CSScene.MainPlayerInfo.BossInfoV2.BossInfoDic:TryGetValue(LuaEnumBossType.DemonBoss)
    if magciBossDicIsFind == true then
        local magicBossTable = Utility.CSDicChangeTable(magicBossDic)
        if magicBossTable ~= nil then
            for k, v in pairs(magicBossTable) do
                local bossList = v
                if bossList ~= nil and bossList.Count > 0 then
                    local length = bossList.Count - 1
                    for i = 0, length do
                        local CSBossInfo = bossList[i]
                        if CSBossInfo ~= nil and CSBossInfo.configId ~= nil and clientTableManager.cfg_demon_bossManager ~= nil and clientTableManager.cfg_demon_bossManager.GetMagicBossType ~= nil then
                            local magicBossType = clientTableManager.cfg_demon_bossManager:GetMagicBossType(CSBossInfo.configId)
                            local maigcBossTypeInfo = self:GetMagicBossTypeInfoByType(magicBossType)
                            if maigcBossTypeInfo ~= nil then
                                local killNum = maigcBossTypeInfo:GetCurKillNum()
                                if killNum > 0 and self:CheckHaveRedPointMagicBossType(magicBossType) == false and LuaGlobalTableDeal.CheckBossTypeIsOpen(LuaEnumBossType.DemonBoss,magicBossType) then
                                    local haveBoss = CSBossInfo.freshTime <= 0
                                    local MainPlayerCanAttackBoss = CSBossInfo.MainPlayerCanAttackBoss
                                    if haveBoss == true and MainPlayerCanAttackBoss == true then
                                        return true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

---保存魔之boss红点提示过的类型
---@param magicBossType number 魔之boss类型
function MagicBossDataInfo:SaveMagicBossHintRedPointMagicType(magicBossType)
    if self.redHintMagicBossType == nil then
        self.redHintMagicBossType = {}
    end
    self.redHintMagicBossType[magicBossType] = magicBossType
end

---检查是否有记录的魔之boss类型
---@param magicBossType number 魔之boss类型
---@return boolean 是否有保存数据
function MagicBossDataInfo:CheckHaveRedPointMagicBossType(magicBossType)
    if self.redHintMagicBossType == nil then
        return false
    end
    return self.redHintMagicBossType[magicBossType] ~= nil
end

---清空魔之boss红点提示保存
function MagicBossDataInfo:ClearRedHintMagicBossTypeTable()
    self.redHintMagicBossType = nil
end

---是否显示魔之boss类型红点
---@param magicBossType LuaEnumMagicBossDropType 魔之boss类型
---@return boolean 是否显示红点
function MagicBossDataInfo:ShowMagicBossTypeRedPoint(magicBossType)

end

---通过魔之boss类型获取怪物列表
---@param magicBossType LuaEnumMagicBossDropType 魔之boss类型
---@return table<IBossDamageRankVO> c#魔之boss数据列表
function MagicBossDataInfo:GetMagicBossListByMagicBossType(magicBossType)
    
end

---通过魔之boss类型获取魔之boss类型信息
---@param magicBossType LuaEnumMagicBossDropType 魔之boss类型
---@return MagicBossTypeDataInfo MagicBossDataInfo.MagicBossClientTypeInfo客户端定义的魔之boss类型信息
function MagicBossDataInfo:GetMagicBossTypeInfoByType(magicBossType)
    if self.MagicBossTypeInfoTable ~= nil and type(self.MagicBossTypeInfoTable) == 'table' then
        return self.MagicBossTypeInfoTable[magicBossType]
    end
end

---获取魔之boss类型击杀次数
---@param magicBossType LuaEnumMagicBossDropType 魔之boss类型
---@return number 魔之boss击杀次数
function MagicBossDataInfo:GetMagicBossTypeKillNum(magicBossType)
    if magicBossType == nil or type(magicBossType) ~= 'number' then
        return 0
    end
    local magicBossTypeInfo = self:GetMagicBossTypeInfoByType(magicBossType)
    if magicBossTypeInfo ~= nil then
        return magicBossTypeInfo.killNum
    end
    return 0
end

---获取魔之boss类型总击杀次数
---@param magicBossType LuaEnumMagicBossDropType 魔之boss类型
---@return number 魔之boss总击杀次数
function MagicBossDataInfo:GetMagicBossTypeTotalKillNum(magicBossType)
    if magicBossType == nil or type(magicBossType) ~= 'number' then
        return 0
    end
    local magicBossTypeInfo = self:GetMagicBossTypeInfoByType(magicBossType)
    if magicBossTypeInfo ~= nil then
        return magicBossTypeInfo.totalKillNum
    end
    return 0
end

---获取魔之boss类型协助次数
---@param magicBossType LuaEnumMagicBossDropType 魔之boss类型
---@return number 魔之boss协助次数
function MagicBossDataInfo:GetMagicBossTypeHelpNum(magicBossType)
    if magicBossType == nil or type(magicBossType) ~= 'number' then
        return 0
    end
    local magicBossTypeInfo = self:GetMagicBossTypeInfoByType(magicBossType)
    if magicBossTypeInfo ~= nil then
        return magicBossTypeInfo.helpNum
    end
    return 0
end

---获取魔之boss类型恢复击杀次数结束时间
---@param magicBossType LuaEnumMagicBossDropType 魔之boss类型
---@return number 魔之boss击杀次数恢复结束时间
function MagicBossDataInfo:GetMagicBossTypeAddKillNumEndTime(magicBossType)
    if magicBossType == nil or type(magicBossType) ~= 'number' then
        return 0
    end
    local magicBossTypeInfo = self:GetMagicBossTypeInfoByType(magicBossType)
    if magicBossTypeInfo ~= nil then
        return magicBossTypeInfo.addKillNumEndTime
    end
    return 0
end

---获取魔之boss类型恢复总击杀击杀次数结束时间
---@param magicBossType LuaEnumMagicBossDropType 魔之boss类型
---@return number 魔之boss击杀次数恢复结束时间
function MagicBossDataInfo:GetMagicBossTypeAddTotalKillNumEndTime(magicBossType)
    if magicBossType == nil or type(magicBossType) ~= 'number' then
        return 0
    end
    local magicBossTypeInfo = self:GetMagicBossTypeInfoByType(magicBossType)
    if magicBossTypeInfo ~= nil then
        return magicBossTypeInfo.totalKillNumNextRecoverTime
    end
    return 0
end

---获取魔之boss当前对于玩家而言的状态（对于玩家来讲，是路人或者攻击者之类或者什么都不是）
---@return LuaEnumMagicBossAttackTypeForMainPlayerType 魔之boss对于主角而言的状态类型
function MagicBossDataInfo:GetMagicBossAttackTypeForMainPlayer()
    if self.magicBossAvater == nil or self.magicBossAvater.Info == nil then
        return LuaEnumMagicBossAttackTypeForMainPlayerType.None
    end

    local mainPlayerName = CS.CSScene.MainPlayerInfo.Name
    local mainPlayerID = CS.CSScene.MainPlayerInfo.ID
    local mainPlayerHaveUnion = CS.StaticUtility.IsNullOrEmpty(CS.CSScene.MainPlayerInfo.UIUnionName) == false

    if self.DeadMonsterId ~= nil and self.DeadMonsterOwnerId and self.CanGetReward == true then
        if mainPlayerID == self.DeadMonsterOwnerId then
            return LuaEnumMagicBossAttackTypeForMainPlayerType.BossDead_Mine
        else
            return LuaEnumMagicBossAttackTypeForMainPlayerType.BossDead_SameUnion
        end
    end

    if self.magicBossAvater.Info.OwnerName == nil or CS.StaticUtility.IsNullOrEmpty(self.magicBossAvater.Info.OwnerName) == true then
        return LuaEnumMagicBossAttackTypeForMainPlayerType.Normal
    elseif CS.StaticUtility.IsNullOrEmpty(self.magicBossAvater.Info.OwnerName) == false and self.magicBossAvater.Info.OwnerName == mainPlayerName and mainPlayerHaveUnion == true then
        return LuaEnumMagicBossAttackTypeForMainPlayerType.BossAttack_Mine
    else
        return LuaEnumMagicBossAttackTypeForMainPlayerType.BossAttack_OtherPlayer
    end
    return LuaEnumMagicBossAttackTypeForMainPlayerType.None
end
--endregion

--region 查询
---击杀次数是否已满
---@param monsterType number 魔之boss类型
---@return boolean
function MagicBossDataInfo:KillTimeIsMax(monsterType)
    local totalKillNum = LuaGlobalTableDeal.GetAttackMagicBossMaxNum()
    local killNum = self:GetMagicBossTypeKillNum(monsterType)
    return killNum >= totalKillNum
end

function MagicBossDataInfo:GetBagMagicBossItemNumber(monsterType)
    local magicBossConfigInfo = LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(monsterType)
    if magicBossConfigInfo == nil then
        return 0
    end
    local addKillNumMaterialItemId = magicBossConfigInfo.killNumRecoverItemId
    local count = CS.CSScene.MainPlayerInfo.BagInfo:GetItemCountByItemId(addKillNumMaterialItemId)
    return count
end

---求助次数是否已满
---@param monsterType number 魔之boss类型
---@return boolean
function MagicBossDataInfo:HelpTimeIsMax(monsterType)
    local totalHelpNum = LuaGlobalTableDeal.GetXieZhuMaxNum()
    local helpNum = self:GetMagicBossTypeHelpNum(monsterType)
    return helpNum >= totalHelpNum
end

---是否有增加攻击次数的物品
---@param monsterType number 魔之boss类型
---return boolean
function MagicBossDataInfo:HaveAddKillItem(monsterType)
    local magicBossConfigInfo = LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(monsterType)
    local haveAddKillNumItem = false
    if magicBossConfigInfo ~= nil and magicBossConfigInfo.killNumRecoverItemId ~= nil then
        haveAddKillNumItem = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(magicBossConfigInfo.killNumRecoverItemId) ~= nil
    end
    return haveAddKillNumItem
end

---魔之boss是否可以被攻击
---@param bossInfo bossV2.FieldBossInfo boss信息
---@return boolean boss是否可以被攻击
function MagicBossDataInfo:MagicBossInfoCanAttackByBossInfo(bossInfo)
    if bossInfo == nil or bossInfo.count <= 0 then
        return false
    end
    return clientTableManager.cfg_bossManager:BossMapCanMeet(bossInfo.bossId)
end
--endregion

--region 功能
---尝试增加击杀次数
function MagicBossDataInfo:TryAddKillNum(go, monsterType, dir)
    local magicBossConfigInfo = LuaGlobalTableDeal.GetMagicBossTypeConfigInfo(monsterType)
    if magicBossConfigInfo == nil then
        return
    end
    local addKillNumMaterialItemId = magicBossConfigInfo.killNumRecoverItemId
    if addKillNumMaterialItemId ~= nil then
        local materialBagItemInfo = CS.CSScene.MainPlayerInfo.BagInfo:GetItemInBagByItemID(addKillNumMaterialItemId)
        if materialBagItemInfo ~= nil then
            local useFunction = function(count)
                networkRequest.ReqUseItem(count, materialBagItemInfo.lid, 0)
            end
            uimanager:CreatePanel("UIItemCountPanel", nil, {
                Title = "使 用",
                ItemInfo = materialBagItemInfo.ItemTABLE,
                CallBack = useFunction,
                BeginningCount = 1,
                MaxCount = materialBagItemInfo.count
            })
        else
            uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.MagicBossPanel
            if (dir == nil) then
                Utility.ShowItemGetWay(addKillNumMaterialItemId, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(10, 0),nil,nil,nil,false);
            else
                Utility.ShowItemGetWay(addKillNumMaterialItemId, go, dir, CS.UnityEngine.Vector2(0, -5),nil,nil,nil,false);
            end
        end
    end
end

---尝试开启魔之boss面板
---@param commonData.avater CSMonster 怪物信息
---@param commonData.endTime number 结束时间
function MagicBossDataInfo:TryOpenMagicBossPanel(commonData)
    local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
    local uiDemonLeftMainPanel = uimanager:GetPanel("UIDemonLeftlMainPanel")
    if uiMainMenusPanel == nil then
        return
    end
    local analysisSuccess = self:AnalysisMagicBossInfo(commonData)
    if analysisSuccess == false or uiStaticParameter.MagicBossInMainPlayerArea == false or CS.CSScene.MainPlayerInfo == nil then
        uiMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
        return
    end
    local remainTime = self:GetRemainTime()
    if self.endTime == nil or (self.endTime > 0 and remainTime < 0) then
        uiMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
        return
    end
    if uiStaticParameter.MagicBossInMainPlayerArea == true then
        if uiDemonLeftMainPanel ~= nil then
            uiDemonLeftMainPanel:RefreshPanel()
        else
            uiMainMenusPanel:ChangeLeftPanel("UIDemonLeftlMainPanel")
        end
    end
end

function MagicBossDataInfo:DelayCloseMagicBossPanel()
    self:CloseDelayCloseMagicBossPanel()
    self.delayCloseMagicBossPanelListUpdate = CS.CSListUpdateMgr.Add(1000, nil, function()
        self:TryCloseMagicBossPanel()
    end)
end

function MagicBossDataInfo:CloseDelayCloseMagicBossPanel()
    if self.delayCloseMagicBossPanelListUpdate ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.delayCloseMagicBossPanelListUpdate)
        self.delayCloseMagicBossPanelListUpdate = nil
    end
end

---尝试关闭魔之boss面板
function MagicBossDataInfo:TryCloseMagicBossPanel()
    local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
    local uiDemonLeftMainPanel = uimanager:GetPanel("UIDemonLeftlMainPanel")
    if uiMainMenusPanel == nil then
        return
    end
    local canGetRewardState = self:CanGetAward(CS.CSScene.MainPlayerInfo.MapID, CS.CSScene.MainPlayerInfo.Owner.OldCell.Coord)
    if canGetRewardState == LuaEnumCanGetMagicBossAwardType.None then
        uiMainMenusPanel:ChangeLeftPanel("UIMissionPanel")
    elseif canGetRewardState == LuaEnumCanGetMagicBossAwardType.WithinRange then
        self:OpenCheckDeadMonsterRange()
        self:OpenDelayCloseDemonLeftPanel()
        if uiDemonLeftMainPanel ~= nil then
            uiDemonLeftMainPanel:RefreshPanel()
        end
    elseif canGetRewardState == LuaEnumCanGetMagicBossAwardType.NotWithinRange then
        self:TryReqGetAward()
    end
end

---开启检测死亡怪物范围
function MagicBossDataInfo:OpenCheckDeadMonsterRange()
    self:CloseCheckDeadMonsterRange()
    self.checkRangeWithDeadMonster = CS.CSListUpdateMgr.Add(200, nil, function()
        local canGetRewardState = self:CanGetAward(CS.CSScene.MainPlayerInfo.MapID, CS.CSScene.MainPlayerInfo.Owner.OldCell.Coord)
        if canGetRewardState == LuaEnumCanGetMagicBossAwardType.NotWithinRange then
            self:TryReqGetAward()
        end
    end, true)
end

---关闭检测死亡怪物范围
function MagicBossDataInfo:CloseCheckDeadMonsterRange()
    if self.checkRangeWithDeadMonster ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.checkRangeWithDeadMonster)
        self.checkRangeWithDeadMonster = nil
    end
end

---开启延迟关闭魔之boss左侧面板
function MagicBossDataInfo:OpenDelayCloseDemonLeftPanel()
    self:CloseDelayCloseDemonLeftPanel()
    local canGetRewardState = self:CanGetAward(CS.CSScene.MainPlayerInfo.MapID, CS.CSScene.MainPlayerInfo.Owner.OldCell.Coord)
    if canGetRewardState == LuaEnumCanGetMagicBossAwardType.WithinRange then
        local autoGetRewardTime = LuaGlobalTableDeal.GetMagicBossAutoGetRewardTime() * 1000
        self.DelayCloseDemonLeftPanel = CS.CSListUpdateMgr.Add(autoGetRewardTime, nil, function()
            self:TryReqGetAward()
        end, false)
    end
end

---关闭延迟关闭魔之boss左侧面板
function MagicBossDataInfo:CloseDelayCloseDemonLeftPanel()
    if self.DelayCloseDemonLeftPanel ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.DelayCloseDemonLeftPanel)
        self.DelayCloseDemonLeftPanel = nil
    end
end
--endregion

---游戏场景退回到登录/选角界面时触发
function MagicBossDataInfo:OnExitDestroy()
    self.MagicBossTypeInfoTable = {}
    self:ResetParams()
    self:ClearAwardParams()
    self:ClearRedHintMagicBossTypeTable()
end
return MagicBossDataInfo