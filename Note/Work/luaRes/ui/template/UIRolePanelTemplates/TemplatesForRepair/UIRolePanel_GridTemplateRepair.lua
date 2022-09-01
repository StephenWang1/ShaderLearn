---@class UIRolePanel_GridTemplateRepair:UIRolePanel_GridTemplateBase
local UIRolePanel_GridTemplateRepair = {}
setmetatable(UIRolePanel_GridTemplateRepair, luaComponentTemplates.UIRolePanel_GridTemplateBase)

function UIRolePanel_GridTemplateRepair:OverrideRefreshGrid()
    self.Choose = false
    self.maxLasting = -1
    if self.itemInfo then
        self.maxLasting = self.itemInfo.maxLasting
    end
end

---刷新加号状态
---@param state XLua.Cast.Int32 状态 0 显示道具 1 不显示道具
function UIRolePanel_GridTemplateRepair:RefreshAddIcon()
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

---设置item选中
function UIRolePanel_GridTemplateRepair:SetChoose(lasting)
    if lasting ~= nil then
        self.lasting = lasting
    end
    if self.lasting == nil then
        return
    end
    local isChoose = self.bagItemInfo and self.maxLasting and self.bagItemInfo.currentLasting / self.maxLasting <= self.lasting / 100
    self.Choose = isChoose
    self:ChooseItem(self.Choose)
end

---重置格子状态
function UIRolePanel_GridTemplateRepair:ResetGrid()
    self.Choose = false
    if self:GetIcon_UISprite() then
        self:GetIcon_UISprite().spriteName = ""
    end
    if self:GetStrength_UILabel() then
        self:GetStrength_UILabel().text = ""
    end
    if self:GetBackGroundEquipIcon_GameObject() and CS.StaticUtility.IsNull(self:GetBackGroundEquipIcon_GameObject()) == false then
        self:GetBackGroundEquipIcon_GameObject():SetActive(true)
    end
    self:RefreshLastingFrame(1)
    self:SetOtherIcon()
    self:HidAddIcon()
end

---设置选中物品
function UIRolePanel_GridTemplateRepair:ChooseItem(isChoose)
    self.Choose = isChoose
    if self:GetCheck_GameObject() and CS.StaticUtility.IsNull(self:GetCheck_GameObject()) == false then
        self:GetCheck_GameObject():SetActive(self.Choose)
    end
end

return UIRolePanel_GridTemplateRepair