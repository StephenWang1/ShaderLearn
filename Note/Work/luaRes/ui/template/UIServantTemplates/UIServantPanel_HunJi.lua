---魂继
---@class UIServantPanel_HunJI:UIServantBasicPanel
local UIServantPanel_HunJI = {}

setmetatable(UIServantPanel_HunJI, luaComponentTemplates.UIServantBasicPanel)

function UIServantPanel_HunJI:GetModel_ObservationModel()
    if (self.mModel == nil) then
        self.mModel = CS.ObservationModel()
    end
    return self.mModel
end

function UIServantPanel_HunJI:GetServantName_UILabel()
    if (self.mServantName_UILabel == nil) then
        self.mServantName_UILabel = self:Get("view/rolename", "UILabel")
    end
    return self.mServantName_UILabel
end

---魂继装备的ScrollView
---@return UIScrollView
function UIServantPanel_HunJI:GetServantHunJiEquipScrollView()
    if self.mServantHunJiEquipScrollView == nil then
        self.mServantHunJiEquipScrollView = self:Get("view/hunjis/equips", "UIScrollView")
    end
    return self.mServantHunJiEquipScrollView
end

---@return UnityEngine.GameObject
function UIServantPanel_HunJI:GetModelRoot()
    if (self.mView == nil) then
        self.mView = self:Get("view/ModelRoot", "GameObject")
    end
    return self.mView
end

---魂继根节点
---@return UnityEngine.GameObject
function UIServantPanel_HunJI:GetServantHunJisRoot()
    if self.mServantHunJisRootGO == nil then
        self.mServantHunJisRootGO = self:Get("view/hunjis", "GameObject")
    end
    return self.mServantHunJisRootGO
end

---@return UIGridContainer
function UIServantPanel_HunJI:GetServantHunjiEquipGrids()
    if self.mServantHunjiEquipGrids == nil then
        self.mServantHunjiEquipGrids = self:Get("view/hunjis/equips/grids", "UIGridContainer")
    end
    return self.mServantHunjiEquipGrids
end

---魂继通灵按钮图片
---@return UISprite
function UIServantPanel_HunJI:GetServantPsychicsSprite()
    if self.mServantPsychicsSprite == nil then
        self.mServantPsychicsSprite = self:Get("view/btn_psychics", "UISprite")
    end
    return self.mServantPsychicsSprite
end

---魂继通灵按钮缩放
---@return UIButtonScale
function UIServantPanel_HunJI:GetServantPsychicsTweenScale()
    if self.mServantPsychicsSpriteTweenScale == nil then
        self.mServantPsychicsSpriteTweenScale = self:Get("view/btn_psychics", "UIButtonScale")
    end
    return self.mServantPsychicsSpriteTweenScale
end

---灵兽等级不足提示Label
---@return UILabel
function UIServantPanel_HunJI:GetServantLevelUnmatchSignLabel()
    if self.mServantLevelUnmatchSignLabel == nil then
        self.mServantLevelUnmatchSignLabel = self:Get("view/hunjis/levelUnmatchSign", "UILabel")
    end
    return self.mServantLevelUnmatchSignLabel
end

function UIServantPanel_HunJI:Init(panel)
    ---@type UIServantPanel
    self.ServantPanel = panel
    self.mOnServantPsychicsButtonClicked = function()
        self:OnServantPsychicsButtonClicked()
    end
end

function UIServantPanel_HunJI:Show()
    self.go:SetActive(true)
    self:BindEvents()
    self:SetSelectedHunJi(nil)
end

function UIServantPanel_HunJI:Hide()
    self.go:SetActive(false)
    self:ReleaseEvents()
    self:SetSelectedHunJi(nil)
end

---设置选中的魂继
---@param grid UIServantHunJiEquipGridTemplate
function UIServantPanel_HunJI:SetSelectedHunJi(grid)
    if self.mSelectedGrid == grid then
        return
    end
    if self.mSelectedGrid ~= nil then
        self.mSelectedGrid:SetChooseState(false)
    end
    self.mSelectedGrid = grid
    if self.mSelectedGrid ~= nil then
        self.mSelectedGrid:SetChooseState(true)
        if self.ServantSeatType ~= nil then
            if self.mSelectedGrid.bagItemInfo ~= nil then
                CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType).HunJi.PreviewItem = self.mSelectedGrid.bagItemInfo
                uiStaticParameter.mSelectedHunJiPos = self.mSelectedGrid.bagItemInfo.index
            else
                CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType).HunJi.PreviewItem = nil
                uiStaticParameter.mSelectedHunJiPos = nil
            end
        end
    else
        if self.ServantSeatType ~= nil and CS.CSScene.MainPlayerInfo ~= nil then
            CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType).HunJi.PreviewItem = nil
            uiStaticParameter.mSelectedHunJiPos = nil
        end
    end
