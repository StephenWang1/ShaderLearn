---@class UIActivityDuplicateRewardItemTemplate:TemplateBase
local UIActivityDuplicateRewardItemTemplate = {}

function UIActivityDuplicateRewardItemTemplate:Init()
    self:InitComponents()
    self:InitOther()
end
--通过工具生成 控件变量
function UIActivityDuplicateRewardItemTemplate:InitComponents()
    --图标
    self.mIcon_UISprite = self:Get("icon", "Top_UISprite")
    --数量
    self.mCount_UILabel = self:Get("count", "Top_UILabel")
    --名称
    self.mName_UILabel = self:Get("name", "Top_UILabel")


end
--初始化 变量 按钮点击 服务器消息事件等
function UIActivityDuplicateRewardItemTemplate:InitOther()
    --物品
    self.mItem = nil

    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickItem
end

---刷新UI
---@field  itemId 物品ID
---@field count 数量
function UIActivityDuplicateRewardItemTemplate:RefreshUI(itemId, count)
    if itemId then
        local isFind, item = CS.Cfg_ItemsTableManager.Instance:TryGetValue(itemId)
        if isFind then
            if self.mIcon_UISprite ~= nil then
                self.mIcon_UISprite.spriteName = item.icon
            end

            if self.mName_UILabel ~= nil then
                self.mName_UILabel.text = item.name
            end
            if count ~= nil and tonumber(count) > 1 then
                self.mCount_UILabel.text = tostring(count)
            else
                self.mCount_UILabel.text = ""
            end
            self.mItem = item
        end
    end
end

---点击物品
function UIActivityDuplicateRewardItemTemplate:OnClickItem()
    if self.mItem then
        uiStaticParameter.UIItemInfoManager:CreatePanel({ itemInfo = self.mItem, showRight = false })
    end
end

return UIActivityDuplicateRewardItemTemplate