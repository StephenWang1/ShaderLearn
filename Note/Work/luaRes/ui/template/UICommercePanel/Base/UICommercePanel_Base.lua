---@class UICommercePanel_Base:TemplateBase 月卡界面模板
local UICommercePanel_Base = {}
--region 参数
---购买价格
UICommercePanel_Base.buyPeice = nil
---描述默认间隔
UICommercePanel_Base.describeInterval = 0
---月卡名字
UICommercePanel_Base.MonthCardName = ""
--endregion

--region 组件
---未购买显示内容
function UICommercePanel_Base:GetSlogan_GameObject()
    if self.Slogan_GameObject == nil or CS.StaticUtility.IsNull(self.Slogan_GameObject) then
        self.Slogan_GameObject = self:Get("panel/slogan", "GameObject")
    end
    return self.Slogan_GameObject
end

---已购买显示内容
function UICommercePanel_Base:GetBuyShowContent_GameObject()
    if self.BuyShowContent_GameObject == nil or CS.StaticUtility.IsNull(self.BuyShowContent_GameObject) then
        self.BuyShowContent_GameObject = self:Get("panel/name", "GameObject")
    end
    return self.BuyShowContent_GameObject
end

---已购买名字显示内容
function UICommercePanel_Base:GetBuyShowContent_UILabel()
    if self.BuyShowContent_UILabel == nil or CS.StaticUtility.IsNull(self.BuyShowContent_UILabel) then
        self.BuyShowContent_UILabel = self:Get("panel/name/label", "UILabel")
    end
    return self.BuyShowContent_UILabel
end

---信息详情面板
function UICommercePanel_Base:GetPrivilege_UIGridContainer()
    if self.Privilege_UIGridContainer == nil or CS.StaticUtility.IsNull(self.Privilege_UIGridContainer) then
        self.Privilege_UIGridContainer = self:Get("panel/privilege/Describe/grid", "UIGridContainer")
    end
    return self.Privilege_UIGridContainer
end

---信息详情面板
function UICommercePanel_Base:GetPrivilege_GameObject()
    if self.Privilege_GameObject == nil or CS.StaticUtility.IsNull(self.Privilege_GameObject) then
        self.Privilege_GameObject = self:Get("panel/privilege", "GameObject")
    end
    return self.Privilege_GameObject
end

---结束时间文本
function UICommercePanel_Base:GetEndTime_UILabel()
    if self.EndTime_UILabel == nil or CS.StaticUtility.IsNull(self.EndTime_UILabel) then
        self.EndTime_UILabel = self:Get("panel/name/validityTerm", "UILabel")
    end
    return self.EndTime_UILabel
end

---续费时间文本
function UICommercePanel_Base:GetRenewTime_UILabel()
    if self.RenewTime_UILabel == nil or CS.StaticUtility.IsNull(self.RenewTime_UILabel) then
        self.RenewTime_UILabel = self:Get("panel/name/renewReminder", "UILabel")
    end
    return self.RenewTime_UILabel
end

---现价
function UICommercePanel_Base:GetNowPrice_UILabel()
    if self.NowPrice_UILabel == nil or CS.StaticUtility.IsNull(self.NowPrice_UILabel) then
        self.NowPrice_UILabel = self:Get("panel/price", "UILabel")
    end
    return self.NowPrice_UILabel
end

---现价图片
function UICommercePanel_Base:GetNowPrice_UISprite()
    if self.NowPrice_UISprite == nil or CS.StaticUtility.IsNull(self.NowPrice_UISprite) then
        self.NowPrice_UISprite = self:Get("panel/price/priceSprite", "UISprite")
    end
    return self.NowPrice_UISprite
end

---现价图片2
function UICommercePanel_Base:GetNowPrice2_UISprite()
    if self.NowPrice2_UISprite == nil or CS.StaticUtility.IsNull(self.NowPrice2_UISprite) then
        self.NowPrice2_UISprite = self:Get("panel/price/priceSprite2", "UISprite")
    end
    return self.NowPrice2_UISprite
end

---原价
function UICommercePanel_Base:GetOriginPrice_UILabel()
    if self.OriginPrice_UILabel == nil or CS.StaticUtility.IsNull(self.OriginPrice_UILabel) then
        self.OriginPrice_UILabel = self:Get("panel/origin", "UILabel")
    end
    return self.OriginPrice_UILabel
end

