---@class UISuperJuLingZhuPanel:UIBase 超级聚灵珠面板
local UISuperJuLingZhuPanel = {}

--region 局部变量定义
UISuperJuLingZhuPanel.mCurrentCostType = LuaEnumCoinType.JuLingDian
UISuperJuLingZhuPanel.EffectParent = nil
UISuperJuLingZhuPanel.mOtherChooseCost = LuaEnumCoinType.YuanBao
--endregion

--region 组件
---@return UISprite icon
function UISuperJuLingZhuPanel:GetIcon_UISprite()
    if self.mIconSp == nil then
        self.mIconSp = self:GetCurComp("WidgetRoot/window/background/Icon", "UISprite")
    end
    return self.mIconSp
end

---@return UILabel 标题文字
function UISuperJuLingZhuPanel:TitleLabel_UILabel()
    if self.mTitleLabel_UILabel == nil then
        self.mTitleLabel_UILabel = self:GetCurComp("WidgetRoot/window/background/Label", "UILabel")
    end
    return self.mTitleLabel_UILabel
end

---@return UILabel 经验值
function UISuperJuLingZhuPanel:ExpValue_UILabel()
    if self.mExpValue_UILabel == nil then
        self.mExpValue_UILabel = self:GetCurComp("WidgetRoot/view/expvalue", "UILabel")
    end
    return self.mExpValue_UILabel
end

---@return UILabel 倍数文字
function UISuperJuLingZhuPanel:CountLabel_UILabel()
    if self.mCountLabel_UILabel == nil then
        self.mCountLabel_UILabel = self:GetCurComp("WidgetRoot/view/Count", "UILabel")
    end
    return self.mCountLabel_UILabel
end

---@return UnityEngine.GameObject 关闭按钮
function UISuperJuLingZhuPanel:CloseButton_GO()
    if self.mCloseBtn_GO == nil then
        self.mCloseBtn_GO = self:GetCurComp("WidgetRoot/events/btn_close", "GameObject")
    end
    return self.mCloseBtn_GO
end

---@return UnityEngine.GameObject 使用按钮
function UISuperJuLingZhuPanel:GetUseBtn_GO()
    if self.mUseBtnGo == nil then
        self.mUseBtnGo = self:GetCurComp("WidgetRoot/view/singleprice/btn", "GameObject")
    end
    return self.mUseBtnGo
end

---@return UILabel 按钮文本
function UISuperJuLingZhuPanel:GetUseBtn_UILabel()
    if self.mUseBtnLb == nil then
        self.mUseBtnLb = self:GetCurComp("WidgetRoot/view/singleprice/btn/Label", "UILabel")
    end
    return self.mUseBtnLb
end

---@return UISprite 单个价格Icon
function UISuperJuLingZhuPanel:GetSinglePriceIcon_UISprite()
    if self.mSinglePriceIcon == nil then
        self.mSinglePriceIcon = self:GetCurComp("WidgetRoot/view/singleprice/price/icon", "UISprite")
    end
    return self.mSinglePriceIcon
end

---@return UILabel 价格文本
function UISuperJuLingZhuPanel:GetPrice_UILabel()
    if self.mPriceLb == nil then
        self.mPriceLb = self:GetCurComp("WidgetRoot/view/singleprice/price", "UILabel")
    end
    return self.mPriceLb
end

---升级特效节点
function UISuperJuLingZhuPanel:GetLevelEffectRoot()
    if (self.mLevelEffectRoot == nil) then
        ---@type UIAllTextTipsContainerPanel
        local panel = uimanager:GetPanel("UIAllTextTipsContainerPanel")
        if (panel ~= nil) then
            self.mLevelEffectRoot = panel.GetEffectRoot_GameObject()
        end
    end
    return self.mLevelEffectRoot
end

---@return UISlider 数目滑动条
function UISuperJuLingZhuPanel:GetNum_Slider()
    if self.mNumSlider == nil then
        self.mNumSlider = self:GetCurComp("WidgetRoot/view/expslider", "UISlider")
    end
    return self.mNumSlider
end

