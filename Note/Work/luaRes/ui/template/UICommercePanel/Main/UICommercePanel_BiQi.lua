---@class UICommercePanel_BiQi:UICommercePanel_Base 比奇商会模板
local UICommercePanel_BiQi = {}
setmetatable(UICommercePanel_BiQi, luaComponentTemplates.UICommercePanel_Base)

--region 组件
---@return UnityEngine.GameObject 转会按钮
function UICommercePanel_BiQi:GetTransferBtn()
    if self.mTransferBtn == nil then
        self.mTransferBtn = self:Get("events/btn_Transfer", "GameObject")
    end
    return self.mTransferBtn
end

function UICommercePanel_BiQi:GetTransferBtn_Text()
    if self.mTransferBtn_Text == nil then
        self.mTransferBtn_Text = self:Get("events/btn_Transfer/template/label", "UILabel")
    end
    return self.mTransferBtn_Text
end
--endregion

function UICommercePanel_BiQi:RefreshPanel(commonData)
    self:RunBaseFunction("RefreshPanel", commonData)
    self:DifferenceRefresh()
end

function UICommercePanel_BiQi:DifferenceRefresh()
    if self.cardType == LuaEnumCoceralCardType.None then
        self:RefreshNoCardPanel()
    elseif self.cardType == LuaEnumCoceralCardType.BiqiMonthCard then
        self:BiQiMonthCardPanel()
    end
    self:GetTransferBtn():SetActive(self.cardType == LuaEnumCoceralCardType.BiqiMonthCard)
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        self:GetDayTime_GameObject():SetActive(not CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedBiQiCommerce());
    else
        self:GetDayTime_GameObject():SetActive(false);
    end

    self:UpdateTransferLabel();
end

function UICommercePanel_BiQi:UpdateTransferLabel()
    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local day = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetRemainTimeDay(self.kind, self.cardType)
        local btnString = day > 3 and "升级商会" or "续费";
        self:GetTransferBtn_Text().text = btnString;
    end
end

---刷新无卡面板
function UICommercePanel_BiQi:RefreshNoCardPanel()
    if self.priceInfo == nil then
        return
    end
    self:RefreshActive(self:GetSlogan_GameObject(), true)
    self:RefreshActive(self:GetPrivilege_GameObject(), true)
    self:RefreshUIGridContainerAndAdjust(self:GetPrivilege_UIGridContainer(), CS.Cfg_DescriptionTableManager.Instance:GetDescribeArray(98))
    self:RefreshLabel(self:GetNowPrice_UILabel(), CS.Cfg_GlobalTableManager.Instance:GetPriceStr(self:GetPriceTextTypeByPriceType(), self.priceInfo.price))
    self:RefreshSprite(self:GetNowPrice_UISprite(), tostring(self.priceInfo.itemId))
    self:RefreshActive(self:GetJoinBtn_GameObject(), true)
end

---刷新比奇月卡面板
function UICommercePanel_BiQi:BiQiMonthCardPanel()
    self:RefreshActive(self:GetBuyShowContent_GameObject(), true)
    self:RefreshLabel(self:GetBuyShowContent_UILabel(), CS.CSScene.MainPlayerInfo.Name)
    --self:RefreshActive(self:GetToStationBtn_GameObject(), true)
    self:RefreshActive(self:GetGrid_GameObject(), true)
    self:RefreshCommerceRightBtn()
    --self:RefreshActive(self:GetRenew_GameObject(),CS.CSScene.MainPlayerInfo.MonthCardInfo:MonthCardNeedRenew(self.kind,self.cardType))
    self:RefreshActive(self:GetRenew_GameObject(), false)
    self:RefreshMonthCardTimeText()
    --self:RefreshLabel(self:GetRenew_UILabel(),"转会")
    self:ResetBtnPosition()
    self:UpdateTransferLabel();
end

function UICommercePanel_BiQi:BindButtonEvents()
    self:RunBaseFunction("BindButtonEvents")
    CS.UIEventListener.Get(self:GetTransferBtn()).onClick = function()
        self:OnTransferClicked()
    end
end

---点击转会
function UICommercePanel_BiQi:OnTransferClicked()
    --Utility.TransferShopChooseItem(14010001)

    if (CS.CSScene.MainPlayerInfo ~= nil) then
        local day = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetRemainTimeDay(self.kind, self.cardType)
        local priceInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetCardPriceInfoByCardType(self.kind, LuaEnumCoceralCardType.MengZhongMonthCard);
        local hasDiscount = false;
        if (priceInfo ~= nil) then
            if (priceInfo.priceType == 2) then
                hasDiscount = true;
            end
        end
        local customData = {};
        if (day > 3) then
            if (hasDiscount) then
                customData.id = 122;
            else
                customData.id = 123;
            end
        else
            if (hasDiscount) then
                customData.id = 124;
            else
                customData.id = 125;
            end
            customData.CancelCallBack = function()
                Utility.TransferShopChooseItem(14010003)
            end
        end

        local currentDay = self:GetMainPlayerInfo().ActualOpenDays
        local time = LuaGlobalTableDeal:GetMonthCardRebateTime()
        if time then
            if currentDay >= time then
                customData.id = 143
            else
                local res, data = CS.CSScene.MainPlayerInfo.MonthCardInfo.CardInfoDic:TryGetValue(LuaEnumCardType.Coceral)
                if res then
                    local res2, info = data:TryGetValue(self.kind)
                    if res2 then
                        if info.activeType == 2 then
                            customData.id = 143
                        end
                    end
                end
            end
        end

        customData.Callback = function()
            uimanager:CreatePanel("UICommercePanel", nil, { isShowBiQi = false });
        end
        Utility.ShowPromptTipsPanel(customData)
    end
end

---@return CSMainPlayerInfo
function UICommercePanel_BiQi:GetMainPlayerInfo()
    if self.mMainPlayerInfo == nil then
        self.mMainPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mMainPlayerInfo
end

return UICommercePanel_BiQi