---原价图片
function UICommercePanel_Base:GetOriginPrice_UISprite()
    if self.OriginPrice_UISprite == nil or CS.StaticUtility.IsNull(self.OriginPrice_UISprite) then
        self.OriginPrice_UISprite = self:Get("panel/origin/priceSprite", "UISprite")
    end
    return self.OriginPrice_UISprite
end

---购买按钮
function UICommercePanel_Base:GetJoinBtn_GameObject()
    if self.JoinBtn_GameObject == nil or CS.StaticUtility.IsNull(self.JoinBtn_GameObject) then
        self.JoinBtn_GameObject = self:Get("events/btn_join", "GameObject")
    end
    return self.JoinBtn_GameObject
end

---前往驻地按钮
function UICommercePanel_Base:GetToStationBtn_GameObject()
    if self.ToStationBtn_GameObject == nil or CS.StaticUtility.IsNull(self.ToStationBtn_GameObject) then
        self.ToStationBtn_GameObject = self:Get("events/btn_ToStation", "GameObject")
    end
    return self.ToStationBtn_GameObject
end

---立即续费按钮
function UICommercePanel_Base:GetRenew_GameObject()
    if self.Renew_GameObject == nil or CS.StaticUtility.IsNull(self.Renew_GameObject) then
        self.Renew_GameObject = self:Get("events/btn_Renew", "GameObject")
    end
    return self.Renew_GameObject
end

---立即续费按钮文本
function UICommercePanel_Base:GetRenew_UILabel()
    if self.Renew_UILabel == nil or CS.StaticUtility.IsNull(self.Renew_UILabel) then
        self.Renew_UILabel = self:Get("events/btn_Renew/template/label", "UILabel")
    end
    return self.Renew_UILabel
end

---必买图片
function UICommercePanel_Base:GetMustBuy_GameObject()
    if self.MustBuy_GameObject == nil or CS.StaticUtility.IsNull(self.Renew_GameObject) then
        self.MustBuy_GameObject = self:Get("panel/title/mustBuy", "GameObject")
    end
    return self.MustBuy_GameObject
end

---关闭按钮
function UICommercePanel_Base:GetCloseBtn_GameObject()
    if self.CloseBtn_GameObject == nil or CS.StaticUtility.IsNull(self.CloseBtn_GameObject) then
        self.CloseBtn_GameObject = self:Get("events/btn_close", "GameObject")
    end
    return self.CloseBtn_GameObject
end

---商会权利列表
function UICommercePanel_Base:GetGrid_UIGridContainer()
    if self.Grid_UIGridContainer == nil or CS.StaticUtility.IsNull(self.Grid_UIGridContainer) then
        self.Grid_UIGridContainer = self:Get("panel/ScrollView/Grid", "UIGridContainer")
    end
    return self.Grid_UIGridContainer
end

function UICommercePanel_Base:GetDayTime_GameObject()
    if(self.mDayTime_GameObject == nil) then
        self.mDayTime_GameObject = self:Get("panel/Time","GameObject");
    end
    return self.mDayTime_GameObject;
end

---商会权利列表
function UICommercePanel_Base:GetGrid_GameObject()
    if self.Grid_GameObject == nil or CS.StaticUtility.IsNull(self.Grid_GameObject) then
        self.Grid_GameObject = self:Get("panel/ScrollView", "GameObject")
    end
    return self.Grid_GameObject
end
--endregion

--region 初始化
function UICommercePanel_Base:Init()
    self:BindButtonEvents()
end

function UICommercePanel_Base:BindButtonEvents()
    CS.UIEventListener.Get(self:GetCloseBtn_GameObject()).onClick = function()
        self:CloseBtnOnClick()
    end
    CS.UIEventListener.Get(self:GetJoinBtn_GameObject()).onClick = function(go)
        self:JoinBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetToStationBtn_GameObject()).onClick = function(go)
        self:ToStationBtnOnClick(go)
    end
    CS.UIEventListener.Get(self:GetRenew_GameObject()).onClick = function(go)
        self:RenewBtnOnClick(go)
    end
end
--endregion

--region 刷新
function UICommercePanel_Base:RefreshPanel(commonData)
    self:AnalysisData(commonData)
    self:HideOtherComponent()
    self:DefaultRefresh()
end

