---@class UIWayGetQuickAuctionBuyTemplate:TemplateBase
local UIWayGetQuickAuctionBuyTemplate = {}

--region 组件
---@return UnityEngine.GameObject
function UIWayGetQuickAuctionBuyTemplate:GetItemGo()
    if self.mItemGo == nil then
        self.mItemGo = self:Get("widget/item", "GameObject")
    end
    return self.mItemGo
end

---@return UISprite
function UIWayGetQuickAuctionBuyTemplate:GetIconSprite()
    if self.mIconSprite == nil then
        self.mIconSprite = self:Get("widget/item/icon", "UISprite")
    end
    return self.mIconSprite
end

---@return UILabel
function UIWayGetQuickAuctionBuyTemplate:GetItemCountLabel()
    if self.mItemCountLabel == nil then
        self.mItemCountLabel = self:Get("widget/item/count", 'UILabel')
    end
    return self.mItemCountLabel
end

---@return UILabel
function UIWayGetQuickAuctionBuyTemplate:GetNameLabel()
    if self.mNameLabel == nil then
        self.mNameLabel = self:Get("widget/item/name", 'UILabel')
    end
    return self.mNameLabel
end

---@return UILabel
function UIWayGetQuickAuctionBuyTemplate:GetStrengthenLabel()
    if self.mStrengthenLabel == nil then
        self.mStrengthenLabel = self:Get("widget/item/strengthen", "UILabel")
    end
    return self.mStrengthenLabel
end

---@return UnityEngine.GameObject
function UIWayGetQuickAuctionBuyTemplate:GetOriginPriceGo()
    if self.mOriginPriceGo == nil then
        self.mOriginPriceGo = self:Get("widget/originalprice", "GameObject")
    end
    return self.mOriginPriceGo
end

---@return UISprite
function UIWayGetQuickAuctionBuyTemplate:GetPriceItemIconSprite()
    if self.mPriceItemIconSprite == nil then
        self.mPriceItemIconSprite = self:Get("widget/price/type", "UISprite")
    end
    return self.mPriceItemIconSprite
end

---@return UILabel
function UIWayGetQuickAuctionBuyTemplate:GetPriceItemValueLabel()
    if self.mPriceItemValueLabel == nil then
        self.mPriceItemValueLabel = self:Get("widget/price/value", 'UILabel')
    end
    return self.mPriceItemValueLabel
end

---@return UnityEngine.GameObject
function UIWayGetQuickAuctionBuyTemplate:GetLimitNumGo()
    if self.mLimitNumGo == nil then
        self.mLimitNumGo = self:Get("widget/limitNum", "GameObject")
    end
    return self.mLimitNumGo
end

---@return UnityEngine.GameObject
function UIWayGetQuickAuctionBuyTemplate:GetBuyButton()
    if self.mBuyButton == nil then
        self.mBuyButton = self:Get("widget/btn_buy", "GameObject")
    end
    return self.mBuyButton
end
--endregion

---@param ownerPanel UIBase
function UIWayGetQuickAuctionBuyTemplate:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
    CS.UIEventListener.Get(self:GetBuyButton()).onClick = function(go)
        self:OnBuyButtonClicked(go)
    end
    CS.UIEventListener.Get(self:GetItemGo()).onClick = function()
        ---占位,以保证点击时有blingbling的特效...
    end
end

function UIWayGetQuickAuctionBuyTemplate:BindBuyButtonClickCallBack(callback)
    self.mClickCallBack = callback
end

---@param data auctionV2.AuctionItemInfo
function UIWayGetQuickAuctionBuyTemplate:Update(data)
    self.mAuctionItemInfo = data
    ---@type boolean 是否被点击过
    self.mIsRequestedBuy = false
    if data == nil then
        self:ResetUI()
        return
    end
    self:RefreshUI()
end

---@private
function UIWayGetQuickAuctionBuyTemplate:ResetUI()
    self:GetIconSprite().spriteName = ""
    self:GetPriceItemIconSprite().spriteName = ""
    self:GetPriceItemValueLabel().text = ""
    self:GetLimitNumGo():SetActive(false)
    self:GetBuyButton():SetActive(false)
    self:GetStrengthenLabel().text = ""
    self:GetItemCountLabel().text = ""
    self:GetNameLabel().text = ""
    self:GetOriginPriceGo():SetActive(false)
end

