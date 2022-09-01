---@class UIAuctionPanel_AuctionUnionGridTemplate:copytemplatebase 交易行-行会竞拍格子
local UIAuctionPanel_AuctionUnionGridTemplate = {}
setmetatable(UIAuctionPanel_AuctionUnionGridTemplate, luaComponentTemplates.copytemplatebase)

function UIAuctionPanel_AuctionUnionGridTemplate:GetPrefabGO()
    if self.mPrefabGO == nil and self:GetRootPanel() then
        self.mPrefabGO = self:GetRootPanel():GetCurComp("WidgetRoot/ItemsArea/Scroll View/UIGrid/uiAuctionItemTemplate", "GameObject")
    end
    return self.mPrefabGO
end

---@return UIAuctionUnionPanel
function UIAuctionPanel_AuctionUnionGridTemplate:GetRootPanel()
    return self.mRootPanel
end

--region 组件
---@return UnityEngine.GameObject 一口价按钮
function UIAuctionPanel_AuctionUnionGridTemplate:GetOnePrice_Go()
    if self.mOnePriceBtn == nil then
        self.mOnePriceBtn = self:GetUIComponentController():GetCustomType(self.mOnePriceBtnPath, "GameObject")
    end
    return self.mOnePriceBtn
end

---@return UnityEngine.GameObject 竞价按钮
function UIAuctionPanel_AuctionUnionGridTemplate:GetAuctionBtn_GO()
    if self.mAuctionPriceBtn == nil then
        self.mAuctionPriceBtn = self:GetUIComponentController():GetCustomType(self.mAuctionBtnPath, "GameObject")
    end
    return self.mAuctionPriceBtn
end

---@return UILabel 一口价价格
function UIAuctionPanel_AuctionUnionGridTemplate:GetOnePrice_UILabel()
    if self.mOnePriceLb == nil then
        self.mOnePriceLb = self:GetUIComponentController():GetCustomType(self.mOnPricePath, "UILabel")
    end
    return self.mOnePriceLb
end

---@return UISprite 一口价icon
function UIAuctionPanel_AuctionUnionGridTemplate:GetOnePrice_UISprite()
    if self.mOnePriceSp == nil and self:GetOnePrice_UILabel() then
        self.mOnePriceSp = CS.Utility_Lua.Get(self:GetOnePrice_UILabel().gameObject.transform, "ingotSymbol", "UISprite")
    end
    return self.mOnePriceSp
end

---@return UILabel 竞价价格
function UIAuctionPanel_AuctionUnionGridTemplate:GetAuctionPrice_UILabel()
    if self.mAuctionPriceLb == nil then
        self.mAuctionPriceLb = self:GetUIComponentController():GetCustomType(self.mAuctionPricePath, "UILabel")
    end
    return self.mAuctionPriceLb
end

---@return UISprite 竞价icon
function UIAuctionPanel_AuctionUnionGridTemplate:GetAuctionPrice_UISprite()
    if self.mAuctionPriceSp == nil and self:GetAuctionPrice_UILabel() then
        self.mAuctionPriceSp = CS.Utility_Lua.Get(self:GetAuctionPrice_UILabel().gameObject.transform, "ingotSymbol", "UISprite")
    end
    return self.mAuctionPriceSp
end

---@return UICountdownLabel 倒计时组件
function UIAuctionPanel_AuctionUnionGridTemplate:GetTimeCount_UICountdownLabel()
    if self.mTimeCountLb == nil then
        self.mTimeCountLb = self:GetUIComponentController():GetCustomType(self.mTimeLbPath, "UICountdownLabel")
    end
    return self.mTimeCountLb
end

---@return UnityEngine.GameObject icon
function UIAuctionPanel_AuctionUnionGridTemplate:GetIcon_GO()
    if self.mIconGo == nil then
        self.mIconGo = self:GetUIComponentController():GetCustomType(self.icon_UISprite, "GameObject")
    end
    return self.mIconGo
end