---@return UIToggle
function UISuperJuLingZhuPanel:GetLeftToggle()
    if self.mLeftToggle == nil then
        self.mLeftToggle = self:GetCurComp("WidgetRoot/view/CostItem/GoldIngot", "UIToggle")
    end
    return self.mLeftToggle
end

---@return UILabel 左边Toggle文本
function UISuperJuLingZhuPanel:GetLeftToggle_UILabel()
    if self.mLeftToggleLb == nil then
        self.mLeftToggleLb = self:GetCurComp("WidgetRoot/view/CostItem/GoldIngot/Label", "UILabel")
    end
    return self.mLeftToggleLb
end

---@return UIToggle 聚灵点
function UISuperJuLingZhuPanel:GetRightToggle()
    if self.mRightToggle == nil then
        self.mRightToggle = self:GetCurComp("WidgetRoot/view/CostItem/JuLingPoint", "UIToggle")
    end
    return self.mRightToggle
end

---@return UILabel 右边Toggle文本
function UISuperJuLingZhuPanel:GetRightToggle_UILabel()
    if self.mRightToggleLb == nil then
        self.mRightToggleLb = self:GetCurComp("WidgetRoot/view/CostItem/JuLingPoint/Label", "UILabel")
    end
    return self.mRightToggleLb
end

---@return UILabel 聚灵点Toggle名字
function UISuperJuLingZhuPanel:GetRightToggle_UILabel()
    if self.mRightToggleLb == nil then
        self.mRightToggleLb = self:GetCurComp("WidgetRoot/view/CostItem/JuLingPoint/Label", "UILabel")
    end
    return self.mRightToggleLb
end

---@return UnityEngine.GameObject
function UISuperJuLingZhuPanel:GetAddBtn_Go()
    if self.mAddGo == nil then
        self.mAddGo = self:GetCurComp("WidgetRoot/view/singleprice/price/add", "GameObject")
    end
    return self.mAddGo
end

---加号图片
---@return UISprite
function UISuperJuLingZhuPanel:GetAddBtn_Sprite()
    if self.mAddBtnSprite == nil then
        self.mAddBtnSprite = self:GetCurComp("WidgetRoot/view/singleprice/price/add", "UISprite")
    end
    return self.mAddBtnSprite
end
--endregion

--region 数据
---@return CSMainPlayerInfo 玩家信息
function UISuperJuLingZhuPanel:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

---@return CSBagInfoV2 背包信息
function UISuperJuLingZhuPanel:GetBagInfoV2()
    if self.mBagInfoV2 == nil and self:GetMainPlayerInfo() then
        self.mBagInfoV2 = self:GetMainPlayerInfo().BagInfo
    end
    return self.mBagInfoV2
end

---@return number 获取聚灵珠花费道具信息
---@param type number 货币id1/货币数目2
function UISuperJuLingZhuPanel:GetCostInfo(type)
    local itemInfo = self:GetCurrentJuLingZhuItemInfo()
    if self.CostInfo == nil and itemInfo then
        self.CostInfo = CS.Cfg_GlobalTableManager.Instance:GetJvLingZhuCostInfoBtItemId(itemInfo.id)
    end
    if self.CostInfo then
        if type == 1 then
            return self.CostInfo.PriceItemId
        elseif type == 2 then
            return self.CostInfo.Price
        end
    end
    return -1
end

---@param type number 聚灵点数目1/聚灵点使用次数2
function UISuperJuLingZhuPanel:GetJLDInfo(type)
    if self:GetBagInfoV2() then
        if type == 1 then
            return self:GetBagInfoV2():GetCoinAmount(LuaEnumCoinType.JuLingDian)
        else
            local num = self:GetBagInfoV2().CurrentUseSuperJLDNum
            if num == nil then
                num = 0
            end
            return num
        end
    end
    return -1
end


--endregion

--region 初始化
function UISuperJuLingZhuPanel:Init()
    self:BindUIEvents()
    self:BindMessage()
end

---@type bagV2.BagItemInfo 聚灵珠对应的背包物品
---@type TABLE.CFG_ITEMS
function UISuperJuLingZhuPanel:Show(customData)
    if customData.info == nil then
        self:ClosePanel()
        return
    end
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.JLZPanel
    self:AddCollider()
    ---@type TABLE.CFG_ITEMS
    self.mItemInfo = customData.info
    self:InitCurrentPanelShow()
    --if self:GetJLDInfo(2) <= 10 and not Utility.IsSuperJLZ(self.mItemInfo.id) then
    --    Utility.ShowPopoTips(self:GetUseBtn_GO(), nil, 323)
    --end
