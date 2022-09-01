---@class UIAuctionPanel_SelfSellGridTemplate:TemplateBase 拍卖行个人出售格子模板
local UIAuctionPanel_SelfSellGridTemplate = {}

UIAuctionPanel_SelfSellGridTemplate.isExpire = false

function UIAuctionPanel_SelfSellGridTemplate:Init(rootPanel)
    ---@type UIAuctionPanel_SelfSellPanel
    self.SelfSellPanel = rootPanel
    self:InitComponents()
    self:BindEvents()
end

function UIAuctionPanel_SelfSellGridTemplate:InitComponents()
    self.Strengthen_UILabel = self:Get("Info/strengthen", "UILabel")
    ---@type UISprite
    ---星星图片
    self.Star_UISprite = self:Get("Info/star", "UISprite")
    self.ItemIcon_UISprite = self:Get("Info/icon", "UISprite")

    ---@type UnityEngine.GameObject
    self.icon_GameObject = self:Get("Info/icon", "GameObject")

    self.ItemCount_UILabel = self:Get("Info/count", "UILabel")
    self.ItemName_UILabel = self:Get("Info/name", "UILabel")
    self.PriceText_UILabel = self:Get("Info/Price/price", "UILabel")
    self.PriceSprite_UISprite = self:Get("Info/Price/icon", "UISprite")
    self.BackFrame_UISprite = self:Get("backFrame", "UISprite")
    ---下架
    self.Downput_GameObject = self:Get("Info/Obtained", "GameObject")
    ---@type UICountdownLabel 倒计时文本组件
    self.TimeText_UICountDownLabel = self:Get("Info/desTime", "UICountdownLabel")
    ---@type UILabel 审核中文本
    self.TimeCheck_UILabel = self:Get("Info/des", "UILabel")
    ---@type UILabel 倒计时文本
    self.TimeText_UILabel = self:Get("Info/desTime", "UILabel")
    self.Add_GameObject = self:Get("add", "GameObject")
    self.Info_GameObject = self:Get("Info", "GameObject")
    ---@type UnityEngine.GameObject
    self.bloodSuitSign = self:Get("Info/BloodLv", "GameObject")
    ---@type UILabel
    self.bloodSuitLevelLabel = self:Get("Info/BloodLvLabel", "UILabel")
end

function UIAuctionPanel_SelfSellGridTemplate:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnRemoveClicked()
    end
    CS.UIEventListener.Get(self.icon_GameObject).onClick = function()
        self:OnRemoveClicked()
    end
end

---下架
function UIAuctionPanel_SelfSellGridTemplate:OnRemoveClicked()
    if self.AuctionInfo then
        local data = {}
        data.AuctionInfo = self.AuctionInfo
        data.BagItemInfo = self.BagItemInfo
        if self.isExpire then
            ---@type UIAuctionPanel_AuctionItem_TradeRemoveShelf
            data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeRemoveShelf
            local itemID = self.BagItemInfo.itemId
            luaEventManager.DoCallback(LuaCEvent.mCurrentReAddItemState, itemID)
        else
            ---@type UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire
            data.Template = luaComponentTemplates.UIAuctionPanel_AuctionItem_TradeRemoveShelfDidNotExpire
        end
        uimanager:CreatePanel('UIAuctionItemPanel', nil, data)
        self.SelfSellPanel.mChooseBagItemInfo = self.BagItemInfo
    end
end

---点击头像
function UIAuctionPanel_SelfSellGridTemplate:OnIconClicked()
    if self.BagItemInfo and self.ItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.BagItemInfo, showAssistPanel = true, showMoreAssistData = true, showTabBtns = true })
    end
end

