---竞拍格子模板
---@class UIAuctionPanel_AuctionGrid:TemplateBase
local UIAuctionPanel_AuctionGrid = {}

local Utility = Utility

---@return CSAuctionInfoV2
function UIAuctionPanel_AuctionGrid:GetAuctionInfoV2()
    if self.UIAuctionPanel_AuctionPanel then
        return self.UIAuctionPanel_AuctionPanel.AuctionPanel:GetAuctionInfoV2()
    end
end

---@return CSMainPlayerInfo
function UIAuctionPanel_AuctionGrid:GetPlayerInfo()
    if self.UIAuctionPanel_AuctionPanel then
        return self.UIAuctionPanel_AuctionPanel.AuctionPanel:GetPlayerInfo()
    end
end

---@param panel UIAuctionPanel_AuctionPanel
function UIAuctionPanel_AuctionGrid:Init(panel)
    self.UIAuctionPanel_AuctionPanel = panel
    self:InitComponent()
    self:BindEvents()
end

function UIAuctionPanel_AuctionGrid:InitComponent()
    self.Root_GameObject = self:Get("Root", "GameObject")

    --region Item
    self.icon_GameObject = self:Get("Root/icon", "GameObject")
    self.icon_UISprite = self:Get("Root/icon", "UISprite")
    self.strength_UILabel = self:Get("Root/strengthen", "UILabel")
    ---@type UISprite
    ---星星图片
    self.star_UISprite = self:Get("Root/star", "UISprite")
    self.count_UILabel = self:Get("Root/count", "UILabel")
    self.name_UILabel = self:Get("Root/name", "UILabel")
    self.BG_UISprite = self:Get("Root/backFrame", "UISprite")
    ---@type UISprite
    self.good_UISprite = self:Get("Root/icon/good", "UISprite")
    ---@type UnityEngine.GameObject
    self.bloodSuitSignGO = self:Get("Root/BloodLv", "GameObject")
    ---@type UILabel
    self.bloodSuitLevelLabel = self:Get("Root/BloodLvLabel", "UILabel")
    --endregion

    --region 时间

    ---剩余时间
    ---@type UICountdownLabel
    self.timeCount_CountDownTimeLabel = self:Get("Root/TimLabel", "UICountdownLabel")

    ---时间文字
    ---@type UILabel
    self.timeShow_UILabel = self:Get("Root/TimLabel", "UILabel")

    --endregion

    --region 当前价
    ---竞价Icon
    ---@type UISprite
    self.currentPriceIcon_UISprite = self:Get("Root/AuctionPrice/ingotSymbol", "UISprite")

    ---竞价价格
    ---@type UILabel
    self.currentPrice_UILabel = self:Get("Root/AuctionPrice", "UILabel")

    ---竞价按钮
    ---@type UnityEngine.GameObject
    self.auctionBtn_GameObject = self:Get("Root/Btn_Auction", "GameObject")

    ---竞价中文字描述
    ---@type UnityEngine.GameObject
    self.selfAuction_UILabel = self:Get("Root/Des", "UILabel")

    ---火热竞价中文字描述
    ---@type UnityEngine.GameObject
    self.selfAuctionHotDes_UILabel = self:Get("Root/HotDes", "UILabel")
    --endregion

    --region 一口价
    ---@type UISprite
    self.oncePriceIcon_UISprite = self:Get("Root/Price/ingotSymbol", "UISprite")
    self.oncePrice_UILabel = self:Get("Root/Price", "UILabel")
    self.oncePrice_GameObject = self:Get("Root/Price", "GameObject")
    self.buyBtn_GameObject = self:Get("Root/Btn_Buy", "GameObject")
    --endregion

end

function UIAuctionPanel_AuctionGrid:BindEvents()
    CS.UIEventListener.Get(self.icon_GameObject).onClick = function()
        self:OnIconClicked()
    end
    CS.UIEventListener.Get(self.auctionBtn_GameObject).onClick = function()
        self:OnAuctionClicked()
    end
    CS.UIEventListener.Get(self.buyBtn_GameObject).onClick = function()
        self:OnBuyClicked()
    end
end