---@return UISprite good
function UIAuctionPanel_AuctionUnionGridTemplate:GetGoodSp_GO()
    if self.mGoodGO == nil and self:GetIcon_GO() then
        self.mGoodGO = CS.Utility_Lua.Get(self:GetIcon_GO().transform, "good", "UISprite")
    end
    return self.mGoodGO
end
--endregion

--region 初始化
function UIAuctionPanel_AuctionUnionGridTemplate:Init(panel)
    self.mRootPanel = panel
    self:InitComponent()
    self:BindEvents()
end

---初始化组件路径
function UIAuctionPanel_AuctionUnionGridTemplate:InitComponent()
    ---一口价按钮
    self.mOnePriceBtnPath = "Btn_Buy"
    ---竞价
    self.mAuctionBtnPath = "Btn_Auction"
    ---竞价描述
    self.mAuctionDesLb = "Des"
    ---火热
    self.mHotDes = "HotDes"
    ---一口价价格
    self.mOnPricePath = "Price"
    ---竞价价格
    self.mAuctionPricePath = "AuctionPrice"
    ---倒计时文本
    self.mTimeLbPath = "TimLabel"

    --region Item
    self.icon_UISprite = "icon"
    self.strength_UILabel = "strengthen"
    self.star_Sp = "star"
    self.count_UILabel = "count"
    self.name_UILabel = "name"
    ---@type UnityEngine.GameObject
    self.bloodSuitSignGO = "BloodLv"
    ---@type UILabel
    self.bloodSuitLevelLabel = "BloodLvLabel"

    self.boxFrame = "boxFrame"
    --endregion

end

function UIAuctionPanel_AuctionUnionGridTemplate:BindEvents()
    if not CS.StaticUtility.IsNull(self:GetOnePrice_Go()) then
        CS.UIEventListener.Get(self:GetOnePrice_Go()).onClick = function()
            self:OnOnePriceClicked()
        end
    end
    if not CS.StaticUtility.IsNull(self:GetAuctionBtn_GO()) then
        CS.UIEventListener.Get(self:GetAuctionBtn_GO()).onClick = function()
            self:OnAuctionClicked()
        end
    end
    if not CS.StaticUtility.IsNull(self:GetIcon_GO()) then
        CS.UIEventListener.Get(self:GetIcon_GO()).onClick = function()
            if self.AuctionInfo then
                local itemInfo = self:CacheItemInfo(self.AuctionInfo.item.itemId)
                if itemInfo then
                    ---@type UIItemInfoPanel_AuctionUnionBid_RightUpOperate
                    local rightUpTemplate = luaComponentTemplates.UIItemInfoPanel_AuctionUnionBid_RightUpOperate
                    uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = self.AuctionInfo.item, showAssistPanel = true, rightUpButtonsModule = rightUpTemplate, showMoreAssistData = true })
                    self:SetAuctionItemInfo()
                end
            end
        end
    end
end
--endregion

--region刷新模板显示
---刷新单条竞价
---@param data auctionV2.AuctionItemInfo
function UIAuctionPanel_AuctionUnionGridTemplate:RefreshSingleAuction(data)
    self.AuctionInfo = data
    if self.AuctionInfo == nil then
        return
    end

    local state = self.AuctionInfo.bidState
    local noOneBid = state == 0
    local hotBid = state == 1
    local isHigh = state == 2
    local higherBid = state == 3


    --竞价显示
    local des = isHigh and "本人出价最高" or ""
    local hotDes = hotBid and "火热竞价中" or (higherBid and "出价被超过" or "")
    self:GetUIComponentController():SetLabelContent(self.mAuctionDesLb, des)
    self:GetUIComponentController():SetLabelContent(self.mHotDes, hotDes)

    --按钮文本显示
    local isPublish = self:GetPublicityState()
    local isShowAuctionBtn = (not isHigh) and (not self:IsSelfShelf()) and (not isPublish) and (not self:IsSelfBid())
    self:GetUIComponentController():SetObjectActive(self.mAuctionBtnPath, isShowAuctionBtn)
    local isShowOnePriceBtn = not self:IsSelfShelf() and not isPublish
    self:GetUIComponentController():SetObjectActive(self.mOnePriceBtnPath, isShowOnePriceBtn)
    local itemInfo = clientTableManager.cfg_itemsManager:TryGetValue(self.AuctionInfo.price.itemId)
    if itemInfo then
        self:GetAuctionPrice_UISprite().spriteName = itemInfo:GetIcon()
        self:GetOnePrice_UISprite().spriteName = itemInfo:GetIcon()
    end
    local bidData = self.AuctionInfo.auctionItemLotInfo
    if bidData then
        local num = self.AuctionInfo.item.count

        self:GetOnePrice_UILabel().text = bidData.fixedPrice
        local price = bidData.bidPrice
        local showPrice = ternary(price == 0, self.AuctionInfo.price.count * num, price)
        self:GetAuctionPrice_UILabel().text = showPrice
    end
    --倒计时
    self:ShowTime()

    --道具
    self:RefreshItemShow(data.item)

    self:GetUIComponentController():Apply()
    self:GetAuctionPrice_UISprite():UpdateAnchors()
    self:GetOnePrice_UISprite():UpdateAnchors()
