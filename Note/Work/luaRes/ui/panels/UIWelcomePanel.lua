local UIWelcomePanel = {}
UIWelcomePanel.PanelLayerType = CS.UILayerType.GuidePlane
function UIWelcomePanel:Init()
    UIWelcomePanel.InitComponents()
    UIWelcomePanel.InitOther()
end
--通过工具生成 控件变量
function UIWelcomePanel.InitComponents()
    UIWelcomePanel.mStartBtn_GameObject = UIWelcomePanel:GetCurComp("WidgetRoot/StartBtn", "GameObject")
end
--初始化 变量 按钮点击 服务器消息事件等
function UIWelcomePanel.InitOther()
    CS.UIEventListener.Get(UIWelcomePanel.mStartBtn_GameObject).onClick = UIWelcomePanel.OnClickStartBtn
    CS.UIEventListener.Get(UIWelcomePanel.go).onClick = UIWelcomePanel.OnClickStartBtn
end

function UIWelcomePanel.OnClickStartBtn()
    uimanager:ClosePanel("UIWelcomePanel")
    UIWelcomePanel:GetClientEventHandler():SendEvent(CS.CEvent.V2_AutoDoMission, 0);
end

return UIWelcomePanel