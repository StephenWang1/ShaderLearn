
---@class UIPotentialInvestTypeTemplate:TemplateBase
local UIPotentialInvestTypeTemplate = {}

function UIPotentialInvestTypeTemplate:Init()
    self.paramData = nil
    self:InitComponents()
    self:BindEvents()
end

---@private
function UIPotentialInvestTypeTemplate:InitComponents()
    ---@type UISprite
    self.bg = self:Get("di", "UISprite")

    ---@type UISprite
    self.choose = self:Get("choose", "UISprite")
end

function UIPotentialInvestTypeTemplate:BindEvents()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnInvestTypeClicked()
    end
end

function UIPotentialInvestTypeTemplate:OnInvestTypeClicked()
    if self.mClickCallBack ~= nil then
        self.mClickCallBack(self.go, self.paramData.index)
    end
end

---注册点击事件回调
---@param clickCallBack fun(go, typenum)
function UIPotentialInvestTypeTemplate:RegisterClickCallBack(clickCallBack)
    ---@type fun(go, typenum)
    self.mClickCallBack = clickCallBack
end

function UIPotentialInvestTypeTemplate:RefreshUI(data)
    self.paramData = data
    self.mIsSelected = data.isSelected
    self.choose.gameObject:SetActive(self.mIsSelected)
    self.bg.spriteName = string.format("PotentialInvest_%d", self.paramData.index)
end

---@return number
function UIPotentialInvestTypeTemplate:GetInvestType()
    return self.paramData.index
end

function UIPotentialInvestTypeTemplate:SetSelectedState(isSelected)
    self.mIsSelected = isSelected
    self.choose.gameObject:SetActive(self.mIsSelected)
end

return UIPotentialInvestTypeTemplate