---@class UIAuctionTransactionRecordPanel_GridTemplate:copytemplatebase
local UIAuctionTransactionRecordPanel_GridTemplate = {}

setmetatable(UIAuctionTransactionRecordPanel_GridTemplate, luaComponentTemplates.copytemplatebase)

---@return UnityEngine.GameObject 预设
function UIAuctionTransactionRecordPanel_GridTemplate:GetPrefabGO()
    if self.mRootPanel and self.mPrefabGo == nil then
        self.mPrefabGo = self.mRootPanel:GetCurComp("ItemsArea/Scroll View/LoopScroll/uiAuctionItemTemplate", "GameObject")
    end
    return self.mPrefabGo
end

---@param panel UIAuctionTransactionRecordPanel
function UIAuctionTransactionRecordPanel_GridTemplate:Init(panel)
    self.mRootPanel = panel
    self:InitComponent()
    self:BindEvent()
end

function UIAuctionTransactionRecordPanel_GridTemplate:InitComponent()
    ---@type UILabel
    ---道具文本
    self.mItemName = "name"

    ---@type UILabel
    ---时间文本
    self.mTimeLabel = "Time"

    ---@type UILabel
    ---类型文本
    self.mDetailsLabel = "Details"

    ---@type UILabel
    ---价格文本
    self.mPriceLabel = "Price"

    ---@type UnityEngine.GameObject
    ---领奖按钮
    self.mRewardBtn = "btn_reward"

    ---@type UnityEngine.GameObject
    ---领完
    self.mHasRewardBtn = "hasReward"
end

---@return UnityEngine.GameObject 物品名字
function UIAuctionTransactionRecordPanel_GridTemplate:GetNameLb_Go()
    if self.mNameLb == nil then
        self.mNameLb = self:GetUIComponentController():GetCustomType(self.mItemName, "GameObject")
    end
    return self.mNameLb
end

---@return UISprite 价格icon
function UIAuctionTransactionRecordPanel_GridTemplate:GetPriceIcon()
    if self.mPriceIcon == nil then
        local go = self:GetUIComponentController():GetCustomType(self.mPriceLabel, "GameObject")
        if not CS.StaticUtility.IsNull(go) then
            self.mPriceIcon = CS.Utility_Lua.Get(go.transform, "ingotSymbol", "UISprite")
        end
    end
    return self.mPriceIcon
end

---@return UnityEngine.GameObject 领奖按钮
function UIAuctionTransactionRecordPanel_GridTemplate:GetRewardBtn_Go()
    if self.mRewardBtnGo == nil then
        self.mRewardBtnGo = self:GetUIComponentController():GetCustomType(self.mRewardBtn, "GameObject")
    end
    return self.mRewardBtnGo
end

function UIAuctionTransactionRecordPanel_GridTemplate:BindEvent()
    if CS.StaticUtility.IsNull(self:GetRewardBtn_Go()) == false then
        CS.UIEventListener.Get(self:GetRewardBtn_Go()).onClick = function(go)
            self:OnRewardBtnClicked(go)
        end
    end
end

---@param  info auctionV2.TransactionRecord
function UIAuctionTransactionRecordPanel_GridTemplate:RefreshGrid(info)
    if info == nil then
        return
    end
    self.Info = info
    if info.goods then
        local itemInfo = info.goods.ItemTABLE
        if itemInfo then
            local add = info.goods.count <= 1 and "" or " x" .. info.goods.count
            local name = Utility.GetShortShowLabel(itemInfo.name)
            self:GetUIComponentController():SetLabelContent(self.mItemName, name .. add)
            CS.UIEventListener.Get(self:GetNameLb_Go()).onClick = function()
                uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = info.goods, showRight = false })
            end
        end
    end

    if info.tradeTime then
        local time = CS.CSServerTime.StampToDateTimeForSecondToString("MM-dd HH:mm:ss", info.tradeTime)
        self:GetUIComponentController():SetLabelContent(self.mTimeLabel, time)
    end

    local isSell = true
    local isShareSell = false
    local isShareBuy = false
    if info.type then
        isSell = info.type == Utility.EnumToInt(CS.auctionV2.RecordType.SELL) and true or false
        isShareSell = info.type == Utility.EnumToInt(CS.auctionV2.RecordType.MOON_SELL) and true or false
        isShareBuy = info.type == Utility.EnumToInt(CS.auctionV2.RecordType.MOON_BUY) and true or false
        local show = isSell and "出售" or isShareSell and "跨服出售" or isShareBuy and "跨服购买" or "购买"
        self:GetUIComponentController():SetLabelContent(self.mDetailsLabel, show)
    end

    if info.moneyId then
        local itemInfo = self:GetItemInfo(info.moneyId)
        if itemInfo then
            if not CS.StaticUtility.IsNull(self:GetPriceIcon()) then
                self:GetPriceIcon().spriteName = itemInfo.icon
                CS.UIEventListener.Get(self:GetPriceIcon().gameObject).onClick = function()
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = itemInfo, showRight = false })
                end
            end
        end
    end

    if info.moneyCount then
        local rate = ""
        if info.substractMoney and info.substractMoney ~= 0 and (isSell or isShareSell) then
            rate = luaEnumColorType.Gray .. "(税" .. info.substractMoney .. ")"
        end
        local color = (isSell or isShareSell) and luaEnumColorType.Green or luaEnumColorType.Red
        self:GetUIComponentController():SetLabelContent(self.mPriceLabel, color .. info.moneyCount .. rate)
    end

    local state = info.state
    local isShowBtn = state == Utility.EnumToInt(CS.auctionV2.RecordState.CAN_RECEIVE)
    self:GetUIComponentController():SetObjectActive(self.mRewardBtn, isShowBtn)
    local hasReward = state == Utility.EnumToInt(CS.auctionV2.RecordState.HAVE_RECEIVE)
    self:GetUIComponentController():SetObjectActive(self.mHasRewardBtn, hasReward)
    self:GetUIComponentController():Apply()

    if not CS.StaticUtility.IsNull(self:GetPriceIcon()) then
        self:GetPriceIcon():UpdateAnchors()
    end

end

---@return TABLE.CFG_ITEMS
function UIAuctionTransactionRecordPanel_GridTemplate:GetItemInfo(id)
    if self.mRootPanel then
        return self.mRootPanel:GetItemInfo(id)
    end
end

function UIAuctionTransactionRecordPanel_GridTemplate:OnRewardBtnClicked(go)
    if self.mRootPanel then
        self.mRootPanel.mNeedJumpLine = true
    end

    if self.Info then
        networkRequest.ReqReceiveTradeRecord(self.Info.id)
    end
end

return UIAuctionTransactionRecordPanel_GridTemplate