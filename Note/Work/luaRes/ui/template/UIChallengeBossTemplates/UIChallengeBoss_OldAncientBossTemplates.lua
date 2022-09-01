---@class UIChallengeBoss_OldAncientBossTemplates 远古boss单元模板(旧的)
local UIChallengeBoss_OldAncientBossTemplates = {}

--region 初始化

function UIChallengeBoss_OldAncientBossTemplates:Init()
    self:InitComponents()
    self:InitParameters()
end
--初始化变量
function UIChallengeBoss_OldAncientBossTemplates:InitParameters()
    self.allBossInfo = nil
end

function UIChallengeBoss_OldAncientBossTemplates:InitComponents()
    ---@type Top_UILabel
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UILabel
    self.level = self:Get("lb_lv", "Top_UILabel")
    ---@type Top_UILabel
    self.AllKilled = self:Get("AllKilled", "Top_UILabel")
    ---@type Top_UISprite
    self.headIcon = self:Get("bossHead/headIcon", "Top_UISprite")
    ---@type Top_UISprite
    self.headIconBg = self:Get("bossHead/headIconBg", "Top_UISprite")
    ---@type Top_UIGridContainer
    self.dropItemGrid = self:Get("DropItem", "Top_UIGridContainer")
    ---@type Top_UIGridContainer
    self.selectMap = self:Get("selectMap", "Top_UIGridContainer")
    ---@type Top_UISprite
    self.bg = self:Get("backGround", "Top_UISprite")
end

function UIChallengeBoss_OldAncientBossTemplates:BindUIEvent()

end

--endregion

--region ShowUI

---@param data table 所有boss信息  先按一只的去写
---@param otherData
function UIChallengeBoss_OldAncientBossTemplates:RefreshUI(data, shaderClip, otherData)
    if data == nil or data.allInfo == nil or #data.allInfo == 0 then
        self.allBossInfo = nil
        return
    end
    if otherData then
        self.line = otherData.line
    else
        self.line = nil
    end

    self.allBossInfo = data.allInfo
    self:RefreshMonsterUI(data.allInfo[1].configId)
    self:RefreshAncientBossInfo(data)
end

---刷新怪物相关
function UIChallengeBoss_OldAncientBossTemplates:RefreshMonsterUI(monsterId)
    local monsterTable = clientTableManager.cfg_monstersManager:TryGetValue(monsterId)
    if monsterTable then
        ---初始化名称
        self.name.text = monsterTable:GetName() == nil and '' or monsterTable:GetName()
        ---初始化icon
        self.headIcon.spriteName = monsterTable:GetHead() == nil and '' or monsterTable:GetHead()
        ---初始化icon背景
        -- self.headIconBg.spriteName = monsterTable:GetHead() == nil and '' or monsterTable:GetHead()
        ---初始化等级
        self.level.text = monsterTable:GetLevel() == nil and '' or monsterTable:GetLevel()
    end
    self.headIconBg.spriteName = 'g3'
    self:RefreshDropList(monsterId)
    self.bg.gameObject:SetActive(self.line ~= nil and self.line % 2 ~= 1)
end

---刷新掉落列表
function UIChallengeBoss_OldAncientBossTemplates:RefreshDropList(monsterId)
    local dropList = Utility.GetBossPanelDropList(monsterId)
    if dropList then
        self.dropItemGrid.MaxCount = #dropList
        for k, v in pairs(dropList) do
            local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(v)

            local go = self.dropItemGrid.controlList[k - 1]
            if infobool then
                local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                temp:RefreshUIWithItemInfo(iteminfo, 1)
                CS.UIEventListener.Get(go.gameObject).onClick = function(go)
                    if temp.ItemInfo ~= nil then
                        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = temp.ItemInfo, showRight = false })
                    end
                end
            end
        end
    end
end

