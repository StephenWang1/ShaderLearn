local UIHuanJingMiGongPanel = {}

--region 变量
UIHuanJingMiGongPanel.GridToItemDic = {}
--endregion

--region  组件
function UIHuanJingMiGongPanel.GetCloseBtn_GameObject()
    if (UIHuanJingMiGongPanel.mCloseBtn == nil) then
        UIHuanJingMiGongPanel.mCloseBtn = UIHuanJingMiGongPanel:GetCurComp("WidgetRoot/CloseBtn", "GameObject")
    end
    return UIHuanJingMiGongPanel.mCloseBtn
end

function UIHuanJingMiGongPanel.GetEnterBtn_GameObject()
    if (UIHuanJingMiGongPanel.mEnterBtn == nil) then
        UIHuanJingMiGongPanel.mEnterBtn = UIHuanJingMiGongPanel:GetCurComp("WidgetRoot/EnterBtn", "GameObject")
    end
    return UIHuanJingMiGongPanel.mEnterBtn
end

function UIHuanJingMiGongPanel.GetAward_UIGridContainer()
    if (UIHuanJingMiGongPanel.mAwardGridContainer == nil) then
        UIHuanJingMiGongPanel.mAwardGridContainer = UIHuanJingMiGongPanel:GetCurComp("WidgetRoot/Awards", "Top_UIGridContainer")
    end
    return UIHuanJingMiGongPanel.mAwardGridContainer
end
--endregion

--region 初始化
function UIHuanJingMiGongPanel:Init()
    self:BindMessage()
    self:BindUIEvents()
end

function UIHuanJingMiGongPanel:BindMessage()

end

function UIHuanJingMiGongPanel:BindUIEvents()
    CS.UIEventListener.Get(UIHuanJingMiGongPanel.GetCloseBtn_GameObject()).onClick = UIHuanJingMiGongPanel.CloseBtnOnClick
    CS.UIEventListener.Get(UIHuanJingMiGongPanel.GetEnterBtn_GameObject()).onClick = UIHuanJingMiGongPanel.EnterBtnOnClick
end

function UIHuanJingMiGongPanel:Show()
    UIHuanJingMiGongPanel.RefreshPanelAward()
end
--endregion

--region 客户端事件
function UIHuanJingMiGongPanel.EnterBtnOnClick()
    networkRequest.ReqEnterDuplicate(9901)
end

function UIHuanJingMiGongPanel.CloseBtnOnClick()
    uimanager:ClosePanel("UIHuanJingMiGongPanel")
end
--endregion

--region 界面刷新
function UIHuanJingMiGongPanel.RefreshPanelAward()
    local list = CS.Cfg_GlobalTableManager.Instance.MazeItemList
    local count = list.Count
    UIHuanJingMiGongPanel.GetAward_UIGridContainer().MaxCount = count
    for i = 0, count - 1 do
        local bagItemInfo = CS.Utility_Lua.ReverseItemInfo(tostring(list[i + 1]))
        local iteminfo = nil
        if bagItemInfo ~= nil then
            local itemInfoIsFind, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(bagItemInfo.itemId)
            if itemInfoIsFind then
                iteminfo = itemInfo
            end
            if (UIHuanJingMiGongPanel.GridToItemDic[UIHuanJingMiGongPanel.GetAward_UIGridContainer().controlList[i]] == nil) then
                UIHuanJingMiGongPanel.GridToItemDic[UIHuanJingMiGongPanel.GetAward_UIGridContainer().controlList[i]] = templatemanager.GetNewTemplate(
                        UIHuanJingMiGongPanel.GetAward_UIGridContainer().controlList[i], luaComponentTemplates.UIGridItem)
            end
            UIHuanJingMiGongPanel.GridToItemDic[UIHuanJingMiGongPanel.GetAward_UIGridContainer().controlList[i]]:RefreshUIWithItemInfo(iteminfo, bagItemInfo.count)
            UIHuanJingMiGongPanel.GridToItemDic[UIHuanJingMiGongPanel.GetAward_UIGridContainer().controlList[i]].bagItemInfo = bagItemInfo
            CS.UIEventListener.Get(UIHuanJingMiGongPanel.GetAward_UIGridContainer().controlList[i].gameObject).onClick = UIHuanJingMiGongPanel.OnCheckItemClicked
        else
            UIHuanJingMiGongPanel.GetAward_UIGridContainer().MaxCount = 0
        end
    end
end
--endregion
return UIHuanJingMiGongPanel