end

function UISuperJuLingZhuPanel:BindUIEvents()
    CS.UIEventListener.Get(self:GetIcon_UISprite().gameObject).onClick = function()
        self:ShowItemInfo()
    end

    CS.UIEventListener.Get(self:CloseButton_GO()).onClick = function()
        self:ClosePanel()
    end

    CS.UIEventListener.Get(self:GetUseBtn_GO()).onClick = function(go)
        self:OnUseClicked(go)
    end

    CS.EventDelegate.Add(self:GetLeftToggle().onChange, function()
        if self:GetLeftToggle().value then
            self:RefreshCurrentCost(self.mOtherChooseCost)
        end
    end)

    CS.EventDelegate.Add(self:GetRightToggle().onChange, function()
        if self:GetRightToggle().value then
            self:RefreshCurrentCost(LuaEnumCoinType.JuLingDian)
        end
    end)

    CS.EventDelegate.Add(self:GetNum_Slider().onChange, function()
        self:RefreshSliderValue()
    end)

    CS.UIEventListener.Get(self:GetAddBtn_Go()).onClick = function(go)
        self:ShowTips(go)
    end

    CS.UIEventListener.Get(self:GetSinglePriceIcon_UISprite().gameObject).onClick = function()
        local info = self:GetItemInfoCache(self.mCurrentCostType)
        if info then
            uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = info, showRight = false })
        end
    end
end

function UISuperJuLingZhuPanel:BindMessage()
    self:GetClientEventHandler():AddEvent(CS.CEvent.Role_UpdateLevel_Delay, function()
        self:RefreshCurrentPanelShow()
        self:ShowRoleLevelUpEffect()
    end)

    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BagCoinsChanged, function()
        self:RefreshPriceShow()
    end)

    self:GetLuaEventHandler():BindNetMsg(LuaEnumNetDef.ResBagChangeMessage, UISuperJuLingZhuPanel.OnResBagChangeMessageReceived)
end

--endregion

--region客户端消息
---播放升级特效
function UISuperJuLingZhuPanel:ShowRoleLevelUpEffect()
    if (uiStaticParameter.LevelUpEffect == nil) then
        UISuperJuLingZhuPanel.LoadEffect('700115', UISuperJuLingZhuPanel:GetLevelEffectRoot().transform, function(path, obj)
            uiStaticParameter.LevelUpEffect = obj
        end)
    else
        uiStaticParameter.LevelUpEffect:SetActive(false)
        uiStaticParameter.LevelUpEffect:SetActive(true)
    end
end

function UISuperJuLingZhuPanel.LoadEffect(code, parent, CallBack)
    UISuperJuLingZhuPanel.EffectParent = parent
    UISuperJuLingZhuPanel.CallBack = CallBack
    CS.CSResourceManager.Singleton:AddQueueCannotDelete(code, CS.ResourceType.UIEffect, UISuperJuLingZhuPanel.LevelUpEffectFinished, CS.ResourceAssistType.UI)
end

function UISuperJuLingZhuPanel.LevelUpEffectFinished(res)
    if res ~= nil or res.MirrorObj ~= nil then
        --设置父物体
        if CS.StaticUtility.IsNull(UISuperJuLingZhuPanel.EffectParent) then
            return
        end
        UISuperJuLingZhuPanel.promptEffect_Path = res.Path
        local go = res:GetObjInst()
        if go then
            go.transform.parent = UISuperJuLingZhuPanel.EffectParent
            go.transform.localPosition = CS.UnityEngine.Vector3(0, 200, 0)
            go.transform.localScale = CS.UnityEngine.Vector3.one
        end
        if UISuperJuLingZhuPanel.CallBack then
            UISuperJuLingZhuPanel.CallBack(res.Path, go)
        end
    end
end
--endregion

--region 服务器消息

