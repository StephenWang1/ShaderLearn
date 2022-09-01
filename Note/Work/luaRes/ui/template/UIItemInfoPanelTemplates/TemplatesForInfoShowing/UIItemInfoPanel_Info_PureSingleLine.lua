---@class UIItemInfoPanel_Info_PureSingleLine:UIItemInfoPanel_Info_Basic
local UIItemInfoPanel_Info_PureSingleLine = {}

setmetatable(UIItemInfoPanel_Info_PureSingleLine, luaComponentTemplates.UIItemInfoPanel_Info_Basic)

--region 组件
function UIItemInfoPanel_Info_PureSingleLine:GetTextLabel_UILabel()
    if self.mTextLabel_UILabel == nil then
        self.mTextLabel_UILabel = self:Get("Text", "UILabel")
    end
    return self.mTextLabel_UILabel
end
--endregion

---此方法废弃
---@private
function UIItemInfoPanel_Info_PureSingleLine:RefreshWithInfo(bagItemInfo, itemInfo)
end

function UIItemInfoPanel_Info_PureSingleLine:RefreshText(textContent)
    if textContent == nil then
        textContent = ""
    end
    if self:GetTextLabel_UILabel() and CS.StaticUtility.IsNull(self:GetTextLabel_UILabel()) == false then
        self:GetTextLabel_UILabel().text = textContent
    end
end

return UIItemInfoPanel_Info_PureSingleLine