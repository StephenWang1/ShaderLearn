local UIHuanJingTopFloorPanel = {}

--region 组件
function UIHuanJingTopFloorPanel.GetEnterBtn_GameObject()
    if (UIHuanJingTopFloorPanel.mEnterBtn == nil) then
        UIHuanJingTopFloorPanel.mEnterBtn = UIHuanJingTopFloorPanel:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return UIHuanJingTopFloorPanel.mEnterBtn
end

function UIHuanJingTopFloorPanel.GetCloseBtn_GameObject()
    if (UIHuanJingTopFloorPanel.mCloseBtn == nil) then
        UIHuanJingTopFloorPanel.mCloseBtn = UIHuanJingTopFloorPanel:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return UIHuanJingTopFloorPanel.mCloseBtn
end
--endregion

--region 初始化
function UIHuanJingTopFloorPanel:Init()
    CS.UIEventListener.Get(UIHuanJingTopFloorPanel.GetEnterBtn_GameObject()).onClick = UIHuanJingTopFloorPanel.EnterBtnOnClick
    CS.UIEventListener.Get(UIHuanJingTopFloorPanel.GetCloseBtn_GameObject()).onClick = UIHuanJingTopFloorPanel.CloseBtnOnClick
end

function UIHuanJingTopFloorPanel:Show()

end
--endregion

function UIHuanJingTopFloorPanel.EnterBtnOnClick()
    networkRequest.ReqDeliveryDuplicate(9917)
    uimanager:ClosePanel("UIHuanJingTopFloorPanel")
end

function UIHuanJingTopFloorPanel.CloseBtnOnClick()
    uimanager:ClosePanel("UIHuanJingTopFloorPanel")
end

function UIHuanJingTopFloorPanel.ondestroy()

end

return UIHuanJingTopFloorPanel