end

---获取选中的魂继
---@return UIServantHunJiEquipGridTemplate|nil
function UIServantPanel_HunJI:GetSelectedHunJi()
    return self.mSelectedGrid
end

function UIServantPanel_HunJI:BindEvents()
    if self.ServantPanel ~= nil and self.ServantPanel.mPanelOpenSourceType ~= LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant then
        if self.mMainPlayerHunJiInfoChangedEvent == nil then
            self.mMainPlayerHunJiInfoChangedEvent = function(uiEvtID, servantType)
                self:OnMainPlayerServantHunJIChanged(uiEvtID, servantType)
            end
        end
        self.ServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerHunJiInfoChanged, self.mMainPlayerHunJiInfoChangedEvent)
        self.ServantPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_HunJiPreviewStateChanged, function()
            self:UpdateServantModel(self:GetModel_ObservationModel(), self:GetModelRoot())
        end)
        self:GetServantPsychicsSprite().gameObject:SetActive(true)
    else
        self:GetServantPsychicsSprite().gameObject:SetActive(false)
    end
end

function UIServantPanel_HunJI:ReleaseEvents()
    if self.ServantPanel ~= nil and self.ServantPanel.mPanelOpenSourceType ~= LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant and self.mMainPlayerHunJiInfoChangedEvent ~= nil then
        self.ServantPanel:GetClientEventHandler():RemoveEvent(CS.CEvent.V2_MainPlayerHunJiInfoChanged, self.mMainPlayerHunJiInfoChangedEvent)
        self.mMainPlayerHunJiInfoChangedEvent = nil
    end
end

---主角灵兽魂继变化事件
function UIServantPanel_HunJI:OnMainPlayerServantHunJIChanged(uiEvtID, servantType)
    if servantType ~= nil and self.ServantPanel ~= nil and servantType == self.ServantSeatType then
        self:RefreshGrids()
    end
end

---刷新灵兽
---@param servantInfo servantV2.ServantInfo
---@param panelOpenType LuaEnumPanelOpenSourceType 灵兽界面打开类型(可以为空)
---@param bagItemInfo bagV2.BagItemInfo 设置默认选中格子
function UIServantPanel_HunJI:RefreshServant(servantInfo, panelOpenType, bagItemInfo)
    self:SetSelectedHunJi(nil)
    self.ServantInfo = servantInfo
    self.ServantPanelOpenType = panelOpenType
    if servantInfo == nil then
        self.ServantSeatType = 0
    else
        self.ServantSeatType = servantInfo.type
    end
    local seatData
    local isOtherPlayerServant = self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant
    if isOtherPlayerServant then
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.OtherPlayerServantData:GetServantSeatData(self.ServantSeatType)
    else
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType)
    end
    if seatData ~= nil and seatData.State ~= CS.CSServantSeatData.SeatState.Locked and seatData.State ~= CS.CSServantSeatData.SeatState.Recall then
        self:GetServantName_UILabel().text = seatData:GetServantName(false, false)
    else
        self:GetServantName_UILabel().text = ""
    end
    local ServantItemHeadList = self.ServantPanel.ServantItemHeadList;
    for k, v in pairs(ServantItemHeadList) do
        v:UpdateServantIconShadow();
    end
    --未装备幻兽 空档位
    if (self.mLastHeadInfo ~= nil) then
        self.mLastHeadInfo:HideAllBackGround();
    end
    if (self.ServantPanel:GetSelectHeadInfo() ~= nil) then
        self.ServantPanel:GetSelectHeadInfo():UpdateBackGround();
        self.mLastHeadInfo = self.ServantPanel:GetSelectHeadInfo();
    end

    self:UpdateServantModel(self:GetModel_ObservationModel(), self:GetModelRoot())
    if (self.ServantPanel:GetSelectHeadInfo() ~= nil) then
        local servantSeatData = self:GetServantSeatData()
        local isHideLockTip
        if servantSeatData and servantSeatData.State == CS.CSServantSeatData.SeatState.Recall then
            isHideLockTip = true
        end
        self.ServantPanel:GetSelectHeadInfo():UpdateBackGround(isHideLockTip);
        self.mLastHeadInfo = self.ServantPanel:GetSelectHeadInfo();
    end
    self:RefreshGrids()
