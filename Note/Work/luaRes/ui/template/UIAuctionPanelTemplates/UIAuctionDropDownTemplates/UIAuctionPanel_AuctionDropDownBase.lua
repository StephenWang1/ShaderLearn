---@class UIAuctionPanel_AuctionDropDownBase:TemplateBase 竞拍行类型排序模板
local UIAuctionPanel_AuctionDropDownBase = {}

UIAuctionPanel_AuctionDropDownBase.grayColor = "auction_unpricearrow"
UIAuctionPanel_AuctionDropDownBase.lightColor = "auction_pricearrow"

UIAuctionPanel_AuctionDropDownBase.mMenuName = {
    [LuaEnumAuctionPanelSecondMenuType.All] = "所有道具",
    [LuaEnumAuctionPanelSecondMenuType.AuctionItem] = "竞拍道具",
    [LuaEnumAuctionPanelSecondMenuType.BuyItem] = "直售道具",
    [LuaEnumAuctionPanelSecondMenuType.JoinItem] = "参与竞价道具",
}

function UIAuctionPanel_AuctionDropDownBase:GetDropDown_UIGridContainer()
end

function UIAuctionPanel_AuctionDropDownBase:Init(panel)
    self.mRootPanel = panel
    self:InitComponent()
    self:InitEvent()
    ---@type boolean
    --- 是否生成目录Toggle
    self.hasMenuToggle = false
    self:InitMenuToggle()
    self:ResetMenu()
end

function UIAuctionPanel_AuctionDropDownBase:InitComponent()
    self.SortTime_GameObject = self:Get("Time", "GameObject")
    self.SortPrice_GameObject = self:Get("AuctionPrice", "GameObject")
    self.SortOncePrice_GameObject = self:Get("Price", "GameObject")
    self.sortByTime = true
    self.sortByAuctionPrice = false
    self.sortByOncePrice = false

    self.time_UILabel = self:Get("Time/CaptionLabel", "UILabel")
    self.timeDown_UISprite = self:Get("Time/Btn_programd", "UISprite")
    self.timeBg_GameObject = self:Get("Time/bg", "GameObject")
    self.timeArrow_TweenRotation = self:Get("Time/Btn_programd", "TweenRotation")
    ---@type UnityEngine.BoxCollider
    self.time_Collider = self:Get("Time", "BoxCollider")

    self.auctionPriceDown_UISprite = self:Get("AuctionPrice/Btn_programd", "UISprite")
    self.auction_UILabel = self:Get("AuctionPrice/CaptionLabel", "UILabel")
    self.auctionBg_GameObject = self:Get("AuctionPrice/bg", "GameObject")
    self.auctionArrow_TweenRotation = self:Get("AuctionPrice/Btn_programd", "TweenRotation")
    ---@type UnityEngine.BoxCollider
    self.auction_Collider = self:Get("AuctionPrice", "BoxCollider")

    self.priceDown_UISprite = self:Get("Price/Btn_programd", "UISprite")
    self.price_UILabel = self:Get("Price/CaptionLabel", "UILabel")
    self.priceArrow_TweenRotation = self:Get("Price/Btn_programd", "TweenRotation")
    ---@type UnityEngine.GameObject
    ---价格背景
    self.priceBg_GameObject = self:Get("Price/bg", "GameObject")
    ---@type UnityEngine.BoxCollider
    self.price_Collider = self:Get("Price", "BoxCollider")

    --region选择目录
    ---@type UIGridContainer
    ---选择目录container
    self.ChooseMenu_UIGridContainer = self:Get("Caption/Grid", "UIGridContainer")

    ---@type UnityEngine.GameObject
    self.mCloseChooseBtn_Go = self:Get("Caption/Grid/close", "GameObject")

    ---@type UnityEngine.GameObject
    ---选择按钮
    self.ChooseMenu_Go = self:Get("Caption", "GameObject")

    ---@type UILabel
    ---目录名字
    self.mMenuNameLabel_UILabel = self:Get("Caption/CaptionLabel", "UILabel")

    ---@type TweenRotation
    ---目录箭头
    self.mMenuArrow_TweenRotation = self:Get("Caption/Btn_programd", "TweenRotation")

    --endregion
