---拍卖行竞拍上架Tips
local UIAuctionSellDialog = {}

--region组件
---模板节点
function UIAuctionSellDialog.GetRoot_GameObject()
    if UIAuctionSellDialog.mRoot == nil then
        UIAuctionSellDialog.mRoot = UIAuctionSellDialog:GetCurComp("WidgetRoot/view", "GameObject")
    end
    return UIAuctionSellDialog.mRoot
end

---关闭按钮
function UIAuctionSellDialog.GetCloseButton_GameObject()
    if UIAuctionSellDialog.mCloseButton == nil then
        UIAuctionSellDialog.mCloseButton = UIAuctionSellDialog:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    end
    return UIAuctionSellDialog.mCloseButton
end

--endregion
function UIAuctionSellDialog:Init()
    UIAuctionSellDialog.BindEvents()
end

--region 初始化
---@param customData.Template 模板（非必须）
---@param customData.BagItemInfo 物品信息(必须)
function UIAuctionSellDialog:Show(customData)
    if customData and customData.BagItemInfo then
        ---@type UIAuctionPanel_AuctionTipsTemplate
        local template = luaComponentTemplates.UIAuctionPanel_AuctionTipsTemplate
        if customData.Template then
            template = customData.Template
        end
        UIAuctionSellDialog.Template = templatemanager.GetNewTemplate(UIAuctionSellDialog.GetRoot_GameObject(), template, customData)
    end
end

function UIAuctionSellDialog.BindEvents()
    CS.UIEventListener.Get(UIAuctionSellDialog.GetCloseButton_GameObject()).onClick = UIAuctionSellDialog.OnCloseButtonClicked
end

--endregion

--region UI事件
function UIAuctionSellDialog.OnCloseButtonClicked()
    uimanager:ClosePanel("UIAuctionSellDialog")
end
--endregion

return UIAuctionSellDialog