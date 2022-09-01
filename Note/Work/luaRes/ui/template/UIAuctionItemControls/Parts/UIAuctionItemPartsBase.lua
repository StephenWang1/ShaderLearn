---拍卖物品各部分基类
---@class UIAuctionItemPartsBase:TemplateBase
local UIAuctionItemPartsBase = {}

---部位类型
---@return LuaEnumAuctionItemPartType
function UIAuctionItemPartsBase:GetPartType()
    return self.mPartType or LuaEnumAuctionItemPartType.None
end

---设置部位类型
---@private
---@param partType LuaEnumAuctionItemPartType
function UIAuctionItemPartsBase:SetPartType(partType)
    self.mPartType = partType or LuaEnumAuctionItemPartType.None
end

---重置
function UIAuctionItemPartsBase:ResetAll()

end

return UIAuctionItemPartsBase