function UISuperJuLingZhuPanel.OnResBagChangeMessageReceived(id, data)
    if data.action ~= nil and data.action == 2052 then
        UISuperJuLingZhuPanel:InitCurrentPanelShow()
    end
end
--endregion

--region UI事件
---点击聚灵珠icon
function UISuperJuLingZhuPanel:ShowItemInfo()
    local bagItemInfo = self:GetCurrentJuLingZhuBagItemInfo()
    if bagItemInfo then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ bagItemInfo = bagItemInfo, showRight = false })
    end
end

---刷新当前聚灵珠数目及信息
function UISuperJuLingZhuPanel:RefreshCurrentGatheringBeads()
    local itemInfo = self:GetCurrentJuLingZhuItemInfo()
    if itemInfo then
        local mBagItems = self:GetBagInfoV2():GetGatheringBeads(itemInfo.id)
        if mBagItems and mBagItems.Count > 0 then
            self.mBagItemInfo = mBagItems[0]

            local num = 0
            for i = 0, mBagItems.Count - 1 do
                num = num + mBagItems[i].count
            end
            self.mCount = num
        else
            self:ClosePanel()
        end
    end
end

---@return bagV2.BagItemInfo
function UISuperJuLingZhuPanel:GetCurrentJuLingZhuBagItemInfo()
    return self.mBagItemInfo
end

---@return TABLE.CFG_ITEMS
function UISuperJuLingZhuPanel:GetCurrentJuLingZhuItemInfo()
    return self.mItemInfo
end

---@return number 聚灵珠数目
function UISuperJuLingZhuPanel:GetCurrentJuLingZhuNum()
    return self.mCount
end

---初始化界面显示
function UISuperJuLingZhuPanel:InitCurrentPanelShow()
    local itemInfo = self:GetCurrentJuLingZhuItemInfo()
    if itemInfo then
        self:GetIcon_UISprite().spriteName = itemInfo.icon
        self:TitleLabel_UILabel().text = itemInfo.name
    end
    --self:GetCoinCostAndPlayerHas(self.mOtherChooseCost)
    --聚灵点数量
    local point = self:GetJLDInfo(1)
    local perCost, playerHas = self:GetCoinCostAndPlayerHas(self.mOtherChooseCost)
    self:RefreshCurrentPanelShow()

    --大聚灵珠
    if (itemInfo.id == 8040007) then
        --优先使用元宝
        if playerHas >= perCost then
            self:GetLeftToggle():Set(true)
        elseif (point > 0) then
            --没有足够的元宝,但是存在聚灵点,那么使用聚灵点
            self:GetRightToggle():Set(true)
        else
            self:GetLeftToggle():Set(true)
        end
    elseif (itemInfo.id == 8040015) then
        --超级聚灵珠ID == 8040015
        --优先使用聚灵点
        if point > 0 then
            self:GetRightToggle():Set(true)
        elseif (playerHas >= perCost) then
            --聚灵点不足,如果有足够的元宝
            self:GetLeftToggle():Set(true)
        else
            self:GetRightToggle():Set(true)
        end
    else
        if point > 0 then
            self:GetRightToggle():Set(true)
        else
            if playerHas >= perCost then
                self:GetLeftToggle():Set(true)
            else
                self:GetRightToggle():Set(true)
            end
        end
    end
    self:RefreshSliderValue()
end

---刷新界面显示
function UISuperJuLingZhuPanel:RefreshCurrentPanelShow()
    self:RefreshCurrentGatheringBeads()
    local bagItemInfo = self:GetCurrentJuLingZhuBagItemInfo()
    if bagItemInfo then
        self:ExpValue_UILabel().text = bagItemInfo.maxStar .. "经验"
    end

    local count = self:GetCurrentJuLingZhuNum()
    self:CountLabel_UILabel().gameObject:SetActive(count and count > 1)
    if count then
        self:CountLabel_UILabel().text = "x " .. count
    end
    local leftName = CS.Cfg_ItemsTableManager.Instance:GetItemName(self.mOtherChooseCost)
    local rightName = CS.Cfg_ItemsTableManager.Instance:GetItemName(LuaEnumCoinType.JuLingDian)
    if leftName and rightName then
        self:GetLeftToggle_UILabel().text = luaEnumColorType.Gray .. leftName
        self:GetRightToggle_UILabel().text = luaEnumColorType.Gray .. rightName
    end
