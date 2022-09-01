local UIWarehouseTipsPanel = {}

---开服天数限制
UIWarehouseTipsPanel.limitOpenDays = nil
---角色等级限制
UIWarehouseTipsPanel.limitRoleLevel = nil
---背包
UIWarehouseTipsPanel.mBagPanel = nil
---仓库界面
UIWarehouseTipsPanel.mWarehousePanel = nil
---仓库打捆界面
UIWarehouseTipsPanel.mBundlePanel = nil

---关闭按钮
function UIWarehouseTipsPanel.GetCloseButton_GameObject()
    if UIWarehouseTipsPanel.mCloseButton == nil then
        UIWarehouseTipsPanel.mCloseButton = UIWarehouseTipsPanel:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    end
    return UIWarehouseTipsPanel.mCloseButton
end

---仓库服务
function UIWarehouseTipsPanel.GetServiceButton_GameObject()
    if UIWarehouseTipsPanel.mServiceButton == nil then
        UIWarehouseTipsPanel.mServiceButton = UIWarehouseTipsPanel:GetCurComp("WidgetRoot/event/btn_service", "GameObject")
    end
    return UIWarehouseTipsPanel.mServiceButton
end

---仓库打捆
function UIWarehouseTipsPanel.GetBundleButton_GameObject()
    if UIWarehouseTipsPanel.mBundleButton == nil then
        UIWarehouseTipsPanel.mBundleButton = UIWarehouseTipsPanel:GetCurComp("WidgetRoot/event/btn_budling", "GameObject")
    end
    return UIWarehouseTipsPanel.mBundleButton
end

function UIWarehouseTipsPanel:Init()
    UIWarehouseTipsPanel.InitData()
    UIWarehouseTipsPanel.BindEvent()
end

function UIWarehouseTipsPanel.BindEvent()
    CS.UIEventListener.Get(UIWarehouseTipsPanel.GetCloseButton_GameObject()).onClick = UIWarehouseTipsPanel.OnCloseButtonClicked
    CS.UIEventListener.Get(UIWarehouseTipsPanel.GetServiceButton_GameObject()).onClick = UIWarehouseTipsPanel.OnServiceButtonClicked
    CS.UIEventListener.Get(UIWarehouseTipsPanel.GetBundleButton_GameObject()).onClick = UIWarehouseTipsPanel.OnBundleButtonClicked
    UIWarehouseTipsPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIWarehouseTipsPanel.OnMainPlayerBeginWalkMsg)
    UIWarehouseTipsPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.MainChatPanel_BtnBag, UIWarehouseTipsPanel.OnMainChatPanelBagBtnClicked)
end

function UIWarehouseTipsPanel.InitData()
    UIWarehouseTipsPanel.limitOpenDays, UIWarehouseTipsPanel.limitRoleLevel = CS.Cfg_GlobalTableManager.Instance:GetOpenStorageCondition()
end

---聊天主界面背包按钮点击事件
function UIWarehouseTipsPanel.OnMainChatPanelBagBtnClicked()
    if uimanager:GetPanel("UIPlayerWarehousePanel") ~= nil or uimanager:GetPanel("UIWarehouseBundleUpPanel") ~= nil then
        return
    end
    UIWarehouseTipsPanel.mIsClosedByMainChatBtnBag = true
    uimanager:ClosePanel("UIWarehouseTipsPanel")
    uimanager:CreatePanel("UIBagPanel", nil, { type = LuaEnumBagType.Normal })
end

---判断仓库功能是否可开启
function UIWarehouseTipsPanel.IsOpenStorageAvailable()
    if UIWarehouseTipsPanel.limitRoleLevel and UIWarehouseTipsPanel.limitOpenDays then
        local isOpenDaysArrive = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(UIWarehouseTipsPanel.limitOpenDays)
        if not isOpenDaysArrive then
            CS.Utility.ShowTips("开服时间不足，无法开启")
            return false
        end
        local isLevelArrive = CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(UIWarehouseTipsPanel.limitRoleLevel)
        if not isLevelArrive then
            CS.Utility.ShowTips("角色等级不足，无法开启")
            return false
        end
        return true
    end
    return false
end

---关闭界面
function UIWarehouseTipsPanel.OnCloseButtonClicked()
    uimanager:ClosePanel('UIWarehouseTipsPanel')
    luaEventManager.DoCallback(LuaCEvent.CloseStorage)
end

---仓库服务
function UIWarehouseTipsPanel.OnServiceButtonClicked()
    UIWarehouseTipsPanel.OpenWarehousePanel()
end

---仓库打捆
function UIWarehouseTipsPanel.OnBundleButtonClicked()
    UIWarehouseTipsPanel.OpenBundlePanel()
end

---主角移动事件,关闭界面
function UIWarehouseTipsPanel.OnMainPlayerBeginWalkMsg(id, data)
    UIWarehouseTipsPanel.OnCloseButtonClicked()
end

---打捆界面打开事件
function UIWarehouseTipsPanel.OnBundlePanelOpened(panel)
    UIWarehouseTipsPanel.mBundlePanel = panel
end

---仓库界面打开事件
function UIWarehouseTipsPanel.OnWarehousePanelOpened(panel)
    UIWarehouseTipsPanel.mWarehousePanel = panel
end

---打开打捆界面
function UIWarehouseTipsPanel.OpenBundlePanel()
    if UIWarehouseTipsPanel.IsOpenStorageAvailable() then
        if UIWarehouseTipsPanel.mWarehousePanel ~= nil then
            uimanager:ClosePanel(UIWarehouseTipsPanel.mWarehousePanel)
            UIWarehouseTipsPanel.mWarehousePanel = nil
        end
        uimanager:CreatePanel("UIWarehouseBundleUpPanel", UIWarehouseTipsPanel.OnBundlePanelOpened)
    end
end

---打开仓库界面
function UIWarehouseTipsPanel.OpenWarehousePanel()
    if UIWarehouseTipsPanel.IsOpenStorageAvailable() then
        local StorageGrid = CS.CSScene.MainPlayerInfo.Storage.MaxStorageGrid
        if StorageGrid == 0 then
            networkRequest.ReqStorageInfo()
        end
        if UIWarehouseTipsPanel.mBundlePanel ~= nil then
            uimanager:ClosePanel(UIWarehouseTipsPanel.mBundlePanel)
            UIWarehouseTipsPanel.mBundlePanel = nil
        end
        uimanager:CreatePanel("UIPlayerWarehousePanel", UIWarehouseTipsPanel.OnWarehousePanelOpened)
    end
end

function ondestroy()
    if UIWarehouseTipsPanel.mIsClosedByMainChatBtnBag ~= true then
        uimanager:ClosePanel("UIBagPanel")
    end
    --luaEventManager.RemoveCallback(LuaCEvent.MainChatPanel_BtnBag, UIWarehouseTipsPanel.OnMainChatPanelBagBtnClicked)
    if UIWarehouseTipsPanel.mBundlePanel then
        uimanager:ClosePanel(UIWarehouseTipsPanel.mBundlePanel)
        UIWarehouseTipsPanel.mBundlePanel = nil
    end
    if UIWarehouseTipsPanel.mWarehousePanel then
        uimanager:ClosePanel(UIWarehouseTipsPanel.mWarehousePanel)
        UIWarehouseTipsPanel.mWarehousePanel = nil
    end
end

return UIWarehouseTipsPanel