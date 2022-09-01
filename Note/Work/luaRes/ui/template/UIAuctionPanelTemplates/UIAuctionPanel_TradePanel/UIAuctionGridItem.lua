---拍卖行格子物品模板
---@class UIAuctionGridItem:copytemplatebase
local UIAuctionGridItem = {}

setmetatable(UIAuctionGridItem, luaComponentTemplates.copytemplatebase)

function UIAuctionGridItem:GetPrefabGO()
    if self.RootPanel and self.mPrefabGO == nil then
        self.mPrefabGO = self.RootPanel:Get("ItemsArea/uiAuctionItemTemplate", "GameObject")
    end
    return self.mPrefabGO
end

---@param rootPanel UIAuctionPanel_TradePanel
function UIAuctionGridItem:Init(rootPanel)
    self.RootPanel = rootPanel
    self:InitComponents()
    self:InitParameters()
    self:BindEvent()
end

function UIAuctionGridItem:InitComponents()
    self.Strengthen_UILabel = "strengthen"
    ---@type UISprite
    self.ItemIcon_UISprite = "icon"
    self.ItemCount_UILabel = "count"
    self.NameText_UILabel = "name"
    self.PriceText_UILabel = "Price"
    self.ServerId_UILabel = "serverID"
    self.BloodSuitSignGO = "BloodLv"
    self.BloodSuitLabel = "BloodLvLabel"
    self.mStar = "star"
end

--region组件
---@return UnityEngine.GameObject iconGo
function UIAuctionGridItem:GetIcon_Go()
    if self.mIconGo == nil then
        self.mIconGo = self:GetUIComponentController():GetCustomType(self.ItemIcon_UISprite, "GameObject")
    end
    return self.mIconGo
end

---@return UnityEngine.GameObject 特效
function UIAuctionGridItem:GetEffect_Go()
    if self.mEffectGo == nil and not CS.StaticUtility.IsNull(self:GetIcon_Go()) then
        self.mEffectGo = CS.Utility_Lua.Get(self:GetIcon_Go().transform, "CheckMark", "GameObject")
    end
    return self.mEffectGo
end

---@return UnityEngine.GameObject 更好
function UIAuctionGridItem:GetGood_UISprite()
    if self.mGoodGo == nil and not CS.StaticUtility.IsNull(self:GetIcon_Go()) then
        self.mGoodGo = CS.Utility_Lua.Get(self:GetIcon_Go().transform, "good", "UISprite")
    end
    return self.mGoodGo
end

---@return UnityEngine.GameObject 价格
function UIAuctionGridItem:GetPriceText_Go()
    if self.mPriceTextGo == nil then
        self.mPriceTextGo = self:GetUIComponentController():GetCustomType(self.PriceText_UILabel, "GameObject")
    end
    return self.mPriceTextGo
end

---@return UISprite 价格sp
function UIAuctionGridItem:GetPriceSprite_UISprite()
    if self.mPriceSprite == nil and not CS.StaticUtility.IsNull(self:GetPriceText_Go()) then
        self.mPriceSprite = CS.Utility_Lua.Get(self:GetPriceText_Go().transform, "ingotSymbol", "UISprite")
    end
    return self.mPriceSprite
end
--endregion

function UIAuctionGridItem:InitParameters()
    ---背包物品信息,bagV2.BagItemInfo类型
    ---@type bagV2.BagItemInfo
    self.BagItemInfo = nil
    ---物品信息,TABLE.CFG_ITEMS类型
    ---@type TABLE.CFG_ITEMS
    self.ItemInfo = nil
    ---背包物品信息,auctionV2.AuctionItemInfo类型
    ---@type auctionV2.AuctionItemInfo
    self.AuctionInfo = nil
end

function UIAuctionGridItem:BindEvent()
    self:GetUIComponentController():SetObjectActiveImmediately(self.ServerId_UILabel, false)
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnAuctionItemClicked()
    end
    CS.UIEventListener.Get(self:GetIcon_Go()).onClick = function()
        self:OnIconClicked()
    end
end

---刷新UI
---@param info auctionV2.AuctionItemInfo 背包物品信息
function UIAuctionGridItem:RefreshUI(info)
    if info ~= nil then
        self.AuctionInfo = info
        self.BagItemInfo = info.item
        local res = false
        res, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
        --若Item表中有该物品,根据Item表和背包物品信息设置物品显示
        if res then
            --region 设置物品Icon
            self:GetUIComponentController():SetObjectActive(self.ItemIcon_UISprite, true)
            self:GetUIComponentController():SetSpriteName(self.ItemIcon_UISprite, self.ItemInfo.icon)
            local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.BagItemInfo.itemId)
            if bloodsuitTbl and self.BagItemInfo.bloodLevel > 0 then
                self:GetUIComponentController():SetObjectActive(self.BloodSuitSignGO, true)
                self:GetUIComponentController():SetObjectActive(self.BloodSuitLabel, true)
                self:GetUIComponentController():SetLabelContent(self.BloodSuitLabel, tostring(self.BagItemInfo.bloodLevel))
            else
                self:GetUIComponentController():SetObjectActive(self.BloodSuitSignGO, false)
                self:GetUIComponentController():SetObjectActive(self.BloodSuitLabel, false)
            end
            --endregion

            --region 设置物品数量
            self:GetUIComponentController():SetObjectActive(self.ItemCount_UILabel, true)
            local lb = self.BagItemInfo.count > 1 and self.BagItemInfo.count or ""
            self:GetUIComponentController():SetLabelContent(self.ItemCount_UILabel, lb)
            --endregion

            self:RefreshStrengthenInfo()

            --region  设置名字
            self:GetUIComponentController():SetObjectActive(self.NameText_UILabel, true)
            local name = Utility.GetShortShowLabel(self.ItemInfo.name)
            self:GetUIComponentController():SetLabelContent(self.NameText_UILabel, name)
            --endregion

            --region 设置价格
            self:GetUIComponentController():SetObjectActive(self.PriceText_UILabel, true)
            self:GetUIComponentController():SetLabelContent(self.PriceText_UILabel, self.AuctionInfo.price.count)
            local res, priceIcon = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.AuctionInfo.price.itemId)
            if not CS.StaticUtility.IsNull(self:GetPriceSprite_UISprite()) then
                if res then
                    self:GetPriceSprite_UISprite().spriteName = priceIcon.icon
                else
                    self:GetPriceSprite_UISprite().gameObject:SetActive(false)
                end
            end

            --endregion

            --设置绿色箭头
            if not CS.StaticUtility.IsNull(self:GetGood_UISprite()) then
                local type = Utility.GetArrowType(self.BagItemInfo)
                self:GetGood_UISprite().gameObject:SetActive(type ~= LuaEnumArrowType.NONE)
                if type ~= LuaEnumArrowType.NONE then
                    self:GetGood_UISprite().spriteName = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(type)
                end
            end
        else
            luaDebug.LogError("Item未找到" .. tostring(self.BagItemInfo.itemId))
        end

        local lb = info.serverId == nil and 0 or info.serverId
        self:GetUIComponentController():SetLabelContent(self.ServerId_UILabel, lb)
        self:GetUIComponentController():Apply()
    end
