---个人竞拍出售总列表格子模板
---@class UIAuctionPanel_SelfAuctionGridTemplate
local UIAuctionPanel_SelfAuctionGridTemplate = {}

function UIAuctionPanel_SelfAuctionGridTemplate:Init()
    self:InitComponent()
    self:BindEvents()
end

function UIAuctionPanel_SelfAuctionGridTemplate:InitComponent()
    self.add_GameObject = self:Get("add", "GameObject")
    self.BG_UISprite = self:Get("backFrame", "UISprite")
    self.Item_GameObject = self:Get("Item", "GameObject")
    --region Item
    self.icon_UISprite = self:Get("Item/icon", "UISprite")
    self.count_UILabel = self:Get("Item/count", "UILabel")
    self.name_UILabel = self:Get("Item/name", "UILabel")
    self.strength_UILabel = self:Get("Item/strengthen", "UILabel")
    ---@type UISprite
    self.star_UISprite = self:Get("Item/star", "UISprite")
    self.icon_GameObject = self:Get("Item/icon", "GameObject")
    ---@type UnityEngine.GameObject
    self.bloodSuitSignGO = self:Get("Item/BloodLv", "GameObject")
    ---@type UILabel
    self.bloodSuitLabel = self:Get("Item/BloodLvLabel", "UILabel")
    --endregion

    ---@type UIGridContainer
    ---价格container
    self.priceContainer_UIGridContainer = self:Get("Item/Price/Gird", "UIGridContainer")

    --region 下架
    ---时间显示
    self.timeShow_UILabel = self:Get("Item/des", "UILabel")
    self.removeBtn_GameObject = self:Get("Item/Obtained", "GameObject")
    ---@type UICountdownLabel
    self.timeCount_CountDownTimeLabel = self:Get("Item/des", "UICountdownLabel")

    ---@type UnityEngine.GameObject 审核中文本
    self.mTimeCountDes2 = self:Get("Item/des2", "GameObject")
    --endregion
end

function UIAuctionPanel_SelfAuctionGridTemplate:BindEvents()
    CS.UIEventListener.Get(self.icon_GameObject).onClick = function()
        self:OnRemoveBtnClicked()
    end
    CS.UIEventListener.Get(self.removeBtn_GameObject).onClick = function()
        self:OnRemoveBtnClicked()
    end
end

---刷新显示信息
---@param auctionInfo auctionV2.AuctionItemInfo
function UIAuctionPanel_SelfAuctionGridTemplate:RefreshItem(auctionInfo)
    self.isExpire = false
    self.AuctionInfo = auctionInfo
    self.add_GameObject:SetActive(self.AuctionInfo == nil)
    self.Item_GameObject:SetActive(self.AuctionInfo ~= nil)
    if auctionInfo then
        if auctionInfo.item then
            self.BagItemInfo = auctionInfo.item
            if self.BagItemInfo then
                local res
                res, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
                if res and self.ItemInfo.bidPriceSection then
                    self.OncePriceMultiple = self.ItemInfo.bidPriceSection.list[4]
                end
            end
        end
        self:SetShowTime()
    else
        self.AuctionInfo = nil
        self.isExpire = false
    end
    self:SetItemShow()
    self:SetPriceShow()
end

---设置Item显示
function UIAuctionPanel_SelfAuctionGridTemplate:SetItemShow()
    if self.BagItemInfo and self.ItemInfo then
        self.icon_UISprite.spriteName = self.ItemInfo.icon
        self.name_UILabel.text = Utility.GetShortShowLabel(self.BagItemInfo.ItemFullName)
        self.count_UILabel.text = ternary(self.BagItemInfo.count == 1, "", self.BagItemInfo.count)
        local isShow = self.BagItemInfo.intensify and self.BagItemInfo.intensify > 0
        if isShow then
            local showInfo, icon = Utility.GetIntensifyShow(self.BagItemInfo.intensify)
            self.strength_UILabel.text = showInfo
            self.star_UISprite.spriteName = icon
        end
        self.strength_UILabel.gameObject:SetActive(isShow)
        self.star_UISprite.gameObject:SetActive(isShow)

        local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.BagItemInfo.itemId)
        if bloodsuitTbl and self.BagItemInfo.bloodLevel > 0 then
            self.bloodSuitSignGO:SetActive(true)
            self.bloodSuitLabel.gameObject:SetActive(true)
            self.bloodSuitLabel.text = tostring(self.BagItemInfo.bloodLevel)
        else
            self.bloodSuitSignGO:SetActive(false)
            self.bloodSuitLabel.gameObject:SetActive(false)
        end
    end
