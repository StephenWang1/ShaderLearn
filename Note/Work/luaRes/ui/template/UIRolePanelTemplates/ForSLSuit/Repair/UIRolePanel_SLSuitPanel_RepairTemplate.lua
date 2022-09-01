---@class UIRolePanel_SLSuitPanel_RepairTemplate:UIRolePanel_SLSuitPanelTemplate
local UIRolePanel_SLSuitPanel_RepairTemplate = {}

setmetatable(UIRolePanel_SLSuitPanel_RepairTemplate, luaComponentTemplates.UIRolePanel_SLSuitPanelTemplate)

---@return UIRolePanel_SLEquipGrid_RepairTemplate
function UIRolePanel_SLSuitPanel_RepairTemplate:GetGridTemp()
    return luaComponentTemplates.UIRolePanel_SLEquipGrid_RepairTemplate
end

---刷新所有装备选中状态
---@param mBasicIndexToChooseState table<LuaEquipmentItemType,boolean> 装备位对应选中状态
function UIRolePanel_SLSuitPanel_RepairTemplate:UpdateAllEquipChooseState(mBasicIndexToChooseState)
    for i = 1, #uiStaticParameter.mDivineSuitType do
        local basicIndex = uiStaticParameter.mDivineSuitType[i]
        local state = mBasicIndexToChooseState[basicIndex]
        self:UpdateSingleEquipChooseStateByBasicIndex(basicIndex, state)
    end
end

---刷新单个装备选中状态（根据装备位）
function UIRolePanel_SLSuitPanel_RepairTemplate:UpdateSingleEquipChooseStateByEquipIndex(equipIndex, needChoose)
    local basicIndex = self:GetBasicIndexByEquipIndex(equipIndex)
    if basicIndex then
        self:UpdateSingleEquipChooseStateByBasicIndex(basicIndex, needChoose)
    end
end

---刷新单个装备选中状态（根据subtype）
---@param equipBasicIndex LuaEquipmentItemType
function UIRolePanel_SLSuitPanel_RepairTemplate:UpdateSingleEquipChooseStateByBasicIndex(equipBasicIndex, needChoose)
    ---@type UIRolePanel_SLEquipGrid_RepairTemplate
    local temp = self.EquipGridDic[equipBasicIndex]
    if (temp == nil) then
        return
    end
    temp:SetItemChoose(needChoose)
end

---根据装备位获取对应的枚举
---@return LuaEquipmentItemType subtype
---@param  equipIndex number 装备位
function UIRolePanel_SLSuitPanel_RepairTemplate:GetBasicIndexByEquipIndex(equipIndex)
    return Utility.GetSLEquipBasicIndex(equipIndex)
end

---根据枚举获取对应的装备位
---@return number 装备位
---@param equipBasicIndex LuaEquipmentItemType subtype
function UIRolePanel_SLSuitPanel_RepairTemplate:GetEquipIndexByBasicIndex(equipBasicIndex)
    return Utility.GetItemSubTypeByEquipIndex(equipBasicIndex)
end

return UIRolePanel_SLSuitPanel_RepairTemplate