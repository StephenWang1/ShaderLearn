---仓库打捆界面
---@class UIWarehouseBundleUpPanel:UIBase
local UIWarehouseBundleUpPanel = {}

--region 局部变量定义
---当前兑换道具
UIWarehouseBundleUpPanel.mNewGetItem = nil
---可兑换道具列表
UIWarehouseBundleUpPanel.allExchangeItemList = nil
---兑换新道具列表
UIWarehouseBundleUpPanel.newItemList = {}
---可兑换道具列表
UIWarehouseBundleUpPanel.GridTemplateList = {}
--endregion

--region 组件
---关闭按钮
function UIWarehouseBundleUpPanel.GetCloseButton_GameObject()
    if UIWarehouseBundleUpPanel.mCloseButton == nil then
        UIWarehouseBundleUpPanel.mCloseButton = UIWarehouseBundleUpPanel:GetCurComp("WidgetRoot/panel/close_btn", "GameObject")
    end
    return UIWarehouseBundleUpPanel.mCloseButton
end

---GridContainer
function UIWarehouseBundleUpPanel.GetGridRoot_UIGridContainer()
    if UIWarehouseBundleUpPanel.mGridRoot == nil then
        UIWarehouseBundleUpPanel.mGridRoot = UIWarehouseBundleUpPanel:GetCurComp("WidgetRoot/view/ScrollView/ItemList", "UIGridContainer")
    end
    return UIWarehouseBundleUpPanel.mGridRoot
end
--endregion

--region 初始化
function UIWarehouseBundleUpPanel:Init()
    UIWarehouseBundleUpPanel.BindEvents()
    UIWarehouseBundleUpPanel.BindMessage()
    uimanager:CreatePanel('UIBagPanel', nil, { type = LuaEnumBagType.Bundle })
end

function UIWarehouseBundleUpPanel:Show()
    ---请求打捆列表
    networkRequest.ReqBundlitem()
end

function UIWarehouseBundleUpPanel.BindEvents()
    CS.UIEventListener.Get(UIWarehouseBundleUpPanel.GetCloseButton_GameObject()).onClick = UIWarehouseBundleUpPanel.OnCloseButtonClicked
end

function UIWarehouseBundleUpPanel.BindMessage()
    UIWarehouseBundleUpPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBundlitemMessage, UIWarehouseBundleUpPanel.OnResBundlitemMessageReceived)
    UIWarehouseBundleUpPanel:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResSuccessBuyBindlitemMessage, UIWarehouseBundleUpPanel.OnResResSuccessBuyBindlitemMessageReceived)
    UIWarehouseBundleUpPanel:GetLuaEventHandler():BindLuaEvent(LuaCEvent.CloseStorage, UIWarehouseBundleUpPanel.OnCloseButtonClicked)
    UIWarehouseBundleUpPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, UIWarehouseBundleUpPanel.Refresh)
    UIWarehouseBundleUpPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagItemChanged, UIWarehouseBundleUpPanel.Refresh)
    UIWarehouseBundleUpPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_MainPlayerBeginWalk, UIWarehouseBundleUpPanel.MainPlayerBeginWalk)
end
--endregion

--region 服务器消息
---收到打捆商品列表
function UIWarehouseBundleUpPanel.OnResBundlitemMessageReceived(MsgId, tblData, csData)
    if tblData and tblData.itemId then
        UIWarehouseBundleUpPanel.allExchangeItemList = tblData.itemId
        UIWarehouseBundleUpPanel.GetGridRoot_UIGridContainer().MaxCount = #tblData.itemId
        for i = 0, #tblData.itemId - 1 do
            local go = UIWarehouseBundleUpPanel.GetGridRoot_UIGridContainer().controlList[i]
            ---@type UIWarehouseBundleUpPanel_GridTemplate
            local temp = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIWarehouseBundleUpPanel_GridTemplate)
            temp:RefreshItem(tblData.itemId[i + 1], i % 2 ~= 0)
            UIWarehouseBundleUpPanel.GridTemplateList[i + 1] = temp
        end
    end
end

---收到兑换变化消息
function UIWarehouseBundleUpPanel.OnResResSuccessBuyBindlitemMessageReceived(MsgId, tblData, csData)
    if tblData and tblData.lid then
        luaEventManager.DoCallback(LuaCEvent.BundlingPitch, tblData.lid)
        UIWarehouseBundleUpPanel.Refresh()
    end
end
--endregion

function UIWarehouseBundleUpPanel.Refresh()
    for i = 1, #UIWarehouseBundleUpPanel.GridTemplateList do
        UIWarehouseBundleUpPanel.GridTemplateList[i]:SetExchangeButton()
    end
end

function UIWarehouseBundleUpPanel.MainPlayerBeginWalk()
    UIWarehouseBundleUpPanel.OnCloseButtonClicked()
end

--region UI事件
---关闭界面
function UIWarehouseBundleUpPanel.OnCloseButtonClicked()
    uimanager:ClosePanel("UIWarehouseBundleUpPanel")
    uimanager:ClosePanel("UIBagPanel")
end
--endregion

--region onDestroy
function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBundlitemMessage, UIWarehouseBundleUpPanel.OnResBundlitemMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UIWarehouseBundleUpPanel.OnResBagChangeMessageReceived)
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResSuccessBuyBindlitemMessage, UIWarehouseBundleUpPanel.OnResResSuccessBuyBindlitemMessageReceived)
    --luaEventManager.RemoveCallback(LuaCEvent.CloseStorage, UIWarehouseBundleUpPanel.OnCloseButtonClicked)
end
--endregion

return UIWarehouseBundleUpPanel