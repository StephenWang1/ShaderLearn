local UICommercePanel_MengZhong = {}
setmetatable(UICommercePanel_MengZhong,luaComponentTemplates.UICommercePanel_Base)

function UICommercePanel_MengZhong:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel",commonData)
    self:DifferenceRefresh()
end

function UICommercePanel_MengZhong:DifferenceRefresh()
    if self.cardType == LuaEnumCoceralCardType.None then
        self:RefreshNoCardPanel()
    elseif self.cardType == LuaEnumCoceralCardType.MengZhongMonthCard then
        self:MengZhongCardPanel()
    elseif self.cardType == LuaEnumCoceralCardType.MengZhongMonthTasteCard then
        self:MengZhongTasteCardPanel()
    end

    if(CS.CSScene.MainPlayerInfo ~= nil) then
        self:GetDayTime_GameObject():SetActive(not CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedMengZhongCommerce());
    else
        self:GetDayTime_GameObject():SetActive(false);
    end
end

---刷新无卡面板
function UICommercePanel_MengZhong:RefreshNoCardPanel()
    if self.priceInfo == nil then
        return
    end
    local nowPriceTextType,LimitTimePriceTextType = self:GetPriceTextTypeByPriceType()
    self:RefreshActive(self:GetSlogan_GameObject(),true)
    --self:RefreshActive(self:GetCloseBtn_GameObject(),CS.CSScene.MainPlayerInfo.MonthCardInfo.serverDayLimitCondition)

    local commercePanel = uimanager:GetPanel("UICommercePanel");
    if(commercePanel ~= nil) then
        self:RefreshActive(self:GetCloseBtn_GameObject(), not commercePanel.biqi.activeSelf);
    else
        self:RefreshActive(self:GetCloseBtn_GameObject(), true);
    end

    self:RefreshActive(self:GetPrivilege_GameObject(), true)
    self:RefreshUIGridContainerAndAdjust(self:GetPrivilege_UIGridContainer(),CS.Cfg_DescriptionTableManager.Instance:GetDescribeArray(97))
    self:RefreshSprite(self:GetNowPrice_UISprite(),tostring(self.priceInfo.itemId))
    self:RefreshSprite(self:GetNowPrice2_UISprite(),tostring(self.priceInfo.itemId))
    self:RefreshSprite(self:GetOriginPrice_UISprite(),tostring(self.priceInfo.itemId))
    self:RefreshActive(self:GetNowPrice_UILabel(),true)
    self:RefreshLabel(self:GetNowPrice_UILabel(),CS.Cfg_GlobalTableManager.Instance:GetPriceStr(nowPriceTextType,self.priceInfo.price,0))
    self:RefreshLabel(self:GetOriginPrice_UILabel(),CS.Cfg_GlobalTableManager.Instance:GetPriceStr(LimitTimePriceTextType,self.priceInfo.orignalPrice,0))
    self:RefreshActive(self:GetOriginPrice_UILabel(),self.priceInfo.priceType == LuaEnumMonthCardPriceType.OpenServer_Price)
    self:RefreshActive(self:GetJoinBtn_GameObject(),true)
    self:RefreshActive(self:GetMustBuy_GameObject(),CS.CSScene.MainPlayerInfo.MonthCardInfo.serverDayLimitCondition == false)
    self:RefreshActive(self:GetNowPrice_UISprite(),nowPriceTextType ~= luaEnumMonthCardPriceTextType.MengZhongPriceLimitTimePriceText)
    self:RefreshActive(self:GetNowPrice2_UISprite(),nowPriceTextType == luaEnumMonthCardPriceTextType.MengZhongPriceLimitTimePriceText)
end

