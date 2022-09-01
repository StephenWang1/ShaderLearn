---@class UIWeddingRingUpPanel:UIBase
local UIWeddingRingUpPanel = {}

--region 局部变量
UIWeddingRingUpPanel.BranchPanel = {};
--endregion

--region 组件
function UIWeddingRingUpPanel:GetCloseBtn_GameObject()
    if (UIWeddingRingUpPanel.mCloseBtn == nil) then
        UIWeddingRingUpPanel.mCloseBtn = UIWeddingRingUpPanel:GetCurComp("WidgetRoot/events/CloseBtn", "GameObject")
    end
    return UIWeddingRingUpPanel.mCloseBtn
end

function UIWeddingRingUpPanel:GetCurBranchPanel()
    return UIWeddingRingUpPanel.BranchPanel[UIWeddingRingUpPanel.WeddingNavType]
end

function UIWeddingRingUpPanel:GetWeddingRingPanel_Root()
    if (UIWeddingRingUpPanel.mWeddingRingRoot == nil) then
        UIWeddingRingUpPanel.mWeddingRingRoot = UIWeddingRingUpPanel:GetCurComp("WidgetRoot/window/WeddingRingPanel", "GameObject")
    end
    return UIWeddingRingUpPanel.mWeddingRingRoot
end

function UIWeddingRingUpPanel:GetMoreInfoPanel_Root()
    if (UIWeddingRingUpPanel.mMoreInfoRoot == nil) then
        UIWeddingRingUpPanel.mMoreInfoRoot = UIWeddingRingUpPanel:GetCurComp("WidgetRoot/window/MoreInfoPanel", "GameObject")
    end
    return UIWeddingRingUpPanel.mMoreInfoRoot
end

function UIWeddingRingUpPanel:GetWeddingBtn_GameObject()
    if (UIWeddingRingUpPanel.mWeddingBtn == nil) then
        UIWeddingRingUpPanel.mWeddingBtn = UIWeddingRingUpPanel:GetCurComp("WidgetRoot/events/ToggleList/WeddingBtn", "GameObject")
    end
    return UIWeddingRingUpPanel.mWeddingBtn
end

function UIWeddingRingUpPanel:GetMoreInfoBtn_GameObject()
    if (UIWeddingRingUpPanel.mMoreInfoBtn == nil) then
        UIWeddingRingUpPanel.mMoreInfoBtn = UIWeddingRingUpPanel:GetCurComp("WidgetRoot/events/ToggleList/MoreInfoBtn", "GameObject")
    end
    return UIWeddingRingUpPanel.mMoreInfoBtn
end

function UIWeddingRingUpPanel:GetMaxLevel_UISprite()
    if (self.mMaxLevelSprite == nil) then
        self.mMaxLevelSprite = self:GetCurComp("WidgetRoot/view/MaxLevel", "UISprite")
    end
    return self.mMaxLevelSprite
end
--endregion

--region 初始化
function UIWeddingRingUpPanel:Init()
    UIWeddingRingUpPanel:BindUIEvents()
    UIWeddingRingUpPanel:InitPanel()
end

function UIWeddingRingUpPanel:BindUIEvents()
    CS.UIEventListener.Get(UIWeddingRingUpPanel:GetCloseBtn_GameObject()).onClick = UIWeddingRingUpPanel.CloseBtnOnClick
    CS.UIEventListener.Get(UIWeddingRingUpPanel:GetWeddingBtn_GameObject()).onClick = UIWeddingRingUpPanel.WeddingPanelBtnOnClick
    CS.UIEventListener.Get(UIWeddingRingUpPanel:GetMoreInfoBtn_GameObject()).onClick = UIWeddingRingUpPanel.MoreInfoPanelBtnOnClick
end

---@param type number 界面类型
function UIWeddingRingUpPanel:Show(type)
    if (type == nil) then
        UIWeddingRingUpPanel.WeddingNavType = LuaEnumWeddingPanelType.WeddingRingPanel
        UIWeddingRingUpPanel:SwitchPanel(UIWeddingRingUpPanel.WeddingNavType)
    end
end

function UIWeddingRingUpPanel:InitPanel()
    UIWeddingRingUpPanel.BranchPanel[LuaEnumWeddingPanelType.WeddingRingPanel] = templatemanager.GetNewTemplate(UIWeddingRingUpPanel:GetWeddingRingPanel_Root(), luaComponentTemplates.UIWeddingRingPanelTemplates, self)
    UIWeddingRingUpPanel.BranchPanel[LuaEnumWeddingPanelType.MoreInfoPanel] = templatemanager.GetNewTemplate(UIWeddingRingUpPanel:GetMoreInfoPanel_Root(), luaComponentTemplates.UIWeddingMoreInfoPanelTemplates, self)
end
--endregion

--region 界面刷新
---@param type number 界面类型
function UIWeddingRingUpPanel:SwitchPanel(type)
    if (UIWeddingRingUpPanel:GetCurBranchPanel() ~= nil) then
        UIWeddingRingUpPanel:GetCurBranchPanel():Hide()
    end
    UIWeddingRingUpPanel.WeddingNavType = type
    if (UIWeddingRingUpPanel:GetCurBranchPanel() ~= nil) then
        UIWeddingRingUpPanel:GetCurBranchPanel():Show()
    end
end

function UIWeddingRingUpPanel:RefreshUIPanel()

end


--endregion

--region 客户端消息处理
function UIWeddingRingUpPanel.CloseBtnOnClick()
    uimanager:ClosePanel("UIWeddingRingUpPanel")
end

function UIWeddingRingUpPanel.WeddingPanelBtnOnClick()
    UIWeddingRingUpPanel:SwitchPanel(LuaEnumWeddingPanelType.WeddingRingPanel)
end

function UIWeddingRingUpPanel.MoreInfoPanelBtnOnClick()
    UIWeddingRingUpPanel:SwitchPanel(LuaEnumWeddingPanelType.MoreInfoPanel)
end


--endregion

--region 服务器消息处理

--endregion

function ondestroy()

end

return UIWeddingRingUpPanel