---显示节点
function UIAuctionPanel_AuctionGrid:ShowRoot(isShow)
    if CS.StaticUtility.IsNull(self.Root_GameObject) == false then
        self.Root_GameObject:SetActive(isShow)
    end
end

--region 刷新基本信息
---显示基本信息
function UIAuctionPanel_AuctionGrid:ShowItem()
    if self.BagItemInfo and self.ItemInfo then
        self.icon_UISprite.spriteName = self.ItemInfo.icon
        self.name_UILabel.text = Utility.GetShortShowLabel(self.ItemInfo.name)
        self:RefreshStrengthenInfo()
        if self.BagItemInfo.count then
            self.count_UILabel.text = ternary(self.BagItemInfo.count > 1, self.BagItemInfo.count, "")
        end

        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.BagItemInfo.itemId)
        if bloodsuitTbl and self.BagItemInfo.bloodLevel > 0 then
            self.bloodSuitSignGO:SetActive(true)
            self.bloodSuitLevelLabel.gameObject:SetActive(true)
            self.bloodSuitLevelLabel.text = tostring(self.BagItemInfo.bloodLevel)
        else
            self.bloodSuitSignGO:SetActive(false)
            self.bloodSuitLevelLabel.gameObject:SetActive(false)
        end

        --设置绿色箭头
        local type = Utility.GetArrowType(self.BagItemInfo)
        self.good_UISprite.gameObject:SetActive(type ~= LuaEnumArrowType.NONE)
        if type ~= LuaEnumArrowType.NONE then
            self.good_UISprite.spriteName = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(type)
        end
    end
end

---刷新锻造信息
function UIAuctionPanel_AuctionGrid:RefreshStrengthenInfo()
    local isShow = self.BagItemInfo.intensify and self.BagItemInfo.intensify > 0
    self.strength_UILabel.gameObject:SetActive(isShow)
    self.star_UISprite.gameObject:SetActive(isShow)
    if isShow then
        local showInfo, icon = Utility.GetIntensifyShow(self.BagItemInfo.intensify)
        self.strength_UILabel.text = showInfo
        self.star_UISprite.spriteName = icon
    end
end
--endregion

---显示当前竞价
function UIAuctionPanel_AuctionGrid:ShowCurrentPrice()
    if self.AuctionInfo and self.AuctionInfo.auctionItemLotInfo then
        local num = self.AuctionInfo.item.count
        local price = self.AuctionInfo.auctionItemLotInfo.bidPrice
        local showPrice = ternary(price == 0, self.AuctionInfo.price.count * num, price)
        self.currentPrice_UILabel.text = showPrice
        self.currentPriceIcon_UISprite.spriteName = self.AuctionInfo.price.itemId
        self.currentPriceIcon_UISprite:ResetAnchors()
    end
end

---显示一口价
function UIAuctionPanel_AuctionGrid:ShowOncePrice()
    if self.AuctionInfo then
        local num = self.AuctionInfo.item.count
        local isBuy = self.AuctionInfo.itemType == Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS)
        if isBuy then
            self.oncePrice_UILabel.text = self.AuctionInfo.price.count
        else
            if self.AuctionInfo.auctionItemLotInfo ~= nil then
                self.oncePrice_UILabel.text = self.AuctionInfo.auctionItemLotInfo.fixedPrice
            end
        end
        self.oncePriceIcon_UISprite.spriteName = self.AuctionInfo.price.itemId
        self.oncePriceIcon_UISprite:ResetAnchors()
    end
end

---显示时间
function UIAuctionPanel_AuctionGrid:ShowTime()
    if self.AuctionInfo and self.AuctionInfo.auctionItemLotInfo then
        local isPublicity = self.AuctionInfo.auctionItemLotInfo.isPublicity
        local publicityTime = self.AuctionInfo.auctionItemLotInfo.publicityTime
        local isPublicityOver = true
        if self:GetAuctionInfoV2() then
            isPublicityOver = self:GetAuctionInfoV2():IsTimeOver(publicityTime)
        end
        if isPublicity and not isPublicityOver then
            self.timeCount_CountDownTimeLabel:StartCountDown(nil, 5, publicityTime, luaEnumColorType.Red, "[-]\n \n(公示期)", nil, function()
                self:OverTimeCountDown()
            end)
            return
        end
        self:OverTimeCountDown()
    end
