local UIOptionalBoxPanel = {}
--region 组件
function UIOptionalBoxPanel:GetBackGround_UISprite()
    if self.BackGround_UISprite == nil then
        self.BackGround_UISprite = self:GetCurComp("WidgetRoot/view/background/bg","UISprite")
    end
    return self.BackGround_UISprite
end
--endregion

--region 初始化
function UIOptionalBoxPanel:Init()
    self:InitComponent()
    self:BindEvents()
    self:BindClientEvents()
end

function UIOptionalBoxPanel:InitComponent()
    self.closeBtn_GameObject = self:GetCurComp("WidgetRoot/events/close","GameObject")
    self.confirmBtn_GameObject = self:GetCurComp("WidgetRoot/events/CenterBtn","GameObject")
    self.titleName_UILabel = self:GetCurComp("WidgetRoot/view/title","UILabel")
    self.descriptor_UILabel = self:GetCurComp("WidgetRoot/view/description","UILabel")
    self.grid_UIGridContainer = self:GetCurComp("WidgetRoot/ScrollView/grid","UIGridContainer")
end

function UIOptionalBoxPanel:BindEvents()
    CS.UIEventListener.Get(self.closeBtn_GameObject).onClick = function()
        uimanager:ClosePanel("UIItemInfoPanel")
        uimanager:ClosePanel(self)
    end
    CS.UIEventListener.Get(self.confirmBtn_GameObject).onClick = function(go)
        local chooseList = CS.Cfg_BoxTableManager.Instance.ChooseItemidList
        if chooseList.Count ~= self.optionalBox.MaxChooseCount then
            Utility.ShowPopoTips(go.transform,nil,304)
            return
        end
        if chooseList ~= nil and chooseList.Count > 0 then
            uimanager:ClosePanel(self)
            uimanager:ClosePanel("UIItemInfoPanel")
            local chooseTable = Utility.ListChangeTable(chooseList)
            networkRequest.ReqUseItem(1, self.bagItemInfo.lid, 0,chooseTable)
            CS.Cfg_BoxTableManager.Instance:ClearChooseList()
        end
    end
end

function UIOptionalBoxPanel:BindClientEvents()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_RemoveIdBoxChooseList, function(id,itemId)
        if self.chooseItemTemplateTable ~= nil then
            local template = self.chooseItemTemplateTable[itemId]
            if template ~= nil then
                template:RefreshChooseState(false)
            end
        end
    end)
end
--endregion

--region 刷新
function UIOptionalBoxPanel:Show(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel(self)
        return
    end
    self:DefaultRefresh()
    self:RefreshItemList()
end

---解析数据
---@return boolean 是否解析成功
function UIOptionalBoxPanel:AnalysisParams(commonData)
    if commonData == nil or commonData.optionalBox == nil or commonData.optionalBox.IsOptionalBox == false or commonData.optionalBox.AnalysisSuccess == false
    or commonData.optionalBox.ChooseItemIdList == nil or commonData.optionalBox.ChooseItemIdList.Count == 0 or commonData.bagItemInfo == nil then
        return false
    end
    self.bagItemInfo = commonData.bagItemInfo
    self.optionalBox = commonData.optionalBox
    self.chooseItemList = self.optionalBox.ChooseItemIdList
    return true
end

function UIOptionalBoxPanel:DefaultRefresh()
    if CS.StaticUtility.IsNull(self.titleName_UILabel) == false then
        self.titleName_UILabel.text = self.optionalBox.BoxName
    end
    if CS.StaticUtility.IsNull(self.descriptor_UILabel) == false then
        self.descriptor_UILabel.text = self.optionalBox.BoxDescriptor
    end
end

function UIOptionalBoxPanel:RefreshItemList()
    self.chooseItemTemplateTable = {}
    if self.grid_UIGridContainer ~= nil then
        self.grid_UIGridContainer.MaxCount = self.chooseItemList.Count
        local length = self.chooseItemList.Count - 1
        for k = 0,length do
            local grid_go = self.grid_UIGridContainer.controlList[k]
            local optionalBoxIteminfo = self.chooseItemList[k]
            local template = templatemanager.GetNewTemplate(grid_go,luaComponentTemplates.UIOptionalBoxPanelGrid_Normal)
            local refreshSuccess = template:RefreshPanel({optionalBoxIteminfo = optionalBoxIteminfo,maxChooseCount = self.optionalBox.MaxChooseCount,UIOptionalBoxPanel = self})
            if refreshSuccess == false then
                uimanager:ClosePanel(self)
                return
            end
            self.chooseItemTemplateTable[optionalBoxIteminfo.ItemId] = template
        end
    end
end
--endregion
return UIOptionalBoxPanel