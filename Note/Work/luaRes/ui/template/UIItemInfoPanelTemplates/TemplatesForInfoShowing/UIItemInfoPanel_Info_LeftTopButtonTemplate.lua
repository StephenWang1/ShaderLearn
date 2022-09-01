local UIItemInfoPanel_Info_LeftTopButtonTemplate = {}

--region 初始化
function UIItemInfoPanel_Info_LeftTopButtonTemplate:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIItemInfoPanel_Info_LeftTopButtonTemplate:InitComponent()
    self.bgName_UISprite = self:Get("backGround/Label","UISprite")
    self.check_UISprite = self:Get("check/Label","UISprite")
    self.redPoint = self:Get("redpoint","GameObject")
    self.check_Go = self:Get("check","GameObject")
    self.go_UIToggle = self:Get("","UIToggle")
end

function UIItemInfoPanel_Info_LeftTopButtonTemplate:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function() self:BtnOnClick() end
end
--endregion

--region 事件
function UIItemInfoPanel_Info_LeftTopButtonTemplate:BtnOnClick()
    if (luaEventManager.HasCallback(LuaCEvent.TabChangeRefreshPanel)) then
        local customData = {};
        customData.type = self.type
        customData.btnIndex = self.btnIndex
        customData.index = self.index
        uiStaticParameter.UIItemInfoManager:SetChooseIndex(self.index)
        luaEventManager.DoCallback(LuaCEvent.TabChangeRefreshPanel, customData)
    end
end
--endregion

--region 刷新
function UIItemInfoPanel_Info_LeftTopButtonTemplate:RefreshPanel(commonData)
    self:AnalysisParams(commonData)
    self:RefreshName()
    self:RefreshRedPoint()
    if self.TabDefaultChoose ~= 0 then
        self:ChangeStartState(self.index == self.TabDefaultChoose)
    end
    self.go_UIToggle.group = 10
end

function UIItemInfoPanel_Info_LeftTopButtonTemplate:AnalysisParams(commonData)
    self.index = commonData.index
    self.name = ternary(commonData.name == nil,"",commonData.name)
    self.bagItemInfoTable = commonData.bagItemInfoTable
    self.itemInfoTable = commonData.itemInfoTable
    self.type = commonData.type
    self.btnIndex = commonData.btnIndex
    self.TabDefaultChoose = commonData.TabDefaultChoose
    return true
end

function UIItemInfoPanel_Info_LeftTopButtonTemplate:RefreshName()
    if self.bgName_UISprite ~= nil and self.check_UISprite ~= nil and self.name ~= nil and type(self.name) == 'table' and Utility.GetTableCount(self.name) then
        self.bgName_UISprite.spriteName = self.name[1]
        self.check_UISprite.spriteName = self.name[2]
    end
end

function UIItemInfoPanel_Info_LeftTopButtonTemplate:RefreshRedPoint()
    if self.redPoint ~= nil then
        self.redPoint:SetActive(false)
    end
end

function UIItemInfoPanel_Info_LeftTopButtonTemplate:ChangeStartState(open)
    if self.go_UIToggle ~= nil then
        self.go_UIToggle:Set(open)
    end
end
--endregion

return UIItemInfoPanel_Info_LeftTopButtonTemplate