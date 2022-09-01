---血继肉身装备格子面板
---@class UIRoleBloodSuitBodyItemTemplate:UIRoleBloodSuitItemBase
local UIRoleBloodSuitBodyItemTemplate = {}

setmetatable(UIRoleBloodSuitBodyItemTemplate, luaComponentTemplates.UIRoleBloodSuitItemBase)

function UIRoleBloodSuitBodyItemTemplate:InitComponents()
    ---选择框
    self.Choose = self:Get("Choose", "GameObject")
    ---icon
    self.iconHead = self:Get("iconHead", "Top_UISprite")
    ---quality
    self.iconHeadQuality = self:Get("iconHead/quality", "GameObject")
    ---quality
    self.iconHeadframe = self:Get("iconHead/frame", "GameObject")
    ---血继等级
    self.BloodLv_UILabel = self:Get("BloodLv/Label", "Top_UILabel")
    ---血继等级跟节点
    self.BloodLvRoot = self:Get("BloodLv", "GameObject")
    ---添加灵兽
    self.add = self:Get("add", "GameObject")
    ---等级框
    self.frame = self:Get("frame", "Top_UISprite")
    ---锁标识
    self.lockGO = self:Get("lock", "GameObject")
end

---刷新数据
---@param equipIndex number 装备位
---@param isMainPlayer boolean 是否是主角的装备
---@param data LuaEquipDataBloodSuitItem
function UIRoleBloodSuitBodyItemTemplate:RefreshUI(equipIndex, isMainPlayer, data, ownerData, career)
    self:RunBaseFunction("RefreshUI", equipIndex, isMainPlayer, data, ownerData, career)
    if self.itemTbl ~= nil then
        self.iconHead.spriteName = self.itemTbl:GetIcon()
    end
    if self.iconHeadQuality ~= nil then
        self.iconHeadQuality.gameObject:SetActive(false)
    end
    if self.iconHeadframe ~= nil then
        self.iconHeadframe.gameObject:SetActive(false)
    end
    if self.frame ~= nil then
        self.frame.gameObject:SetActive(self.BloodLv >= 1)
        self.frame.spriteName = "BloodSuit_item_" .. tostring(self.BloodLv)
    end
end

---刷新添加按鈕顯示
---@param type LuaEquipBloodSuitType
function UIRoleBloodSuitBodyItemTemplate:RefreshAddActive()
    self:RunBaseFunction("RefreshAddActive")
    self.add.gameObject:SetActive(self:IsOpenAddActiveInfo(2))
end

---@protected
function UIRoleBloodSuitBodyItemTemplate:RefreshLockState()
    self:RunBaseFunction("RefreshLockState")
    if self.isLocked then
        self.lockGO:SetActive(true)
    else
        self.lockGO:SetActive(false)
    end
end

return UIRoleBloodSuitBodyItemTemplate