---刷新UI
---@param info auctionV2.AuctionItemInfo 背包物品信息
---@param gridType 背包格子类型 格子类型
function UIAuctionPanel_SelfSellGridTemplate:RefreshUI(info)
    ---@type boolean 是否过期
    self.isExpire = false
    self:SetComponent(self.Add_GameObject, info == nil)
    self:SetComponent(self.Info_GameObject, info ~= nil)

    if info ~= nil then
        self.AuctionInfo = info
        self:SetShowTime()
        self.BagItemInfo = self.AuctionInfo.item
        if self.BagItemInfo then
            self:RefreshStrengthInfo()
            ___, self.ItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.BagItemInfo.itemId)
            if self.ItemInfo then
                --物品图片
                if self.ItemIcon_UISprite then
                    self.ItemIcon_UISprite.spriteName = self.ItemInfo.icon
                end
                local bloodsuitTbl = clientTableManager.cfg_bloodsuitManager:TryGetValue(self.BagItemInfo.itemId)
                if bloodsuitTbl and self.BagItemInfo.bloodLevel > 0 then
                    self.bloodSuitSign:SetActive(true)
                    self.bloodSuitLevelLabel.gameObject:SetActive(true)
                    self.bloodSuitLevelLabel.text = tostring(self.BagItemInfo.bloodLevel)
                else
                    self.bloodSuitSign:SetActive(false)
                    self.bloodSuitLevelLabel.gameObject:SetActive(false)
                end

                --物品数量
                if self.ItemCount_UILabel then
                    self.ItemCount_UILabel.text = ternary(self.BagItemInfo.count == 0 or self.BagItemInfo.count == 1, "", self.BagItemInfo.count)
                end
                --物品名字
                if self.ItemName_UILabel then
                    -- self.ItemName_UILabel.text = self.BagItemInfo.ItemFullName
                    self.ItemName_UILabel.text = Utility.GetShortShowLabel(self.BagItemInfo.ItemFullName)
                end
                --价格
                if self.PriceText_UILabel then
                    self.PriceText_UILabel.text = self.AuctionInfo.price.count
                end
                --货币icon
                if self.PriceSprite_UISprite then
                    local resPrice, priceItemInfo = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(self.AuctionInfo.price.itemId)
                    if resPrice then
                        self.PriceSprite_UISprite.spriteName = priceItemInfo.icon
                    end
                end
            end
        end
    end
end

---置空UI
function UIAuctionPanel_SelfSellGridTemplate:ResetUI()
    self:SetComponent(self.Add_GameObject, false)
    self:SetComponent(self.Info_GameObject, false)
end

function UIAuctionPanel_SelfSellGridTemplate:SetComponent(Obj, isShow)
    if not CS.StaticUtility.IsNull(Obj) then
        Obj:SetActive(isShow)
    end
end

---刷新强化等级显示
function UIAuctionPanel_SelfSellGridTemplate:RefreshStrengthInfo()
    --物品强化等级
    if CS.StaticUtility.IsNull(self.Strengthen_UILabel) == false then
        local isShow = self.BagItemInfo.intensify and self.BagItemInfo.intensify > 0
        if isShow then
            local str, icon = Utility.GetIntensifyShow(self.BagItemInfo.intensify)
            self.Strengthen_UILabel.text = str
            if CS.StaticUtility.IsNull(self.Star_UISprite) == false then
                self.Star_UISprite.spriteName = icon
            end
        end
        self.Strengthen_UILabel.gameObject:SetActive(isShow)
        if CS.StaticUtility.IsNull(self.Star_UISprite) == false then
            self.Star_UISprite.gameObject:SetActive(isShow)
        end
    end
end

---刷新背景显示
function UIAuctionPanel_SelfSellGridTemplate:ShowBackFrame(isShow)
    if CS.StaticUtility.IsNull(self.BackFrame_UISprite) == false then
        local color = ternary(isShow, LuaEnumUnityColorType.Normal, LuaEnumUnityColorType.Transparent)
        self.BackFrame_UISprite.color = color
    end
end

---设置显示时间
function UIAuctionPanel_SelfSellGridTemplate:SetShowTime()
    self.TimeText_UICountDownLabel:StopCountDown()
    local timeDelay = self.AuctionInfo.delayTime
    if timeDelay and timeDelay ~= 0 and CS.CSAuctionInfoV2.NotOverTime(timeDelay) then
        self.TimeCheck_UILabel.gameObject:SetActive(true)
        self.TimeCheck_UILabel.text = "[878787]审核中"
        self.TimeText_UILabel.gameObject:SetActive(false)
        self.TimeText_UICountDownLabel:StartCountDown(nil, 5, timeDelay, nil, nil, nil, function()
            self:OverDelayTime()
        end)
    else
        self:OverDelayTime()
    end
end

---审核时间结束后开始过期时间
function UIAuctionPanel_SelfSellGridTemplate:OverDelayTime()
    self.TimeCheck_UILabel.gameObject:SetActive(false)
    self.TimeText_UILabel.gameObject:SetActive(true)
    local time = self.AuctionInfo.overdueTime
    if time and time ~= 0 and CS.CSAuctionInfoV2.NotOverTime(time) then
        self.TimeText_UICountDownLabel:StartCountDown(nil, 5, time, "[878787]", "[-]", nil, function()
            self:OverdueTime()
        end)
    else
        self:OverdueTime()
    end
end

---上架过期
function UIAuctionPanel_SelfSellGridTemplate:OverdueTime()
    self.TimeText_UILabel.text = "已过期"
    self.isExpire = true
end

return UIAuctionPanel_SelfSellGridTemplate