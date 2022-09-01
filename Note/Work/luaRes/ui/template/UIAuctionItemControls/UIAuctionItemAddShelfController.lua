---竞拍行上架控制器
---@class UIAuctionItemAddShelfController:UIAuctionItemController
local UIAuctionItemAddShelfController = {}

setmetatable(UIAuctionItemAddShelfController, luaComponentTemplates.AuctionItemController)

---初始化排版
function UIAuctionItemAddShelfController:InitializeCompose()
    --[[****************************初始化数据*****************************]]
    ---@type {Template:table,BagItemInfo:bagV2.BagItemInfo,PriceData:auctionV2.MarketPriceSection,ItemState:number}
    local data = self:GetData()
    if data == nil or data.BagItemInfo == nil then
        return
    end
    if self:IsItemCanYuanBaoDeal() or self:CanBothDeal() then
        self:SetCurrentCoinType(LuaEnumCoinType.YuanBao)
    else
        self:SetCurrentCoinType(LuaEnumCoinType.Diamond)
    end
    self:RefreshAllPart()
    self:RefreshCoin()
    self:RefreshCurrentNumber()
end

function UIAuctionItemAddShelfController:RefreshAllPart()
    --[[****************************排版并初始化组件*****************************]]
    local data = self:GetData()
    ---当前物品数量
    ---@private
    self.mCurrentNumber = 1
    ---@type TABLE.CFG_ITEMS
    local diamondTbl
    ___, diamondTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.Diamond)
    self.mDiamondTbl = diamondTbl
    ___, self.mYuanBaoTbl = CS.Cfg_ItemsTableManager.Instance:TryGetValue(LuaEnumCoinType.YuanBao)

    local isYuanBao = self:GetCurrentCoinType() == LuaEnumCoinType.YuanBao
    local coinTable = isYuanBao and self.mYuanBaoTbl or diamondTbl

    if self:CanBothDeal() then
        ---@private
        self.mTitleBtn = self:AddDoubleTitleBtns()
        self.mTitleBtn:BindEvents(function()
            self:OnLeftTitleBtnClicked()
        end, function()
            self:OnRightTitleBtnClicked()
        end)
        self.mTitleBtn:SetToggleState(isYuanBao)
    end

    self:AddSpace(10)

    ---@private
    self.mMinMaxNumberPart = self:AddNumberAndMinus()
    self.mMinMaxNumberPart:Initialize("数    目", 1, data.BagItemInfo.count, false, true, self.mCurrentNumber)
    self.mMinMaxNumberPart:BindEvents(function()
        self:OnItemCountChanged()
        self:OnQiPaiPriceValueChanged()
    end)

    self:AddSpace(10)
    ---@private
    self.mQiPaiCoinLabel = self:AddCoinInput()
    self.mQiPaiCoinLabel:Initialize("起拍价", coinTable, 0)
    self.mQiPaiCoinLabel:OpenInput(true, function(value, uiInputGo)
        self:OnSinglePriceChange(value, uiInputGo)
    end)

    self:AddSpace(13)
    ---@private
    self.mQiPaiSlider = self:AddSlider()
    self.mQiPaiSlider:Initialize(self:GetCurrentPriceData().lowPrice, self:GetCurrentPriceData().topPrice, function()
        self:OnQiPaiPriceValueChanged()
    end)

    self:AddSpace(13)
    ---@private
    self.mYiKouCoinLabel = self:AddCoinInput()
    self.mYiKouCoinLabel:Initialize("一口价", coinTable, 0)
    self.mYiKouCoinLabel:OpenInput(true, function(value, uiInputGo)
        self:OnTotalPriceChange(value, uiInputGo)
    end)

    self:AddSpace(13)
    ---一口价倍数(一口价实际数值为起拍价与该倍数的乘积)
    ---@private
    self.mYiKouSlider = self:AddSlider()
    self.mYiKouSlider:Initialize(1, self:GetOnePriceRate(isYuanBao), function()
        self:OnYiKouPriceValueChanged()
    end)

    self:AddSpace(13)
    self.mTaxCoinLabel = self:AddCoinInput()
    self.mTaxCoinLabel:Initialize("交易税", coinTable, 0)

    if self:GetCurrentCoinType() == LuaEnumCoinType.Diamond then
        self:AddSpace(10)
        self.mPublicToggle = self:AddToggle()
        self.mPublicToggle:Initialize(false, "是否公示 (交易税减半)", function()
            self:OnPublicTaxToggleChanged()
        end)
    end

    self:AddSpace(10)
    self.mAddShelfButton = self:AddBigButton()
    self.mAddShelfButton:Initialize("上架", function()
        self:OnAddShelfButtonClicked()
    end)

    self:AddSpace(10)
    self:OnQiPaiPriceValueChanged()
    --[[****************************刷新*****************************]]
