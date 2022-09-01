---@class  UIRepairGridItem 维修格子物品模板
local UIRepairGridItem = {}

---@param RepairPanel UIRepairPanel
function UIRepairGridItem:Init(RepairPanel)
    self.RepairPanel = RepairPanel
    self:InitComponents()
    self:InitParameters()
    self:BindEvents()
end

function UIRepairGridItem:InitComponents()
    self.ItemIcon_UISprite = self:Get("icon", "UISprite")
    self.Strengthen_UILabel = self:Get("strengthen", "UILabel")
    self.Star_Sp = self:Get("star", "UISprite")
    self.Lasting_UILabel = self:Get("lasting", "UILabel")
    self.Frame_UISprite = self:Get("frame", "UISprite")
end

function UIRepairGridItem:InitParameters()
    ---背包物品信息,bagV2.BagItemInfo类型
    ---@type bagV2.BagItemInfo
    self.BagItemInfo = nil
    ---物品信息,TABLE.CFG_ITEMS类型
    ---@type TABLE.CFG_ITEMS
    self.ItemInfo = nil
end

function UIRepairGridItem:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnBagItemClicked()
    end
end

---刷新UI
---@param info bagV2.BagItemInfo 背包物品信息
---@param lasting number 玩家设置耐久
function UIRepairGridItem:RefreshUI(info, lasting)
    self.BagItemInfo = nil
    self.ItemInfo = nil
    self.BagItemInfo = info
    self.playerLasting = lasting
    if info then
        ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(info.itemId)
    end
    self:RefreshIcon()
    self:RefreshStrengthenInfo()
    self:RefreshLastingInfo()
    self:RefreshFrame()
end

---刷新Icon
function UIRepairGridItem:RefreshIcon()
    if CS.StaticUtility.IsNull(self.ItemIcon_UISprite) == false then
        local showInfo = ""
        if self.ItemInfo then
            showInfo = self.ItemInfo.icon
        end
        self.ItemIcon_UISprite.spriteName = showInfo
    end
end

---刷新耐久度
function UIRepairGridItem:RefreshLastingInfo()
    local lasting = ""
    if self.playerLasting and self.BagItemInfo and self.ItemInfo then
        local mLastingInfo = self.BagItemInfo.currentLasting
        local maxLasting = self.ItemInfo.maxLasting
        local color = ternary(mLastingInfo / maxLasting <= self.playerLasting / 100, "[ff0000]", "")
        lasting = color .. mLastingInfo .. "/" .. maxLasting
    end
    self.Lasting_UILabel.text = lasting
end

---刷新强化信息
function UIRepairGridItem:RefreshStrengthenInfo()
    if CS.StaticUtility.IsNull(self.Strengthen_UILabel) == false then
        local isShow = self.BagItemInfo and self.BagItemInfo.intensify and self.BagItemInfo.intensify > 0
        if isShow then
            local showInfo, icon = Utility.GetIntensifyShow(self.BagItemInfo.intensify)
            self.Strengthen_UILabel.text = showInfo
            self.Star_Sp.spriteName = icon
        end
        self.Strengthen_UILabel.gameObject:SetActive(isShow)
        self.Star_Sp.gameObject:SetActive(isShow)
    end
end

---刷新品质
function UIRepairGridItem:RefreshFrame()
    self.Frame_UISprite.gameObject:SetActive(self.ItemInfo ~= nil)
    if CS.StaticUtility.IsNull(self.Frame_UISprite) == false then
        self.Frame_UISprite.spriteName = CS.CSScene.MainPlayerInfo.ServantInfoV2:GetEquipFrameIcon(self.ItemInfo)
    end
end

---点击维修装备格子
function UIRepairGridItem:OnBagItemClicked(go)
    if self.BagItemInfo and self.RepairPanel then
        if self.RepairPanel.mCurrentPanel == luaEnumRepairType.Role then
            luaEventManager.DoCallback(LuaCEvent.RepairChooseRoleGridChange, self.BagItemInfo.lid)
        elseif self.RepairPanel.mCurrentPanel == luaEnumRepairType.Bag then
            luaEventManager.DoCallback(LuaCEvent.RepairChooseBagGridChange, self.BagItemInfo.lid)
        elseif self.RepairPanel.mCurrentPanel == luaEnumRepairType.Servant then
            luaEventManager.DoCallback(LuaCEvent.RepairChooseServantGridChange, self.BagItemInfo.lid)
        else
            luaEventManager.DoCallback(LuaCEvent.RepairChooseItemChange, self.BagItemInfo)
        end
    end
end

return UIRepairGridItem