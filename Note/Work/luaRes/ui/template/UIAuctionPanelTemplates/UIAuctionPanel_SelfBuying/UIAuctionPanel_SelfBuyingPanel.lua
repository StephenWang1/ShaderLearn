---拍卖行个人求购界面
---@class UIAuctionPanel_SelfBuyingPanel
local UIAuctionPanel_SelfBuyingPanel = {}

UIAuctionPanel_SelfBuyingPanel.isExpire = nil
--region 初始化
---@param auctionPanel UIAuctionPanel
function UIAuctionPanel_SelfBuyingPanel:Init(auctionPanel)
    self.AuctionPanel = auctionPanel

    self.OnSelfBuyingResGetAuctionShelfMessageReceived = function(msgID, tblData, csData)
        self:RefreshSelfAuctionList(msgID, tblData, csData)
    end
    self.AuctionPanel:GetClientEventHandler():AddEvent(CS.CEvent.V2_AuctionBuyingInfoChange, self.OnSelfBuyingResGetAuctionShelfMessageReceived)

    self:InitComponent()
    self:BindTemplate()
    self:InitEvents()
end

function UIAuctionPanel_SelfBuyingPanel:OnEnable()
    --请求消息
    networkRequest.ReqGetAuctionShelf(Utility.EnumToInt(CS.auctionV2.AuctionItemType.BUY_PRODUCTS))
end

function UIAuctionPanel_SelfBuyingPanel:InitComponent()
    self.mBackButton_GameObject = self:Get("BackBtn", "GameObject")
    self.mSelfBuyingList_GameObject = self:Get("List", "GameObject")
    self.mBuyingType_GameObject = self:Get("Choose", "GameObject")
end

function UIAuctionPanel_SelfBuyingPanel:BindTemplate()
    ---@type UIAuctionPanel_SelfBuying_BagPanel
    self.BuyingMenuTemplate = templatemanager.GetNewTemplate(self.mBuyingType_GameObject, luaComponentTemplates.UIAuctionPanel_SelfBuying_BagPanel)
end

function UIAuctionPanel_SelfBuyingPanel:InitEvents()
    CS.UIEventListener.Get(self.mBackButton_GameObject).onClick = function()
        self:OnBackButtonClicked()
    end
end
--endregion

--region 属性
---@return UIAuctionPanel_SelfBuyingListTemplate
function UIAuctionPanel_SelfBuyingPanel:GetBuyingListTemplate()
    if self.BuyingListTemplate == nil then
        self.BuyingListTemplate = templatemanager.GetNewTemplate(self.mSelfBuyingList_GameObject, luaComponentTemplates.UIAuctionPanel_SelfBuyingListTemplate, self)
    end
    return self.BuyingListTemplate
end
--endregion

--region 服务器消息
---刷新个人求购列表
function UIAuctionPanel_SelfBuyingPanel:RefreshSelfAuctionList()
    self:GetBuyingListTemplate():RefreshGridShow()
end
--endregion

--region 事件
function UIAuctionPanel_SelfBuyingPanel:OnBackButtonClicked()
    if self.AuctionPanel and self.AuctionPanel.SwitchToBuyingPanel then
        self.AuctionPanel:SwitchToBuyingPanel()
    end
end

--endregion

return UIAuctionPanel_SelfBuyingPanel