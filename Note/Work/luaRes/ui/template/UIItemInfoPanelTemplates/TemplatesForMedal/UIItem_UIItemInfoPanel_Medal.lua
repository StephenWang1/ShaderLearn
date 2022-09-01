---勋章信息界面的UIItem
---@class 勋章信息界面UIItem:UI物品
local UIItem_UIItemInfoPanel_Medal = {}

setmetatable(UIItem_UIItemInfoPanel_Medal, luaComponentTemplates.UIItem)

--region 信息显示组件

---使用背包物品信息刷新UI
---@param bagItemInfo bagV2.BagItemInfo
function UIItem_UIItemInfoPanel_Medal:RefreshUIWithBagItemInfo(bagItemInfo)
    local isFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
    if isFind then
        --缓存物品信息
        self.ItemInfo = itemInfo
        self:RefreshUI(bagItemInfo)
        self:RefreshGemIcon(bagItemInfo)
        self:RefreshItemIcon(bagItemInfo)
        --if CS.CSScene.MainPlayerInfo.EquipInfo:IsEquip(bagItemInfo.lid) then
        --
        --end
    end
end

function UIItem_UIItemInfoPanel_Medal:RefreshUI(bagItemInfo)
    if bagItemInfo ~= nil then
        --显示物品图标
        if self:GetItemIcon_UISprite() ~= nil and self.ItemInfo ~= nil then
            self:GetItemIcon_UISprite().gameObject:SetActive(true)
            self:GetItemIcon_UISprite().spriteName = tostring(self.ItemInfo.icon)
            self:GetItemIcon_UISprite():MakePixelPerfect()
        end
        --显示物品名称
        if self:GetItemName_UILabel() ~= nil then
            self:GetItemName_UILabel().gameObject:SetActive(true)
            self:GetItemName_UILabel().text =bagItemInfo.ItemFullName
        end
        --耐久值
        --if self:GetItemFrame_UISprite() ~= nil then
        --self:GetItemFrame_UISprite().gameObject:SetActive(false)--暂时全隐藏
        --if itemInfo.type ~= luaEnumItemType.Equip then
        --    if itemInfo.quality == 0 then
        --        --0:白
        --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
        --        self:GetItemFrame_UISprite().spriteName = "quality_white"
        --    elseif itemInfo.quality == 1 then
        --        --1:绿
        --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
        --        self:GetItemFrame_UISprite().spriteName = "quality_green"
        --    elseif itemInfo.quality == 2 then
        --        --2:紫
        --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
        --        self:GetItemFrame_UISprite().spriteName = "quality_purple"
        --    elseif itemInfo.quality == 3 then
        --        --3:橙
        --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
        --        self:GetItemFrame_UISprite().spriteName = "quality_yellow"
        --    elseif itemInfo.quality == 4 then
        --        --4:红
        --        self:GetItemFrame_UISprite().gameObject:SetActive(true)
        --        self:GetItemFrame_UISprite().spriteName = "quality_red"
        --    else
        --        --超出定义,隐藏
        --        self:GetItemFrame_UISprite().gameObject:SetActive(false)
        --    end
        --end
        --end
        ---显示物品强化
        --if self:GetItemStrength_UILabel() ~= nil then
        --    self:GetItemStrength_UILabel().gameObject:SetActive(true)
        --end
    end

end

return UIItem_UIItemInfoPanel_Medal