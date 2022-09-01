---血继肉身装备格子面板
---@class UIRoleBloodSuitItemBase:TemplateBase
local UIRoleBloodSuitItemBase = {}

UIRoleBloodSuitItemBase.OnClickItemOpenRight = nil
---装备位
UIRoleBloodSuitItemBase.equipIndex = 0
---是否是主角装备
UIRoleBloodSuitItemBase.isMainPlayer = true
---是否被锁住了
UIRoleBloodSuitItemBase.isLocked = false

---初始化数据
function UIRoleBloodSuitItemBase:Init(superiorPanel, subTab)
    ---@type UIRoleBloodSuitPanel
    self.superiorPanel = superiorPanel
    ---@type LuaEquipBloodSuitItemType
    self.pos = subTab
    self.OnClickItemOpenRight = true
    self:InitComponents()
    self:InitOther()
end

function UIRoleBloodSuitItemBase:InitComponents()
    ---todo by subclass
end

function UIRoleBloodSuitItemBase:InitOther()
    CS.UIEventListener.Get(self.go.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.go.gameObject).OnClickLuaDelegate = self.OnClickAdd
end

---@return UISprite
function UIRoleBloodSuitItemBase:GetChooseSprite()
    if self.mChooseSp == nil and CS.StaticUtility.IsNull(self.Choose) == false then
        self.mChooseSp = CS.Utility_Lua.GetComponent(self.Choose.transform, "UISprite")
    end
    return self.mChooseSp
end

---@param equipIndex number 装备位
---@param isMainPlayer boolean 是否是主角的装备
---@param itemData LuaEquipDataBloodSuitItem
---@param ownerData LuaPlayerBloodSuitEquipMgr
---@param career number
function UIRoleBloodSuitItemBase:RefreshUI(equipIndex, isMainPlayer, itemData, ownerData, career)
    self.equipIndex = equipIndex
    self.isMainPlayer = isMainPlayer
    self.LuaEquipDataBloodSuitItem = itemData
    self.OwnerLuaPlayerBloodSuitEquipMgr = ownerData
    self.career = career
    self.itemTbl = nil
    self.BagItemInfo = nil
    self.huanShouTbl = nil
    self.monstersTbl = nil
    self.BloodLv = 0
    if itemData ~= nil then
        self.itemTbl = itemData:GetItemTbl()
        self.BagItemInfo = itemData.BagItemInfo
        self.huanShouTbl = itemData:GetHuanShouTbl()
        self.monstersTbl = itemData:GetMonstersTbl()
    end
    if self.BagItemInfo ~= nil then
        self.BloodLv = self.BagItemInfo.bloodLevel
    end
    self.BloodLvRoot.gameObject:SetActive(self.BloodLv >= 1)
    self.iconHead.gameObject:SetActive(self.itemTbl ~= nil)
    self.BloodLv_UILabel.text = self.BloodLv
    self:RefreShChoose()
    self:RefreshAddActive()
    self:RefreshLockState()
    self:RefreshChooseItem()
end

---刷新选中框显示
function UIRoleBloodSuitItemBase:RefreshChooseItem()
    if self.superiorPanel and CS.StaticUtility.IsNull(self:GetChooseSprite()) == false then
        local hasBagPanel = self.superiorPanel:GetBagPanelExistState()
        self:GetChooseSprite().color = hasBagPanel and LuaEnumUnityColorType.Normal or LuaEnumUnityColorType.Transparent
    end
end

---@protected
function UIRoleBloodSuitItemBase:RefreshLockState()
    if self.isMainPlayer then
        self.isLocked = gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsEquipGridUnlocked(self.equipIndex) ~= true
        --print("self.isLocked", gameMgr:GetPlayerDataMgr():GetMainPlayerEquipMgr():IsEquipGridUnlocked(self.equipIndex), self.isLocked)
    else
        self.isLocked = false
    end
end

---刷新选中
function UIRoleBloodSuitItemBase:RefreShChoose()
    local isChoose = self.superiorPanel.MainData.NowSelectEquipItemType == self.pos
    self.Choose.gameObject:SetActive(isChoose)
end

---刷新添加按鈕顯示
---@param type LuaEquipBloodSuitType
function UIRoleBloodSuitItemBase:RefreshAddActive()

end

function UIRoleBloodSuitItemBase:IsOpenAddActiveInfo(BloodSuitType)
    if self.BagItemInfo ~= nil then
        return false
    end
    if self.isLocked then
        return false
    end
    if self.superiorPanel ~= nil and self.superiorPanel.MainData ~= nil and self.superiorPanel.MainData.SuitTypeCanUseDic ~= nil then
        local SuitTypeCanUse = self.superiorPanel.MainData.SuitTypeCanUseDic[self.superiorPanel.MainData.NowSelectSuit]
        --   print("----0",SuitTypeCanUse,type)
        if SuitTypeCanUse == nil then
            return false
        end
        if BloodSuitType == 1 then
            return SuitTypeCanUse.iscanUseEgg
        elseif BloodSuitType == 2 then
            return SuitTypeCanUse.iscanUseBody
        end
    end
end

---点击操作
function UIRoleBloodSuitItemBase:OnClickAdd()
    if self.superiorPanel == nil then
        return
    end
    if self:RespondLockClick() then
        return
    end
    self.superiorPanel:RefreshSelectIndex(self.pos)
   -- self.superiorPanel:OnOpenBag()
    if self.LuaEquipDataBloodSuitItem ~= nil and self.LuaEquipDataBloodSuitItem.BagItemInfo ~= nil then
        uiStaticParameter.UIItemInfoManager:CreatePanel({
            bagItemInfo = self.LuaEquipDataBloodSuitItem.BagItemInfo,
            rightUpButtonsModule = luaComponentTemplates.UIRoleBloodSuit_PanelRightUpOperate,
            itemType = LuaEnumItemInfoPanelItemType.BloodSuit,
            showRight = self.OnClickItemOpenRight,
            ownerBloodSuitEquipMgr = self.OwnerLuaPlayerBloodSuitEquipMgr,
            career = self.career
        }
        )
    else
        if self.superiorPanel.MainData == nil then
            return
        end
        local BagItemInfo = self.superiorPanel.MainData:GetSpecifyTypeBagItemInfo()
        if BagItemInfo ~= nil then
            local IsWearSameBloodsuit = self.superiorPanel.MainData:IsWearSameBloodsuit(BagItemInfo.itemId, self.superiorPanel.MainData.NowSelectSuit)
            if IsWearSameBloodsuit == false then
                networkRequest.ReqPutOnTheEquip(gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitEquipMgr():GetNowSelectEquipIndex(), BagItemInfo.lid)
            end
        end
    end
end

---响应锁住点击事件
---@return boolean 是否阻塞后续点击事件
function UIRoleBloodSuitItemBase:RespondLockClick()
    if self.isLocked then
        local bloodSuitLattice = clientTableManager.cfg_bloodsuit_latticeManager:TryGetValue(self.equipIndex)
        uimanager:CreatePanel("UIPromptBloodSuitPanel", nil, self.equipIndex, bloodSuitLattice)
        return true
    else
        return false
    end
end

return UIRoleBloodSuitItemBase