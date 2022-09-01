---帮会仓库背包格子模板
---@class UIGuildBagPanel_BagGridTemplate:UIBagTypeGrid
local UIGuildBagPanel_BagGridTemplate = {}

setmetatable(UIGuildBagPanel_BagGridTemplate, luaComponentTemplates.UIBagType_Grid)

function UIGuildBagPanel_BagGridTemplate:RefreshSingleGrid(bagItemInfo, itemTbl)
    ---刷新icon
    self:SetCompSpriteName(self.Components.Icon, itemTbl.icon)
    self:SetCompLabelContent(self.Components.Count, (bagItemInfo.count > 1) and tostring(bagItemInfo.count) or nil)
end

return UIGuildBagPanel_BagGridTemplate