end

---@return boolean 是否是自己上架道具
function UIAuctionPanel_AuctionUnionGridTemplate:IsSelfShelf()
    if self.AuctionInfo then
        local selfID = self:GetRootPanel():GetMainPlayerInfo().ID
        return self.AuctionInfo.roleId == selfID
    end
    return false
end

function UIAuctionPanel_AuctionUnionGridTemplate:SetPublicity(state)
    self.mIsPublicity = state
end

---@return boolean 是否在公示期 true公示中
function UIAuctionPanel_AuctionUnionGridTemplate:GetPublicityState()
    if self.AuctionInfo and self.AuctionInfo.auctionItemLotInfo then
        local isPublicity = self.AuctionInfo.auctionItemLotInfo.isPublicity
        local publicityTime = self.AuctionInfo.auctionItemLotInfo.publicityTime
        local isPublicityOver = Utility.IsTimeOverByMillisecondTimeStamp(publicityTime)
        return isPublicity and not isPublicityOver
    end
    return false
end

---@return boolean 是否是自己竞价道具
function UIAuctionPanel_AuctionUnionGridTemplate:IsSelfBid()
    if self.AuctionInfo then
        local selfID = self:GetRootPanel():GetMainPlayerInfo().ID
        return self.AuctionInfo.auctionItemLotInfo.bidderRid == selfID
    end
    return false
end
--endregion

--region 竞价
function UIAuctionPanel_AuctionUnionGridTemplate:OnAuctionClicked()
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
    self:ClearBuyAuctionInfo()
end
--endregion

--region 一口价
function UIAuctionPanel_AuctionUnionGridTemplate:OnOnePriceClicked()
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

---设置即将购买道具信息
function UIAuctionPanel_AuctionUnionGridTemplate:SetAuctionItemInfo()
    if self:GetRootPanel() and self.AuctionInfo then
        local itemId = self.AuctionInfo.item.itemId
        local pos = self:GetIcon_GO().transform.position
        self:GetRootPanel():SetBuyItemInfo(itemId, pos, self.AuctionInfo)
    end
end
function UIAuctionPanel_AuctionUnionGridTemplate:SetAuctionItemInfo()
    if self:GetRootPanel() and self.AuctionInfo then
        local itemId = self.AuctionInfo.item.itemId
        local pos = self:GetIcon_GO().transform.position
        self:GetRootPanel():SetBuyItemInfo(itemId, pos, self.AuctionInfo)
    end
end

function UIAuctionPanel_AuctionUnionGridTemplate:ClearBuyAuctionInfo()
    if self:GetRootPanel() then
        self:GetRootPanel():ClearBuyItemInfo()
    end
end
--endregion

