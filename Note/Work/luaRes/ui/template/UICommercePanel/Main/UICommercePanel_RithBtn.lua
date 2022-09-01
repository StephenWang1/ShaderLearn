local UICommercePanel_RithBtn = {}
--region 初始化
function UICommercePanel_RithBtn:Init()
    self.InitSuccess = false
    self:InitComponent()
    self:BindEvents()
    self:InitParams()
end

function UICommercePanel_RithBtn:InitComponent()
    self.icon = self:Get("icon", "UISprite")
    self.name = self:Get("name", "UILabel")
    self.choose = self:Get("choose", "GameObject")
    self.Sign = self:Get("Sign", "UISprite")
    self.toggle = self:Get("", "UIToggle")
end

function UICommercePanel_RithBtn:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:TryOpenPanel()
    end
    CS.EventDelegate.Add(self.toggle.onChange, function()
        if self.curOpenPanel ~= nil and self.InitSuccess == true then
            uimanager:ClosePanel(self.curOpenPanel)
        end
    end)
end

function UICommercePanel_RithBtn:InitParams()
    if self.toggle ~= nil then
        self.toggle.group = 99
    end
end
--endregion

--region 刷新
function UICommercePanel_RithBtn:RefreshPanel(commonData)
    if self:AnalysisParams(commonData) == false then
        uimanager:ClosePanel("UICommercePanel")
    end
    self:RefreshCurPanel()
    self:InitOpenPanel()
    self.InitSuccess = true
end

---解析数据
function UICommercePanel_RithBtn:AnalysisParams(commonData)
    self.CommerceRightBtnInfo = commonData.CommerceRightBtnInfo
    self.index = commonData.index
    self.cardInfo = commonData.cardInfo
    if self.CommerceRightBtnInfo == nil or self.CommerceRightBtnInfo.CommerceRightType == LuaEnumCommerceRightType.NONE then
        return false
    end
    return true
end

function UICommercePanel_RithBtn:RefreshCurPanel()
    if CS.StaticUtility.IsNull(self.icon) == false then
        self.icon.spriteName = self.CommerceRightBtnInfo.BtnSpriteName
    end
    if CS.StaticUtility.IsNull(self.name) == false then
        self.name.text = self.CommerceRightBtnInfo.BtnName
    end
    if CS.StaticUtility.IsNull(self.Sign) == false then
        self.Sign.spriteName = self.CommerceRightBtnInfo.CornerSpriteName
        self.Sign.gameObject:SetActive(self.CommerceRightBtnInfo:NeedShowCorner())
    end
end

---初始打开面板
function UICommercePanel_RithBtn:InitOpenPanel()
    if self.initOpenPanel ~= true then
        self.initOpenPanel = true
        if uiStaticParameter.startActive == true then
            uiStaticParameter.startActive = false
            if self.cardInfo == nil then
                return
            end
            local defaultClickBtnType = luaclass.MonthCardTableData:GetCommerceCardDefaultClickBtnType(self.cardInfo.id)
            if defaultClickBtnType == 0 then
                return
            end
            if self.CommerceRightBtnInfo.CommerceRightType == defaultClickBtnType then
                self.toggle.startsActive = true
                self:TryOpenPanel()
            end
        end
    end
end

function UICommercePanel_RithBtn:TryOpenPanel()
    if self.CommerceRightBtnInfo ~= nil then
        if self.CommerceRightBtnInfo.CommerceRightType == LuaEnumCommerceRightType.IntegralStore then
            self.curOpenPanel = uimanager:CreatePanel(self.CommerceRightBtnInfo.OpenPanelName, nil, false, false, false, { type = LuaEnumStoreType.CommerceIntegral })
            return
        elseif self.CommerceRightBtnInfo.CommerceRightType == LuaEnumCommerceRightType.KingForbidden then
            self.curOpenPanel = uimanager:CreatePanel(self.CommerceRightBtnInfo.OpenPanelName, nil, 9301, 120, 83)
            return
        elseif self.CommerceRightBtnInfo.CommerceRightType == LuaEnumCommerceRightType.CommerceStore then
            self.curOpenPanel = uimanager:CreatePanel("UIShopPanel", nil, { type = LuaEnumStoreType.CommerceDiamond })
            return
        elseif self.CommerceRightBtnInfo.CommerceRightType == LuaEnumCommerceRightType.MoZhiBoss then
            ---打开魔之Boss面板
            self.curOpenPanel = uimanager:CreatePanel("UIBossPanel", nil, { type = LuaEnumBossType.DemonBoss })
            return
        elseif self.CommerceRightBtnInfo.CommerceRightType == LuaEnumCommerceRightType.CommerceShop then
            ---打开商会商城面板
              uiTransferManager:TransferToPanel(self.CommerceRightBtnInfo.OpenPanelName)
            return
        end
        self.curOpenPanel = uimanager:CreatePanel(self.CommerceRightBtnInfo.OpenPanelName)
    end
end
--endregion
return UICommercePanel_RithBtn