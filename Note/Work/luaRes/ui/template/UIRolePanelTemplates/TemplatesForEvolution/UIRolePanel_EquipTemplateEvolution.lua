---@class UIRolePanel_EquipTemplateEvolution
local UIRolePanel_EquipTemplateEvolution = {};

setmetatable(UIRolePanel_EquipTemplateEvolution, luaComponentTemplates.UIRolePanel_EquipTemplate);

--region Method

--region Public
---重写选中角色格子事件
function UIRolePanel_EquipTemplateEvolution:SetItemChoose(equipIndex)
    if self.mEquipIndexToTemplate and equipIndex and self.mEquipIndexToTemplate[equipIndex] then
        local go = self.mEquipIndexToGrid[equipIndex]
        self:HideCurrentChooseItem()
        self:SetItemShowChoose(true, go)
        self.mCurrentChooseItem = go
    end
end

function UIRolePanel_EquipTemplateEvolution:HideCurrentChooseItem()
    if self.mCurrentChooseItem ~= nil then
        self:SetItemShowChoose(false, self.mCurrentChooseItem)
        self.mCurrentChooseItem = nil
    end
end
--endregion

--region Private

function UIRolePanel_EquipTemplateEvolution:SetItemShowChoose(isShow, go)
    local template = self.mGridToTemplate[go]
    if template then
        template:ChooseItem(isShow)
    end
end

--endregion

--endregion

return UIRolePanel_EquipTemplateEvolution;