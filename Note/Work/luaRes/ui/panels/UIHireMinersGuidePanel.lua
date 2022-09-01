local UIHireMinersGuidePanel = {}

function UIHireMinersGuidePanel:InitComponents()
    self.btn_close = self:GetCurComp('WidgetRoot/event/btn_close', 'GameObject')
    self.findPath = self:GetCurComp('WidgetRoot/view/btn', 'GameObject')
end
function UIHireMinersGuidePanel:InitOther()
    CS.UIEventListener.Get(self.btn_close.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.btn_close.gameObject).OnClickLuaDelegate = self.OnClickClose

    CS.UIEventListener.Get(self.findPath.gameObject).LuaEventTable = self
    CS.UIEventListener.Get(self.findPath.gameObject).OnClickLuaDelegate = self.OnClickfindPath
end

function UIHireMinersGuidePanel:Init()
    self:InitComponents()
    self:InitOther()
end

function UIHireMinersGuidePanel:RefreshUI()

end

function UIHireMinersGuidePanel:OnClickClose()
    uimanager:ClosePanel('UIHireMinersGuidePanel')
end

function UIHireMinersGuidePanel:OnClickfindPath()
    uimanager:ClosePanel('UIHireMinersGuidePanel')
    CS.CSScene.MainPlayerInfo.AsyncOperationController.GeneralFindPathAndOpenPanelByDeliverIDOperation:DoOperation(120013)
end

return UIHireMinersGuidePanel