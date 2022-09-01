---灵兽肉身装备顶部显示（与装备相比去掉耐久）
---@class UIItemInfoPanel_ServantBody_UIItem:UIItemInfoPanel_ServantEquip_UIItem
local UIItemInfoPanel_ServantBody_UIItem = {}

setmetatable(UIItemInfoPanel_ServantBody_UIItem, luaComponentTemplates.UIItemInfoPanel_ServantEquip_UIItem)

---使用信息刷新
---@param commonData UIItemTipInfoCommonData
function UIItemInfoPanel_ServantBody_UIItem:RefreshWithInfo(commonData)
    ---@type bagV2.BagItemInfo 背包信息
    self.BagItemInfo = commonData.bagItemInfo
    ---@type TABLE.CFG_ITEMS 物品信息
    self.ItemInfo = commonData.itemInfo
    self.showBind = commonData.showBind
    self.IsNeedShowBind = false
    if self.BagItemInfo ~= nil then
        self.IsNeedShowBind = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.BagItemInfo)
    elseif self.ItemInfo ~= nil then
        self.IsNeedShowBind = CS.CSScene.MainPlayerInfo.ServerItemInfo:IsBindItem(self.ItemInfo)
    end
    self:RefreshWearState()
    self:RefreshUIItem()
    self:RefreshWeight()
    self:RefreshStrengthenInfo()
    self:RefreshFrame()
    self:GetNaijiu_UILabel().gameObject:SetActive(false)
    self:RefreshBind()
end

return UIItemInfoPanel_ServantBody_UIItem