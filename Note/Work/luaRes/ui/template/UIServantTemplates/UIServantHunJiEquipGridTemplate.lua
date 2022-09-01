---魂继界面的魂继装备格子模板
---@class UIServantHunJiEquipGridTemplate:TemplateBase
local UIServantHunJiEquipGridTemplate = {}

---魂继格子状态枚举
---@class HunJiEquipGridState
UIServantHunJiEquipGridTemplate.HunjiGridState = {
    ---有魂继装备的格子
    Hunji = 1,
    ---空格子
    Empty = 2,
    ---锁住的格子
    Locked = 3
}

--region 属性
---当前格子状态
---@type HunJiEquipGridState
UIServantHunJiEquipGridTemplate.gridState = nil
---格子对应的物品信息
---@type bagV2.BagItemInfo
UIServantHunJiEquipGridTemplate.bagItemInfo = nil
---归属的界面
---@type UIServantPanel_HunJI
UIServantHunJiEquipGridTemplate.ownerPanel = nil
--endregion

--region 组件
---获取icon对应的UISprite
---@return UISprite
function UIServantHunJiEquipGridTemplate:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("icon", "UISprite")
    end
    return self.mIconSprite
end

---锁物体
---@return UnityEngine.GameObject
function UIServantHunJiEquipGridTemplate:GetLockGO()
    if self.mLockGO == nil then
        self.mLockGO = self:Get("lock", "GameObject")
    end
    return self.mLockGO
end

---红点GameObject
---@return UnityEngine.GameObject
function UIServantHunJiEquipGridTemplate:GetRedPointGO()
    if self.mRedPointGO == nil then
        self.mRedPointGO = self:Get("RedPoint", "GameObject")
    end
    return self.mRedPointGO
end

---加号标识
---@return UnityEngine.GameObject
function UIServantHunJiEquipGridTemplate:GetAddSignGO()
    if self.mAddSignGO == nil then
        self.mAddSignGO = self:Get("add", "GameObject")
    end
    return self.mAddSignGO
end

---通灵标识
---@return UnityEngine.GameObject
function UIServantHunJiEquipGridTemplate:GetTongLingSignGO()
    if self.mTongLingSignGO == nil then
        self.mTongLingSignGO = self:Get("psychic", "GameObject")
    end
    return self.mTongLingSignGO
end

---选中标识
---@return UnityEngine.GameObject
function UIServantHunJiEquipGridTemplate:GetChooseGO()
    if self.mChooseGO == nil then
        self.mChooseGO = self:Get("choose", "GameObject")
    end
    return self.mChooseGO
end

---品质文本
---@return UILabel
function UIServantHunJiEquipGridTemplate:GetQualityLabel()
    if self.mQualityLabel == nil then
        self.mQualityLabel = self:Get("icon/quality", "UILabel")
    end
    return self.mQualityLabel
end
--endregion

--region 初始化
function UIServantHunJiEquipGridTemplate:Init(panel)
    self.ownerPanel = panel
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnGridClicked()
    end
end

---刷新灵兽位类型
---@param servantSeatType luaEnumServantSeatType 灵兽位类型
function UIServantHunJiEquipGridTemplate:RefreshServantSeatType(servantSeatType)
    ---@type luaEnumServantSeatType
    self.mServantSeatType = servantSeatType;
end
--endregion

--region 刷新
---刷新为魂继装备格子
---@param bagItemInfo bagV2.BagItemInfo 格子中映射的背包物品
---@param isUsed boolean 是否处于已通灵状态
function UIServantHunJiEquipGridTemplate:RefreshWithHunJi(bagItemInfo, isUsed)
    self.mIsAvailableEquipInBag = nil
    self.bagItemInfo = bagItemInfo
    if self.bagItemInfo == nil or self.bagItemInfo.ItemTABLE == nil then
        self:RefreshWithEmptyGrid()
        return
    end
    self.gridState = self.HunjiGridState.Hunji
    self:RefreshIcon(self.bagItemInfo.ItemTABLE.icon)
    self:RefreshLockState(false)
    self:SetQuality(nil)
    self:SetChooseState(false)
    self:SetAddState(false)
    self:SetRedPointState(false)
    if isUsed then
        self:GetTongLingSignGO():SetActive(true)
    else
        self:GetTongLingSignGO():SetActive(false)
    end
end

---刷新为空格子
---@param isAvailableEquipInBag boolean
function UIServantHunJiEquipGridTemplate:RefreshWithEmptyGrid(isAvailableEquipInBag)
    self.mIsAvailableEquipInBag = isAvailableEquipInBag
    self.gridState = self.HunjiGridState.Empty
    self.bagItemInfo = nil
    self:RefreshIcon("")
    self:RefreshLockState(false)
    self:SetQuality(nil)
    self:SetChooseState(false)
    self:SetAddState(self.mIsAvailableEquipInBag)
    self:GetTongLingSignGO():SetActive(false)
    self:SetRedPointState(false)
end

---刷新为锁住的格子
---@param nextServantLevel number 解锁需要的下个等级
---@param nextServantReinLevel number 解锁需要的下个转生等级
---@param nextMaxCount number 解锁后的格子数量
function UIServantHunJiEquipGridTemplate:RefreshWithLockGrid(nextServantLevel, nextServantReinLevel, nextMaxCount)
    self.mNextServantLevel = nextServantLevel
    self.mNextServantReinLevel = nextServantReinLevel
    self.mNextMaxCount = nextMaxCount
    self.mIsAvailableEquipInBag = nil
    self.gridState = self.HunjiGridState.Locked
    self.bagItemInfo = nil
    self:RefreshIcon("")
    self:RefreshLockState(true)
    self:SetQuality(nil)
    self:SetChooseState(false)
    self:SetAddState(false)
    self:GetTongLingSignGO():SetActive(false)
    self:SetRedPointState(false)
