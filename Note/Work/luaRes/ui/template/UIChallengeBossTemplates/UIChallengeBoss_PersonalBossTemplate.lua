---@class UIChallengeBoss_PersonalBossTemplate:UIChallengeBossBaseTemplates 个人boss单元模板
local UIChallengeBoss_PersonalBossTemplate = {}
setmetatable(UIChallengeBoss_PersonalBossTemplate, luaComponentTemplates.UIChallengeBossBaseTemplates)
--region 初始化
function UIChallengeBoss_PersonalBossTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---地图信息按钮
    self.btn_go = self:Get("btn_go", "GameObject")
    ---地图名称
    self.lab_name = self:Get("btn_go/lab_name", "UILabel")
    ---地图怪物数量
    self.lab_num = self:Get("btn_go/lab_num", "UILabel")
    ---掉落道具展示
    self.dropItemGrid = self:Get("dropScroll/DropItem", "UIGridContainer")
    ---@type UIGridSpriteTiled bg平铺替换
    self.dropItemTiled = self:Get("dropScroll/DropItem", "UIGridSpriteTiled")
    ---UIScrollView
    self.UIScrollView = self:Get("dropScroll", "UIScrollView")
    ---@type UISprite 按钮背景图
    self.backGround_UISprite = self:Get("btn_go/backGround", "UISprite")
    ---@type UnityEngine.GameObject 按钮消耗物
    self.costObj = self:Get("btn_go/cost", "GameObject")
    ---@type UISprite 按钮消耗物icon
    self.costIcon = self:Get("btn_go/cost/icon", "UISprite")
    ---@type UILabel 按钮消耗物label
    self.costNum = self:Get("btn_go/cost/num", "UILabel")
end

function UIChallengeBoss_PersonalBossTemplate:InitOther()
    self:RunBaseFunction("InitOther")
    CS.UIEventListener.Get(self.btn_go).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_go).OnClickLuaDelegate = self.OnClickBossInfoBtn
    CS.UIEventListener.Get(self.costIcon.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.costIcon.gameObject).OnClickLuaDelegate = self.OnClickCostIcon
end

function UIChallengeBoss_PersonalBossTemplate:OnClickCostIcon()
    local isFind, itemTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.needItemId)
    if isFind then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemTbl, showRight = false })
    end
end

---点击怪物信息按钮
function UIChallengeBoss_PersonalBossTemplate:OnClickBossInfoBtn(go)
    if self.bossTable == nil then
        return
    end
    self:ClickOperation(self.bossTable, go)
end

---点击操作
function UIChallengeBoss_PersonalBossTemplate:ClickOperation(bossTable, go)
    if bossTable == nil then
        return
    end
    if self.fieldBossInfo == nil or self.fieldBossInfo.count == 0 then
        Utility.ShowPopoTips(go, nil, 481, "UIBossPanel")
        return
    elseif not self:IsMeetPersonalCondition(0) then
        Utility.ShowPopoTips(go, nil, 478, "UIBossPanel")
        return
    elseif not self:IsMeetPersonalCondition(1) then
        if self.needItemId ~= nil then
            local bgWidth = self.backGround_UISprite.width
            Utility.ShowItemGetWay(self.needItemId, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(bgWidth / 2, 0), nil, nil, nil, false);
        else
            Utility.ShowPopoTips(go, nil, 72, "UIBossPanel")
        end

        return
    end

    local EventParameDic = self:AnalysisEventParameters(bossTable)
    if EventParameDic == nil then
        return
    end
    self:ConditionOperation(EventParameDic[1], go, bossTable)
    self:AllServantChangeState()
end

---显示boss模型信息
---@param monsterTable TABLE.cfg_monsters
function UIChallengeBoss_PersonalBossTemplate:ShowModelInfo(monsterTable)
    if monsterTable == nil then
        return
    end
    local nameColor = LuaGlobalTableDeal.GetMonsterNameColorByType(tostring(monsterTable:GetType()))
    self.name.text = nameColor .. monsterTable:GetName()
end

---@param data table<number,bossV2.FieldBossInfo>
function UIChallengeBoss_PersonalBossTemplate:RefreshUI(data, ClipShader)
    self:RunBaseFunction("RefreshUI", data, ClipShader)
    self:SetBossInfoBtn()
    self:RefreshDropItemView()
    self:RefreshClearBtn()
end

---刷新掉落道具视图
function UIChallengeBoss_PersonalBossTemplate:RefreshDropItemView()
    if self.bossTable == nil then
        return
    end
    local monsterID = self.bossTable:GetConfId()
    local dropList
    if clientTableManager.cfg_monstersManager.GetDropShowList ~= nil then
        dropList = clientTableManager.cfg_monstersManager:GetDropShowList(monsterID)
    end
    if dropList then
        self.dropItemGrid.MaxCount = #dropList
        if self.dropItemTiled~=nil then
            self.dropItemTiled.MaxCount = #dropList
        end
        for i = 1, #dropList do
            if dropList[i]:GetItemId() ~= nil then
                local infobool, iteminfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(dropList[i]:GetItemId())
                local go = self.dropItemGrid.controlList[i - 1]
                if infobool then
                    local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIItem)
                    temp:RefreshUIWithItemInfo(iteminfo, 1)
                    temp:RefreshOtherUI({ showItemInfo = iteminfo })
                end
            end
        end
    end
    self.UIScrollView:ResetPosition()

