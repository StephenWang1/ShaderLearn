local UIIndividEscortPanel = {}
--region 初始化
function UIIndividEscortPanel:Init()
    self:InitComponent()
    self:InitTemplate()
    self:BindEvents()
end

function UIIndividEscortPanel:InitComponent()
    self.CloseBtn_GameObject = self:GetCurComp("WidgetRoot/events/CloseBtn","GameObject")
    self.HelpBtn_GameObject = self:GetCurComp("WidgetRoot/events/HelpBtn","GameObject")
    self.ChooseEscort_GameObject = self:GetCurComp("WidgetRoot/view/ChooseEscort","GameObject")
    self.NoEscort_GameObject = self:GetCurComp("WidgetRoot/view/NoEscort","GameObject")
end

function UIIndividEscortPanel:InitTemplate()
    self.ChooseEscort_Template =  templatemanager.GetNewTemplate(self.ChooseEscort_GameObject,luaComponentTemplates.IndividEscortList2Template)
end

function UIIndividEscortPanel:BindEvents()
    CS.UIEventListener.Get(self.CloseBtn_GameObject).onClick = function()
        self:CloseBtnOnClick()
    end
    CS.UIEventListener.Get(self.HelpBtn_GameObject).onClick = function()
        self:HelpBtnOnClick()
    end
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_PersonDartCarRefresh, function(id,dartCarInfo) self:EventToRefreshDartCarList(dartCarInfo) end)
end
--endregion

--region 事件
function UIIndividEscortPanel:CloseBtnOnClick()
    uimanager:ClosePanel(self)
end

function UIIndividEscortPanel:HelpBtnOnClick()
    Utility.ShowHelpPanel({id = 129})
end
--endregion

--region 刷新
function UIIndividEscortPanel:Show(npcId)
    self.npcId = npcId
    self.personDartCarListType = LuaEnumPersonDartCarListType.NONE
    self:RefreshDartCarList(self:GetPersonDartCarList())
end

---刷新镖车列表方法
---@param List<PersonDartCar> dartCarList
function UIIndividEscortPanel:RefreshDartCarList(dartCarList)
    if dartCarList == nil then
        uimanager:ClosePanel(self)
        return
    end
    self:RefreshNoCarHint(dartCarList)
    self.ChooseEscort_Template:RefreshPanel({dartCarList = dartCarList,personDartCarListType = self.personDartCarListType,personDartCarSourceType = self.personDartCarSourceType,parentCalss = self})
end

function UIIndividEscortPanel:EventToRefreshDartCarList(dartCarInfo)
    if dartCarInfo ~= nil then
        self.ChooseEscort_Template:RefreshSigleDartCar(dartCarInfo)
    else
        self:RefreshDartCarList(self:GetPersonDartCarList())
    end
end

---刷新无镖车提示
function UIIndividEscortPanel:RefreshNoCarHint(dartCarList)
    if self.personDartCarListType == LuaEnumPersonDartCarListType.RecommendDartCarList then

    elseif self.personDartCarListType == LuaEnumPersonDartCarListType.ToReceiveDartCarList then

    elseif self.personDartCarListType == LuaEnumPersonDartCarListType.ReceiveDartCarList then
        if self.NoEscort_GameObject ~= nil then
            self.NoEscort_GameObject:SetActive(dartCarList.Count <= 0)
        end
    end
end
--endregion

--region 获取
---获取个人押镖镖车列表(默认情况下的个人镖车列表)
function UIIndividEscortPanel:GetPersonDartCarList()
    local isDepartNpc = self:IsDepartNpc()
    self.personDartCarSourceType = self:GetPersonDartSourceType()
    if isDepartNpc == true then
        self.personDartCarListType = LuaEnumPersonDartCarListType.RecommendDartCarList
        return CS.CSScene.MainPlayerInfo.PersonDartcarInfo:GetRecommonedDartCarList(self.personDartCarSourceType)
    else
        self.personDartCarListType = LuaEnumPersonDartCarListType.ReceiveDartCarList
        return CS.CSScene.MainPlayerInfo.PersonDartcarInfo:GetReceiveCarList(self.personDartCarSourceType)
    end
end

---获取个人镖车列表
function UIIndividEscortPanel:GetPersonDartSourceType()
    local personDartCarSourceType = LuaEnumPersonDartCarSourceType.NONE
    if self.npcId ~= nil then
        if self.npcId == 1015 or self.npcId == 1017 then
            personDartCarSourceType = LuaEnumPersonDartCarSourceType.BIQI
        elseif self.npcId == 1016 or self.npcId == 1018 then
            personDartCarSourceType = LuaEnumPersonDartCarSourceType.MENGZHONG
        end
    end
    return personDartCarSourceType
end

---刷新回原来的列表（策划要求打开出发镖车列表面板后，清空镖车列表，关闭后显示镖车列表）
function UIIndividEscortPanel:RefreshOriginPanel()
    self:RefreshDartCarList(self:GetPersonDartCarList())
end
--endregion

--region 查询
---是否是出发npc
function UIIndividEscortPanel:IsDepartNpc()
    local isDepartNpc = false
    if self.npcId ~= nil and (self.npcId == 1015 or self.npcId == 1016) then
        isDepartNpc = true
    end
    return isDepartNpc
end
--endregion

function ondestroy()
    uimanager:ClosePanel("UIIndividEscortChoosePanel")
end
return UIIndividEscortPanel