end
--endregion

--region 组件状态切换
---刷新icon
---@private
---@param icon string
function UIServantHunJiEquipGridTemplate:RefreshIcon(icon)
    if self.mIcon ~= icon then
        self.mIcon = icon == nil and "" or icon
        if self.mIcon == "" then
            if self.mIconActive ~= false then
                self.mIconActive = false
                self:GetIconSprite().gameObject:SetActive(false)
            end
        else
            if self.mIconActive ~= true then
                self.mIconActive = true
                self:GetIconSprite().gameObject:SetActive(true)
            end
            self:GetIconSprite().spriteName = self.mIcon
        end
    end
end

---设定品质
---@param quality number|nil
function UIServantHunJiEquipGridTemplate:SetQuality(quality)
    self:GetQualityLabel().gameObject:SetActive(false)
    --if self.mQuality ~= quality then
    --    self.mQuality = quality
    --    if quality == nil or quality == 0 then
    --        self:GetQualityLabel().text = ""
    --    else
    --        self:GetQualityLabel().text = "+" .. tostring(quality)
    --    end
    --end
end

---刷新锁住的状态
---@private
---@param isLocked boolean
function UIServantHunJiEquipGridTemplate:RefreshLockState(isLocked)
    isLocked = isLocked == nil and false or isLocked
    if self.mIsLocked ~= isLocked then
        self.mIsLocked = isLocked == true
        self:GetLockGO():SetActive(self.mIsLocked)
    end
end

---设定选中状态
---@param isChosen boolean
function UIServantHunJiEquipGridTemplate:SetChooseState(isChosen)
    isChosen = isChosen == nil and false or isChosen
    if self.mIsChosen ~= isChosen then
        self.mIsChosen = isChosen == true
        self:GetChooseGO():SetActive(self.mIsChosen)
    end
end

---是否开启加号
---@param isAddOn boolean
function UIServantHunJiEquipGridTemplate:SetAddState(isAddOn)
    isAddOn = isAddOn == nil and false or isAddOn
    if self.mAddState ~= isAddOn then
        self.mAddState = isAddOn
        self:GetAddSignGO():SetActive(isAddOn)
    end
end

---设定红点状态
---@param redPointState boolean
function UIServantHunJiEquipGridTemplate:SetRedPointState(redPointState)
    redPointState = redPointState == nil and false or redPointState
    if self.mRedPointState ~= redPointState then
        self.mRedPointState = redPointState
        self:GetRedPointGO():SetActive(redPointState)
    end
end
--endregion

--region 事件
---格子点击事件
function UIServantHunJiEquipGridTemplate:OnGridClicked()
    if self.gridState == self.HunjiGridState.Hunji then
        ---魂继格子
        if self.bagItemInfo ~= nil then
            if self.ownerPanel:GetSelectedHunJi() ~= self then
                self.ownerPanel:SetSelectedHunJi(self)
            else
                local isEquiped, seatType, isUsed, equipIndex = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:IsHunJiEquiped(self.bagItemInfo)
                if isEquiped then
                    if isUsed then
                        ---已通灵的魂继装备
                        ---@type ItemInfoData
                        local customData = {}
                        customData.bagItemInfo = self.bagItemInfo
                        customData.showRight = true
                        customData.showAssistPanel = true
                        customData.showBind = true
                        uiStaticParameter.UIItemInfoManager:CreatePanel(customData)
                        return
                    else
                        ---未通灵的魂继装备
                        ---@type ItemInfoData
                        local customData = {}
                        customData.bagItemInfo = self.bagItemInfo
                        customData.showRight = true
                        customData.showAssistPanel = true
                        customData.showBind = true
                        uiStaticParameter.UIItemInfoManager:CreatePanel(customData)
                        return
                    end
                end
            end
        else
            self.ownerPanel:SetSelectedHunJi(nil)
        end
    elseif self.gridState == self.HunjiGridState.Locked then
        ---锁住的格子
        ---@type CSServantSeatData_MainPlayer
        local servantSeatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.mServantSeatType)
        if servantSeatData.ReinLevel < self.mNextServantReinLevel then
            Utility.ShowPopoTips(self.go, "灵兽转生" .. tostring(self.mNextServantReinLevel) .. "级开启", 205, "UIServantPanel")
        elseif servantSeatData.Level < self.mNextServantLevel then
            Utility.ShowPopoTips(self.go, "灵兽" .. tostring(self.mNextServantLevel) .. "级开启", 205, "UIServantPanel")
        end
    elseif self.gridState == self.HunjiGridState.Empty then
        ---空格子
        ---@type CSServantSeatData_MainPlayer
        local servantSeatData = CS.CSScene.MainPlayerInfo.ServantInfoV2.MainPlayerServantData:GetServantSeatData(self.mServantSeatType)
        local isExist, bagItemInfoInBag, hunjiEquipIndex = servantSeatData:IsAnyAvailableHunJiInBagToEquipInServantSeat(true)
        if isExist and bagItemInfoInBag ~= nil and hunjiEquipIndex ~= 0 then
            networkRequest.ReqPutOnTheEquip(hunjiEquipIndex, bagItemInfoInBag.lid)
        end
    end
end
--endregion

--region 格子数据判定

--endregion

return UIServantHunJiEquipGridTemplate