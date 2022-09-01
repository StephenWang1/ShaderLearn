local UINightCityItemTemplate = {}




function UINightCityItemTemplate:Init()
    ---@type Top_UISprite
    self.icon = self:Get("icon", "Top_UISprite")
    ---@type Top_UILabel
    self.count = self:Get("count", "Top_UILabel")
    ---@type Top_UILabel
    self.name = self:Get("name", "Top_UILabel")
    ---@type Top_UILabel
    self.strengthen = self:Get("strengthen", "Top_UILabel")

    self.data = nil
    CS.UIEventListener.Get(self.go).LuaEventTable = self
    CS.UIEventListener.Get(self.go).OnClickLuaDelegate = self.OnClickitem
end

---刷新UI
function UINightCityItemTemplate:RefreshUI(data)
    self.data = data
    if data ~= nil then
        local item
        local count
        if type(data) == 'number' then
            item = CS.Cfg_ItemsTableManager.Instance:GetItems(data)
            count = ""
        else
            item = CS.Cfg_ItemsTableManager.Instance:GetItems(data.list[0])
            count = data.list[1]
        end
        self.icon.spriteName = item.icon
        self.count.text = count
    end
end

---物品详细信息
function UINightCityItemTemplate:OnClickitem(go)
    if self.data == nil then
        print('data==Null')
        return
    end
    local item
    if type(self.data) == 'number' then
        item = CS.Cfg_ItemsTableManager.Instance:GetItems(self.data)
    else
        item = CS.Cfg_ItemsTableManager.Instance:GetItems(self.data.list[0])
    end
    uiStaticParameter.UIItemInfoManager:CreatePanel({itemInfo = item})
end

return UINightCityItemTemplate