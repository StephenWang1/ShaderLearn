local UICommercePanel = {}

UICommercePanel.mIsShowBiQi = true;

function UICommercePanel:GetTweenAlpha()
    if(self.mTweenAlpha == nil) then
        self.mTweenAlpha = self:GetCurComp("","TweenAlpha");
    end
    return self.mTweenAlpha;
end

--region 初始化
function UICommercePanel:Init()
    self:InitComponents()
    self:InitTemplates()
    self:GetPanelOffset()
    self:BindClientEvent()
    self:ClosePanel()
end

function UICommercePanel:InitComponents()
    self.mengzhong = self:GetCurComp("WidgetRoot/mengzhong", "GameObject")
    self.biqi = self:GetCurComp("WidgetRoot/biqi", "GameObject")
    self.mengzhongBg_Texture = self:GetCurComp("WidgetRoot/mengzhong/window/bg", "UITexture")
end

function UICommercePanel:InitTemplates()
    self.mengzhongTemplate = templatemanager.GetNewTemplate(self.mengzhong, luaComponentTemplates.UICommercePanel_MengZhong)
    self.biqiTemplate = templatemanager.GetNewTemplate(self.biqi, luaComponentTemplates.UICommercePanel_BiQi)
end

function UICommercePanel:BindClientEvent()
    self:GetClientEventHandler():AddEvent(CS.CEvent.V2_BuyMonthCardInfoRefresh, function(id, kind)
        if not CS.StaticUtility.IsNull(self.mengzhong) then
            self:RefreshPanel(id, kind)
        end
    end)
end

function UICommercePanel:ReqParams()
    networkRequest.ReqMonthCardPanel(LuaEnumCardType.Coceral)
end

function UICommercePanel:ClosePanel()
    local isJoinCommerce = CS.CSScene.MainPlayerInfo.MonthCardInfo:IsJoinedCommerce()
    if isJoinCommerce == false then
        uimanager:ClosePanel("UICommerceAdministratorPanel")
        uimanager:ClosePanel("UIMrTarotPanel")
        uimanager:ClosePanel("UICommerceShopPanel")
        uimanager:ClosePanel("UIActivityDuplicatePanel")
    end
end
--endregion

--region 刷新
---刷新面板
function UICommercePanel:RefreshPanel(id, kind)
    uiStaticParameter.RechargePointPanelType = LuaEnumRechargePointEntranceType.CommercePanel

    if kind == LuaEnumCardType.Coceral then
        self.cardInfo = CS.CSScene.MainPlayerInfo.MonthCardInfo:GetJoinMonthCardInfo(kind)
        self:AnalysisCardType(self.cardInfo)
        --self:AdjustPanel()
        self:ControlShow()
        self:RefreshPanelByCardType()
    else
        print("服务器未发月卡价格数据")
        uimanager:ClosePanel(self)
    end
end

---解析月卡类型
function UICommercePanel:AnalysisCardType(cardInfo)
    if cardInfo == nil or cardInfo.cardType == nil then
        self.cardType = LuaEnumCoceralCardType.None
    else
        self.cardType = cardInfo.cardType
    end
end

---通过月卡类型刷新面板
function UICommercePanel:RefreshPanelByCardType()
    if (self.cardType == LuaEnumCoceralCardType.None and CS.CSScene.MainPlayerInfo.MonthCardInfo.serverDayLimitCondition == false)
            or self.cardType == LuaEnumCoceralCardType.BiqiMonthCard then
        if(not self.mIsShowBiQi) then
            self.mengzhongTemplate:RefreshPanel({ cardType = LuaEnumCoceralCardType.None, curCardType = LuaEnumCoceralCardType.MengZhongMonthCard,clickRenewBtn = self.clickRenewBtn })
        else
            self.biqiTemplate:RefreshPanel({ cardType = self.cardType, curCardType = LuaEnumCoceralCardType.BiqiMonthCard,clickRenewBtn = self.clickRenewBtn })
        end
    end
    if self.cardType == LuaEnumCoceralCardType.None or self.cardType == LuaEnumCoceralCardType.MengZhongMonthCard
            or self.cardType == LuaEnumCoceralCardType.MengZhongMonthTasteCard  then
        local cardType = LuaEnumCoceralCardType.MengZhongMonthCard
        if self.cardType == LuaEnumCoceralCardType.MengZhongMonthTasteCard then
            cardType = LuaEnumCoceralCardType.MengZhongMonthTasteCard
        end

        self.mengzhongTemplate:RefreshPanel({ cardType = self.cardType, curCardType = cardType,clickRenewBtn = self.clickRenewBtn})
    end
end
--endregion

--region 矫正面板和显示控制
---矫正面板
function UICommercePanel:AdjustPanel()
    local panelOffset = 0
    if self.cardType == LuaEnumCoceralCardType.None and CS.CSScene.MainPlayerInfo.MonthCardInfo.serverDayLimitCondition == false then
        panelOffset = self.panelOffset
    end
    if self.mengzhong == nil or CS.StaticUtility.IsNull(self.mengzhong) then
        return
    end
    self.mengzhong.transform.localPosition = CS.UnityEngine.Vector3.left * panelOffset
    self.biqi.transform.localPosition = CS.UnityEngine.Vector3.right * panelOffset
end

---控制显示
function UICommercePanel:ControlShow()
    local biQiIsShow = self.mIsShowBiQi and ((self.cardType == LuaEnumCoceralCardType.None and CS.CSScene.MainPlayerInfo.MonthCardInfo.serverDayLimitCondition == false) or self.cardType == LuaEnumCoceralCardType.BiqiMonthCard)
    local mengZhongIsShow = not self.mIsShowBiQi or (self.cardType == LuaEnumCoceralCardType.None or self.cardType == LuaEnumCoceralCardType.MengZhongMonthCard or self.cardType == LuaEnumCoceralCardType.MengZhongMonthTasteCard)
    if self.mengzhong == nil or CS.StaticUtility.IsNull(self.mengzhong) then
        return
    end
    self.biqi:SetActive(biQiIsShow)
    self.mengzhong:SetActive(mengZhongIsShow)
end
--endregion

--region 获取数据
---获取面板偏移量（默认值217）
function UICommercePanel:GetPanelOffset()
    local panelOffset = 217
    if self.mengzhongBg_Texture ~= nil then
        panelOffset = self.mengzhongBg_Texture.localSize.x * 0.5
    end
    self.panelOffset = panelOffset
end
--endregion

function UICommercePanel:Show(customData)
    if(customData == nil) then
        customData = {};
    end

    if(customData.isShowBiQi ~= nil) then
        self.mIsShowBiQi = customData.isShowBiQi;
    end
    if customData.clickRenewBtn ~= nil then
        self.clickRenewBtn = customData.clickRenewBtn
    end
    self:GetTweenAlpha():PlayTween();
    self:ReqParams()
end

return UICommercePanel