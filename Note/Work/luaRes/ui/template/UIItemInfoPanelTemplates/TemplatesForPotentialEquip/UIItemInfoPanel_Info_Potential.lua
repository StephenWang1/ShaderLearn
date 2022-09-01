---@class UIItemInfoPanel_Info_Potential:UIItemInfoPanel_Info_UIItem
local UIItemInfoPanel_Info_Potential = {}
setmetatable(UIItemInfoPanel_Info_Potential, luaComponentTemplates.UIItemInfoPanel_Info_UIItem)

---重写刷新重量
function UIItemInfoPanel_Info_Potential:RefreshWeight()
    self:GetWeight_UILabel().text = "潜能武器"
end


return UIItemInfoPanel_Info_Potential