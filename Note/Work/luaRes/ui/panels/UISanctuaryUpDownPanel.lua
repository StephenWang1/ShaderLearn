local UISanctuaryUpDownPanel = {}
--region 初始化
function UISanctuaryUpDownPanel:Init()
    self:InitComponent()
    self:InitParams()
    self:InitEvents()
end

function UISanctuaryUpDownPanel:InitComponent()
    self.titleName_UILabel = self:GetCurComp("WidgetRoot/view/lb_name", "UILabel")
    self.nextLayerTips_UILabel = self:GetCurComp("WidgetRoot/view/lb_describe", "UILabel")
    self.upLayerBtn_GameObject = self:GetCurComp("WidgetRoot/view/Daily/btn1", "GameObject")
    self.downLayerBtn_GameObject = self:GetCurComp("WidgetRoot/view/Daily/btn2", "GameObject")
    self.closeBtn_GameObject = self:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
end

function UISanctuaryUpDownPanel:InitParams()
    self.duplicateInfo = CS.CSScene.MainPlayerInfo.SanctuaryInfo.nowDuplicateInfo
    self.upLayerDuplicateId = CS.CSScene.MainPlayerInfo.SanctuaryInfo:GetUpLayerDuplicateId(1)
    self.lowLayerDuplicateId = CS.CSScene.MainPlayerInfo.SanctuaryInfo:GetUpLayerDuplicateId(2)
    if self.duplicateInfo ~= nil then
        self.nowLayer = self.duplicateInfo.floor
    end
end

function UISanctuaryUpDownPanel:InitEvents()
    CS.UIEventListener.Get(self.downLayerBtn_GameObject).onClick = function(go)
        if CS.CSScene.MainPlayerInfo.SanctuaryInfo:CheckSanctuaryIsCanEnter(self.lowLayerDuplicateId) then
            Utility.ReqEnterDuplicate(self.lowLayerDuplicateId)
            self:ChangeMissionPanel()
        else
            Utility.ShowPopoTips(go.transform, nil, 185)
        end
    end
    CS.UIEventListener.Get(self.upLayerBtn_GameObject).onClick = function()
        Utility.ReqEnterDuplicate(self.upLayerDuplicateId)
        self:ChangeMissionPanel()
    end
    CS.UIEventListener.Get(self.closeBtn_GameObject).onClick = function()
        self:ChangeMissionPanel()
    end
end
--endregion

--region 刷新
function UISanctuaryUpDownPanel:Show()
    if self.duplicateInfo == nil then
        uimanager:ClosePanel(self)
        print("没有当前层数据")
        return
    end
    if self.titleName_UILabel ~= nil and self.duplicateInfo ~= nil then
        self.titleName_UILabel.text = '[dde6eb]' .. self.duplicateInfo.name .. '[-]'
    end
    if self.nextLayerTips_UILabel ~= nil and self.duplicateInfo ~= nil then
        self.nextLayerTips_UILabel.text = '[878787]' .. CS.CSScene.MainPlayerInfo.SanctuaryInfo:GetLayerTipsText(self.nowLayer + 1) ..'[-]'
    end
    self:RefreshBtn()
end

function UISanctuaryUpDownPanel:RefreshBtn()
    if self.upLayerDuplicateId == 0 then
        self.upLayerBtn_GameObject:SetActive(false)
    end
    if self.lowLayerDuplicateId == 0 then
        self.downLayerBtn_GameObject:SetActive(false)
    end
end

function UISanctuaryUpDownPanel:ChangeMissionPanel()
    uimanager:ClosePanel(self)
    local uiMainMenusPanel = uimanager:GetPanel("UIMainMenusPanel")
    if uiMainMenusPanel ~= nil then
        uiMainMenusPanel:ChangeLeftPanel("UISanctuaryLeftMainPanel")
    end
end
--endregion

--region UI事件

--endregion
return UISanctuaryUpDownPanel