end

---@param isYuanBao boolean 是否是元宝的数据
function UIAuctionItemAddShelfController:GetOnePriceRate(isYuanBao)
    if self:GetData() then
        if isYuanBao then
            return self:GetData().PriceData.marketPriceSection.ratio
        end
        return self:GetData().PriceData.otherMarketPriceSection.ratio
        --[[        if self:CanBothDeal() then
                    if not isYuanBao then
                        return self:GetData().PriceData.otherMarketPriceSection.ratio
                    end
                end
                return self:GetData().PriceData.marketPriceSection.ratio]]
    end
end

--[[****************************事件*****************************]]
---物品数量变化事件
---@private
function UIAuctionItemAddShelfController:OnItemCountChanged()
    self:RefreshCurrentNumber()
    -- self:SetRealQiPaiSinglePrice(self:GetRealQiPaiSinglePrice())
end

---起拍价(单价)变化事件
---@private
function UIAuctionItemAddShelfController:OnQiPaiPriceValueChanged()
    ---起拍价变化时需要重置一口价倍数
    -- self.mYiKouSlider:SetValue(0)
    local sliderPrice = math.ceil(self.mQiPaiSlider:GetCurrentValue()) * self:GetItemCount()
    self:SetRealQiPaiSinglePrice(sliderPrice)
end

---一口价倍数变化事件
---@private
function UIAuctionItemAddShelfController:OnYiKouPriceValueChanged()
    self:RefreshYiKouPriceCoinAmount()
end

---一口价倍数变化事件
---@private
function UIAuctionItemAddShelfController:OnPublicTaxToggleChanged()
    self:RefreshTax()
end

---上架按钮点击事件
function UIAuctionItemAddShelfController:OnAddShelfButtonClicked()
    local isPublish = false
    if self.mPublicToggle then
        isPublish = self.mPublicToggle:GetValue()
    end
    networkRequest.ReqAddToShelf(self:GetData().BagItemInfo.lid, self:GetItemCount(), { itemId = self:GetCurrentCoinType(), count = self:GetSingleItemPrice() },
            Utility.EnumToInt(CS.auctionV2.AuctionItemType.SALF_PRODUCTS), isPublish, self:GetYiKouSinglePrice())
    uimanager:ClosePanel("UIAuctionItemPanel")
end

---单价改变
function UIAuctionItemAddShelfController:OnSinglePriceChange(value, uiInputGo)
    local low = self:GetCurrentPriceData().lowPrice * self:GetItemCount()
    local top = self:GetCurrentPriceData().topPrice * self:GetItemCount()
    local num = math.min(top, value)
    num = math.max(low, num)
    self.mQiPaiSlider:SetValue(num / self:GetItemCount())
    if uiInputGo then
        uiInputGo.value = num
        self:SetRealQiPaiSinglePrice(num)--这里赋值必须在 self.mQiPaiSlider:SetValue之前，不然slider会赋一个错误的值
    end
end

