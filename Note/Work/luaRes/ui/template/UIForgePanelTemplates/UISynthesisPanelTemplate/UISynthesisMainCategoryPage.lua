---@class UISynthesisMainCategoryPage
local UISynthesisMainCategoryPage = {};

UISynthesisMainCategoryPage.mBtnType = nil;

UISynthesisMainCategoryPage.mOwnerType = nil;

---@type LuaSynthesis_MainCategory
UISynthesisMainCategoryPage.MainCategoryData = nil;

--region Components

function UISynthesisMainCategoryPage:GetTgl_UIToggle()
    if(self.mTgl_UIToggle == nil) then
        self.mTgl_UIToggle = self:Get("","UIToggle");
    end
    return self.mTgl_UIToggle;
end

function UISynthesisMainCategoryPage:GetBtnLabel1_Text()
    if(self.mBtnLabel1_Text == nil) then
        self.mBtnLabel1_Text = self:Get("Background/label","UILabel");
    end
    return self.mBtnLabel1_Text;
end

function UISynthesisMainCategoryPage:GetBtnLabel2_Text()
    if(self.mBtnLabel2_Text == nil) then
        self.mBtnLabel2_Text = self:Get("checkmark/label","UILabel");
    end
    return self.mBtnLabel2_Text;
end

function UISynthesisMainCategoryPage:GetRedPointComponent()
    if(self.mRedPointComponent == nil) then
        self.mRedPointComponent = self:Get("redPoint","UIRedPoint");
    end
    return self.mRedPointComponent;
end

--endregion

--region Method

--region CallFunction

---@private
function UISynthesisMainCategoryPage:OnSelfClick()
    self:SwitchTglState(true);
    luaEventManager.DoCallback(LuaCEvent.Synthesis_CallOnSynthesisMainCategoryOnClick, {unit = self, type = self.MainCategoryData.Type})
end

--endregion

--region Public

---@param customData LuaSynthesis_MainCategory  第一级按钮
function UISynthesisMainCategoryPage:UpdateUnit(Synthesis_MainCategory, open)
    self.MainCategoryData = Synthesis_MainCategory
    self:UpdateUI();
    self:UpdateRedPoint();
    self:SwitchTglState(open)
end

function UISynthesisMainCategoryPage:UpdateUI()
    if(self.MainCategoryData ~= nil) then
        self:GetBtnLabel1_Text().text = self.MainCategoryData.Name;
        self:GetBtnLabel2_Text().text = self.MainCategoryData.Name;
    end
end

function UISynthesisMainCategoryPage:SwitchTglState(value)
    self:GetTgl_UIToggle().activeSprite.alpha = value and 1 or 0;
end

function UISynthesisMainCategoryPage:UpdateRedPoint()
    if(self:GetRedPointComponent() ~= nil) then
        self:GetRedPointComponent():RemoveRedPointKey();
    end
    local key = nil;
    ---@type LuaSynthesisMgr
    local SynthesisMgr = gameMgr:GetPlayerDataMgr():GetSynthesisMgr()

    key = self.MainCategoryData.RedKey

    if(key ~= nil) then
        self:AddRedPointKey(key);
    end
end

function UISynthesisMainCategoryPage:AddRedPointKey(key)
    if(self:GetRedPointComponent() ~= nil) then
        self:GetRedPointComponent():AddRedPointKey(key);
    end
end

--endregion

--region Private

function UISynthesisMainCategoryPage:InitEvents()
    CS.UIEventListener.Get(self:GetTgl_UIToggle().gameObject).onClick = function()
        self:OnSelfClick();
    end
end

--endregion

--endregion

function UISynthesisMainCategoryPage:Init(parentPageButtonUnit)
    self.mParentPageButtonUnit = parentPageButtonUnit;
    self:SwitchTglState(false);
    self:InitEvents();
end

return UISynthesisMainCategoryPage;