end

---公示到期 倒计时到期时间
function UIAuctionPanel_AuctionGrid:OverTimeCountDown()
    local overTime = self.AuctionInfo.overdueTime
    local isOver = self:GetAuctionInfoV2():IsTimeOver(overTime)
    if overTime and not isOver then
        self.timeCount_CountDownTimeLabel:StartCountDown(nil, 5, overTime, luaEnumColorType.Red, nil, nil, function()
            self.timeShow_UILabel.text = "过期"
        end)
    else
        self.timeShow_UILabel.text = "过期"
    end
end

---点击头像
function UIAuctionPanel_AuctionGrid:OnIconClicked()
    if self.BagItemInfo and self.ItemInfo then
        local roleId = self:GetPlayerInfo().ID
        local isSelfAuction = roleId == self.AuctionInfo.roleId

        ---@type UIItemInfoPanel_AuctionBid_RightUpOperate
        local rightUpTemplate = luaComponentTemplates.UIItemInfoPanel_AuctionBid_RightUpOperate
        if self.isBuy then
            ---@type UIItemInfoPanel_AuctionBid_BuyRightUpOperate
            rightUpTemplate = luaComponentTemplates.UIItemInfoPanel_AuctionBid_BuyRightUpOperate
        end
        if isSelfAuction then
            rightUpTemplate = nil
        end

        self.UIAuctionPanel_AuctionPanel.AuctionPanel.mCurrentChooseAuctionItemInfo = self.AuctionInfo

        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showAssistPanel = true, rightUpButtonsModule = rightUpTemplate, showMoreAssistData = true })
        self:SetAuctionItemInfo()
        luaEventManager.DoCallback(LuaCEvent.AuctionBuyAuctionItem, 1)
    end
end

---点击竞拍
function UIAuctionPanel_AuctionGrid:OnAuctionClicked()
    local data = {}
    if self.AuctionInfo.price.itemId == LuaEnumCoinType.Diamond then
        ---@type UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi
        data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_ZuanShi
    else
        ---@type UIAuctionPanel_AuctionItem_UnionAuction_YuanBao
        data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_YuanBao
    end
    data.AuctionInfo = self.AuctionInfo
    data.BagItemInfo = self.AuctionInfo.item
    uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
end

---判断自己道具是否足够购买
function UIAuctionPanel_AuctionGrid:IsCostEnough(price)
    local isEnough = false
    if self.AuctionInfo and self.AuctionInfo.price then
        local selfCost = CS.CSScene.MainPlayerInfo.BagInfo:GetAuctionDiamondNum()
        isEnough = price <= math.ceil(selfCost)
    end
    return isEnough
end

---显示道具不足提示
function UIAuctionPanel_AuctionGrid:ShowMoneyNotEnoughTips()
    if self.CoinInfo and self.promptPanel then
        local TipsInfo = {}
        TipsInfo[LuaEnumTipConfigType.Parent] = self.promptPanel.GetRightButton_GameObject().transform
        TipsInfo[LuaEnumTipConfigType.ConfigID] = 78
        local isfind, data = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(78)
        if isfind then
            TipsInfo[LuaEnumTipConfigType.Describe] = string.format(data.content, self.CoinInfo.name)
        end
        uimanager:CreatePanel("UIBubbleTipsPanel", function(panel)
            local promptPanelLayer = self.promptPanel.GetLayer()
            self.bubblePanel = panel
            if panel.SetLayer then
                panel:SetLayer(promptPanelLayer + 2)
            end
        end, TipsInfo)
    end
end

---点击购买
function UIAuctionPanel_AuctionGrid:OnBuyClicked()
    local data = {}
    if self.AuctionInfo.price.itemId == LuaEnumCoinType.Diamond then
        ---@type UIAuctionPanel_AuctionItem_UnionAuction_DiamondOnePrice
        data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_DiamondOnePrice
    else
        ---@type UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice
        data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_UnionAuction_YuanBaoOnePrice
    end
    data.AuctionInfo = self.AuctionInfo
    data.BagItemInfo = self.AuctionInfo.item
    uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
    self:SetAuctionItemInfo()
end

