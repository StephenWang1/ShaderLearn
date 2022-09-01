local BuDouKaiBetDataClass = {}
--region 数据
---押注数据表
BuDouKaiBetDataClass.BetPlayerInfoTable = {}
--endregion

--region 刷新
--region 刷新所有玩家押注数据
---刷新押注信息列表
---@param tblData duplicateV2.ResBetPlayerInfo lua table类型消息数据
function BuDouKaiBetDataClass:RefreshBetTable(tblData)
    if tblData == nil then
        return
    end
    if self.BetPlayerInfoTable == nil then
        self.BetPlayerInfoTable = {}
    end
    local refreshPlayerBetListType = {}
    if tblData.someSelectPlayers ~= nil and #tblData.someSelectPlayers > 0 then
        table.insert(refreshPlayerBetListType,luaEnumBuDouKaiStage.FRISTREST)
        self.BetPlayerInfoTable.PrompotionBetPlayerTable = tblData.someSelectPlayers
    end
    if tblData.finalPlayers ~= nil and #tblData.finalPlayers > 0 then
        table.insert(refreshPlayerBetListType,luaEnumBuDouKaiStage.SCEONDREST)
        self.BetPlayerInfoTable.FinalBetPlayerTable = tblData.finalPlayers
    end
    self:AddParams()
    if #refreshPlayerBetListType > 0 then
        luaEventManager.DoCallback(LuaCEvent.BuDouKaiBetPlayerListRefresh,refreshPlayerBetListType)
    end
end

---玩家押注信息添加客户端信息数据
function BuDouKaiBetDataClass:AddParams()
    if self.BetPlayerInfoTable ~= nil then
        if self.BetPlayerInfoTable.PrompotionBetPlayerTable ~= nil then
            for k,v in pairs(self.BetPlayerInfoTable.PrompotionBetPlayerTable) do
                v.stage = luaEnumBuDouKaiStage.FRISTREST
            end
        end
        if self.BetPlayerInfoTable.FinalBetPlayerTable ~= nil then
            for k,v in pairs(self.BetPlayerInfoTable.FinalBetPlayerTable) do
                v.stage = luaEnumBuDouKaiStage.SCEONDREST
            end
        end
    end
end
--endregion

--region 刷新单个玩家数据
---刷新单个玩家押注角色信息
---@param tblData duplicateV2.BudoBetSuccess lua table类型消息数据
function BuDouKaiBetDataClass:RefreshSingleBetInfo(tblData)
    if tblData == nil or tblData.targetId == nil or tblData.state == nil then
        return
    end
    local betPlayerInfo = self:GetStagePlayerInfo(tblData.state,tblData.targetId)
    if betPlayerInfo == nil then
        return
    end
    if tblData.targetZhu ~= nil and type(tblData.targetZhu) == 'number' and tblData.targetZhu >= 0 then
        betPlayerInfo.zhuNum = tblData.targetZhu
    end
    if tblData.betInt ~= nil and type(tblData.betInt) == 'number' and tblData.betInt >= 0 then
        betPlayerInfo.odds = tblData.betInt * 0.001
    end
    luaEventManager.DoCallback(LuaCEvent.BuDouKaiBetSinglePlayerRefresh,{curBetPlayerInfo = betPlayerInfo})
end
--endregion

--region 5s刷新玩家部分数据
---刷新所有赛程单个押注角色信息
---@param tblData duplicateV2.BudoBetBeiInfo lua table类型消息数据
function BuDouKaiBetDataClass:RefreshAllMatchSingleBetInfo(tblData)
    if tblData == nil or tblData.info == nil or type(tblData.info) ~= 'table' then
        return
    end
    if self.BetPlayerInfoTable == nil or type(self.BetPlayerInfoTable) ~= 'table' then
        return
    end
    local refreshBetPlayerInfoTable = {}
    for k,v in pairs(tblData.info) do
        if v ~= nil then
            local refreshPlayerId = v.targetId
            local refreshStage = v.state
            local betPlayerInfo = self:GetStagePlayerInfo(refreshStage,refreshPlayerId)
            if betPlayerInfo ~= nil then
                local lossPerCent = nil
                if refreshStage == luaEnumBuDouKaiStage.FRISTREST then
                    lossPerCent = v.someSelectBetInt
                elseif refreshStage == luaEnumBuDouKaiStage.SCEONDREST then
                    lossPerCent = v.finalBetInt
                end
                if lossPerCent ~= nil then
                    betPlayerInfo.odds = lossPerCent * 0.001
                end
                table.insert(refreshBetPlayerInfoTable,betPlayerInfo)
            end
        end
    end
    luaEventManager.DoCallback(LuaCEvent.BuDouKaiBetPlayerTableRefresh,{refreshBetPlayerInfoTable = refreshBetPlayerInfoTable})
end
--endregion
--endregion

--region 获取
---获取押注玩家列表
---@param stage number 武道会阶段
function BuDouKaiBetDataClass:GetBetPlayerList(stage)
    if self.BetPlayerInfoTable == nil then
        return nil
    end
    if stage ~= nil and type(stage) ~= 'number' then
        stage = Utility.EnumToInt(stage)
    end
    if stage ~= nil then
        if stage == luaEnumBuDouKaiStage.FRISTREST then
            return self.BetPlayerInfoTable.PrompotionBetPlayerTable
        elseif stage == luaEnumBuDouKaiStage.SCEONDREST then
            return self.BetPlayerInfoTable.FinalBetPlayerTable
        end
    end
end

---获取对应阶段押注具体人物数据
---@param stage luaEnumBuDouKaiStage 阶段
---@param playerId number 押注对象lid
function BuDouKaiBetDataClass:GetStagePlayerInfo(stage,playerId)
    local betPlayerInfoTable = self:GetBetPlayerList(stage)
    local betPlayerInfo = nil
    if betPlayerInfoTable ~= nil and type(betPlayerInfoTable) == 'table' then
        for k,v in pairs(betPlayerInfoTable) do
            if v ~= nil and v.playerId == playerId then
                betPlayerInfo = v
                break
            end
        end
    end
    return betPlayerInfo
end
--endregion

---游戏场景退回到登录/选角界面时触发
function BuDouKaiBetDataClass:OnExitDestroy()
    self.BetPlayerInfoTable = {}
end
return BuDouKaiBetDataClass