---刷新盟重月卡面板
function UICommercePanel_MengZhong:MengZhongCardPanel()
    self:RefreshActive(self:GetBuyShowContent_GameObject(),true)
    self:RefreshActive(self:GetCloseBtn_GameObject(),true)
    self:RefreshLabel(self:GetBuyShowContent_UILabel(),CS.CSScene.MainPlayerInfo.Name)
    self:RefreshActive(self:GetGrid_GameObject(), true)
    self:RefreshCommerceRightBtn()
    --self:RefreshActive(self:GetToStationBtn_GameObject(),true)
    --self:RefreshActive(self:GetRenew_GameObject(),CS.CSScene.MainPlayerInfo.MonthCardInfo:MonthCardNeedRenew(self.kind,self.cardType))
    self:RefreshActive(self:GetRenew_GameObject(),true)
    self:RefreshMonthCardTimeText()
    self:RefreshLabel(self:GetRenew_UILabel(),"续费")
    self:ResetBtnPosition()
    self:RefreshActive(self:GetOriginPrice_UILabel(),false)
end

---刷新盟重体验卡面板
function UICommercePanel_MengZhong:MengZhongTasteCardPanel()
    self:RefreshActive(self:GetBuyShowContent_GameObject(),true)
    self:RefreshActive(self:GetCloseBtn_GameObject(),true)
    self:RefreshLabel(self:GetBuyShowContent_UILabel(),CS.CSScene.MainPlayerInfo.Name)
    self:RefreshActive(self:GetGrid_GameObject(), true)
    self:RefreshCommerceRightBtn()
    --self:RefreshActive(self:GetToStationBtn_GameObject(),true)
    --self:RefreshActive(self:GetRenew_GameObject(),CS.CSScene.MainPlayerInfo.MonthCardInfo:MonthCardNeedRenew(self.kind,self.cardType))
    self:RefreshActive(self:GetRenew_GameObject(),true)
    self:RefreshLabel(self:GetRenew_UILabel(),"入会")
    self:ResetBtnPosition()
    self:RefreshActive(self:GetOriginPrice_UILabel(),false)
    self:AddUpdateList(function()
        local remainTime = 0
        if self.cardInfo ~= nil and self.cardInfo.endTime ~= nil then
            remainTime = self.cardInfo.endTime - CS.CSScene.MainPlayerInfo.serverTime
        end
        if remainTime < 0 then
            remainTime = 0
        end
        local showContent = ""
        if remainTime > 0 then
            local minute,second = Utility.MillisecondToMinuteTime(remainTime)
            showContent = string.format("%02d分%02d秒",minute,second)
        end
        self:RefreshLabel(self:GetEndTime_UILabel(), showContent)
    end)
end

function UICommercePanel_MengZhong:RenewBtnOnClick(go)
    if self.priceInfo == nil or self.priceItemTable == nil then
        return
    end
    if self.cardInfo ~= nil and self.cardInfo.id == LuaEnumCoceralCardType.MengZhongMonthTasteCard then
        ---盟重体验卡
        Utility.TransferShopChooseItem(14010001)
    elseif self.cardInfo ~= nil and self.cardInfo.id == LuaEnumCoceralCardType.MengZhongMonthCard then
        ---盟重月卡
        local isFind, showInfo = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(LuaEnumSecondConfirmType.CommerceRenew)
        local isFind2, showInfo2 = CS.Cfg_PromptWordTableManager.Instance.dic:TryGetValue(99)

        if isFind and isFind2 then
            local data = {
                Title = showInfo.title == nil and '' or showInfo.title,
                Content = string.format(showInfo.des, self.cardInfo.renewNum + 1),
                SubContent = string.format(showInfo2.des, tostring( self.priceInfo.orignalPrice).."钻石", tostring( self.priceInfo.price).."钻石"),
                CenterDescription = showInfo.leftButton,
                ID = LuaEnumSecondConfirmType.CommerceRenew,
                CallBack = function(panel)
                    panel.mIsClose = self:ShowNoEnoughMoneyProp(nil,false) == false;
                    --如果钱不够购买,那么弹出提示框
                    if self:ShowNoEnoughMoneyProp(panel.GetCenterButton_GameObject(),true) then
                        return
                    end
                    --请求服务器消耗资源购买
                    networkRequest.ReqBuyMonthCard(self.curCardType)
                end
            }
            uimanager:CreatePanel("UIPromptPanel", nil, data)
        end
    end
end
return UICommercePanel_MengZhong