function UICommercePanel_Base:AnalysisData(commonData)
    self.kind = LuaEnumCardType.Coceral
    self.cardType = commonData.cardType
    self.curCardType = commonData.curCardType
    self.priceInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetCardPriceInfoByCardType(self.kind, self.curCardType)
    --月卡详细信息--包含月卡的续费次数等
    self.cardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetCardInfoByCardType(self.kind, self.curCardType)
    self.CommerceRightBtnList = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetCommerceRightBtnData(self.kind, self.curCardType)
    self.needRenewCard = false
    if self.cardInfo ~= nil then
        self.needRenewCard = CS.CSScene.MainPlayerInfo.MonthCardInfo:MonthCardNeedRenew(self.cardInfo.kind,self.cardInfo.cardType)
    end
    self.clickRenewBtn = commonData.clickRenewBtn
    if self.priceInfo ~= nil then
        local priceItemTableIsFind, priceItemTable = CS.Cfg_ItemsTableManager.Instance:TryGetValue(self.priceInfo.itemId)
        if priceItemTableIsFind then
            self.priceItemTable = priceItemTable
        end
    end
end

function UICommercePanel_Base:HideOtherComponent()
    self:RefreshActive(self:GetSlogan_GameObject(), false)
    self:RefreshActive(self:GetNowPrice_UILabel(), false)
    self:RefreshActive(self:GetBuyShowContent_GameObject(), false)
    self:RefreshActive(self:GetJoinBtn_GameObject(), false)
    self:RefreshActive(self:GetToStationBtn_GameObject(), false)
    self:RefreshActive(self:GetRenew_GameObject(), false)
    self:RefreshActive(self:GetEndTime_UILabel(), false)
    self:RefreshActive(self:GetRenewTime_UILabel(), false)
    self:RefreshActive(self:GetMustBuy_GameObject(), false)
    self:RefreshActive(self:GetGrid_GameObject(), false)
    self:RefreshActive(self:GetPrivilege_GameObject(), false)
    self:RefreshLabel(self:GetRenew_UILabel(), "续费")
end

---默认开启刷新
function UICommercePanel_Base:DefaultRefresh()
    if self.clickRenewBtn == true and self.cardInfo ~= nil and self.priceInfo ~= nil and self.needRenewCard == true  then
        self:RenewBtnOnClick()
        self:OnTransferClicked()
    end
end
--endregion

--region UI事件
---关闭按钮回调
function UICommercePanel_Base:CloseBtnOnClick()
    uimanager:ClosePanel("UICommercePanel")
end

---购买点击回调
function UICommercePanel_Base:JoinBtnOnClick(go)
    if (Utility.IsPushSpecialGift()) then
        uimanager:CreatePanel("UIRechargeGiftPanel")
        return
    end
    if self.priceInfo == nil or self.priceItemTable == nil then
        return
    end
    if self:ShowNoEnoughMoneyProp(go, false) then
        if Utility.IsDiamondItemId(self.priceInfo.itemId) then
            if gameMgr:GetPlayerDataMgr():GetRechargeInfo():IsFirstRecharge() == false then
                Utility.TryShowFirstRechargePanel(LuaEnumRechargePointEntranceType.CommercePanel);
            else
                Utility.JumpRechargePanel()
            end
        else
            uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.CommercePanelIngotNotEnough
            Utility.ShowItemGetWay(self.priceInfo.itemId, go, LuaEnumWayGetPanelArrowDirType.Left, CS.UnityEngine.Vector2(60, 0), nil, LuaEnumRechargePointType.CommercePanelIngotNotEnoughToRewardGift)
        end
        return
    end

    local customData = {}
    local commerceName = CS.Cfg_MonthCardTableManager.Instance:GetName(self.kind, self.curCardType)
    customData.ID = LuaEnumSecondConfirmType.CommerceCost
    customData.CenterCostID = self.priceInfo.itemId
    customData.CenterCostNum = self.priceInfo.price
    customData.CenterCallBack = function(go)
        networkRequest.ReqBuyMonthCard(self.curCardType)
        uimanager:ClosePanel("UIGuildAccusePromptPanel")
    end
    uimanager:CreatePanel("UIGuildAccusePromptPanel", function(panel)
        panel:GetConfirmBtn_UISprite().spriteName = "anniu10"
    end, customData, commerceName)

end

---前往驻地按钮回调
function UICommercePanel_Base:ToStationBtnOnClick(go)
    local derverId = 3002
    if self.cardType == LuaEnumCoceralCardType.BiqiMonthCard then
        derverId = 10003
    elseif self.cardType == LuaEnumCoceralCardType.MengZhongMonthCard then
        derverId = 10004
    elseif self.cardType == LuaEnumCoceralCardType.MengZhongMonthTasteCard then
        derverId = 10004
    end
    networkRequest.ReqDeliverByConfig(derverId, false)
    uimanager:ClosePanel("UICommercePanel")