end

---设置价格显示
function UIAuctionPanel_SelfAuctionGridTemplate:SetPriceShow()
    if self.AuctionInfo then
        local coinId = self.AuctionInfo.price.itemId
        local price = self.AuctionInfo.price.count
        if self.AuctionInfo.itemType == Utility.EnumToInt(CS.auctionV2.AuctionItemType.THADED_PRODUCTS) then
            ---交易品 说明是直购
            self.priceContainer_UIGridContainer.MaxCount = 1
            local go = self.priceContainer_UIGridContainer.controlList[0]
            self:RefreshSinglePrice(go, true, self:GetItemInfo(coinId), price, "一口价")
        else
            self.priceContainer_UIGridContainer.MaxCount = 3
            if self.priceContainer_UIGridContainer.controlList.Count >= 3 and self.AuctionInfo.auctionItemLotInfo then
                local go1 = self.priceContainer_UIGridContainer.controlList[0]
                self:RefreshSinglePrice(go1, true, self:GetItemInfo(coinId), price * self.BagItemInfo.count, "起拍价")

                local go2 = self.priceContainer_UIGridContainer.controlList[1]
                local bidPrice = 0
                local auctionInfo = self.AuctionInfo.auctionItemLotInfo
                if auctionInfo then
                    bidPrice = auctionInfo.bidPrice
                end
                self:RefreshSinglePrice(go2, bidPrice ~= 0, self:GetItemInfo(coinId), bidPrice, "竞拍价")
                local go3 = self.priceContainer_UIGridContainer.controlList[2]
                self:RefreshSinglePrice(go3, true, self:GetItemInfo(coinId), self.AuctionInfo.auctionItemLotInfo.fixedPrice, "一口价")
            end
        end
    end
end

---@param go UnityEngine.GameObject
---@param isShowIcon boolean 是否显示icon
---@param coinInfo TABLE.CFG_ITEMS 货币信息
---@param price number 价格
function UIAuctionPanel_SelfAuctionGridTemplate:RefreshSinglePrice(go, isShowIcon, coinInfo, price, title)

    local icon = CS.Utility_Lua.Get(go.transform, "icon", "UISprite")
    local priceLabel = CS.Utility_Lua.Get(go.transform, "icon/price", "UILabel")
    local showLabel = CS.Utility_Lua.Get(go.transform, "des", "GameObject")
    local titleLabel = CS.Utility_Lua.Get(go.transform, "label", "UILabel")
    if coinInfo and not CS.StaticUtility.IsNull(icon) then
        icon.spriteName = coinInfo.icon
    end
    if not CS.StaticUtility.IsNull(priceLabel) then
        priceLabel.text = price
    end
    if not CS.StaticUtility.IsNull(icon) then
        icon.gameObject:SetActive(isShowIcon)
    end
    if not CS.StaticUtility .IsNull(showLabel) then
        showLabel.gameObject:SetActive(not isShowIcon)
    end
    if not CS.StaticUtility.IsNull(titleLabel) then
        titleLabel.text = title
    end
end

---@return TABLE.CFG_ITEMS 道具信息
function UIAuctionPanel_SelfAuctionGridTemplate:GetItemInfo(id)
    if self.mIdToItemInfo == nil then
        self.mIdToItemInfo = {}
    end
    local itemInfo = self.mIdToItemInfo[id]
    if itemInfo == nil then
        ___, itemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(id)
        self.mIdToItemInfo[id] = itemInfo
    end
    return itemInfo