---刷新远古相关
function UIChallengeBoss_OldAncientBossTemplates:RefreshAncientBossInfo(ancientBossInfo)
    if not ancientBossInfo.canChange then
        local needMonsterName = ''
        local isFind, ancientBossTable = CS.Cfg_AncientBossTableManager.Instance:TryGetValue(ancientBossInfo.allInfo[1].configId)
        if isFind then
            if ancientBossTable.need ~= nil and ancientBossTable.need.list.Count > 0 then
                ---暂时只取第1个
                ---@type TABLE.CFG_MONSTERS
                local monsterTblTemp
                ___, monsterTblTemp = CS.Cfg_MonsterTableManager.Instance:TryGetValue(ancientBossTable.need.list[0])
                if monsterTblTemp ~= nil then
                    needMonsterName = monsterTblTemp.name
                end
            end
        end
        --显示剩余
        self.AllKilled.text = "[dde6eb]击杀 [e85038]" .. tostring(ancientBossInfo.bossCount) .. "[-]/" .. tostring(ancientBossTable.num) .. "只 " .. needMonsterName .. "[-]"
    end
    self.AllKilled.gameObject:SetActive(not ancientBossInfo.canChange)
    self:RefreshMapBtn(ancientBossInfo.canChange)
end

function UIChallengeBoss_OldAncientBossTemplates:RefreshMapBtn(canChange)
    if not canChange then
        self.selectMap.MaxCount = 0
        return
    end
    self.selectMap.MaxCount = #self.allBossInfo
    for i = 1, #self.allBossInfo do
        local bossInfo = self.allBossInfo[i]
        local mapId = bossInfo.mapId
        local bossID = bossInfo.bossId
        local bossTbl = clientTableManager.cfg_bossManager:TryGetValue(bossID)
        local go = self.selectMap.controlList[i - 1]
        if go then
            --local bg = CS.Utility_Lua.GetComponent(go.transform:Find("backGround"), "Top_UISprite")
            local name = CS.Utility_Lua.GetComponent(go.transform:Find("lab_name"), "Top_UILabel")
            local isFind, mapTable = CS.Cfg_MapTableManager.Instance.dic:TryGetValue(mapId)
            if isFind then
                name.text = mapTable.name
                CS.UIEventListener.Get(go).onClick = function(go)
                    self:ClickOperation(bossInfo, bossTbl, go)
                end
            end
        end
    end
end

--endregion

---点击操作
function UIChallengeBoss_OldAncientBossTemplates:ClickOperation(bossInfo, bossTable, go)
    if bossTable == nil then
        return
    end
    local isMeetCondition = self:IsMeetCondition(bossTable)
    local EventParameDic = self:AnalysisEventParameters(bossTable)
    if EventParameDic == nil then
        return
    end
    local number = 1
    if isMeetCondition == false then
        number = 2
    end
    self:ConditionOperation(EventParameDic[number], go, bossTable, bossInfo)
end

---是否满足条件
function UIChallengeBoss_OldAncientBossTemplates:IsMeetCondition(bossTable)
    if bossTable == nil then
        return false
    end
    local isMeet = true
    if bossTable:GetLevel() ~= nil then
        for i = 0, bossTable:GetLevel().list.Count - 1 do
            local conditionID = bossTable:GetLevel().list[i]
            if CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(conditionID) == false then
                isMeet = false
            end
        end
    end
    return isMeet
end

---解析条件类型参数
---@param bossTable TABLE.cfg_boss
---@return table<number,BossOperationParame>
function UIChallengeBoss_OldAncientBossTemplates:AnalysisEventParameters(bossTable)
    if bossTable == nil then
        return nil
    end
    local eventParameters = bossTable:GetEventParameters()
    if eventParameters == nil or eventParameters == "" then
        return nil
    end
    local temp1 = _fSplit(eventParameters, "&")
    local EventParameDic = {}
    local temp2 = _fSplit(tostring(temp1[1]), "#")
    local Meet = {
        OperationType = tonumber(temp2[1]),
        OperationParame = tostring(temp2[2]),
    }
    EventParameDic[1] = Meet
    if #temp1 == 1 then
        return EventParameDic
    end

    local temp3 = _fSplit(tostring(temp1[2]), "#")
    local NotMeet = {
        OperationType = tonumber(temp3[1]),
        OperationParame = tostring(temp3[2]),
    }
    EventParameDic[2] = NotMeet
    return EventParameDic
