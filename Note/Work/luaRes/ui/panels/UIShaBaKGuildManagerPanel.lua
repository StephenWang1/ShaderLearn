---@class UIShaBaKGuildManagerPanel
local UIShaBaKGuildManagerPanel = {};

---@type UIShaBaKGuildManagerPanel
local this = nil;

UIShaBaKGuildManagerPanel.mIsOpenBtnEffect = false;

---@return CSPlayerInfo 玩家信息
function UIShaBaKGuildManagerPanel:GetPlayerInfo()
    if self.mPlayerInfo == nil then
        self.mPlayerInfo = CS.CSScene.MainPlayerInfo
    end
    return self.mPlayerInfo
end

--region Components

function UIShaBaKGuildManagerPanel:GetBtnBtnShopDelivery_GameObject()
    if (this.mBtnShopDelivery_GameObject == nil) then
        this.mBtnShopDelivery_GameObject = this:GetCurComp("WidgetRoot/event/btnShopDelivery", "GameObject");
    end
    return this.mBtnShopDelivery_GameObject;
end

function UIShaBaKGuildManagerPanel:GetBtnGuildRank_GameObject()
    if (this.mBtnGuildRank_GameObject == nil) then
        this.mBtnGuildRank_GameObject = this:GetCurComp("WidgetRoot/event/btnGuildRank", "GameObject");
    end
    return this.mBtnGuildRank_GameObject;
end

function UIShaBaKGuildManagerPanel:GetBtnGuildRecommend_GameObject()
    if (this.mBtnGuildRecommend_GameObject == nil) then
        this.mBtnGuildRecommend_GameObject = this:GetCurComp("WidgetRoot/event/btnGuildRecommend", "GameObject");
    end
    return this.mBtnGuildRecommend_GameObject;
end

function UIShaBaKGuildManagerPanel:GetBtnClose_GameObject()
    if (this.mBtnClose_GameObject == nil) then
        this.mBtnClose_GameObject = this:GetCurComp("WidgetRoot/event/btn_close", "GameObject")
    end
    return this.mBtnClose_GameObject;
end

--endregion

--region Method

--region Public

function UIShaBaKGuildManagerPanel:UpdateUI()
    if (this.mSelectType ~= nil) then
        this:SelectWithType(this.mSelectType);
    end
end

function UIShaBaKGuildManagerPanel:SelectWithType(panelType)
    if (panelType == LuaEnumShaBaKGuildManagerPanelType.ShopDelivery) then
        uimanager:CreatePanel("UICityWarShopTeleportPanel", nil, { type = LuaEnumShaBaKShopDeliveryOpenType.GuildManager });
        uimanager:ClosePanel("UIShaBaKGuildManagerPanel");
    elseif (panelType == LuaEnumShaBaKGuildManagerPanelType.UnionRank) then
        uimanager:CreatePanel("UIGuildPanel", nil, { type = LuaEnumGuildPanelType.GuildList })
        uimanager:ClosePanel("UIShaBaKGuildManagerPanel");
    elseif (panelType == LuaEnumShaBaKGuildManagerPanelType.UnionRecRecommend) then
        uimanager:CreatePanel("UIUnionManagerPanel", nil, this.mIsOpenBtnEffect);
        uimanager:ClosePanel("UIShaBaKGuildManagerPanel");
    end
end

--endregion

--region Private

function UIShaBaKGuildManagerPanel:InitEvents()
    CS.UIEventListener.Get(this:GetBtnBtnShopDelivery_GameObject()).onClick = function()
        this:SelectWithType(LuaEnumShaBaKGuildManagerPanelType.ShopDelivery);
    end

    CS.UIEventListener.Get(this:GetBtnGuildRank_GameObject()).onClick = function()
        this:SelectWithType(LuaEnumShaBaKGuildManagerPanelType.UnionRank);
    end

    CS.UIEventListener.Get(this:GetBtnGuildRecommend_GameObject()).onClick = function(go)
        self:OnBtnGuildRecommendClicked(go)
    end

    CS.UIEventListener.Get(this:GetBtnClose_GameObject()).onClick = function()
        uimanager:ClosePanel("UIShaBaKGuildManagerPanel");
    end
end

function UIShaBaKGuildManagerPanel:RemoveEvents()

end

function UIShaBaKGuildManagerPanel:OnBtnGuildRecommendClicked(go)
    if self:GetPlayerInfo() then
        local level = self:GetPlayerInfo().Level
        local limitLevel = self:GetOpenUnionLimit()
        if level and limitLevel then
            if level < limitLevel then
                --等级不足
                local des = self:GetOpenPanelLevelNotEnoughDes()
                if des then
                    Utility.ShowPopoTips(go, des, 28)
                end
            else
                this:SelectWithType(LuaEnumShaBaKGuildManagerPanelType.UnionRecRecommend);
            end
        end

    end
end

---@return number 打开帮会等级限制
function UIShaBaKGuildManagerPanel:GetOpenUnionLimit()
    if self.mOpenUnionLimitLevel == nil then
        self.mOpenUnionLimitLevel = CS.Cfg_GlobalTableManager.Instance:OpenUnionLevel()
    end
    return self.mOpenUnionLimitLevel
end

---@return string  打开帮会等级不足提示
function UIShaBaKGuildManagerPanel:GetOpenPanelLevelNotEnoughDes()
    if self.mOpenGuildDes == nil then
        local res1, bubbleInfo = CS.Cfg_PromptFrameTableManager.Instance:TryGetValue(28)
        if res1 then
            self.mOpenGuildDes = string.format(bubbleInfo.content, self:GetOpenUnionLimit())
        end
    end
    return self.mOpenGuildDes
end

--endregion

--endregion

function UIShaBaKGuildManagerPanel:Init()
    this = self;
    this:InitEvents();
end

function UIShaBaKGuildManagerPanel:Show(customData)
    if (customData == nil) then
        customData = {};
    end
    if (customData.type ~= nil) then
        this.mSelectType = customData.type;
    end
    if (customData.isOpenBtnEffect == nil) then
        customData.isOpenBtnEffect = false;
    end
    this.mIsOpenBtnEffect = customData.isOpenBtnEffect;
    this:UpdateUI();
end

function ondestroy()
    this:RemoveEvents();
end

return UIShaBaKGuildManagerPanel;