end

function UIAuctionPanel_AuctionDropDownBase:InitEvent()
    CS.UIEventListener.Get(self.SortTime_GameObject).onClick = function()
        self:SortByTime()
    end
    CS.UIEventListener.Get(self.SortPrice_GameObject).onClick = function()
        self:SortByAuctionPrice()
    end
    CS.UIEventListener.Get(self.SortOncePrice_GameObject).onClick = function()
        self:SortByOncePrice()
    end
    CS.UIEventListener.Get(self.ChooseMenu_Go).onClick = function()
        self:ChooseMenu()
    end
    CS.UIEventListener.Get(self.mCloseChooseBtn_Go).onClick = function()
        self:ChooseMenu()
    end
end

---选择目录点击
function UIAuctionPanel_AuctionDropDownBase:ChooseMenu()
    self.hasChooseMenu = not self.hasChooseMenu
    self:SetMenuShow(self.hasChooseMenu)
end

---设置目录显示
function UIAuctionPanel_AuctionDropDownBase:SetMenuShow(isShow)
    self.ChooseMenu_UIGridContainer.gameObject:SetActive(isShow)
    self:SetArrowRotation(self.mMenuArrow_TweenRotation, isShow)
end

---获取目录Toggle
function UIAuctionPanel_AuctionDropDownBase:InitMenuToggle()
    if self.mTypeToToggle == nil then
        self.mTypeToToggle = {}
    end
    if not self.hasMenuToggle then
        local toggleTable = {}
        table.insert(toggleTable, LuaEnumAuctionPanelSecondMenuType.All)
        table.insert(toggleTable, LuaEnumAuctionPanelSecondMenuType.JoinItem)
        self.ChooseMenu_UIGridContainer.MaxCount = #toggleTable
        for i = 0, 1 do
            local go = self.ChooseMenu_UIGridContainer.controlList[i]
            local toggle = CS.Utility_Lua.GetComponent(go.transform, "UIToggle")
            local type = toggleTable[i + 1]
            local nameLabel = CS.Utility_Lua.Get(go.transform, "CaptionLabel", "UILabel")
            CS.EventDelegate.Add(toggle.onChange, function()
                local nameColor = ternary(toggle.value, luaEnumColorType.White, luaEnumColorType.Gray)
                nameLabel.text = nameColor .. self.mMenuName[type]
            end)
            CS.UIEventListener.Get(toggle.gameObject).onClick = function()
                self:OnToggleClicked(type, true)
            end
            self.mTypeToToggle[type] = toggle
        end
        self.hasMenuToggle = true
    end
end

---@return UIToggle
function UIAuctionPanel_AuctionDropDownBase:GetMenuToggle(type)
    if self.mTypeToToggle then
        return self.mTypeToToggle[type]
    end
end

function UIAuctionPanel_AuctionDropDownBase:ChooseTypeToggle(type)
    local toggle = self:GetMenuToggle(type)
    if toggle then
        toggle:Set(true)
    end
    self:OnToggleClicked(type)
end

function UIAuctionPanel_AuctionDropDownBase:OnToggleClicked(type, needReq)
    self.hasChooseMenu = false
    self:SetMenuShow(false)
    self.ChooseType = type
    self.mMenuNameLabel_UILabel.text = self.mMenuName[type]
    self.time_Collider.enabled = type ~= LuaEnumAuctionPanelSecondMenuType.BuyItem
    self.auction_Collider.enabled = type ~= LuaEnumAuctionPanelSecondMenuType.BuyItem
    self.SortBuy = LuaEnumAuctionPanelSortType.PutOnTime
    if needReq then
        self:OnTitleChooseChange()
    end
    self:SetButtonShow()
end

---按时间排序
function UIAuctionPanel_AuctionDropDownBase:SortByTime()
    self.SortBuy = LuaEnumAuctionPanelSortType.OverTime
    if self.sortByTime then
        self.mPriceHighToLow = not self.mPriceHighToLow
    else
        self.mPriceHighToLow = false
        self.sortByTime = true
        self.sortByAuctionPrice = false
        self.sortByOncePrice = false
    end
    self:SetButtonShow()
    self:OnTitleChooseChange()