end

---更新灵兽模型
---@param ObservationModel ObservationModel
---@param ModelRootGO UnityEngine.GameObject
function UIServantPanel_HunJI:UpdateServantModel(ObservationModel, ModelRootGO)
    if ObservationModel == nil or CS.StaticUtility.IsNull(ModelRootGO) then
        return
    end
    ---@type CSServantSeatData_OtherPlayer|CSServantSeatData_MainPlayer
    local seatData
    if self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant then
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.OtherPlayerServantData:GetServantSeatData(self.ServantSeatType)
    else
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType)
    end
    local monsterID
    local servantID
    if seatData ~= nil and seatData.State ~= CS.CSServantSeatData.SeatState.Locked and seatData.State ~= CS.CSServantSeatData.SeatState.Recall then
        monsterID = seatData:GetMonsterID(true)
        --servantID = seatData.ServantInfo.cfgId
        servantID = monsterID
    end
    if self.mPreviousServantModelMID == monsterID then
        --print("self.mPreviousServantModelMID == monsterID")
        return
    end
    self.mPreviousServantModelMID = monsterID
    if servantID == nil or self.mPreviousServantModelMID == nil or self.mPreviousServantModelMID == 0 then
        ObservationModel:ClearModel()
        --print("ObservationModel:ClearModel()")
        self.mPreviousServantModelMID = nil
        return
    end
    local servant
    ---@type TABLE.CFG_MONSTERS
    local monsterTbl
    ___, servant = CS.Cfg_ServantTableManager.Instance:TryGetValue(servantID)
    ___, monsterTbl = CS.Cfg_MonsterTableManager.Instance:TryGetValue(self.mPreviousServantModelMID)
    if monsterTbl ~= nil then
        self.mCurSerVantModelId = monsterTbl.model
    else
        self.mCurSerVantModelId = 0
    end
    if (servant ~= nil) then
        self.mWeight = servant.weight
        self.mTotalWeight = servant.weight
        self.mHSScale = servant.hsScale / 100
    else
        --print("ObservationModel:ClearModel()")
        ObservationModel:ClearModel()
        self.mPreviousServantModelMID = nil
        return
    end
    --print("ObservationModel:ClearModel()")
    ObservationModel:ClearModel()
    ObservationModel:SetShowMotion(CS.CSMotion.ShowStand)
    ObservationModel:SetPosition(CS.UnityEngine.Vector3(-180 - servant.offsetX, -150 + servant.y, 300))
    ObservationModel:SetRotation(CS.UnityEngine.Vector3(0, 180, 0))
    ObservationModel:SetPositionDeviation(servant.offsetX)
    ObservationModel:SetBindRenderQueue()
    ObservationModel:SetDragRoot(ModelRootGO)
    ObservationModel:CreateModel(self.mCurSerVantModelId, CS.EAvatarType.Monster, ModelRootGO.transform, function()
        if (self.mWeight ~= nil and self.mTotalWeight ~= nil and self.mTotalWeight ~= 0 and self.mHSScale ~= 0 and self.ServantPanel:GetSelectServantInfo() ~= nil) then
            ObservationModel:ResetCurScale()
            local num = tonumber(self.ServantPanel:GetSelectServantInfo().weight / self.mTotalWeight * self.mHSScale)-- * self.mScaleK
            ObservationModel:SetScaleSizeforRatio(num * 1.2)
        end
    end)
end

function UIServantPanel_HunJI:ShowFull(full)

end