end

---刷新怪物按钮视图
function UIChallengeBoss_PersonalBossTemplate:SetBossInfoBtn()
    if self.bossTable == nil or self.fieldBossInfo == nil then
        return
    end
    local isChallenged = self.fieldBossInfo.count == 0
    local mapNameList = string.Split(self.bossTable:GetMapName(), "#")
    local name = ""
    local spriteName = 'bo1'
    if isChallenged then
        name = tostring(mapNameList[2])
        spriteName = "bo2"
    elseif self:IsMeetPersonalCondition(0) then
        ---达到会员条件就亮起
        name = tostring(mapNameList[1])
    else
        spriteName = "bo2"
        name = tostring(mapNameList[3])
    end
    self.lab_name.text = name
    self.backGround_UISprite.spriteName = spriteName
    self:RefreshBtnCost()
end

---刷新按钮消耗物品(未满足会员或者已挑战不显示)
function UIChallengeBoss_PersonalBossTemplate:RefreshBtnCost()
    local isChallenged = self.fieldBossInfo.count == 0
    if isChallenged then
        self.costObj:SetActive(false)
        return
    end

    local isMeetMemberCondition = false
    isMeetMemberCondition = self:IsMeetPersonalCondition(0)
    local isMeetItemCondition = self:IsMeetPersonalCondition(1)

    if isMeetMemberCondition and not isChallenged then

        local needInfo = LuaGlobalTableDeal.GetNeedItemAndCountByBossId(self.bossTable:GetId())
        if needInfo then
            self.needItemId = needInfo.itemId
            local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.needItemId)
            if itemTbl then
                self.costIcon.spriteName = itemTbl:GetIcon()
            end
            local bagItemCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(self.needItemId)
            local color = isMeetItemCondition and luaEnumColorType.Green3 or luaEnumColorType.Red
            self.costNum.text = color .. tostring(bagItemCount) .. '[-]/' .. tostring(needInfo.count)
            self.costIcon:UpdateAnchors()
        end
    end
    self.costObj:SetActive(isMeetMemberCondition)
end

---是否满足条件
---@param index  number 索引
---@return boolean
---@return number
function UIChallengeBoss_PersonalBossTemplate:IsMeetPersonalCondition(index)
    if self.bossTable == nil then
        return false
    end
    local isMeet = false
    if self.bossTable:GetLevel() ~= nil and self.bossTable:GetLevel().list.Count > 0 then
        if index == 0 then
            local memberCondition = self.bossTable:GetLevel().list[0]
            isMeet = Utility.IsMainPlayerMatchCondition(memberCondition).success
        elseif index == 1 then
            local needInfo = LuaGlobalTableDeal.GetNeedItemAndCountByBossId(self.bossTable:GetId())
            if needInfo then
                local bagItemCount = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemAndMoneyCount(needInfo.itemId)
                isMeet = bagItemCount >= needInfo.count
            end
        end
    end
    return isMeet
end

--region 扫荡刷新
---刷新扫荡按钮
function UIChallengeBoss_PersonalBossTemplate:RefreshClearBtn()
    local configCanShowClearBtn = LuaGlobalTableDeal:CanShowClearBtn()
    local bossCondition = self:IsMeetPersonalCondition(0)
    local canChallenged = self.fieldBossInfo.count > 0
    local showClearBtn = configCanShowClearBtn and self.bossCanClear and bossCondition and canChallenged
    luaclass.UIRefresh:RefreshActive(self.GoBtn_GameObject, showClearBtn == false)
    luaclass.UIRefresh:RefreshActive(self.DoubleBtn_GameObject,showClearBtn)
    if self.bossCanClear then
        local completeTemplate = templatemanager.GetNewTemplate(self.DoubleBtn_GameObject, luaComponentTemplates.CompleteTemplate)
        if completeTemplate ~= nil then
            ---@type CompleteTemplateCommonData
            local commonData = {}
            commonData.JoinBtnCallBack = function(go)
                if self.bossTable ~= nil then
                    self:ClickOperation(self.bossTable,go)
                end
            end
            commonData.ClearBtnCallBack = function()
                if self.bossTable ~= nil then
                    networkRequest.ReqUseMonsterCleanUpCoupons(LuaEnumClearType.PersonBoss, self.bossTable:GetId())
                end
            end
            if self.bossTable ~= nil then
                commonData.JointCost = LuaGlobalTableDeal.GetNeedItemAndCountByBossId_Cost(self.bossTable:GetId())
            end
            if self.bossTable ~= nil then
                commonData.ClearCost = clientTableManager.cfg_bossManager:GetBossClearCost(self.bossTable:GetId())
            end
            completeTemplate:RefreshPanel(commonData)
        end
    end
end
--endregion

return UIChallengeBoss_PersonalBossTemplate