---一口价改变
function UIAuctionItemAddShelfController:OnTotalPriceChange(value, uiInputGo)
    local isYuanBao = self:GetCurrentCoinType() == LuaEnumCoinType.YuanBao
    local rate = self:GetOnePriceRate(isYuanBao)

    local low = 1
    local top = rate

    local num = math.min(top, value / self:GetQiPaiSinglePrice())
    num = math.max(low, num)
    self.mYiKouSlider:SetValue(num)
    self:RefreshTax()
    if uiInputGo then
        uiInputGo.value = math.ceil(num * self:GetQiPaiSinglePrice())
    end
end

--[[****************************刷新数量*****************************]]
---刷新当前物品数量
function UIAuctionItemAddShelfController:RefreshCurrentNumber()
    self:RefreshQiPaiCoinAmount()
end

---刷新起拍价数量
function UIAuctionItemAddShelfController:RefreshQiPaiCoinAmount()
    self.mQiPaiCoinLabel:RefreshContent(self:GetQiPaiSummaryPrice())
    self:RefreshYiKouPriceCoinAmount()
    self.mYiKouCoinLabel:RefreshContent(self:GetYiKouSummaryPrice())
    self:RefreshTax()
end

---刷新一口价价格
function UIAuctionItemAddShelfController:RefreshYiKouPriceCoinAmount()
    self.mYiKouCoinLabel:RefreshContent(self:GetYiKouSummaryPrice())
    self:RefreshTax()
end

---刷新税
function UIAuctionItemAddShelfController:RefreshTax()
    local taxMin = self:GetTaxMin() * self:GetItemCount()
    local taxMax = self:GetTaxMax() * self:GetItemCount()
    self.mTaxCoinLabel:RefreshContent(tostring(taxMin) .. "-" .. tostring(taxMax))
end

--[[****************************获取税率*****************************]]
---获取交易税数值(小数,需要向上取整)
---@private
---@param amount
---@return number
function UIAuctionItemAddShelfController:GetRateAmount(amount)
    local addNum = 0
    local rateInfo = self:GetCurrentRateTableData()
    local mMinPrice = self:GetCurrentPriceData().lowPrice
    local mHighPrice = self:GetCurrentPriceData().topPrice
    if amount and rateInfo then
        local num = mHighPrice - mMinPrice
        local totalPrice = (amount - mMinPrice) / num  * 1000
        for i = 1, #rateInfo do
            if rateInfo[i][2] and rateInfo[i][1] and rateInfo[i][3] then
                if totalPrice >= rateInfo[i][2] then
                    local value1 = rateInfo[i][3] / 10000
                    local value2 = mMinPrice
                    addNum = addNum + value1 * value2
                else
                    local value1 = rateInfo[i][1] / 100
                    local value2 = amount - mMinPrice * value1
                    local value3 = rateInfo[i][3] / 10000
                    addNum = addNum + value3 * value2
                    break
                end
            end
        end
    end
    return addNum
end

---获取税率信息的表数据
---@private
function UIAuctionItemAddShelfController:GetRateTableData(globalId)
    ---@private
    local mRateInfo = {}
    local res, tableData = CS.Cfg_GlobalTableManager.Instance.dic:TryGetValue(globalId)
    if res then
        local str = string.Split(tableData.value, "&")
        for i = 1, #str do
            local tbl = {}
            local str2 = string.Split(str[i], "#")
            for j = 1, #str2 do
                tbl[j] = tonumber(str2[j])
                mRateInfo[i] = tbl
            end
        end
    end
    return mRateInfo
end

---@return table<> 税率相关数据
function UIAuctionItemAddShelfController:GetCurrentRateTableData()
    local coinType = self:GetCurrentCoinType()
    if self.mCoinTypeToRateTbl == nil then
        self.mCoinTypeToRateTbl = {}
    end
    local data = self.mCoinTypeToRateTbl[coinType]
    if data == nil then
        local globalId = coinType == LuaEnumCoinType.YuanBao and 20300 or 22017
        data = self:GetRateTableData(globalId)
        self.mCoinTypeToRateTbl[coinType] = data
    end
    return data
