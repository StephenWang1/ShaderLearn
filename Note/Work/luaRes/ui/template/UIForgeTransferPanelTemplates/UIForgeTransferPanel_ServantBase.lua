---转移重写灵兽面板
---@class UIForgeTransferPanel_ServantBase:UIServantPanel_Base
local UIForgeTransferPanel_ServantBase = {}

setmetatable(UIForgeTransferPanel_ServantBase, luaComponentTemplates.UIServantPanel_Base)

---设置格子选中
function UIForgeTransferPanel_ServantBase:SetItemChoose(lid, isChoose)
    local grid = self.mLidToGrid[lid]
    if grid then
        self:ShowChooseEffect(grid, isChoose)
    end
    self.mLidToChoose[lid] = isChoose
end

---重写以隐藏按钮
function UIForgeTransferPanel_ServantBase:InitInfo()
    self:GetAllBtn_GameObject():SetActive(false)
    self:GetEquipHelp_GameObject():SetActive(false)
end

---初始化隐藏此按钮，重写置空此方法
function UIForgeTransferPanel_ServantBase:SetAllButtonShow(isShow)
end

---重写隐藏肉身
function UIForgeTransferPanel_ServantBase:IsShowBodyEquip()
    return false
end

---重写隐藏法宝
function UIForgeTransferPanel_ServantBase:IsShowServantMagicWeapon()
    return false
end

---重写是否显示箭头
---@return boolean
function UIForgeTransferPanel_ServantBase:IsShowArrow()
    return false
end
return UIForgeTransferPanel_ServantBase