end

---续费按钮回调--弹出UIGuildAccusePromptPanel提示购买
function UICommercePanel_Base:RenewBtnOnClick(go)

end

function UICommercePanel_Base:OnTransferClicked()

end
--endregion

--region UI控制
---控制显示
function UICommercePanel_Base:RefreshActive(obj, state)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        obj.gameObject:SetActive(state)
    end
end

---设置Sprite
function UICommercePanel_Base:RefreshSprite(obj, spriteName)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UISprite)) then
            obj.spriteName = spriteName
        else
            local curSprite = self:GetCurComp(obj, "", "UISprite")
            if curSprite ~= nil then
                curSprite.spriteName = spriteName
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置Label
function UICommercePanel_Base:RefreshLabel(obj, text)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UILabel)) then
            obj.text = text
        else
            local curLabel = self:GetCurComp(obj, "", "UILabel")
            if curLabel ~= nil then
                curLabel.text = text
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置UIGridContainer
function UICommercePanel_Base:RefreshUIGridContainer(obj, textList)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UIGridContainer)) then
            self:SetDescribe(obj, textList)
        else
            local curGridContainer = self:GetCurComp(obj, "", "UIGridContainer")
            if curGridContainer ~= nil then
                self:SetDescribe(obj, textList)
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

---设置UIGridContainer并校正位置
---@param obj UnityEngine.GameObject
---@param textList System.Array
function UICommercePanel_Base:RefreshUIGridContainerAndAdjust(obj, textList)
    if obj ~= nil and not CS.StaticUtility.IsNull(obj) then
        if CS.Utility_Lua.IsTypeEqual(obj:GetType() , typeof(CS.Top_UIGridContainer)) then
            self:SetDescribeAndAdjust(obj, textList)
        else
            local curGridContainer = self:GetCurComp(obj, "", "UIGridContainer")
            if curGridContainer ~= nil then
                self:SetDescribeAndAdjust(curGridContainer, textList)
            end
        end
        if obj.gameObject.activeSelf ~= true then
            self:RefreshActive(obj, true)
        end
    end
end

--region UIGridContainer
---设置UIGridContainer
function UICommercePanel_Base:SetDescribe(uiGridContainer, textList)
    if uiGridContainer == nil or textList == nil then
        return
    end
    uiGridContainer.MaxCount = textList.Count
    for i = 0, textList.Count - 1 do
        local describeText = textList[i]
        local desLabel = self:GetCurComp(uiGridContainer.controlList[i].transform, "", "UILabel")
        desLabel.text = string.format(string.gsub(describeText, "\\n", '\n'))
    end
end

---自适应UIGridContainer
---@param uiGridContainer UnityEngine.GameObject
---@param textList System.Array
function UICommercePanel_Base:SetDescribeAndAdjust(uiGridContainer, textList)
    if uiGridContainer == nil or textList == nil then
        return
    end
    uiGridContainer.CellHeight = uiGridContainer.CellHeight + self.describeInterval
    uiGridContainer.MaxCount = textList.Length
    for i = 0, textList.Length - 1 do
        local describeText = textList[i]
        --local desTransform = self:GetCurComp(uiGridContainer.controlList[i].transform, "", "GameObject")
        local desLabel = self:GetCurComp(uiGridContainer.controlList[i].transform, "desText", "UILabel")
        desLabel.text = describeText
        --if i + 1 < textList.Length then
        --    local nextDes_GameObject = self:GetCurComp(uiGridContainer.controlList[i + 1].transform, "", "GameObject")
        --    nextDes_GameObject.transform.localPosition = CS.UnityEngine.Vector3.down * (math.abs(desTransform.transform.localPosition.y) + desLabel.height)
        --end
    end
end
--endregion

--region 其他刷新
---刷新月卡时间文本
function UICommercePanel_Base:RefreshMonthCardTimeText()
    local monthCardTimeTextList = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetVipTimeTextList(self.kind, self.cardType)
    if monthCardTimeTextList ~= nil and monthCardTimeTextList.Count > 0 then
        self:RefreshLabel(self:GetEndTime_UILabel(), monthCardTimeTextList[0])
    end
    if monthCardTimeTextList ~= nil and monthCardTimeTextList.Count > 1 then
        self:RefreshLabel(self:GetRenewTime_UILabel(), monthCardTimeTextList[1])
    end
end