end

---条件操作
---@param BossOperationParame BossOperationParame
function UIChallengeBoss_OldAncientBossTemplates:ConditionOperation(BossOperationParame, go, bossTable, bossInfo)
    if BossOperationParame == nil then
        return
    end
    if BossOperationParame.OperationType == LuaEnumBossOperationType.FindTarget then
        self:FindTarget(BossOperationParame.OperationParame, bossTable, false, bossInfo)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.Bubble then
        self:Bubble(BossOperationParame.OperationParame, go)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.JumpPanel then
        self:JumpPanel(BossOperationParame.OperationParame, go)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.Deliver then
        self:Deliver(bossTable)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.FindTargetTeleporter then
        self:FindTarget(BossOperationParame.OperationParame, bossTable, true)
    elseif BossOperationParame.OperationType == LuaEnumBossOperationType.GoToDeliverDirectly then
        self:GoForDeliverTarget(bossTable)
    end
end

---寻找目标
---@param bossTable TABLE.cfg_boss
function UIChallengeBoss_OldAncientBossTemplates:FindTarget(OperationParame, bossTable, isFindTeleporter, bossInfo)
    ---@type TABLE.CFG_MAP
    local mapTbl
    ___, mapTbl = CS.Cfg_MapTableManager.Instance:TryGetValue(bossInfo.mapId)
    local res = CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(CS.CSScene.MainPlayerInfo.AsyncOperationController.BossPanelFindBossOperation:DoOperation(bossInfo.mapId, mapTbl.announceDeliver, isFindTeleporter, OperationParame))
    if res < 0 then
        CS.CSScene.MainPlayerInfo.AsyncOperationController.PauseAndExitDuplicate:TryPauseOperation(function()
            CS.MainPlayerAsyncOperation.MainPlayerAsyncOperationUtil.TransferFinishCodeEnumToInt(CS.CSScene.MainPlayerInfo.AsyncOperationController.BossPanelFindBossOperation:DoOperation(bossInfo.mapId, mapTbl.announceDeliver, isFindTeleporter, OperationParame))
            uimanager:ClosePanel("UIBossPanel")
        end)
        return
    end
    uimanager:ClosePanel("UIBossPanel")
end

---弹出气泡
function UIChallengeBoss_OldAncientBossTemplates:Bubble(OperationParame, go)
    Utility.ShowPopoTips(go.transform, nil, tonumber(OperationParame))
end

---跳转面板
function UIChallengeBoss_OldAncientBossTemplates:JumpPanel(OperationParame)
    uiTransferManager:TransferToPanel(tonumber(OperationParame))
    -- uimanager:ClosePanel("UIBossPanel")
end

---Deliver传送
function UIChallengeBoss_OldAncientBossTemplates:Deliver(bossTable)
    if bossTable == nil then
        return
    end
    networkRequest.ReqDeliverByConfig(tonumber(bossTable:GetDeliverId()))
    uimanager:ClosePanel("UIBossPanel")
end

---前往deliveID对应的地图
---@param bossTable TABLE.cfg_boss
function UIChallengeBoss_OldAncientBossTemplates:GoForDeliverTarget(bossTable)
    if bossTable == nil then
        return
    end
    ---@type TABLE.CFG_DELIVER
    local deliverTbl
    ___, deliverTbl = CS.Cfg_DeliverTableManager.Instance:TryGetValue(bossTable:GetDeliverId())
    if deliverTbl ~= nil then
        local res = CS.CSPathFinderManager.Instance:SetFixedDestination(
                deliverTbl.toMapId,
                { x = deliverTbl.x, y = deliverTbl.y },
                CS.EAutoPathFindSourceSystemType.Boss,
                CS.EAutoPathFindType.Boss_FightWithAncientBoss,
                2,
                deliverTbl.id
        )
        if res then
            uimanager:ClosePanel("UIBossPanel")
        end
    end
end

--region otherFunc

--endregion



return UIChallengeBoss_OldAncientBossTemplates