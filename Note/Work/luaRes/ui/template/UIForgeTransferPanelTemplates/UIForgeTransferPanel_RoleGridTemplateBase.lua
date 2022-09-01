---@class UIForgeTransferPanel_RoleGridTemplateBase:UIRolePanel_GridTemplateBase
local UIForgeTransferPanel_RoleGridTemplateBase = {}

setmetatable(UIForgeTransferPanel_RoleGridTemplateBase, luaComponentTemplates.UIRolePanel_GridTemplateBase)

---刷新加号状态
---@param state XLua.Cast.Int32 状态 0 显示道具 1 不显示道具
function UIForgeTransferPanel_RoleGridTemplateBase:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

return UIForgeTransferPanel_RoleGridTemplateBase