---重置按钮位置
function UICommercePanel_Base:ResetBtnPosition()
    local ToStationBtn_TweenPosition = self:GetCurComp(self:GetToStationBtn_GameObject().transform, "", "TweenPosition")
    local RenewBtn_TweenPosition = self:GetCurComp(self:GetRenew_GameObject().transform, "", "TweenPosition")
    if CS.CSScene.MainPlayerInfo.MonthCardInfo:MonthCardNeedRenew(self.kind, self.cardType) then
        ToStationBtn_TweenPosition:PlayForward()
        RenewBtn_TweenPosition:PlayForward()
    else
        ToStationBtn_TweenPosition:PlayReverse()
        RenewBtn_TweenPosition:PlayReverse()
    end
end

---刷新商会特权按钮
function UICommercePanel_Base:RefreshCommerceRightBtn()
    if self:GetGrid_UIGridContainer() ~= nil and CS.StaticUtility.IsNull(self:GetGrid_UIGridContainer()) == false and self.CommerceRightBtnList ~= nil then
        self:RefreshActive(self:GetGrid_GameObject(), true)
        self:GetGrid_UIGridContainer().MaxCount = self.CommerceRightBtnList.Count
        for k = 0, self:GetGrid_UIGridContainer().MaxCount - 1 do
            local grid = self:GetGrid_UIGridContainer().controlList[k]
            local data = self.CommerceRightBtnList[k]
            if CS.StaticUtility.IsNull(grid) == false and data ~= nil then
                local gridTemplate = templatemanager.GetNewTemplate(grid, luaComponentTemplates.UICommercePanel_RithBtn)
                gridTemplate:RefreshPanel({ CommerceRightBtnInfo = data, index = k, cardInfo = self.cardInfo })
            end
        end
    end
end

---添加刷新事件
function UICommercePanel_Base:AddUpdateList(action)
    self:RemoveUpdateList()
    self.UpdateRefresh = CS.CSListUpdateMgr.Add(20, nil, action, true)
end

---移除刷新事件
function UICommercePanel_Base:RemoveUpdateList()
    if self.UpdateRefresh ~= nil then
        CS.CSListUpdateMgr.Instance:Remove(self.UpdateRefresh)
        self.UpdateRefresh = nil
    end
end
--endregion
--endregion

--region 获取
---获取价格文本显示格式类型
function UICommercePanel_Base:GetPriceTextTypeByPriceType()
    if self.priceInfo == nil then
        return luaEnumMonthCardPriceTextType.BiQiNowPriceText
    end
    if self.cardType == LuaEnumCoceralCardType.None then
        if self.curCardType == LuaEnumCoceralCardType.BiqiMonthCard then
            return luaEnumMonthCardPriceTextType.BiQiNowPriceText
        elseif self.curCardType == LuaEnumCoceralCardType.MengZhongMonthCard then
            if self.priceInfo.priceType == LuaEnumMonthCardPriceType.Origin_Price then
                return luaEnumMonthCardPriceTextType.MengZhongNowPriceText, luaEnumMonthCardPriceTextType.None
            elseif self.priceInfo.priceType == LuaEnumMonthCardPriceType.OpenServer_Price then
                return luaEnumMonthCardPriceTextType.MengZhongPriceLimitTimePriceText, luaEnumMonthCardPriceTextType.MengZhongOriginPriceText
            elseif self.priceInfo.priceType == LuaEnumMonthCardPriceType.Renew_Price then
                return luaEnumMonthCardPriceTextType.MengZhongPriceLimitTimePriceText, luaEnumMonthCardPriceTextType.MengZhongOriginPriceText
            end
        end
    end
end
--endregion

--region 气泡相关
---显示货币不足气泡提示
function UICommercePanel_Base:ShowNoEnoughMoneyProp(go, showPop)
    local priceItemId = self.priceInfo.itemId
    local priceNeedNum = self.priceInfo.price
    local priceName = CS.Utility_Lua.GetNoColorItemName(priceItemId)
    if priceNeedNum > CS.CSScene.MainPlayerInfo.BagInfo:GetCoinNum(priceItemId) then
        if showPop == true then
            Utility.ShowPopoTips(go, CS.Cfg_PromptFrameTableManager.Instance:GetShowContent(LuaEnumPopoTipsType.CommerceNoEnoughMoney, priceName), LuaEnumPopoTipsType.FullBag)
        end
        return true
    end
    return false
end
--endregion

function UICommercePanel_Base:OnDestroy()
    self:RemoveUpdateList()
end
return UICommercePanel_Base