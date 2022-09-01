---@class UIRolePanel_GridTemplateEvolution:UIRolePanel_GridTemplateBase
local UIRolePanel_GridTemplateEvolution = {};

setmetatable(UIRolePanel_GridTemplateEvolution, luaComponentTemplates.UIRolePanel_GridTemplateBase);

--region Method

function UIRolePanel_GridTemplateEvolution:OverrideRefreshGrid()
    self:ShowEvolution()
end

---显示可进化标记
function UIRolePanel_GridTemplateEvolution:ShowEvolution()
    if CS.StaticUtility.IsNull(self:GetEvolotion_GameObject()) == false then
        local canEvolution = false
        if self.bagItemInfo then
            canEvolution = CS.Cfg_EvolutionTableManager.Instance:CanEvolution(self.bagItemInfo.itemId)
        end
        self:GetEvolotion_GameObject():SetActive(canEvolution)
    end
end

--region Public
---选中特效
function UIRolePanel_GridTemplateEvolution:ChooseItem(isShow)
    if self:GetChoose_GameObject() and CS.StaticUtility.IsNull(self:GetChoose_GameObject()) == false then
        self:GetChoose_GameObject():SetActive(isShow)
    end
end
--endregion

---重写加号显示
function UIRolePanel_GridTemplateEvolution:RefreshAddIcon(state)
    if self:GetAdd_GameObject() and CS.StaticUtility.IsNull(self:GetAdd_GameObject()) == false then
        self:GetAdd_GameObject():SetActive(false)
    end
end

--endregion


return UIRolePanel_GridTemplateEvolution;