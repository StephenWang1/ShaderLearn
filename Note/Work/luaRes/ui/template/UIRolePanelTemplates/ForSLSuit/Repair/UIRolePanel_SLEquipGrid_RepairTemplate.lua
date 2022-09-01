---@class UIRolePanel_SLEquipGrid_RepairTemplate:UIRolePanel_SLEquipGridTemp
local UIRolePanel_SLEquipGrid_RepairTemplate = {}

setmetatable(UIRolePanel_SLEquipGrid_RepairTemplate, luaComponentTemplates.UIRolePanel_SLEquipGridTemp)

function UIRolePanel_SLEquipGrid_RepairTemplate:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        if self.bagItemInfo then
            local popID = Utility:GetItemRepairReason(self.bagItemInfo)
            if popID == 0 then
                luaEventManager.DoCallback(LuaCEvent.RepairSLEquipGridClicked, self.bagItemInfo)
            else
                Utility.ShowPopoTips(self.go, nil, popID)
            end
        end
    end
end

---设置选中物品
function UIRolePanel_SLEquipGrid_RepairTemplate:SetItemChoose(isChoose)
    self.Choose = isChoose
    if self:GetCheck_GameObject() and CS.StaticUtility.IsNull(self:GetCheck_GameObject()) == false then
        self:GetCheck_GameObject():SetActive(self.Choose)
    end
end

return UIRolePanel_SLEquipGrid_RepairTemplate