---邮件附件格子物品模板
local UIGridItem = {}

setmetatable(UIGridItem, luaComponentTemplates.UIItem)
function UIGridItem:Init()
    self:RunBaseFunction("Init")
end



return UIGridItem