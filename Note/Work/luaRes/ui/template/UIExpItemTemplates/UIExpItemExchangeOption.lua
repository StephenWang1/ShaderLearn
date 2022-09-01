---经验丹兑换经验的选项
---@class UIExpItemExchangeOption:TemplateBase
local UIExpItemExchangeOption = {}

---@return UILabel
function UIExpItemExchangeOption:GetExchangeLabel()
    if self.mExchangeLabel == nil then
        self.mExchangeLabel = self:Get("lb_exchange", "UILabel")
    end
    return self.mExchangeLabel
end

---@return UILabel
function UIExpItemExchangeOption:GetDesLabel()
    if self.mDesLabel == nil then
        self.mDesLabel = self:Get("Des", "UILabel")
    end
    return self.mDesLabel
end

---@return UnityEngine.GameObject
function UIExpItemExchangeOption:GetButtonGo()
    if self.mButtonGo == nil then
        self.mButtonGo = self:Get("btn_get", "GameObject")
    end
    return self.mButtonGo
end

---@return UISprite
function UIExpItemExchangeOption:GetButtonSprite()
    if self.mBtnSprite == nil then
        self.mBtnSprite = self:Get("btn_get", "UISprite")
    end
    return self.mBtnSprite
end

---@return UISprite
function UIExpItemExchangeOption:GetExchangeCoinCostIconUISprite()
    if self.mExchangeCoinCostIconUISprite == nil then
        self.mExchangeCoinCostIconUISprite = self:Get("btn_get/icon", "UISprite")
    end
    return self.mExchangeCoinCostIconUISprite
end

---@return UILabel
function UIExpItemExchangeOption:GetExchangeCoinCostAmountLabel()
    if self.mExchangeCoinCostAmountLabel == nil then
        self.mExchangeCoinCostAmountLabel = self:Get("btn_get/Label", "UILabel")
    end
    return self.mExchangeCoinCostAmountLabel
end

---@param ownerPanel UIExpItemPanel
function UIExpItemExchangeOption:Init(ownerPanel)
    self.mOwnerPanel = ownerPanel
    CS.UIEventListener.Get(self:GetButtonGo()).onClick = function(go)
        self:OnExchangeButtonClicked(go)
    end
end

---@param clickcallback fun<info:ExpPropSingleUseInfo, go:UnityEngine.GameObject> 按钮点击回调
function UIExpItemExchangeOption:BindClickCallBack(clickcallback)
    self.clickcallback = clickcallback
end

---@param expPropSingleUseInfo ExpPropSingleUseInfo 刷新用的信息
---@param amount number 打算兑换的数量
function UIExpItemExchangeOption:InitializeData(expPropSingleUseInfo, amount, clickcallback)
    self.mExpPropSingleUseInfo = expPropSingleUseInfo
    self:RefreshUI(amount)
end

function UIExpItemExchangeOption:OnExchangeButtonClicked(go)
    if self.mExpPropSingleUseInfo == nil then
        return
    end
    if self.clickcallback ~= nil then
        self.clickcallback(self.mExpPropSingleUseInfo, go)
    end
end

---@param amount number 打算兑换的数量
function UIExpItemExchangeOption:RefreshUI(amount)
    local amountInOptionShow = amount
    if amountInOptionShow <= 0 then
        amountInOptionShow = 1
    end
    self:GetExchangeLabel().text = tostring(self.mExpPropSingleUseInfo.multiple) .. '倍兑换'
    self:GetDesLabel().text = "[00ff00]获得" .. self.mOwnerPanel:GetNumberChineseStr(self.mExpPropSingleUseInfo.gainExp * amountInOptionShow, true) .. "经验"
    local coincostcount = self.mExpPropSingleUseInfo.coincount * amountInOptionShow
    local coincostitemID = self.mExpPropSingleUseInfo.coinitemid
    if coincostcount == 0 or coincostitemID == 0 then
        self:GetExchangeCoinCostIconUISprite().spriteName = ""
        self:GetExchangeCoinCostAmountLabel().text = "[fff0c2]免费兑换"
        local pos = self:GetExchangeCoinCostAmountLabel().transform.localPosition
        pos.x = 0
        self:GetExchangeCoinCostAmountLabel().transform.localPosition = pos
        if amount == 0 then
            self:GetButtonSprite().spriteName = "anniu26"
        else
            self:GetButtonSprite().spriteName = "anniu11"
        end
    else
        local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(coincostitemID)
        self:GetExchangeCoinCostIconUISprite().spriteName = itemTbl:GetIcon()
        if coincostitemID == 1000001 then
            ---钻石的全显示
            self:GetExchangeCoinCostAmountLabel().text = "[fff0c2]" .. tostring(coincostcount)
        else
            self:GetExchangeCoinCostAmountLabel().text = "[fff0c2]" .. self.mOwnerPanel:GetNumberChineseStr(coincostcount, true)
        end
        local pos = self:GetExchangeCoinCostAmountLabel().transform.localPosition
        pos.x = 14
        self:GetExchangeCoinCostAmountLabel().transform.localPosition = pos
        local coinAmountInBag = gameMgr:GetPlayerDataMgr():GetMainPlayerBagMgr():GetCoinAmount(coincostitemID)
        if amount == 0 then
            self:GetButtonSprite().spriteName = "anniu26"
        else
            self:GetButtonSprite().spriteName = coinAmountInBag >= coincostcount and "anniu11" or "anniu26"
        end
    end
end

return UIExpItemExchangeOption