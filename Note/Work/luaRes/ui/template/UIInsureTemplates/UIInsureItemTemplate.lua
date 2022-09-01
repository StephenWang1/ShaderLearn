--- DateTime: 2021/05/08 16:37
--- Description 

---@class UIInsureItemTemplate:TemplateBase
local UIInsureItemTemplate = {}

---@type LuaInsureItem
UIInsureItemTemplate.LuaInvestmentItem = nil
--region parameters

--endregion

--region Init
function UIInsureItemTemplate:Init()
    ---
    ---@type UnityEngine.GameObject
    self.go_Selected = self:Get("checkmark", "GameObject")
    ---
    ---@type UnityEngine.GameObject
    self.go_redPoint = self:Get("redPoint", "GameObject")
    ---
    ---@type UIItem
    self.uiitem_UIItemTemplate = templatemanager.GetNewTemplate(self:Get("UIItemTemplate", "GameObject"), luaComponentTemplates.UIItem);
    ---
    ---@type Top_UILabel
    self.lb_name = self:Get("name", "Top_UILabel")
end
--endregion

--region public methods
---@param luaInsureItem LuaInsureItem
function UIInsureItemTemplate:Show(luaInsureItem)
    if (luaInsureItem == nil) then
        return
    end
    self.LuaInsureItem = luaInsureItem
    self:RefreshUI()
end

---@param value boolean
function UIInsureItemTemplate:SetSelectedEffect(value)
    luaclass.UIRefresh:RefreshActive(self.go_Selected, value)
end

---@param value boolean
function UIInsureItemTemplate:SetRedPoint(value)
    luaclass.UIRefresh:RefreshActive(self.go_redPoint, value)
end
--endregion

--region private methods

---@private
function UIInsureItemTemplate:RefreshUI()
    self:SetSelectedEffect(false)
    self:SetRedPoint(false)
    if (self.LuaInsureItem ~= nil and self.LuaInsureItem:GetCSTblItem() ~= nil) then
        if (self.uiitem_UIItemTemplate ~= nil) then
            self.uiitem_UIItemTemplate:RefreshUIWithItemInfo(self.LuaInsureItem:GetCSTblItem(), nil, nil, self.LuaInsureItem:GetBagItemInfo())
            self.uiitem_UIItemTemplate:RefreshOtherUI({ showItemInfo = self.LuaInsureItem:GetCSTblItem() })
        end
        luaclass.UIRefresh:RefreshLabel(self.lb_name, self.LuaInsureItem:GetTblItem():GetName())
    end
end
--endregion

return UIInsureItemTemplate