end

--[[****************************获取数值*****************************]]
---获取交易的物品数量
---@return number
function UIAuctionItemAddShelfController:GetItemCount()
    return self.mMinMaxNumberPart:GetCurrentNumber()
end

---设置实际起拍价
function UIAuctionItemAddShelfController:SetRealQiPaiSinglePrice(price)
    --[[    local minPrice = self:GetCurrentPriceData().lowPrice * self:GetItemCount()
        local maxPrice = self:GetCurrentPriceData().topPrice * self:GetItemCount()
        price = math.min(price, maxPrice)
        price = math.max(price, minPrice)]]
    --更改起拍价
    self.mQiPaiCoinLabel:GetCoinInput_UIInput().value = price
    self.mRealQiPaiPrice = price
    --起拍价变化刷新一口价以及税率
    self.mYiKouCoinLabel:RefreshContent(price)
    self:OnTotalPriceChange(price, self.mYiKouCoinLabel:GetCoinInput_UIInput())
    self:RefreshTax()
end

---手动输入5，滑动有小数，最后获得的起拍价是6
---因为计算有小数点，会导致获取的起拍价不准确，所以保存一个准确的当前的起拍价
function UIAuctionItemAddShelfController:GetRealQiPaiSinglePrice()
    return self.mRealQiPaiPrice
end

function UIAuctionItemAddShelfController:GetSingleItemPrice()
    if self.mRealQiPaiPrice ~= nil and self:GetItemCount() >= 1 then
        local num = self.mRealQiPaiPrice / self:GetItemCount()
        return num
    end
end

---获取起拍单价
---@return number
function UIAuctionItemAddShelfController:GetQiPaiSinglePrice()
    if self:GetRealQiPaiSinglePrice() == nil then
        --没手动赋值前，按原有逻辑通过slider获取
        return math.ceil(self.mQiPaiSlider:GetCurrentValue())
    else
        --有过赋值以后，获取玩家设置的数据
        return self:GetRealQiPaiSinglePrice()
    end
end

---获取起拍总价
---@return number
function UIAuctionItemAddShelfController:GetQiPaiSummaryPrice()
    return self:GetQiPaiSinglePrice() * self:GetItemCount()
end

---获取一口价单价
---@return number
function UIAuctionItemAddShelfController:GetYiKouSinglePrice()
    local rate = math.ceil(self.mYiKouSlider:GetCurrentValue())
    local onePrice = math.ceil(rate * self:GetQiPaiSinglePrice())
    return onePrice
end

---获取一口总价
---@return number
function UIAuctionItemAddShelfController:GetYiKouSummaryPrice()
    return self:GetYiKouSinglePrice() * self:GetItemCount()
end

---获取交易税最低值
---@return number
function UIAuctionItemAddShelfController:GetTaxMin()
    ---交易税最低值即起拍总价对应的税值
    if self.mPublicToggle then
        if self.mPublicToggle:GetValue() then
            return math.ceil(self:GetRateAmount(self:GetQiPaiSinglePrice()) * 0.5)
        end
    end
    return math.ceil(self:GetRateAmount(self:GetQiPaiSinglePrice()))
end

---获取交易税最高值
---@return number
function UIAuctionItemAddShelfController:GetTaxMax()
    ---交易税最高值即一口总价对应的税值
    if self.mPublicToggle and self.mPublicToggle:GetValue() then
        return math.ceil(self:GetRateAmount(self:GetYiKouSinglePrice()) * 0.5)
    else
        return math.ceil(self:GetRateAmount(self:GetYiKouSinglePrice()))
    end
end