end

---点击使用聚灵珠
function UISuperJuLingZhuPanel:OnUseClicked(go)
    if self.mClosePanel then
        return
    end
    local itemInfo = self:GetCurrentJuLingZhuItemInfo()
    local perCost, playerHas = self:GetCoinCostAndPlayerHas(self.mCurrentCostType)
    if self.mUseNum and itemInfo then
        local totalCost = self.mUseNum * perCost
        if totalCost <= playerHas then
            local isJLD = self.mCurrentCostType == LuaEnumCoinType.JuLingDian and 1 or 0
            networkRequest.ReqUseExpBox(itemInfo.id, self.mUseNum, isJLD)
            self:ShowJULINGBallEffect()
            self:RefreshCurrentGatheringBeads()
        else
            self:ShowTips(go)
        end
    end
end

---刷新当前货币
function UISuperJuLingZhuPanel:RefreshCurrentCost(type)
    self.mCurrentCostType = type
    self:SetStartSliderValue(type)
    local info = self:GetItemInfoCache(self.mCurrentCostType)
    if info then
        self:GetSinglePriceIcon_UISprite().spriteName = info.icon
    end
    self:RefreshSliderValue()
end

---刷新滑动条状态
function UISuperJuLingZhuPanel:RefreshSliderValue()
    local maxNum = self:GetCurrentJuLingZhuNum()
    --self:GetNum_Slider().gameObject:SetActive(self:IsShowSlider())
    if self:IsShowSlider() and maxNum and maxNum > 1 then
        self:GetNum_Slider().gameObject:SetActive(true)
        local rate = self:GetNum_Slider().value
        if rate and maxNum then
            self.mUseNum = math.floor((maxNum - 1) * rate + 1)
        end
    else
        self.mUseNum = 1
        self:GetNum_Slider().gameObject:SetActive(false)
    end
    self:RefreshPriceShow()
end

function UISuperJuLingZhuPanel:IsShowSlider()
    if self:GetMainPlayerInfo() then
        local limit = CS.Cfg_GlobalTableManager.Instance:GetShowJLZSliderLevel()
        if limit then
            return CS.Cfg_ConditionManager.Instance:IsMainPlayerMatchCondition(limit)
        end
    end
    return false
end

---刷新价格显示
function UISuperJuLingZhuPanel:RefreshPriceShow()
    local itemInfo = self:GetCurrentJuLingZhuItemInfo()
    if self.mUseNum and itemInfo then
        self:GetUseBtn_UILabel().text = "使用" .. self.mUseNum .. "个"
        local perCost, playerHas = self:GetCoinCostAndPlayerHas(self.mCurrentCostType)
        local needCost = perCost * self.mUseNum
        local color = needCost <= playerHas and "" or "[E85038]"
        if self.mCurrentCostType == LuaEnumCoinType.JuLingDian then
            self:GetPrice_UILabel().text = color .. tostring(playerHas) .. "[-]/" .. tostring(needCost)
        else
            self:GetPrice_UILabel().text = color .. tostring(needCost)
        end
        if needCost <= playerHas then
            self:GetAddBtn_Sprite().spriteName = "add_small2"
        else
            self:GetAddBtn_Sprite().spriteName = "add_small"
        end
        self:GetIcon_UISprite():UpdateAnchors()
        self:GetAddBtn_Sprite():UpdateAnchors()
    end
end

---聚灵珠使用特效
function UISuperJuLingZhuPanel:ShowJULINGBallEffect()
    ---@type UIMainChatPanel
    local panel = uimanager:GetPanel('UIMainChatPanel')
    if panel then
        panel.ShowJLZEffect(nil)
    end
end