---刷新显示
---@param auctionInfo auctionV2.AuctionItemInfo
---@param tblData auctionV2.AuctionItemInfo
function UIAuctionPanel_AuctionGrid:RefreshUI(auctionInfo, tblData)
    if auctionInfo then
        self.AuctionInfo = auctionInfo
        self.BagItemInfo = auctionInfo.item
        self.mTblAuctionData = tblData

        if self.BagItemInfo then
            local res
            res, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
            ___, self.CoinInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.AuctionInfo.price.itemId)
        end
        self:ShowRoot(true)
        self:ShowItem()

        --直购
        self.isBuy = auctionInfo.itemType == Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS)

        self:RefreshBtnAndLbShow()

        self:ShowTime()
        self:ShowCurrentPrice()
        self.timeCount_CountDownTimeLabel.gameObject:SetActive(not self.isBuy)
        self.currentPrice_UILabel.gameObject:SetActive(not self.isBuy)
        self:ShowOncePrice()
    end
end

---刷新文本和按钮显示
function UIAuctionPanel_AuctionGrid:RefreshBtnAndLbShow()
    if self.mTblAuctionData == nil then
        return
    end
    local state = self.mTblAuctionData.bidState
    local noOneBid = state == 0
    local hotBid = state == 1
    local isHigh = state == 2
    local higherBid = state == 3
    local des = isHigh and "本人出价最高" or ""
    local hotDes = hotBid and "火热竞价中" or (higherBid and "出价被超过" or "")
    ---自己竞价
    self.selfAuction_UILabel.text = des
    self.selfAuctionHotDes_UILabel.text = hotDes
    self.selfAuction_UILabel.gameObject:SetActive(true)
    self.selfAuctionHotDes_UILabel.gameObject:SetActive(true)

    local isPublish = self:GetPublicityState()
    local isShowAuctionBtn = (not isHigh) and (not self:IsSelfShelf()) and (not isPublish) and (not self:IsSelfBid())
    ---不是自己出售，不是自己竞价，不在公示时间
    self.auctionBtn_GameObject:SetActive(isShowAuctionBtn)

    local isShowOnePriceBtn = not self:IsSelfShelf() and not isPublish
    ---不是自己出售，不在公示时间
    self.buyBtn_GameObject:SetActive(isShowOnePriceBtn)

end

---@return boolean 是否在公示期 true公示中
function UIAuctionPanel_AuctionGrid:GetPublicityState()
    if self.AuctionInfo and self.AuctionInfo.auctionItemLotInfo then
        local isPublicity = self.AuctionInfo.auctionItemLotInfo.isPublicity
        local publicityTime = self.AuctionInfo.auctionItemLotInfo.publicityTime
        local isPublicityOver = Utility.IsTimeOverByMillisecondTimeStamp(publicityTime)
        return isPublicity and not isPublicityOver
    end
    return false
end

---@return boolean 是否是自己上架道具
function UIAuctionPanel_AuctionGrid:IsSelfShelf()
    if self.AuctionInfo then
        local selfID = self:GetPlayerInfo().ID
        return self.AuctionInfo.roleId == selfID
    end
    return false
end

---@return boolean 是否是自己竞价道具
function UIAuctionPanel_AuctionGrid:IsSelfBid()
    if self.AuctionInfo and self.AuctionInfo.auctionItemLotInfo then
        local selfID = self:GetPlayerInfo().ID
        return self.AuctionInfo.auctionItemLotInfo.bidderRid == selfID
    end
    return false
end
--endregion

---置空
function UIAuctionPanel_AuctionGrid:ResetUI()
    self:ShowRoot(false)
end

---设置即将购买道具信息
function UIAuctionPanel_AuctionGrid:SetAuctionItemInfo()
    if self.UIAuctionPanel_AuctionPanel and self.UIAuctionPanel_AuctionPanel.AuctionPanel then
        self.UIAuctionPanel_AuctionPanel.AuctionPanel.mAuctionBuyItemId = self.ItemInfo.id
        self.UIAuctionPanel_AuctionPanel.AuctionPanel.mAuctionBuyItemPos = self.icon_GameObject.transform.position
        self.UIAuctionPanel_AuctionPanel.AuctionPanel:SaveCurrentBagGridCount(self.ItemInfo.id)
    end
end

return UIAuctionPanel_AuctionGrid