function UIAuctionItemAddShelfController:GetCurrentPriceData()
    if self:GetCurrentCoinType() == LuaEnumCoinType.YuanBao then
        return self:GetData().PriceData.marketPriceSection
    else
        return self:GetData().PriceData.otherMarketPriceSection
    end

    --[[    local normalData = self:GetData().PriceData.marketPriceSection
        if self:CanBothDeal() then
            if self:GetCurrentCoinType() == LuaEnumCoinType.YuanBao then
                return normalData
            else
                local otherData = self:GetData().PriceData.otherMarketPriceSection
                return otherData == nil and normalData or otherData
            end
        else
            return normalData
        end]]
end

--region 标题
---是否可以元宝交易
function UIAuctionItemAddShelfController:IsItemCanYuanBaoDeal()
    if self.mCanYuanBaoDeal == nil then
        if self:GetData() then
            self.mCanYuanBaoDeal = CS.CSServerItemInfo.CanYuanBaoAuctionDeal(self:GetData().BagItemInfo.itemId)
        else
            self.mCanYuanBaoDeal = false
        end
    end
    return self.mCanYuanBaoDeal
end

---是否可以钻石交易
function UIAuctionItemAddShelfController:CanDiamondDeal()
    if self.mCanDiamondDeal == nil then
        if self:GetData() then
            self.mCanDiamondDeal = CS.CSServerItemInfo.CanAuctionDeal(self:GetData().BagItemInfo.itemId)
        else
            self.mCanDiamondDeal = false
        end
    end
    return self.mCanDiamondDeal
end

---两种交易都可以
function UIAuctionItemAddShelfController:CanBothDeal()
    return self:IsItemCanYuanBaoDeal() and self:CanDiamondDeal()
end

---元宝交易
function UIAuctionItemAddShelfController:OnLeftTitleBtnClicked()
    self:SetCurrentCoinType(LuaEnumCoinType.YuanBao)
    self:RefreshAll()
end

---钻石交易
function UIAuctionItemAddShelfController:OnRightTitleBtnClicked()
    self:SetCurrentCoinType(LuaEnumCoinType.Diamond)
    self:RefreshAll()
end

---获取当前货币类型
function UIAuctionItemAddShelfController:GetCurrentCoinType()
    return self.mCurrentCoinType
end

---修改当前货币类型
function UIAuctionItemAddShelfController:SetCurrentCoinType(type)
    self.mCurrentCoinType = type
end

--endregion

--region 刷新整个界面显示
function UIAuctionItemAddShelfController:RefreshAll()
    self:ResetToRefresh()
    self:RefreshCoin()
    self:RefreshCurrentNumber()
end

---重置数目
function UIAuctionItemAddShelfController:ResetNum()
    if self.mMinMaxNumberPart then
        self.mMinMaxNumberPart:SetCurrentNumber(1)
    end
    self.mQiPaiSlider:ResetValue(self:GetCurrentPriceData().lowPrice, self:GetCurrentPriceData().topPrice)
end

---刷新货币
function UIAuctionItemAddShelfController:RefreshCoin()
    local coinTbl = self:GetCurrentCoinType() == LuaEnumCoinType.YuanBao and self.mYuanBaoTbl or self.mDiamondTbl
    if self.mQiPaiCoinLabel then
        self.mQiPaiCoinLabel:Refresh(coinTbl, 0)
    end
    if self.mYiKouCoinLabel then
        self.mYiKouCoinLabel:Refresh(coinTbl, 0)
    end
    if self.mTaxCoinLabel then
        self.mTaxCoinLabel:Refresh(coinTbl, 0)
    end
end
--endregion

--region 缓存数据
---@return TABLE.cfg_items
function UIAuctionItemAddShelfController:CacheItemInfo(itemId)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local data = self.mItemIdToInfo[itemId]
    if data == nil then
        data = CS.cfg_items:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = data
    end
    return data
end
--endregion

return UIAuctionItemAddShelfController