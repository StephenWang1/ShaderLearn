---@class UIAuctionPushPanel:UIBase 拍卖行推送面板
local UIAuctionPushPanel = {}

--region 局部变量定义
---界面模板
---@type UIAuctionPushPanel_RootTemplate
UIAuctionPushPanel.panelTemplate = nil
--endregion

--region 组件
---关闭按钮
function UIAuctionPushPanel.GetCloseButton_GameObject()
    if UIAuctionPushPanel.mCloseButton == nil then
        UIAuctionPushPanel.mCloseButton = UIAuctionPushPanel:GetCurComp("WidgetRoot/event/CloseBtn", "GameObject")
    end
    return UIAuctionPushPanel.mCloseButton
end

---绑定模板的obj
function UIAuctionPushPanel.GetTemp_GameObject()
    if UIAuctionPushPanel.mTempObj == nil then
        UIAuctionPushPanel.mTempObj = UIAuctionPushPanel:GetCurComp("WidgetRoot/view", "GameObject")
    end
    return UIAuctionPushPanel.mTempObj
end
--endregion

--region 初始化
function UIAuctionPushPanel:Init()
    self:BindEvents()
end

function UIAuctionPushPanel:Show(cutomData)
    if cutomData then
        if cutomData.mPushType == LuaEnumAuctionPushType.GuessLikePush then
            ---@type  auctionV2.pushResponse
            local csData = cutomData.mNormalPushData
            ---@type UIAuctionPushPanel_ShelvesPushTemplate
            local template = luaComponentTemplates.UIAuctionPushPanel_ShelvesPushTemplate
            if csData.PushType == Utility.EnumToInt(CS.auctionV2.PushType.BUYPUSH) then
                ---@type UIAuctionPushPanel_BuyingPushTemplate
                template = luaComponentTemplates.UIAuctionPushPanel_BuyingPushTemplate
            end
            self.panelTemplate = templatemanager.GetNewTemplate(UIAuctionPushPanel.GetTemp_GameObject(), template, csData)
        elseif cutomData.mPushType == LuaEnumAuctionPushType.PlayerTradePush then
            ---@type  auctionV2.AuctionPush
            local csData = cutomData.mNormalPushData
            ---@type UIAuctionPushPanel_PlayerTradePushTemplate
            local template = luaComponentTemplates.UIAuctionPushPanel_PlayerTradePushTemplate
            self.PushItemType = csData.type
            self.panelTemplate = templatemanager.GetNewTemplate(UIAuctionPushPanel.GetTemp_GameObject(), template, csData)
        end
    else
        self:ClosePanel()
    end
end

function UIAuctionPushPanel:BindEvents()
    CS.UIEventListener.Get(UIAuctionPushPanel.GetCloseButton_GameObject()).onClick = function()
        self:ClosePanel()
    end
end
--endregion

---关闭界面相关处理
function UIAuctionPushPanel:ClosePanelDeal()
    if self.panelTemplate and self.panelTemplate:NeedShowToggle() then
        if self.panelTemplate.mToggleValue_UIToggle.value and self.PushItemType then
            networkRequest.ReqCurLoginNoPush(self.PushItemType)
        end
    end
end

function ondestroy()
    UIAuctionPushPanel:ClosePanelDeal()
end

return UIAuctionPushPanel