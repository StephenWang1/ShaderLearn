---@class UICommonBookMarkTemplate:TemplateBase 通用页签模板
local UICommonBookMarkTemplate = {}

---@return UILabel 背景文本
---@protected
function UICommonBookMarkTemplate:GetBg_Lb()
    if self.mBgLb == nil then
        self.mBgLb = self:Get("background/Label", "UILabel")
    end
    return self.mBgLb
end

---@return UILabel 选中文本
---@protected
function UICommonBookMarkTemplate:GetCheckMark_Lb()
    if self.mCheckMarkLb == nil then
        self.mCheckMarkLb = self:Get("checkmark/Label", "UILabel")
    end
    return self.mCheckMarkLb
end

---@return UIToggle 自身Toggle
---@protected
function UICommonBookMarkTemplate:GetChooseToggle()
    if self.mToggle == nil then
        self.mToggle = self:Get("", "UIToggle")
    end
    return self.mToggle
end

function UICommonBookMarkTemplate:Init()
end

---设置文本
---@param lbInfo string 页签内容
---@public
function UICommonBookMarkTemplate:SetLbInfo(lbInfo)
    if CS.StaticUtility.IsNull(self:GetBg_Lb()) == false then
        self:GetBg_Lb().text = lbInfo
    end
    if CS.StaticUtility.IsNull(self:GetCheckMark_Lb()) == false then
        self:GetCheckMark_Lb().text = lbInfo
    end
end

---设置选中
---@param isChoose boolean 是否选中
---@public
function UICommonBookMarkTemplate:ChooseItem(isChoose)
    if CS.StaticUtility.IsNull(self:GetChooseToggle()) == false then
        self:GetChooseToggle():Set(isChoose)
    end
end

return UICommonBookMarkTemplate