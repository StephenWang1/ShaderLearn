---@class UIRoleBloodSuit_SmeltBodyItemTemplate:UIRoleBloodSuitBodyItemTemplate
local UIRoleBloodSuit_SmeltBodyItemTemplate = {}

setmetatable(UIRoleBloodSuit_SmeltBodyItemTemplate, luaComponentTemplates.UIRoleBloodSuitBodyItemTemplate)

function UIRoleBloodSuit_SmeltBodyItemTemplate:InitComponents()
    self:RunBaseFunction("InitComponents")
    ---@type UnityEngine.GameObject
    self.redPoint = self:Get("RedPoint", "GameObject")
end

---刷新数据
---@param equipIndex number 装备位
---@param isMainPlayer boolean 是否是主角的装备
---@param data LuaEquipDataBloodSuitItem
function UIRoleBloodSuit_SmeltBodyItemTemplate:RefreshUI(equipIndex, isMainPlayer, data, ownerData, career)
    self:RunBaseFunction("RefreshUI", equipIndex, isMainPlayer, data, ownerData, career)
    if self.LuaEquipDataBloodSuitItem ~= nil and self.LuaEquipDataBloodSuitItem.BagItemInfo ~= nil then
        local bagItemInfo = self.LuaEquipDataBloodSuitItem.BagItemInfo
        local canShow = gameMgr:GetPlayerDataMgr():GetMainPlayerBloodSuitSmeltMgr():CanItemSmelt(bagItemInfo)
        self.redPoint:SetActive(canShow)
    else
        self.redPoint:SetActive(false)
    end
end

---刷新选中框显示
function UIRoleBloodSuit_SmeltBodyItemTemplate:RefreshChooseItem()
end

---刷新添加按鈕顯示
---@param type LuaEquipBloodSuitType
function UIRoleBloodSuit_SmeltBodyItemTemplate:RefreshAddActive()
    self:RunBaseFunction("RefreshAddActive")
    self.add.gameObject:SetActive(false)
end

---点击操作
function UIRoleBloodSuit_SmeltBodyItemTemplate:OnClickAdd()
    if self.superiorPanel == nil then
        return
    end
    if self:RespondLockClick() then
        return
    end
    self.superiorPanel:RefreshSelectIndex(self.pos)
    if self.LuaEquipDataBloodSuitItem ~= nil and self.LuaEquipDataBloodSuitItem.BagItemInfo ~= nil then
        luaEventManager.DoCallback(LuaCEvent.BloodSuitPanelItemClicked, self.LuaEquipDataBloodSuitItem.BagItemInfo)
    end
end

---响应锁住点击事件
---@return boolean 是否阻塞后续点击事件
function UIRoleBloodSuit_SmeltBodyItemTemplate:RespondLockClick()
    ---血炼界面的锁住的格子不处理
    return false
end

return UIRoleBloodSuit_SmeltBodyItemTemplate