end

---按竞拍价排序
function UIAuctionPanel_AuctionDropDownBase:SortByAuctionPrice()
    self.SortBuy = LuaEnumAuctionPanelSortType.BidPrice
    if self.sortByAuctionPrice then
        self.mPriceHighToLow = not self.mPriceHighToLow
    else
        self.mPriceHighToLow = true
        self.sortByTime = false
        self.sortByAuctionPrice = true
        self.sortByOncePrice = false
    end
    self:SetButtonShow()
    self:OnTitleChooseChange()
end

---按一口价排序
function UIAuctionPanel_AuctionDropDownBase:SortByOncePrice()
    self.SortBuy = LuaEnumAuctionPanelSortType.FixedPrice
    if self.sortByOncePrice then
        self.mPriceHighToLow = not self.mPriceHighToLow
    else
        self.mPriceHighToLow = true
        self.sortByTime = false
        self.sortByAuctionPrice = false
        self.sortByOncePrice = true
    end
    self:SetButtonShow()
    self:OnTitleChooseChange()
end

---选中目录改变
function UIAuctionPanel_AuctionDropDownBase:OnTitleChooseChange()
    ---@type UIAuctionUnionPanel
    local rootPanel = self.mRootPanel
    rootPanel:OnTitleMenuChange()
end

---设置按钮显示
function UIAuctionPanel_AuctionDropDownBase:SetButtonShow()
    local isSortByTime = self.SortBuy == LuaEnumAuctionPanelSortType.OverTime
    local isSortByOncePrice = self.SortBuy == LuaEnumAuctionPanelSortType.FixedPrice
    local isSortByAuctionPrice = self.SortBuy == LuaEnumAuctionPanelSortType.BidPrice
    self.timeDown_UISprite.spriteName = ternary(isSortByTime, self.lightColor, self.grayColor)
    self.auctionPriceDown_UISprite.spriteName = ternary(isSortByAuctionPrice, self.lightColor, self.grayColor)
    self.priceDown_UISprite.spriteName = ternary(isSortByOncePrice, self.lightColor, self.grayColor)
    self.price_UILabel.text = ternary(isSortByOncePrice, "一口价", "[878787]一口价")
    self.priceBg_GameObject:SetActive(isSortByOncePrice)
    self.auction_UILabel.text = ternary(isSortByAuctionPrice, "当前竞价", "[878787]当前竞价")
    self.auctionBg_GameObject:SetActive(isSortByAuctionPrice)
    self.time_UILabel.text = ternary(isSortByTime, "剩余时间", "[878787]剩余时间")
    self.timeBg_GameObject:SetActive(isSortByTime)
    self:SetArrowRotation(self.timeArrow_TweenRotation, isSortByTime and self.mPriceHighToLow)
    self:SetArrowRotation(self.auctionArrow_TweenRotation, isSortByAuctionPrice and self.mPriceHighToLow)
    self:SetArrowRotation(self.priceArrow_TweenRotation, isSortByOncePrice and self.mPriceHighToLow)
end

---@param arrow TweenRotation
function UIAuctionPanel_AuctionDropDownBase:SetArrowRotation(arrow, isShow)
    if CS.StaticUtility.IsNull(arrow) then
        return
    end
    if isShow then
        arrow:PlayReverse()
    else
        arrow:PlayForward()
    end
end

---@return LuaEnumAuctionPanelSortType,LuaEnumAuctionPanelSecondMenuType,boolean
function UIAuctionPanel_AuctionDropDownBase:GetCurrentSortType()
    return self.SortBuy, self.ChooseType, self.mPriceHighToLow
end

---重置目录
function UIAuctionPanel_AuctionDropDownBase:ResetMenu()
    self.ChooseMenu_UIGridContainer.gameObject:SetActive(true)
    self.hasChooseMenu = true
    self.SortBuy = LuaEnumAuctionPanelSortType.PutOnTime
    self:SetButtonShow()
    ---二级目录筛选类型
    self.ChooseType = LuaEnumAuctionPanelSecondMenuType.All
    self:ChooseTypeToggle(self.ChooseType)
end

return UIAuctionPanel_AuctionDropDownBase