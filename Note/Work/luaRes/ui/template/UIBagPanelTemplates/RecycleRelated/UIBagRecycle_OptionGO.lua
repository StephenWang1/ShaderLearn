---回收选项
---@class UIBagRecycleOptionGO:TemplateBase
local UIBagRecycle_OptionGO = {}

---选中框
---@private
---@return UISprite
function UIBagRecycle_OptionGO:GetCheckBoxUISprite()
    if self.mCheckBoxGO == nil then
        self.mCheckBoxGO = self:Get("check", "UISprite")
    end
    return self.mCheckBoxGO
end

---获取选项文本
---@private
---@return UILabel
function UIBagRecycle_OptionGO:GetOptionLabel()
    if self.mOptionLabel == nil then
        self.mOptionLabel = self:Get("", "UILabel")
    end
    return self.mOptionLabel
end

function UIBagRecycle_OptionGO:Init()
    CS.UIEventListener.Get(self.go).onClick = function()
        self:OnClicked()
    end
end

---绑定状态切换事件
---@param onClicked fun(boolean)
function UIBagRecycle_OptionGO:BindChangeEvent(onClicked)
    self.mOnClicked = onClicked
end

---重置选项状态
function UIBagRecycle_OptionGO:ResetOptionState()
    self.mIsChecked = nil
end

---变化状态
---@param isChecked boolean 是否被选中
function UIBagRecycle_OptionGO:ChangeState(isChecked)
    local state = self:GetState()
    if state == isChecked then
        return
    end
    self.mIsChecked = isChecked
    self:GetCheckBoxUISprite().enabled = isChecked
    if self.mOnClicked and self.mLock ~= true then
        self.mLock = true
        self.mOnClicked(self.mIsChecked == true)
        self.mLock = false
    end
end

---获取选中状态
---@return boolean 是否被选中
function UIBagRecycle_OptionGO:GetState()
    return self.mIsChecked
end

---设置选项文本
---@param content string
function UIBagRecycle_OptionGO:SetOptionLabel(content)
    self:GetOptionLabel().text = content
end

---点击事件
---@private
function UIBagRecycle_OptionGO:OnClicked()
    self:ChangeState(self:GetState() == false)
end

return UIBagRecycle_OptionGO