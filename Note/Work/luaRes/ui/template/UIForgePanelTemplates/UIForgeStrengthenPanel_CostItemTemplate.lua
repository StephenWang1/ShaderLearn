---锻造选择模板
---@class UIForgeStrengthenPanel_CostItemTemplate
local UIForgeStrengthenPanel_CostItemTemplate = {}

--region初始化
function UIForgeStrengthenPanel_CostItemTemplate:Init()
    self:InitComponents()
    self.successRate = 0
    self.purity = 0
    self.itemId = 0
    self.icon = 0
    self.itemNum = 0
    self.IsChoose = false
end

function UIForgeStrengthenPanel_CostItemTemplate:InitComponents()
    ---纯度
    self.purity_UILabel = self:Get("purity", "UILabel")
    ---选中
    self.Choose_GameObject = self:Get("choose", "GameObject")
    ---数量
    self.count_UILabel = self:Get("num", "UILabel")
    --self:ChooseItem(false)
end
--endregion

--region刷新
---@param mineInfo StrengthMineInfo 矿信息
---@param itemInfo TABLE.cfg_items 道具信息
function UIForgeStrengthenPanel_CostItemTemplate:RefreshGrid(mineInfo, itemInfo, needChoose)
    self.itemId = mineInfo.itemId
    self.itemNum = mineInfo.playerHas
    self.itemInfo = itemInfo
    self:RefreshItemInfo()
    self:RefreshCostShow()
    self:RefreshShow()
    self.successRate = mineInfo.rate
    self:ChooseItem(needChoose)
end

---刷新Item信息
function UIForgeStrengthenPanel_CostItemTemplate:RefreshItemInfo()
    if self.itemInfo then
        self.icon = self.itemInfo:GetIcon()
        if not CS.StaticUtility.IsNull(self.purity_UILabel) and self.itemInfo:GetUseParam() and self.itemInfo:GetUseParam().list then
            self.purityShow = "纯度" .. self.itemInfo:GetUseParam().list[0]
            self.purity = self.itemInfo:GetUseParam().list[0]
        end
    end
end

---刷新数量显示
function UIForgeStrengthenPanel_CostItemTemplate:RefreshCostShow()
    if CS.StaticUtility.IsNull(self.count_UILabel) == false and self.itemNum then
        self.countShow = self.itemNum .. "个"
    end
end

---设置选中
function UIForgeStrengthenPanel_CostItemTemplate:ChooseItem(isShow)
    self.IsChoose = isShow
    self:RefreshShow()
end

function UIForgeStrengthenPanel_CostItemTemplate:RefreshShow()
    if self.purityShow and self.countShow then
        local color = ternary(self.IsChoose, "[FFFFFF]", "[878787]")
        self.purity_UILabel.text = color .. self.purityShow
        self.count_UILabel.text = color .. self.countShow
    end
end

--endregion

return UIForgeStrengthenPanel_CostItemTemplate