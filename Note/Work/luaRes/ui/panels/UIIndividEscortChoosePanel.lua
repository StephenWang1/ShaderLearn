local UIIndividEscortChoosePanel = {}
--region 初始化
function UIIndividEscortChoosePanel:Init()
    self:InitParams()
    self:InitComponent()
    self:BindEvents()
    self:BindClientEvents()
    self:SetParams()
end

function UIIndividEscortChoosePanel:InitComponent()
    self.dartCarListTemplatePoint = self:GetCurComp("WidgetRoot", "GameObject")
    self.CloseBtn = self:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    self.helpBtn = self:GetCurComp("WidgetRoot/events/btn_help", "GameObject")
    self.expToggle = self:GetCurComp("WidgetRoot/events/TopToggle/ScrollView/ToggleList/ExpToggle", "UIToggle")
    self.servantExpToggle = self:GetCurComp("WidgetRoot/events/TopToggle/ScrollView/ToggleList/ServantExpToggle", "UIToggle")
    self.ingotToggle = self:GetCurComp("WidgetRoot/events/TopToggle/ScrollView/ToggleList/IngotToggle", "UIToggle")
end

function UIIndividEscortChoosePanel:BindEvents()
    CS.UIEventListener.Get(self.CloseBtn).onClick = function()
        uimanager:ClosePanel(self)
    end
    CS.UIEventListener.Get(self.expToggle.gameObject).onClick = function()
        self:RefreshYaBiaoList(LuaEnumPersonDartCarType.PLAYEREXP)
    end
    CS.UIEventListener.Get(self.servantExpToggle.gameObject).onClick = function()
        self:RefreshYaBiaoList(LuaEnumPersonDartCarType.SERVANTEXP)
    end
    CS.UIEventListener.Get(self.ingotToggle.gameObject).onClick = function()
        self:RefreshYaBiaoList(LuaEnumPersonDartCarType.INGOT)
    end
    CS.UIEventListener.Get(self.helpBtn).onClick = function()
        Utility.ShowHelpPanel({ id = 129 })
    end
end

function UIIndividEscortChoosePanel:BindClientEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, function()
        self:RefreshResource()
    end)
end

function UIIndividEscortChoosePanel:InitParams()
    self.yaBiaoListTemplateTable = {}
    self.isRefreshPanel = false
end

function UIIndividEscortChoosePanel:SetParams()
    self.expToggle.group = 10
    self.servantExpToggle.group = 10
    self.ingotToggle.group = 10
end
--endregion

--region 刷新
function UIIndividEscortChoosePanel:Show(commonData)
    self:AnalysisParans(commonData)
    self:SetBtnState()
    self:RefreshYaBiaoList(self.chooseDartCarType)
    self.isRefreshPanel = true
end

---解析参数
function UIIndividEscortChoosePanel:AnalysisParans(commonData)
    self.chooseDartCarType = LuaEnumPersonDartCarType.PLAYEREXP
    if commonData ~= nil then
        self.recommendDartCarInfo = commonData.recommendDartCarInfo
        self.personDartCarSourceType = commonData.personDartCarSourceType
        if self.recommendDartCarInfo ~= nil then
            self.chooseDartCarType = self.recommendDartCarInfo.YaBiaoTable.type
        end
    end
end

---设置按钮状态
function UIIndividEscortChoosePanel:SetBtnState()
    if self.isRefreshPanel == false then
        if self.expToggle ~= nil then
            self.expToggle:Set(self.chooseDartCarType == LuaEnumPersonDartCarType.PLAYEREXP)
        end
        if self.servantExpToggle ~= nil then
            self.servantExpToggle:Set(self.chooseDartCarType == LuaEnumPersonDartCarType.SERVANTEXP)
        end
        if self.ingotToggle ~= nil then
            self.ingotToggle:Set(self.chooseDartCarType == LuaEnumPersonDartCarType.INGOT)
        end
    end
end

---刷新押镖列表
function UIIndividEscortChoosePanel:RefreshYaBiaoList(dartCarType)
    self.dartCarListTemplate = nil
    if self.yaBiaoListTemplateTable ~= nil and self.yaBiaoListTemplateTable[dartCarType] ~= nil then
        self.dartCarListTemplate = self.yaBiaoListTemplateTable[dartCarType]
    else
        local template = self:GetDartCarListTemplate(dartCarType)
        if template ~= nil then
            self.dartCarListTemplate = templatemanager.GetNewTemplate(self.dartCarListTemplatePoint, template, self)
            self.yaBiaoListTemplateTable[dartCarType] = self.dartCarListTemplate
        end
    end
    if self.dartCarListTemplate ~= nil then
        self.dartCarListTemplate:RefreshPanel({ recommendDartCarInfo = self.recommendDartCarInfo, dartCatType = dartCarType, personDartCarSourceType = self.personDartCarSourceType })
    end
end

---刷新资源显示
function UIIndividEscortChoosePanel:RefreshResource()
    if self.dartCarListTemplate ~= nil then
        self.dartCarListTemplate:RefreshNowResource()
    end
end
--endregion

--region 获取
function UIIndividEscortChoosePanel:GetDartCarListTemplate(dartCarType)
    if dartCarType == LuaEnumPersonDartCarType.PLAYEREXP then
        return luaComponentTemplates.UIIndividEscortChoosePanel_PlayerExp
    elseif dartCarType == LuaEnumPersonDartCarType.INGOT then
        return luaComponentTemplates.UIIndividEscortChoosePanel_Ingot
    elseif dartCarType == LuaEnumPersonDartCarType.SERVANTEXP then
        return luaComponentTemplates.UIIndividEscortChoosePanel_ServantExp
    end
    return nil
end
--endregion

function ondestroy()
    local yaBiaoListPanel = uimanager:GetPanel("UIIndividEscortPanel")
    if yaBiaoListPanel ~= nil then
        yaBiaoListPanel:RefreshOriginPanel()
    end
end
return UIIndividEscortChoosePanel