---刷新格子
function UIServantPanel_HunJI:RefreshGrids()
    if self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant then
        ---其他玩家的魂继暂时不显示
        if self.mServantHunjiEquipGrids ~= nil and CS.StaticUtility.IsNull(self.mServantHunjiEquipGrids) == false then
            self.mServantHunjiEquipGrids.MaxCount = 0
            self.mServantHunjiEquipGrids.gameObject:SetActive(false)
        end
        return
    end
    local servantSeatData = self:GetServantSeatData()
    if servantSeatData == nil then
        ---灵兽位未解锁
        self:GetServantHunJisRoot().gameObject:SetActive(false)
        self:GetServantPsychicsSprite().gameObject:SetActive(false)
        return
    end
    if servantSeatData.State == CS.CSServantSeatData.SeatState.Locked then
        ---锁住状态,关闭魂继装备部分
        self:GetServantHunJisRoot():SetActive(false)
        return
    end
    self:GetServantHunJisRoot():SetActive(true)
    ---最大魂继格子数量
    local maxGridCount = servantSeatData.HunJi.HunJiMaxGridCount
    ---魂继装备列表
    local equips = servantSeatData.HunJi.HunJiEquips
    ---空格是否存在
    local isEmptyGridExist
    ---UI上格子数量
    local gridCount = 0
    ---灵兽装备列表数量
    local equipCount = 0
    if equips == nil then
        isEmptyGridExist = maxGridCount > 0
        if isEmptyGridExist then
            gridCount = 1
        end
    else
        equipCount = equips.Count
        isEmptyGridExist = equipCount < maxGridCount and maxGridCount > 0
        if isEmptyGridExist then
            gridCount = equipCount + 1
        else
            gridCount = equipCount
        end
    end
    ---查询下个等级的魂继格子是否存在,以及其解锁等级,转生等级,解锁得到的格子数量
    local isNextLevelHunjiGridExist, nextServantLevel, nextServantReinLevel, nextMaxCount = servantSeatData.HunJi:IsNextLevelHunjiGridsExist()
    if isNextLevelHunjiGridExist and isEmptyGridExist then
        ---有空格的情况下,不显示下个等级的魂继格子(即不显示加锁的格子)
        isNextLevelHunjiGridExist = false
    end
    ---灵兽等级是否不符合魂继等级
    local isServantLevelUnmatchHunJi = false
    if maxGridCount == 0 then
        ---当前格子数量为0的情况下,不显示下个等级的魂继格子(即不显示加锁的格子)
        isNextLevelHunjiGridExist = false
        isServantLevelUnmatchHunJi = true
    end
    if isNextLevelHunjiGridExist then
        gridCount = gridCount + 1
    end
    ---设定魂继格子数量
    self:GetServantHunjiEquipGrids().MaxCount = gridCount
    ---当前通灵的魂继位置
    local servantSeatUsedHunJiID
    if servantSeatData.HunJi.CurrentUsedHunJi ~= nil then
        servantSeatUsedHunJiID = servantSeatData.HunJi.CurrentUsedHunJi.lid
    end
    if servantSeatUsedHunJiID == nil then
        self:GetServantPsychicsSprite().gameObject:SetActive(true)
        CS.UIEventListener.Get(self:GetServantPsychicsSprite().gameObject).onClick = self.mOnServantPsychicsButtonClicked
        self:GetServantPsychicsTweenScale().enabled = true
        self:GetServantPsychicsSprite().spriteName = "Servant_unpsychics"
    else
        self:GetServantPsychicsSprite().gameObject:SetActive(true)
        CS.UIEventListener.Get(self:GetServantPsychicsSprite().gameObject).onClick = nil
        self:GetServantPsychicsTweenScale().enabled = false
        self:GetServantPsychicsSprite().spriteName = "Servant_psychics"
    end
    ---刷新格子状态
    if gridCount > 0 then
        self:GetServantLevelUnmatchSignLabel().gameObject:SetActive(false)
        local isAnyAvailableHunJiToEquipOnServantSeat = servantSeatData:IsAnyAvailableHunJiInBagToEquipInServantSeat(true)
        for i = 0, gridCount - 1 do
            local go = self:GetServantHunjiEquipGrids().controlList[i]
            local template = self:GetServantGridTemplateByGameObject(go)
            ---只需要主角的灵兽魂继格子
            template:RefreshServantSeatType(self.ServantSeatType)
            if i < equipCount then
                local isHunJiUsed = false
                ---@type bagV2.BagItemInfo
                local equipTemp = equips[i]
                if equipTemp ~= nil and servantSeatData.HunJi.CurrentUsedHunJi ~= nil and servantSeatUsedHunJiID ~= nil then
                    isHunJiUsed = equipTemp.lid == servantSeatUsedHunJiID
                end
                template:RefreshWithHunJi(equipTemp, isHunJiUsed)
            elseif i == equipCount and isEmptyGridExist then
                ---当前背包中是否有可用的魂继装备
                template:RefreshWithEmptyGrid(isAnyAvailableHunJiToEquipOnServantSeat)
            elseif i == gridCount - 1 and isNextLevelHunjiGridExist then
                template:RefreshWithLockGrid(nextServantLevel, nextServantReinLevel, nextMaxCount)
            end
        end
    else
        if isServantLevelUnmatchHunJi then
            ---若当前灵兽等级不足,则显示魂继开启条件
            self:GetServantLevelUnmatchSignLabel().gameObject:SetActive(true)
            self:GetServantLevelUnmatchSignLabel().text = "灵兽" .. tostring(nextServantLevel) .. "级开启"
            return
        end
        self:GetServantLevelUnmatchSignLabel().gameObject:SetActive(false)
    end
    self:ScrollToEndOfScrollView()
