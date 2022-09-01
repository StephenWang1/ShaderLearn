---@class UIArbitratorPanel:UIBase 仲裁官
local UIArbitratorPanel = {}
--region 数据
---当前打开的面板模板
UIArbitratorPanel.CurPanelTemplate = nil
--endregion

--region 初始化
function UIArbitratorPanel:Init()
    self:InitConpoment()
    self:BindEvent()
    self:BindClientEvent()
    self:ReqPanelParams()
    self:DefaultRefreshPanel()
    self:AddCollider()
end

function UIArbitratorPanel:InitConpoment()
    self.closeBtn = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    self.dropBtn = self:GetCurComp("WidgetRoot/events/btn_drop", "GameObject")
    self.pickBtn = self:GetCurComp("WidgetRoot/events/btn_pick", "GameObject")
    self.helpBtn = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    self.dropPanel = self:GetCurComp("WidgetRoot/panel/drop", "GameObject")
    self.pickPanel = self:GetCurComp("WidgetRoot/panel/pick", "GameObject")
    self.dropBtnRedPoint = self:GetCurComp("WidgetRoot/events/btn_drop/Redpoint", "GameObject")
    self.pickBtnRedPoint = self:GetCurComp("WidgetRoot/events/btn_pick/Redpoint", "GameObject")
end

function UIArbitratorPanel:BindEvent()
    CS.UIEventListener.Get(self.closeBtn).onClick = function()
        self:CloseBtnOnClick()
    end
    CS.UIEventListener.Get(self.dropBtn).onClick = function()
        self:DropBtnOnClick()
    end
    CS.UIEventListener.Get(self.pickBtn).onClick = function()
        self:PickBtnOnClick()
    end
    CS.UIEventListener.Get(self.helpBtn).onClick = function()
        self:HelpBtnOnClick()
    end
end

function UIArbitratorPanel:BindClientEvent()
    uimanager:GetClientEventHandler():AddEvent(CS.CEvent.V2_DropDataRefresh, function()
        UIArbitratorPanel:RefreshPanel()
    end)
    uimanager:GetClientEventHandler():AddEvent(CS.CEvent.V2_ArbitratorRedPointRefresh, function()
        UIArbitratorPanel:RefreshRedPoint()
    end)
end

function UIArbitratorPanel:ReqPanelParams()
    if luaclass.RemoteHostDataClass:IsKuaFuMap() then
        uiStaticParameter.OpenPanelIsKuaFuMap = true
        networkRequest.ReqShareDropProtect()
    else
        uiStaticParameter.OpenPanelIsKuaFuMap = false
        networkRequest.ReqDropProtect()
    end
end
--endregion

--region 刷新
---默认打开刷新掉落刷新红点
function UIArbitratorPanel:DefaultRefreshPanel()
    self:DropBtnOnClick()
    self:RefreshRedPoint()
end

---刷新当前显示的面板
function UIArbitratorPanel:RefreshPanel()
    if self.CurPanelTemplate ~= nil then
        self.CurPanelTemplate:RefreshPanel()
    end
end
--endregion

--region Event
---关闭按钮点击
function UIArbitratorPanel:CloseBtnOnClick()
    uimanager:ClosePanel(self)
end

---我掉落的按钮点击
function UIArbitratorPanel:DropBtnOnClick()
    self:TryInitDropTemplate()
    self:HidePickTemplate()
end

---我拾取的按钮点击
function UIArbitratorPanel:PickBtnOnClick()
    self:TryInitPickTemplate()
    self:HideDropTemplate()
end

---帮助按钮点击
function UIArbitratorPanel:HelpBtnOnClick()
    Utility.ShowHelpPanel({ id = LuaEnumHelpPanelType.Aribitrator_Help })
end
--endregion

--region drop相关
function UIArbitratorPanel:TryInitDropTemplate()
    if self.dropPanelTemplate == nil and self.dropPanel ~= nil and not CS.StaticUtility.IsNull(self.dropPanel) then
        self.dropPanelTemplate = templatemanager.GetNewTemplate(self.dropPanel, luaComponentTemplates.UIArbitratorPanel_DropPanelTemplate)
    end
    if self.dropPanelTemplate ~= nil then
        self.dropPanelTemplate:RefreshPanel()
    end
    self.CurPanelTemplate = self.dropPanelTemplate
end

function UIArbitratorPanel:HideDropTemplate()
    if self.dropPanelTemplate ~= nil then
        self.dropPanelTemplate:HidePanel()
    end
end
--endregion

--region pick相关
function UIArbitratorPanel:TryInitPickTemplate()
    if self.pickPanelTemplate == nil and self.pickPanel ~= nil and not CS.StaticUtility.IsNull(self.pickPanel) then
        self.pickPanelTemplate = templatemanager.GetNewTemplate(self.pickPanel, luaComponentTemplates.UIArbitratorPanel_PickPanelTemplate)
    end
    if self.pickPanelTemplate ~= nil then
        self.pickPanelTemplate:RefreshPanel()
    end
    self.CurPanelTemplate = self.pickPanelTemplate
end

function UIArbitratorPanel:HidePickTemplate()
    if self.pickPanelTemplate ~= nil then
        self.pickPanelTemplate:HidePanel()
    end
end
--endregion

--region 红点
function UIArbitratorPanel:RefreshRedPoint()
    self:RefreshDropRedPoint()
    self:RefreshPickRedPoint()
end

function UIArbitratorPanel:RefreshDropRedPoint()
    if self.dropBtnRedPoint ~= nil and not CS.StaticUtility.IsNull(self.dropBtnRedPoint) then
        self.dropBtnRedPoint:SetActive(CS.CSScene.MainPlayerInfo.DropInfo:GetDropRedPointState())
    end
end

function UIArbitratorPanel:RefreshPickRedPoint()
    if self.pickBtnRedPoint ~= nil and not CS.StaticUtility.IsNull(self.pickBtnRedPoint) then
        self.pickBtnRedPoint:SetActive(CS.CSScene.MainPlayerInfo.DropInfo:GetPickRedPointState())
    end
end
--endregion
return UIArbitratorPanel