end

---点击格子
function UIAuctionGridItem:OnAuctionItemClicked()
    if self.AuctionInfo then
        local data = {}
        data.AuctionInfo = self.AuctionInfo
        data.BagItemInfo = self.AuctionInfo.item
        data.AuctionPanel = self.RootPanel.AuctionPanel

        if self.AuctionInfo.price.itemId == LuaEnumCoinType.YuanBao then
            ---@type UIAuctionPanel_AuctionItem_TradeBuy 元宝
            data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeBuy
        else
            ---@type UIAuctionPanel_AuctionItem_AuctionBuy 钻石
            data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionBuy
        end
        uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
        if self.AuctionInfo.item then
            local lid = self.AuctionInfo.item.lid
            if self.RootPanel.mLidToChoose[lid] then
                self.RootPanel:SetItemChoose(lid, false)
                self.RootPanel:SetGuessLikeItemChoose(lid, false)
            end
        end
        self:SetBuyItemInfo()
    end
end

function UIAuctionGridItem:OnIconClicked()
    if self.BagItemInfo and self.ItemInfo then
        self.RootPanel.AuctionPanel.mCurrentChooseTradeItemInfo = self.AuctionInfo
        ---@type UIItemInfoPanel_AuctionTrade_RightUpOperate
        local rightUpTemplate = luaComponentTemplates.UIItemInfoPanel_AuctionTrade_RightUpOperate
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true, rightUpButtonsModule = rightUpTemplate, showMoreAssistData = true, showBtnIdTable = true })
        self:SetBuyItemInfo()
        luaEventManager.DoCallback(LuaCEvent.AuctionBuyTradeItem, 1)
    end
end

---设置强化等级
function UIAuctionGridItem:RefreshStrengthenInfo()
    local showInfo = ""
    local icon = ""
    if self.BagItemInfo.intensify > 0 then
        showInfo, icon = Utility.GetIntensifyShow(self.BagItemInfo.intensify)
    end
    self:GetUIComponentController():SetLabelContent(self.Strengthen_UILabel, showInfo)
    self:GetUIComponentController():SetObjectActive(self.Strengthen_UILabel, showInfo ~= "")
    self:GetUIComponentController():SetObjectActive(self.mStar, icon ~= "")
    self:GetUIComponentController():SetSpriteName(self.mStar, icon)
end

---重置UI
function UIAuctionGridItem:ResetUI()
    self.AuctionInfo = nil
    --region 设置物品Icon
    self:GetUIComponentController():SetObjectActive(self.ItemIcon_UISprite, false)
    self:GetUIComponentController():SetObjectActive(self.BloodSuitLabel, false)
    self:GetUIComponentController():SetObjectActive(self.BloodSuitSignGO, false)
    --endregion

    --region 设置物品数量
    self:GetUIComponentController():SetObjectActive(self.ItemCount_UILabel, false)
    --endregion

    --region 设置强化等级
    self:GetUIComponentController():SetObjectActive(self.Strengthen_UILabel, false)
    --endregion

    --设置名字
    self:GetUIComponentController():SetObjectActive(self.NameText_UILabel, false)
    --设置价格
    self:GetUIComponentController():SetObjectActive(self.PriceText_UILabel, false)
    self:ShowBG(false)
    self:GetUIComponentController():SetLabelContent(self.ServerId_UILabel, 0)
    self:GetUIComponentController():Apply()
end

function UIAuctionGridItem:SetItemChoose(isChoose)
    if not CS.StaticUtility.IsNull(self:GetEffect_Go()) then
        self:GetEffect_Go():SetActive(isChoose)
    end
end

---设置可能购买道具信息
function UIAuctionGridItem:SetBuyItemInfo()
    if self.RootPanel and self.RootPanel.AuctionPanel and self.ItemInfo then
        self.RootPanel.AuctionPanel.mTradeItemID = self.ItemInfo.id
        self.RootPanel.AuctionPanel.mTradeItemPos = self:GetIcon_Go().gameObject.transform.position
        self.RootPanel.AuctionPanel:SaveCurrentBagGridCount(self.ItemInfo.id)
    end
end

return UIAuctionGridItem
