---@class UIHighRecyclePanel_RedeemItemTemplate:UIAuctionPanel_AuctionItemTemplateBase
local UIHighRecyclePanel_RedeemItemTemplate = {}

setmetatable(UIHighRecyclePanel_RedeemItemTemplate, luaComponentTemplates.UIAuctionPanel_AuctionItemTemplateBase)

function UIHighRecyclePanel_RedeemItemTemplate:Init(data)
    self:RunBaseFunction("Init", data)
    self.mServerItem = data.mServerItem
    if self.mServerItem == nil then
        return
    end
    self.mServerItem = data.mServerItem
    self.mRedeemCallBack = data.mRedeemCallBack
    self.centerBtn_UILabel.text = "赎回"
    self.coin_UIGridContainer.MaxCount = 2
    ---@type UnityEngine.GameObject
    self.priceGO = self.coin_UIGridContainer.controlList[0]
    ---@type UnityEngine.GameObject
    self.coinGO = self.coin_UIGridContainer.controlList[1]
    self:RefreshCoins()
    self:SuitPanel()
end

function UIHighRecyclePanel_RedeemItemTemplate:Start()
    --客户端事件监听
    self.mClientEventMsg = CS.EventHandlerManager(CS.EventHandlerManager.DispatchType.Event)
    self.mClientEventMsg:AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        ---货币变化时刷新
        self:RefreshCoins()
    end)
end

function UIHighRecyclePanel_RedeemItemTemplate:OnDestroy()
    if self.mClientEventMsg ~= nil then
        self.mClientEventMsg:UnRegAll()
        self.mClientEventMsg = nil
    end
end

---刷新货币
---@private
function UIHighRecyclePanel_RedeemItemTemplate:RefreshCoins()
    ---@type TABLE.CFG_ITEMS
    local itemTable = CS.Cfg_ItemsTableManager.Instance:GetItems(self.mServerItem.configId)
    if self.mServerItem ~= nil and itemTable ~= nil and itemTable.highRecycle ~= nil and itemTable.highRecycle.list.Count >= 2 and CS.CSScene.MainPlayerInfo ~= nil then
        self.priceGO:SetActive(true)
        self.coinGO:SetActive(true)
        self.mCoinItemID = itemTable.highRecycle.list[0]
        self.mDestCoinCount = self.mServerItem.money
        self.mCurrentCoinCount = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(self.mCoinItemID)
        self:SetCoinInfo(self.priceGO, "价格", self.mCoinItemID, self.mDestCoinCount, "[dde6eb]")
        self:SetCoinInfo(self.coinGO, "拥有", self.mCoinItemID, self.mCurrentCoinCount, (self.mCurrentCoinCount >= self.mDestCoinCount) and "[dde6eb]" or "[e85038]")
        self.mIsAvailableForRedeem = self.mCurrentCoinCount >= self.mDestCoinCount
    else
        self.mCoinItemID = 0
        self.mDestCoinCount = 0
        self.mCurrentCoinCount = 0
        self.priceGO:SetActive(false)
        self.coinGO:SetActive(false)
        self.mIsAvailableForRedeem = false
    end
end

---设置货币信息
---@private
---@param go UnityEngine.GameObject
---@param titleContent string
---@param itemID number
---@param count number
---@param color string
function UIHighRecyclePanel_RedeemItemTemplate:SetCoinInfo(go, titleContent, itemID, count, color)
    if self.mCoinInfoGOCompCache == nil then
        self.mCoinInfoGOCompCache = {}
    end
    local tbl
    if self.mCoinInfoGOCompCache[go] == nil then
        tbl = {}
        tbl.titleLabel = self:GetCurComp(go, "Label", "UILabel")
        tbl.iconSprite = self:GetCurComp(go, "Sprite", "UISprite")
        tbl.countLabel = self:GetCurComp(go, "gold", "UILabel")
        self.mCoinInfoGOCompCache[go] = tbl
    else
        tbl = self.mCoinInfoGOCompCache[go]
    end
    local itemTbl = CS.Cfg_ItemsTableManager.Instance:GetItems(itemID)
    tbl.titleLabel.text = titleContent
    if itemTbl ~= nil then
        tbl.iconSprite.spriteName = itemTbl.icon
    else
        tbl.iconSprite.spriteName = ""
    end
    tbl.countLabel.text = color .. tostring(count)
