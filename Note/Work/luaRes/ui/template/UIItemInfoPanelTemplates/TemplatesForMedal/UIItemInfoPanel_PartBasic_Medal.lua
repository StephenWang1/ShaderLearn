---@type 勋章信息界面子界面
---@class UIItemInfoPanel_PartBasic_Medal:UIItemInfoPanel_PartBasic
local UIItemInfoPanel_PartBasic_Medal = {}
setmetatable(UIItemInfoPanel_PartBasic_Medal, luaComponentTemplates.UIItemInfoPanel_PartBasic)

function UIItemInfoPanel_PartBasic_Medal:GetUIItemTemplate()
    if (self.mUIItem == nil) then
        self.mUIItem = self:CreateTemplateUnderArea(self:GetInfoTemplate_UIItem_GO(), luaComponentTemplates.UIItemInfoPanel_Info_Medal, self:GetUpperContentTable_UITable(),LuaEnumItemInfoModuleType.IconAndBaseMsg)
    end
    return self.mUIItem;
end

return UIItemInfoPanel_PartBasic_Medal

