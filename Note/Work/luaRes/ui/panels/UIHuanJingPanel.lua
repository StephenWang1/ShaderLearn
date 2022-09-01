---@class UIHuanJingPanel:UIBase
local UIHuanJingPanel = {}

--region 局部变量
UIHuanJingPanel.DeliverChooseTemplates = {}
UIHuanJingPanel.new = 1
--endregion

--region 组件
function UIHuanJingPanel.GetCloseBtn_GameObject()
    if (UIHuanJingPanel.mCloseBtn == nil) then
        UIHuanJingPanel.mCloseBtn = UIHuanJingPanel:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return UIHuanJingPanel.mCloseBtn
end

function UIHuanJingPanel.GetExitBtn_GameObject()
    if (UIHuanJingPanel.mExitBtn == nil) then
        UIHuanJingPanel.mExitBtn = UIHuanJingPanel:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return UIHuanJingPanel.mExitBtn
end

function UIHuanJingPanel.GetCanDeliverFloor_UILabel()
    if (UIHuanJingPanel.mCanDeliverFloor == nil) then
        UIHuanJingPanel.mCanDeliverFloor = UIHuanJingPanel:GetCurComp("WidgetRoot/introduce/labelGroup/DeliverTitle/value", "UILabel")
    end
    return UIHuanJingPanel.mCanDeliverFloor
end

function UIHuanJingPanel.GetDeliverFloor_GridContainer()
    if (UIHuanJingPanel.mDeliverFloor_GridContainer == nil) then
        UIHuanJingPanel.mDeliverFloor_GridContainer = UIHuanJingPanel:GetCurComp("WidgetRoot/Scroll View/SafeArea", "Top_UIGridContainer")
    end
    return UIHuanJingPanel.mDeliverFloor_GridContainer
end
--endregion

--region 初始化
function UIHuanJingPanel:Init()
    UIHuanJingPanel:BindMessage()
    UIHuanJingPanel:BindUIEvents()
end

function UIHuanJingPanel:Show()
    UIHuanJingPanel.RefreshDeliverPanel()
end

function UIHuanJingPanel:BindMessage()

end

function UIHuanJingPanel:BindUIEvents()
    CS.UIEventListener.Get(UIHuanJingPanel.GetExitBtn_GameObject()).onClick = UIHuanJingPanel.ExitBtnOnClick
    CS.UIEventListener.Get(UIHuanJingPanel.GetCloseBtn_GameObject()).onClick = UIHuanJingPanel.CloseBtnOnClick
end
--endregion

--region 客户端事件
function UIHuanJingPanel.ExitBtnOnClick()
    networkRequest.ReqExitDuplicate(0)
    UIHuanJingPanel.CloseBtnOnClick()
end

function UIHuanJingPanel.CloseBtnOnClick()
    uimanager:ClosePanel("UIHuanJingPanel")
end
--endregion

--region 刷新界面
function UIHuanJingPanel.RefreshDeliverPanel()
    local CanDeliverFloor = CS.CSScene.MainPlayerInfo.DuplicateV2.CanDeliverFloor
    local Length = CS.Cfg_MiGongTableManager.Instance.CanDeliverCount
    if (Length == 0) then
        return
    end
    UIHuanJingPanel.GetCanDeliverFloor_UILabel().text = tostring(CanDeliverFloor)
    UIHuanJingPanel.GetDeliverFloor_GridContainer().MaxCount = Length - 1
    for k = 2, Length do
        local go = UIHuanJingPanel.GetDeliverFloor_GridContainer().controlList[k - 2]
        if (UIHuanJingPanel.DeliverChooseTemplates[go] == nil) then
            UIHuanJingPanel.DeliverChooseTemplates[go] = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIUnrealMazeDeliverChoose, UIHuanJingPanel)
        end
        if (k >= CanDeliverFloor+2) then
            UIHuanJingPanel.DeliverChooseTemplates[go].canDeiliver = false
        else
            UIHuanJingPanel.DeliverChooseTemplates[go].canDeiliver = true
        end
        UIHuanJingPanel.DeliverChooseTemplates[go].index = k
        UIHuanJingPanel.DeliverChooseTemplates[go]:InitData()
        UIHuanJingPanel.DeliverChooseTemplates[go]:RefreshUIPanel()
    end
end

function UIHuanJingPanel:ShowTips(go, id, str)
    local TipsInfo = {}
    TipsInfo[LuaEnumTipConfigType.Parent] = go.transform
    TipsInfo[LuaEnumTipConfigType.ConfigID] = id
    if (str ~= nil) then
        TipsInfo[LuaEnumTipConfigType.Describe] = str
    end
    TipsInfo[LuaEnumTipConfigType.DependPanel] = "UIServantPanel"
    uimanager:CreatePanel("UIBubbleTipsPanel", nil, TipsInfo)
end
--endregion

function ondestroy()

end

return UIHuanJingPanel