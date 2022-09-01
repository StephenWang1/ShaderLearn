---@class UIServerSelfSellPanel_StallViewTemplate:UIAuctionPanel_StallPanel 跨服摆摊视图模板
local UIServerSelfSellPanel_StallViewTemplate = {}
setmetatable(UIServerSelfSellPanel_StallViewTemplate, luaComponentTemplates.UIAuctionPanel_StallPanel)

---@return UIServerSelfSellPanel_StallInfoTemplate
function UIServerSelfSellPanel_StallViewTemplate:GetStallInfoTemplate()
    if self.UIAuctionPanel_StallInfo == nil then
        self.UIAuctionPanel_StallInfo = templatemanager.GetNewTemplate(self:GetStall_Go(), luaComponentTemplates.UIServerSelfSellPanel_StallInfoTemplate, self)
    end
    return self.UIAuctionPanel_StallInfo
end


return UIServerSelfSellPanel_StallViewTemplate