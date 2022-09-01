---血继装备格子面板
---@class UIRoleBloodSuitItemTemplate:UIRoleBloodSuitItemBase
local UIRoleBloodSuitItemTemplate = {}

setmetatable(UIRoleBloodSuitItemTemplate, luaComponentTemplates.UIRoleBloodSuitItemBase)

function UIRoleBloodSuitItemTemplate:InitComponents()
    ---选择框
    self.Choose = self:Get("Choose", "GameObject")
    ---等级
    self.rolelevel = self:Get("rolelevel", "GameObject")
    ---icon
    self.iconHead = self:Get("iconHead", "Top_UISprite")
    ---血继等级
    self.BloodLv_UILabel = self:Get("BloodLv/Label", "Top_UILabel")
    ---血继等级跟节点
    self.BloodLvRoot = self:Get("BloodLv", "GameObject")
    ---添加灵兽
    self.add = self:Get("add", "GameObject")
    ---等级框
    self.frame = self:Get("frame", "Top_UISprite")
    ---锁标识
    ---@type UnityEngine.GameObject
    self.lockGO = self:Get("lock", "GameObject")
end

---刷新数据
---@param equipIndex number 装备位
---@param isMainPlayer boolean 是否是主角的装备
---@param data LuaEquipDataBloodSuitItem
function UIRoleBloodSuitItemTemplate:RefreshUI(equipIndex, isMainPlayer, data, ownerData, career)
    self:RunBaseFunction("RefreshUI", equipIndex, isMainPlayer, data, ownerData, career)
    if self.rolelevel ~= nil then
        self.rolelevel.gameObject:SetActive(false)
    end
    if self.huanShouTbl ~= nil then
        --print( self.huanShouTbl:GetName(),self.huanShouTbl:GetId())
        if self.monstersTbl then
            self.iconHead.spriteName = self.monstersTbl:GetHead()
        end
    end
    if self.frame ~= nil then
        self.frame.gameObject:SetActive(self.BloodLv >= 1)
        self.frame.spriteName = "BloodSuit_servant_" .. tostring(self.BloodLv)
    end
end

---刷新添加按鈕顯示
---@param type LuaEquipBloodSuitType
function UIRoleBloodSuitItemTemplate:RefreshAddActive()
    self:RunBaseFunction("RefreshAddActive")
    self.add.gameObject:SetActive(self:IsOpenAddActiveInfo(1))
end

---@protected
function UIRoleBloodSuitItemTemplate:RefreshLockState()
    self:RunBaseFunction("RefreshLockState")
    if self.isLocked then
        self.lockGO:SetActive(true)
    else
        self.lockGO:SetActive(false)
    end
end

return UIRoleBloodSuitItemTemplate