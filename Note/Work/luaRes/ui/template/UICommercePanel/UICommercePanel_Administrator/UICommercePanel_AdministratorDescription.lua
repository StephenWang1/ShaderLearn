local UICommercePanel_AdministratorDescription = {}

--region 组件
function UICommercePanel_AdministratorDescription:GetTitle_UILabel()
    if CS.StaticUtility.IsNull(self.mTitle_UILabel) then
        self.mTitle_UILabel = self:Get("rewardExperienceLabel","UILabel")
        if CS.StaticUtility.IsNull(self.mTitle_UILabel) then
            self.mTitle_UILabel = self:Get("rewardLabel","UILabel")
        end
    end
    return self.mTitle_UILabel
end

function UICommercePanel_AdministratorDescription:GetDescription_UIGridContainer()
    if CS.StaticUtility.IsNull(self.mDescription_UIGridContainer) then
        self.mDescription_UIGridContainer = self:Get("rewardExperienceDescription","UIGridContainer")
        if CS.StaticUtility.IsNull(self.mDescription_UIGridContainer) then
            self.mDescription_UIGridContainer = self:Get("rewardDescription","UIGridContainer")
        end
    end
    return self.mDescription_UIGridContainer
end
--endregion

--region 刷新
function UICommercePanel_AdministratorDescription:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel("UICommerceAdministratorPanel")
        return
    end
    if CS.StaticUtility.IsNull(self.go) == false then
        self.go:SetActive(true)
    end
    self:RefreshTitle()
    self:RefreshDescription()
end

function UICommercePanel_AdministratorDescription:AnalysisParams(commonData)
    if commonData.title == nil then
        return false
    end
    self.title = commonData.title
    self.descriptionId = commonData.descriptionId
    self.descriptionTable = commonData.descriptionTable
    if self.descriptionTable ~= nil then
        if type(self.descriptionTable) ~= 'table' then
            self.descriptionTable = Utility.ListChangeTable(self.descriptionTable)
        end
    else
        if self.descriptionId ~= nil and type(self.descriptionId) == 'number' then
            local descriptionInfoIsFind,descriptionInfo = CS.Cfg_DescriptionTableManager.Instance:TryGetValue(self.descriptionId)
            if descriptionInfoIsFind == true then
                self.descriptionTable = string.Split(descriptionInfo.value,'#')
            end
        end
    end
    if self.descriptionTable == nil then
        return false
    end
    return true
end

---刷新标题
function UICommercePanel_AdministratorDescription:RefreshTitle()
    if CS.StaticUtility.IsNull(self:GetTitle_UILabel()) == false then
        self:GetTitle_UILabel().text = self.title
    end
end

---刷新描述内容
function UICommercePanel_AdministratorDescription:RefreshDescription()
    self.descriptionTemplateTable = {}
    if CS.StaticUtility.IsNull(self:GetDescription_UIGridContainer()) == false then
        local length = #self.descriptionTable
        self:GetDescription_UIGridContainer().MaxCount = length
        for k = 0,length - 1 do
            local go = self:GetDescription_UIGridContainer().controlList[k]
            local descriptionText = self.descriptionTable[k + 1]
            if CS.StaticUtility.IsNull(go) == false and CS.StaticUtility.IsNullOrEmpty(descriptionText) == false then
                local template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UICommerceRewardDesUnitTemplate)
                if template ~= nil then
                    self.descriptionTemplateTable[go] = template
                    template:UpdateDes(descriptionText)
                end
            end
        end
    end
end
--endregion
return UICommercePanel_AdministratorDescription