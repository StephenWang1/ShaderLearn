---@type 物品信息界面信息
local UIItemInfoPanel_Info_StrengthenAttribute = {}

setmetatable(UIItemInfoPanel_Info_StrengthenAttribute, luaComponentTemplates.UIItemInfoPanel_Info_BaseAttribute)

function UIItemInfoPanel_Info_StrengthenAttribute:RefreshAttributes(bagItemInfo, itemInfo)
    if bagItemInfo and bagItemInfo.intensify then
        local res, attack = CS.Cfg_IntensifyTableManager.Instance:TryGetValue(bagItemInfo.intensify)
        if res then
            self.intensity = bagItemInfo.intensify
            self.attrNameStr = "[e8a657]攻 击:"
            self.attrValueStr = " +(" .. attack.attAdd .. "-" .. attack.attAdd .. ")"
        end
    end
end

function UIItemInfoPanel_Info_StrengthenAttribute:ClearAttributeData()
    self.intensity = 0
    self.attrNameStr = ""
    self.attrValueStr = ""
end

function UIItemInfoPanel_Info_StrengthenAttribute:ShowAttribute()
    self:GetTitleLabel_UILabel().text = ternary(self.intensity == 0, "", "[e8a657]强化 +" .. self.intensity)
    self:GetAttributeNameLabel_UILabel().text = self.attrNameStr
    self:GetAttributeValueLabel_UILabel().text = self.attrValueStr
end

return UIItemInfoPanel_Info_StrengthenAttribute