---@param go UnityEngine.GameObject 提示框id
function UISuperJuLingZhuPanel:ShowTips(go)
    local coinID = self.mCurrentCostType
    local EntranceWay
    if (uiStaticParameter.RechargePointPanelType == LuaEnumRechargePointEntranceType.JLZPanel) then
        if (coinID == LuaEnumCoinType.JuLingDian) then
            EntranceWay = LuaEnumRechargePointType.UseJLZPointNotEnough
        elseif (coinID == LuaEnumCoinType.JinBi) then
            EntranceWay = LuaEnumRechargePointType.UseJLZGoldNotEnough
        elseif (coinID == LuaEnumCoinType.YuanBao) then
            EntranceWay = LuaEnumRechargePointType.UseJLZIngotNotEnough
        elseif Utility.IsItemDiamond(coinID) then
            EntranceWay = LuaEnumRechargePointType.UseJLZDiamondNotEnough
        end
    end
    if Utility.IsItemDiamond(self.mCurrentCostType) then
        Utility.JumpRechargePanel(go, EntranceWay)
    else
        Utility.ShowItemGetWay(self.mCurrentCostType, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, EntranceWay)
    end
end

---设置初始Slider值
function UISuperJuLingZhuPanel:SetStartSliderValue(type)
    local maxNum = self:GetCurrentJuLingZhuNum()
    if (maxNum == nil) then
        maxNum = 0
    end
    local buyNum = 0
    local perCost, playerHas = self:GetCoinCostAndPlayerHas(type)
    if playerHas then
        local playerCanBuy = math.floor(playerHas / perCost)
        if (playerCanBuy == nil) then
            playerCanBuy = 0;
        end
        buyNum = math.min(playerCanBuy, maxNum)
    end

    if maxNum ~= 0 then
        local rate = 1 - (maxNum - buyNum) / maxNum
        self:GetNum_Slider().value = rate
    end

end

---获取对应货币每个聚灵珠花费以及玩家货币数目
function UISuperJuLingZhuPanel:GetCoinCostAndPlayerHas(coinType)
    local perCost = 0
    local playerHas = 0
    local itemInfo = self:GetCurrentJuLingZhuItemInfo()
    if itemInfo then
        if coinType == LuaEnumCoinType.JuLingDian then
            perCost = CS.Cfg_GlobalTableManager.Instance:GetJLZCostJLDNum(itemInfo.id)
            ---@tyoe roleV2.GatherSpritePointInfo
            playerHas = self:GetJLDInfo(1)

        else
            local costNum = CS.Cfg_GlobalTableManager.Instance:GetJvLingZhuCostInfoBtItemId(itemInfo.id)
            if costNum then
                perCost = costNum.Price
                self.mOtherChooseCost = costNum.PriceItemId
                playerHas = self:GetBagInfoV2():GetCoinAmount(costNum.PriceItemId)
            end
        end
    end
    return perCost, playerHas
end

---@return boolean 当前使用聚灵珠花费是否足够
function UISuperJuLingZhuPanel:GetUseJLZCostEnough()
    local costId = UIJuLingZhuPanel.ItemIdToCoinId[UIJuLingZhuPanel.mItemInfo.id]
    local singlePay = UIJuLingZhuPanel.ItemIdToCostNum[UIJuLingZhuPanel.mItemInfo.id]
    local playerHas = 0
    if singlePay then
        playerHas = CS.CSScene.MainPlayerInfo.BagInfo:GetCoinAmount(costId)
    end
    return singlePay <= playerHas
end

---@return TABLE.CFG_ITEMS
function UISuperJuLingZhuPanel:GetItemInfoCache(itemId)
    if self.mItemIdToInfo == nil then
        self.mItemIdToInfo = {}
    end
    local info = self.mItemIdToInfo[itemId]
    if info == nil then
        ___, info = CS.Cfg_ItemsTableManager.Instance.dic:TryGetValue(itemId)
        self.mItemIdToInfo[itemId] = info
    end
    return info
end
--endregion

--region OnDestroy
function ondestroy()
    --commonNetMsgDeal.RemoveCallback(LuaEnumNetDef.ResBagChangeMessage, UISuperJuLingZhuPanel.OnResBagChangeMessageReceived)

    if UISuperJuLingZhuPanel:GetCurrentJuLingZhuBagItemInfo() and UISuperJuLingZhuPanel:GetBagInfoV2() then
        UISuperJuLingZhuPanel:GetBagInfoV2():RemoveBeadsList(UISuperJuLingZhuPanel:GetCurrentJuLingZhuBagItemInfo().itemId)
    end
end
--endregion

return UISuperJuLingZhuPanel