end

---滚到ScrollView的最低层
function UIServantPanel_HunJI:ScrollToEndOfScrollView()
    local currentLineCount = math.ceil(self:GetServantHunjiEquipGrids().MaxCount / self:GetServantHunjiEquipGrids().MaxPerLine)
    --local scrollLineCount = math.ceil(-1 * self:GetServantHunJiEquipScrollView().panel.clipOffset.y / self:GetServantHunJiEquipScrollView().momentumAmount)
    --self:GetServantHunJiEquipScrollView():Scroll(-1 * (currentLineCount - scrollLineCount - 1))
    if currentLineCount <= 2 then
        --若不超过2行,则滑到最上方
        self:GetServantHunJiEquipScrollView():ScrollImmediately(0)
    else
        --若多于2行,则滑到最下方
        self:GetServantHunJiEquipScrollView():ScrollImmediately(1)
    end
end

---@private
---@return CSServantSeatData
function UIServantPanel_HunJI:GetServantSeatData()
    local seatData
    if self.ServantPanelOpenType == LuaEnumPanelOpenSourceType.ByCheckOtherPeopleServant then
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.OtherPlayerServantData:GetServantSeatData(self.ServantSeatType)
    else
        seatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType)
    end
    return seatData
end

---@private
---根据格子的GameObject获取模板
---@return UIServantHunJiEquipGridTemplate
function UIServantPanel_HunJI:GetServantGridTemplateByGameObject(go)
    if self.mServantHunjiGrids == nil then
        ---@type table<UnityEngine.GameObject,UIServantHunJiEquipGridTemplate>
        self.mServantHunjiGrids = {}
    end
    local template = self.mServantHunjiGrids[go]
    if template ~= nil then
        return template
    end
    template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIServantHunJiEquipGridTemplate, self)
    self.mServantHunjiGrids[go] = template
    return template
end

---灵兽魂继界面上的未通灵按钮点击事件
---@private
function UIServantPanel_HunJI:OnServantPsychicsButtonClicked()
    if self.ServantSeatType == nil then
        return
    end
    ---@type CSServantSeatData_MainPlayer
    local servantSeatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.ServantSeatType)
    if servantSeatData == nil then
        return
    end
    local bagItem = servantSeatData:GetBestHunJiEquipInServantSeat()
    if bagItem ~= nil then
        local grid
        for i, v in pairs(self.mServantHunjiGrids) do
            if v.bagItemInfo == bagItem then
                grid = v
            end
        end
        if grid == nil then
            return
        end
        self:SetSelectedHunJi(grid)
        ---@type ItemInfoData
        local customData = {}
        customData.bagItemInfo = bagItem
        customData.showRight = true
        customData.showAssistPanel = true
        customData.showBind = true
        customData.highLightBtnTable = {}
        table.insert(customData.highLightBtnTable, LuaEnumItemOperateType.HunJiTongLing)
        uiStaticParameter.UIItemInfoManager:CreatePanel(customData)
    end
end

function UIServantPanel_HunJI:OnDestroy()
    self:ReleaseEvents()
    self:SetSelectedHunJi(nil)
end

return UIServantPanel_HunJI