---@private
function UIWayGetQuickAuctionBuyTemplate:RefreshUI()
    if self.mAuctionItemInfo == nil or self.mAuctionItemInfo.item == nil or self.mAuctionItemInfo.price == nil then
        return
    end
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mAuctionItemInfo.item.itemId)
    if itemTbl == nil then
        return
    end
    self:GetIconSprite().spriteName = itemTbl:GetIcon()
    self:GetItemCountLabel().text = self.mAuctionItemInfo.item.count > 1 and self.mAuctionItemInfo.item.count or ""
    self:GetNameLabel().text = itemTbl:GetName()
    local priceTbl = clientTableManager.cfg_itemsManager:TryGetValue(self.mAuctionItemInfo.price.itemId)
    if priceTbl == nil then
        return
    end
    self:GetPriceItemIconSprite().spriteName = priceTbl:GetIcon()
    ---显示单价
    self:GetPriceItemValueLabel().text = self.mAuctionItemInfo.price.count
    self:GetStrengthenLabel().text = self.mAuctionItemInfo.item.intensify > 0 and self.mAuctionItemInfo.item.intensify or ""
    self:GetLimitNumGo():SetActive(false)
    self:GetBuyButton():SetActive(true)
    self:GetOriginPriceGo():SetActive(false)
end

---购买按钮点击事件
---@private
function UIWayGetQuickAuctionBuyTemplate:OnBuyButtonClicked(go)
    if self.mAuctionItemInfo ~= nil and self.mClickCallBack ~= nil then
        local fastAuctionTbl = clientTableManager.cfg_wayget_fastauctionManager:TryGetValue(self.mAuctionItemInfo.item.itemId)
        --if false then
        if fastAuctionTbl and fastAuctionTbl:GetChooseNumber() == 1 and self.mAuctionItemInfo.itemCount > 1 then
            ---如果需要打开数量选择界面选择数量
            uimanager:CreatePanel("UIAuctionQuickBuyItemAmountPanel", nil, {
                clickCallBack = function(buyCount)
                    ---buyCount 购买数量
                    self.mClickCallBack(go, self, self.mAuctionItemInfo, buyCount)
                end,
                auctionItemInfo = self.mAuctionItemInfo,
            })
        else
            ---检查货币数量
            if self.mAuctionItemInfo.price == nil then
                return
            end
            local amountInBag = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(self.mAuctionItemInfo.price.itemId) +
                    gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetItemCount(self.mAuctionItemInfo.price.itemId)
            if amountInBag < self.mAuctionItemInfo.price.count then
                ---货币跳转到首冲或者充值界面
                if (CS.CSScene.MainPlayerInfo.BagInfo.DiamondIdList:Contains(self.mAuctionItemInfo.price.itemId)) then
                    Utility.TryShowFirstRechargePanel()
                    return
                end

                local priceItemInfoIsFind, priceItemInfo = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mAuctionItemInfo.price.itemId)
                local tipsId = 63
                local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(tipsId)
                local content = ""
                if isfind and priceItemInfoIsFind then
                    content = string.format(data.content, priceItemInfo.name)
                end
                Utility.ShowPopoTips(go.transform, content, tipsId, "UIFurnaceWayAndBuyPanel");
                return
            end
            ---检查背包容量
            if CS.CSScene.MainPlayerInfo == nil or CS.CSScene.MainPlayerInfo.BagInfo == nil then
                return
            end
            local csItemExist, csItem = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.mAuctionItemInfo.item.itemId)
            if csItem == nil then
                return
            end
            if CS.CSScene.MainPlayerInfo.BagInfo:CheckIsAbleToAddItemOfNumbers(csItem, self.mAuctionItemInfo.item.count) == false then
                Utility.ShowPopoTips(go, "背包剩余空间不足", 290, self.mOwnerPanel ~= nil and self.mOwnerPanel._PanelName or "")
                return
            end

            self.mClickCallBack(go, self, self.mAuctionItemInfo, 1)
        end
    end
end

---播放物品进入背包的动画
---@param msgData auctionV2.ItemMsg
function UIWayGetQuickAuctionBuyTemplate:PlayBuySucceedAnimation(msgData)
    self.mIsRequestedBuy = false
    if self.mAuctionItemInfo == nil or self.mAuctionItemInfo.item == nil or self.mAuctionItemInfo.item.itemId == nil then
        return
    end
    local panel = uimanager:GetPanel('UIMainChatPanel')
    if panel == nil or panel.btn_bag == nil or CS.StaticUtility.IsNull(panel.btn_bag) then
        return
    end
    luaEventManager.DoCallback(LuaCEvent.Effect_FlyItemIcon, {
        itemId = self.mAuctionItemInfo.item.itemId,
        from = self:GetIconSprite().transform.position,
        to = panel.btn_bag.transform.position })
end

return UIWayGetQuickAuctionBuyTemplate