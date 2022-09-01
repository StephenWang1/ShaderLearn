---邮件附件格子物品模板
local UIMailGridItem = {}

setmetatable(UIMailGridItem, luaComponentTemplates.UIItem)
function UIMailGridItem:Init()
    self:RunBaseFunction("Init")
end



return UIMailGridItem