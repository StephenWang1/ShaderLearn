local UIGMPanel_Component_CItem = {}

function UIGMPanel_Component_CItem:InitComponents()
    self.sign = self:Get("Active/sign", "GameObject")
    self.headline=self:Get("headline", "Top_UILabel")

end
function UIGMPanel_Component_CItem:InitOther()
    self.Component=nil
    self.IsOpen=false
end

function UIGMPanel_Component_CItem:Init()
    self:InitComponents()
    self:InitOther()
end

function UIGMPanel_Component_CItem:RefreshUI(item)
    self.Component=item
    self.headline=item.gameObject.name
    self.IsOpen=item.enabled
end

return UIGMPanel_Component_CItem