end

--region 用于重写
function UIHighRecyclePanel_RedeemItemTemplate:IsNumLabelNeedSpace()
    return false
end

---@return boolean 是否显示标题
function UIHighRecyclePanel_RedeemItemTemplate:ShowTitleBtn()
    return false
end

---@return boolean 是否显示数目
function UIHighRecyclePanel_RedeemItemTemplate:ShowNum()
    return false
end

---@return number 价格行数
function UIHighRecyclePanel_RedeemItemTemplate:ShowCoin()
    return 2
end

---@return boolean 是否显示滑条
function UIHighRecyclePanel_RedeemItemTemplate:ShowSlider()
    return false
end

---@return boolean 是否是单个按钮
function UIHighRecyclePanel_RedeemItemTemplate:IsSingleBtn()
    return true
end

---@return boolean 是否显示文本
function UIHighRecyclePanel_RedeemItemTemplate:ShowLabel()
    return false
end

---@return boolean 是否显示加号
function UIHighRecyclePanel_RedeemItemTemplate:ShowAddBtn()
    return false
end

---@return boolean 是否显示减号
function UIHighRecyclePanel_RedeemItemTemplate:ShowReduceBtn()
    return false
end

---滑条改变
function UIHighRecyclePanel_RedeemItemTemplate:SliderChange(sliderValue)
end

---点击竞拍按钮(左按钮)
function UIHighRecyclePanel_RedeemItemTemplate:OnAuctionBtnClicked()
end

---点击直购按钮（右按钮）
function UIHighRecyclePanel_RedeemItemTemplate:OnBuyBtnClicked(go)
end

---用于数目变化后的处理
function UIHighRecyclePanel_RedeemItemTemplate:SetNum()
end

---公示改变
function UIHighRecyclePanel_RedeemItemTemplate:OnPublishToggleChange(value)
end

---点击上架按钮
function UIHighRecyclePanel_RedeemItemTemplate:OnShelfClicked(go)
    if self.mRedeemCallBack ~= nil then
        if self.mIsAvailableForRedeem then
            ---货币足够时
            if self.mRedeemCallBack then
                if self.mRedeemCallBack(self.mServerItem.id, self.btn_GameObject) then
                    uimanager:ClosePanel("UIAuctionItemPanel")
                end
            else
                uimanager:ClosePanel("UIAuctionItemPanel")
            end
        else
            ---货币不足时
            local EntraceType
            local LuaEnumStoreType = LuaEnumStoreType
            if (self.mCoinItemID == LuaEnumStoreType.YuanBao) then
                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.ShopIngotNotEnough
                EntraceType = LuaEnumRechargePointType.ShopPanelIngotNotEnoughToRewardGift
            elseif (self.mCoinItemID == LuaEnumStoreType.CommerceDiamond) then
                uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.CommerceShopIngotNotEngough
                EntraceType = LuaEnumRechargePointType.CommerceShopIngotNotEngoughToRewardGift
            elseif (self.mCoinItemID == LuaEnumStoreType.GoldShop) then
                EntraceType = LuaEnumRechargePointType.ShopPanelGoldNotEnoughToRewardGift
            end
            Utility.ShowItemGetWay(self.mCoinItemID, self.btn_GameObject, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(80, 0), nil, EntraceType);
        end
    end
end

---左边按钮
function UIHighRecyclePanel_RedeemItemTemplate:OnLeftClicked()
end

---右边按钮
function UIHighRecyclePanel_RedeemItemTemplate:OnRightBtnClicked()
end

---刷新标题
function UIHighRecyclePanel_RedeemItemTemplate:RefreshTitle()
    self.centerBtn_UILabel.text = "上架"
    self.leftBtn_UILabel.text = "重新上架"
    self.rightBtn_UILabel.text = "下架"
end

function UIHighRecyclePanel_RedeemItemTemplate:RefreshNumName()
    self.mNameTitle_UILabel.text = ternary(self:IsNumLabelNeedSpace(), "数     目", "数目")
end

--endregion

return UIHighRecyclePanel_RedeemItemTemplate