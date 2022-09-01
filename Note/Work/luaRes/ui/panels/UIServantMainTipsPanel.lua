local UIServantMainTipsPanel = {}

function UIServantMainTipsPanel.GetCloseBtn_GameObject()
    if (UIServantMainTipsPanel.mCloseBtn == nil) then
        UIServantMainTipsPanel.mCloseBtn = UIServantMainTipsPanel:GetCurComp("WidgetRoot/Tip1/close", "GameObject")
    end
    return UIServantMainTipsPanel.mCloseBtn
end

function UIServantMainTipsPanel:Init()
    UIServantMainTipsPanel:InitIEnum()
    UIServantMainTipsPanel:BindUIEvent()
end

function UIServantMainTipsPanel:Show()

end

function UIServantMainTipsPanel:BindUIEvent()
    CS.UIEventListener.Get(UIServantMainTipsPanel.GetCloseBtn_GameObject()).onClick = UIServantMainTipsPanel.CloseBtnClick
end

function UIServantMainTipsPanel:InitIEnum()
    if (self.IEnumTime == nil) then
        self.IEnumTime = StartCoroutine(UIServantMainTipsPanel.IEnumTimeFun, CS.Cfg_GlobalTableManager.Instance.ServantPushTime)
    end
end

function UIServantMainTipsPanel.IEnumTimeFun(time)
    local meetTime = true
    local totalTime = time * 0.001
    while meetTime do
        if totalTime <= 0 then
            meetTime = false
            if (UIServantMainTipsPanel.IEnumTime ~= nil) then
                StopCoroutine(UIServantMainTipsPanel.IEnumTime)
                UIServantMainTipsPanel.IEnumTime = nil
            end
            uimanager:ClosePanel("UIServantMainTipsPanel")
        end
        coroutine.yield(CS.NGUIAssist.GetWaitForSeconds(1))
        totalTime = totalTime - 1
    end
end

function UIServantMainTipsPanel.CloseBtnClick()
    uimanager:ClosePanel("UIServantMainTipsPanel")
end

function ondestroy()
    if (UIServantMainTipsPanel.IEnumTime ~= nil) then
        StopCoroutine(UIServantMainTipsPanel.IEnumTime)
        UIServantMainTipsPanel.IEnumTime = nil
    end
end

return UIServantMainTipsPanel