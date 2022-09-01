local UIGuildSendBenefitsPanel = {}
--region 数据
function UIGuildSendBenefitsPanel:GetMainPlayerInfo()
    if self.mainPlayerInfo == nil then
        self.mainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mainPlayerInfo
end
--endregion

--region 初始化
function UIGuildSendBenefitsPanel:Init()
    self:InitComponent()
    self:InitEvents()
    self:InitPanel()
    self:InitParams()
end

function UIGuildSendBenefitsPanel:InitComponent()
    self.search_Input = self:GetCurComp("WidgetRoot/view/Search","UIInput")
    self.closeBtn = self:GetCurComp("WidgetRoot/events/CloseBtn","GameObject")
    self.helpBtn = self:GetCurComp("WidgetRoot/events/btn_description","GameObject")
    self.search_Btn = self:GetCurComp("WidgetRoot/view/Search/search_btn","GameObject")
    self.onePlayerList_GameObject = self:GetCurComp("WidgetRoot/view/OneSendPanel","GameObject")
    self.allPlayerList_GameObject = self:GetCurComp("WidgetRoot/view/AllSendPanel","GameObject")
    self.grant_Btn = self:GetCurComp("WidgetRoot/events/btn_ections","GameObject")
end

function UIGuildSendBenefitsPanel:InitEvents()
    CS.UIEventListener.Get(self.closeBtn).onClick = function()
        uimanager:ClosePanel(self)
    end
    CS.UIEventListener.Get(self.helpBtn).onClick = function()
        self:CreateHelpPanel()
    end
    CS.UIEventListener.Get(self.search_Btn).onClick = function()
        self:SearchBtnOnClick()
    end
    CS.UIEventListener.Get(self.grant_Btn).onClick = function(go)
        self:GrantBtnOnClick(go)
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_GrantPlayerListRefresh, function()
        if self.playerListTemplate ~= nil then
            self.playerListTemplate:RefreshPanel({bagItemInfo = self.bagItemInfo,itemInfo = self.itemInfo})
        end
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_UnionGrantPlayerStateChange, function()
        if self.playerListTemplate ~= nil and self.playerListTemplate.playerListType == ChoosePlayerListType.Choose then
            self.playerListTemplate:RefreshNowList()
        end
    end)
end

function UIGuildSendBenefitsPanel:InitPanel()
    self.onePlayerList_GameObject:SetActive(false)
    self.allPlayerList_GameObject:SetActive(false)
end

function UIGuildSendBenefitsPanel:InitParams()
    networkRequest.ReqCanGetSpoilsMembers()
end
--endregion

--region 刷新
---@param CommonData.bagItemInfo 物品信息
function UIGuildSendBenefitsPanel:Show(CommonData)
    self:AnalysisData(CommonData)
    self:RefreshPanel()
end

function UIGuildSendBenefitsPanel:AnalysisData(CommonData)
    self.bagItemInfo = CommonData.bagItemInfo
    local itemInfoIsFind,itemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.bagItemInfo.itemId)
    if itemInfoIsFind then
        self.itemInfo = itemInfo
    end
    self:GetPlayerListType()
end

function UIGuildSendBenefitsPanel:GetPlayerListType()
    if self.itemInfo ~= nil then
        if self.itemInfo.type == luaEnumItemType.Coin then
            self.playerListType = luaEnumUnionGrantPlayerListType.AllPlayerList
        elseif self.itemInfo.overlying == 1 then
            self.playerListType = luaEnumUnionGrantPlayerListType.OnePlayerList
        else
            self.playerListType = luaEnumUnionGrantPlayerListType.OnePlayerList
        end
    end
end

function UIGuildSendBenefitsPanel:RefreshPanel()
    if self.playerListType == luaEnumUnionGrantPlayerListType.OnePlayerList then
        self.playerListTemplate = templatemanager.GetNewTemplate(self.onePlayerList_GameObject,luaComponentTemplates.UIGuildSendBenefitsPanel_OnePlayerList)
    elseif self.playerListType == luaEnumUnionGrantPlayerListType.AllPlayerList then
        self.playerListTemplate = templatemanager.GetNewTemplate(self.allPlayerList_GameObject,luaComponentTemplates.UIGuildSendBenefitsPanel_AllPlayerList)
    end
    --if self.playerListTemplate ~= nil then
    --    self.playerListTemplate:RefreshPanel({bagItemInfo = self.bagItemInfo,itemInfo = self.itemInfo})
    --end
end
--endregion

--region UI
---创建帮助面板
function UIGuildSendBenefitsPanel:CreateHelpPanel()
    local isFind, info = CS.Cfg_DescriptionTableManager.Instance.dic:TryGetValue(112)
    if isFind then
        uimanager:CreatePanel("UIHelpTipsPanel", nil, info)
    end
end

---点击搜索按钮
function UIGuildSendBenefitsPanel:SearchBtnOnClick()
    local searchText = self.search_Input.value
    if self.playerListTemplate ~= nil then
        self.playerListTemplate:RefreshSearchList(searchText)
    end
end

---发放按钮点击
function UIGuildSendBenefitsPanel:GrantBtnOnClick(go)
    if self.playerListTemplate == nil then
        return
    end
    self.playerListTemplate:GrantBtnOnClick(go)
end
--endregion
return UIGuildSendBenefitsPanel