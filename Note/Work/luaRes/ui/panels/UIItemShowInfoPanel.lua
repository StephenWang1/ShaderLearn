---物品展示信息界面
---@class 物品展示信息界面:物品信息界面
local UIItemShowInfoPanel = {}

setmetatable(UIItemShowInfoPanel, luaPanelModules.UIItemInfoPanel)

function UIItemShowInfoPanel:GetPanel_Link()
    if CS.StaticUtility.IsNull(self.Panel_Link) then
        self.Panel_Link = self:GetCurComp("","UILinkerCollector")
    end
    return self.Panel_Link
end

function UIItemShowInfoPanel:RefreshOther()
    if self.ExhibitionPanelNeedLink == false and CS.StaticUtility.IsNull(self:GetPanel_Link()) == false then
        self:GetPanel_Link().enabled = false
        self.go.transform.localPosition = CS.UnityEngine.Vector3.zero
    end
end

function ondestroy()
    UIItemShowInfoPanel:OnDestroy()
end

return UIItemShowInfoPanel