end

---设置显示时间
function UIAuctionPanel_SelfAuctionGridTemplate:SetShowTime()
    self.timeCount_CountDownTimeLabel.gameObject:SetActive(false)
    self.mTimeCountDes2:SetActive(true)
    self.timeCount_CountDownTimeLabel:StopCountDown()
    --审核时间
    local timeDelay = self.AuctionInfo.delayTime
    if self.AuctionInfo.delayTime and CS.CSAuctionInfoV2.NotOverTime(timeDelay) and timeDelay ~= 0 then
        self.timeCount_CountDownTimeLabel:StartCountDown(nil, 5, timeDelay, "审核中(", ")", nil, function()
            self:OverDelayTime()
        end)
    else
        self:OverDelayTime()
    end
end

---审核结束回调，审核结束 倒计时公示或者到期时间
function UIAuctionPanel_SelfAuctionGridTemplate:OverDelayTime()
    self.mTimeCountDes2:SetActive(false)
    self.timeCount_CountDownTimeLabel.gameObject:SetActive(true)
    if self.AuctionInfo.auctionItemLotInfo then
        local time = self.AuctionInfo.auctionItemLotInfo.publicityTime
        --公示时间
        if self.AuctionInfo.auctionItemLotInfo.isPublicity and time ~= 0 and CS.CSAuctionInfoV2.NotOverTime(time) then
            self.timeCount_CountDownTimeLabel:StartCountDown(nil, 5, time, "(公示)", nil, nil, function()
                self:OverPublicityTime()
            end)
        else
            self:OverPublicityTime()
        end
    else
        self:OverPublicityTime()
    end
end

---公示结束回调 公示到期 倒计时到期时间
function UIAuctionPanel_SelfAuctionGridTemplate:OverPublicityTime()
    local overTime = self.AuctionInfo.overdueTime
    if overTime and overTime ~= 0 and CS.CSAuctionInfoV2.NotOverTime(overTime) then
        self.timeCount_CountDownTimeLabel:StartCountDown(nil, 5, overTime, nil, nil, nil, function()
            self:OverTime()
        end)
    else
        self:OverTime()
    end
end

---过期
function UIAuctionPanel_SelfAuctionGridTemplate:OverTime()
    self.timeShow_UILabel.text = "过期"
    self.isExpire = true
end

---事件戳转为多久前
---@return -1 过期
function UIAuctionPanel_SelfAuctionGridTemplate:TimeToOfflineTime(time)
    local desTime = time / 1000 - CS.CSServerTime.DateTimeToStamp(CS.CSServerTime.Now)
    local showTime = ""
    if desTime <= 0 then
        return -1
    elseif desTime <= 60 then
        showTime = "[8c8c8c]1分钟内"
    elseif desTime <= 3600 then
        showTime = "[8c8c8c]" .. math.modf(desTime / 60) .. "分钟"
    else
        showTime = "[8c8c8c]" .. math.modf(desTime / 3600) .. "小时"
    end
    return showTime
end

---点击头像
function UIAuctionPanel_SelfAuctionGridTemplate:OnIconClicked()
    if self.BagItemInfo and self.ItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })
    end
end

---点击下架
function UIAuctionPanel_SelfAuctionGridTemplate:OnRemoveBtnClicked()
    local data = {}
    if self.isExpire then
        ---@type UIAuctionPanel_AuctionItem_AuctionRemoveShelf
        data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionRemoveShelf
    else
        ---@type UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire
        data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_AuctionRemoveShelfDidNotExpire
    end
    data.AuctionInfo = self.AuctionInfo
    data.BagItemInfo = self.AuctionInfo.item
    uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
end

---设置背景显示
function UIAuctionPanel_SelfAuctionGridTemplate:ShowBG(isShow)
    local colorValue = ternary(isShow, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
    self.BG_UISprite.color = colorValue
end

return UIAuctionPanel_SelfAuctionGridTemplate