--region 时间
---显示时间
function UIAuctionPanel_AuctionUnionGridTemplate:ShowTime()
    if self.AuctionInfo and self.AuctionInfo.auctionItemLotInfo then
        local isPublicity = self.AuctionInfo.auctionItemLotInfo.isPublicity
        local publicityTime = self.AuctionInfo.auctionItemLotInfo.publicityTime
        local isPublicityOver = Utility.IsTimeOverByMillisecondTimeStamp(publicityTime)
        if isPublicity and not isPublicityOver then
            self:GetTimeCount_UICountdownLabel():StartCountDown(nil, 5, publicityTime, luaEnumColorType.Red, "[-]\n \n(公示期)", nil, function()
                self:OverTimeCountDown()
            end)
            return
        end
        self:OverTimeCountDown()
    end
end

---公示到期 倒计时到期时间
function UIAuctionPanel_AuctionUnionGridTemplate:OverTimeCountDown()
    local overTime = self.AuctionInfo.overdueTime
    local isOver = Utility.IsTimeOverByMillisecondTimeStamp(overTime)
    if overTime and not isOver then
        self:GetTimeCount_UICountdownLabel():StartCountDown(nil, 5, overTime, luaEnumColorType.Red, nil, nil, function()
            self:GetUIComponentController():SetLabelContent(self.mTimeCountLb, "过期")
        end)
    else
        self:GetUIComponentController():SetLabelContent(self.mTimeCountLb, "过期")
    end
end
--endregion

--region 刷新道具
---@param bagItemInfo bagV2.BagItemInfo
function UIAuctionPanel_AuctionUnionGridTemplate:RefreshItemShow(bagItemInfo)
    if bagItemInfo == nil then
        return
    end
    local auctionItemInfo = clientTableManager.cfg_itemsManager:TryGetValue(bagItemInfo.itemId)
    if auctionItemInfo == nil then
        return
    end
    --icon
    self:GetUIComponentController():SetSpriteName(self.icon_UISprite, auctionItemInfo:GetIcon())
    self:GetUIComponentController():SetObjectActive(self.boxFrame, true)
    local name = Utility.GetShortShowLabel(auctionItemInfo:GetName())
    self:GetUIComponentController():SetLabelContent(self.name_UILabel, name)
    self:GetUIComponentController():SetLabelContent(self.count_UILabel, bagItemInfo.count > 1 and bagItemInfo.count or "")

    --更好
    local csBagItemInfo = protobufMgr.DecodeTable.bag.BagItemInfo(bagItemInfo)
    local type = Utility.GetArrowType(csBagItemInfo)
    self:GetGoodSp_GO().gameObject:SetActive(type ~= LuaEnumArrowType.NONE)
    if type ~= LuaEnumArrowType.NONE then
        local sp = CS.Cfg_GlobalTableManager.Instance:GetArrowSpriteName(type)
        self:GetGoodSp_GO().spriteName = sp
    end

    --星级
    local isShowStrength = bagItemInfo and bagItemInfo.intensify and bagItemInfo.intensify > 0
    if isShowStrength then
        local showInfo, icon = Utility.GetIntensifyShow(bagItemInfo.intensify)
        self:GetUIComponentController():SetLabelContent(self.strength_UILabel, showInfo)
        self:GetUIComponentController():SetSpriteName(self.star_Sp, icon)
    end
    self:GetUIComponentController():SetObjectActive(self.strength_UILabel, isShowStrength)
    self:GetUIComponentController():SetObjectActive(self.star_Sp, isShowStrength)

    --血继
    local isShowBlood = bagItemInfo and bagItemInfo.bloodLevel > 0
    self:GetUIComponentController():SetObjectActive(self.bloodSuitSignGO, isShowBlood)
    self:GetUIComponentController():SetLabelContent(self.bloodSuitLevelLabel, isShowBlood and bagItemInfo.bloodLevel or "")
end

--endregion

---@return TABLE.cfg_items 缓存item信息
function UIAuctionPanel_AuctionUnionGridTemplate:CacheItemInfo(itemId)
    if self:GetRootPanel() then
        return self:GetRootPanel():GetItemInfoCache(itemId)
    end
end

return UIAuctionPanel_AuctionUnionGridTemplate