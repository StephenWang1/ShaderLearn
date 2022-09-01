---经验兑换开销选项
---@class UIExpExchangeCostOption:TemplateBase
local UIExpExchangeCostOption = {}

---@return UILabel
function UIExpExchangeCostOption:GetExchangeLabel()
    if self.mExchangeLabel == nil then
        self.mExchangeLabel = self:Get("lb_exchange", "UILabel")
    end
    return self.mExchangeLabel
end

---@return UILabel
function UIExpExchangeCostOption:GetDescriptionLabel()
    if self.mDescriptionLabel == nil then
        self.mDescriptionLabel = self:Get("Des", "UILabel")
    end
    return self.mDescriptionLabel
end

---@return UnityEngine.GameObject
function UIExpExchangeCostOption:GetExchangeButtonGo()
    if self.mExchangeButtonGo == nil then
        self.mExchangeButtonGo = self:Get("btn_get", "GameObject")
    end
    return self.mExchangeButtonGo
end

---@return UISprite
function UIExpExchangeCostOption:GetBtnGetSprite()
    if self.mBtnGetSprite == nil then
        self.mBtnGetSprite = self:Get("btn_get", "UISprite")
    end
    return self.mBtnGetSprite
end

---兑换货币icon
---@return UISprite
function UIExpExchangeCostOption:GetExchangeCoinIconUISprite()
    if self.mExchangeIconUISprite == nil then
        self.mExchangeIconUISprite = self:Get("btn_get/icon", "UISprite")
    end
    return self.mExchangeIconUISprite
end

---兑换货币数量文本
---@return UILabel
function UIExpExchangeCostOption:GetExchangeCoinAmountUILabel()
    if self.mExchangeCoinAmountUILabel == nil then
        self.mExchangeCoinAmountUILabel = self:Get("btn_get/Label", "UILabel")
    end
    return self.mExchangeCoinAmountUILabel
end

---按钮上的特效物体
---@return UnityEngine.GameObject
function UIExpExchangeCostOption:GetEffectGo()
    if self.mEffectGo == nil then
        self.mEffectGo = self:Get("btn_get/Effect", "GameObject")
    end
    return self.mEffectGo
end

---@return ExpExchangeCost
function UIExpExchangeCostOption:GetCostData()
    return self.mCostData
end

---@return UIRoleExpExchangePanel
function UIExpExchangeCostOption:GetOwnerPanel()
    return self.mOwner
end

function UIExpExchangeCostOption:Init(owner)
    self.mOwner = owner
end

---@param expExchangeCost ExpExchangeCost
---@public
function UIExpExchangeCostOption:InitializeCostData(expExchangeCost)
    self.mCostData = expExchangeCost
    self:RefreshUI()
    if self.mButtonClickFunc == nil then
        self.mButtonClickFunc = function(go)
            self:OnButtonClicked(go)
        end
        CS.UIEventListener.Get(self:GetExchangeButtonGo()).onClick = self.mButtonClickFunc
    end
end

---仅刷新UI
---@public
function UIExpExchangeCostOption:RefreshUI()
    local minGain = 0
    for i = 1, #gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetExpExchangeCostList() do
        local cost = gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetExpExchangeCostList()[i]
        if minGain == 0 or minGain > cost.expGain.count then
            minGain = cost.expGain.count
        end
    end
    self:GetExchangeLabel().text = tostring(math.floor(self:GetCostData().expGain.count / minGain)) .. "倍兑换"
    self:GetDescriptionLabel().text = "[00ff00]获得" .. self:GetOwnerPanel():GetNumberChineseStr(self:GetCostData().expGain.count, true)
    local itemTbl = clientTableManager.cfg_itemsManager:TryGetValue(self:GetCostData().coinCost.itemID)
    if itemTbl then
        self:GetExchangeCoinIconUISprite().spriteName = itemTbl:GetIcon()
    else
        self:GetExchangeCoinIconUISprite().spriteName = ""
    end
    self:GetExchangeCoinAmountUILabel().text = "[fff0c2]" .. self:GetCostData().coinCost.count
    local isExpEnough = gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetCurrentRoleExpExchangeData().hasExp >= self:GetCostData().expGain.count
    if isExpEnough then
        self:GetBtnGetSprite().spriteName = "anniu11"
    else
        self:GetBtnGetSprite().spriteName = "anniu26"
    end
    local isExchangeAvailable = gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():IsExchangeAvailable(self:GetCostData().gearIndex)
    self:GetEffectGo():SetActive(isExchangeAvailable)
end

---@private
---@param go UnityEngine.GameObject
function UIExpExchangeCostOption:OnButtonClicked(go)
    local expGain = self:GetCostData().expGain.count
    local currentExp = gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():GetCurrentRoleExpExchangeData().hasExp
    if currentExp < expGain then
        local isFind, info = CS.Cfg_PromptWordTableManager.Instance:TryGetValue(161)
        if isFind then
            local isCanShow = Utility.ShowPromptTipsPanel({
                id = 161,
                Callback = function()
                    uiTransferManager:TransferToPanel(1001)
                end
            })
            if isCanShow then
                return
            end
        end
    end
    local res, error = gameMgr:GetPlayerDataMgr():GetMainPlayerExpExchange():TryRequestExchangeExp(self:GetCostData().gearIndex)
    if res == false then
        if error ~= nil then
            Utility.ShowPopoTips(go.transform, error, 209, "UIRoleExpExchangePanel")
        end
    end
end

return UIExpExchangeCostOption