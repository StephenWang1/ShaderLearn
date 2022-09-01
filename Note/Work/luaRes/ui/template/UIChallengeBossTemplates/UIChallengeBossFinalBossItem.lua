---@class UIChallengeBossFinalBossItem:TemplateBase Boss界面终极Boss的物品
local UIChallengeBossFinalBossItem = {}

---物品ICON
function UIChallengeBossFinalBossItem:GetItemIcon_UISprite()
    if self.mItemIcon_UISprite == nil then
        self.mItemIcon_UISprite = self:Get("icon", "UISprite")
    end
    return self.mItemIcon_UISprite
end

---物品数量
function UIChallengeBossFinalBossItem:GetItemCount_UILabel()
    if self.mItemCount_UILabel == nil then
        self.mItemCount_UILabel = self:Get("count", "UILabel")
    end
    return self.mItemCount_UILabel
end

---使用物品信息刷新UI
---@param itemInfo TABLE.CFG_ITEMS 类型物品信息
---@param count XLua.Cast.Int32  默认为1
function UIChallengeBossFinalBossItem:RefreshUIWithItemInfo(itemInfo, count)
    if itemInfo ~= nil then
        --if count == nil or type(count) ~= "number" then
        --    count = 1
        --end
        --缓存物品信息
        self.ItemInfo = itemInfo
        --显示物品数量
        local showCountStr = ""
        if count >= 100000 then
            showCountStr = string.format("%.1f", tostring(count / 10000)) .. "万"
        else
            if count >= 2 then
                showCountStr = tostring(count)
            end
        end
        if self:GetItemCount_UILabel() ~= nil then
            self:GetItemCount_UILabel().gameObject:SetActive(true)
            self:GetItemCount_UILabel().text = showCountStr
        end
        --显示物品图标
        if self:GetItemIcon_UISprite() ~= nil and itemInfo ~= nil then
            self:GetItemIcon_UISprite().gameObject:SetActive(true)
            local spriteName = tostring(itemInfo.icon)
            local spriteColor = LuaEnumUnityColorType.Normal
            if LuaGlobalTableDeal.IsServantDefaultMagicEquip(itemInfo.id) then
                spriteColor = LuaEnumUnityColorType.Gray
            end
            luaclass.UIRefresh:RefreshSprite(self:GetItemIcon_UISprite(),spriteName,spriteColor)
        end
    end
end

return UIChallengeBossFinalBossItem