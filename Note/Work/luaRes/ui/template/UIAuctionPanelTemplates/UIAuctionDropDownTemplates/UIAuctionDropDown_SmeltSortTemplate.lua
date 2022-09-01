---@class UIAuctionDropDown_SmeltSortTemplate:UIAuctionDropDownTemplateBase 熔炼下拉框
local UIAuctionDropDown_SmeltSortTemplate = {}

setmetatable(UIAuctionDropDown_SmeltSortTemplate, luaComponentTemplates.UIAuctionDropDownTemplateBase)

---@return string
function UIAuctionDropDown_SmeltSortTemplate:GetIdText(id)
    ---@type UIAuctionMenuPanelTemplateBase
    local rootPanel = self.mRootPanel
    if rootPanel then
        local info = rootPanel:CacheTradeTypeTableInfo(id)
        if info then
            return info.name
        end
        return ""
    end
end

return UIAuctionDropDown_SmeltSortTemplate