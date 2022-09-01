---@class UIAuctionPanel_SelfAuctionPanel 个人竞拍界面
local UIAuctionPanel_SelfAuctionPanel = {}

---竞拍货币类型
UIAuctionPanel_SelfAuctionPanel.mCoinType = LuaEnumCoinType.Diamond

--region 初始化
---@param panel UIAuctionPanel
function UIAuctionPanel_SelfAuctionPanel:Init(panel)
    self.AuctionPanel = panel
    self:InitComponent()
    self:BindEvents()
end

---显示的时候需要请求的数据
function UIAuctionPanel_SelfAuctionPanel:ReqData()
    networkRequest.ReqGetAuctionShelf(Utility.EnumToInt(CS.auctionV2.AuctionItemType.SALF_PRODUCTS))
end

function UIAuctionPanel_SelfAuctionPanel:InitComponent()
    self.backButton_GameObject = self:Get("BackBtn", "GameObject")
    ---@type UILoopScrollViewPlus
    self.auctionContainer_UILoopScrollViewPlus = self:Get("Scroll View/AuctionSellList", "UILoopScrollViewPlus")
    ---@type UnityEngine.GameObject
    self.NoSaleItem_GO = self:Get("NoSaleItem", "GameObject")

end

function UIAuctionPanel_SelfAuctionPanel:BindEvents()
    CS.UIEventListener.Get(self.backButton_GameObject).onClick = function()
        self:OnBackButtonClicked()
    end
end

--endregion

--region 按钮事件
---返回竞拍界面
function UIAuctionPanel_SelfAuctionPanel:OnBackButtonClicked()
    if self.AuctionPanel then
        self.AuctionPanel:SwitchToAuctionPanel()
    end
end
--endregion

--region 刷新列表显示
function UIAuctionPanel_SelfAuctionPanel:RefreshListShow()
    local auctionSellInfo = CS.CSScene.MainPlayerInfo.AuctionInfo.AuctionSellInfo
    local list = self:GetShowSellInfo(auctionSellInfo)
    self:RefreshAuctionShelfTwo(list)
end

---@return number 上架最大数目
function UIAuctionPanel_SelfAuctionPanel:GetAuctionShelfMaxNum()
    if self.mAuctionShelfMaxNum == nil then
        self.mAuctionShelfMaxNum = CS.Cfg_VipTableManager.Instance:GetCurrentAuctionShelfNum(1)
    end
    return self.mAuctionShelfMaxNum
end

--region 第二版显示
--[[function UIAuctionPanel_SelfAuctionPanel:RefreshAuctionShelfTwo(list)
    self.NoSaleItem_GO:SetActive(#list == 0)
    if #list == 0 then
        self.auctionContainer_UIGridContainer.MaxCount = 0
    else
        local number = #list
        self.auctionContainer_UIGridContainer.MaxCount = number
        for i = 0, self.auctionContainer_UIGridContainer.controlList.Count - 1 do
            local go = self.auctionContainer_UIGridContainer.controlList[i]
            local template = self:GetAuctionShelfTemplate(go)
            if template then
                template:RefreshItem(list[i + 1])
            end
        end
    end
end]]

function UIAuctionPanel_SelfAuctionPanel:RefreshAuctionShelfTwo(list)
    self.NoSaleItem_GO:SetActive(#list == 0)

    self.auctionContainer_UILoopScrollViewPlus:Init(function(go, line)
        if (line < #list) then
            local template = self:GetAuctionShelfTemplate(go)
            if template then
                template:RefreshItem(list[line + 1])
            end
            return true
        else
            return false
        end
    end, nil)
end

--endregion

---@return UIAuctionPanel_SelfAuctionGridTemplate 竞拍上架模板
function UIAuctionPanel_SelfAuctionPanel:GetAuctionShelfTemplate(go)
    if self.mGoToTemplate == nil then
        self.mGoToTemplate = {}
    end
    local template = self.mGoToTemplate[go]
    if template == nil then
        template = templatemanager.GetNewTemplate(go, luaComponentTemplates.UIAuctionPanel_SelfAuctionGridTemplate)
        self.mGoToTemplate[go] = template
    end
    return template
end

--endregion

--region 服务器消息

---将字典转换成table
function UIAuctionPanel_SelfAuctionPanel:GetShowSellInfo(dic)
    local list = {}
    CS.Utility_Lua.luaForeachCsharp:Foreach(dic, function(k, v)
        table.insert(list, v)
    end)
    return list
end

---获取价格区间数据
---@param csData auctionV2.MarketPriceSection 价格区间数据
function UIAuctionPanel_SelfAuctionPanel:GetSellInfoFun(csData)
    if csData == nil or self.mCurrentChooseBagItemInfo == nil then
        return
    end
    if csData.lid == self.mCurrentChooseBagItemInfo.lid then
        local data = {}
        if csData.MarketPriceSectionType == Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.RE_ADD) then
            local isBuy = self.ReAddType == Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS)
            data.ItemState = ternary(isBuy, LuaEnumDiamondShelfType.Buy, LuaEnumDiamondShelfType.Auction)
            if isBuy then
                ---@type UIAuctionPanel_AuctionItem_AuctionReAddShelf
                data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionReAddShelf
            else
                ---@type UIAuctionItemReaddShelfController
                data.Template = luaComponentTemplates.AuctionItemReaddShelfController
            end
        elseif csData.MarketPriceSectionType == Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD) then
            ---@type UIAuctionItemAddShelfController
            data.Template = luaComponentTemplates.AuctionItemAddShelfController
            data.ItemState = LuaEnumDiamondShelfType.Auction
        end
        data.BagItemInfo = self.mCurrentChooseBagItemInfo
        data.PriceData = csData
        data.Type = luaEnumAuctionPanelType.SelfAuction
        uimanager:CreatePanel("UIAuctionItemPanel", nil, data)
    end
end
--endregion

--region 客户端事件
---拍卖行当前点击背包格子
---@param bagItemInfo bagV2.BagItemInfo
function UIAuctionPanel_SelfAuctionPanel:OnBagGridClickedFunc(msgID, bagItemInfo)
    self.mCurrentChooseBagItemInfo = bagItemInfo
    if bagItemInfo then
        networkRequest.ReqMarketPriceSection(bagItemInfo.lid, Utility.EnumToInt(CS.auctionV2.MarketPriceSectionType.ADD), Utility.EnumToInt(CS.auctionV2.AuctionItemType.SALF_PRODUCTS), 0)
    end
end

---@param auctionInfo auctionV2.AuctionItemInfo
function UIAuctionPanel_SelfAuctionPanel:OnReAddGridClickedFunc(auctionInfo)
    self.mCurrentChooseBagItemInfo = auctionInfo.item
    self.ReAddType = auctionInfo.itemType
end

--endregion

return UIAuctionPanel_SelfAuctionPanel